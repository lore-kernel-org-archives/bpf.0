Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F80B2EEE93
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314983; cv=none; b=P6cp27PoZ4/HO7ZSPsCj14S8qOOcl37x7dwIWHUvz4UaS53vAMdeU5+alx8CZOiwQuzANfS+QpJodZEzAQtCYD3+ZCSNWRda0GpOjVopHON9BxiGFKbnuYJJWn0hraCIHV/AsIOTmMQuhIdQizNAzKowV2EvUkUiBnM1KEQXFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314983; c=relaxed/simple;
	bh=vURde89sMtWURw6FG+tepB88QIn9K8t6TisozbmFr3A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PKvqi/MollBFtG2oQrGopOV29O325hDxck/sDbpFIUMKJGIeIQWmLguOKTNq8JH/e4af9HWJR5ZK6mT1a5ni+6bvtwbDyWa6+Fu9KHBfUiVw4Pie051fEkT9g+29pND2WGerSnqOMhnrgjIVPzQZc1rVhSZ93PFZcq2zCDk2E3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaoBhxcF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaoBhxcF"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so4161598b3a.3
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784314981; x=1784919781; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0HQ96Vdn4h35OeWau0U6VFgnANMcH6MfT+eFQl3cSlw=;
        b=MaoBhxcFnQhFRaNA2Z+ubiZwfqGUIflOErH8nfTaUsRC4v3U/VBU0OIQOrujGZfFL8
         FX6nL4jB0hduh8Dt1OdeV/mOGdzhc0K85lr5PlFq0IqsmC1XvclKc9LAVs2iXZ2jHthg
         pnRBLKy9Bp6G2AHpUsnb45nVpLxfn5/SiTTpOeb40BsutOo710CJAWuwKjmBAO5Fd8Z+
         INCxVUKFVhEWwNAx5Ddo/hi16GgouACmiInhncxeMb3KrOxGS8ZRlXPCMReWVWpjWB3X
         Dc4k8knde6JNLGPmV4d+5/ddkDFp1SbjtCQXQi5RQdEFwt9gRR/YYXqIYuBW5IOtXeuL
         6zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784314981; x=1784919781;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0HQ96Vdn4h35OeWau0U6VFgnANMcH6MfT+eFQl3cSlw=;
        b=axUgwbx1q8NmsFv2ncZm35giA8p62w8QtV6cFWYN/csKLU0Dzic+nhRNjc/KD8fBx+
         vqX/XdPf7+ffZbk5a3c0EWaz7jSOur2Br35L6dkYvBYUg1fClSlWlPPXv6zXBh0zUWGK
         En1UxfaFSxVbe+6K2nVsOxi18LGz3wo3/8HhwDiXCOyIA1RLvzw53MRuFO6S+ekXBZF5
         nWMvtHHFWN+uKsmTaT6athZ0QR+RYuSAfG0iFV0XBm61cxWSGYuWYV4q5RnBppmE0pb4
         kCAIeG2vUlO9pi24jKX/4qKFnEqZ0YjW5y9TY7FEYvV/Z9y/9cKgnaCQaHxC2PrfZ31X
         qnLQ==
X-Forwarded-Encrypted: i=1; AHgh+RqH3thX5lWZzujSm9iK2i1y0Yp/Ih2QulEXHE5JiYlhFkzDVpzs7iqMlXJSaopUwzQHm2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy38QMF2nOYTDLq6AjV+lenDZY+8fOs5HnC3LZYGgRbo2nyTZ7h
	B4hIZ+IEvNBCwf87MuqL1Lfad+DFgttaczcN/IY5ek+wq/ffWsXAkzam
X-Gm-Gg: AfdE7cl0aVcPJ6AWn1ZJzyOOqNStj3t16iVPZHcVwztXIQBVyUAzDYrYPiuvJ5G50do
	dN8l72M5igZLTN596Q+RQTuM7yyyYHcCjvyHVWTm3Eyntbl5G4CYYAgWHKfkauUffzNas3GTZd0
	eez1t+saY7eNSeUPHQMIMvEbgNBDPuefmR7C1c8LrENZuzWsRZ2gPIfUal96a2NOaigSJXqBs/C
	5uVhApstpUtFiwgxP3vCtw5UxlvO3cDqDsQVH9Tdzkua940nY3lg0Y3sY87OyHRNzSKIX/qSnJy
	ZB74EJ1H4ZmzIu72KUQ5fcEYbgK3J5BHi6cCyZzoMDzzVNWandRTsf2oA/PohWCq2Zj2XFwff7c
	/G4phNlu/RFgVfzWxjgHHG8oEeoCkcV3lWnUkp10ZPXWBbGUCef62YgsMx4OOK5/utIBX5vT6fT
	qOk3Q6HGpPVIFzN/FGkgziwVaWrp0qBsSlVKoE6rpu4I/Tdr5umyex1OsdLw==
X-Received: by 2002:a05:6a20:1446:b0:3c3:954d:279a with SMTP id adf61e73a8af0-3c3ad87eba1mr4515283637.33.1784314981521;
        Fri, 17 Jul 2026 12:03:01 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:87e3:2c3:b68c:94ea? ([2620:10d:c090:500::1:14f3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cd6e6esm7942276c88.13.2026.07.17.12.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:03:01 -0700 (PDT)
Message-ID: <a6bff14e1eaaae768562fb2825693fa3c5568dee.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add bpf_for() benchmark
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 17 Jul 2026 12:02:59 -0700
In-Reply-To: <20260717120215.2171057-5-puranjay@kernel.org>
References: <20260717120215.2171057-1-puranjay@kernel.org>
	 <20260717120215.2171057-5-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-17 at 05:02 -0700, Puranjay Mohan wrote:
> The bpf_for() macro builds on the numeric open-coded iterator kfuncs
> bpf_iter_num_{new,next,destroy}(). Add a benchmark, modelled on the
> existing bpf_loop benchmark, that repeatedly runs a bpf_for() loop so the
> per-iteration cost of the iterator can be measured, e.g. to quantify the
> effect of inlining the iterator kfuncs in the verifier.
>=20
> The BPF program runs an inner bpf_for(i, 0, nr_loops) loop with an empty
> body 1000 times per trigger and accounts nr_loops hits per outer
> iteration, mirroring bench_bpf_loop so the two are directly comparable.
>=20
> nr_loops defaults to 1000 so that the per-iteration bpf_iter_num_next()
> cost, rather than the one-time bpf_iter_num_new()/destroy() setup and
> teardown, dominates the reported numbers:
>=20
>   $ ./bench -p 1 --nr_loops 1000 bpf-for
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Could you please add a few tests with __xlated tag, e.g. as in:

  tools/testing/selftests/bpf/progs/epilogue_exit.c

To verify the shape of the inlined code?
