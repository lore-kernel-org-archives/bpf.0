Return-Path: <SRS0=xWwI=DV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0882C433DF
	for <bpf@archiver.kernel.org>; Wed, 14 Oct 2020 09:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33401207C3
	for <bpf@archiver.kernel.org>; Wed, 14 Oct 2020 09:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdKm5DUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgJNJqY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgJNJqY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Oct 2020 05:46:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D88C061755;
        Wed, 14 Oct 2020 02:46:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f21so1660141wml.3;
        Wed, 14 Oct 2020 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CfnUA7lPs13+RkY13s7qGHXOH+QwqeJG5S0NDdqc//A=;
        b=BdKm5DUb5YHQLwciujai1hznrA0naxCz2ZZ8ifFnrKF+9/dcR2xOhHefVYa0NDsxlj
         Geb7m42lxK9a7w+lTCbiMBsqIoe2kw6B2wbb4SLNaHKc/0Uq22MhsE25VCrWKwfr46jq
         5IvvfNLb1yJXcZLA50dDx06UBPdoYCP5mxZrwhQKjH2egtNPw8ePv/yj1KqA0UrtNT0W
         IlQbz0alr3LrH2/7YkRbgKS29WneQOs/ffVN2UACUmUww8cWmGlMBlIOwjv3Z5AM9LUE
         f9o0nSA+Ixm8kn12y0WTEa319wLXPKLC6/546m0pyX8shtvj4ozZSoqUY34TzwzhuhH5
         BogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CfnUA7lPs13+RkY13s7qGHXOH+QwqeJG5S0NDdqc//A=;
        b=qfynyBnOACEWF4Qx2LWKN0d8G4cw0o9HnhqL7br7Y2prxPUY7COk6RUBsWFtn0qBtF
         WaXAYrFhPUP/zJTcMMjKoliySNdUw/kAYeQKx6INPsDLGeIh14T65+ASi5qE4siDcllM
         FDxsa0sn8L46fY07SUI8cTzOpqB9gI/A/moP3AGW0XTt92IVi5xe6KuoJuXEP3e6Jq9e
         X61oyBktpC46gp/H3iHHJlkfPUvSxNSClwsPJBED8HnKMRpLp239nsdLXJzAiHG3DYvt
         8jzcHijfZ8jQQERoucP0HhFX6VTA7f7ZBZRmavQbwHpxRjEc1a7QLY3U8bOtIkWqXzb5
         cBPA==
X-Gm-Message-State: AOAM531NpxJxcruUYJaw6PpnoUuEKuebgEwHBEZHZ/n+ZdWrVVTwPu1M
        uR2kmGXVhIu8tzwh1AwRtvK+gX8Jce7kHZdO
X-Google-Smtp-Source: ABdhPJwGaqynFd9Wu1Qx7mnra13c+vM06XaTSAYrsjS3vddBQNkYNdGPSyfh8sMS1grAu24T/vogog==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr2598216wmc.42.1602668782840;
        Wed, 14 Oct 2020 02:46:22 -0700 (PDT)
Received: from [192.168.0.66] (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id v17sm4499293wrc.23.2020.10.14.02.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 02:46:22 -0700 (PDT)
Subject: Re: [PATCH] net: sockmap: Don't call bpf_prog_put() on NULL pointer
To:     Jakub Sitnicki <jakub@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201012170952.60750-1-alex.dewar90@gmail.com>
 <877drtqhj6.fsf@cloudflare.com>
From:   Alex Dewar <alex.dewar90@gmail.com>
Message-ID: <58d4578e-3314-9121-8723-7aaef9d02604@gmail.com>
Date:   Wed, 14 Oct 2020 10:45:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <877drtqhj6.fsf@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 14/10/2020 10:32, Jakub Sitnicki wrote:
> On Mon, Oct 12, 2020 at 07:09 PM CEST, Alex Dewar wrote:
>> If bpf_prog_inc_not_zero() fails for skb_parser, then bpf_prog_put() is
>> called unconditionally on skb_verdict, even though it may be NULL. Fix
>> and tidy up error path.
>>
>> Addresses-Coverity-ID: 1497799: Null pointer dereferences (FORWARD_NULL)
>> Fixes: 743df8b7749f ("bpf, sockmap: Check skb_verdict and skb_parser programs explicitly")
>> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
>> ---
> Note to maintainers: the issue exists only in bpf-next where we have:
>
>    https://lore.kernel.org/bpf/160239294756.8495.5796595770890272219.stgit@john-Precision-5820-Tower/
>
> The patch also looks like it is supposed to be applied on top of the above.
Yes, the patch is based on linux-next.
