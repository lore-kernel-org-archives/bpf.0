Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758372;
	b=ayILHcAOw1Y+XQoxsF+V/XMOdh642xEKqSRyUzeqOI3xitDXmc4su+bXfYiI8oiTz8oj
	 avAQcT/X5VnurhdRqVfUReP7RnbhHpmQTJ+wlUoJjnCRuETh06enlJQkkeeu6lHe9AkJf
	 oPOKNhh/q//j0T0imIKthRJeDVRV+a3vzaCWoxynksDoucvQL1w9kTqXv0KFfX5g+Ij0e
	 Smy/K24ABHN3U+ZGRwlMCS9O3U1cBwmumLVj1yWOc8PoNnW7xnXaj4Rgn7cJvCZ2PM2Qi
	 PbxBfuycmo1ljtfYvC8eIB5JDYZKbM1XBv5AOeIUt8lKKEF/TOCjPcbTNUMJAt/dfEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758372;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=E6qYmbdS1aTuYvFHeAxo+rkVIN5rdLZm18+CbYkp5y8=;
	b=GCkSnNbGmcyq1AqL1VgbdR0dgVDoNTLRjHEekyinx17GCTuwpbMnts9+OlQjRDN3+ioY
	 5t/iOdDbtMj1AsR4tApNOtprPB9OYE0PlYavygIH4yHtmmQzT/D39lk/lEO0D4hJS2HYn
	 5cQNIeiFuDp7GOAPemeekwRuuMYIh3TfXMMnhqaddrHxuK2hmeA/rvs2f3o6drD6o+3cw
	 HLgdSHwvWW1ErI2m38sHd8REw3P1CL4g8HQpPKCyQYnrFPv8fmG/8mRTb8tcCndyjjEBV
	 b8i7eeA2zgH4451j4j9AK7TJfPlTE0OLC6L00IGhiPESsUpmFM/M5aPr+//3f153vlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kle7Vg+F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11F0606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kle7Vg+F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669921F000C1;
	Wed,  4 Nov 2026 02:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793758371;
	bh=E6qYmbdS1aTuYvFHeAxo+rkVIN5rdLZm18+CbYkp5y8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kle7Vg+Fx7qfch97nxwSTDi7gpZpx5ZmDNm2PsmDHuOKo+qxdgJC+HuNunFP1iBkt
	 qpxdahAjmUpm/1NSbtpHB7HZ6mXAKC/kv5V55ZVWXKO448i5xdxdqQL1swvbf+Ew8N
	 hqF1cZxKpKsPAZUmGGz7Pb5WDqQHyoucA7LPNcxZOrgMW//8hKTQPbaukMuHfyg14E
	 L7oGI3Wsxlz0fy0mc36tAadOtkCDfgI/n1YpPbKanbvHjDGrQTU4jsUfOSd7yesFsv
	 C8BfWfi/AuYcNVT3y47omF6xUVNbo39PDhBcv1Wvd7elK2xOA46fT7odjEQBHvlGRI
	 2h9UyIvm5c1xA==
Content-Type: multipart/mixed; boundary="===============7445167922784116080=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20624e1d325fbb5acc44943f55c08b622648583bce6559911be3cf47d2d882ec@mail.kernel.org>
In-Reply-To: <20261104012401.1354861-4-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 03/14] bpf: Treat addr_space_cast of a pointer that is not in arena as a move
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 02:12:51 +0000 (UTC)

--===============7445167922784116080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Treat addr_space_cast of a pointer that is not in arena as a move

TL;DR: is_cast_mov() may treat arena pointers loaded from bpf_obj_new()
objects (untrusted mem) as as(0); previously working programs may now fail to
load on stores or silently read zeros on loads. Commit message doesn't mention
this.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +static bool is_cast_mov(const struct bpf_insn *insn, const struct bpf_reg_state *src_reg)
> +{
> +	/* cast from as(1) to as(0) */
> +	if (insn->imm != 1)
> +		return false;
> +
> +	switch (base_type(src_reg->type)) {
> +	case SCALAR_VALUE:
> +	case PTR_TO_ARENA:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}

Is it correct for is_cast_mov() to treat every pointer type other than
PTR_TO_ARENA as already being in as(0)?

A load of a non-struct pointer member (for example 'u64 __arena *data')
from an object described by program BTF, such as one from bpf_obj_new(),
bpf_percpu_obj_new() or a local kptr, goes through btf_struct_walk() which
returns WALK_PTR_UNTRUSTED.  Unlike WALK_PTR, btf_struct_access() has no
type_is_alloc() exception for it:

    case WALK_PTR_UNTRUSTED:
        *flag = MEM_RDONLY | PTR_UNTRUSTED;
        ret = PTR_TO_MEM;

So after something like 'e->data = bpf_arena_alloc_pages(...)', loading
e->data gives PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED, but the value in
the register is an arena user address, since arena_alloc_pages() returns
clear_lo32(arena->user_vm_start) + uaddr32.  When the program dereferences
it, clang emits 'rX = addr_space_cast(rY, 0, 1)'.

Before this patch rX became PTR_TO_ARENA, the access was rewritten to
BPF_PROBE_MEM32, and it reached the arena page.  After this patch the cast
is lowered to 'rX = rY' and rX stays rdonly_untrusted_mem:

- A store through rX is now rejected at load time ("cannot write into
  rdonly_untrusted_mem").

- A load through rX becomes a BPF_PROBE_MEM load from the 64-bit user VA.
  The x86 JIT emits its "src_reg + off > TASK_SIZE_MAX + PAGE_SIZE" check
  for that load, so the program reads zeros instead of the arena contents,
  and nothing reports it.

The commit message says these members are rdonly_untrusted_mem and "the
cast is a move too", but it does not say that these registers hold as(1)
addresses rather than kernel addresses, or that programs which loaded and
worked before now either fail to load or silently read 0.

Could btf_struct_access() return SCALAR_VALUE for WALK_PTR_UNTRUSTED when
type_is_alloc(reg->type), as it already does for WALK_PTR, so that such a
member takes the cast_arena path?  Alternatively, should is_cast_mov() not
treat untrusted memory derived from program BTF as as(0)?

The same applies to the case in the commit message of an untagged
(gcc-built) kernel __arena member: there, writes would stop loading
instead of reaching the arena.

No later commit in the series changes is_cast_mov() or the
WALK_PTR_UNTRUSTED handling.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41755299448
--===============7445167922784116080==--
