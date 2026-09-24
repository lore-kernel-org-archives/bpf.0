Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204CE21FF2A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210821; cv=none; b=qahm3BDMnP5MYyPeqeas3Hvrq4XWCoGBetCYEtkGFpxs6Qoa3ULVP5IdleykXi9b84QR5eCHqKnNVaehSULjIv1vKGUwguH507N0+xuoKaEGeccjH7nvcG40TDkyjA3tC1HLHfi0ZzTBO2c4xktm31FptWUZKYo5S+/byDmkk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210821; c=relaxed/simple;
	bh=WPNy1w9NelqUrEMPB053iBP22vAxa6vRubQj9rL7PH0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=c7qm22miGHjupOQ3ArYsxlqMld10aFZTy8eO4HH+YXgrLKHKiaqkY5p8yiuacGlEEDMWxeHzagaXGk69DI7vKYa7Yct7agTUSoxvDIZOpGcPqPoc2QmAQlt7HvdEvhUcTVzSzxdkp4izj5f5pbxxBZnkZ9XgeSBRjoqoF0sSTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZjSwKmo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZjSwKmo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C7C1F000FF;
	Thu, 24 Sep 2026 00:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790210819;
	bh=PtwLxd5EKaZhjxKqPDiJzZX85Bfd3Lwjnyr05WfOG9M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iZjSwKmornNNubRto8QhpzxvgkXCmhRvecdUU2jc0kHa+GbkFTrzeLWnUAO2MlE/A
	 7kJwoy1ly/ysIS3RGQbzRCzqwaTNNDVkjC1M+lxFzkrM/HLfFUkUYJLaoj3eDXaScz
	 C64EL91yNv5U9YR9ExwMJbVAS3a03QME/HiFHPTHL+5u3NRjEuhiyJIoeAI3yrKPVB
	 0+fER5IkD4ZoTZ9O14xfE6vgfiTYBDeyutafo+qpZhdKyaxksifryLlXvNtIjymBqt
	 /KPp5v3zSXHhahIArwJbkCoeWmHT9UAq96emrG9gpolUKmeUTjk3pbdqdTc7MkxO1Z
	 3dCByUpnkMAhw==
Content-Type: multipart/mixed; boundary="===============8519926169279110971=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7f1587113ee73116a351e6a5316e2b8f7485b1cdb69ab60fd56ae9069e98d767@mail.kernel.org>
In-Reply-To: <20260922011323.1298619-11-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-11-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 10/17] bpf: Recognize pointers to functions in read-only maps
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 00:46:58 +0000 (UTC)

--===============8519926169279110971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2ebd08a3c736..958a8897cbf6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6532,12 +6638,100 @@ static void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s64 val)
>  	reg_bounds_sync(dst_reg);
>  }
>
> +static void mark_reg_func_ptr(struct bpf_verifier_env *env, struct bpf_reg_state *regs,
> +			      int regno, int subprog)
> +{
> +	mark_reg_known_zero(env, regs, regno);
> +	regs[regno].type = PTR_TO_FUNC;
> +	regs[regno].subprogno = subprog;
> +}
> +
> +/* a read from a table of functions branches into that many states at most */
> +#define BPF_MAX_FUNC_PTR_TARGETS 64
> +/* and the table, which might have other data in it, is that many pointers long at most */
> +#define BPF_MAX_FUNC_PTR_RANGE 4096
> +
> +/*
> + * A read from a frozen read-only map that has pointers to functions, see
> + * resolve_func_ptrs(). A read of exactly one pointer yields PTR_TO_FUNC.
> + * When the offset is variable and only pointers can be read, which is how
> + * an element of a table of functions is loaded, the verification continues
> + * with each of them. Other reads that overlap with a pointer are rejected,
> + * because their result is not known until the program is jitted.
> + *
> + * Return -ENOENT if there are no pointers to functions in the bytes that are read.
> + */
> +static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int off,
> +			       int size, int value_regno)
> +{
> +	u64 min_off = reg_umin(reg) + off, max_off = reg_umax(reg) + off;
> +	struct tnum offs = tnum_add(reg->var_off, tnum_const(off));
> +	struct bpf_reg_state *regs = cur_regs(env);
> +	struct bpf_map *map = reg->map_ptr;
> +	struct bpf_verifier_state *branch;
> +	int subprog, targets[BPF_MAX_FUNC_PTR_TARGETS];
> +	struct bpf_func_ptr *ptrs;
> +	u32 i, cnt, n = 0;
> +	u64 o;
> +
> +	ptrs = bpf_map_range_func_ptrs(env, map, min_off, max_off - min_off + size, &cnt);
> +	if (!ptrs)
> +		return -ENOENT;
> +
> +	if (size != sizeof(u64) || value_regno < 0 || !tnum_is_aligned(offs, sizeof(u64)) ||
> +	    (max_off - min_off) / sizeof(u64) > BPF_MAX_FUNC_PTR_RANGE)
> +		goto overlap;
> +
> +	/*
> +	 * Every offset that the read is possible at has to be the offset of
> +	 * a pointer. var_off tells the stride of the elements of an array.
> +	 */
> +	for (o = round_up(min_off, sizeof(u64)), i = 0; o <= max_off; o += sizeof(u64)) {
> +		if ((o ^ offs.value) & ~offs.mask)
> +			continue;
> +		while (i < cnt && ptrs[i].map_off < o)
> +			i++;
> +		if (i == cnt || ptrs[i].map_off != o)
> +			goto overlap;

Can reads that don't actually overlap pointers still be rejected here?
Looking at the bounds-based overlap check, when a vtable-like struct has
both data and function pointers (e.g., struct { u64 data; void (*fn)(void); }
with stride 16), reading tbl[i].data gives var_off with offsets 0, 16, 32...
where every tnum-possible offset is non-pointer data.

However, bpf_map_range_func_ptrs() returns pointers in the bounds interval
[min_off, max_off + size), which includes the fn slots at 8, 24, etc.  The
check then rejects the read because ptrs[i].map_off != o for the data offsets,
even though none of the tnum-possible offsets actually touch a pointer.

The commit message mentions supporting tables where pointers are mixed with
sizes and other data, so these programs seem like valid use cases.  Should
the overlap check walk only the tnum-possible offsets and return -ENOENT when
none of them overlap a pointer?

> +		if (n == BPF_MAX_FUNC_PTR_TARGETS) {
> +			verbose(env, "read from map '%s' may yield more than %d pointers to functions\n",
> +				map->name, BPF_MAX_FUNC_PTR_TARGETS);
> +			return -E2BIG;
> +		}
> +		subprog = bpf_find_subprog(env, ptrs[i].xlated_off);
> +		if (verifier_bug_if(subprog <= 0, env, "no function at insn %u for map '%s' offset %u",
> +				    ptrs[i].xlated_off, map->name, ptrs[i].map_off))
> +			return -EFAULT;
> +		ptrs[i].used = true;
> +		targets[n++] = subprog;
> +	}
> +	if (verifier_bug_if(!n, env, "no offsets to read map '%s' at", map->name))
> +		return -EFAULT;
> +
> +	for (i = 0; i < n - 1; i++) {
> +		branch = push_stack(env, env->insn_idx + 1, env->insn_idx,
> +				    env->cur_state->speculative);
> +		if (IS_ERR(branch))
> +			return PTR_ERR(branch);
> +		mark_reg_func_ptr(env, branch->frame[branch->curframe]->regs, value_regno,
> +				  targets[i]);
> +	}
> +	mark_reg_func_ptr(env, regs, value_regno, targets[n - 1]);
> +	return 0;
> +
> +overlap:
> +	verbose(env, "read of %d bytes at offset [%llu,%llu] of map '%s' overlaps with a pointer to a function\n",
> +		size, min_off, max_off, map->name);
> +	return -EACCES;
> +}
> +
>  static int check_map_mem_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int off,
>  			      int bpf_size, int value_regno, bool is_ldsx)
>  {
>  	struct bpf_reg_state *regs = cur_regs(env);
>  	int size = bpf_size_to_bytes(bpf_size);
>  	struct bpf_map *map = reg->map_ptr;
> +	int err;
>
>  	switch (map->map_type) {
>  	case BPF_MAP_TYPE_INSN_ARRAY:
> @@ -6555,13 +6749,18 @@ static int check_map_mem_read(struct bpf_verifier_env *env, struct bpf_reg_state
>  		break;
>  	}
>
> +	if (env->func_ptr_cnt) {
> +		err = check_func_ptr_read(env, reg, off, size, value_regno);
> +		if (err != -ENOENT)
> +			return err;
> +	}

Does a PTR_TO_FUNC loaded from a map force the program to be JITed?
check_func_ptr_read() marks the register as PTR_TO_FUNC but doesn't set
env->prog->jit_required.  The map still holds the byte offset (e.g. 0x40),
not a real address until jit_subprogs() patches it.

Helpers like bpf_for_each_map_elem() and bpf_timer_set_callback() accept
any PTR_TO_FUNC via check_func_arg() -> ARG_PTR_TO_FUNC, which just sets
meta->subprogno = reg->subprogno.  They call the register value as a kernel
function pointer at runtime.

bpf_fixup_call_args() falls back to the interpreter when jit_requested is
false (bpf_jit_enable=0 without CONFIG_BPF_JIT_ALWAYS_ON=y) or when
bpf_jit_subprogs() fails with anything other than -EFAULT.  That includes the
new -EBUSY claim failure, -ENOMEM, or a subprog JIT failure.

The interpreter's callback check only looks for ld_imm64 BPF_PSEUDO_FUNC:

kernel/bpf/fixups.c:bpf_fixup_call_args() {
    if (bpf_pseudo_func(insn)) {
        verbose(env, "callbacks are not allowed in non-JITed programs\n");
        return -EINVAL;

A PTR_TO_FUNC loaded from a map has no such insn, so the program loads and
runs in the interpreter with the map unpatched.  The helper then calls the
raw offset (0x40) as a kernel function pointer.

A program needs only a callx on a dead branch (e.g. gated by a .rodata
constant folded to false) to enable resolve_func_ptrs(), since
check_subprogs() sets env->has_callx from a static scan.  check_func_callx()
and its JIT requirement check never run.

Should check_func_ptr_read() or resolve_func_ptrs() check
jit_requested && bpf_jit_supports_callx() and set jit_required, the same way
check_func_callx() does?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35935998342
--===============8519926169279110971==--
