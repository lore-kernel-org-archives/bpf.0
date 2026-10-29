Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291754;
	b=U5FMUM/IaIp3Qds64IUMv88UFOJyf97h+dx2Tz7egvq/VwQBa7EriED9D8Hrx2CFcLDx
	 TsSXBtt5r+rRvM/ZQXy9fBGaY9HScvtjlMIrXW88wg3n7vBTuzUrkDxA+5wL1OqsSvkkB
	 6qg068S9nTKqYMzNw1amhd105F7h2dAqgTCSQz2MyxUCvmK4iLcMuO7Rhn2IUCJvLOEuQ
	 r/4rwhz0d5iPI3jcSeZ5eVAggRxDDIjegt/CP8yZvHe1rcQgVwcWYVShp07FAoNjV0Zcl
	 O/w9jbZTjqcPwgqlh5gaxOUlmUhBEir/E5GsfBRFSvaYNLqaNGQuTHjA2DHMaqv2aEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=les2g87PSHgvNrrOSQca0MPNOKPP1t4sZIzgv+XDxaY=;
	b=EUn7ghZ4LUprRLJna9xDrC2EfcFGZ5zDUnRRg+rD0OrD3CBecCvLazHEgOzj3AbwCcSn
	 xjY7Qti3dBW3ssnDW/76CJXN8Q11AExL64VgBi7shJVzx5KOGXSYhA2qYCSD6aLk1Hy+q
	 nWIYGQceqqQ9aU0jy5y22fH3HJN0LDKElHHvmv/Quoh8o3ZjkZPci7l53Gh7MxCfYG6z7
	 QVUPtCVbXZ5ZX5iqa1+SnLN+mtRKtGkndP6flWjKc9YsSFFIxnBwdC6prm8juXDqeUBZM
	 nl99hAQrhl/+zU9hGNrQUkn2e0JilhDG0gVc3aWF8rwItKPVG/11AgLlRU8wvFbXsMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Isc/nwI9";
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573A606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3573A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Isc/nwI9
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd8ca57ef64so463570a12.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793291753; x=1793896553; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=les2g87PSHgvNrrOSQca0MPNOKPP1t4sZIzgv+XDxaY=;
        b=Isc/nwI9X3oBw6g+hHgW2ESomBs2zEJXw028q1i2bf/9Pn6gNEQ1C3sn+HYXMn+YKw
         2SKlkNucmZQxU9biihGCWYNB0QG9BMs4mt0M5Nf0FOuw9AqFCDoQczWLwdkXKkcQmAxx
         BHdB7XyBCxbYfsUMmKDV4ndDvf+soRYXkDKkan9Ga9ETpBG5p6kiIXTtZkBnaP3//xH0
         vhH3nNEDR34BL7Gu3Xz3PnUQAqoc8lufv+AdDQKrLO5oE+OTqzFWfh6CvAndB9XUxnlt
         0c6MOv3Y7fyOo9jeFZaR948lacxNxRW05Noue4EwY4oRBaT0FvuhM21vexyatF9d/hxg
         pIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291753; x=1793896553;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=les2g87PSHgvNrrOSQca0MPNOKPP1t4sZIzgv+XDxaY=;
        b=jhUpJ+U8zvjqEVUJoZGnvFwTvAbJiav8RbGO6EEU2ap4c4uTIE/tlWOWqoocTwvay4
         GxW30NcOkPalFX09b2mfzt+a7EnuHK4AIict8yLCEtJu9eTrGICuodmjSQkDKWjKUKDf
         EUn8Q82f9/WA8NXLop/pvn2rQVTG4+bdRbct+XWvXjWqJGOhMR98FkJL4V9ApCeGLeGz
         6nHdEq6rfzEqxzgVH7ZIOj4JKB7rR3C/e5R8Pm399XHj59L9A5KdiDCLfXuRptanf2uA
         6QEaRKKmqQjkuEZQTVrqn6r6TG10GxIdqun9crznBx8usgG9Cf6JovBUnDF4Jp2cf8b+
         rebw==
X-Forwarded-Encrypted: i=1; AKwUvBzhjx8cLxMuOd9kS4Lii1qX0/ISvtUeXi/XHta0Uh6icTBOb316I3jAyVR7fgbZ8ePn2UE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQnTUsKUGH2fl9a208qzIcnpGTcWzFfWTFXkHjq+bpJXrBQFpd
	MJ+mgbZ2zJrjhxLQlrSKzqAJaHQ7CiDaRApeHG48fEtPFOem11u1TdQd
X-Gm-Gg: AYBFou2/K6bN5Kr831BUBdu+9cCIZfzM9JLTL2YH/HGmWaRk/1aKKTjoMFiGIFr8VP1
	hvz6BCYzhRGC3eIHUOqjcoa7GmM5iKf37VeoHDt8jLDOLDDQBiaTNbG2yZlM5M7mUd9uWpLQQV1
	ZwDTe5JwzIy8HclOcT+4Qv1PuZqKbfzDrlwVPcdftp2PECgZPOwAXpAumMlSRxug5gmJOEH7fIb
	K1mSOGL9gd07Avut4ScABG/PMpHsayjQOXb4g1v2WaOksSIJjsOTtGWmu+Rtoi/2nhqpif5+2eI
	5uTL6cQx3+AOaDKnlWcbg0O2hDJyD0mtiu5Xdx4U7Ry9jS9a/8sR8uXPzXk/lLtJVUVsKEwF6jg
	SI7EXLLSwj8mmMWr4EBKb9Smnqv0bontGazEE6MDob+931RcCW9bWqGM2TyBNydqg/zgG2fkt/N
	1qzD33lqSnpVekPtIVtVGr+slQ4x/EBoC+Nve20qkIUG+3fST8KEKb7aksWVsVhOiAV3DhNYRcf
	C/f0NtQ1ll7/kN6LUiNRcIj+iopmAs0ia+uFQ3KoQ+CWaE7ABdwZlNpK9RyRboZKEbMDX6tCtPc
	Ce9OOF8aB65Jguc30LlzN3VKueOT7FbpNgXWiPuIAL0GDZw8G8jyADB35GsC3cR2rDjVMk8xOkM
	diCF3h7QIShyAdeONEQeqUAF4ssew/pQbSQ==
X-Received: by 2002:a17:90b:1dc1:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3ae6ed6bd58mr1816660a91.30.1793291753149;
        Thu, 29 Oct 2026 09:35:53 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98f888sm4850133a91.13.2026.10.29.09.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 09:35:52 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 16:35:52 +0000
Message-Id: <DMHGVE026N3I.1V3834R8WLSYB@gmail.com>
Cc: <rostedt@goodmis.org>, <andrii@kernel.org>, <jolsa@kernel.org>,
 "Menglong Dong" <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf v3 1/2] x86/ftrace: Mark jmp mode by clearing bit 63
 of trampoline address
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>, <bpf@vger.kernel.org>
In-Reply-To: <20261028202345.1215859-1-daniel@iogearbox.net>
References: <20261028202345.1215859-1-daniel@iogearbox.net>
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

On Wed, Oct 28, 2026 at 01:23 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
>  static inline unsigned long ftrace_jmp_set(unsigned long addr)
>  {
> -	return addr | 1UL;
> +	return addr & ~FTRACE_JMP_BIT;
>  }
>
>  static inline unsigned long ftrace_jmp_get(unsigned long addr)
>  {
> -	return addr & ~1UL;
> +	return addr | FTRACE_JMP_BIT;
>  }
>  #else
>  static inline bool ftrace_is_jmp(unsigned long addr)

Steven,
the code is the same as in v2. Only the Kconfig text is gone, as you asked.
patch 2 is a bpf selftest.
Mind if I take it via bpf tree?
