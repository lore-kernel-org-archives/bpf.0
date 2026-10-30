Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355296;
	b=dJpLh4ErFSKxNuUzheg5NG1j1p8gYSfaKcj53xXCIijgFXV2LbqXQ2UVkMi6V+9P7fLR
	 rqHUBC53pTm/RzL3MQWxSFnB6Ldlg6wJlt+iXAYHvaJqaDkaxEEDdRaqtdD+GYkqxnG4Y
	 2l71se8gwzPsp3IqLCxjjPeOrsaAjTmOqpV2sTMCuJrueR8HhQQ2oAxW2wsLfln/Oqs3Y
	 itXnVZeff0OF78Saapt/cdrPN2OW6af6g5yjGB18n87KMP6yxV56NEoDxtB2V6pf5NDpR
	 eDApPncTEArf/QPc/PpVMNjbbId1xlj1fpR45BnaoQcNzJEck8hg4EWv/48eIrBvi3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355296;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=w+JD3u6Dxdi41StGp1M2/D2DhAk8dxZzkihehYnQT4Q=;
	b=Bhi7+JwbfZBHrAvH26cmM6yfd1a/eYbXHvkV/jYRk/Fl16IdSzjYK5W6rD6nHeRIgOyQ
	 nhxAwtSxf1VWdR8s55NF4a2cTXE5y2Sbe3uegYNRh1ME0Q0d9oDj/p0/KKgLFrvCEszYG
	 OGXXejoGaU7Q6nu0PvegL7v1vK5gQ6Aa+isx/Av/LRa+8p/ps/doCiym3pMCpQaz3krB4
	 Q/Yharqh3RxUjfj+JZ9kiPDJ5eg3bR/5ksBMr0pHhCwIXPSs7rNreLB8z8bx+R3jvCVuW
	 LHiB23ZhGcJkkVoludYBzjD+HKvKdTG9dxtkYYCFpipkf/u8qesL8SMF1uEdmg66sHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4ytUL2d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A39606A322;
	Fri, 30 Oct 2026 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4ytUL2d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0898F1F000C1;
	Fri, 30 Oct 2026 10:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793355295;
	bh=w+JD3u6Dxdi41StGp1M2/D2DhAk8dxZzkihehYnQT4Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=P4ytUL2deDLpG/s6gi3nA1RPO0NZyuHqn4Cc08ztiHLoVbQoBFM0wId6gQGHRmc9g
	 B/pglAOLX7PsOx0EzAKEuIRs77z7QVpLnrfjsFrbBg/EvniLUBFVfIPU/tQxcvB6Xr
	 gERY4KLDyqYvwSi9UpFaH0XFP1P5hIshT5LvFVC8UbUaWJaw9zucJ8LedV1T/6dA4M
	 Pdm76QEUtZcAZfxTnk0L2vJg/awT6VU4uzwOXUVx0BII1l18Mbg8EpfUTeIQQWB1Ik
	 8Rr+Q1NHx7tu4Bw1CWEODeZc+LbteADUC8C6C+bIouK5acfc5ZHgg+dUu+C2CCP1I/
	 /+FmlDFu74P0A==
Content-Type: multipart/mixed; boundary="===============2457037860811280631=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c3d38e0d458ec830e8f94f5eb68bf2402a609b3c0b07fc9ba87115712b80b28e@mail.kernel.org>
In-Reply-To: <20261030092248.7388-1-mahe.tardy@gmail.com>
References: <20261030092248.7388-1-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf] libbpf: Enforce program limit only for loaded programs
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,linux-kernel@vger.kernel.org,john.fastabend@gmail.com,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 30 Oct 2026 10:14:55 +0000 (UTC)

--===============2457037860811280631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Enforce program limit only for loaded programs

TL;DR:
- Patch is based on a tree lacking its Fixes: target aac5ba0a4d52; applied
  there, the early E2BIG check in bpf_gen__init() may still reject the object
  and the new clamp is dead code
- Fixes: tag may need to name ba05fd36b851

>     libbpf: Enforce program limit only for loaded programs
>
>     As explained in commit '259172bb6514 ("libbpf: Fix gen_loader assumption
>     on number of programs.")', nr_progs which is obj->nr_programs at this
>     stage is including subprogs and autoload=false progs which are filtered
>     later during the generation.
>     Quoting Alexei, previous patch 'aac5ba0a4d52 ("libbpf: Reject excessive
>     program counts in generated loaders")' does move rejection at gen time
>     instead of load time, but some programs are still wrongfully rejected:
>
>       Two objects with obj->nr_programs == 33:
>
>         object               before aac5ba0a  after aac5ba0a should be
>         -------------------  ---------------  -------------  -------------
>         33 progs             -EACCES at load  -E2BIG at gen  -E2BIG at gen
>         1 prog, 32 subprogs  -EACCES at load  -E2BIG at gen  loads
>
>       The second object fails today because of the cleanup loop in
>       bpf_gen__init(). It closes nr_progs slots of prog_fd[], and
>       prog_fd[32] is at r10 + 0:
>
>         r1 = *(u32 *)(r10 +0)
>         invalid read from stack R10 off=0 size=4
>
>     We now clamp the loop generating the cleanups, which may still be more
>     numerous than necessary and do the actual E2BIG check just before
>     writing the actual prog_fd into the stack for the cleanups, after
>     bpf_object__load_progs() has been doing the filtering on progs.
>
>     Fixes: aac5ba0a4d52 ("libbpf: Reject excessive program counts in generated loaders")
>     Suggested-by: Alexei Starovoitov <ast@kernel.org>
>     Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

The commit message's own table shows that the "1 prog, 32 subprogs" object
already failed with -EACCES at load time before aac5ba0a4d52, and the cause
it names is the cleanup loop in bpf_gen__init() that closes nr_progs slots of
prog_fd[].

That unclamped nr_progs-sized loop was introduced by ba05fd36b851 ("libbpf:
Perform map fd cleanup for gen_loader in case of error"), where
bpf_gen__init() computes nr_progs_sz from obj->nr_programs.  Commit
259172bb6514 ("libbpf: Fix gen_loader assumption on number of programs.")
then relaxed bpf_gen__finish() so that such objects reached load time, and is
a possible alternative target.

aac5ba0a4d52 only moved the failure from load time to gen time.

Should the Fixes: tag point at the commit that introduced the problem
instead, so the stable backport scope covers kernels since 5.16:

  Fixes: ba05fd36b851 ("libbpf: Perform map fd cleanup for gen_loader in case of error")

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 251392aa8b41..555d4757a898 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -139,6 +139,8 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
>  	emit(gen, BPF_MOV64_IMM(BPF_REG_3, 0));
>  	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
>
> +	/* nr_progs includes subprogs and progs that are not loaded */
> +	nr_progs = min(nr_progs, MAX_USED_PROGS);
>  	/* amount of stack actually used, only used to calculate iterations, not stack offset */
>  	nr_progs_sz = offsetof(struct loader_stack, prog_fd[nr_progs]);
>  	/* jump over cleanup code */

Does this fix work on a tree that contains the Fixes: target?

The preimage blob of this diff (251392aa8b41) is the file as it was before
aac5ba0a4d52, and aac5ba0a4d52 is not an ancestor of this commit.  The patch
applies to aac5ba0a4d52:tools/lib/bpf/gen_loader.c with only an offset, and
leaves this check in bpf_gen__init() untouched:

	if (nr_progs > MAX_USED_PROGS) {
		pr_warn("Total programs exceeds %d\n", MAX_USED_PROGS);
		gen->error = -E2BIG;
		return;
	}

With that check present, bpf_object_load() still passes obj->nr_programs ==
33 to bpf_gen__init() for the "1 prog, 32 subprogs" object.  The early return
sets gen->error = -E2BIG before the new min() clamp is reached, and
bpf_gen__finish() returns -E2BIG, so the object still fails at gen time
instead of loading.

The new min(nr_progs, MAX_USED_PROGS) is also dead code there, since nr_progs
can never exceed MAX_USED_PROGS once that check has passed.

In the tree this diff was generated against, which lacks aac5ba0a4d52, the
code is correct, but then the Fixes: tag names a commit that is not in this
history.

Should this be rebased onto aac5ba0a4d52 and also delete the early nr_progs
check in bpf_gen__init(), or should the Fixes: tag name the commit that
actually introduced the problem (ba05fd36b851)?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41035838634
--===============2457037860811280631==--
