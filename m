Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535B0C43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C14C205ED
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ig0AOkXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDYTlR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:41:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42475 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfDYTlR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 15:41:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so1468654qtc.9
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ps2h5vxRpN9DtKz/C1MlSyBGaFwq8a7WWYcjVMrd+ug=;
        b=ig0AOkXg5ECBXTJnqOvD6lsG+TOKpWmAP8wflukc4/IyEfLObE95F5ON3jP/AiKIpM
         h15jCm7wFsvv2S+L3L3RB3/+/zOlIXIqqF3gtf9mlEr4IbZHv1D54E/30KA54Kn0UEnz
         abn3PZJAlOL3/l1GbwcUrxAHPHHIMzInqLqOM64je6/o0PtAj2itEDRCXvCmJfwf+YUE
         i0AwlnzzO06903yFoiVq38j3RgxW/AFtmeOq7PcdKZ05EAA2r1rQoy2A94wskpOAzADx
         IeNH4+Xc5ZGzbZUiOSUS9Jg0ACS9Os8TbkRX218CWYPHInZVOez6tkoGGrS/YAD1EA58
         1/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ps2h5vxRpN9DtKz/C1MlSyBGaFwq8a7WWYcjVMrd+ug=;
        b=U3lBScpORsRON612vo2QXiD7d8dN/OsHlkK+XOi7rrjp9K7qImPKtBTTRCzi0zloLU
         yiqmS8w/1p2AHAjFEhbtSwUX7hZkNyp2Djw/ConF045fi+hUMbixzwQVRdvZwNTWgsBF
         +yX44ZzQK5pyHNz5i4YyUQRxq8AToExRnquElT9g/uU5+Rfx5GNptRrR1mtKg5fGY+3J
         N+xGTVpU6JV4WDrNla9AUKcpGpwAotUrsB8I2EtwyB2iAbK6ycoeB++kbmJiPqCowYOz
         t/w7I2opfmp6PJFCtd3eVm5GmHIej54z5RlqXZYGQmNuOWA8M1LZNlcjdwhDmHaNuo4C
         8Wpw==
X-Gm-Message-State: APjAAAUtL3NvmEm3mFh+9e2hXBdcC+oZs2qD0nOvG8ifue7B6oOBy1eO
        los73prn3agHKoQs0RZqv3oo/Q==
X-Google-Smtp-Source: APXvYqzUMv/uY3YJBRw5vvocxzWj63ZbhlrTXkqJ+6RphSL26k1clJu7oSNMxenIEDnImSOr9eshEw==
X-Received: by 2002:ac8:7c9:: with SMTP id m9mr30361158qth.26.1556221276558;
        Thu, 25 Apr 2019 12:41:16 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id d41sm14615290qtd.90.2019.04.25.12.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 12:41:16 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:41:12 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [bpf PATCH v2 1/3] bpf: tls, implement unhash to avoid
 transition out of ESTABLISHED
Message-ID: <20190425124112.629571a1@cakuba.netronome.com>
In-Reply-To: <4f0cc6d0-1934-92d7-d2fd-d02ebe5ab822@gmail.com>
References: <155620799743.22884.8046772841813554446.stgit@john-XPS-13-9360>
        <155620818860.22884.14832636768748270693.stgit@john-XPS-13-9360>
        <20190425122908.68b8d759@cakuba.netronome.com>
        <fed3deb5-0119-4f24-9a53-cad7a9b0fcbe@gmail.com>
        <4f0cc6d0-1934-92d7-d2fd-d02ebe5ab822@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 25 Apr 2019 12:35:58 -0700, John Fastabend wrote:
> On 4/25/19 12:32 PM, John Fastabend wrote:
> > On 4/25/19 12:29 PM, Jakub Kicinski wrote:  
> >> On Thu, 25 Apr 2019 09:03:08 -0700, John Fastabend wrote:  
> >>> +static void tls_sk_proto_unhash(struct sock *sk)
> >>> +{
> >>> +	struct tls_context *ctx = tls_get_ctx(sk);
> >>> +	void (*sk_proto_unhash)(struct sock *sk);
> >>> +	bool free_ctx;
> >>> +
> >>> +	if (!ctx)
> >>> +		return sk->sk_prot->unhash(sk);
> >>> +	sk_proto_unhash = ctx->sk_proto_unhash;
> >>> +	free_ctx = tls_sk_proto_destroy(sk, ctx, false);
> >>> +	tls_put_ctx(sk);  
> >>
> >> Oh, I think you can't put_ctx() unconditionally,
> >> when free_ctx is false, tls_device_sk_destruct() 
> >> needs it the ctx pointer.
> >>
> >> I think this explains the offload crashing.
> >>  
> > 
> > ugh yeah. So we need to _not_ free it from tls_sk_proto_destroy
> > do the put_ctx and then finally free it. Otherwise we can't
> > restore the sk_proto fields. v3 on its way. Thanks.
> >   
> 
> I'm going to throw that patch I sent earlier in this thread
> on the series as well. Its the minimal set to get things working
> again for me. Will follow up some selftests so we don't get
> here again.

SGTM, I've been racking my brain trying to come up with a good test for
the offload stuff, because it's really hard to test that without actual
HW.  I don't see any other way than adding full on per-packet crypto
logic into netdevsim or such :/  Trying to lie about having offloaded
the crypto breaks down in corner cases.

> >>> +	if (sk_proto_unhash)
> >>> +		sk_proto_unhash(sk);
> >>> +	if (free_ctx)
> >>> +		tls_ctx_free(ctx);
> >>> +}
> >>>  
> >>> -skip_tx_cleanup:
> >>> +static void tls_sk_proto_close(struct sock *sk, long timeout)
> >>> +{
> >>> +	void (*sk_proto_close)(struct sock *sk, long timeout);
> >>> +	struct tls_context *ctx = tls_get_ctx(sk);
> >>> +	bool free_ctx;
> >>> +
> >>> +	if (!ctx)
> >>> +		return sk->sk_prot->destroy(sk);
> >>> +
> >>> +	lock_sock(sk);
> >>> +	sk_proto_close = ctx->sk_proto_close;
> >>> +	free_ctx = tls_sk_proto_destroy(sk, ctx, true);
> >>> +	tls_put_ctx(sk);  
