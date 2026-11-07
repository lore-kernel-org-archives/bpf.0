Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025983;
	b=45xrDYpdBpH18/T9Wjbp7WA7DgVpywjZ431bTVi+NswCVoSEg6mGMhUUthu++qZUxxy2
	 IGJwjfeVHbIw93qImvjx44i0iLj3/vxnk6mHVH/fmOSsHQWKx4ZJyNBhhljI5gmz5ebhJ
	 YmlRIyup9B4v/T8nYG8LRWBpB7npiIplk+5BMSX3/XmpVo0Em4pWANgdhyhJPfsKgCW7u
	 3Bn73o7FtevEMEIJv9ABHDJFwmm4MOsLmxvkuZpekjH8W2bsvynNiVQU8J/h6VOo3Nhnf
	 1G/8gPc0P7IZsl+KIm74r7bWnzKIuC1OcYr/pRl9e2Up0aa8hfYz3LpFnbtb0xq/H1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025983;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=wR0sCJ6o1ska6lY7mh4DqklMTifm5mPn+uw2Ndz+WlE=;
	b=xFGMYtciDVA3JWF9QVoq83/WoMVWwduZZyRm8nDJ3PL8wCvOdrOTvr1mwOHB6VZzegwj
	 7390kx5ajG5ETsAt7TBdPW4j296xkl0d4smEUrEWSWkE75WXmW4QYhbedzkk6CZFXpwpd
	 o5ueDvEVjyx+h+zm9YGR3rU8G5958wc0qYiqB8dROS82yqIBAiGt+p9fc1ay+SIH2ol6q
	 XvMhEgLXi+fPltX3AAUYyrBFbrH1yO2mKcVW9iQlZsfn8XgpUtCE0fbXV/8IpwbIs10jc
	 QcwGuTOgqw29gsE8svZMn+qVPZKY1SjwbqjokHIRD35zaZJi3iHLOa3Cle/urhgSs/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqWfcFXo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD381606A32C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqWfcFXo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FE51F0089F;
	Sat,  7 Nov 2026 04:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025982;
	bh=wR0sCJ6o1ska6lY7mh4DqklMTifm5mPn+uw2Ndz+WlE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CqWfcFXoBDpqh0x3Kla5w8Si7vdjSi59lqY2o+8SZYuOrDGCmxoANI7RPn18B6Ks3
	 y1mXJXoIrYKusH9EfCN7lXwFHkSxazV30B4Le8TjvVNNyF/X1Q9Fz7nCh9/YLbPV2z
	 MwTxxtq2NxbG1mAxRfwcJBJgNdmh/lgyTKwz/zyUbqxIZ92ptRtnm8UQLe05t6z8wC
	 uQvSlf/SSD7kpdsvFSRRmCy5QAIQSJ0hCc2MsgBoauG8DtRHYRX1PaOALrORR9j1qb
	 f+3H38c7S1AjTvjRa/SGxAwECVH12Nv+9EcFjbzi5GBOCiYDhCfiBsFiWXDHmedcZi
	 VnPs5X0Q09Btg==
Content-Type: multipart/mixed; boundary="===============3960911691898126970=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a4c9be4f4465e947201813726ba6eeefc022ff1d8121d7e1d5daccc699e983a1@mail.kernel.org>
In-Reply-To: <20261107033758.1547725-23-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-23-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v4 22/46] bpf: Allow recursive subprogs
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  7 Nov 2026 04:33:02 +0000 (UTC)

--===============3960911691898126970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow recursive subprogs

TL;DR: The new liveness check for stack pointers passed between recursive
subprogs may wrongly reject programs that loaded before, because provisional
recursive marks from callx edges can be false cycles.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -2408,6 +2415,17 @@ static int analyze_subprog(struct bpf_verifier_env *env,
>  		if (!has_fp_args(callee_args))
>  			continue;
>  
> +		/*
> +		 * at_in[] is kept per subprog and the snapshot of the stack per call insn:
> +		 * the walk must not enter a subprog that it has not left.
> +		 */
> +		if (env->subprog_info[subprog].recursive && env->subprog_info[callee].recursive) {
> +			verbose(env, "recursive %s() passes a pointer to the stack to %s()\n",
> +				bpf_subprog_name(env, subprog), bpf_subprog_name(env, callee));
> +			err = -EINVAL;
> +			goto out_free;
> +		}
> +

Can this reject programs that loaded before this commit?

bpf_compute_live_registers() runs after mark_recursive_subprogs(), but the
recursive marks are only provisional at that point.  Since callx targets are
not known before the main pass, mark_recursive_subprogs() treats every
subprog that contains callx as calling every subprog whose address is taken:

    for_each_set_bit(s, callx, cnt)
        bitmap_or(calls + s * words, calls + s * words, taken, cnt);

The taken set includes plain bpf_loop() callbacks and every entry of a
read-only function pointer table.  check_recursion() only drops the wrong
marks after do_check_all(), which is too late for this check.

For example:

    static int bar(void *p);                         /* only entry of a RO func table */
    static int helper(int *p) { return tbl[0](p); }  /* callx, always calls bar */
    static int cb(u64 i, void *ctx) { int x = 0; return helper(&x); }
    prog: bpf_loop(1, cb, NULL, 0);

cb is in taken (pseudo_func) and helper contains callx, so the provisional
graph has the cycle cb -> helper -> cb and both get recursive = true.
analyze_subprog(cb) then sees a pseudo_call to helper with an FP-derived r1,
which is live at helper's entry because callx reads r1-r5.  The load fails
with "recursive cb() passes a pointer to the stack to helper()".

The parent commit accepts this program, because sort_subprogs_topo() knew no
callx edges before the main pass and the re-sort after it found no cycle.

The check does not seem to be needed for the reason its comment gives.
analyze_subprog() only follows bpf_pseudo_call edges and the constant
callbacks of find_callback_subprog(), never callx, so a cycle that depends on
a callx edge cannot make the walk re-enter a subprog and free
info[subprog].at_in while it is in use.

Would it work to test for a cycle in the graph that analyze_subprog()
actually walks (pseudo_call plus sync callback edges) instead of using the
provisional recursive marks?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42335829855
--===============3960911691898126970==--
