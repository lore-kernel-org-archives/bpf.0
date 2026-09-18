Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C988397949
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713348; cv=none; b=SUryfTsjbblVpuXH4v+sRQWSBl65xOQfQH1oncyUaXIsuczZaCtjglbl2zA0ZP0ufVknmj8h59tm47urcX+TmfTPwEWINvflDXD4WJWvvtV5TtCW5sHpmjst0+ybiXdDRZ7Dm6eLaYReuxHfiWRmil1v4ND32b5ibLQOxVXyElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713348; c=relaxed/simple;
	bh=UTjeTk1VbKKBdARAgf7jpdviy6hz0sJdCAUDxdrPnZo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=m6zcxaLzXhH6VpT63WcaTOIFJPZroo7TT8Pi5El7Yz2vNzsGmJ3jjqnvEb9TK06HdtH6HsQEd3TXUvyYqMc54qDvEFgQaRoxy/5Y2Hywyu9R09SH9V/md/5Fnpjm5tbJDsyqjaLox668WYVcajf1AEDTAYTKIiSbIzafjMLSlmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOZOdDBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOZOdDBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268161F00893;
	Fri, 18 Sep 2026 06:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713341;
	bh=QWQ4PWDnoYK9UmX2NhmuId7k6uU1Wt6ixKWUSIpB1zM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZOZOdDBmZl4Ax2FotUVj0/i1oUKINKlvDTe9w4J+gNBE056Q03e8Cjs1q1Dp+KsCt
	 a1KeobB2c6XodPRD4cgy7QqA/+QGiFDtdfH0AAWQfmrpDAzpeC3iIJ8NRbJwkRJY+a
	 AQ4cknlBaeWsQKDcaTiEIFvQBFNmk7o7pIW6KFCe+G1n/0SFrCi8dMCsyCTuUo424f
	 WdhKlnoeyCMyyPir/lWiJiamH3jNCVGF2MeQ7MWR2kRK1fHZH7D7KH6XSEdlle3c+5
	 9NXsg+Vi3xZWrBI1sdvPFDtCP+8G7OSZ6/44+yKaCtJqqWs+ch/iR6sYExE63Kyie7
	 vLE+771+yscyw==
Content-Type: multipart/mixed; boundary="===============1875449126614993302=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7c7f848aa9c18988eb847024f7db7ce6144696650aeb9abe16143a3691ac6bb2@mail.kernel.org>
In-Reply-To: <20260918052906.12226-6-memxor@gmail.com>
References: <20260918052906.12226-6-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] bpf: Fix generic __uninit kfunc output buffers
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: tj@kernel.org,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,ameryhung@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 06:35:41 +0000 (UTC)

--===============1875449126614993302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 6c2c048dccef6..71fb0ca72d698 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -164,19 +164,32 @@ suffix should be used.
>  2.3.3 __uninit Annotation
>  -------------------------
>
> -This annotation is used to indicate that the argument will be treated as
> -uninitialized.
> +Use ``__uninit`` on a pointer parameter for an output that the kfunc
> +initializes without reading its incoming contents.
> +
> +For generic memory buffers, the kfunc must initialize every byte in the
> +declared range on every return path, including error returns and struct
> +padding. The range is determined by the pointed-to type or the associated
> +``__sz`` or ``__szk`` size argument.
> +
> +The annotation does not change the accepted pointer types. A stack-backed
> +struct passed as a generic memory buffer must still be scalar-only.
>
> -An example is given below::
> +A stack buffer with a verifier-known constant offset and size may be
> +uninitialized before the call and is considered initialized afterwards.
> +For variable offsets or sizes, callers with neither ``CAP_PERFMON`` nor
> +``CAP_SYS_ADMIN`` must initialize the potentially accessed stack range before
> +the call.

Does this capability-conditioned requirement match what the verifier
actually enforces?

Looking at check_stack_range_initialized() for the variable offset case,
unprivileged callers are rejected outright:

kernel/bpf/verifier.c:check_stack_range_initialized() {
    if (!env->bypass_spec_v1) {
            ...
            verbose(env, "%s variable offset stack access prohibited for !root, var_off=%s\n",
                    reg_arg_name(env, argno), tn_buf);
            return -EACCES;
    }

so pre-initializing the range does not make an unprivileged call verify.
Privileged callers that pass bypass_spec_v1 then hit:

kernel/bpf/verifier.c:check_stack_range_initialized() {
    ...
            raw_mode = false;

which means exactly the callers the documentation exempts are the ones
required to have the range initialized. The requirement appears inverted
for variable offsets.

For the variable size case, check_mem_size_reg() clears the output
descriptor unconditionally with no capability test:

kernel/bpf/verifier.c:check_mem_size_reg() {
    if (!tnum_is_const(size_reg->var_off) &&
        meta->arg_raw_mem.argno == arg_slot_from_argno(mem_argno) + 1)
            meta->arg_raw_mem.argno = 0;

With argno cleared, raw_mode becomes false for every caller, so every
caller must have the whole reg_umax(size) range initialized beforehand,
not just unprivileged callers.

The gate is also env->bypass_spec_v1 rather than a pure capability check.
bpf_bypass_spec_v1() returns true for bpf_jit_bypass_spec_v1(),
cpu_mitigations_off(), or bpf_token_capable(token, CAP_PERFMON), so the
behavior also flips with mitigations=off or a JIT that bypasses spec-v1.

The commit message only mentions documenting that outputs must be fully
initialized on return paths and does not claim anything about capabilities,
so the capability sentence appears to be an unbacked addition. The
pre-existing comment above check_mem_size_reg()'s clearing (line 7218-7222)
has similar inaccuracy and may be the source.

Could the documentation drop the capability qualifier? A variable size
always requires initialization, and a variable pointer offset additionally
requires CAP_PERFMON/CAP_SYS_ADMIN merely to be accepted at all.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35311871659
--===============1875449126614993302==--
