Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB8FC43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 10:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D6C20838
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 10:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="eQQ9zfpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfCBKMN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 2 Mar 2019 05:12:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40711 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfCBKMN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Mar 2019 05:12:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id a8so232077lfi.7
        for <bpf@vger.kernel.org>; Sat, 02 Mar 2019 02:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cYRHzHIJ93lUPFjUOboVeHRSEAE23+rZlrsUkMjtfhc=;
        b=eQQ9zfpNAdp930A05+Mu/kBPGS9qD57Jzpj9tUFTjuCrFNqmqZibaq1IE/KR8Ca2Lo
         6N17Oyuc+QG6o51lipGS2EWSoi8FLujKTnU4x3kxV097rwOIR4tCZqSmI7Bx16+uvUpY
         gl4P7kBZGDeZpjQfWbXGYqqC7QLZa4+DC0lEf96aaes/jjIuq9NavK0WAWn76/4a5eWP
         igHVx7G6M8/fQFB0OLUi/rwpnpYELr5SL8tMMV6T6eCTuz41pFdJo8/P0+u8GnvTzkxt
         6rK3w7CHbZHKMdQAXxvtoFv+n49lBvR6WGPag3YprBAeboCwHgsZrujvZ72L9ZbMl+B1
         c2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cYRHzHIJ93lUPFjUOboVeHRSEAE23+rZlrsUkMjtfhc=;
        b=GxcrPczOFfNhVfJ4LuUtFdzMMSyiA24SKghxcBQXQQEwj8k6t16Y3ZSjb+H0ABvOah
         +RunoatI3lYXGDhORTcHwu8gWYVZ/Q6nobwKFxADrZnKPlpkTChLmHHyQI5rHh2gaRtg
         z0rUMvMkD3FvkIWy3MepnHOl/mHtL1+aJME7y/ZSiQhoB+sOMmCfpzF8rZ337FbjqVGp
         xTsaA7es4Jb+6dHA8LQuoQMPHAgllHNGxP2OLJOpdcC3LmDACXFRIOz7aaHwvsMRd63Y
         uF4SrNoumRPrrzFcLnav700EQyQbVfbiesbUcMG4gqWuWL27KwUtG9qvkKOvzsKmMR2z
         wnFw==
X-Gm-Message-State: APjAAAUzU74sMv3Cydee9QUoevraw4tL6hExrVQ+OgPEH/OG2HsmhvLC
        YKMOTxV5BUeZ0JlcG33DBPPD9g==
X-Google-Smtp-Source: APXvYqwbOuV01juLEEk/bhBYY+UJMI2Pl/Evf/+hmN3EtfzzA2DcGDw7P1pAgQrJpB0YDv35eFP9IQ==
X-Received: by 2002:a19:2d44:: with SMTP id t4mr5241924lft.90.1551521531319;
        Sat, 02 Mar 2019 02:12:11 -0800 (PST)
Received: from [192.168.0.199] ([31.173.84.84])
        by smtp.gmail.com with ESMTPSA id t135sm109119lff.74.2019.03.02.02.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 02:12:10 -0800 (PST)
Subject: Re: [PATCH bpf] bpf: fix sanitation rewrite in case of non-pointers
To:     Daniel Borkmann <daniel@iogearbox.net>, ast@fb.com
Cc:     afabre@cloudflare.com, marek@cloudflare.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190301210529.8218-1-daniel@iogearbox.net>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <96367b1a-4ab5-8f1d-1823-a65ba48fa3cc@cogentembedded.com>
Date:   Sat, 2 Mar 2019 13:11:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301210529.8218-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello!

On 02.03.2019 0:05, Daniel Borkmann wrote:

> Marek reported that he saw an issue with the below snippet in that
> timing measurements where off when loaded as unpriv while results

    Were?

> were reasonable when loaded as privileged:
> 
>      [...]
>      uint64_t a = bpf_ktime_get_ns();
>      uint64_t b = bpf_ktime_get_ns();
>      uint64_t delta = b - a;
>      if ((int64_t)delta > 0) {
>      [...]
> 
> Turns out there is a bug where a corner case is missing in the fix
> d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar
> type from different paths"), namely fixup_bpf_calls() only checks
> whether aux has a non-zero alu_state, but it also needs to test for
> the case of BPF_ALU_NON_POINTER since in both occasions we need to
> skip the masking rewrite (as there is nothing to mask).
> 
> Fixes: d3bd7413e0ca ("bpf: fix sanitation of alu op with pointer / scalar type from different paths")
> Reported-by: Marek Majkowski <marek@cloudflare.com>
> Reported-by: Arthur Fabre <afabre@cloudflare.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/netdev/CAJPywTJqP34cK20iLM5YmUMz9KXQOdu1-+BZrGMAGgLuBWz7fg@mail.gmail.com/T/
[...]

MBR, Sergei
