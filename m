Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794844991;
	b=tu3Bg+0al/Aka3G56xxGCkeIyPdFo2TC2uy8HmsALYRV6QsLohK9ayBIzakewKk+Pxg1
	 RmGGRZyR0enCSlU1f82exNQR9HkNXPDGFQmEPnTr8ps6ly+nG2RGf1MfDEB94/tYFihDK
	 qMPT2JN6mzw91CcblKcKvWxu5dhvQ6nxAeJtqfByF5pEW+StxMzOwmbSmkhSfdq6aQXX1
	 BrCnPihFFS5MCzdP8ReWr0xlva8c8qlaL65A5OX+SV3gG2S0+NosfGXlQo9c02MYLGy65
	 7AJlmatM16B54rU58vG6/q1DYZ+MNXcpJe7liwEou4gsrWxUee0QGqdv2I8BOv0qKEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=75pkuYW/tk7J9Bw8nfex7DohVw3/gs/HE93Gq8puzEQ=;
	b=SThDrvlqreK17gPjf3bysCAymOM9MW8NMXMMzORPhJRU9t6pmaGpDSq+wKSSSlQi7Lla
	 xuW5F+MLvKvuCVhWq2E+EqurCaQZiOY+6sQf1h2eJ/fUrdj8JE5hehva6Tj/fcqVwjZ/4
	 Z5p57o56YJYUoXR7GFdGGqV1CM9JyTxyzCforUuu/pSGbH6LM9Em2rZo2JFFW+CHcwDO2
	 vNaUEgLN31f1F15nnqlNF8fTZglbs2flgejBjFXv0l3k+yijisyoaIi3zw+wD9bOz2R+G
	 u5PHhj/bNLyK14AwSbPaEe4lLXpsDwEz6qiyJLmcsYJroy+hhdNPQfIroGXGHHf5heg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j5+qfPZW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DDE606A334
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 16:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9DDE606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j5+qfPZW
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2efa9addec5so5770365ad.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:03:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794844990; cv=none;
        d=google.com; s=arc-20260327;
        b=i08+xx8m37RJuHHWXMy0+DaqB1pHH9GkcU4RlR11pqlSz6FHoThDUqkMQbUm7f9Ni5
         CX/3L3SD0w4rARKgZ5DbQnjA+ogF2DdbOu41ZcPeBcu80WNccMbdHEjf+weBZPIBqVcA
         OlkjR+UDt6c3+6GiqcLZyuilqUcD8nPDv6W3/FEYA4YFQgU4vnZn3AwQlI99PjqZFTqB
         Ta8AXEl+7UB6Mnhv5IYR5QXmph6y3W0EF380ZtMvzx14FPXE3HAgSYA94PO9wI9Ysyeb
         0hOX6wmO/3OdGo9Y4syg6LjwUHQVMLJClI1+NJvc76qR8ZdaAslVd6zouIHNgPcNVL+f
         a2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=75pkuYW/tk7J9Bw8nfex7DohVw3/gs/HE93Gq8puzEQ=;
        fh=NFkKrnW2QdHJ0favwN3CrZQK8ewtvGC0GIwf11Uof68=;
        b=Nxji5zu4Wr5lfSn6jggWreOMJRfSTzPz/l6WQGoblZw5ieVt2ZTnojaAG0cz+rcAIF
         4wpplh0lVcp+4dXBZUpW7ccVIb8E4ELKv+vc8xlLvev4MSL1Nae5usiJHsOLbttzgj7d
         g8NB12NuneZ+ydi1jkmP4WIm+77Wgu4Asp8FpDlf2xN3sZ0GwawyScRVGr5hqx6tH5BI
         XGgH2rVwuAzfnLMZvr+dKoyZdxBUeepcB2vKBSIbVDtkahuZz/OS8abHvi15YblUQEkL
         Lrvs2XueknnCWjOOdXYuX5DPxfY450VtCFGXXSH6WVUavMHuN4dOqieYFoxht2UjH0zs
         odFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794844990; x=1795449790; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75pkuYW/tk7J9Bw8nfex7DohVw3/gs/HE93Gq8puzEQ=;
        b=j5+qfPZWt2MiR9AwyGnuSWff4kqLNf2XZOiwJnxZ+Fv0u1xxF4OIzba8auw2DFGria
         RUb2lc0JvJCxRj6Sp5wd8n8GN+fVHAzINHu4GRUl3yu2yHMI501c4wW2crgydaFx3jsE
         lSM2odqPpPWNXbrGAKXoPpmlZw5EaXH1hh87buKYcgSywRmFBtM4pSnPlvXkBQe4++xh
         0bQTuOm9SoWLQT8EZjRSo/DtXDY558fBXgN3Z+o+1TrHGsvMJ7HiAuWun66rYU1dHnWs
         VXb+7U5JpdSFegGhqgYMC5nLUFcvstgH/6u4ood/1y0JA3IoK1AR6cJ1RlH2vVzkS7hV
         zBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794844990; x=1795449790;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=75pkuYW/tk7J9Bw8nfex7DohVw3/gs/HE93Gq8puzEQ=;
        b=XRa3FfA91QAp9ow/gwWfNyqdoXu7oKUI7zPPLfu1785lFwtlyXeswYz2ck3XegmlST
         J+ETOVUC8CuGQOUx4Xl6EfxTeDitsD7lvVdyYUsiSOF+yOjE1xAf+srNoTb6yFLG+MPy
         OHrBpX2H8zGwdWnmzYC2jrHFvmkjl221qwdzI92iriZT/E8P+48Giah0HAyK1ShuLY+1
         LqJLIlJ+PRY0TPV5GNBozAhY4WYPtjru7m/aDPWKwc2nTcA6M999zWfNK8izYtWYpUNL
         NrDiX5RIcCuXhKI3Oin/LhcsxzmQzWITyyOe09Be3zHNk+T3JsreSAGf0YfaNYQsZAVS
         nfHw==
X-Forwarded-Encrypted: i=1; AL+hErH9jdQPxaPteWf+LFyitZcCXWu9qRe6nuf75l4lS0pdffK77xdWXdF7WFMVAoU2VQrbYHo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tyHUoxIQt/J/FTa0aPgUb9+pbPzXUJnPE8enWWDX1bm3tGbFs
	80Qx2/mZudRVbcpQppgYuKGLq7LSKy35+/vNFDC687A9cNgjKwy4eWVXvkZrABGkPmR0FlaUL44
	EfUTfoqizRlTUAwugcE6TjNdwzzHCXnY=
X-Gm-Gg: AZFdTZfS2TpPxs6XP6tGsJ2bWQaK4YJ6izBLDXQ8RyC72RDAB37bsGJWVTGWuukCqua
	Aa4qUkytPKj5ZHO0BveSZgmeBJagLAYqg6jh0KBRfUEmGocgykJg5VQ8e23gZHLvGG0nc/TCwJR
	W694HG/dm3GFBNlLaj4GYHhd48FZKMRuwldxVDqCrBw0jjHQMXAk5zVbKYJF9Fl/wMEfnXklFxg
	HtIU/C3MQBcTkunrEnikDpbMhOzb29GZsmYaz5viUYNOVn4Ng9u0oJijRAwxX/A6IOsXwWOtDSn
	tK330x4TUsXXL/HXQJQG4G8sQZklH8bsmMoYTLPJQ8fDaEbOrfu6lZwkAQSuypLmXbYWGlkJ4kZ
	AgMcc1CtPM0+aLnv3aDtxQ+GIUP94Fp5dmkFhw+V23hQ3rE+bFvvEx00FtQf9EJCdorJTNXMjZ0
	guWPVERhR1V2HhQ9qBcfGkreLiQ+bA4LPOnDPyzBshXcT9SBo2DxGv6GEj
X-Received: by 2002:a17:903:3c0c:b0:2ef:d952:4a70 with SMTP id
 d9443c01a7336-2efd9524f10mr160655ad.15.1794844989621; Mon, 16 Nov 2026
 08:03:09 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <avsfpHqbu_rdmOrf@sirena.org.uk>
In-Reply-To: <avsfpHqbu_rdmOrf@sirena.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 16 Nov 2026 08:02:56 -0800
X-Gm-Features: AclHuK8Zde0ypoKNoy9FjTToivHq-RePvO_-KQS7SMLakIHz2MwjMtcG0NQBgHE
Message-ID: <CAADnVQKjK2ezTcTUfQLACJDBLzhy=aBvoiK7L1cqKmb5RE40CA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf tree with the origin tree
To: Mark Brown <broonie@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Sergei Nizovtsev <snizovtsev@cloudlinux.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 16, 2026 at 07:22 AM Mark Brown <broonie@kernel.org> wrote:
> Hi all,
>
> Today's linux-next merge of the bpf tree got a conflict in:
>
>   kernel/bpf/bpf_lsm.c
>
> between commit:
>
>   ea8c4b37b8809 ("bpf: don't mark namespace_init and namespace_free arguments as trusted")
>
> from the origin tree and commit:
>
>   ab86b62012b9e ("bpf, lsm: Mark backing_file_alloc/free LSM hooks as untrusted")
>
> from the bpf tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> diff --cc kernel/bpf/bpf_lsm.c
> index 468e63dbd922d,f39a3766f2245..0000000000000
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@@ -411,8 -411,8 +411,10 @@@ BTF_ID(func, bpf_lsm_bpf_map_free
>   BTF_ID(func, bpf_lsm_bpf_prog_free)
>   BTF_ID(func, bpf_lsm_file_alloc_security)
>   BTF_ID(func, bpf_lsm_file_free_security)
>  +BTF_ID(func, bpf_lsm_namespace_init)
>  +BTF_ID(func, bpf_lsm_namespace_free)
> + BTF_ID(func, bpf_lsm_backing_file_alloc)
> + BTF_ID(func, bpf_lsm_backing_file_free)
>   #ifdef CONFIG_SECURITY_NETWORK
>   BTF_ID(func, bpf_lsm_sk_alloc_security)
>   BTF_ID(func, bpf_lsm_sk_free_security)

Thanks. The resolution is correct.
