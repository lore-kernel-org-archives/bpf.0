Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4581735200B;
	Wed, 20 May 2026 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290322; cv=none; b=iB4FWKRuGCbtVYwHhsBgJcG6MBr9vSru17/D22YJmnxfQog3T+EUnOs3Ugcf5Ccwlx3CUn0S9+n9QbTQyP85el8bwm8rrPa3qCMaBzhahzQWcMceRp3Ru4FeNGRX0KVh9et9/Ip7cWEaclI3j1ePJEImPrHRuBrz2DcMda0z8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290322; c=relaxed/simple;
	bh=CsJyjGYk9MPmuXq/sMIif4W7eME7vsUXaQFOdtUDLWc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=o01lR7BNnP1LlAJsGqAx0iBfbm7x5ESy+P0EwSd290yMe9+5d5H+O+lcO+Mbe813cBpcfgFB+fmisx5k3KfeWUR1vbmGI6gHsw3io80EnAiXje4xHpVJAU5DOZKfMPf9TsRVg9MPWkdcgcdt78rgI+cChgVgYD9LFZKMER9NCq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIH98+pK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIH98+pK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBAA1F00893;
	Wed, 20 May 2026 15:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779290320;
	bh=EQMpW6tFb/6jivmY5Uk5CQF0G8jXgohUdT8ZnDKF7HY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NIH98+pKjHW1ZZaZ3RllMsWTgjdvj8H7rEC8IeUM8S4ffW62Si/1Wp8fUOSbQVvs7
	 fBl9lz62nWpAhjHUHiTzc1T6d4zg3gOV2BA6nTIG70X8DAUTz46Rbe6YxacDaA4ZJN
	 pzLS0y48CtTmJHA/MRylgVZ/lL15eevGmn03s6PJ+n1yWTlS7bpaoIt8dm7b1nR4mW
	 8X1I6DZr2TqEpGKZP9leLHi+W2jHzHMjIGPtUZuVM0M1LTvhpxJPPRvtNfJLUdzMNG
	 ZFxvQ9fwuqg8Sjxe90MGE+PkPvAM8bzN7/84VVuBrL0JgTVI0p8y3QpzgX+I7Nknhw
	 yPsqk2suCsUhw==
Content-Type: multipart/mixed; boundary="===============4862285814015129048=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ffe4e22a8e5d0fceefa7f9ecb378e038b4686aa417addd57d2af243b67607c0a@mail.kernel.org>
In-Reply-To: <20260520-bpf-insn-doc-v1-1-74d7dada9bfc@bootlin.com>
References: <20260520-bpf-insn-doc-v1-1-74d7dada9bfc@bootlin.com>
Subject: Re: [PATCH bpf-next] bpf, docs: add LOAD_AQCUIRE and STORE_RELEASE instructions
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,void@manifault.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,corbet@lwn.net,skhan@linuxfoundation.org
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,bpf@ietf.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 20 May 2026 15:18:40 +0000 (UTC)

--===============4862285814015129048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -695,22 +695,24 @@
>    *(u64 *)(dst + offset) += src
>
>  In addition to the simple atomic operations, there also is a modifier and
> -two complex atomic operations:
> +four complex atomic operations:
>
>  .. table:: Complex atomic operations
>
>    ===========  ================  ===========================
>    imm          value             description
>    ===========  ================  ===========================
> -  FETCH        0x01              modifier: return old value
> -  XCHG         0xe0 | FETCH      atomic exchange
> -  CMPXCHG      0xf0 | FETCH      atomic compare and exchange
> +  FETCH        0x0001            modifier: return old value
> +  XCHG         0x00e0 | FETCH    atomic exchange
> +  CMPXCHG      0x00f0 | FETCH    atomic compare and exchange
> +  LOAD_ACQ     0x0100            atomic load with barrier
> +  STORE_REL    0x0110            atomic store with barrier
>    ===========  ================  ===========================
>
>  The ``FETCH`` modifier is optional for simple atomic operations, and
> -always set for the complex atomic operations.  If the ``FETCH`` flag
> -is set, then the operation also overwrites ``src`` with the value that
> -was in memory before it was modified.
> +always set for the ``XCHG`` and ``CMPXCHG`` complex atomic operations.  If
> +the ``FETCH`` flag is set, then the operation also overwrites ``src`` with
> +the value that was in memory before it was modified.
>
>  The ``XCHG`` operation atomically exchanges ``src`` with the value
>  addressed by ``dst + offset``.

[ ... ]

> @@ -721,6 +723,11 @@
>  value that was at ``dst + offset`` before the operation is zero-extended
>  and loaded back to ``R0``.
>
> +The ``LOAD_ACQ`` and ``STORE_REL`` operations implement lighter LOAD and
> +STORE memory barriers than full barriers. The corresponding accesses must
> +be aligned, but are allowed for any access size (8-bit up to 64-bit
> +operations).

Does the LOAD_ACQ documentation need to clarify its non-standard register
semantics? BPF atomic operations are encoded as STX instructions, which
conventionally use dst as the memory base pointer and src as the value
register. However, LOAD_ACQ reverses this pattern by using src as the
memory base pointer and dst as the destination register for the fetched
value, acting like an LDX instruction.

Additionally, should the documentation clarify that the loaded value is
zero-extended into the 64-bit destination register for 8, 16, and 32-bit
accesses? Omitting these details might lead to incorrect implementations
based on standard STX rules.

This contradiction creates specification ambiguity: the documentation
states that LOAD_ACQ and STORE_REL "are allowed for any access size
(8-bit up to 64-bit operations)", but earlier in the document (line 671)
explicitly states "8-bit and 16-bit wide atomic operations are not
supported."

The instruction encoding section (lines 667-671) only defines two size
encodings for ATOMIC mode:
- {ATOMIC, W, STX} for 32-bit operations
- {ATOMIC, DW, STX} for 64-bit operations

No encoding is shown for B (byte/8-bit) or H (half-word/16-bit) with
ATOMIC mode.

If LOAD_ACQ/STORE_REL truly support 8-bit and 16-bit sizes, shouldn't the
encoding section document how B and H size modifiers work with ATOMIC
mode, and line 671 clarify the exception?

Alternatively, if LOAD_ACQ/STORE_REL only support 32-bit and 64-bit sizes
like other atomic operations, should line 728 be corrected to state
"32-bit and 64-bit operations" instead of "8-bit up to 64-bit operations"?

For a standardized instruction set specification used by multiple
implementations (verifier, JIT compilers, potentially other BPF runtimes),
internal contradictions can lead to implementation divergence and
interoperability issues.

> +
>  64-bit immediate instructions
>  -----------------------------
>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26170628668
--===============4862285814015129048==--
