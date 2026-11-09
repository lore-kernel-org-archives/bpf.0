Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235661;
	b=nIvyu7ewgB3Y+k5wBlEjQiEZp9uan5KkUgBVzw1ZSEuXB+QCgLkU+YarD+yaO+mN/jPG
	 hjCZ3Go+LGv6Q4wF1xriCi16mKvLrwOplc1RaEvOnXdGb2YwFE/0lXRNU30w1lnsM7RXw
	 D2W6Rc6OamtUrmrs/Tuik4UKyFDLix/1GNoDCh2U6liNMYVY+JzGocXxvsD9RBW4sZsIN
	 GhVBTCdYhBxWdD2Lepzxrd9iQ1iVSNTFuFwcJRrkMYvwy2EAx6ZT+IUDKeO83IgL/hQpZ
	 1nGXdy4nzHCchuQRUg2RFLonnpI1XlddDUh8KTd56SukE2HE2B+pPEdQYsZgBgO6t2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235661;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=9cPLPAVcEOwBLk/Nk6KbuGfr7S0+BQfhEGmd0X57WrM=;
	b=mPRHmcaPknQswEHaZJDrXIZ/opgiPEIXcI5ZfE818OZBcsaBh61wb8IW/jNtNPiVZLxP
	 NltEqUEK/Qd2fm5ujcDGCxjMP3qNRFkm9Ln1D8McO9gSsb6o9Cvdp3uBXCAidBsKzjE04
	 A2q62ljcUctKY2R4Pr8qHeuSXO6stOCSX15Gg9EFvGz4gxZDJ4B+xNeLiXtLazAeoynaN
	 Ok/X02TOJCnBVRulbgswnnRxCgRjEYPnshcQqE0IHCINPfKlaoEK6pwPnNdgkdT5NAFHW
	 697DUiXBeZWQC7bSMx/0DVzaO7A08mHkR9LJv7oqpZGV0aqVW4nb2DvzARmwuObQeaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rhrs+P3H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42647606A31C;
	Mon,  9 Nov 2026 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rhrs+P3H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A511F0089F;
	Mon,  9 Nov 2026 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235660;
	bh=9cPLPAVcEOwBLk/Nk6KbuGfr7S0+BQfhEGmd0X57WrM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Rhrs+P3H4AnKUavy4PrxroYsuROG9hChr1Lx04aqxyz2BS7m30jUG513px0IO3ffB
	 bH1H6TjGLP8BztwxmEUBzE7lq95rFUENYid/Ho2sOh9jFb5Ch3vSdteGs4ixbcR6tE
	 Pz5g3o4sQXprjFGB4OvsxF3iMDxxlyiH9GWVfxRQ4axm7tvR4XxN6fOzZf1THXaDae
	 yoBkTfx+gQ/MBPGv3F3+AAtv3y3p5y0ucCLPXRWzLrDkLPthKZrXGQPSO+1g7n6U8y
	 uClDYUfZTcdXl2ajP1YRPb9cwL9mwu1N4mAjZD1XQYutbeJdaZgDJqJbVVHdu+UAns
	 X4lBmaPv0TO9A==
Content-Type: multipart/mixed; boundary="===============4240390738181790142=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5ed2ec09ce8a3ce5477a658b68c6315499ef67793014be27de18ee57ec968e12@mail.kernel.org>
In-Reply-To: <20261109140816.5196-2-leon.hwang@linux.dev>
References: <20261109140816.5196-2-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 1/9] bpf: Add log support for tracing link_create
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,kpsingh@kernel.org,matt@bobrowski.net,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 14:47:40 +0000 (UTC)

--===============4240390738181790142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add log support for tracing link_create

TL;DR: Logging is incomplete: the freplace max_ctx_offset check in
bpf_tracing_prog_attach() still returns -EINVAL with an empty log, and the
saved_dst type mismatch may too. No functional regression.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -3843,6 +3849,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  	 */
>  	if (prog->type == BPF_PROG_TYPE_EXT &&
>  	    prog->aux->kprobe_write_ctx != tgt_prog->aux->kprobe_write_ctx) {
> +		bpf_log(log, "Invalid kprobe_write_ctx.\n");
>  		err = -EINVAL;
>  		goto out_unlock;
>  	}

The check right after this one still returns -EINVAL without writing
anything to the log:

	if (prog->type == BPF_PROG_TYPE_EXT &&
	    (tgt_prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT ||
	     tgt_prog->type == BPF_PROG_TYPE_TRACEPOINT ||
	     tgt_prog->type == BPF_PROG_TYPE_SYSCALL) &&
	    prog->aux->max_ctx_offset > tgt_prog->aux->max_ctx_offset) {
		err = -EINVAL;
		goto out_unlock;
	}

An freplace program whose max_ctx_offset is larger than that of a
RAW_TRACEPOINT, TRACEPOINT or SYSCALL target will get -EINVAL from
link_create with an empty log and log_true_size of 0.  That is the same
kind of invalid freplace target as the kprobe_write_ctx mismatch above,
which now logs.  This isn't a functional regression, but was this check
missed?

Would something like this cover it?

	bpf_log(log, "Extension accesses more ctx than its target.\n");

Also, bpf_check_attach_target() still returns a bare -EINVAL for the
saved_dst_prog_type / saved_dst_attach_type mismatch, which is the
"freplace attachment to a new target" case the commit message mentions.
That code is in verifier.c, so it is outside this patch, but is it intended
to be left without a message?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42633880300
--===============4240390738181790142==--
