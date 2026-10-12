Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139B48CD55
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815238; cv=none; b=nKVvw9g01iovm6c3b2MWfR1qnBFP8hWIeFdGfq+g+nJgGpLbOQEPjHFpaphOEJFxjbyu4aks8DZ6XUsJMWrc19AEaQGy7Ix4sT6AS0OUJ+WRK1DZX8heM31oHf0dlkheurd0vZTonUOxN3zZBSyyyFHTAeQd0L3zQBI1cdn8zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815238; c=relaxed/simple;
	bh=nmyoFxyv+AxjQBh8wdhyNdiU7nzVT9cp8KY6EyWrpfU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Jl87WCZcI4VGrhhJ+i1HGjij5eEExE3MCsRDRbdrpf+plbVrdc6MKVDF1H4yguMYtImbJHJlKnDSO37WzLF/bZeuRuttP6xTPpp6IJq4SgwwwaZrrNIA/jo7oMzLW2ZeokCSrlWTJzxsqfB4bJ4Yypn3QQ7NQbo9E20s6Cssn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQBcPM5+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQBcPM5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BE01F0089B;
	Mon, 12 Oct 2026 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815236;
	bh=xca3TIyPG5sTnyszY/yEHi1Xgu1qovnKDAOVMOb2S6s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CQBcPM5+pDz7YYTdypOv3IyH9vMstAoQdnlYxjwvij8pdDGm2myVRc/kIQyFfITIc
	 n6lobf8cUZbp1nkaduNrjhndH5lAJ7dKkga2o9OGoWaW1ms+QnyqPgvEVnjfTw8eaW
	 QB4iXvYIpbCLBem4GhMU4qYvCTmD1W8gbT1k89KYLB5dYA5XSM9MjuaFIVp10k9PsC
	 zxsUFFLm6JXZ5zRiAIr22LfcIsn4Q5PSOiejQQO8ik+IYy9GyjR6zvMGkydfC+dlKo
	 /iPbkVhyj2FIn6D2TK3A2ctIg3nQmCuTb2Jp52JzSWjuBLUmC4D17pSO3ciO9MbLPe
	 yXyPIcP4kdo7Q==
Content-Type: multipart/mixed; boundary="===============2248682884586621731=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8cabe7dcd5fa67622b194c7d1b320f0309936ec7a3bea329a52c398bd94f4e88@mail.kernel.org>
In-Reply-To: <20261012133711.4030594-6-memxor@gmail.com>
References: <20261012133711.4030594-6-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 05/10] selftests/bpf: Test __arena pointer members
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 14:27:15 +0000 (UTC)

--===============2248682884586621731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test __arena pointer members

TL;DR: Commit message only: it says a failure test covers "a store through the
member", but the test stores to the member itself; should it say "a store to
the member"?

> selftests/bpf: Test __arena pointer members
>
> Add a struct_ops member to bpf_testmod whose argument struct publishes
> arena pointers: a plain one, a __nullable one that is left NULL, one
> behind a nested struct, one inside a union, next to a scalar, together
> with a kfunc that fills the struct with the kernel address of an __arena
> argument and calls the member.
>
> Two callbacks read the pointers back. One shares the header with the
> module, so the members are arena pointers on the program side as well
> and need no cast; it also records the register a load produces, which
> must be the arena offset with the upper 32 bits clear, and hands the
> pointer to an __arena kfunc. The other mirrors the vmlinux.h rendering
> of the struct, a kernel pointer with the type tag as an attribute, and
> casts the members to the arena address space the way a program built
> against vmlinux.h has to. Both increment the value through each pointer
> and the trigger checks the count.
>
> The failure cases cover a store through the member, a load from the
> union, an atomic load, one insn loading the arena pointer on one path
> and the scalar on another, and a program without an arena.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

The failure cases are described as covering "a store through the member", but
the test for it, struct_ops_arena_member_fail__write.c, stores to the member
itself:

    /* The kernel owns the member, a program only reads it. */
    SEC("struct_ops/test_arena_member")
    __failure __msg("only read is supported")
    int BPF_PROG(write_member, struct bpf_testmod_arena_member_args *args)
    {
        ...
        args->ptr = NULL;

A store through the member would be *args->ptr = v, which writes arena memory.
That is allowed, and the success callback in struct_ops_arena_member.c does
it:

    u64 __arena *ptr = args->ptr;
    ...
    *ptr += 1;

The earlier paragraph also says "Both increment the value through each
pointer".

As written, the failure-case sentence reads as if stores through the arena
pointer are rejected.  Should it say "a store to the member" instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38258617362
--===============2248682884586621731==--
