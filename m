Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1CD2571A9
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780104211; cv=none; b=larfTBq/1H+xMfVED7XjP24/X+h+c4oQ4jZ//4V/VeZO8qJBAknJiDT2Yxf3E0SczDeivySevy5tG/o8ZtUmMX2p4vxH+xVO4GANt4zwFYnarRZIqgcwlGUu4XxXVXyokq8V/pt5p8zp2Sx/l1LtkfbdkHffb2KGJLeZLtUjS/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780104211; c=relaxed/simple;
	bh=BtaYKpTPJilCTGNFssblfegA2Q/llZ2Ei2qTZMpuJQ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IDDZFtqIRLCgPZQhq2kzi8a2By8zVxtYEscSt3iRoOi0ik6bxqKT3TTPqFxKoImnnSaATtj7Og1dD53znPRUiZcs65/YYzyW2pOHPeu+NIJWh65tL5FFYl+GJReczetWl5eqOXrFU/JsHyuwAInnxDQACY4d939LlOCWowyOuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5b6N6hy; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5b6N6hy"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69df6127fc6so1624131eaf.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780104209; x=1780709009; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfTiRoOM8MzpyQ3L15jEBMe4g863/IvoH5IPT22XTg0=;
        b=g5b6N6hyOXYuFMjhD6fZWBOiORGJf3Yg7DPvBAStagCuCBp9RqB/RXy0PPLFwlE5IK
         Rb0k1giFoafrOPvQwaJDkzyTYH6rqzBILvGWYaVdo7+q55oocgna5e9VnCnLIK8wcJyU
         wtnkXcg6Xvt9YJfa/6//eAyCIv3ksnTW/U2tjgz31oce8ekIudgZLUGzZ+tfufMGIYFG
         FT1Ye5ttp2PCardBqolnEq1Xr/rIVaLgnINY2IH5pKDqwWI5ZZ7UUqcbHsbFoVd7Vjzc
         qi+UCsD3h0j6uaB0heEVP2KPnhpBQhBJVrb4hFChWXFOFArYpdpOx9O3LuLjVLQHRLrO
         KGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780104209; x=1780709009;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfTiRoOM8MzpyQ3L15jEBMe4g863/IvoH5IPT22XTg0=;
        b=gdzHwWAEXn8IpN0Wk3ZxKM0cHwBHDR11Ew+GU8pu4pRKc19TK1S7dlLJV3mxJ9NwSW
         GX1kNX14UAiVLeTokVeRk6+aKpECJWQx9oHySN+fYPvWxtMhgxsiEQSckWaPhvpIwogC
         ygk9X/Ns7vbQ/kHd7zXs7pBdRvaJugqHFvgXEqFaopikEoeOKakTjYh8CSwPgQluZ4bq
         V+Nu+Uk3Fy71qTCDidK4AS/36D7OLJ9iMpbHjA5nrOoQg/kHDxZFsDUyRmQM34Bd09RC
         onF1pX130/LscWpWEXzwohIP8ayg6dqfKADctAttlqaFmLBFZ+h/hs1bbGjA8x7mLQRd
         PtDw==
X-Gm-Message-State: AOJu0Yzil1nzrV6+Eip+7bEf+Txu4lLB9DtX2T0wQc1uVuN8sWmDdEvv
	tXbHqvLNoUVUSmNk7GZduFoGSQNG/Y17IRhCcNItKxHWWpsx+LiIRxYn
X-Gm-Gg: Acq92OH+OscqgdMR1OhFMl8YQpyotxEw8BHhS8qakygzUugUn/2CebdLACJA848Afcm
	P+PgjJI+C3dNKQjPOw5j1mCgLqYvwvNFJZlaYG0mrnXbMnY1ypAa5y0Gt+GBGqh87KfkKZ7jGsu
	o2gKX4vAvPOTrWGVfHoGPlKgkS2szc3g958pc2Sge9j46XFCSoKvHcQA8V4LorcqWmGzpAW/T8S
	WnUYKF69zkBJaj5cvo7v/btKngKFfQf4t9tCVdEyIxUVJa3Uhos7dXRgnaamzlfgsN04LGVRc/Y
	x490vuCHfDD5n6rdQc+q8eHCznD998nUeSq+7r7Y4GhLnIYX1ptF3cKKLzMBrMh/Ajp0vcGTF1W
	O1h7TN8R1nwn/urDpDFrQ6ReOYdP2Nku2ufBeKcq9MeSlvxO+k99Qy162FurBezxm8JNSiiYky/
	HRZvXOJm4Z6l3ho2imDDevE9BX40cERaCXmLunnLVZQabAMQM2tbZq6QY/J2QMOM7OpmdWWwG5M
	xVa94gGLLOt04yYVp20dSquOvo=
X-Received: by 2002:a05:6820:4df9:b0:69d:eccd:f54a with SMTP id 006d021491bc7-69e10308376mr832561eaf.23.1780104209345;
        Fri, 29 May 2026 18:23:29 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e0677268dsm2056831eaf.1.2026.05.29.18.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 18:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 18:23:26 -0700
Message-Id: <DIVM9YXYJV5N.2TEM951JWKD95@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Song Liu"
 <song@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>
Subject: Re: [PATCH RFC] bpf: add DAG fast-path in verifier to skip
 redundant state pruning
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Seunghyeon Lee" <hyeon3125@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>
X-Mailer: aerc
References: <178004391665.3522.4865582628003357086@gmail.com>
In-Reply-To: <178004391665.3522.4865582628003357086@gmail.com>

On Fri May 29, 2026 at 1:38 AM PDT, Seunghyeon Lee wrote:
> bpf: add DAG fast-path in verifier to skip redundant state pruning
>
> The BPF verifier's state-equivalence loop (is_state_visited /
> states_equal) dominates load time for programs with acyclic control
> flow graphs (DAGs). In a DAG, every instruction is reached via exactly
> one path: no state is ever revisited, making state-pruning comparisons
> mathematically vacuous.
>
> This RFC proposes three components:
>
> 1. compute_dag_topo() -- replaces a simple is_acyclic_dag() bool.
>    Uses Kahn's algorithm (O(V+E), O(V) space, no recursion) to detect
>    back-edges AND preserve the topological visit order for use in (2).
>    Handles BPF_JMP32, BPF_LD_IMM64 wide instructions, and falls back
>    conservatively on BPF-to-BPF subprogram calls.
>
> 2. do_check_dag() -- fast-path verifier for confirmed-DAG programs.
>    Critical correctness property: maintains a per-instruction state
>    table (states[insn_cnt]) and, at every join point (in_degree > 1),
>    calls merge_verifier_state() to conservatively merge all incoming
>    paths BEFORE processing the instruction. This ensures the verifier
>    never sees a register as initialized when any predecessor path left
>    it NOT_INIT.
>
>    Skips is_state_visited() / states_equal() entirely; provably safe
>    because topological order guarantees each instruction is processed
>    exactly once.
>
> 3. Full fallback: if compute_dag_topo() returns NULL (cyclic program,
>    subprog, or allocation failure), or if do_check_dag() returns an
>    error, the unmodified do_check() runs unchanged.
>
> Register-state correctness at join points
> -----------------------------------------
> When paths A and B converge at instruction N, the verifier must hold
> the least precise state that is safe for both paths.
>
>   Path A arrives at insn N: R2 =3D scalar [0, 5]
>   Path B arrives at insn N: R2 =3D NOT_INIT
>   merge_verifier_state() result: R2 =3D NOT_INIT
>   -> verifier correctly rejects any use of R2 at N
>
> Without this merge (a flaw in naive linear-scan approaches), the
> verifier would see only the state from whichever path was processed
> last in memory order, potentially accepting a program that
> dereferences an uninitialized register at runtime.
>
> RFC design question:
> --------------------
> do_check_dag()'s inner per-instruction verification step requires
> calling into do_check()'s inner loop logic, which is not currently
> factored as a callable sub-function. We propose two integration
> options and request maintainer guidance:
>
>   Option A: Extract a verify_one_insn() helper from do_check()'s
>             inner loop; do_check_dag() calls it per topological step.

Specializing the verifier for DAG only case is not interesting.
Almost all programs now contain loops.
But the approach to use do_check_insn() as a transfer function
in the data flow analysis is totally viable.
I've been prototyping such transfer + join verifier for some time.
Will share soon. What merge_verifier_state() does is a key.
