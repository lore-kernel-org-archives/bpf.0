Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1E9C10F14
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 10:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1DB2171F
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 10:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="j3tFRuFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfDLK2f (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:28:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41014 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLK2f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 06:28:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so11217615wrq.8
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uGn3YfgPb8ObPsEXifWAv7OOEeV5FVg84Csv1Qtjfuc=;
        b=j3tFRuFMPkOc3+WiLx9+m3YwEiQpSBey5XQEC96+8/cLBmOOD5WFZMwiB69xIWweOS
         67FvBmr3hqAmofauLPtiL35QAbRkXAcUMDhDiisUSiJaoVengZcjxqxlroxQvCavs8zw
         gRPN0m+x26jbUn3A/M8WfmYcvZnj85HCLe7uR49DwhFAKi+kQ0CR4cwnufmhZzo7Us5I
         7PG1y/lA7YgfhZw4GEz2ptkHo69rTpUlYlmu93MN4qxQaUL/y1VmMIwNDYo/qhmmSUOo
         tPNd40Ba8y7r2HEZq1KRlMvAXexcVLqZ26QwmgNuUD86shdDdt/2nt/WTa9HTIcZGygF
         zMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uGn3YfgPb8ObPsEXifWAv7OOEeV5FVg84Csv1Qtjfuc=;
        b=Kt4Y1Pxf6r7T+pzBuwUNXkDdXupFS4vs9SUgk719sUhaamp/soBJO+yhoWXddmwbfn
         uyaawgSbAfgrESm0eDqDupUhkE4sWWRS61PcA26OLHdvOfFVNCgoPrnTvAmv2d4n9a6e
         rGQaWYWRdiwqsBFud5dcCntiDo+DkLBkJIXvNIS1FW8EO0l5ShY6Id3U1QtLbPhTRQZP
         lbOeyJeAel3MUTDJb3TyZ0eHY6u6H7B3H/hd7lU4KNQOn3vTJIbz5xa97r8Loh+HoLHO
         76IcpzlloG6rqjypFzQ9NtrI73q+36BSJDxAFPdIlKxQC+xWvXd8Al1U+2Gy1gIFssC2
         Od7w==
X-Gm-Message-State: APjAAAVjbGzSLbZdiyV9OMdY3UyOTLXe9QUJ+cqasM3OOGR17Nhhk8HR
        MGrTdtmskKw7lVSjg+n27b5XhbNf6lY=
X-Google-Smtp-Source: APXvYqwHUzyreR08EQrShvO1Rrn02gbEgWOfyvbQSiuWHApbpJ+q7xjVl/ko2Cbw1ZUDN47iT8FUYQ==
X-Received: by 2002:adf:97c5:: with SMTP id t5mr18119501wrb.252.1555064913332;
        Fri, 12 Apr 2019 03:28:33 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.213])
        by smtp.gmail.com with ESMTPSA id y3sm8422934wmi.27.2019.04.12.03.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:28:32 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next 2/2] bpftool: Improve handling of ENOSPC on
 reuseport_array map dumps
To:     Benjamin Poirier <bpoirier@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20190411082700.26888-1-bpoirier@suse.com>
 <20190412030322.15494-1-bpoirier@suse.com>
 <20190412030322.15494-2-bpoirier@suse.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <8c20e4d9-28a9-626f-1e15-40cf105d7ce7@netronome.com>
Date:   Fri, 12 Apr 2019 11:28:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412030322.15494-2-bpoirier@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-12 12:03 UTC+0900 ~ Benjamin Poirier <bpoirier@suse.com>
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
>   tools/bpf/bpftool/map.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 71840faaeab5..e6d72f777767 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -716,8 +716,12 @@ static int dump_map_elem(int fd, void *key, void *value,
>   	} else {
>   		const char *msg = NULL;
>   
> -		if (errno == ENOENT)
> +		if (lookup_errno == ENOENT) {
>   			msg = "<no entry>";
> +		} else if (lookup_errno == ENOSPC && map_info->type ==
> +			 BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {

Nit: This should be aligned on the open parenthesis (And preferably 
split after the "&&", if the second condition fits on its own line?).

Thanks for the changes! This version looks much better to me than v1.

Quentin
