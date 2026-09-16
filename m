Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D39477E4B
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548266; cv=none; b=r4v2hnP847yzBE2ABYXLLBPS4UiWb/s/63LT8neTlXdQpGeUQ6IfiO7I3rKFIrHeSvTZZpM/WSFAxJ6IoB/g7ksnf6Cjv3geYZUo87s+YvEiZeLwnDWKhxGO+fzMV0UOd6cyRI4FZ92BZtmvOnzy4S8VquzW12VNf4Mt10V2cEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548266; c=relaxed/simple;
	bh=PST2vwk69tSVYrBKQN00HO+f7mz93E0lgzcu0DNrbas=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fas+UPrCL0w3QMXzKb/cjUqPaQxBNPpPgN6rnW4chpCErDfVmvvpxIIsD/4a6EHPvHs/DOnK9V7Rl08d3owNj19ob5wTdv+gWmkzSc7lDk949WpYAHtMmq27TmEhYVY8ffd4aRU+Lc/ELVc6Qmtc/UGgiFXX0VngTmHygjyZo5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpGg4UsP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpGg4UsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A401F000FF;
	Wed, 16 Sep 2026 08:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789548261;
	bh=Vfi8dD8juoqCJ8DzlEAYy6/NWaRdj00oHmYZ7gwdC6c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZpGg4UsPGE9vwdkYC4zxqVDKsgdoACwvt52jTQDPjI2249aRAuWcwOx02iA2xKo7S
	 y/pc23gDzH/11k0pbZYcQTMMh/1ee4x5b68iqDLQqVSbPj5Q32A8Aa35KBPLzlOUTs
	 2VODaTXAPLP2fGDTZGvykyhQbUGm6/Rn041MT6GjXWQz5ib6OH/mpevhY0XxLZsaZk
	 vIvXhlr+7GQOdL91ikHmP3b1/x8rEyvGA2IVdfAik4nAZdqs7I3FSq6y1KSMilND00
	 QQK59CGpdoNUIRh/kW7I3bzYOVCUi1aBE2U56XZj4f08Kqjk2jDUdtfTWaiBbEaE29
	 /b8uCgK4oRAHQ==
Content-Type: multipart/mixed; boundary="===============0357294195670245447=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2938122783a51a2e22a0abf9f4e61087a79500a6b3e07a872dd18cd0fc729cc6@mail.kernel.org>
In-Reply-To: <20260916074118.1007116-4-alan.maguire@oracle.com>
References: <20260916074118.1007116-4-alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 03/11] selftests/bpf: Test helper support for BTF_KIND_LOC[_PARAM|_PROTO|SEC]
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,jolsa@kernel.org
Cc: daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 16 Sep 2026 08:44:20 +0000 (UTC)

--===============0357294195670245447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
> index 1c1c2c26690a7..972403f6a7438 100644
> --- a/tools/testing/selftests/bpf/btf_helpers.c
> +++ b/tools/testing/selftests/bpf/btf_helpers.c

[ ... ]

> @@ -203,6 +206,37 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
>  		fprintf(out, " type_id=%u component_idx=%d",
>  			t->type, btf_decl_tag(t)->component_idx);
>  		break;
> +	case BTF_KIND_LOC_PARAM: {
> +		struct btf_loc_param *p = btf_loc_param(t);
> +		__u32 *v = (__u32 *)(p + 1);
> +
> +		fprintf(out, " size=%u flags=0x%x vlen=%u", t->size, p->flags, vlen);
> +		for (i = 0; i < vlen; i++, v++) {
> +			if (p->flags & BTF_LOC_PARAM_SIGNED)
> +				fprintf(out, "\n\tvalue=%d", (__s32)*v);
> +			else
> +				fprintf(out, "\n\tvalue=%u", *v);
> +		}
> +		break;
> +	}

This isn't a bug, but could this use p->values directly rather than casting
past the struct?

struct btf_loc_param already has a flexible array member (__u32 values[]),
and the kernel side of the series prints them as p->values[i] in
btf_loc_param_log(). The neighbouring ARRAY, STRUCT, ENUM, ENUM64,
FUNC_PROTO, DATASEC and the two new LOC_PROTO/LOCSEC cases all declare
'const struct ... *' for their record pointers.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftests/bpf/test_btf.h
> index e7bc781083745..b99c04b4d26bb 100644
> --- a/tools/testing/selftests/bpf/test_btf.h
> +++ b/tools/testing/selftests/bpf/test_btf.h

[ ... ]

> @@ -84,4 +84,20 @@
>  #define BTF_TYPE_TAG_ENC(value, type)	\
>  	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TYPE_TAG, 0, 0), type)
>
> +#define BTF_LOC_PARAM_ENC(nvals, sz, flags) \
> +	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_LOC_PARAM, 0, nvals), sz), (flags)
> +
> +#define BTF_LOC_PARAM_VAL_ENCODE(val)	(val)
> +
> +#define BTF_LOC_PROTO_ENC(nargs) \
> +	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_LOC_PROTO, 0, nargs), 0)
> +
> +#define BTF_LOC_PROTO_PARAM_ENCODE(param) (param)
> +
> +#define BTF_LOCSEC_ENC(name, nlocs) \
> +	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_LOCSEC, 0, nlocs), 0)
> +
> +#define BTF_LOCSEC_LOC_ENCODE(func, loc_proto, offset) \
> +	(func), (loc_proto), (offset)
> +
>  #endif /* _TEST_BTF_H */

This isn't a bug, but are these macros used by a raw-BTF test somewhere, or
could they wait until the patch that needs them?

A git grep for BTF_LOC_PARAM_ENC, BTF_LOC_PARAM_VAL_ENCODE,
BTF_LOC_PROTO_ENC, BTF_LOC_PROTO_PARAM_ENCODE, BTF_LOCSEC_ENC and
BTF_LOCSEC_LOC_ENCODE across the tree at the last commit of the series
matches only test_btf.h itself. The later selftests that exercise the new
kinds (btf_field_iter.c, btf_dedup_split.c, btf_distill.c) all build their
BTF through the btf__add_loc_*() APIs instead.

This isn't a bug, but would BTF_LOC_PARAM_VAL_ENC /
BTF_LOC_PROTO_PARAM_ENC / BTF_LOCSEC_LOC_ENC line up better with the _ENC
naming used by the rest of this header?

The other three macros added by the same hunk (BTF_LOC_PARAM_ENC,
BTF_LOC_PROTO_ENC, BTF_LOCSEC_ENC) follow the _ENC suffix, and every other
macro in test_btf.h that fills the same role uses _ENC: BTF_MEMBER_ENC,
BTF_ENUM_ENC, BTF_ENUM64_ENC, BTF_ARRAY_ENC, BTF_VAR_SECINFO_ENC,
BTF_FUNC_PROTO_ARG_ENC.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35072175008
--===============0357294195670245447==--
