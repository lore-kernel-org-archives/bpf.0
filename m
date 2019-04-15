Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CB7C10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 09:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43952073F
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 09:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="CRW2iN+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfDOJSg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:18:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51896 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfDOJSf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 05:18:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so19675595wmf.1
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B81COM85m4lVNCDgDUr6KTHnRwDglA7ZlliOpOsgLpg=;
        b=CRW2iN+iTEjD4GegNoYu0tRf8SYaTpSCNVzW95oCTHLVihH0jPYTJlpxgJZ1H0/IYp
         J0GtLLNK1wnY8TaVDnx45TsZPHb22GfTEF47a6vOEJqcsHNCrotzw/PEDT0b39n6Vwla
         defhyPbadiDxT9FpdMq9EP+Wb6tQgMrHwBPxHMPPGNF5Q/jUNpKDRAm+wGD7l0qSK4fe
         gyc3Hhlo5qA7S4/eazcUe9et+aVQLWxOP5Jj/+Z0K0dvWpflHb60xE1QTV18e4HPKXTy
         jSwkdydra6rx99MBbjLueRQmgDftY18g+gaPpxG7K5sQEoBt+4shF1SUdezK5k5sMelH
         WnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B81COM85m4lVNCDgDUr6KTHnRwDglA7ZlliOpOsgLpg=;
        b=t/5Urv/6f5Vb+PisIELN0/hww6veou9BhtFMH5s/RXL6bvq8qNSfNo1u62z8xtSduA
         3b22t87Uduo2Cfcbt7ITeDq1Zl/zQvYbgn22CeYrmcHtvEUyITznH7kKllWfU5mJP5XT
         zeejpY5BnYsktwXn0cg198SGwkUNjZV5dATZfnubWHZ5tjjrdM7RS0hj/remEjExNdc6
         r5P9YsOoVhGRZW/8nqJO/O+XcoXxappCRiIfn0/dbgfW8KAKTGqv2AzgeCZIShaZmfVg
         kex2llK7WB8DCeWqoyoHaas9tPTUVMElk5PcxlPSX7rvYSeh/M8L/5JzMuPfr/b/j2w+
         Yuew==
X-Gm-Message-State: APjAAAXXmY3h9UZvfhDUYGwueRp5OJs0OKxrkM6GFEbBipyG69Wwmszc
        kY/epcogu8GFxqsjWWH22b6K2Xdr0IU=
X-Google-Smtp-Source: APXvYqwy8JrPZTqb+RoF4fAFJGmX+cSbB3Zb0+8OGbfo8q1VOcIoVOVfNMx0gK60cchf3wiBbYxHBw==
X-Received: by 2002:a1c:a803:: with SMTP id r3mr19928073wme.78.1555319913050;
        Mon, 15 Apr 2019 02:18:33 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.213])
        by smtp.gmail.com with ESMTPSA id t14sm13112970wmi.16.2019.04.15.02.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 02:18:32 -0700 (PDT)
Subject: Re: [PATCH v3 bpf-next 1/2] bpftool: Use print_entry_error() in case
 of ENOENT when dumping
To:     Benjamin Poirier <bpoirier@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20190412030322.15494-1-bpoirier@suse.com>
 <20190415071536.19287-1-bpoirier@suse.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <aea8ec32-4b9b-194e-2369-95bc6ad1119d@netronome.com>
Date:   Mon, 15 Apr 2019 10:18:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415071536.19287-1-bpoirier@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-15 16:15 UTC+0900 ~ Benjamin Poirier <bpoirier@suse.com>
> Commit bf598a8f0f77 ("bpftool: Improve handling of ENOENT on map dumps")
> used print_entry_plain() in case of ENOENT. However, that commit introduces
> dead code. Per-cpu maps are zero-filled. When reading them, it's all or
> nothing. There will never be a case where some cpus have an entry and
> others don't.
> 
> The truth is that ENOENT is an error case. Use print_entry_error() to
> output the desired message. That function's "value" parameter is also
> renamed to indicate that we never use it for an actual map value.
> 
> The output format is unchanged.
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>   tools/bpf/bpftool/map.c | 33 ++++++++++++++-------------------
>   1 file changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index e96903078991..df958af56b6c 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -261,20 +261,20 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
>   }
>   
>   static void print_entry_error(struct bpf_map_info *info, unsigned char *key,
> -			      const char *value)
> +			      const char *error_msg)
>   {
> -	int value_size = strlen(value);
> +	int msg_size = strlen(error_msg);
>   	bool single_line, break_names;
>   
> -	break_names = info->key_size > 16 || value_size > 16;
> -	single_line = info->key_size + value_size <= 24 && !break_names;
> +	break_names = info->key_size > 16 || msg_size > 16;
> +	single_line = info->key_size + msg_size <= 24 && !break_names;
>   
>   	printf("key:%c", break_names ? '\n' : ' ');
>   	fprint_hex(stdout, key, info->key_size, " ");
>   
>   	printf(single_line ? "  " : "\n");
>   
> -	printf("value:%c%s", break_names ? '\n' : ' ', value);
> +	printf("value:%c%s", break_names ? '\n' : ' ', error_msg);
>   
>   	printf("\n");
>   }
> @@ -298,11 +298,7 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
>   
>   		if (info->value_size) {
>   			printf("value:%c", break_names ? '\n' : ' ');
> -			if (value)
> -				fprint_hex(stdout, value, info->value_size,
> -					   " ");
> -			else
> -				printf("<no entry>");
> +			fprint_hex(stdout, value, info->value_size, " ");
>   		}
>   
>   		printf("\n");
> @@ -321,11 +317,8 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
>   			for (i = 0; i < n; i++) {
>   				printf("value (CPU %02d):%c",
>   				       i, info->value_size > 16 ? '\n' : ' ');
> -				if (value)
> -					fprint_hex(stdout, value + i * step,
> -						   info->value_size, " ");
> -				else
> -					printf("<no entry>");
> +				fprint_hex(stdout, value + i * step,
> +					   info->value_size, " ");
>   				printf("\n");
>   			}
>   		}
> @@ -722,11 +715,13 @@ static int dump_map_elem(int fd, void *key, void *value,
>   		jsonw_string_field(json_wtr, "error", strerror(lookup_errno));
>   		jsonw_end_object(json_wtr);
>   	} else {
> +		const char *msg = NULL;
> +
>   		if (errno == ENOENT)
> -			print_entry_plain(map_info, key, NULL);
> -		else
> -			print_entry_error(map_info, key,
> -					  strerror(lookup_errno));
> +			msg = "<no entry>";
> +
> +		print_entry_error(map_info, key,
> +				  msg ? : strerror(lookup_errno));

(Nit: This would now fit on a single line, but no need to respin just 
for that.)

Thanks!
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
