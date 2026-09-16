Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A05499F22
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549416; cv=none; b=SB7GJtZKEzTy7rRbVQKZ82kzaJ01MmCpfX2AxTMCyzYNEBTPGWboNdtysmxnuwYGC+uPAkBKqCYxQe4R0gXIRu6aH7CQNrAYYjGrrVn/yOql+8sF2yng6KGOmumodKhqIfg7nOQatBGUq3mZKI2s8YY4YLUlOkfWdIML3s7hCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549416; c=relaxed/simple;
	bh=dPiQNIYpL16O2MSNAS7ReZPSsyaT/YKxFX8t8JEY7v8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=axXbQCiOW1p1TssJWkbE8L4yD1s/2CQOPvEd2WmXOn919Nz4EQau+jZn4Kr2hstHCkR+8mYkPd9xm/pbz/hCglcCPCAorT9z1/BKUcQQmIGUGWiGd0bUmlrs2ro1Egm1fx1BQx3l/trXKv84rdfZd4Ksm8BO7xWQvsn9t5ixD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af4zs+ZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af4zs+ZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE301F00899;
	Wed, 16 Sep 2026 09:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789549401;
	bh=5vODQFG5mV0NXPRDaCR+Msk5prI0NQ3VdqsuWokKDYo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=af4zs+ZShQ/+Bs9iczwecyCtDbYdY2cGe9zCuwWxtzqoKTL98Tr9dva36/ZYTPy1G
	 XBfKf7iwfCGVqz0iJXKmPQ9YGQRosVdQsAT//zxPxZZV7pnQHnSbywjl8eE34IyUks
	 yiRMSYw+TUtZODp9IMeVw5s86/9ZdcXRkPRdY5mk2ZoJ1jZOUGenyvE7n1S8+BdgBA
	 SGP59M4U8vgFprOL1NT6m8OHNEWDth6iuaWevLkN6UhclEf+rK1csDtSProodr08Ou
	 nKYnBp5168XtBVH5Eb59Y/QTfQtsb5y5KgczGpolGVT9hruGgG2ZpapqApSJ8b4aKx
	 0GNA9FVXOdOmg==
Content-Type: multipart/mixed; boundary="===============0322982508488566466=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0e052699d93ddf459b9290d43c7ff00756d934a967981dd2c974f882385216fc@mail.kernel.org>
In-Reply-To: <20260916074118.1007116-12-alan.maguire@oracle.com>
References: <20260916074118.1007116-12-alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 11/11] Documentation/bpf: Describe new location-related BTF kinds
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,jolsa@kernel.org
Cc: daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 16 Sep 2026 09:03:20 +0000 (UTC)

--===============0322982508488566466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 004aa1058d857..70ab6ad608ae5 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst

[ ... ]

> @@ -104,11 +107,13 @@ Each type contains the following common data::
>           *             decl_tag and type_tag
>           */
>          __u32 info;
> -        /* "size" is used by INT, ENUM, STRUCT, UNION and ENUM64.
> +        /* "size" is used by INT, ENUM, STRUCT, UNION, ENUM64 and
> +         * LOC_PARAM.
>           * "size" tells the size of the type it is describing.
>           *
>           * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
> -         * FUNC, FUNC_PROTO, DECL_TAG and TYPE_TAG.
> +         * FUNC, FUNC_PROTO, DECL_TAG and TYPE_TAG. It is unused by
> +         * LOC_PROTO and LOCSEC.
>           * "type" is a type_id referring to another type.
>           */
>          union {

The comment is being updated to add LOC_PARAM to the list of kinds that use
'size', but should BTF_KIND_FLOAT be included as well?

Section 2.2.16 documents FLOAT as using size ('size: the size of the float
type in bytes: 2, 4, 8, 12 or 16.'), and kernel/bpf/btf.c btf_float_check_meta()
validates t->size. The omission is pre-existing (and mirrored in
include/uapi/linux/btf.h), but since the line is being rewritten, adding FLOAT
here would make the list complete.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35072175008
--===============0322982508488566466==--
