Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A917C10F11
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 09:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF61520656
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 09:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="yT6Zc7do"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfDOJU6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:20:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37240 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfDOJU5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 05:20:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so20962686wrm.4
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2ynLz9Z2ynYNuXqyMG+PCxcONBkd+qipE9b/sEQetNw=;
        b=yT6Zc7dodm367KAurUfCt+V10x5J7olyVUQpatcy6R89U7Js2gN5DV1jPClWflmLCk
         Np5JQ0FxqX4PB9DR4a6I/E4A7rvc31Bu0CC1R7/ghsXtPF2MURkVcvKJoJaxOAa0D1LO
         BNswY3neQ4l3h+/GkAobhGFfKOOunTTwL7A51B5m1gk3bGlFzpGlH3yOpKlGwVQnVyDK
         jiF2t0IyGYfMlwLhS/sbgOKgS+D5BaZPqyjMacOR/DoAeHn1AqpWGbuvQIIMO8ldPa6D
         O8gschquQMdl/rbAriwpNCMLSjGQAfMPuzytO54Ha/Fb6uhE754PVqM4qJjml6+ptClq
         6mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ynLz9Z2ynYNuXqyMG+PCxcONBkd+qipE9b/sEQetNw=;
        b=tIaEGsD/Jh1iIj4ZPJQ9hgg4VCjnZSre0zpqUQzms+4axX8hcQg/+XPqglwR0JDxhn
         FVQ7bvMrJRZv10GHaGVNcE4HhNVqi1WSvvc0MlUP15zeJPWuufyu4kCSxvwsqbhrYaIa
         ST+Yc54duPSy8waEOv0RnIcH35ba9DzWDzUZYqorZToLfLxuaKhXcOnf89m4MGUnX4SR
         7KefMwVg/FU8hn7kevvA+XGUkHMUlUf690GwR1hv3h5C32BOJnkIFOfvj9SKaUov7yXt
         ZSicUhVvF0Htl5XYJr/JZvXz04/0Q1RWUJdIoIVbTIKG8q3V0Jol3xFhniz9g/3WdUUq
         9S2A==
X-Gm-Message-State: APjAAAW0O0qWzpnYvQnHKltfc16a8hphxrHjN19c1xAM6YQPxEMNsgWm
        uqY6it1dxtWw/1DS2VXGleDfX1+RysE=
X-Google-Smtp-Source: APXvYqxwFbY46pX6TRkh93sUIFwdTpH/qMpZGUxW7VGfDSdxjrbUftFO/NsqVI0kl30Kyh/b7ojjrg==
X-Received: by 2002:a5d:6b02:: with SMTP id v2mr24424414wrw.84.1555320055422;
        Mon, 15 Apr 2019 02:20:55 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.213])
        by smtp.gmail.com with ESMTPSA id 7sm169083561wrc.81.2019.04.15.02.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 02:20:54 -0700 (PDT)
Subject: Re: [PATCH v3 bpf-next 2/2] bpftool: Improve handling of ENOSPC on
 reuseport_array map dumps
To:     Benjamin Poirier <bpoirier@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20190412030322.15494-1-bpoirier@suse.com>
 <20190415071536.19287-1-bpoirier@suse.com>
 <20190415071536.19287-2-bpoirier@suse.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <573ac2b2-a2a8-3072-556d-9b890133afc0@netronome.com>
Date:   Mon, 15 Apr 2019 10:20:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415071536.19287-2-bpoirier@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-15 16:15 UTC+0900 ~ Benjamin Poirier <bpoirier@suse.com>
> avoids outputting a series of
> 	value:
> 	No space left on device
> 
> The value itself is not wrong but bpf_fd_reuseport_array_lookup_elem() can
> only return it if the map was created with value_size = 8. There's nothing
> bpftool can do about it. Instead of repeating this error for every key in
> the map, print an explanatory warning and a specialized error.
> 
> example before:
> key: 00 00 00 00
> value:
> No space left on device
> key: 01 00 00 00
> value:
> No space left on device
> key: 02 00 00 00
> value:
> No space left on device
> Found 0 elements
> 
> example after:
> Warning: cannot read values from reuseport_sockarray map with value_size != 8
> key: 00 00 00 00  value: <cannot read>
> key: 01 00 00 00  value: <cannot read>
> key: 02 00 00 00  value: <cannot read>
> Found 0 elements
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>   tools/bpf/bpftool/map.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index df958af56b6c..44b192e87708 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -719,6 +719,9 @@ static int dump_map_elem(int fd, void *key, void *value,
>   
>   		if (errno == ENOENT)
>   			msg = "<no entry>";
> +		else if (lookup_errno == ENOSPC &&
> +			 map_info->type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY)
> +			msg = "<cannot read>";
>   
>   		print_entry_error(map_info, key,
>   				  msg ? : strerror(lookup_errno));
> @@ -775,6 +778,10 @@ static int do_dump(int argc, char **argv)
>   			}
>   		}
>   
> +	if (info.type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY &&
> +	    info.value_size != 8)
> +		p_info("Warning: cannot read values from %s map with value_size != 8",
> +		       map_type_name[info.type]);
>   	while (true) {
>   		err = bpf_map_get_next_key(fd, prev_key, key);
>   		if (err) {
> 

All good for me now, thanks a lot!

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
