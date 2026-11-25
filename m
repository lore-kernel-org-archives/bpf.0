Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644901;
	b=JLPjxgE2RkJVYTAFy/8mCQyEwyixj1X9jf1wLpAvxVb+v0N8rWkmZNhOilNTbsk1UKd5
	 MUUimEXQXd9WsmWfa1WmjDEPgnXoTb9SRXqFPHyM4EFfYms7Zy7dxMGh+R05G1WAUskau
	 +YCqkiin1S7p/HWrfPL7/uHLEE6x1roD1SbiLFrSbFX3mZRXdnKBWXIpf/49OFwrbxwt3
	 hCGgpJqg/2IaK5sBGI9sKrOugfegbGBRy0q0tkdUDKLw+OgUA+/j396y3ZvNGwNJhCrVR
	 iOtLS26TVpuQ6QDF16un/z8lgoEH4a5r3uGFIyGBGO6ygqqPlMyRhqY0i+fP5ZL0UaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644901;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=V9anp00Gccli3hB5u4PWUWPgORId09KraOOTsdodoKk=;
	b=1DcggxCswLN7H0Ju/aaO9hdANoUxRYczEr0mcq0n/l1WjFBpaXJXtJaHmN+uySPOOIv2
	 n7orT0IGdXshTRhO1l8QurdAnjFXobZZJOspHtVSpZ0FMYejsibFmTrcEQT0fIxejyEDh
	 VNUXicHpK9TIAuUCHMImCdZ8ceEPIsBznZzEypBRyaucL7j6RgV9m5qJqeaPGNpEEyyiy
	 BS7FCIoxFhCXmbK2A/x+1t4zl2MMNTrlHwHD5uPS5CURU+crDwOAjv2GD16TGMUsGRyLA
	 AkN506NcnM7FErcYYiGa0TZs9sfcxrJFUem6Kuam/EqR39aj7TLMHEJtxCYNYkTG3mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwafiTn8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3BE606A32A
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwafiTn8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3111F000C4;
	Wed, 25 Nov 2026 22:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795644901;
	bh=V9anp00Gccli3hB5u4PWUWPgORId09KraOOTsdodoKk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dwafiTn8Mq0tyJ4w9i1N43S/NM5mOlh4ZpkhGORssky9WhDo+Ksak4ktm7x/1phHp
	 wK9auphORfnUtADXLTmH5yhKTGgnLWkJupLjoWRByYCbdBK4RYV2ZkKHdMKjtJ+YJZ
	 jHWwS31dPetNBNdT+/KVZrtrg9nvc6Uu11f+QjwChIkRSFncz8DTDSrZ+R5ikHRK69
	 E/YpB8c2QjcRVm4sBJmvvCmpZoOAuONJIA7Bdy25luLs5vbdOKkT7h7FJLC0+8d+YM
	 h2CNl8KhdPzCBE6ukJ3m8yL6T+acScCj3vNMPMY3kAlKKvx8iXMHEMZw2OuOnqPsPJ
	 pTc1WRlGb16zg==
Content-Type: multipart/mixed; boundary="===============1227930402520077500=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <60e66815fcf2117a391927fc894fca80573a652ac302d35b2d680ee6f401dfae@mail.kernel.org>
In-Reply-To: <20261125212849.868523-2-a.s.protopopov@gmail.com>
References: <20261125212849.868523-2-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/5] resolve_btfids: Do not tag functions which work on BPF objects
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,jolsa@kernel.org,almagui@kernel.org,john.fastabend@gmail.com,bpf@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 22:14:59 +0000 (UTC)

--===============1227930402520077500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Do not tag functions which work on BPF objects

TL;DR: Test issue: skipping bpf_* parameter types likely leaves vmlinux
bpf_dummy_reg() untagged, so the tag_of_vmlinux selftest may no longer test
anything and its comment is stale.

> diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> --- a/tools/bpf/resolve_btfids/fmodret.c
> +++ b/tools/bpf/resolve_btfids/fmodret.c

[ ... ]

> @@ -220,6 +251,9 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
>  		size = int_return_size(btf, t);
>  		if ((size != 4 && size != 8) || !fits_trampoline(btf, t))
>  			continue;
> +		/* Skip functions which take or return BPF objects */
> +		if (has_bpf_types(btf, t))
> +			continue;
>  		/* Init code is gone before a program can attach */
>  		name = btf__name_by_offset(btf, t->name_off);
>  		func = image_func(&img, name);

This isn't a bug, but does this change leave the tag_of_vmlinux subtest
without anything to test?

In tools/testing/selftests/bpf/progs/fmodret_retval.c:

    /*
     * vmlinux has a bpf_dummy_reg() of the same type, so the two share the
     * FUNC of vmlinux. That one returns an error and has a tag. This one
     * returns only 0.
     */
    SEC("fmod_ret/bpf_testmod:bpf_dummy_reg")
    __failure __msg("bpf_dummy_reg() is not modifiable")
    int BPF_PROG(tag_of_vmlinux, void *kdata, struct bpf_link *link, int ret)

The vmlinux function is:

    static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
    {
            return -EOPNOTSUPP;
    }

Its second parameter is a pointer to struct bpf_link, so is_bpf_type()
follows the pointer, matches the "bpf_" prefix, and has_bpf_types() returns
true.  fmodret_tag() then no longer emits "bpf_fmodret_retval:-95" for the
vmlinux bpf_dummy_reg().

The subtest exists to show that the verifier does not use the vmlinux tag
for the module function.  With no vmlinux tag left, the program is rejected
with "bpf_dummy_reg() is not modifiable" regardless of which BTF the lookup
searches, so a later change that made btf_find_func_tag_value() also search
base BTF would leave this test passing.  The comment "That one returns an
error and has a tag" is also no longer true.

None of the later patches in the series touch progs/fmodret_retval.c, and
prog_tests/fmodret_untagged.c does not cover this case.

Would a pair of same-named vmlinux and module functions with the same
prototype, where the vmlinux one is still tagged, restore the coverage?
Otherwise should the subtest and its comment be updated or removed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45706808075
--===============1227930402520077500==--
