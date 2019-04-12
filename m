Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1CEC10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 10:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3929420850
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 10:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="rWNFfUVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfDLK2k (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:28:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37437 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLK2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 06:28:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so11271413wrm.4
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 03:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NTkKQOs9zctdhMgfdzwa0qtX2SfuqQlJYXeOfwVck6w=;
        b=rWNFfUVNtoenzNFbVQo9GR3SonSHItpEJ2Fo0z4gkgP3PFiFWYpR/2UfCfvqIDkjVT
         868AUUdX4F4Uu570VjMy/fKVp6KIEErNIZij6ixPEzFv+89+mdg8kx2WNJQlxdgBfsDc
         F1sbA0uX2zT5AXgjoti7s281xccDhtnLb8amMOiW7n04ELaGzYQt++nd9Lm5xLWczeSu
         idYCHXhphdlwhWrRKdX9AeA7Jgskj4QygidXo+UudzpKx0gc7j1j2i8xGht3tgj4roln
         wsptiWworQvTgYIKLGYz3+cWazoJrcvYXcTnMuhyt45ppTH7Bn0tMSSkkzfE+B/WOs3s
         aSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NTkKQOs9zctdhMgfdzwa0qtX2SfuqQlJYXeOfwVck6w=;
        b=t6zuUgSRjUyRwIW52afKHOZ9rn88jx4x/WtUExH8I5O0ILsyx7Wdx9Qbi37JRUcj0k
         Y9DeT9zV7DxqbkeW+FhM1SlgKRO4aLYIVCDEB8l9Y3ZL3T1VVR1tXO7ynzr3SgOH8IYY
         WtAgFbzlC0xqaF+YOqd9yPNC78cs27FbX9s9IqVM/4IUP3nW1kzRohKPUKj+FsAFUfV7
         vkklKxGxraWp7sBx5bl7wtGOkTtcyUsbx4PsKKYvW6m41g2M32awMuNmuC9tkkw76G9i
         MYqYuDVN1CnBiMjYc6Q+nx704LItkGH1N+Q7DEsY1UIpfmX1hM+hF7Yx53htGz5EM9Sj
         G04w==
X-Gm-Message-State: APjAAAWKe5rFc5qeuQPGQaFrxOGCgH2AK8cLsEvwLglBMl1NmYSRu0tD
        Oko/Mu9TJEyCYnCUdznnDqOeUw==
X-Google-Smtp-Source: APXvYqzKxe7d1txqXx+L2ghgFJPQAC27s0zQfJgxOyf5PE2Krq0kh/NYJo/U0bnkNLhtxoHCguIkFg==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr28293542wru.299.1555064918184;
        Fri, 12 Apr 2019 03:28:38 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.213])
        by smtp.gmail.com with ESMTPSA id v14sm51300361wrr.20.2019.04.12.03.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:28:37 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next 1/2] bpftool: Use print_entry_error() in case
 of ENOENT when dumping
To:     Benjamin Poirier <bpoirier@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
References: <20190411082700.26888-1-bpoirier@suse.com>
 <20190412030322.15494-1-bpoirier@suse.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <44958814-3145-717f-366e-ecc52f2145b9@netronome.com>
Date:   Fri, 12 Apr 2019 11:28:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412030322.15494-1-bpoirier@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-12 12:03 UTC+0900 ~ Benjamin Poirier <bpoirier@suse.com>
> Commit bf598a8f0f77 ("bpftool: Improve handling of ENOENT on map dumps")
> used print_entry_plain() in case of ENOENT because that function provided
> the desired formatting. However, that commit actually introduces dead code.
> Per-cpu maps are zero-filled. When reading them, it's all or nothing. There
> will never be a case where some cpus have an entry and others don't.
> 
> The truth is that ENOENT is an error case. So rework print_entry_error() to
> provide the desired formatting.
> 
> Note that this commit changes the output format in case of errors other
> than ENOENT.
> 
> example before:
> key:
> 00 00 00 00
> value:
> No space left on device
> [...]
> 
> example after:
> key: 00 00 00 00
> value:
> No space left on device
> [...]
> 
> The ENOENT case is unchanged:
> key: 00 00 00 00  value: 14 5b 00 00 00 00 00 00
> key: 01 00 00 00  value: <no entry>
> [...]
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>   tools/bpf/bpftool/map.c | 34 ++++++++++++++--------------------
>   1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index e96903078991..71840faaeab5 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -261,20 +261,19 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
>   }
>   
>   static void print_entry_error(struct bpf_map_info *info, unsigned char *key,
> -			      const char *value)
> +			      const char *value, bool single_line)

Nit: if you respin the series, could you rename "value" into "error_msg" 
or something like this to better indicate we never pass an actual map 
value to the function?

>   {
> -	int value_size = strlen(value);
> -	bool single_line, break_names;
> +	bool break_names;
>   
> -	break_names = info->key_size > 16 || value_size > 16;
> -	single_line = info->key_size + value_size <= 24 && !break_names;
> +	break_names = info->key_size > 16;
> +	single_line = single_line && !break_names;

If I understand correctly, this will also change formatting when error 
message is short (shorter than 16 characters: the "value" line will now 
be unconditionally split, even for short error messages (other than "<no 
entry>")). Why removing the condition on value_size > 16? (This is just 
a remark, I am not against changing it.)

>   
>   	printf("key:%c", break_names ? '\n' : ' ');
>   	fprint_hex(stdout, key, info->key_size, " ");
>   
>   	printf(single_line ? "  " : "\n");
>   
> -	printf("value:%c%s", break_names ? '\n' : ' ', value);
> +	printf("value:%c%s", single_line ? ' ' : '\n', value);
>   
>   	printf("\n");
>   }

[...]
