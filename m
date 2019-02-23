Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4EDC43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 20:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F91F204EC
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 20:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsRA7mTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfBWUs6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 23 Feb 2019 15:48:58 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41365 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfBWUs5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Feb 2019 15:48:57 -0500
Received: by mail-yw1-f68.google.com with SMTP id q128so2196581ywg.8;
        Sat, 23 Feb 2019 12:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w+BU+NvwGK0Oz7T93t0LWlKOLYpeOkCU67pEHARut0Q=;
        b=WsRA7mTo3jDpmKDSb8QNOKLL2fbkZX1o4kwYDqHQvXpjJrVCPqTQxcliVmEIQP8ZYY
         SLxQEoYSp7DnAo2N1uswOIUEma759CupUByusnn0EnZ6SqBNMxH6DkBG+VKsdym3/yjW
         AbRSBT7oNfq3J4Bbmts7aUqE6RrPF4r71gZF3kvpbQETw/AyOTRYhNUa+Hg3MoBawvV4
         3SHhGxw8awzmse/5ABSi6mwTi3pXsauLIF6XmtuhPcOdu0GNQYw3wcQxK7esxCidG4jK
         Rk1yhiVFuJ6I8Or37immyq+qTBOx8mMme5OJCd/MaEVPw9/Y2DDBNF7qHHD696Z+nEn0
         z2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w+BU+NvwGK0Oz7T93t0LWlKOLYpeOkCU67pEHARut0Q=;
        b=NZldEcDDBzfFuzCyzvHjNJAZMA2WgJhT8r8cH6XxREp5yD8Eu8dvGQr8dZeDbmCQzg
         r1vNPIJEIfww2la3cRh3sXsneoI16qFeU+Bk5xFET4HlEWUvaHWFQkKlMuW4RDhRD/fa
         ZoFQDcemRRKpxI8GaZrFER4djR2P4R2fKpvcfZRa5sdgQxBjqAl8/ucll7UiPKp09ebH
         Zsa7nWMtCncy6WnzmQtyUvyr7bf5SPaeG30HeTMXk/T6EE0y3yfSFM/Hbhg6yhs2yf7E
         5MYErmbnD5ztbkYba35z5ugpiN3QHpGZuQoO8/K4RU/IqPoSlkq6AqtckRYiIDpImnpI
         qCPw==
X-Gm-Message-State: AHQUAuZ7K3gXswLU/qHAYnljxoshf8mbduV1N9QBBEge+P5fphP7S2ct
        SJG84Hgt3qUaJfPSEfInYN8=
X-Google-Smtp-Source: AHgI3Ibn5wZdbr9MbkO6qyjydLJZ0WcAvKrx5AFNv+aCwdNA344Yvi2K1x1qO0Ee5fSNflQEvDk4tQ==
X-Received: by 2002:a81:5509:: with SMTP id j9mr8555805ywb.409.1550954936548;
        Sat, 23 Feb 2019 12:48:56 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id b83sm1807289ywb.48.2019.02.23.12.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 12:48:55 -0800 (PST)
Subject: Re: [PATCH bpf] bpf: properly check TCP_CONGESTION optlen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Lawrence Brakmo <brakmo@fb.com>
References: <20190223190709.61558-1-edumazet@google.com>
 <20190223203808.f2r54xz2z7j2gecg@ast-mbp.dhcp.thefacebook.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <73905026-571a-867d-43eb-3d9b36f6c39c@gmail.com>
Date:   Sat, 23 Feb 2019 12:48:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190223203808.f2r54xz2z7j2gecg@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 02/23/2019 12:38 PM, Alexei Starovoitov wrote:
> On Sat, Feb 23, 2019 at 11:07:09AM -0800, Eric Dumazet wrote:
>> If caller of bpf_setsockopt() is silly passing a negative optlen
>> bad things happen.
>>
>> Fixes: 91b5b21c7c16 ("bpf: Add support for changing congestion control")
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Cc: Lawrence Brakmo <brakmo@fb.com>
>> ---
>>  net/core/filter.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index f7d0004fc16096eb42ece3a6acf645540ee2326b..6a5d89464168f2f35f43986c1dbc0446c9390a3c 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -4194,8 +4194,9 @@ BPF_CALL_5(bpf_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>>  			char name[TCP_CA_NAME_MAX];
>>  			bool reinit = bpf_sock->op > BPF_SOCK_OPS_NEEDS_ECN;
>>  
>> -			strncpy(name, optval, min_t(long, optlen,
>> -						    TCP_CA_NAME_MAX-1));
>> +			if (optlen < 0)
>> +				return -EINVAL;
>> +			strncpy(name, optval, min(optlen, TCP_CA_NAME_MAX - 1));
> 
> Unnecessary.
> The verifier guarantees that optlen > 0 because
> static const struct bpf_func_proto bpf_setsockopt_proto = {
>         .func           = bpf_setsockopt,
> ...
>         .arg5_type      = ARG_CONST_SIZE,
> };
> 

Even on 32bit kernel ?

The suspect thing to me is the min_t(long, ....)

optlen is an integer, why do we need to promote to a long ?


