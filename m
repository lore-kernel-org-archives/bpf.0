Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DF3479860
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251011; cv=none; b=NCr/VuDDZm9bhJOwQt+D3Dv++rHix8b7s8QJ8g1ug78M3BtUpHNLJAGUYe4ldy4tFQJAD1hjSx1QepkB1Nnoh64CXVLzw9h9C7boRlPwnTAFXmGxx5gRXVto9WHjiQY2G2X7R9rkobSZeYhdy5PGFkFPtE/i7EGe1jpIKhg4cx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251011; c=relaxed/simple;
	bh=gE0JQus0VaMn4N7NOhEeQn3ggrbF+kjsmQsEg4Nc30Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HOix47zSl3+Qu5Q2lO+RSxRJZ6R0vhyFxieBsL0GmUAyw6hCyC8mlAdTbE4gpXcvmb1kvX73I3EDPR4FbIG4Evail4/24pUvtMEjGqTaKDSoYDBOlMtfMygVP1u4jdaJWQDD9eNWtPRwpQYM97dUU2R+ggM6UKE16IdvRqTvmks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZWo/Amr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZWo/Amr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F67E1F000FF;
	Thu, 24 Sep 2026 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790251009;
	bh=25Di2F4gelHCLl/896NXpZwXZVqRKDZ7oQgxxG+XJ78=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PZWo/AmruX60j8Xff80rE8a52e/gln098tApbEGMLd+mGmKn/y/jfYu+nxdg6Rhzz
	 Q4o8lM4j9I4gCbLZM4p0N/FVkr/ab6olhhMR+J+t35NrRMep+0JXN9byJVrc5I6zLR
	 jeX1k9Eib3K5oIR8IL7JeWuuC0hoSrMpu3zuuGVw1E1sxyPts4BG00Crr2odry3eDm
	 cpXJTl5yWJ4ww8SLJkPjO9sxSXMZKmATSFmwPIIltTNeCQuuMgLGlj0zJr0xEj+vcI
	 1u8HeNJYXNMdLQ2QRcXd4PE4WfdTLUi46aikDxi4JT7Os0FT6SWbQSfH+nV8+1wY6N
	 swZa0ajnxOC2A==
Content-Type: multipart/mixed; boundary="===============7451706810926196302=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1504d409bfe9e3e530206b1a008291d2dc0bb9ffc8524359ba6731e2fbf5a4ea@mail.kernel.org>
In-Reply-To: <20260924111428.75957-12-alan.maguire@oracle.com>
References: <20260924111428.75957-12-alan.maguire@oracle.com>
Subject: Re: [PATCH v4 bpf-next 11/11] Documentation/bpf: Describe new location-related BTF kinds
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,qmo@kernel.org
Cc: jolsa@kernel.org,daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 11:56:47 +0000 (UTC)

--===============7451706810926196302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 004aa1058d85..29de1222c3e7 100644
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

This isn't a bug, but should this list include BTF_KIND_VAR as well?

Looking at the UAPI header (include/uapi/linux/btf.h line 59-61), it
states: "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT, FUNC,
FUNC_PROTO, VAR, DECL_TAG and TYPE_TAG. The BTF_KIND_VAR documentation
at line 422 confirms it uses the type field.

Since this patch updates this comment to note which types use or don't
use the type field, would it make sense to include VAR in the list for
completeness?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35993586374
--===============7451706810926196302==--
