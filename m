Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476186;
	b=4LNFCXk4cCnx1hanQDKf0xGh4dLffupKYdkGJ0kuUL3kyypU2Crn589hR0jQf/X3cfTD
	 5h3B7plJCBYqgV12CBCqld0x2bIOPlxDHlrx7n5lrtYCFx5WnoTFt7tK4Ww9IfcgYhmDZ
	 7mT/36okmOj9aNFO+KFxR5r9QsU3gqOjPFXEBT7ZSnXc12goO9v5HJkXJuBh5bD6JMota
	 xBJucRFFd41aPleAXUEbNIlX+jOHMu2GZfKbjW9VFBRA7w2R8UNKjXOLJN01F4g7Hf0DE
	 +/5Ngg/Wq6WS2npQOp0S2mYmoaSdR288Lbmd1TDHEjf/sgWKPiTa0k+V2Zuajm7Xj9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476186;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=GsmrKM2CDk0hjye2bElM6gkBzhsUXbVm/bu6E0pz+fI=;
	b=rKtEfXhsXFyLijUDHQV8q0X1SIr3L0gbKzL5qO03pbwNIaIFCfhIXslmjbi1ccXt12VG
	 SzufqR8NbA5bmACnjtJcA/wz6nt2yGO6vVgnN9XxNh7DYrdbpznIuOQP/heHI7Cd8UfaL
	 qQ4tqI8BlmKpAukxJ9gd/vaiTVbct2UMFJSDNsL4n1nzOfwGYRuvzzh4NEf2wzUWk1B6E
	 ZSd2s9IHmJ4i05ycOuZ4gYjjgkItRTWc5/KUiLFC7WOiWcOrA8DljLdkmXoh2ixUL534r
	 hWisFBq//OWDOiS/+GhpdodZxZ0AVC4mzIl4bb2VOZ5hvUo5o/8GM1KDhCwNukxVBMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfEG8Q2Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ADF606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfEG8Q2Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE261F000D1;
	Mon, 23 Nov 2026 23:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795476185;
	bh=GsmrKM2CDk0hjye2bElM6gkBzhsUXbVm/bu6E0pz+fI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VfEG8Q2Q+Vo8xYkbuPob86MA3MzNRST3TW4lm3q7JYUA67MRKNQceHAmxqx2bLn6F
	 5WyThjDteHoYzhoxtlk/zhHl7ir574CtPzqfeXc/YEvGfqlK+Hpe9sVFaLOHMcJ3nS
	 +p1H8r/tCxXuED3CRHZJdPejUVkZUaiP+gIgxbyKVQ8kzT549IOivF7jAIt+bwEr9p
	 /3xZiNd70LAL45SImlHvYPNKveGgOST0FDbKZVv9ZyvnrJlHhfpRi9I3u3HNYGr03q
	 QPFxmOsPneWSsWgig63lFKb3sDWX7ImxVBTc7pp4f5l/5tl1Lyar5HDdTGqysn/Tcq
	 PqxSW58bwqb1Q==
Content-Type: multipart/mixed; boundary="===============8537876250370688859=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <daac95452e1e87f874f41492facf95fd16118d93b67f7964e3510368751148b0@mail.kernel.org>
In-Reply-To: <20261123223227.745345-2-almagui@kernel.org>
References: <20261123223227.745345-2-almagui@kernel.org>
Subject: Re: [PATCH bpf-next 1/7] libbpf: Support CO-RE relocation of tracing program arguments
From: bot+bpf-ci@kernel.org
To: almagui@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,bpf@vger.kernel.org,almagui@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 23 Nov 2026 23:23:03 +0000 (UTC)

--===============8537876250370688859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Support CO-RE relocation of tracing program arguments

TL;DR:
- Changing attach target or type after bpf_object__prepare() may silently load
  stale argument offsets, reading the wrong arguments
- bpf_tracing.h comments advise by-value struct member access that can fail to
  load (non-8-byte-aligned offsets)

> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h

[ ... ]

> + * On big-endian architectures (e.g., s390x), the verifier only allows loads
> + * of whole 8-byte context slots, so loads of integer and enum arguments (and
> + * return values) smaller than 8 bytes are widened to their slot. That only

[ ... ]

> + * Structs passed by value that are larger than 8 bytes can't be copied out
> + * of the program context as a whole, so they can't be used as arguments of
> + * BPF_PROG_CORE; use an explicit __bpf_func_args struct and access their
> + * members individually instead.

Is this advice accurate for every struct?

btf_ctx_access() rejects any context offset that is not a multiple of 8, on
all architectures:

    if (off % 8) {
        bpf_log(log, "func '%s' offset %d is not multiple of 8\n", tname, off);
        return false;
    }

Nested member matching produces slot_offset + member_offset, so a member of
a by-value struct argument at a non-8-byte-aligned offset can never be read.
For example, with bpf_testmod_test_struct_arg_9(..., struct
bpf_testmod_struct_arg_5 h, long i), where the struct is { char a; short b;
int c; long d; }:

    struct args9 { struct bpf_testmod_struct_arg_5 h; } __bpf_func_args;
    ... return args->h.c;   /* ctx offset 7*8 + 4 = 60 */

This fails to load with "offset 60 is not multiple of 8", yet it is what the
comment recommends.  BPF_PROG2() handles this struct by loading whole u64
slots.  The same applies to by-value structs of 8 bytes or less with members
at a non-zero offset, such as { int a; int b; }.

Also, the big-endian paragraph says "the verifier only allows loads of whole
8-byte context slots".  bpf_tracing_ctx_access() only requires off % size ==
0, so narrow loads at the start of a slot are accepted.  The actual
constraint is 8-byte-aligned offsets, which is how the commit message
describes it ("only allows 8-byte-aligned context accesses").

Could both comments describe the 8-byte-aligned offset rule instead?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +/* Find the BTF type of the attach target of a BTF-attached tracing program */
> +static int bpf_prog_attach_target(const struct bpf_program *prog,
> +				  const struct btf **btf, __u32 *btf_id)
> +{

[ ... ]

> +	if (prog->attach_btf_id) {
> +		/* set via bpf_program__set_attach_target() */
> +		btf_obj_fd = prog->attach_btf_obj_fd;
> +		btf_type_id = prog->attach_btf_id;
> +	} else {
> +		const char *attach_name = strchr(prog->sec_name, '/');

Function-argument relocations are now resolved during bpf_object__prepare():

bpf_object__prepare() -> bpf_object__relocate() -> bpf_object__relocate_core()
  -> bpf_core_resolve_relo() -> bpf_core_args_find_cands()
    -> bpf_prog_attach_target()

bpf_program__set_attach_target() and bpf_program__set_expected_attach_type()
only reject obj->state >= OBJ_LOADED, so both still succeed in OBJ_PREPARED.
Before this patch nothing in prepare read the attach target, so open ->
bpf_object__prepare() -> bpf_program__set_attach_target() ->
bpf_object__load() worked.

With __bpf_func_args or BPF_PROG_CORE() in use, that sequence now loads
instructions whose context offsets and sizes were computed for the old
target.  At load time libbpf_prepare_prog_load() skips resolution because
prog->attach_btf_id is non-zero, and the new attach_btf_id is passed to the
kernel, so nothing is redone and nothing reports an error.

For example, SEC("fentry/foo") with struct args { int a; int b; } and foo(int
a, int b).  After prepare, bpf_program__set_attach_target(prog, 0, "bar")
with bar(int b, int a) loads fine, and args->a reads bar's slot 0, which is
b.  The verifier accepts it because both slots are scalars.  Changing fentry
to fexit via set_expected_attach_type() after prepare similarly leaves a
__bpf_func_ret member resolved as missing.

Can these setters be refused in OBJ_PREPARED for programs with function
argument relocations, or can the target used during relocation be recorded
and compared at load/clone time?  The commit message does not mention this
limitation, and no later commit in the series changes it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45283084474
--===============8537876250370688859==--
