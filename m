Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068273B7750
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541775; cv=none; b=Pqcu65JMmSZHxKkG2ldY8jowvwBYWb9gw9Jr5Vi8N9Z4tNi9jVJmUC26WgLXbd6LRPBrX4kJv/xjElB1hK0G3jorLkFMnOQtJ0AiQEYYwJwpku7KJotzWs/7ISiBB6nmFoNAHyL2O76faZ62g6QeDYkl6BnlUzHzwqbd6gM9HjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541775; c=relaxed/simple;
	bh=2H0MXCG8PGyisST7LsT4NPmRvQmpm40INlYQguhNalU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TGN4Z6orr3begm/wzoOQS6gx/vRgXKMFUkXPBbGueMIdB3LeEiH6ss4W0Zsk1dCCH39vQBbya0CigU+sqpTV+3hQ71qpz5lYz6DfxLfKML3hQLYvuPUt18+xkPHEG1+fLzRO11Pl1L2o4oJUDlScHHGTxh7WzWh9Hc0aCxVMZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUKE4Aq5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUKE4Aq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4E81F000FF;
	Sun, 27 Sep 2026 20:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541773;
	bh=o23uZXPRWowG2FoEQsfpH0QKuVGBCDsaSo+hwh8yflk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RUKE4Aq5kEcYsOGGE8cf9rC7Z2miBJ0WtwVtpEFij08/6uDtEBcu3KGWd+d6o9e+5
	 uGm8wHQ8kEPHvAByVbq6kKskwjVOkM+TnM+KURdT3npY6GDTpK0h68w+KYimwZhfMN
	 WsEtsckf33TEysRRCHMgwmEimlhSyciQh/WyayHRcRvnVjD/ImgzacYCKH7x6OqzAW
	 1SyfyP/6u8qDn0HxZ1GS57qjz/EHTskm4a2BhzGZWWkkFxLH/72C9HEnmz29cOunkl
	 0/IniW417HKKQcxg9p94+InQ9sUkoPW3BGZXusvRiKaCoqInfgOHDh/hMn+W7lwt6L
	 GvrAn8wYW8Pkg==
Content-Type: multipart/mixed; boundary="===============3615861331373378302=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9a141712e953b6cf3b27ddb58f0c212a27efa93dc0df088a5a2fd47151bc7459@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-33-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-33-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 33/36] selftests/bpf: tests for varying offset access to PTR_TO_BTF_ID
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:42:52 +0000 (UTC)

--===============3615861331373378302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> index e1d559ba1271..9f188ff9be89 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -26,6 +26,7 @@
>  #include "verifier_bpf_get_stack.skel.h"
>  #include "verifier_bpf_trap.skel.h"
>  #include "verifier_bswap.skel.h"
> +#include "verifier_btf_array_access.skel.h"
>  #include "verifier_btf_ctx_access.skel.h"
>  #include "verifier_btf_flex_array.skel.h"
>  #include "verifier_btf_unreliable_prog.skel.h"
> @@ -211,6 +212,7 @@ void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_u
>  void test_verifier_bpf_get_stack(void)        { RUN(verifier_bpf_get_stack); }
>  void test_verifier_bpf_trap(void)             { RUN(verifier_bpf_trap); }
>  void test_verifier_bswap(void)                { RUN(verifier_bswap); }
> +void test_verifier_btf_array_access(void)     { RUN(verifier_btf_array_access); }
>  void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
>  void test_verifier_btf_flex_array(void)       { RUN(verifier_btf_flex_array); }
>  void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
> new file mode 100644
> index 000000000000..ab6b74457365
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
> @@ -0,0 +1,506 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +#include "bpf_experimental.h"
> +#include "bpf_misc.h"

[ ... ]

> +/*
> + * Array nested below a struct member at a non-zero offset. The walk descends
> + * through 'm' (resetting the running offset) before reaching 'arr', exercising
> + * the array_start = min_off - arrays[i].off telescoping across a WALK_STRUCT
> + * dive.
> + */
> +struct mid {
> +	struct inner arr[8];	/* stride 8, size 64 */
> +};
> +
> +struct nest {
> +	long pad;		/* off 0 */
> +	struct mid m;		/* off 8 */
> +};
> +
> +/* m.arr[i].b, i in [0, 7], 4-byte read: stays within m.arr. */
> +SEC("syscall")
> +__success
> +int nested_struct_in_bounds(void *ctx)
> +{
> +	unsigned long i = bpf_get_prandom_u32();
> +	struct nest *o;
> +	int val = 0;
> +
> +	o = bpf_obj_new(typeof(*o));
> +	if (!o)
> +		return 0;
> +	asm volatile ("						\
> +	r1 = %[o];						\
> +	r2 = %[i];						\
> +	r2 &= 7;						\
> +	r2 *= 8;						\
> +	r1 += r2;						\
> +	%[val] = *(u32 *)(r1 + 12);				\
> +"	: [val] "=r"(val)
> +	: [o] "r"(o), [i] "r"(i)
> +	: "r1", "r2");
> +	bpf_obj_drop(o);
> +	return val;
> +}

Does this test actually exercise the WALK_STRUCT path described in the
comment? The comment says the test exercises "offset telescoping across a
WALK_STRUCT dive," but with offset 12 (reading m.arr[i].b), the walk
path appears to skip the WALK_STRUCT branch.

Looking at btf_struct_walk() in the verifier, it only returns WALK_STRUCT
when the offset exactly equals a member's start:

    if (btf_type_is_struct(mtype)) {
        t = mtype;
        if (off == moff) {
            *next_btf_id = mid;
            return WALK_STRUCT;
        }
        off -= moff;
        goto again;
    }

With min_off at 12:
- At nest, m starts at moff 8 but off is 12, so it takes 'goto again'
  with off 4
- At mid, arr[0] starts at moff 0 but off is 4, so it takes 'goto again'
  again
- At inner, it finds b and returns WALK_SCALAR

The WALK_STRUCT branch in btf_struct_access() is never reached, so the
offset reset and arrays[] re-entry that the comment describes doesn't
occur.

Would reading m.arr[i].a (r1 + 8) instead put min_off at offsetof(struct
nest, m), causing the walk to go through WALK_STRUCT twice (nest->mid,
then mid->inner) and cover the telescoping path the comment describes?

> +
> +/* m.arr[i].b, i in [0, 15]: max offset runs past the end of m.arr. */
> +SEC("syscall")
> +__failure
> +__msg("invalid variable offset access into struct nest")
> +int nested_struct_out_of_bounds(void *ctx)
> +{
> +	unsigned long i = bpf_get_prandom_u32();
> +	struct nest *o;
> +	int val = 0;
> +
> +	o = bpf_obj_new(typeof(*o));
> +	if (!o)
> +		return 0;
> +	asm volatile ("						\
> +	r1 = %[o];						\
> +	r2 = %[i];						\
> +	r2 &= 15;						\
> +	r2 *= 8;						\
> +	r1 += r2;						\
> +	%[val] = *(u32 *)(r1 + 12);				\
> +"	: [val] "=r"(val)
> +	: [o] "r"(o), [i] "r"(i)
> +	: "r1", "r2");
> +	bpf_obj_drop(o);
> +	return val;
> +}
> +
> +/*
> + * A trailing flexible array member makes the struct tail an unbounded region,
> + * so a varying access into it has no upper bound to exceed (mirrors how
> + * unix_address.name[] is accessed via sun_path[i]).
> + *
> + * A custom (program) BTF struct can only be reached as a PTR_TO_BTF_ID through
> + * bpf_obj_new(), which does not allow flexible array members. So use a kernel
> + * type via an untrusted PTR_TO_BTF_ID (bpf_core_cast()). struct vring_used ends
> + * with a flexible array 'ring[]' of struct vring_used_elem { __virtio32 id, len; },
> + * mirroring a 'struct foo { int a; int b; }' flexible array.
> + */

Is the justification here accurate? The comment states that "bpf_obj_new()
does not allow flexible array members," which also appears in the commit
message:

    A program-defined struct cannot be used here because bpf_obj_new()
    forbids flexible array members

However, looking at the verifier, bpf_obj_new() itself doesn't reject
flexible array members. The obj_new path in check_kfunc_call() only
checks that the type is a struct and allocates ret_t->size bytes.

tools/testing/selftests/bpf/progs/linked_list_fail.c already has
obj_new_flex_array that allocates a struct with a flexible array member
using bpf_obj_new_impl():

    struct obj_new_flex {
        int hdr;
        struct obj_new_flex_elem cells[];
    };

It only fails later on access with "access beyond struct obj_new_flex."

The real restriction appears to be that btf_struct_access() passes
walk_flex_arrays = !type_is_alloc(reg->type), so flexible arrays aren't
walked for MEM_ALLOC registers.

Also, a program-BTF struct can be reached as a non-MEM_ALLOC PTR_TO_BTF_ID
through other means. Loading a __kptr field of a local type outside an RCU
critical section yields PTR_TO_BTF_ID | PTR_MAYBE_NULL | PTR_UNTRUSTED
without MEM_ALLOC (through btf_ld_kptr_type()). For such a register,
btf_struct_walk() does walk flexible arrays.

tools/testing/selftests/bpf/progs/verifier_btf_flex_array.c:stash_and_peek
already uses exactly this approach to reach the flexible array walk with a
program-defined struct in a SEC("syscall") program (which is outside RCU by
default).

Should the comment and commit message give the correct reason instead? The
current explanation also creates a dependency on struct vring_used being in
vmlinux BTF, which only exists when virtio is built in.

> +
> +/* ring[i].len, i in [0, 63], 4-byte read: the flexible array has no upper bound. */
> +SEC("syscall")
> +__success
> +int flex_array_field(void *ctx)
> +{
> +	unsigned long i = bpf_get_prandom_u32();
> +	struct vring_used *o;
> +	int val = 0;
> +
> +	o = bpf_core_cast(bpf_get_current_task_btf(), struct vring_used);
> +	asm volatile ("						\
> +	r1 = %[o];						\
> +	r2 = %[i];						\
> +	r2 &= 63;						\
> +	r2 *= 8;						\
> +	r1 += r2;						\
> +	%[val] = *(u32 *)(r1 + 8);				\
> +"	: [val] "=r"(val)
> +	: [o] "r"(o), [i] "r"(i)
> +	: "r1", "r2");
> +	return val;
> +}
> +
> +/*
> + * ring[] accessed with step 4 (half of sizeof(struct vring_used_elem)): the
> + * step is not a whole number of elements, so the flexible array stride does
> + * not match.
> + */
> +SEC("syscall")
> +__failure
> +__msg("invalid variable offset access into struct vring_used")
> +int flex_array_unaligned_step(void *ctx)
> +{
> +	unsigned long i = bpf_get_prandom_u32();
> +	struct vring_used *o;
> +	int val = 0;
> +
> +	o = bpf_core_cast(bpf_get_current_task_btf(), struct vring_used);
> +	asm volatile ("						\
> +	r1 = %[o];						\
> +	r2 = %[i];						\
> +	r2 &= 7;						\
> +	r2 *= 4;						\
> +	r1 += r2;						\
> +	%[val] = *(u32 *)(r1 + 4);				\
> +"	: [val] "=r"(val)
> +	: [o] "r"(o), [i] "r"(i)
> +	: "r1", "r2");
> +	return val;
> +}
> +
> +char _license[] SEC("license") = "GPL";

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============3615861331373378302==--
