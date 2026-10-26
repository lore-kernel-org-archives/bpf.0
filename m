Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.240.27.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792974487;
	b=SLz+5NIYIgFdAmyjoKRCb64OS2fB4In9j2Zp2fvAbmSqSOF8+LUbjv/4VXxXhwQNtAyb
	 XhspkvL73VeIrJjRw4OSC1rKqp4OzrBXRzLR4Nb32/zxguu/C4mgDKto7GWxCRNja1nv9
	 2w4tsDhy/FMDI2G4mRBv9Ximy9e2SBTD9ORlMKVB4e19XhjpMvrol/VvaeS6/lCSaFX6q
	 PrGT65piqpB160uTHUsOJNIBkKCtHDmda/VkzqOOEIR68pMqYgztBNWV8UgYe+F010DZt
	 fwWnI3uXUkW9d/FZSYACDuc1jV9alrIponF++vCkrKUiWjRYVqjSopsRhzVIHUbZrCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792974487;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Feedback-ID:X-SES-Outgoing;
	bh=SnH8JE59vFBbzoP4MnVT/o0Xt6ltmcPnihBt2i/fRG4=;
	b=RPvIypQOOai8LlAlVvHIldO4zs/W53R4WVfnlr8PA5UQSlbPr/C+9Ms4HIIX6gsOMoGD
	 kpLLjcFhEOfEmy1B6rbplgz+iVp2vp065WPH/L9VTgh1/7i50XfDzEQaQA0UUzrQK/B9h
	 2YazlLrH/5XGUvmPKJNPF9Ds1G+uBg0ezWon5bj4/1LlqBNHdc2XaJD2dpBgIEjYKX0pr
	 zlnxjXh8PpPtLEWC5JjFiBQG8PK+gg4hp4mLh00sZ4sU/sBdbcl30jyHnhUrsEgRPEWZB
	 ++evRTU6V/u7j4Wiz6IUJtmbV2ALBFxzaCjr/g8jHYfK9sJPSL692uqknk36kQovQNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eliskeggs.com;
	spf=pass smtp.mailfrom=us-west-2.amazonses.com;
	dkim=pass header.d=eliskeggs.com header.i=@eliskeggs.com header.a=rsa-sha256 header.s=5wf2ig6m4xs5fvcu5nmk6zmaekj5twpk header.b=Gjvb0ej6;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=vYJ21Idr;
	arc=none smtp.remote-ip=54.240.27.22
Received: from a27-22.smtp-out.us-west-2.amazonses.com (a27-22.smtp-out.us-west-2.amazonses.com [54.240.27.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA832606A31F
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 00:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA832606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eliskeggs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us-west-2.amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eliskeggs.com header.i=@eliskeggs.com header.a=rsa-sha256 header.s=5wf2ig6m4xs5fvcu5nmk6zmaekj5twpk header.b=Gjvb0ej6;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=vYJ21Idr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=5wf2ig6m4xs5fvcu5nmk6zmaekj5twpk; d=eliskeggs.com; t=1792974486;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=Cg0GzzdMILyjQSBXKShDkjEip+lcb6hj9MZd2pFrNSI=;
	b=Gjvb0ej67lSAmoRdo5iejH3tgsjaMdXrL98zUejv+Uu/ky8zt3NVH2RF+D8FWvuM
	XmCt398eVBYujKXM6UYxv0j4VAVfvGw5kTRYsukNXEJZ2qVozHwSk0WC1KYXniW7OAp
	eCGQB1oXXx9X0Jm6UWtm1bISJWogbBpwsiKkwt60=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1792974486;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
	bh=Cg0GzzdMILyjQSBXKShDkjEip+lcb6hj9MZd2pFrNSI=;
	b=vYJ21IdrVkv1J3O20TXR3c/qLsqRLn8bjljNCLNK+jkzuXju5si/rA4k51Of0InS
	iNLm4Ei478dDe6zOGvE2WWFShXkHRW/ahW+mnRBk5EtDPxUq68EvYiH/YCzI01jpA5D
	qvXd9DuGIAi8UZ8j+lMoMKUsWoK7EODW6huCPxCA=
Date: Mon, 26 Oct 2026 00:28:06 +0000
From: Eli Skeggs <kernel@eliskeggs.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Redirect a bare FIN to another
 socket's egress
Message-ID: <010101a1759b7ae8-df75d095-c70e-48c8-b611-eaf85a566324-000000@us-west-2.amazonses.com>
References: <20261025-sockmap-bare-fin-v1-0-bb8feae7c4a7@eliskeggs.com>
 <20261025-sockmap-bare-fin-v1-2-bb8feae7c4a7@eliskeggs.com>
 <sashiko-outbox-184525@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-184525@kernel.org>
Feedback-ID: ::1.us-west-2.aEUYuRRC8Z+WeC8mlWAQBpqJLV0VswmaEnHpVsice/Y=:AmazonSES
X-SES-Outgoing: 2026.10.26-54.240.27.22

On Sun, Oct 25, 2026 at 11:55:07PM +0000, sashiko-bot@kernel.org wrote:
> > +/* A bare FIN turns into an empty skb. When redirected to another socket,
> > + * verify that it does not break the destination socket's psock. Data
> > + * later redirected to the destination socket must still transmit.
> > + */
> > +static void test_sockmap_skb_verdict_redir_fin(void)
> 
> [Severity: Low]
> This isn't a bug, but in tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> above test_sockmap_skb_verdict_redir_fin(), the new multi-line comment places
> text on the opening /* line. Could this follow the BPF subsystem multi-line
> comment style by placing the opening /* on its own line:

Thanks. Happy to fix this in v2.

Eli
