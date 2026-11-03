Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695953;
	b=CZzbSxOBEZTuW4sutj4uD/2zvQyrTfTKbJTUmXfODOrRKJbGwVKlxYWnQ2Dri0aBw11V
	 bHK885FPDVxIcpe71XLWNrVVy547fQFEqSUaMR6jZ5HwCi1CundAmTLn/w01JRsuMMr8x
	 ZHXDEl5zfIJ07lg8ZcDscjL6AcRftEfs8OCDipXjc5mXiptFcsDhsWzKhHG9qL8uW3CSZ
	 ogJTAbFBVG1zuFc9PySCGRUPJCmKhjqOt8gq94fNmdrb6jC8YlxdyXWI9gTYmKvlxmkX1
	 1jzWmulCNIo4DGM2AYIFY5kFF3JD7uSzWeEINQWgomjdfJOmiz4MuYVTpqTfyVMF3Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695953;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=H1zLd6hG/R8x62IgEXyvz1fvxMh0hGKtNRoZJvWwbaA=;
	b=L3L5T1vWREWg8+SZ/cyGw85ntQFpCDUTDD969j0yO+3A/pOhhtnLadQ1KN2+FGo20nj+
	 odyvLMPeWDHpAru+0m6NPC40yNsCbIQOAJWz45F7TYUeufQ2+Hawf4KSBv0fikSYctCtJ
	 ruuRGVWN3QTezg6NoFP3LPcJ+QVflFBsbNP4RPiZ7tGtd5hm9ussTEIWcOc866+BS3uSB
	 qYzyg9o73u0wGmubEoQx5waY4NKB9Gg7EAhOZPhLNLUbExgul13VY7k0/TRds9ck58D2q
	 /JdSXAwwxwKsO76K7dZFnteXrH4HvfaHOhH9y7UQo2/C4D/aL8jcQIpdsdL9N0bFb1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ey2/rNZS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A6606A327
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ey2/rNZS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039E21F000C1;
	Tue,  3 Nov 2026 08:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695952;
	bh=H1zLd6hG/R8x62IgEXyvz1fvxMh0hGKtNRoZJvWwbaA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ey2/rNZSZSGEgNni1SBM051jGaDNXKipu6bI+WhqXg+DXQtxTAkPHp1y6npUYrPMd
	 xG+FEEg6UyC0ULBue/cBsk5nnYzKj6PlsZ6wuwRfOkzFTa+1PgFj49FrepxPsmfx3g
	 MpWpm7Rd+T0rbT5L5MhjpOknL27S4xBg7V7z657TtsQ5A3taA7GGwMQncLSH1ywyWB
	 0YYFzQSqU2+NuAm1u5c621J5DSXar3ssYU1XYYOg8Vhz/fdsKsEJ643KBwbTOjIg1w
	 QfQdei9I65G90fAi1cTue17tdqDZXM6TNp4UwAXwPwoCWerM6/8ut7/VkDPCNe51dr
	 08zz1FF3faELw==
Content-Type: multipart/mixed; boundary="===============8055261971948351789=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <3b79b99ba7a323fc42e7d3a19139c46535271762ae6f70ab629213866f54f54f@mail.kernel.org>
In-Reply-To: <20261103075916.100050-2-jolsa@kernel.org>
References: <20261103075916.100050-2-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 1/8] bpf: Honor const on generic kfunc memory arguments
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ljs@kernel.org,john.fastabend@gmail.com,nierro92@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 08:52:31 +0000 (UTC)

--===============8055261971948351789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Honor const on generic kfunc memory arguments

TL;DR: Commit message only: it lacks motivation and doesn't say the verifier
now trusts const in kfunc prototypes, so a kfunc casting const away and
writing could make it unsound; kfuncs.rst doesn't say this either.

>     bpf: Honor const on generic kfunc memory arguments
>
>     Mark generic kfunc memory arguments as read-only when their BTF pointer
>     type points to const data. Preserve that access mode when resolving
>     scalar structs to fixed-size memory.
>
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>

This isn't a bug, but the changelog describes what changes without saying
why.  Could it explain the motivation, for example that read-only memory
such as .rodata can now be passed to these kfuncs?

Before this patch, generic kfunc memory arguments were checked as
BPF_READ | BPF_WRITE.  After it, a const pointee is checked as BPF_READ
only.  As a result:

  - check_reg_type() now accepts read-only registers (rdonly_mem,
    rdonly_buf, BPF_F_RDONLY_PROG map values, map keys, and
    PTR_TO_BTF_ID | PTR_TRUSTED).

  - Program types that may only read packets can now pass packet
    pointers.

  - check_stack_range_initialized() no longer marks the stack bytes as
    clobbered, so the verifier keeps what it knew about the stack across
    the call.

Could the changelog mention that the verifier now relies on the const
qualifier in a kfunc's C prototype, so a kfunc that casts away const and
writes through the pointer would make the verifier unsound?  Neither the
changelog nor Documentation/bpf/kfuncs.rst says this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41602296728
--===============8055261971948351789==--
