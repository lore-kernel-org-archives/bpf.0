Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E30CC43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABEF20685
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODr8pNnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfDYTgL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:36:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34411 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfDYTgK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 15:36:10 -0400
Received: by mail-io1-f65.google.com with SMTP id h26so1029665ioj.1;
        Thu, 25 Apr 2019 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8KYm2hu8JfOk0d4ClZL46j9Hks2DNLaPsYbnNUUCdpY=;
        b=ODr8pNnlM4k6jxJM+X/feVj8F00L1Ye8FBgfVtjfpgjtSqEeUpOcz4HZcCF5jP4nEK
         CAZWhdaKrF6f3hNJzd8r1CYeGiNvLPSSRIPbn2LXFU4aYqvZso/FjCgWHf+cw+UrHrXu
         +z7wcgLPuUPcqADN1wGcrvXABv4sRr5qdeQaUf8U8Iu8Ex1WnyxCjUwKseo1eZ8K0dAF
         hVPb9JpNDdSsoFmOV1gEKq5PTHAFqD1Esf2Vl/bTJi/PalANJF+qhJ1Hh8MS5fekpLjS
         KWzBPzS0tlX3PQnT9mQcOOk0YFgJpsq0JzT6/O3vXu1k+ODdqP3GhPQgEX3x1MUmu0zl
         veHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8KYm2hu8JfOk0d4ClZL46j9Hks2DNLaPsYbnNUUCdpY=;
        b=G9D1wJIM51Vx5AfPFtfV/3LAdcH+XIec3OYE/ZWECU1EIP5Xwj++X6EL20SP/OOJRR
         hYBERjmnwGqAQR+f6BC+FKKN5LRxcYbj8R6m6EI6kCV6WqDwG6LuICP76JzQX5+2eooF
         EbJ7F1BIpmqCNr9s/4Qx4P+7jEav+kXEEhdz08amT8mqOm1Rc5zkYFF9d+jeR9JBXlY7
         lCQgaTZvO3CDtHoXOj7GUXHBAjd6m7KltuVWmvXuQAl6mjOGJ9YCxrUUhD1k0yCr4zGm
         c6NNkKmbK+7q8C806csVpB+Z3XrgmJ0xSvF0CBhin7lE3zt1Jab0BC/BNWUIJjpZPFbi
         t5yQ==
X-Gm-Message-State: APjAAAVfG4HOvzxxxSK7wdEUds4OgpGwCFBJC+BfwwB5pf6YFUNdraHU
        Msrpl/rp6+kpR8l0fKPxWdvn3LC/87g=
X-Google-Smtp-Source: APXvYqwyKT0ufx8mce88zooN3aXpWwzVa3o57uD/4Z52DUaMhCAfvbjpGLk7d+daZvY8T55/CpEM/w==
X-Received: by 2002:a6b:ed0c:: with SMTP id n12mr6404914iog.259.1556220969968;
        Thu, 25 Apr 2019 12:36:09 -0700 (PDT)
Received: from [192.168.86.29] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id h8sm8488110iof.36.2019.04.25.12.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:36:09 -0700 (PDT)
Subject: Re: [bpf PATCH v2 1/3] bpf: tls, implement unhash to avoid transition
 out of ESTABLISHED
From:   John Fastabend <john.fastabend@gmail.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <155620799743.22884.8046772841813554446.stgit@john-XPS-13-9360>
 <155620818860.22884.14832636768748270693.stgit@john-XPS-13-9360>
 <20190425122908.68b8d759@cakuba.netronome.com>
 <fed3deb5-0119-4f24-9a53-cad7a9b0fcbe@gmail.com>
Message-ID: <4f0cc6d0-1934-92d7-d2fd-d02ebe5ab822@gmail.com>
Date:   Thu, 25 Apr 2019 12:35:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fed3deb5-0119-4f24-9a53-cad7a9b0fcbe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/25/19 12:32 PM, John Fastabend wrote:
> On 4/25/19 12:29 PM, Jakub Kicinski wrote:
>> On Thu, 25 Apr 2019 09:03:08 -0700, John Fastabend wrote:
>>> +static void tls_sk_proto_unhash(struct sock *sk)
>>> +{
>>> +	struct tls_context *ctx = tls_get_ctx(sk);
>>> +	void (*sk_proto_unhash)(struct sock *sk);
>>> +	bool free_ctx;
>>> +
>>> +	if (!ctx)
>>> +		return sk->sk_prot->unhash(sk);
>>> +	sk_proto_unhash = ctx->sk_proto_unhash;
>>> +	free_ctx = tls_sk_proto_destroy(sk, ctx, false);
>>> +	tls_put_ctx(sk);
>>
>> Oh, I think you can't put_ctx() unconditionally,
>> when free_ctx is false, tls_device_sk_destruct() 
>> needs it the ctx pointer.
>>
>> I think this explains the offload crashing.
>>
> 
> ugh yeah. So we need to _not_ free it from tls_sk_proto_destroy
> do the put_ctx and then finally free it. Otherwise we can't
> restore the sk_proto fields. v3 on its way. Thanks.
> 

I'm going to throw that patch I sent earlier in this thread
on the series as well. Its the minimal set to get things working
again for me. Will follow up some selftests so we don't get
here again.

>>> +	if (sk_proto_unhash)
>>> +		sk_proto_unhash(sk);
>>> +	if (free_ctx)
>>> +		tls_ctx_free(ctx);
>>> +}
>>>  
>>> -skip_tx_cleanup:
>>> +static void tls_sk_proto_close(struct sock *sk, long timeout)
>>> +{
>>> +	void (*sk_proto_close)(struct sock *sk, long timeout);
>>> +	struct tls_context *ctx = tls_get_ctx(sk);
>>> +	bool free_ctx;
>>> +
>>> +	if (!ctx)
>>> +		return sk->sk_prot->destroy(sk);
>>> +
>>> +	lock_sock(sk);
>>> +	sk_proto_close = ctx->sk_proto_close;
>>> +	free_ctx = tls_sk_proto_destroy(sk, ctx, true);
>>> +	tls_put_ctx(sk);
> 

