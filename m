Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E43D3D05
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303267; cv=none; b=m6p1tPc0HQM9rEsdVNa2vQLE2JCkTMa5JYXRAPHkbJ9nQC/WYsTHFXWt1P0+Vo+eBULR86dy6ajnDsBM7Vu5biuym9n49XU8MGdpN4IvG95xRg6vc/JckiQ2To3IYXH9UUst4TD1g084TCyegNnfmEsKxDsAHlJ25JCzvf3pFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303267; c=relaxed/simple;
	bh=lGEMy8UIN+fTJmtIdtuFJyBWyHQUMLGF+H4nss57VLo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rpFqkhV1KFfUaMweRq1k+E1WsIkTZD22vCVueTSrFasUflTtJjJVekpxhx5Xa+uN1HLyMIzlt3tCoRWbw3EHkqkZcXM17dpvYksIb5miX5oe/Lupd1+KNVbsWD8AKx+MrgyHGSsHSng0Y8/uvR+GTazIFePOSDt49y9EJT28U50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY7xsJA9; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY7xsJA9"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1383e116edfso1839273c88.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 15:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781303265; x=1781908065; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tdOIpPwQMpYh5nCpsBhSLYhKVNtHCNddyJ/gLUgFL/s=;
        b=cY7xsJA9VwVlFPywfn6d9BBupAE8A3LtzQ8nXtOTOea6oseE3WRgvDGyq532z/Qhtc
         fSuWX0S0q9ZLCN+/mINrLcOmoYGt4dcJM4d2AGWPhjuKYHyLGTZB1RjdAhE+pBc4mqC+
         zSVNwwm9rT0OQrHkOtlq/PsFxIk4ZfXBzIgcC8pOgvuQaMdQR+8zQ/lWmjUzoW7Ov+4k
         +yy5cd1FEAA/TVg6YVcua5JwSR3AxXC/+YeKUHuy65RO3W3FsvnmPOq3YWuFu7qbXb1e
         DZLYWbrWW3q7EWVnMZIZR/QVrwICCQa8lq1IaPVLfmjJsBJAaktkv6pmiTWcpxuV+4C3
         WERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781303265; x=1781908065;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdOIpPwQMpYh5nCpsBhSLYhKVNtHCNddyJ/gLUgFL/s=;
        b=sJblVSZv7t1rvdT1Tu/bklkEG6mgj7UiSjXqCo0ki4LwgxcUF4pDf6kC3CqNY1ONOU
         3MDm/hw9IOiOjyvPB6fMPfBYSTi2pVvM+Pd+vcicuIQVdUSGpiEVaqUauCeixS2TSUO6
         ppAssG571gQYekVe21ccX98knAjJZmUNn3QBikJQO7n/JfpJuCqTHNOopIipqNLPOHDk
         ZlUMxsBxvJvTiDo5m/9SLQKi5gqTPtnjxdpByhmOUHD9fa8c57zE/DlynjLDNRo6YXIL
         h/W9p9e2294lTYx2sPkOovzDBPWFpAZrxwjccuOjgzvwZv0pERsN3txb3OzfS4/089gh
         Qe2Q==
X-Gm-Message-State: AOJu0YzP2jSdG8OLiQudDTqp/RJwTvVnlEZv11TIUQu4S1j0f9G9+53W
	mThMC/qOc5cgsCncl4xanlmyqjMQAOFRMxYEMSICsZ4eElKgjQnpqm/a
X-Gm-Gg: Acq92OHNPABKq+57IjCxjrZBwtMuf3c0sh2OCaQBZX+9OUGD48lgoaK03gVegVYizYn
	tlFE9SscfbeqtFfPPTeawQfGRYZkXVl330TjanJvChKr4sZ3hDnAmSTxNA1vlR4ht77fffyBRAY
	aRGZCpmKU/ezUAxjvhldtu7w2wE/rP1hXpF04EToz/v+IhIjXEv2fgSOAs28D2vPeMuBFNb4hk+
	VJkvEzZbhv4kkKcHYT0arCqnJj+Kkz/Nelnej/fN3nv+gg3cXiyixujV26D/tvcJ0SljkuavvXo
	4bEDFfAfu1+0x3zRXyCeHjbqC6QShpsv7kYtwLLsq4eh6l+nGvT7nI3t6WzOOFPdAEubStOzitM
	23VuD+Ho/jC2bZfI3/XrRaKq5Xol0mWBYmizqhv+s2CP9XMwP6m4kjGff9qnyyYbkxveGBmi8zZ
	0oUfm1ECS4WvVNXWu4c3zpa9+EW9d1ts9RfaB6IWQ8MklGui6z7p9ugIuFeNB9p9CuEcWTGg9bP
	y1WqXZxiaHjhlLE
X-Received: by 2002:a05:7022:309:b0:138:236a:c521 with SMTP id a92af1059eb24-1384baf12b0mr2300612c88.2.1781303265082;
        Fri, 12 Jun 2026 15:27:45 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c503:9b3a:29da:a70c? ([2620:10d:c090:500::9f26])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1386f20ad25sm1289668c88.0.2026.06.12.15.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 15:27:44 -0700 (PDT)
Message-ID: <76cf1da72418d905cfd52dc9e0efa7c37cf8ba76.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Track spilled zero scalars for var-off stack
 reads
From: Eduard Zingerman <eddyz87@gmail.com>
To: Woojin Ji <random6.xyz@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko	 <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi	
 <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan	
 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 12 Jun 2026 15:27:42 -0700
In-Reply-To: <20260611-bpf-stack-var-off-zero-v1-v1-1-0ec407376147@gmail.com>
References: <20260611-bpf-stack-var-off-zero-v1-v1-1-0ec407376147@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-11 at 19:11 +0900, Woojin Ji wrote:
> mark_reg_stack_read() currently treats a variable-offset stack read as
> known-zero only when every byte in the read range has STACK_ZERO type.
> This loses precision for stack bytes that are represented as STACK_SPILL
> but come from a spilled scalar const zero.
>=20
> Fixed-offset stack reads already preserve such partial reads from a
> spilled scalar zero as const zero. Variable-offset stack writes also keep
> a spilled scalar zero intact when a zero write overlaps it. The read side
> is therefore inconsistent and can reject otherwise valid programs: a byte
> read from a spilled zero becomes an unknown u8 and may then make a
> stack access through that value appear out of bounds.
>=20
> Treat STACK_SPILL bytes backed by a spilled scalar const zero as zero
> bytes in mark_reg_stack_read(). When such a spilled scalar is used to
> prove the destination register is const zero, mark every contributing
> source stack slot precise before state pruning can use an explored
> zero-spill path for a later non-zero spill path.
>=20
> This has to be done eagerly for variable-offset loads. Fixed-offset stack
> fills can record one source stack slot in the jump history and propagate
> destination precision back to that slot later, but a variable-offset load
> may source bytes from multiple stack slots. Seed precision backtracking
> with every zero-spill slot that contributes to the const-zero
> classification instead.
>=20
> Add verifier selftests for both sides: accepted programs that read a byte
> through a variable stack offset from spilled zero scalars, including a
> multi-slot range, and a rejected program that would be accepted unsafely
> by a naive implementation that promotes spilled zero bytes to const zero
> without tracking the source spilled slot precisely. Use
> BPF_F_TEST_STATE_FREQ for the rejected test so it does not depend on the
> current verifier checkpoint heuristic thresholds.
>=20
> Tested:
>   ./test_progs -t verifier_var_off
>=20
> Assisted-by: opencode:gpt-5.5
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
> ---

This patch does not apply cleanly to current bpf-next, and that's the
branch it should target. Also note that tests should be split as a
separate patch in the patch-set.
