Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385665;
	b=aiIT5XbGGMjKTK0pskIOmX8tBav11UiHLgd3yWMri8jWgqdAWAoIgF4vZbdzotm+gbBZ
	 Wp74AM0w83GN0rP9LSwKIp0Kh62ObFJo4bIggwXC0HXfzpVAaeQGlwQrzV1DOufD9MPcS
	 HwlRXTDZNI/gVc2kTzBJOqbOg+zWNWKzoSgKHxBBNH5Fnx+au6x/9VrPJcLq41xCSERit
	 nEr9oM2l0TnVBoqQ5i6+mWqDgzAj53zbj68sEgt4pyUt0bawlmKdFU54A/sLM+AXGMY3d
	 96ypgWm0Va6Rrgs+7gnV/W2GV7VZuTC0lQtNC6KLuzK2CFg/Of8lizISldZqGCjrziA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385665;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=S7F/ivoSK0O50RRN0z3HrIXQ/7VsKIhZ1oxujVS438U=;
	b=rulwloyiK6niUQIDUPpK4D49kiWoGUqDo3CeVXHZLrKGyuqH7jpQEGlea6M03gh6juYR
	 xAQehTPfYh8jN/DvsGFk9Xs/h5LHt7TIbcxxshxXH6beDqR89tH8phOB3aYNbaUMbN8vu
	 OnozUqdKhWfEIhKhJBOn40qrmADDWVz7Seyvtsq9MxJf4xv2bWWLg/6Jf4zr2DGg6rkGQ
	 4r4GDKJj9kPNGvMJcMRAxLMjGmqfiGIJlDkMtlfiFcTsaLlgwy0goj9ejtvx1TYCTdFm2
	 YZxNgtKciQz0LSWIfcjTXL/8qMVi+vmtmoTF1vwje9imm/ymNz7ucRLAAZzJQo67esw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTk75gpZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143AA606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTk75gpZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ED21F00A05;
	Wed, 11 Nov 2026 08:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385664;
	bh=S7F/ivoSK0O50RRN0z3HrIXQ/7VsKIhZ1oxujVS438U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nTk75gpZJ9FN7ftgINNKI7xfx8Er/KUTkmhGuwKlLBkeM8Ocbr2FN7bE9d5haYcv4
	 SJZ/DmHC2QiVPdlqzYcEbGmuT05OmZchGvcoqSZ6KbluiuKb79H26K0YTo3/j2ZNd9
	 d0WD4rHDyHO52zwm3pi5LOkiTw0wTqB8NhrWInLfeLKrYXNCnxt6gLLUBsAaVFffN3
	 tS5yeWydk7FTL/sUVFBYk739RZMGiA3kxTUL7ZQ4d8nKWK/9Y9y7amns+TY1dDzYkG
	 7ZoTpbPO4XgfehjgOSjoL/S6abgLjE/fiJM/w8mTQ4y963CwkbA5Vbm1WSBJ0Ui2g5
	 c6AIkcnnwviEQ==
Content-Type: multipart/mixed; boundary="===============1100655331685570816=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9521956a50aa81400b5f4fd74064883ebc3f798a3f261ad5fba5d5548cd5b210@mail.kernel.org>
In-Reply-To: <20261111051341.2800252-7-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-7-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 06/29] bpf: Give SSA names to the values that scalar evolution does not track
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 08:27:44 +0000 (UTC)

--===============1100655331685570816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Give SSA names to the values that scalar evolution does not track

TL;DR: Nits only: comments on insn_def() and log_def() in kernel/bpf/scev.c
repeat explanations from the struct expr_def comment; could they refer to it
instead?

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -217,6 +285,33 @@ static int imm_expr(struct scev *scev, s64 value)
>  	return add_expr(scev, (struct expr){ .op = IMM, .imm = value });
>  }
>  
> +/*
> + * The insn at @idx defines @reg. Without its backedges and with nested loops collapsed the body is
> + * acyclic: an insn executes at most once per iteration, so a def is one value per iteration.
> + */
> +static struct expr_def insn_def(int idx, u32 reg)

This isn't a bug, but the "acyclic body, one value per iteration"
explanation is also in the struct expr_def comment, and phi_def() just
says "for the same reason".

Could insn_def() refer to the struct expr_def comment instead of
repeating it?

[ ... ]

> +/*
> + * An SSA name is printed as '%', the SCEV register, '.', the insn. A def is printed in full at
> + * every use: (+ %r8.7=phi(1, 2) 4).

[ ... ]

> + * A name is unique within the env of one loop. In the env of loop H a phi at H merges the backedge
> + * values only, the header phi itself is (REG r): in 'scev at header 1: r6=%r6.1=phi(r6, (+ r6 1))'
> + * one backedge leaves r6 as it is, the other one adds 1.
> + * '%' in front of r or fp is a name, followed by a blank it is BPF_MOD.
> + */
> +static void log_def(struct bpf_verifier_env *env, struct expr_def def)

This isn't a bug, but the "unique within the env of one loop" and "phi at
H merges the backedge values only" sentences are also in the struct
expr_def comment.

Could log_def() point to that comment as well, so the explanation lives in
one place?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42982641817
--===============1100655331685570816==--
