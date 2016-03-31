//
//  YouTubeGetVideoInfoAPIParser.swift
//  YouTubeGetVideoInfoAPIParser
//
//  Created by sonson on 2016/03/31.
//  Copyright © 2016年 sonson. All rights reserved.
//

import Foundation

/**
 Parse query style string returned from https://www.youtube.com/get_video_info?video_id=
 - parameter str: String to be parsed.
 - returns: Dictionary object as [String:String]
 */
func str2dict(str: String) -> [String:String] {
    return str.componentsSeparatedByString("&").reduce([:] as [String:String], combine: {
        var d = $0
        let components = $1.componentsSeparatedByString("=")
        if components.count == 2 {
            if let key = components[0].stringByRemovingPercentEncoding, value = components[1].stringByRemovingPercentEncoding {
                d[key] = value
            }
        }
        return d
    })
}

/**
 Enum for video quality.
 This is comparable
 */
public enum StreamingQuality : Comparable {
    case Small
    case Medium
    case Large
    case Hd720
    case Other
    
    init(_ value: String) {
        switch value {
        case "small":
            self = .Small
        case "medium":
            self = .Medium
        case "large":
            self = .Large
        case "hd720":
            self = .Hd720
        default:
            self = .Other
        }
    }
    
    var level: Int {
        get {
            switch self {
            case .Small:
                return 1
            case .Medium:
                return 2
            case .Large:
                return 3
            case .Hd720:
                return 4
            default:
                return 5
            }
        }
    }
}

public func ==(x: StreamingQuality, y: StreamingQuality) -> Bool { return x.level == y.level }
public func <(x: StreamingQuality, y: StreamingQuality) -> Bool { return x.level < y.level }

/**
 Streaming format
 */
public struct FormatStreamMap {
    public let type: String
    public let itag: String
    public let quality: StreamingQuality
    public let fallbackHost: String
    public let url: NSURL
    public let s: String
    
    public init?(_ dict: [String:String]) {
        guard let type = dict["type"] else { return nil }
        guard let urlString = dict["url"] else { return nil }
        guard let url = NSURL(string: urlString) else { return nil }
        guard let quality = dict["quality"] else { return nil }
        
        self.type = type
        self.url = url
        self.quality = StreamingQuality(quality)
        self.itag = dict["itag"] ?? ""
        self.s = dict["s"] ?? ""
        self.fallbackHost = dict["fallback_host"] ?? ""
    }
}

/**
 Streaming information
 */
public struct YouTubeStreaming {
    /// csi_page_type
    public let csiPageType: String
    /// enabled_engage_types
    public let enabledEngageTypes: String
    /// tag_for_child_directed
    public let tagForChildDirected: Bool
    /// enablecsi
    public let enablecsi: Int
    /// caption_tracks
    public let captionTracks: String
    /// ptk
    public let ptk: String
    /// account_playback_token
    public let accountPlaybackToken: String
    /// ad_device
    public let adDevice: Int
    /// c
    public let c: String
    /// video_verticals
    public let videoVerticals: String
    /// iurlmq
    public let iurlmq: String
    /// cc_asr
    public let ccAsr: Int
    /// ptchn
    public let ptchn: String
    /// iv_invideo_url
    public let ivInvideoUrl: String
    /// status
    public let status: String
    /// as_launched_in_country
    public let asLaunchedInCountry: Int
    /// allow_html5_ads
    public let allowHtml5Ads: Int
    /// cc3_module
    public let cc3Module: Int
    /// ad_module
    public let adModule: String
    /// timestamp
    public let timestamp: Float
    /// adsense_video_doc_id
    public let adsenseVideoDocId: String
    /// oid
    public let oid: String
    /// ypc_ad_indicator
    public let ypcAdIndicator: Float
    /// keywords
    public let keywords: [String]
    /// avg_rating
    public let avgRating: Float
    /// mpvid
    public let mpvid: String
    /// default_audio_track_index
    public let defaultAudioTrackIndex: Int
    /// pltype
    public let pltype: String
    /// length_seconds
    public let lengthSeconds: Int
    /// watermark
    public let watermark: [String]
    /// ucid
    public let ucid: String
    /// afv_ad_tag
    public let afvAdTag: String
    /// of
    public let of: String
    /// cver
    public let cver: Float
    /// ad_flags
    public let adFlags: Int
    /// allow_ratings
    public let allowRatings: Int
    /// allow_embed
    public let allowEmbed: Int
    /// show_content_thumbnail
    public let showContentThumbnail: Bool
    /// gut_tag
    public let gutTag: String
    /// fexp
    public let fexp: String
    /// midroll_prefetch_size
    public let midrollPrefetchSize: Int
    /// shortform
    public let shortform: Bool
    /// dbp
    public let dbp: String
    /// probe_url
    public let probeUrl: String
    /// sffb
    public let sffb: Bool
    /// cc_font
    public let ccFont: String
    /// allowed_ads
    public let allowedAds: String
    /// tmi
    public let tmi: Int
    /// storyboard_spec
    public let storyboardSpec: String
    /// fade_in_duration_milliseconds
    public let fadeInDurationMilliseconds: Int
    /// idpj
    public let idpj: Int
    /// is_listed
    public let isListed: Int
    /// fmt_list
    public let fmtList: String
    /// iv_module
    public let ivModule: String
    /// iurlmaxres
    public let iurlmaxres: String
    /// adaptive_fmts---------------------
    public let adaptiveFmts: String
    /// author
    public let author: String
    /// apply_fade_on_midrolls
    public let applyFadeOnMidrolls: Bool
    /// has_cc
    public let hasCc: Bool
    /// fade_in_start_milliseconds
    public let fadeInStartMilliseconds: Int
    /// cc_fonts_url
    public let ccFontsUrl: String
    /// no_get_video_log
    public let noGetVideoLog: Int
    /// ad_slots
    public let adSlots: Int
    /// iv_load_policy
    public let ivLoadPolicy: Int
    /// iv_allow_in_place_switch
    public let ivAllowInPlaceSwitch: Int
    /// vm
    public let vm: String
    /// cc_module
    public let ccModule: String
    /// excluded_ads
    public let excludedAds: String
    /// iurlhq
    public let iurlhq: String
    /// plid
    public let plid: String
    /// muted
    public let muted: Int
    /// loeid
    public let loeid: String
    /// title
    public let title: String
    /// dashmpd
    public let dashmpd: String
    /// fade_out_start_milliseconds
    public let fadeOutStartMilliseconds: Int
    /// iurl
    public let iurl: String
    /// instream_long
    public let instreamLong: Bool
    /// cid
    public let cid: Int
    /// iurlsd
    public let iurlsd: String
    /// use_cipher_signature
    public let useCipherSignature: Bool
    /// ttsurl
    public let ttsurl: String
    /// caption_translation_languages--------------------------------------
    public let captionTranslationLanguages: String
    /// core_dbp
    public let coreDbp: String
    /// video_id
    public let videoId: String
    /// token
    public let token: String
    /// eventid
    public let eventid: String
    /// caption_audio_tracks
    public let captionAudioTracks: String
    /// cl
    public let cl: Float
    /// iv3_module
    public let iv3Module: Int
    /// ldpj
    public let ldpj: Int
    /// afv
    public let afv: Bool
    /// fade_out_duration_milliseconds
    public let fadeOutDurationMilliseconds: Int
    /// hl
    public let hl: String
    /// subtitles_xlb
    public let subtitlesXlb: String
    /// view_count
    public let viewCount: Int
    /// ad_logging_flag
    public let adLoggingFlag: Int
    /// thumbnail_url
    public let thumbnailUrl: String
    /// midroll_freqcap
    public let midrollFreqcap: Float
    ///
    public let formatStreamMap: [FormatStreamMap]
    
    init(_ dict: [String:String]) {
        csiPageType = dict["csi_page_type"] ?? ""
        enabledEngageTypes = dict["enabled_engage_types"] ?? ""
        tagForChildDirected = (dict["tag_for_child_directed"] ?? "false").lowercaseString == "true"
        enablecsi = Int(dict["enablecsi"] ?? "0") ?? 0
        captionTracks = dict["caption_tracks"] ?? ""
        ptk = dict["ptk"] ?? ""
        accountPlaybackToken = dict["account_playback_token"] ?? ""
        adDevice = Int(dict["ad_device"] ?? "0") ?? 0
        c = dict["c"] ?? ""
        videoVerticals = dict["video_verticals"] ?? ""
        iurlmq = dict["iurlmq"] ?? ""
        ccAsr = Int(dict["cc_asr"] ?? "0") ?? 0
        ptchn = dict["ptchn"] ?? ""
        ivInvideoUrl = dict["iv_invideo_url"] ?? ""
        status = dict["status"] ?? ""
        asLaunchedInCountry = Int(dict["as_launched_in_country"] ?? "0") ?? 0
        allowHtml5Ads = Int(dict["allow_html5_ads"] ?? "0") ?? 0
        cc3Module = Int(dict["cc3_module"] ?? "0") ?? 0
        adModule = dict["ad_module"] ?? ""
        timestamp = Float(dict["timestamp"] ?? "0") ?? 0
        adsenseVideoDocId = dict["adsense_video_doc_id"] ?? ""
        oid = dict["oid"] ?? ""
        ypcAdIndicator = Float(dict["ypc_ad_indicator"] ?? "0") ?? 0
        
        if let temp = dict["keywords"] {
            keywords = temp.componentsSeparatedByString(",")
                .map({ $0.stringByReplacingOccurrencesOfString("+", withString: " ")})
        } else {
            keywords = []
        }
        
        avgRating = Float(dict["avg_rating"] ?? "0") ?? 0
        mpvid = dict["mpvid"] ?? ""
        defaultAudioTrackIndex = Int(dict["default_audio_track_index"] ?? "0") ?? 0
        pltype = dict["pltype"] ?? ""
        lengthSeconds = Int(dict["length_seconds"] ?? "0") ?? 0
        
        if let temp = dict["watermark"] {
            watermark = temp.componentsSeparatedByString(",")
                .filter({ $0.characters.count > 0 })
        } else {
            watermark = []
        }
        
        ucid = dict["ucid"] ?? ""
        afvAdTag = dict["afv_ad_tag"] ?? ""
        of = dict["of"] ?? ""
        cver = Float(dict["cver"] ?? "0") ?? 0
        adFlags = Int(dict["ad_flags"] ?? "0") ?? 0
        allowRatings = Int(dict["allow_ratings"] ?? "0") ?? 0
        allowEmbed = Int(dict["allow_embed"] ?? "0") ?? 0
        showContentThumbnail = (dict["show_content_thumbnail"] ?? "false").lowercaseString == "true"
        gutTag = dict["gut_tag"] ?? ""
        fexp = dict["fexp"] ?? ""
        midrollPrefetchSize = Int(dict["midroll_prefetch_size"] ?? "0") ?? 0
        shortform = (dict["shortform"] ?? "false").lowercaseString == "true"
        dbp = dict["dbp"] ?? ""
        probeUrl = dict["probe_url"] ?? ""
        sffb = (dict["sffb"] ?? "false").lowercaseString == "true"
        ccFont = dict["cc_font"] ?? ""
        allowedAds = dict["allowed_ads"] ?? ""
        tmi = Int(dict["tmi"] ?? "0") ?? 0
        storyboardSpec = dict["storyboard_spec"] ?? ""
        fadeInDurationMilliseconds = Int(dict["fade_in_duration_milliseconds"] ?? "0") ?? 0
        idpj = Int(dict["idpj"] ?? "0") ?? 0
        isListed = Int(dict["is_listed"] ?? "0") ?? 0
        fmtList = dict["fmt_list"] ?? ""
        ivModule = dict["iv_module"] ?? ""
        iurlmaxres = dict["iurlmaxres"] ?? ""
        adaptiveFmts = dict["adaptive_fmts"] ?? ""
        author = dict["author"] ?? ""
        applyFadeOnMidrolls = (dict["apply_fade_on_midrolls"] ?? "false").lowercaseString == "true"
        hasCc = (dict["has_cc"] ?? "false").lowercaseString == "true"
        fadeInStartMilliseconds = Int(dict["fade_in_start_milliseconds"] ?? "0") ?? 0
        ccFontsUrl = dict["cc_fonts_url"] ?? ""
        noGetVideoLog = Int(dict["no_get_video_log"] ?? "0") ?? 0
        adSlots = Int(dict["ad_slots"] ?? "0") ?? 0
        ivLoadPolicy = Int(dict["iv_load_policy"] ?? "0") ?? 0
        ivAllowInPlaceSwitch = Int(dict["iv_allow_in_place_switch"] ?? "0") ?? 0
        vm = dict["vm"] ?? ""
        ccModule = dict["cc_module"] ?? ""
        excludedAds = dict["excluded_ads"] ?? ""
        iurlhq = dict["iurlhq"] ?? ""
        plid = dict["plid"] ?? ""
        muted = Int(dict["muted"] ?? "0") ?? 0
        loeid = dict["loeid"] ?? ""
        if let temp = dict["title"] {
            title = temp.stringByReplacingOccurrencesOfString("+", withString: " ")
        } else {
            title = ""
        }
        dashmpd = dict["dashmpd"] ?? ""
        fadeOutStartMilliseconds = Int(dict["fade_out_start_milliseconds"] ?? "0") ?? 0
        iurl = dict["iurl"] ?? ""
        instreamLong = (dict["instream_long"] ?? "false").lowercaseString == "true"
        cid = Int(dict["cid"] ?? "0") ?? 0
        iurlsd = dict["iurlsd"] ?? ""
        useCipherSignature = (dict["use_cipher_signature"] ?? "false").lowercaseString == "true"
        ttsurl = dict["ttsurl"] ?? ""
        captionTranslationLanguages = dict["caption_translation_languages"] ?? ""
        coreDbp = dict["core_dbp"] ?? ""
        videoId = dict["video_id"] ?? ""
        token = dict["token"] ?? ""
        eventid = dict["eventid"] ?? ""
        captionAudioTracks = dict["caption_audio_tracks"] ?? ""
        cl = Float(dict["cl"] ?? "0") ?? 0
        iv3Module = Int(dict["iv3_module"] ?? "0") ?? 0
        ldpj = Int(dict["ldpj"] ?? "0") ?? 0
        afv = (dict["afv"] ?? "false").lowercaseString == "true"
        fadeOutDurationMilliseconds = Int(dict["fade_out_duration_milliseconds"] ?? "0") ?? 0
        hl = dict["hl"] ?? ""
        subtitlesXlb = dict["subtitles_xlb"] ?? ""
        viewCount = Int(dict["view_count"] ?? "0") ?? 0
        adLoggingFlag = Int(dict["ad_logging_flag"] ?? "0") ?? 0
        thumbnailUrl = dict["thumbnail_url"] ?? ""
        midrollFreqcap = Float(dict["midroll_freqcap"] ?? "0") ?? 0
        
        if let value = dict["url_encoded_fmt_stream_map"] {
            formatStreamMap = value
                .componentsSeparatedByString(",")
                .flatMap({ str2dict($0) })
                .flatMap({ FormatStreamMap($0) })
                .sort({$0.0.quality < $0.1.quality})
        }
        else {
            formatStreamMap = []
        }
    }
}

/**
 Get FormatStreamMap array from string directly.
 YouTubeStreaming object is not created in this method.
 - parameter string: String to be parsed.
 - returns: Array of FormatStreamMap.
 */
public func FormatStreamMapFromString(string:String) -> [FormatStreamMap] {
    let dict = str2dict(string)
    if let value = dict["url_encoded_fmt_stream_map"], decoded = value.stringByRemovingPercentEncoding {
        return decoded
            .componentsSeparatedByString(",")
            .flatMap({ str2dict($0) })
            .flatMap({ FormatStreamMap($0) })
            .sort({$0.0.quality < $0.1.quality})
    }
    return []
}

/**
 Get YouTubeStreaming from string.
 - parameter string: String to be parsed.
 - returns: YouTubeStreaming object.
 */
public func YouTubeStreamingFromString(string:String) -> YouTubeStreaming {
    return YouTubeStreaming(str2dict(string))
}