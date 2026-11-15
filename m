Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739641;
	b=2keCh7tsRxw+/iPKHZGdvkUhTvIkX72tnsMPguRaAbsgTVLYZM1ZzSZnrOvDgMsORhPC
	 ouimrOa86vzLB+/DeixbhpAzQFymzriGHNBDaqjBnvV4iYQHSKQZs7HG31jaAuNFWzl97
	 LaQqZ0CpAi/WvGRVPZ96MDQIXbdSzPV7siZYOf3GOC+6RZNsTUUncLsOfGfJCPnRNEFB+
	 HgWev3qj+niKA5DiIPUSdAQ1wAZlVThno10wRdcNCTznvp4e8q1dBW6txKNBAndByyP5c
	 bkShuoNZqJYaEVzFft+Cem/YublbkieCLKUZABBME253UnVZTf5KXCjnjL2YYYOJ3Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739641;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mCG1bWkK6lBm1j1JbqQVOw1t7gXmT/cBx65r9nFjdy0=;
	b=s+0Cc+orkm1phTeQ2a0C6hjpWgjzmOpufT92Zn36+iOFNxxAUCKPC7g5naSQlZS/IwJf
	 1NZ73uNFYyw8M/uXRz83+7Hk4PcM6ipUZ4cYG3oS81r9uhd4yNj/SJN6nRFGQsQhghgu3
	 XZjIk9el3t23dGN+jz+EKEyUO/sdmPorlZjwfKrd57OdE07Sc4xbPjtczaIlglI5mrTsE
	 am5eH+bJxRHHxjR5Wsy+oFHvNQFjGFQNeOeta8u+pGvzXPG6trJfaSYGHl8aqieaQMwhZ
	 MmX21zLjK/RyTPmOMZG5kZlQvv8SoQ3GHLiIfCUWR0kJMYIal8h0kNxTyV47EDkUDow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGbrdGFC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE708606A31D
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGbrdGFC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220781F000C4;
	Sun, 15 Nov 2026 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794739641;
	bh=mCG1bWkK6lBm1j1JbqQVOw1t7gXmT/cBx65r9nFjdy0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YGbrdGFCuVhGoqo1efanbPxEg3Bnxi5c5Xs+0cMsgXZuwxZQ9eLBejdcvqqau8KlE
	 ch0yrdZAZZkmEo+b6uN8zoKl7wGNF5SBr5TmiHX6GxlPvIkWQ0ZW6NbPSHzkaJGBWH
	 kubgjfur5+Or4na2Bxn5d++fW17HfV0FnHRrfkHXcoDrF0vq9iqfaf51rMJnTfp7CZ
	 diJIQbJ3Scw4iygYQNhG0Dg8PSKCt/bE9LM6oNQboCjG101jgswvVgDOL1q1ZiaCcJ
	 3sRChxkjfzkq4OOKTYHgjH0LGwrYyMjtBGGTJ0oxDA5WvVUOLSq+hQnPuo/QfdCqDP
	 AcKVmq0Esui9w==
Message-ID: <sashiko-outbox-215408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test the emitted bounds
 check of the array gen_lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuan Chen" <chenyuan@kylinos.cn>, bpf@vger.kernel.org
In-Reply-To: <20261115102559.465375-3-chenyuan@kylinos.cn>
References: <20261115102559.465375-1-chenyuan@kylinos.cn>
 <20261115102559.465375-3-chenyuan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 10:47:20 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] selftests/bpf: check_jmp32() fails on bpf_jit_needs_zext()
  architectures
- [Medium] selftests/bpf: verifier elides NULL check in
  load_lookup_prog() for in-range key
- [Low] selftests/bpf: test_array_gen_lookup_jmp32() fails when
  bpf_jit_harden is enabled
- [Low] selftests/bpf: check_jmp32() duplicates get_xlated_program()
  helper
- [Low] selftests/bpf: comment style and missing EOF newline in
  array_gen_lookup_jmp32.c
--

commit 10c7c22ab5fe20010aaf42d0505ab98d777d6a8e
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: Test the emitted bounds check of the array gen_lookup

This commit adds a bpf selftest that inspects the translated instructions
of inlined array map lookups for a 32-bit bounds check and verifies in-range
and out-of-range lookups via bpf_prog_test_run_opts().

> diff --git a/tools/testing/selftests/bpf/prog_tests/array_gen_lookup_jmp3=
2.c b/tools/testing/selftests/bpf/prog_tests/array_gen_lookup_jmp32.c
> new file mode 100644
> index 0000000000000..ba8215506534a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/array_gen_lookup_jmp32.c
> @@ -0,0 +1,204 @@
[ ... ]
> +/* Loads a program that inlines bpf_map_lookup_elem() on @map_fd and
> + * returns 2 (XDP_PASS) when the element is found, 1 (XDP_DROP) when the
> + * lookup returns NULL.
> + */

[Severity: Low]
This isn't a bug, but bpf coding style places the opening /* of a
multi-line comment on its own line, and the end of this file is missing a
trailing newline.

> +static int load_lookup_prog(int map_fd, __u32 key)
> +{
> +	const struct bpf_insn insns[] =3D {
> +		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
> +		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +		BPF_ST_MEM(BPF_W, BPF_REG_2, 0, key),
> +		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> +		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
> +		BPF_MOV64_IMM(BPF_REG_0, 2 /* XDP_PASS */),
> +		BPF_JMP_A(1),
> +		BPF_MOV64_IMM(BPF_REG_0, 1 /* XDP_DROP */),
> +		BPF_EXIT_INSN(),
> +	};

[Severity: Medium]
Does the verifier dead-code-eliminate the null check here for in-range
array and per-cpu array keys?

Because key is stored with a constant-immediate store at an 8-byte-aligned
stack offset (r10 - 8), check_stack_write_fixed_off() tracks it as a
spilled constant scalar.  When key < max_entries, check_helper_call() sees
can_elide_value_nullness() and marks r0 as non-null:

kernel/bpf/verifier.c:check_helper_call() {
    ...
		if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
		    can_elide_value_nullness(meta.map.ptr) &&
		    meta.max_map_key < meta.map.ptr->max_entries)
			ret_flag &=3D ~PTR_MAYBE_NULL;
    ...
}

Dead-code elimination then strips the conditional jump and the drop branch
before bpf_do_misc_fixups() inlines the lookup, so the translated program
ignores r0 from the inlined lookup and unconditionally sets r0 =3D 2.
Storing the key at r10 - 4 or reading the returned element pointer would
keep the runtime check intact.

[ ... ]
> +static void check_jmp32(int prog_fd, __u32 max_entries, const char *what)
> +{
> +	struct bpf_prog_info info =3D {};
> +	__u32 info_len =3D sizeof(info), len;
> +	struct bpf_insn *xlated;
> +	__u32 i, jge32 =3D 0, jge64 =3D 0;
> +	int err;
> +
> +	err =3D bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
> +	if (!ASSERT_OK(err, "prog_get_info"))
> +		return;
> +
> +	len =3D info.xlated_prog_len;
> +	xlated =3D calloc(1, len);
> +	if (!ASSERT_OK_PTR(xlated, "calloc xlated"))
> +		return;
> +
> +	memset(&info, 0, sizeof(info));
> +	info.xlated_prog_len =3D len;
> +	info.xlated_prog_insns =3D ptr_to_u64(xlated);
> +	err =3D bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
> +	if (!ASSERT_OK(err, "prog_get_info xlated"))
> +		goto out;

[Severity: Low]
This isn't a bug, but could check_jmp32() use get_xlated_program() from
testing_helpers.h instead of open-coding the two bpf_prog_get_info_by_fd()
calls and allocation?  Also, test_array_gen_lookup_jmp32() loads the
program with key =3D 1 to run check_jmp32(), closes prog_fd, and then calls
run_lookup() which loads the exact same program a second time.

> +
> +	for (i =3D 0; i + 1 < info.xlated_prog_len / (u32)sizeof(*xlated); i++)=
 {
> +		if (xlated[i].code !=3D (BPF_LDX | BPF_W | BPF_MEM))
> +			continue;
> +		if (xlated[i + 1].code !=3D (BPF_JMP32 | BPF_JGE | BPF_K) &&
> +		    xlated[i + 1].code !=3D (BPF_JMP | BPF_JGE | BPF_K))
> +			continue;

[Severity: Medium]
Will check_jmp32() miss the bounds-check jump on 64-bit architectures where
bpf_jit_needs_zext() is true (such as s390x, riscv64, and powerpc64)?

When the patch list from map_gen_lookup() is applied, patch_list_adj_aux()
marks the 32-bit index load with zext_dst =3D true.  In
bpf_opt_subreg_zext_lo32_rnd_hi32(), architectures with
bpf_jit_needs_zext() insert a zero-extension instruction right after the
load at xlated[i + 1], which shifts the bounds-check jump to xlated[i + 2]
and leaves jge32 at 0.

[ ... ]
> +void test_array_gen_lookup_jmp32(void)
> +{

[Severity: Low]
Can check_jmp32() fail when /proc/sys/net/core/bpf_jit_harden is enabled
on the host or toggled by another test running in parallel under
test_progs -j?

When bpf_jit_harden is 2, bpf_jit_blind_insn() rewrites the immediate
bounds-check jump into register-based instructions using the auxiliary
register before exposing the translated instructions, so jge32 stays 0.
Other tests that inspect translated instructions (such as
serial_test_patch_list()) use the serial_test_ prefix and set
/proc/sys/net/core/bpf_jit_harden to 0 while loading the program.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115102559.4653=
75-1-chenyuan@kylinos.cn?part=3D2
