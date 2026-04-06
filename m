Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4312DF717
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487810; cv=none; b=BbMdnT68yABfAGnUvKoUVdwqDBVFrpGDWZ1wcC2+5/A3y3PB/Xf8OFB+/m5GlKTzUAeOJTIhOIM6RVqQAbuBpQubPod1OokyI/8o8n16vFl0jMDuAwWzZ8idIihJNwyScGlp1zE2ueBEH9PuCI7sbq27eHfJc1bag/JTjGJnTjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487810; c=relaxed/simple;
	bh=Uprov0jrtOcRuxNc80ad2g8tFoGky4UTLW0QIw9yZtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS1tBH2G7apVXSQ7lZY21aGAqwlNzYEyiBWWDDu/wxFG3m+naz8K8LS6h25yCjlZTI8pQJKv6xPGBRuy2OnjHSy0x9UIO5gotKAap7VQRX9MXbOnyGtrfsbRpv0iKkP1KN+yFime+ED0t8Tf6dGXZAy1f7ktZSwh9p4NjfRlP9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQFfjuWd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQFfjuWd"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so15442295e9.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775487807; x=1776092607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AA4txN+HtTgWBygj5ACndnynG518oXDUR0nB5q9cW8Y=;
        b=HQFfjuWdB7pPkexEDMcDAMwnkivoqH7+s4Rh8EnTHOz19IQU7pGA/g5CVOh5YZWqW/
         ztxjrwRy3eMHP32/ArO1oUgNXJSZdSHA9sknZaff5F603mmLcM5PmBYmDiMdgaOVrGK6
         RSfzsa9xro1Cq6YvvS3ft1ph10Y466qLJdydMzoiLiXbTR+V8FkkJDWHGaRupieAdYGM
         16KduD0xwvKUiT7td006Ze+yEDP1XFkSjSDZc6SCglrVYPBfcYkeMBEKq5Dij61End1V
         nXYlt0JGUdw0B5H+FdvZDgKAg8rTXQfrcGHZyY5BlJaiUIHqwLdWwRUo0Kw2TNkN9AXX
         pMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775487807; x=1776092607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AA4txN+HtTgWBygj5ACndnynG518oXDUR0nB5q9cW8Y=;
        b=b7/4GdP2o3TQIgG6X+/YnnUOPY/CP/VP+X7GDy6KRjWURK9yH598pzCf5Ckx/sVEHa
         tVxTLMMKTJROyC4qZE4+EZJX5cIj/EJXYWqLe1cln5q0Dx8AlxcE7HE1xNvfH+wAEjE9
         txeeF3omXk4xoqrt1S6yer9IrvaSoFgo5dy0uG8n1zaBwnYjlOSN/EQ8u+69rsvNDUL4
         gZUFECTXx8MFpcdmPej3JaLtsWyUo8UTUzrAka0ckXFQbqkn7t9vYLvRlYjpOPRhGQaQ
         drTJY1Rf0n1m49opEA8vcOww9+1Y8tw6Ixj7mQHuBWjKJ1R7bYbzgh6t7JEdI/V6DZzI
         PyAA==
X-Forwarded-Encrypted: i=1; AJvYcCXU8qwV7hltJ4m6JRhkDIri3/dwaz9B+NcW09u5ou+OlUikF7p2+uEj/SLtOAjD22bJemE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUm3wnikLgstX4i/JhkE6IstHhBvRhiTVGBBoMn67JIMn2vEMi
	MqLZgM9qCq0kHbtgdxscyI0WRoFh5JXyk4fwNmtIziGhIW5x8d0Yoqjy
X-Gm-Gg: AeBDietHIGG7gzUlOg7l8A0vr3PkTiDDcwxevJWO0rQbZG6kpOOCt9nd7E32hhi5oTu
	M6L50bDmrhAZXami1C3zaOpT0CltQwNRPJYbTnscMTTWcZ97txMlbodut2367ZudTuROOGiBRbI
	T2jEtUku6Gbymd7F8aYapOQMyM9KQ73bPAFPjnl+PxTcPtDeEs+ZKY+flvy9lsffTp82xjGFyNc
	6SEk0pfN/nNfNqOt+q8u/Om+DxZWoYHb/JGXojJ6vaQmcTlx7DFqWpHi76IpfifVxhKDkT+hEdI
	VMTckPmJ581xFPNwTbp4eqPLzo4xWAHmsRFkVNG7I7Kf70h87m5KAJbuuUTeyRh0wEPW5wUQXVi
	+jdMvOjeAFiXPV+ig5VndlEwfkanAadoS24IxquabsxlKMmAax9swN/OumFiG7jdDXjj10fbtn7
	DW/XRyKDqzDeejr9JfWycF7GKkYQw8inpdA43a6p51kbl3EQykop4zUzvTXohD0SlBP9nuObQ8N
	D3ErqdccM8FSPRzuozinrnicHZrV68t103hus7YfSPrQCMLDU/ghXZIvmZWpGUUjqKEm8qjf2FN
	Y1WvtKnDtYdxvPnv5H6+zrU41F9e0zc=
X-Received: by 2002:a05:600c:1d86:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48899719a00mr164662855e9.12.1775487807073;
        Mon, 06 Apr 2026 08:03:27 -0700 (PDT)
Received: from Tunnel (2a01cb09e026ada2c97bbbb55b3a4739.ipv6.abo.wanadoo.fr. [2a01:cb09:e026:ada2:c97b:bbb5:5b3a:4739])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899d3a4e9sm187832175e9.6.2026.04.06.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 08:03:26 -0700 (PDT)
Date: Mon, 6 Apr 2026 17:03:23 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: add test for negative CO-RE
 accessor index rejection
Message-ID: <adPLO_2CROkqD9Qp@Tunnel>
References: <20260404161221.961828-1-bestswngs@gmail.com>
 <20260404161221.961828-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404161221.961828-3-bestswngs@gmail.com>

On Sun, Apr 05, 2026 at 12:12:21AM +0800, Weiming Shi wrote:
> Add a selftest to verify that the kernel rejects BPF programs containing
> CO-RE relocations with negative accessor indices.  The test constructs a
> minimal BTF blob with a struct type and a CO-RE relocation whose access
> string is "0:-1".  Without the fix in the previous patch, this triggers
> an out-of-bounds read in bpf_core_parse_spec(); with the fix, the
> program load fails cleanly with -EINVAL.
> 
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

I checked that the new selftest does fail, in the expected manner, when
applied without the corresponding fix.

Tested-by: Paul Chaignon <paul.chaignon@gmail.com>

> ---
>  .../selftests/bpf/prog_tests/core_reloc_raw.c | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> index a18d3680fb16..f7bf6c237d59 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> @@ -118,8 +118,102 @@ static void test_bad_local_id(void)
>  	close(btf_fd);
>  }
>  
> +/* Check that verifier rejects BPF program containing CO-RE relocation
> + * with a negative accessor index (e.g. "0:-1").
> + */
> +static void test_negative_accessor(void)
> +{
> +	struct test_btf {
> +		struct btf_header hdr;
> +		__u32 types[18];
> +		char strings[20];
> +	} raw_btf = {
> +		.hdr = {
> +			.magic = BTF_MAGIC,
> +			.version = BTF_VERSION,
> +			.hdr_len = sizeof(struct btf_header),
> +			.type_off = 0,
> +			.type_len = sizeof(raw_btf.types),
> +			.str_off = offsetof(struct test_btf, strings) -
> +				   offsetof(struct test_btf, types),
> +			.str_len = sizeof(raw_btf.strings),
> +		},
> +		.types = {
> +			/* [1] int */
> +			BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
> +			/* [2] struct s { int x; } */
> +			BTF_STRUCT_ENC(5, 1, 4),
> +			BTF_MEMBER_ENC(7, 1, 0),
> +			/* [3] int (*)(int a) */
> +			BTF_FUNC_PROTO_ENC(1, 1),
> +			BTF_FUNC_PROTO_ARG_ENC(13, 1),
> +			/* [4] FUNC 'foo' */
> +			BTF_FUNC_ENC(9, 3),
> +		},
> +		/* offsets: 0:NUL 1:"int" 5:"s" 7:"x" 9:"foo" 13:"a" 15:"0:-1" */
> +		.strings = "\0int\0s\0x\0foo\0a\0" "0:-1",
> +	};
> +	__u32 log_level = 1 | 2 | 4;
> +	LIBBPF_OPTS(bpf_btf_load_opts, opts,
> +		    .log_buf = log,
> +		    .log_size = sizeof(log),
> +		    .log_level = log_level,
> +	);
> +	struct bpf_insn insns[] = {
> +		BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	struct bpf_func_info funcs[] = {
> +		{ .insn_off = 0, .type_id = 4 }
> +	};
> +	struct bpf_core_relo relos[] = {
> +		{
> +			.insn_off = 0,
> +			.type_id = 2,		/* struct s */
> +			.access_str_off = 15,	/* "0:-1" */
> +			.kind = BPF_CORE_FIELD_BYTE_OFFSET,
> +		}
> +	};
> +	union bpf_attr attr;
> +	int prog_fd = -1;
> +	int btf_fd = -1;
> +
> +	btf_fd = bpf_btf_load(&raw_btf, sizeof(raw_btf), &opts);
> +	if (!ASSERT_GE(btf_fd, 0, "btf_load"))
> +		return;
> +
> +	log[0] = 0;
> +	memset(&attr, 0, sizeof(attr));
> +	attr.prog_btf_fd = btf_fd;
> +	attr.prog_type = BPF_TRACE_RAW_TP;
> +	attr.license = (__u64)"GPL";
> +	attr.insns = (__u64)&insns;
> +	attr.insn_cnt = sizeof(insns) / sizeof(*insns);
> +	attr.log_buf = (__u64)log;
> +	attr.log_size = sizeof(log);
> +	attr.log_level = log_level;
> +	attr.func_info = (__u64)funcs;
> +	attr.func_info_cnt = sizeof(funcs) / sizeof(*funcs);
> +	attr.func_info_rec_size = sizeof(*funcs);
> +	attr.core_relos = (__u64)relos;
> +	attr.core_relo_cnt = sizeof(relos) / sizeof(*relos);
> +	attr.core_relo_rec_size = sizeof(*relos);
> +	prog_fd = sys_bpf_prog_load(&attr, sizeof(attr), 1);
> +	if (prog_fd >= 0) {
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
> -- 
> 2.43.0
> 
> 
