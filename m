Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF1497B65
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332609; cv=none; b=olPmxkTXMXzBYARdhSH/mHCwXz7xJR/bODW+f8FECJ4O+0wZuA+CHostD0nwd1S/kIVibDf9axXbKKbsPCsynEjCkUXiylIiM3qQnZAcjpL0jJStRrWFI9+cytaNZ07nz12nTSfihNVOeh3ze4ES16OTGLDJ6tkZaYz0Ra5fAPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332609; c=relaxed/simple;
	bh=ijl+RANe7Vrhpf0sGLoW4V2X5+0DXzBX8iGibsJxYKg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DJJ/VMbhByQb9loAXwSPfdp36KmEdWkeIXEC4WNI9PaBQ1zp4k1Uv9EMmkN1CX+DlM6KP1ur4Zml9SMjhLNghQJWSiLVljSAqKkQKXJn1gdARUjIERWTiCwxyIMQSCCeb14MLiuvNm63pbzgNizb1NC61iJ7ehdyZH/MbsAflY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3zIszWl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3zIszWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F651F000FF;
	Fri, 25 Sep 2026 10:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790332607;
	bh=IfP5PQOaVaPa0p29aa9eRWM8cCq9CRVcdk4JTz9q6/o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=G3zIszWlPz9DfMljCO5QzLXSHTTCBQFVb5xh2p7Z0ENaMkfMxmQpMc+/TwEJn5cvq
	 rzpgpWutHIg7GBQZqF1ooKSaFAKQ8t8V/5xINOag8Ob+wKKKZUy97H+Y4rx1Boq7RD
	 LBkY3Oq88NgQJHhVvvVD2yjjHc8GveTkyyQR5EEVxVLL0UMgdxz+kQ1fb1F6QCjFBb
	 at1cuYvmT0WCICKsTV0U+lpgbTKEuOIPj1Slxvi+vEW0DByIzYluUhC4S8chwRRiNF
	 4J3fcOJ5O+jKh0Mrp4JkmIBYOZVjb3fEf15HKvVSI2T4yWDJDLkfZdYGs+kzYYXCZj
	 BATE8lHMJNIqw==
Content-Type: multipart/mixed; boundary="===============8477136397996495623=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <069e52534d05eec2b5c017c7bffeaf2cd29214924deb58beb760b37fb2eb7227@mail.kernel.org>
In-Reply-To: <20260925095231.879708-3-alan.maguire@oracle.com>
References: <20260925095231.879708-3-alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next 2/3] bpftool: Update func representation to include function signature
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,qmo@kernel.org
Cc: jolsa@kernel.org,daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 10:36:45 +0000 (UTC)

--===============8477136397996495623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 46a8924a62f4ce47f7ea0951644e3f0fb4ac14c2
> Author: Alan Maguire <alan.maguire@oracle.com>
>
>     bpftool: Update func representation to include function signature
>
>     Augment func= output for LOCSEC entries to include a mapping from
>     function signature to where parameters are stored; for example:
>
>     [290179] LOCSEC 'inline.text' vlen=524941
>             func='task_pid_nr(tsk [reg0])' func_type_id=136691 loc_proto_type_id=136693 offset=2097226
>             func='get_current()' func_type_id=136694 loc_proto_type_id=136695 offset=2097247
>             func='arch_static_branch(key [address 0x2e275e8], branch [const 0x0])' func_type_id=136697 loc_proto_type_id=136700 offset=2097296
>
>     Fixes: 321562c34d5b ("bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC")
>     Suggested-by: Alexei Starovoitov <ast@kernel.org>
>     Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

The changelog only describes the LOCSEC func= change. Does the commit
message need to mention the other user-visible output changes?

The patch also changes:

1. btf_loc_param_str() now prints "address 0x..." instead of
   "0x... (addr)", and adds a new "const " prefix. This changes the
   values= output of every BTF_KIND_LOC_PARAM dump line and the value=
   output of every BTF_KIND_LOC_PROTO line, not just LOCSEC entries.

2. LOCSEC entries printed name='foo' before this patch, and the JSON
   key was "name". The patch renames the plain-text field to func= and
   replaces the JSON "name" key with "func", which now holds a
   formatted signature string.

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index e29c8a84e224..6e569ace6add 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c

[ ... ]

> @@ -234,8 +235,10 @@ static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
>  						(1ULL << bits) - value;
>  			}
>  		}
> -		snprintf(num, sizeof(num), "0x%llx%s", (unsigned long long)value,
> -			 p->flags & BTF_LOC_PARAM_ADDR ? " (addr)" : "");
> +		snprintf(num, sizeof(num), "%s0x%llx",
> +			 p->flags & BTF_LOC_PARAM_ADDR ? "address " :
> +			 p->flags & BTF_LOC_PARAM_CONST ? "const " : "",
> +			 (unsigned long long)value);
>  	}
>  	if (i != vlen) {
>  		btf_loc_param_raw_str(p, vlen, str, sz);

Will negative signed constants now print as "-const 0x16" instead of
"const -0x16"?

The patch moves the kind label (e.g., "const ") into num as a prefix.
The sign, however, still lives in op, and the final format string puts
op in front of num:

    snprintf(str, sz, "%s%s%s%s%s", deref, regs, op, num, deref_close);

With no register, op is "-" when negative is true, so the '-' ends up
in front of the new label. Take a LOC_PARAM with flags =
BTF_LOC_PARAM_CONST | BTF_LOC_PARAM_SIGNED, size 4, and value
0xffffffea (-22). The SIGNED block sets negative = true and value =
0x16. num becomes "const 0x16", op is "-", and the output is:

    values='-const 0x16'

In the new LOCSEC signature it shows up as, for example,
"foo(err [-const 0x16])". Before this patch the same parameter printed
as "-0x16".

The UAPI comment in include/uapi/linux/btf.h says CONST values are
interpreted using "size, vlen and _SIGNED flag". The kernel's
btf_loc_param_check_meta() accepts CONST|SIGNED. btf_loc_param_str()
also has explicit code to handle negative constants ("we need to
determine if the value is negative so we can prepend a \"-\""). So
this input is expected, for example an inlined call site that passes
-EINVAL or -1.

Register+offset output ("fbreg - 0x10") is not affected, because
neither CONST nor ADDR is set there.

[ ... ]

> @@ -617,22 +701,20 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>  		}
>
>  		for (i = 0; i < vlen; i++, locs++) {
> -			const struct btf_type *f = btf__type_by_id(btf, locs->func);
> -			const char *name = "<invalid>";
> +			char func_str[1024] = {};
>
> -			if (f && btf_is_func(f))
> -				name = btf_str(btf, f->name_off);
> +			btf_locsec_func_str(btf, locs, func_str, sizeof(func_str));
>
>  			if (json_output) {
>  				jsonw_start_object(w);
>  				jsonw_uint_field(w, "func_type_id", locs->func);
> -				jsonw_string_field(w, "name", name);
> +				jsonw_string_field(w, "func", func_str);
>  				jsonw_uint_field(w, "loc_proto_type_id", locs->loc_proto);
>  				jsonw_uint_field(w, "offset", locs->offset);
>  				jsonw_end_object(w);
>  			} else {
> -				printf("\n\tname='%s' func_type_id=%u loc_proto_type_id=%u offset=%u",
> -				       name, locs->func, locs->loc_proto, locs->offset);
> +				printf("\n\tfunc='%s' func_type_id=%u loc_proto_type_id=%u offset=%u",
> +				       func_str, locs->func, locs->loc_proto, locs->offset);
>  			}
>  		}
>  		if (json_output)

Does this commit break the bpftool_btf_dump selftest?

At this commit, test_loc_dump() in
tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c still
compares the output exactly against the old format:

    "[7] LOC_PARAM ... values='0x123456789abcdef0 (addr)'\n"
    "[8] LOC_PARAM ... values='0xdeadbeeffeedface'\n"
    ...
    "\tname='foo' func_type_id=3 loc_proto_type_id=10 offset=64\n";

    ASSERT_OK(compare_text_to_expected(dump, expected), "cmp_loc_dump");

This patch changes all of these lines: the 'address '/'const '
prefixes, and name= becoming func=. The test's FUNC_PROTO also has
vlen=5 while the LOC_PROTO has vlen=6. The new btf_locsec_func_str()
treats that vlen mismatch as "<invalid>", so cmp_loc_dump fails at
this commit.

The selftest update in f2a598589f90 ("selftests/bpf: Fix up bpftool
btf dump test for signatures") fixes it later in the series. BPF CI
runs test_progs per commit, so would it be better to fold that test
update into this patch to keep the series bisectable?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36122090541
--===============8477136397996495623==--
