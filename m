Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF8EC10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 11:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A35F2084D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 11:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="zcpw6xQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfDKLW7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:22:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45501 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfDKLW6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 07:22:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so6785937wra.12
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2019 04:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hbgGZ/ioe6qCqVuTNLgV9MkeZW2n7OkxXnas0MQbh64=;
        b=zcpw6xQtlTzJ5iexfRc1T5XwhKzLDqCTxZT6YiSI7eu8XQjE/15Rt78V81555dedSG
         HIJibV+KdB7GzNCgApZurLVeD0t1A12RnLtMqv9pavkvI1khLrU7KMxNiqEdmSFyA7Kj
         M6cUTow7rT222FXEFlSFMoEOzxjt62iGH0kukxRfnuLIZFd5s5AN6Y4cM/x1bJgusxu7
         PbsHR4OX/36Cc4kPcGkUH1ZZ1D5FU2DRARUGHXzNkVe8njNq8JqgYwIFZCaBUMOJKEuw
         EMVvv8YXG6fhiWNYX+i7mV6b0grmUl7G53qqsj9ye7db3prj1bc4kJov9jJFg5u1h8r6
         Zfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hbgGZ/ioe6qCqVuTNLgV9MkeZW2n7OkxXnas0MQbh64=;
        b=qfGlBfDvaCbzEqr90Wpd60TLA1HwvzDQn/Vk2bik1WscQhFrXqAbuz2JhiCmTfB31y
         2xvr/3l3TVQOSTaZunQIN+FQ3uieFwaTKK7PUc8+EGa3Qg18tVt4qgN57FaHsxnvfZrg
         uEP7roxc+E46NE1JQWwAGArPckOGazFDyRWGLtCqe3zhNwUiFgWtrnMKR0rmLfENwVrD
         PunvEX4LnH3exMnv/2kQiui1m0FxRKTPhOU1AnYTQl2ztbcH25E5SoVoRbpR4srwwM5s
         V2e6r+SBAl7S3FHhvgZDFrd4tGjt8ADK5LXmSpL4bqqMnXm+reHjHhiSMIuf8s5DE8kj
         4iGw==
X-Gm-Message-State: APjAAAX8ZdHfo7B7cBsq/ALbvgMYaNkw0I9HHuX4XP3V+Vgywwk5EQia
        HEO3a6ZOF5QG0oYs8eP1DUBflg==
X-Google-Smtp-Source: APXvYqyeDVC+TNrJ1CkUztCvVQQhP48xfgbMUXJMQj2gD+bb1rjPuexL0iiLcH1E4l3vDHpwhk389g==
X-Received: by 2002:adf:f90c:: with SMTP id b12mr6646106wrr.63.1554981776347;
        Thu, 11 Apr 2019 04:22:56 -0700 (PDT)
Received: from [172.20.1.104] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id q4sm53634433wrx.25.2019.04.11.04.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 04:22:55 -0700 (PDT)
Subject: Re: [PATCH bpf] bpftool: Fix errno variable usage
To:     Benjamin Poirier <bpoirier@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
References: <20190411080332.24574-1-bpoirier@suse.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <2589b64c-0ed1-7815-dde2-aee1b48602ba@netronome.com>
Date:   Thu, 11 Apr 2019 12:22:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411080332.24574-1-bpoirier@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-11 17:03 UTC+0900 ~ Benjamin Poirier <bpoirier@suse.com>
> The test meant to use the saved value of errno. Given the current code, it
> makes no practical difference however.
> 
> Fixes: bf598a8f0f77 ("bpftool: Improve handling of ENOENT on map dumps")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  tools/bpf/bpftool/map.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index e0c650d91784..05b029b934a6 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -720,7 +720,7 @@ static int dump_map_elem(int fd, void *key, void *value,
>  		jsonw_string_field(json_wtr, "error", strerror(lookup_errno));
>  		jsonw_end_object(json_wtr);
>  	} else {
> -		if (errno == ENOENT)
> +		if (lookup_errno == ENOENT)
>  			print_entry_plain(map_info, key, NULL);
>  		else
>  			print_entry_error(map_info, key,
> 


Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
