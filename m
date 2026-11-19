Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067689;
	b=V4SCtg2Zj/b51ke4zEEw50TOWl+QKrn2whDpucUptkjf6Ti6XMEFmsu5qUFHBy22DvMs
	 0EQSNc3h4aHn9WuQ5g3OZw1qA5SIzmfkuwoMce+bgO03tmbB/h+VnPHRmwfgjoc8a4aGF
	 1hfcY8GzcKDsYtoBWlXao02jaUyJQlNmoW5Ah7t0CMPO/PrPeVH3300kdrIP0+tR9joaL
	 Iom5bTozjlojEhtSXxgYG9Zr8gWxOJmCHKvwikSTyRphNx+hC4htMLjlqyDWzXqfvj66i
	 tjvtFg5p1+P2/unQcD+Lpk9OaW/hnaSfavmYWy/zpapeCfvxG0QMKsL16zssxzbbt5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067689;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=w9gT3Yxkj/ETOc7+oy0JbXNq+OZp8B4up/OpOWOsd7Q=;
	b=iXVxNdtUiqO4cr1VvhW/gK3f/iuKR+5A2yDkWxkkzXctD3HsrZUvnzoGxXV01gkjOxCH
	 1zurXZ6G+bXDWIZ3aycsm7B096eb8/WMHtA8puGF/aGDC3Yj0WGzIMKV2/dDGYFU16XoD
	 HJBTM9nEHDskO6OUTHTTYOHuWl0df+EDLWWMdm1Q5IgnDzTmgWuJOzGzWsl8mrWA5m+D9
	 7H3qcyVjmyKoMulQlUDhKWHz/b6g+Lk42nlh+ln9oFUEavAFHmpXsyzUGM+BmxCV748j0
	 I7beRLV7aWCgEnHedsfXvy/Rjl2kwAAPRrat0y18sHCQ+6Mj0Tym2tM070UHFaT8kbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KttKWvqS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE81606A332
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KttKWvqS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BE51F000C5;
	Thu, 19 Nov 2026 05:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795067688;
	bh=w9gT3Yxkj/ETOc7+oy0JbXNq+OZp8B4up/OpOWOsd7Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KttKWvqSC2Z2K/YUnzZlZ92HB5oSNqOBIWiaikcXm9hX1KuGGp7GhXa1zzgRJtmWO
	 Qphikp7g+hPaD/b7lrMjd68UTX4zgnAsdmPzO+u6xs99aSCU6BnHARCGppNVJeyJPz
	 1IN3UQxyPIPKpsBWToAON9bt+fs5Xq1Xpdm3mvh3udowf5jC/P3tzTyYFQBqhcy92d
	 22CACSY5vByXWQUIrV/Drt3PPQ/2lxiSPdOfi97LXagQuZENK3mmGHBSHuG1VzRF6o
	 Yj+YaNH9ObF9+hFFsVb8W6e6+LPNLgB/qcjISTuQBLB+QjYHAm4FJo9U25SelsBDrf
	 /pf+Jw5L1OLMw==
Content-Type: multipart/mixed; boundary="===============8817275863650509165=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4b1c106f8c17afddbdacf8814838a3c0aca16456e7655da2be23bad0bc40405f@mail.kernel.org>
In-Reply-To: <20261119051453.1902726-1-yonghong.song@linux.dev>
References: <20261119051453.1902726-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Test CO-RE relocations of unsigned 32-bit enum values
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 19 Nov 2026 05:54:48 +0000 (UTC)

--===============8817275863650509165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test CO-RE relocations of unsigned 32-bit enum values

TL;DR: The new enum test likely fails core_reloc/enumval on the GCC-BPF flavor
at this commit, since GCC sign-extends the value; fixes come later in the
series, so it isn't bisectable.

> diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
> --- a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
> +++ b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c

[ ... ]

> @@ -64,6 +72,12 @@ int test_core_enumval(void *ctx)
>  	out->anon_val1 = bpf_core_enum_value(anon, ANON_ENUM_VAL1);
>  	out->anon_val2 = bpf_core_enum_value(anon, ANON_ENUM_VAL2);
>  	/* ANON_ENUM_VAL3 value is optional */
> +
> +	/* enum named_uint_enum is optional */
> +	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL1))
> +		out->uint_val1 = bpf_core_enum_value(enum named_uint_enum, UINT_ENUM_VAL1);
> +	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL2))
> +		out->uint_val2 = bpf_core_enum_value(enum named_uint_enum, UINT_ENUM_VAL2);

Will this pass for the GCC-BPF flavor of the object (test_progs-bpf_gcc)?

Under !__clang__, bpf_core_enum_value() expands to
__builtin_preserve_enum_value(), which returns int, so GCC emits the
ld_imm64 sign-extended (for example lddw %r1,-2147483648 for 0x80000000).

With f3507c4b38e8 applied, bpf_core_calc_enumval_relo() gets orig_val from
btf_enum_value(), which is (__u32)e->val for a kflag 0 enum, and
bpf_core_patch_insn() then validates it against the instruction:

    imm = (__u32)insn[0].imm | ((__u64)insn[1].imm << 32);
    if (res->validate && imm != orig_val) {
        pr_warn("... unexpected insn #%d (LDIMM64) value: ...");
        return -EINVAL;
    }

For the GCC-built object imm is 0xffffffff80000000 while orig_val is
0x80000000, so bpf_object__load() should fail and ASSERT_OK(err,
"obj_load") would fail core_reloc/enumval, and core_reloc_btfgen/enumval
the same way.  ENUMVAL_CASE(enumval) does not set .fails, neither subtest
is in ci/vmtest/configs/DENYLIST.test_progs-bpf_gcc, and the gcc-bpf job
(KERNEL_TEST: test_progs-bpf_gcc) runs on x86_64.

Even with only the libbpf fix, the int result stored into the new long
uint_val1/uint_val2 fields would read back as 0xffffffff80000001, while
core_reloc.c expects 0x80000001 and 0xffffffff.

This looks to be fixed later in the series, and both are needed for GCC:

  aa93e7e947e0 ("libbpf: Accept sign-extended 32-bit enum values in CO-RE
  relocations") makes libbpf accept the sign-extended form.

  ec81091d83f1 ("selftests/bpf: Take unsigned enum values as unsigned int
  for GCC") adds UINT_ENUM_VALUE(), which casts to unsigned int under
  !__clang__.

Until both land, test_progs-bpf_gcc fails at this commit, so the series is
not bisectable for that flavor.  Could those changes be folded into this
commit and f3507c4b38e8, or the series reordered?

The commit message also describes only the clang behaviour ("whose values
clang emits zero-extended in the ld_imm64 of the relocations").


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44465301903
--===============8817275863650509165==--
