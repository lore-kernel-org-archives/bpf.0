Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ADEC43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C31120717
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qkU2+Zr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfDYT3P (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:29:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33086 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfDYT3P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 15:29:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id g7so1502546qtc.0
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 12:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=V64eqLfnNiiUQhGeCK2Ks+H0ucLAHdDbqBo2j5uTyg8=;
        b=qkU2+Zr9gZ23xh1GtWk5K+0eMSqUoi7Kt5sc3YYIxMqTyONzmuY3V1AH5YoKaUO4M5
         hyi2r60YEwkupMBmmi1Svhdwn9VrgluiCCzkx4X1K0Sf26Ghr6Mzl4yLAeFi6NkQtssm
         8azwHGN2CzGyPX0suf1FxD/v2q5xLPGLf37ImaXP0VdVNoC9ELhWp8t8Z33oNgHuZDC/
         vYlhjAdObjd/161i2IRUZCOEz180LdMZ6BJihLJ7qEwAiszmTmOOI/xrRZ8KNJSYdMJH
         hPwVETg/nsMBI1J54x5J7tiaWt+kh124CLvue+qFjr4LnHvNIZgW/KgJZBQuujhps8fm
         pEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=V64eqLfnNiiUQhGeCK2Ks+H0ucLAHdDbqBo2j5uTyg8=;
        b=DSJzt+25LiUst3tr49LC3TYIOp4HEomSi2qWKaUYGiklPyCFLQ+NC0qi1FBXzan8zv
         BVk79pClS4BEGnzZvBl4AmKeQiV1mlvdNCYXXOGJyDN/Kzir9BLNbdSAovMNdnGINVs+
         PJsl4t91EfLLqPhRzT1vUmyRxLIKlb7Y5pwYCFHmd7Vl34NZn2VFRNY/8kIONWui/YFb
         xQR/SyhOSe+CdRNT45OJd05wSoDuXnPrV2G8gGXy/Ut+CAvJNEj1/5Y5+FSwREhIx3cX
         oAno+RlCh62raEXoR8gJF2dzrYTme87HnEyGMfhcU8mfADqUXj8nTfcDGtlG80LTV2NP
         ZqZA==
X-Gm-Message-State: APjAAAVDN+moEkKjcpeCNKdir3vUvjnVYXKpNFaBgl7cJMsf9mO5hcew
        VQicsraA+x8EJrxlnQMd9WaGlCLuBps=
X-Google-Smtp-Source: APXvYqzr64xQEZ0SQNq577Ao+orJEyS/K6OcMVY3aGT+8NQp/ngcWT0HmLvG75q4fdfGJRId4ZTxCQ==
X-Received: by 2002:a0c:946f:: with SMTP id i44mr32642850qvi.113.1556220554065;
        Thu, 25 Apr 2019 12:29:14 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id t188sm12250678qkf.81.2019.04.25.12.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 12:29:13 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:29:08 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [bpf PATCH v2 1/3] bpf: tls, implement unhash to avoid
 transition out of ESTABLISHED
Message-ID: <20190425122908.68b8d759@cakuba.netronome.com>
In-Reply-To: <155620818860.22884.14832636768748270693.stgit@john-XPS-13-9360>
References: <155620799743.22884.8046772841813554446.stgit@john-XPS-13-9360>
        <155620818860.22884.14832636768748270693.stgit@john-XPS-13-9360>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 25 Apr 2019 09:03:08 -0700, John Fastabend wrote:
> +static void tls_sk_proto_unhash(struct sock *sk)
> +{
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	void (*sk_proto_unhash)(struct sock *sk);
> +	bool free_ctx;
> +
> +	if (!ctx)
> +		return sk->sk_prot->unhash(sk);
> +	sk_proto_unhash = ctx->sk_proto_unhash;
> +	free_ctx = tls_sk_proto_destroy(sk, ctx, false);
> +	tls_put_ctx(sk);

Oh, I think you can't put_ctx() unconditionally,
when free_ctx is false, tls_device_sk_destruct() 
needs it the ctx pointer.

I think this explains the offload crashing.

> +	if (sk_proto_unhash)
> +		sk_proto_unhash(sk);
> +	if (free_ctx)
> +		tls_ctx_free(ctx);
> +}
>  
> -skip_tx_cleanup:
> +static void tls_sk_proto_close(struct sock *sk, long timeout)
> +{
> +	void (*sk_proto_close)(struct sock *sk, long timeout);
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	bool free_ctx;
> +
> +	if (!ctx)
> +		return sk->sk_prot->destroy(sk);
> +
> +	lock_sock(sk);
> +	sk_proto_close = ctx->sk_proto_close;
> +	free_ctx = tls_sk_proto_destroy(sk, ctx, true);
> +	tls_put_ctx(sk);
