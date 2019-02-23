Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD880C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 18:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87087206B6
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 18:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrdjIq4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfBWSgx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 23 Feb 2019 13:36:53 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34567 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfBWSgw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Feb 2019 13:36:52 -0500
Received: by mail-yb1-f194.google.com with SMTP id a4so2205222ybo.1;
        Sat, 23 Feb 2019 10:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mk+Zdbh1oJOQ2bnINtgY1mHTpf0WvUy/SfouUgtrcvU=;
        b=GrdjIq4DalKhrzELrqxLhpFBmr0Fs4GIToIKMaBR8F1kdzIrQRP3uUeX2XWKUcLW2i
         ElogjLkGTIrxj8xopwMUwgNKIKW50G5Si54x6C5xuexe/T/n8LN84Z2lJ4//Q7yvMsfi
         gK+pPQERmf3MzIHKPh2pMdkQlbRP4AbfKkN636FwRVhxX4HrDSBXsqpMRZHnwjw0Bime
         fmUzvps9fOyLmrzNm9SO6aEgaaIQHCi1E1frWSFhnFJCHX53H6Dl5gcyewoevd7mPxzS
         1byZaJB/3oEGZuIjQ56qJlS4Q5f4Qsixekw49Xvc9tkbj04n4msxpssdOODLLayFWtXV
         yt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mk+Zdbh1oJOQ2bnINtgY1mHTpf0WvUy/SfouUgtrcvU=;
        b=J/LquE9nwGWGclfnOo5/lOgqopAIUmfOBITZ4m+DGTOMb0acWbro4g5POxkyWkK5wu
         VNRISLPHQ5oHTqsejMLPT22jrnEn1AOpenak6efAmSiywI6D36Awao4BaPSTrG7BuOdl
         G8IvFAwHMKV4TVJyVFhUsS9NagQwQP2UMjYyBHKdSNwZcf9Lu+q7Se3x+Co8MtRqwwZV
         JcsfJtogVk6jFlsFUo5nMqwXfERvMY93mvOEekyxN6M0BJMOnRMJ29rB30R0i5aX4HOB
         my5wrwUF5aDFouFbz8WxmYRYK1dPiPwB5ov1Im/HzvemIaBwrmqBlAuwn+Rym9QwaBYI
         trFA==
X-Gm-Message-State: AHQUAub+TppoTo1icq3e+UqBdcWsrz97d+pihPb6LJrZzs/LVeNL2IEX
        5hqxPHsQ7IqsjreWNyoGJ4k=
X-Google-Smtp-Source: AHgI3IbvldwYH/cNj2Qi2tMNjS+R4WrF5k9XrBJwoVlfENxBcdEHZ7iGVKVroiupXGWIu/rGTmzLhg==
X-Received: by 2002:a25:4d7:: with SMTP id 206mr8527922ybe.52.1550947012021;
        Sat, 23 Feb 2019 10:36:52 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id 207sm1705646ywd.45.2019.02.23.10.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 10:36:49 -0800 (PST)
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: enable program stats
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     daniel@iogearbox.net, edumazet@google.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20190223174422.663270-1-ast@kernel.org>
 <20190223174422.663270-2-ast@kernel.org>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <218b9aab-5e78-46b1-1f65-dd0a305548c7@gmail.com>
Date:   Sat, 23 Feb 2019 10:36:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190223174422.663270-2-ast@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 02/23/2019 09:44 AM, Alexei Starovoitov wrote:

...

>  
> -#define BPF_PROG_RUN(filter, ctx)  ({ cant_sleep(); (*(filter)->bpf_func)(ctx, (filter)->insnsi); })
> +DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
> +
> +#define BPF_PROG_RUN(prog, ctx)	({				\
> +	u32 ret;						\
> +	cant_sleep();						\
> +	if (static_branch_unlikely(&bpf_stats_enabled_key)) {	\
> +		struct bpf_prog_stats *stats;			\
> +		u64 start = sched_clock();			\
> +		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
> +		stats = this_cpu_ptr(prog->aux->stats);		\
> +		u64_stats_update_begin(&stats->syncp);		\
> +		stats->cnt++;					\
> +		stats->nsecs += sched_clock() - start;		\
> +		u64_stats_update_end(&stats->syncp);		\
> +	} else {						\
> +		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
> +	}							\
> +	ret; })
> 

It seems a cpu running there could still be interrupted (by an interrupt)
and re-enter this section ?

If yes, u64_stats_update_begin() and u64_stats_update_end() are unsafe (on 32bit arches)

u64_stats_update_{begin|end}() assume proper locking, since they use a simple increment.

But then, even on 64bit arches, the stats->{cnt|nsecs} updates are unsafe ?
