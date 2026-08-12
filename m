Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB73264F9
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567335; cv=none; b=k0vhm0vPxfoadszzi4vGKeMK9zp2BGleNJL0H4qjbaqemLHHKZ9qFuyQBpjefaj7QXdW3j3L3yWCfsySSeJzUksMrn4Vm2061q88uPap3U/xjhQGEv5HszDNr5BzzmQqdiSOCacXeP0jPZTGmwFOF1R1MQIJ2FNBprvbK+GVNng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567335; c=relaxed/simple;
	bh=vSnucZxx0thuoI++qe64iBvrncmh1lJb9SBslwOAiFc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O36dKLWPXLU76ipYAZHkeHfNcAFqMLk3hjFTaVlgbyFchp2gFHf2+51piNuTUk+JvqJY55whCDhee/xZFUJDIFmPBYOQ2c4YkgoiRkaMdE1Yqa7v1nYdotzwN1lBC7N5qe2tJI6sgLF/funRhSzT0mrKzyjVTGm4lkbGdEFwRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElFEbKAZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElFEbKAZ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381b831d535so2463696a91.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786567333; x=1787172133; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vSnucZxx0thuoI++qe64iBvrncmh1lJb9SBslwOAiFc=;
        b=ElFEbKAZaZ1Dw7j8jOUwfZ3+GBS5LjFkYa8SmuRld5QWf0sdexbRJtyrj/yqew/gdL
         enfMhwGFDsYUSWCwn/oCPj2gktyq9R2ADjN19SjhNngBdPsDl9QZsc1qsNt0decxATh/
         kNr9PfRM9wyyuJvZ414kl6RJ7R/KauJZivYAAF3sRG2Izx+f0LMUl0fwxZkxQAV7gryb
         /pWRU/5twvWk/bFScqPCLOVnMUwH05BhbXfLga9xmEhhdin2hx6g1LaZSSzBIfuKV6zZ
         A+w3Xz+XJ7pXB6U4vdKFPoXU5XJJGOBI/tufIWovU28DODXmW10xy45ee8yfHMyN/8JZ
         yoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786567333; x=1787172133;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vSnucZxx0thuoI++qe64iBvrncmh1lJb9SBslwOAiFc=;
        b=J6V3lbL+FUiHlOT8kxgyeGgVxGqdzKKzyAWK+yTRAv2o1M4cUjoQsLd+toRqCFV8W3
         4+PmQfMLTqcR/gUdafxgAST6cvIUo7mkvPxaVtNNJuBlGlYI+VcunPcJRt1pr0jbdTLL
         twlFUhIrjJyOcgYSLJu8I0ZwErXHHYoCEfdFhTIZm4h1KTJ2Nq03qwtFbeeIYFEcvWJe
         E6hftFtTEsQHYPiTQKdFB0E//8xKhy3/2VtoFdaafy5NRWIvF1CLi+KQHk46cBQwvAXm
         fL+f3Z/eL2AHOfZbRL5gHY/novZbUQegWDBulaziZBtjIPVSrivHc+XQLN4REWhDDXar
         d4RQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOffCrtnIM52g5Uw+SSo5I2WexGcqMgNmqmv03bonci9rxld1Sx1Q9+7nDfrNamRdTnGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKlZlM+Xaeyae45q8mzpXkBrjdxwV5wVwn9llPgu2xDYl6r8Bo
	FbW5v8qR3bx0h09TWoqr/WtYaGJRgiYF9iXmGWum+TVr1pLZdFTdGXsg
X-Gm-Gg: AR+sD10KFpoI7scHj0Rd+/vvBgIPBWSpA7O4bWeyZsjWYkHjXub7njJkyDn76lJwAlk
	fZV203rICsmUUxLn7efEcINcP/B7H9eyBFH9iIiK3ul7HCRMHWq9vOxQcTTUAy3EbvBjwQ3NryA
	gbrGb4tPmrMx/UKet1AAkfjrIueB8kICzUh/o2iDmHWe6f5M4oaan14lBSl1QmnS3+WR1o/OYjG
	QaiFASG57cEmKACkHijW3WfA4p86thB7WZCLSm7g41wnB4yTd3T0rJd4V0u9zUzzuUNs5tvvby3
	ebffmC/FEcLom8mHTHHfMO6cqNpBrsfIJ3XdjMkESsEDIzGNPPQ/PbMVoGq6SblGn9hRXK5bN3D
	qCx941PmzkS6JpMbpHm43/y6HmrJIbNO17WqK/In3x8Nw6X0fvVqb34gLtPllpMieKcMDBf7hEg
	XSrB+7ftZ+jodE7vEBXJUKOzzAKK5BLNalBBEK6qTwUyP2eqbRxzWGryktzsk6q76faxE+/XEh1
	sHt/C8V7oNmxDs0l8i6SPUZ3Uk=
X-Received: by 2002:a17:90b:1f88:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-3931e26fbeamr1143443a91.12.1786567333036;
        Wed, 12 Aug 2026 13:42:13 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931cce8a3esm794247a91.1.2026.08.12.13.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:42:12 -0700 (PDT)
Message-ID: <925e8941448f47a3db4ad6cc390971c3d93f0407.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 03/13] bpf: Wire up JIT support for 16-byte
 kfunc returns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 12 Aug 2026 13:42:09 -0700
In-Reply-To: <20260811000927.2380571-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
	 <20260811000927.2380571-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:
> LLVM 23 returns an __int128, or a struct/union larger than 8 bytes and no
> larger than 16 bytes, in the BPF R0:R2 register pair. The previous patch
> taught the verifier about that convention; wire up the JIT side so that t=
he
> second half of the return value actually lands in R2.
>=20
> A kfunc returning more than 8 bytes hands the second half of the result
> back in RDX, the native x86-64 ABI's second return register. BPF R0 maps =
to
> RAX so it needs no move, but BPF R2 maps to RSI, so emit a RDX->RSI move
> after a BPF_PSEUDO_KFUNC_CALL whose function model reports ret_size > 8.
>=20
> Placing the second return half into R2 is possible on any JIT, but it nee=
ds
> architecture-specific JIT work. Rather than requiring every JIT to
> implement it at once, add a bpf_jit_supports_kfunc_ret_reg_pair()
> capability, defaulting to false in the generic core; an architecture opts
> in once its JIT handles the R0:R2 pair, and the remaining ones are left f=
or
> future work. The verifier enforces it in bpf_add_kfunc_call(), rejecting =
a
> kfunc whose return is larger than 8 bytes with -EOPNOTSUPP when the JIT
> lacks the capability. Only x86, arm64 and riscv are supported so far.
>=20
> On arm64 and riscv the native second return register is already BPF R2 (x=
1
> in bpf2a64[] and a1 in regmap[] respectively), so the value is in the R0:=
R2
> register pair on return with no extra move, unlike x86 (RDX->RSI). This h=
as
> been tested on x86 and arm64. The riscv path is expected to work by the
> same register-mapping reasoning as arm64 but has not been tested.
>=20
> bpf_add_kfunc_call() also rejects a kfunc that is marked KF_FASTCALL and
> returns more than 8 bytes. The bpf_fastcall contract implemented by
> mark_fastcall_pattern_for_call() assumes a call clobbers R0 plus the
> registers holding its arguments, so a return in the R0:R2 pair would
> clobber an R2 the caller expects the fastcall pattern to preserve. Such
> a kfunc is rejected with -EOPNOTSUPP as well.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
