Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7F423C8AE
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775326347; cv=none; b=E/EnpvSwg+2GfyYn4sPKKXhAigXvFxDtWwb0uraH/I4/MJ6/ETEwmYqEPSjTR6cA4jTdG0FMLv5kPQkjS6FDRa7GyigmfAemWK36KcsSy4YUCd6/NKHAbQda6wmv5UjaxBOEPbOvwKgiIm1DHdKz3PdNdGM8hoYERoHmSuIoYqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775326347; c=relaxed/simple;
	bh=mKU8t0YjslAfTeRpvofUP6TWVMNQfoIKt8kpGneSv2A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cxboMSneyzyzRhCRUQFQDaxOVGm+9jHRcwBK1j8q5Cd1VaZ/dVtHsLODKFWHGRbr89xpW/DKyZO1Q7xP7WppZgBYqdS3L93y8zMCQ0Mf+Z3P73QueOKstU94Qao4T+e+WfFuAjaWWj54TyplMJyWlFPFKFdwgkvvJpPOzGMEDAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=tQXmA/Yt; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="tQXmA/Yt"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2b0afa0210bso13277505ad.2
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775326345; x=1775931145; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52Dr65csThaf+P2U+1oj1UQHieOnFSEmb2t1DWzAfXA=;
        b=tQXmA/Yt3UDFmv4D6CUcJC2n7w1zMCHSksfanL8fiqBjRXEVCRs/313mzlCXoOZJ1c
         m2QopCpwrEar1vHtBGsy31bSsyRguEtqRP/cAPWlcNB0K43lvbS9fYlw/+s2D8OeM+mD
         3cFvfGohpm6K6nG8Ds59pzngWY1p+5Qvia0pkPgO3Gjlq9acP8DtoW62Dm1X/6EQzfXR
         iiEH0PAjoKi6yqMS1qFrx022+OK3IMZh8MiAoBDfbbrjt63LeigGQDMI+3gTDh7XbpGN
         jWQ9J6SKCrCtMQSg1u+MNCLRfKunVu+crDn/oKslYyY71peTnmFhLV0Gt9H4ibwJ3aJO
         H2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775326345; x=1775931145;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52Dr65csThaf+P2U+1oj1UQHieOnFSEmb2t1DWzAfXA=;
        b=qIX1C90X/RE/X0ZZybXhE5ZMPFeBmVtjnLqyKErv/GOTReSU4vY40bK4TgF0Yt7ZPb
         swYI0n4XMR24s1ZH+ya6elrOIkYXvNLCW3KwkdNHupCINX8/pEmdF8mdl1A37mtJ4f4D
         /sPtiOjSNcqhJRd/9nnSLxPgMihxbPAAvG2W0Dg1xcjcMpzebiDxUEW8LlHzjpt0Ws/s
         JjW6PNv2ywH/50mUhQkdK3vEnQkKXz5e9orl7pW/x4nKhVE5JxznCDjcigxz2mjbxGfy
         nSooW49gJvl5r23mINlnr29Tiy8PNsgwq9s4dQQgDRmICVAx80GSRfhH12y2vPGzHnGc
         3gSA==
X-Forwarded-Encrypted: i=1; AJvYcCVDMvZewfeRY+X1BtH+887fU5w9KMlSf4lBMx5ImfP4CXOwejlKelBwWLAxNKzun2BvmNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySIOdlxpqUirN4BsDZ2WnMDIn0/docGLAjPcXwAYTDT1ylZh8V
	fCawCvwpHYfObOgHfnuB1tBrb5myQonYm1Vzn57itEN6KLcHW58wYhF0sWAFtG/GpFN0xYLw5vf
	2CBII8z2Tq0jD
X-Gm-Gg: AeBDievKAEuCW982AamlwPcgLckLHTv2zcOY3W5PxFSRfIw5bv1eCbiW7qXdG+jTEBd
	0bXjqhiYLCMwVQXp8cLIsZreYJ/VoK0c42P/TWvdCchxhDCMYaGuSp7SzC+RvuwCiQFB1rrOkyO
	ua1auSQE5wo35fVeAgnjFhH/JuWiDcMz1DC493p0xkuAhnXFiY2xY06u1L7sm5FiW49TwFGkDSQ
	YmYymYwdyB1aiH8mb76yN8QLtkBwM4wlHaw+99Att1oVNF30lG1ln8Q+lDNx217f0lgox0vvBl6
	2ePft63jWQsz8K1vymaBb5wfTpnk2QqakmAu55bgfczWH47d+O0/ZjcEFCbZNnGYT2nG9zF57AB
	92rVxyWVUjyWp0YRtAz0f2eHzK/J2FVhYJwEpKqzZF6M2ok+HNgQuZ+XPOm7FhWDcHhp9UEqxXS
	K68vJDoekwGWku3nYGEA==
X-Received: by 2002:a17:902:bd01:b0:2b2:49a7:a5ca with SMTP id d9443c01a7336-2b2817d8a3amr48979435ad.5.1775326344929;
        Sat, 04 Apr 2026 11:12:24 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd85sm88694025ad.74.2026.04.04.11.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 11:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 14:12:23 -0400
Message-Id: <DHKKNZ9YUGJ7.3V2JN75E8R5JG@etsalapatis.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 <bpf@vger.kernel.org>, "Xiang Mei" <xmei5@asu.edu>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: add test for negative CO-RE
 accessor index rejection
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260404161221.961828-1-bestswngs@gmail.com>
 <20260404161221.961828-3-bestswngs@gmail.com>
In-Reply-To: <20260404161221.961828-3-bestswngs@gmail.com>

On Sat Apr 4, 2026 at 12:12 PM EDT, Weiming Shi wrote:
> Add a selftest to verify that the kernel rejects BPF programs containing
> CO-RE relocations with negative accessor indices.  The test constructs a
> minimal BTF blob with a struct type and a CO-RE relocation whose access
> string is "0:-1".  Without the fix in the previous patch, this triggers
> an out-of-bounds read in bpf_core_parse_spec(); with the fix, the
> program load fails cleanly with -EINVAL.
>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Thank you for adding the selftest. Some nits below, but otherwise:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/prog_tests/core_reloc_raw.c | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/to=
ols/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> index a18d3680fb16..f7bf6c237d59 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> @@ -118,8 +118,102 @@ static void test_bad_local_id(void)
>  	close(btf_fd);
>  }
> =20
> +/* Check that verifier rejects BPF program containing CO-RE relocation
> + * with a negative accessor index (e.g. "0:-1").
> + */
> +static void test_negative_accessor(void)
> +{
> +	struct test_btf {
> +		struct btf_header hdr;
> +		__u32 types[18];
> +		char strings[20];
> +	} raw_btf =3D {
> +		.hdr =3D {
> +			.magic =3D BTF_MAGIC,
> +			.version =3D BTF_VERSION,
> +			.hdr_len =3D sizeof(struct btf_header),
> +			.type_off =3D 0,
> +			.type_len =3D sizeof(raw_btf.types),
> +			.str_off =3D offsetof(struct test_btf, strings) -
> +				   offsetof(struct test_btf, types),
> +			.str_len =3D sizeof(raw_btf.strings),
> +		},
> +		.types =3D {
> +			/* [1] int */
> +			BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
> +			/* [2] struct s { int x; } */
> +			BTF_STRUCT_ENC(5, 1, 4),
> +			BTF_MEMBER_ENC(7, 1, 0),
> +			/* [3] int (*)(int a) */
> +			BTF_FUNC_PROTO_ENC(1, 1),
> +			BTF_FUNC_PROTO_ARG_ENC(13, 1),

Nit: If you make this BPF_PROG_TYPE_TRACING (see below) you can change this
to be void(void) and skip the extra member.

> +			/* [4] FUNC 'foo' */
> +			BTF_FUNC_ENC(9, 3),
> +		},
> +		/* offsets: 0:NUL 1:"int" 5:"s" 7:"x" 9:"foo" 13:"a" 15:"0:-1" */
> +		.strings =3D "\0int\0s\0x\0foo\0a\0" "0:-1",
> +	};
> +	__u32 log_level =3D 1 | 2 | 4;
> +	LIBBPF_OPTS(bpf_btf_load_opts, opts,
> +		    .log_buf =3D log,
> +		    .log_size =3D sizeof(log),
> +		    .log_level =3D log_level,
> +	);
> +	struct bpf_insn insns[] =3D {
> +		BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	struct bpf_func_info funcs[] =3D {
> +		{ .insn_off =3D 0, .type_id =3D 4 }
> +	};
> +	struct bpf_core_relo relos[] =3D {
> +		{
> +			.insn_off =3D 0,
> +			.type_id =3D 2,		/* struct s */
> +			.access_str_off =3D 15,	/* "0:-1" */
> +			.kind =3D BPF_CORE_FIELD_BYTE_OFFSET,
> +		}
> +	};
> +	union bpf_attr attr;
> +	int prog_fd =3D -1;
> +	int btf_fd =3D -1;
> +
> +	btf_fd =3D bpf_btf_load(&raw_btf, sizeof(raw_btf), &opts);
> +	if (!ASSERT_GE(btf_fd, 0, "btf_load"))
> +		return;
> +
> +	log[0] =3D 0;

No need for setting 0, the log is guaranteed to be NULL-terminated
after load() is called provided the user running the selftests has
the appropriate privilege.

> +	memset(&attr, 0, sizeof(attr));
> +	attr.prog_btf_fd =3D btf_fd;
> +	attr.prog_type =3D BPF_TRACE_RAW_TP;

As the bot in sashiko.dev points out, this is an attach type and not a
load type. Can you change it so BPF_PROG_TYPE_TRACING? The same holds
for the pre-existing test that has the same issue - I think a drive-by
fix is fine in this case as long as you mention it in the commit
message.

> +	attr.license =3D (__u64)"GPL";
> +	attr.insns =3D (__u64)&insns;
> +	attr.insn_cnt =3D sizeof(insns) / sizeof(*insns);
> +	attr.log_buf =3D (__u64)log;
> +	attr.log_size =3D sizeof(log);
> +	attr.log_level =3D log_level;
> +	attr.func_info =3D (__u64)funcs;
> +	attr.func_info_cnt =3D sizeof(funcs) / sizeof(*funcs);
> +	attr.func_info_rec_size =3D sizeof(*funcs);
> +	attr.core_relos =3D (__u64)relos;
> +	attr.core_relo_cnt =3D sizeof(relos) / sizeof(*relos);
> +	attr.core_relo_rec_size =3D sizeof(*relos);
> +	prog_fd =3D sys_bpf_prog_load(&attr, sizeof(attr), 1);
> +	if (prog_fd >=3D 0) {
> +		PRINT_FAIL("sys_bpf_prog_load() expected to fail\n");
> +		goto out;
> +	}
> +	ASSERT_HAS_SUBSTR(log, "failed: -22", "prog_load_log");
> +
> +out:
> +	close(prog_fd);
> +	close(btf_fd);
> +}
> +
>  void test_core_reloc_raw(void)
>  {
>  	if (test__start_subtest("bad_local_id"))
>  		test_bad_local_id();
> +	if (test__start_subtest("negative_accessor"))
> +		test_negative_accessor();
>  }

