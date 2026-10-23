Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771152;
	b=d1WBYvsH2Vqo50RTpIaWAIkyWtyrS80XKZsQjuAlTl2TlvTrWiASuFhLs0nBnn0o8V91
	 YNEZ/bJn2ma1birgK6Uy7o8DBsoszE1as2EKx/32U+5DkVKeSnn7UtOx2ajwArynT6Gkv
	 h+1+/GlyVgcEP9sZPmQbY2Lt0/ssfsMh+6RE1nyolVXtEvovB8De80/KXERaifDC5JxGT
	 Yu9FMHVEOiy1bMcmD/qg4jYh8gaFhWWJJWEgWb9NLZMy7iU1giUSciSsN6omgIqA2K4U/
	 1lRIH9Uv2B9BrSziRO8wplFL0GZg9klKYEGYcja4sPy3mKK46bwZ0IuprSkg3+TI25Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=nlo4Rbpa5QmCWecn+jb+dgeDkwh72cCXtNG3YBtAJlc=;
	b=3xdCSviWieUTJaWFzZDyHhw7wRb6UEaqzUiPEAi41magRa3E8vCA1xze3e+wwVvERMJE
	 T3VUv7qgAmAkMTPP3hzVzjSdMARSSyBm3R1ZBUpQaelvyDrW76lcGmZA5UWYUbr3F9+B5
	 ZMnrz1nIp2mLVmE9I5ZpLq2N/fDCwCckjry3hxehgIP8yzhkEvwZlr+dIgYIG6imZ0oPo
	 WpYIDCTKXkQBn3j/vcLSbWULILoM30nZhZQRC0iWTeJmgqqeVc0jOK90QxVcxp7/WgEgC
	 BX6fZGrqu0ksAbWmZPDKJMa+ZRegwH4woaUIouph7SHySd5Sx4ualIDYvZkGvldmvxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H9vWS37D;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7E606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 15:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8F7E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H9vWS37D
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so602758a91.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792771151; x=1793375951; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nlo4Rbpa5QmCWecn+jb+dgeDkwh72cCXtNG3YBtAJlc=;
        b=H9vWS37DzwRcOSAFaiuY3PFfDcMzE0UJ6jlQQRq1fU0lg+mDLs0wT2dHhQ5p48MWGb
         QzI3F5PTmLQoWcvlyxiY6RjCFVTqRJhLek6/p1VuOn/oFAigp7SLFR7xy4ZnXsysrmqZ
         AB/s9x7AjW1fmobiw3Hz6BAFqyhYA8MXdly/4U3uYMn5JLXle/1dLS4HacBjT/ZTYjHg
         bsSAOPleC4qBWVdxAp0otDscF8se1n3cz4ux8fYbz0wTxbrZYAQePftNAAL1XcL3XcIB
         avbAKw/1mGESeGLsNMyrVLaBgyUUqPX2YyX00a2t5ba7pT+6BLNzdw1UNVQPnj/FoVad
         HlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771151; x=1793375951;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nlo4Rbpa5QmCWecn+jb+dgeDkwh72cCXtNG3YBtAJlc=;
        b=TV9fUOcflYI3wPT4X8qIFWmLOIvbKwD3iPl5yJm+A1VfeA/s61hFE+yvPPvOcRfhd4
         qP1N0UIPSasUUVjgAdefpkqgROPEfURKNxhrnkFLbAd1ZU5w+jJV4k2BknM6NCN3Q2/e
         lJwuOXUI3FTFyEaA2NLK6RZUCEPSCD6AX/yu07XRNZBudhefPdUx7s5V9UMIXUfUCe1b
         mSvMLGfK9txBa/10puub0IhXOeZBK6QCuV7e4NR/ktimbVPF/uG6KSEMBf0M552zft/k
         U4C3k16CxKTvffwD3JGlMi3hQ4afFZK4Fmouynfklg7ROHBQi3+mY+LWKNrgPzn3+e3p
         TxKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeO/uK9xrrmaQP3Crs03ikj1Pj8OI4bVg95Q8bAFVnQlgGpvtRIJSCWJoCaorpZg8Q98k=@vger.kernel.org
X-Gm-Message-State: AFq9FYI068mxXFnXmIYUDclEYsf3tIdcB+mrFvRMoR+By8pZo1CovcsV
	IwnOvr24kIZzCmBmMLnWTQrHqYl/Z/zkHyd3RcUlYOGXl6mnCWZE0VrZ
X-Gm-Gg: AYBFou32XpFRBM2o/xP6i0JMz/ClR6skOXMY049HSUECWB1RoEl6s5VSYlmSNWD0txg
	Tud7rNuefYYRiZgAH/hBGhsbWoAovfqTJ9QWFDPPtlA7dD6yCfp09jBvysoocs4TcyEWJ/ew8z7
	TZg1BRiCWVs8JsWqW29BY1IeCdtAHr9nzzlIquiTRVoKQxJ6gKk+ZyfbcYPKwQ4UC4Ohjq7x3wJ
	TESVK4hB+VO1IzsQq4kKVWYQVAZu9Zk0DZSFxn//mhqa+H7zZrouEDcyWHYdrTFmRD/GeDLn6eV
	uTNSpnzaFdZufwH3r2oBAuZGpbE7X5ROj4QdJ+acx7dWnDBvqVlCdtk9Bk6VGlRKOpXn15qP2zV
	krS1msPOgvopBG60AQ9GrckuQodxnDB1n+OxypdjleCpz6E1rLuvmURIl3lp5A5cp8pSn0yOlJO
	fnka6TBUOTN+h+JtJGiIPfoMJBgchkB+Efr465UiLyRt8xV69Tf2dTgA/1rybf3XEE1PLOJVhub
	zAcU7RdAsBgL3Dy3LRRgEWk8/sSIIEjuHXxmAdxyrX0jNk3vLUvsimoqXevmRKWU/7QlGUM9fE2
	hutkvcc/J+Gd+tTjjRbpNDlan89xC+V2BuQL8JxCGulR/VRq4Xb9uHUIpryK
X-Received: by 2002:a17:90b:2752:b0:3aa:fc22:8aad with SMTP id 98e67ed59e1d1-3adce7cab6fmr2434265a91.54.1792771150833;
        Fri, 23 Oct 2026 08:59:10 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3addd7b5a46sm742463a91.6.2026.10.23.08.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 08:59:10 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 15:59:10 +0000
Message-Id: <DMCCC0KHY4VC.2O9M91KEVRW0J@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapis.com>,
 <ihor.solodrai@linux.dev>, <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] libbpf: fix symbol resolution without .symtab
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zateev" <hackerowskiy@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261023141040.249597-1-hackerowskiy@gmail.com>
References: <20261023141040.249597-1-hackerowskiy@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Oct 23, 2026 at 07:10 AM Eduard Zateev <hackerowskiy@gmail.com> wrote:
> -TEST_GEN_FILES += $(TEST_KMODS) liburandom_read.so urandom_read sign-file uprobe_multi
> +TEST_GEN_FILES += $(TEST_KMODS) liburandom_read.so urandom_read sign-file uprobe_multi \
> +	uprobe_multi_stripped.so

The test will fail in test_progs-no_alu32 and test_progs-cpuv4.
cd_flavor_subdir() does chdir() into no_alu32/ and cpuv4/ and only
RUNNER_EXTRA_FILES are copied there. uprobe_multi_stripped.so is not
in that list, so elf_open("./uprobe_multi_stripped.so") returns -ENOENT
and the first ASSERT_OK_PTR() fails.
'make test_progs' won't build it either.

> +	if (!ASSERT_OK_PTR(link, "attach_uprobe_multi_stripped")) {
> +		link = NULL;
> +		goto cleanup;
> +	}
> +	bpf_link__destroy(link);
> +	link = NULL;

All three 'link = NULL' are dead code. Nothing reads it afterwards.

pw-bot: cr
