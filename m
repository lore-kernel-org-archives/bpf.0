Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086D33936F
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418807; cv=none; b=QHul+EDCE+j9CldGTiU3I0sFXVi9SPx63ORags8ApgfOuDd3jIAt4cn8QtIlv64YBHHnKFsORl0jfHXdB1ACf3An85bfmrr1m26xQWMRVA9msY9UJpln9FDDoFpFs7Ydi0s4mPi6N7u1r5DH7II59Iub6Pw9I4/X9n25sVBkSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418807; c=relaxed/simple;
	bh=at0xow6Pkbm9RKyxI9Ni0bLZG+PtU2WhkFDAbik1riA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UXnFj8QjRnHlxZasVLPFHnGaecYC8g9kcPsFPmU6MorIqzyy2vsZjeNcMAtjJRekjXkTERbKDBIXPsMjAKHvHGk/qWZQQnXL7W5BcdxWR0Qv9Mj2lBXFLGJIv2Lg7UJG7WWdXBANWKsvqUWCeFAm8k/3hrluVGIs57hfltYTviQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rk8RDS5T; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk8RDS5T"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed6d6eso18019725ad.2
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789418805; x=1790023605; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OyAH/shxqFMyT1AhH1nqWKxJFZ6X51xar7vvuBrPEms=;
        b=Rk8RDS5TwQMyLUnBPImSWVbpGUEXZA5NqjqVTTiccDNv3AK2pdbvyRFjc9c747A9Jg
         MSHZx/r6OV++QRpxvzDTYzRHLqyJcjLbMf/fYgWZhpaX3j3mFpNmp3nZuHR25YXPVn+c
         v3hcqgJYzI0mD+D9l2XAH+n89412F6HIAONDka1pGObg8nZmhXgXBPXXl5WYAHC2gaEt
         a9I4pwdc0gq+U3jKd5/yk5HknSVrXZ8MKz6RbF36h6N3cGF/aXeRnYToycKX9is2iUmB
         T+DLRh8g88inU/+IF4gFU/T7Dhh3S+z89QGuD5D3si/OT81SBFhagB86vhmcFLV2RhC0
         GCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789418805; x=1790023605;
        h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OyAH/shxqFMyT1AhH1nqWKxJFZ6X51xar7vvuBrPEms=;
        b=ya/qkggKoxy8Qy5WAW2LKm3GqGxG75/rIDF01chqAdVlP4ToV1Qg9xVLzGcmvmUujl
         yz3HXQbRmsh80iFEjifhyCv/SHh6Ch0lPdVM5fcm5VFXq1n4T+LDmLr0gtQjtIvVMUea
         Nt/rXWI2FphJSOe4Npvs1uQ8/jxzS0x9p3pFUy3JHHqAeBUeYPR4XQHN+eHIpEluv4tA
         HICzlPrePpPgTywHZF5NETyL5w+jKVgGiYKcPtzanq1XWu2PxGYA44atbjJE7je4a2NO
         acGeEV9a1suMiceLWGo8xFlWpysgsLNqiK5eDnMkefiWcIi4Ne58Cv4kk9Sim5cDFriH
         zGiQ==
X-Forwarded-Encrypted: i=1; AKwUvByzVL7D+rZ2czQM/rb9FSp+eKIFVecbtxR/uSFf4pCzJI5deXMA+PqmQ+Q59dMKlK9E6ls=@vger.kernel.org
X-Gm-Message-State: AFuF++lXRIfXCKPk7DspYD7V+z4oa+D1XQj46NI041kA1CzIX+w9zcFs
	B4jH+jt3Xh4LzSuWqEN+QG0rilRYsZmbB627IdVDL4IVVPYcdu3e4pUV
X-Gm-Gg: AYBFou08SglyvjX00zogaLAtwdWzBj9hA+KJbBsrHbhwLZNTBXQm2CuIF5oA3CzKcLP
	zAEOp+WRJA2CIoQv6b/FhTM4qxkKy/xdv+K/4YFKbOx8GvQ7L2YBmTd6eY4fpBN7YU/MsM06on0
	i/5G5PG8wi6xp5RfLFQOixzf1W3S5IfLDMbcRYebeeFYWw27rrqGl2oy81ts83ddfHf4jCpBz+0
	tS3Ya6LbIPm0PYvWWLXEQwqz1AFu7Fv62Szj5AThyxRJM9nlup3LwjFbiMw0fSs2w+MBnTsi5m8
	OIn9h1ITegpSRwPFnv0IU8OZMDCu3nkMU8VWpJfgABJesWwh39DrA7C/udFKbNbIthrjAzpl33z
	sdZ33Wd3Y7931pvcc5ylLmQuIyRGeSsFrVhiMKBo4TTJpLYXmJZMNWwsnzl/frDjSDfJlwzwgNR
	mv3fGA48i4lBCQBSLL9cbOVbnAPCtJdl/rjpF4Q4Da4JIwwGoq2yDYey5+/r0Ik1FY+WYUzpHaU
	0Fa5+71/Dnb65cLAbVUV7V7rnc=
X-Received: by 2002:a17:903:4585:b0:2db:210f:c104 with SMTP id d9443c01a7336-2dd6c6eb512mr94037965ad.10.1789418804913;
        Mon, 14 Sep 2026 13:46:44 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca6b7bsm55937725ad.3.2026.09.14.13.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:46:44 -0700 (PDT)
Message-ID: <3848f517c487c24d34ee5be3654ce8d550dab536.camel@gmail.com>
Subject: Re: [PATCH bpf v3 5/7] selftests/bpf: Test CO-RE instruction
 poisoning restrictions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Mon, 14 Sep 2026 13:46:41 -0700
In-Reply-To: <20260914131701.2529725-6-memxor@gmail.com>
References: <20260914131701.2529725-1-memxor@gmail.com>
	 <20260914131701.2529725-6-memxor@gmail.com>
Content-Type: multipart/mixed; boundary="=-tdwk31ifX8CHfgNGuDuw"
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-tdwk31ifX8CHfgNGuDuw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-09-14 at 15:16 +0200, Kumar Kartikeya Dwivedi wrote:

...

> +static void test_poisoned_insns(void)
> +{
> +	static const struct {
> +		const char *name;
> +		struct bpf_insn insns[2];
> +		bool relocatable;
> +	} tests[] =3D {
> +		{ "poison_exit", { BPF_EXIT_INSN() } },
> +		{ "poison_ja", { BPF_JMP_A(1) } },
> +		{ "poison_jmp", { BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1) } },
> +		{ "poison_jmp32", { BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 0, 1) } },
> +		{ "poison_call", { BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32) } },
> +		{ "poison_alu_reg", { BPF_MOV32_REG(BPF_REG_0, BPF_REG_1) } },
> +		{ "poison_alu64_reg", { BPF_MOV64_REG(BPF_REG_0, BPF_REG_1) } },
> +		{ "poison_ld_abs", { BPF_LD_ABS(BPF_W, 0) } },
> +		{ "poison_alu_imm", { BPF_MOV32_IMM(BPF_REG_0, 0) }, true },
> +		{ "poison_alu64_imm", { BPF_MOV64_IMM(BPF_REG_0, 0) }, true },
> +		{ "poison_ldx", { BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0) }, true =
},
> +		{ "poison_st", { BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0) }, true },
> +		{ "poison_stx", { BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4) }, tru=
e },
> +		{ "poison_ldimm64", { BPF_LD_IMM64(BPF_REG_0, 0) }, true },
> +	};
> +	struct bpf_func_info funcs[2];
> +	struct bpf_insn subprog[] =3D {
> +		BPF_CALL_REL(2),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	const void *raw_btf;
> +	struct btf *btf;
> +	__u32 raw_btf_size;
> +	int access_str_off, btf_fd =3D -1, enum_id;
> +	int int_id, main_id, prog_fd =3D -1, proto_id, sub_id, i;
> +
> +	btf =3D btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "btf_new_empty"))
> +		return;
> +	int_id =3D btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	if (!ASSERT_GT(int_id, 0, "add_int"))
> +		goto cleanup;
> +	proto_id =3D btf__add_func_proto(btf, int_id);
> +	if (!ASSERT_GT(proto_id, 0, "add_func_proto"))
> +		goto cleanup;
> +	main_id =3D btf__add_func(btf, "main_fn", BTF_FUNC_STATIC, proto_id);
> +	if (!ASSERT_GT(main_id, 0, "add_main_func"))
> +		goto cleanup;
> +	sub_id =3D btf__add_func(btf, "sub_fn", BTF_FUNC_STATIC, proto_id);
> +	if (!ASSERT_GT(sub_id, 0, "add_sub_func"))
> +		goto cleanup;
> +	enum_id =3D btf__add_enum(btf, "core_relo_poison_missing", 4);
> +	if (!ASSERT_GT(enum_id, 0, "add_enum") ||
> +	=C2=A0=C2=A0=C2=A0 !ASSERT_OK(btf__add_enum_value(btf, "value", 0), "ad=
d_enum_value"))
> +		goto cleanup;
> +	access_str_off =3D btf__add_str(btf, "0");
> +	if (!ASSERT_GT(access_str_off, 0, "add_access_str"))
> +		goto cleanup;

Nit: We have a BTF_*_ENC series of macro to assist with this in selftests.
     See attached diff.

> +
> +	raw_btf =3D btf__raw_data(btf, &raw_btf_size);
> +	if (!ASSERT_OK_PTR(raw_btf, "raw_btf"))
> +		goto cleanup;
> +	btf_fd =3D bpf_btf_load(raw_btf, raw_btf_size, NULL);
> +	if (!ASSERT_GE(btf_fd, 0, "btf_load"))
> +		goto cleanup;
> +	funcs[0] =3D (struct bpf_func_info) { .insn_off =3D 0, .type_id =3D mai=
n_id };
> +	funcs[1] =3D (struct bpf_func_info) { .insn_off =3D 3, .type_id =3D sub=
_id };
> +
> +	if (test__start_subtest("poisoned_subprog_terminator")) {
> +		prog_fd =3D load_core_relo_insns(btf_fd, subprog, ARRAY_SIZE(subprog),=
 funcs, 2,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum_id, access_str_off, 2, fa=
lse);
> +		if (!ASSERT_GE(prog_fd, 0, "control_load"))
> +			goto cleanup;
> +		close(prog_fd);
> +		prog_fd =3D load_core_relo_insns(btf_fd, subprog, ARRAY_SIZE(subprog),=
 funcs, 2,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum_id, access_str_off, 2, tr=
ue);
> +		if (!ASSERT_LT(prog_fd, 0, "poisoned_load"))
> +			goto cleanup;
> +		ASSERT_HAS_SUBSTR(log, "trying to relocate unrecognized insn #2",
> +				=C2=A0 "poisoned_load_log");
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
> +		struct bpf_insn insns[] =3D {
> +			BPF_MOV64_IMM(BPF_REG_0, 0),
> +			BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
> +			tests[i].insns[0],
> +			BPF_MOV64_IMM(BPF_REG_0, 0),
> +			BPF_MOV64_IMM(BPF_REG_0, 0),
> +			BPF_EXIT_INSN(),
> +		};
> +		int insn_cnt =3D ARRAY_SIZE(insns);
> +
> +		if (!test__start_subtest(tests[i].name))
> +			continue;
> +		if (insns[2].code =3D=3D (BPF_LD | BPF_DW | BPF_IMM)) {
> +			insns[3] =3D tests[i].insns[1];
> +		} else {
> +			insns[1].off =3D 1;
> +			insns[4] =3D BPF_EXIT_INSN();
> +			insn_cnt--;

Nit: this else block is not really necessary.

> +		}
> +		prog_fd =3D load_core_relo_insns(btf_fd, insns, insn_cnt, funcs, 1,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum_id, access_str_off, 2, fa=
lse);
> +		if (!ASSERT_GE(prog_fd, 0, "control_load"))
> +			goto cleanup;
> +		close(prog_fd);
> +		prog_fd =3D load_core_relo_insns(btf_fd, insns, insn_cnt, funcs, 1,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum_id, access_str_off, 2, tr=
ue);
> +		if (tests[i].relocatable) {
> +			ASSERT_GE(prog_fd, 0, "dead_poison_load");
> +			ASSERT_HAS_SUBSTR(log, "substituting insn #2", "poison_log");
> +			if (insns[2].code =3D=3D (BPF_LD | BPF_DW | BPF_IMM))
> +				ASSERT_HAS_SUBSTR(log, "substituting insn #3", "poison_ldimm64_log")=
;
> +		} else {
> +			ASSERT_LT(prog_fd, 0, "invalid_poison_load");
> +			ASSERT_NULL(strstr(log, "substituting insn"), "invalid_poison_log");
> +		}
> +		close(prog_fd);
> +		prog_fd =3D -1;
> +	}

...

--=-tdwk31ifX8CHfgNGuDuw
Content-Disposition: attachment; filename="btf-enc.diff"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="btf-enc.diff"; charset="UTF-8"

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2NvcmVf
cmVsb2NfcmF3LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9jb3Jl
X3JlbG9jX3Jhdy5jCmluZGV4IDE1OGIzZTJlM2Y1Zi4uYWViM2RkMmM3YjcyIDEwMDY0NAotLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9jb3JlX3JlbG9jX3Jhdy5j
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2NvcmVfcmVsb2Nf
cmF3LmMKQEAgLTcwLDcgKzcwLDM1IEBAIHN0YXRpYyB2b2lkIHRlc3RfcG9pc29uZWRfaW5zbnMo
dm9pZCkKIAkJeyAicG9pc29uX3N0eCIsIHsgQlBGX1NUWF9NRU0oQlBGX1csIEJQRl9SRUdfMTAs
IEJQRl9SRUdfMCwgLTQpIH0sIHRydWUgfSwKIAkJeyAicG9pc29uX2xkaW1tNjQiLCB7IEJQRl9M
RF9JTU02NChCUEZfUkVHXzAsIDApIH0sIHRydWUgfSwKIAl9OwotCXN0cnVjdCBicGZfZnVuY19p
bmZvIGZ1bmNzWzJdOworCXN0cnVjdCB0ZXN0X2J0ZiB7CisJCXN0cnVjdCBidGZfaGVhZGVyIGhk
cjsKKwkJX191MzIgdHlwZXNbMThdOworCQljaGFyIHN0cmluZ3NbNjRdOworCX0gcmF3X2J0ZiA9
IHsKKwkJLmhkciA9IHsKKwkJCS5tYWdpYyA9IEJURl9NQUdJQywKKwkJCS52ZXJzaW9uID0gQlRG
X1ZFUlNJT04sCisJCQkuaGRyX2xlbiA9IHNpemVvZihzdHJ1Y3QgYnRmX2hlYWRlciksCisJCQku
dHlwZV9vZmYgPSAwLAorCQkJLnR5cGVfbGVuID0gc2l6ZW9mKHJhd19idGYudHlwZXMpLAorCQkJ
LnN0cl9vZmYgPSBvZmZzZXRvZihzdHJ1Y3QgdGVzdF9idGYsIHN0cmluZ3MpIC0KKwkJCQkgICBv
ZmZzZXRvZihzdHJ1Y3QgdGVzdF9idGYsIHR5cGVzKSwKKwkJCS5zdHJfbGVuID0gc2l6ZW9mKHJh
d19idGYuc3RyaW5ncyksCisJCX0sCisJCS50eXBlcyA9IHsKKwkJCUJURl9UWVBFX0lOVF9FTkMo
MSwgQlRGX0lOVF9TSUdORUQsIDAsIDMyLCA0KSwgLyogWzFdIGludCAqLworCQkJQlRGX0ZVTkNf
UFJPVE9fRU5DKDEsIDApLAkvKiBbMl0gaW50ICgqKSh2b2lkKSAqLworCQkJQlRGX0ZVTkNfRU5D
KDUsIDIpLAkJLyogWzNdIG1haW5fZm4gKi8KKwkJCUJURl9GVU5DX0VOQygxMywgMiksCQkvKiBb
NF0gc3ViX2ZuICovCisJCQlCVEZfVFlQRV9FTkMoMjAsIEJURl9JTkZPX0VOQyhCVEZfS0lORF9F
TlVNLCAwLCAxKSwgNCksIC8qIFs1XSBlbnVtICovCisJCQlCVEZfRU5VTV9FTkMoNDUsIDApLAkJ
LyogdmFsdWUgPSAwICovCisJCX0sCisJCS5zdHJpbmdzID0gIlwwaW50XDBtYWluX2ZuXDBzdWJf
Zm5cMGNvcmVfcmVsb19wb2lzb25fbWlzc2luZ1wwdmFsdWVcMCIgIjAiLAorCX07CisJc3RydWN0
IGJwZl9mdW5jX2luZm8gZnVuY3NbXSA9IHsKKwkJeyAuaW5zbl9vZmYgPSAwLCAudHlwZV9pZCA9
IDMgfSwKKwkJeyAuaW5zbl9vZmYgPSAzLCAudHlwZV9pZCA9IDQgfSwKKwl9OwogCXN0cnVjdCBi
cGZfaW5zbiBzdWJwcm9nW10gPSB7CiAJCUJQRl9DQUxMX1JFTCgyKSwKIAkJQlBGX01PVjY0X0lN
TShCUEZfUkVHXzAsIDApLApAQCAtNzgsNDMgKzEwNiwxMiBAQCBzdGF0aWMgdm9pZCB0ZXN0X3Bv
aXNvbmVkX2luc25zKHZvaWQpCiAJCUJQRl9NT1Y2NF9JTU0oQlBGX1JFR18wLCAwKSwKIAkJQlBG
X0VYSVRfSU5TTigpLAogCX07Ci0JY29uc3Qgdm9pZCAqcmF3X2J0ZjsKLQlzdHJ1Y3QgYnRmICpi
dGY7Ci0JX191MzIgcmF3X2J0Zl9zaXplOwotCWludCBhY2Nlc3Nfc3RyX29mZiwgYnRmX2ZkID0g
LTEsIGVudW1faWQ7Ci0JaW50IGludF9pZCwgbWFpbl9pZCwgcHJvZ19mZCA9IC0xLCBwcm90b19p
ZCwgc3ViX2lkLCBpOworCWludCBhY2Nlc3Nfc3RyX29mZiA9IDUxLCBlbnVtX2lkID0gNTsKKwlp
bnQgYnRmX2ZkLCBwcm9nX2ZkID0gLTEsIGk7CiAKLQlidGYgPSBidGZfX25ld19lbXB0eSgpOwot
CWlmICghQVNTRVJUX09LX1BUUihidGYsICJidGZfbmV3X2VtcHR5IikpCi0JCXJldHVybjsKLQlp
bnRfaWQgPSBidGZfX2FkZF9pbnQoYnRmLCAiaW50IiwgNCwgQlRGX0lOVF9TSUdORUQpOwotCWlm
ICghQVNTRVJUX0dUKGludF9pZCwgMCwgImFkZF9pbnQiKSkKLQkJZ290byBjbGVhbnVwOwotCXBy
b3RvX2lkID0gYnRmX19hZGRfZnVuY19wcm90byhidGYsIGludF9pZCk7Ci0JaWYgKCFBU1NFUlRf
R1QocHJvdG9faWQsIDAsICJhZGRfZnVuY19wcm90byIpKQotCQlnb3RvIGNsZWFudXA7Ci0JbWFp
bl9pZCA9IGJ0Zl9fYWRkX2Z1bmMoYnRmLCAibWFpbl9mbiIsIEJURl9GVU5DX1NUQVRJQywgcHJv
dG9faWQpOwotCWlmICghQVNTRVJUX0dUKG1haW5faWQsIDAsICJhZGRfbWFpbl9mdW5jIikpCi0J
CWdvdG8gY2xlYW51cDsKLQlzdWJfaWQgPSBidGZfX2FkZF9mdW5jKGJ0ZiwgInN1Yl9mbiIsIEJU
Rl9GVU5DX1NUQVRJQywgcHJvdG9faWQpOwotCWlmICghQVNTRVJUX0dUKHN1Yl9pZCwgMCwgImFk
ZF9zdWJfZnVuYyIpKQotCQlnb3RvIGNsZWFudXA7Ci0JZW51bV9pZCA9IGJ0Zl9fYWRkX2VudW0o
YnRmLCAiY29yZV9yZWxvX3BvaXNvbl9taXNzaW5nIiwgNCk7Ci0JaWYgKCFBU1NFUlRfR1QoZW51
bV9pZCwgMCwgImFkZF9lbnVtIikgfHwKLQkgICAgIUFTU0VSVF9PSyhidGZfX2FkZF9lbnVtX3Zh
bHVlKGJ0ZiwgInZhbHVlIiwgMCksICJhZGRfZW51bV92YWx1ZSIpKQotCQlnb3RvIGNsZWFudXA7
Ci0JYWNjZXNzX3N0cl9vZmYgPSBidGZfX2FkZF9zdHIoYnRmLCAiMCIpOwotCWlmICghQVNTRVJU
X0dUKGFjY2Vzc19zdHJfb2ZmLCAwLCAiYWRkX2FjY2Vzc19zdHIiKSkKLQkJZ290byBjbGVhbnVw
OwotCi0JcmF3X2J0ZiA9IGJ0Zl9fcmF3X2RhdGEoYnRmLCAmcmF3X2J0Zl9zaXplKTsKLQlpZiAo
IUFTU0VSVF9PS19QVFIocmF3X2J0ZiwgInJhd19idGYiKSkKLQkJZ290byBjbGVhbnVwOwotCWJ0
Zl9mZCA9IGJwZl9idGZfbG9hZChyYXdfYnRmLCByYXdfYnRmX3NpemUsIE5VTEwpOworCWJ0Zl9m
ZCA9IGJwZl9idGZfbG9hZCgmcmF3X2J0Ziwgc2l6ZW9mKHJhd19idGYpLCBOVUxMKTsKIAlpZiAo
IUFTU0VSVF9HRShidGZfZmQsIDAsICJidGZfbG9hZCIpKQogCQlnb3RvIGNsZWFudXA7Ci0JZnVu
Y3NbMF0gPSAoc3RydWN0IGJwZl9mdW5jX2luZm8pIHsgLmluc25fb2ZmID0gMCwgLnR5cGVfaWQg
PSBtYWluX2lkIH07Ci0JZnVuY3NbMV0gPSAoc3RydWN0IGJwZl9mdW5jX2luZm8pIHsgLmluc25f
b2ZmID0gMywgLnR5cGVfaWQgPSBzdWJfaWQgfTsKIAogCWlmICh0ZXN0X19zdGFydF9zdWJ0ZXN0
KCJwb2lzb25lZF9zdWJwcm9nX3Rlcm1pbmF0b3IiKSkgewogCQlwcm9nX2ZkID0gbG9hZF9jb3Jl
X3JlbG9faW5zbnMoYnRmX2ZkLCBzdWJwcm9nLCBBUlJBWV9TSVpFKHN1YnByb2cpLCBmdW5jcywg
MiwKQEAgLTE3OCw3ICsxNzUsNiBAQCBzdGF0aWMgdm9pZCB0ZXN0X3BvaXNvbmVkX2luc25zKHZv
aWQpCiAJfQogCWNsb3NlKHByb2dfZmQpOwogCWNsb3NlKGJ0Zl9mZCk7Ci0JYnRmX19mcmVlKGJ0
Zik7CiB9CiAKIC8qIENoZWNrIHRoYXQgdmVyaWZpZXIgcmVqZWN0cyBCUEYgcHJvZ3JhbSBjb250
YWluaW5nIHJlbG9jYXRpb24K


--=-tdwk31ifX8CHfgNGuDuw--
