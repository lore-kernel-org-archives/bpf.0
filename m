Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5093002B3
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776366309; cv=none; b=qS/PqxSP91mxN8O5l0AkpFP3GC6tv3Ber/oH5qJFDerDf1hgvXW8IToSLfQSRUoz/VvUQKw1/T9559f6NKNpQ+9WkasdfKuXaDgmD9xnKhgyvGGyutJDS/QmOC/3fG/RQrOB7aHCeU7Q0En05u2xJpDr8UeV1zWUMQHsLK0oFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776366309; c=relaxed/simple;
	bh=4HS41cJi6ZLUpGL6ig3IW6O406cwvxfsn3tbfPPuT/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dDiQih+TarMEfKTepXwjYTOVlfR8K9LOd3katzv2ERhmAeyXqccMjJJLRezqmY5xBYNOcz0iQtyCNunwFzH8wSebIz4JWtX5uGr4Ty0PLaQbvMDAhVuRKyYEOyu8Ftg3cqFUSyCeoZMxjsjoCVqKEInlFBhYxtR0QBaw1+LC/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drrFAzIu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drrFAzIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F093C2BCAF;
	Thu, 16 Apr 2026 19:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776366308;
	bh=4HS41cJi6ZLUpGL6ig3IW6O406cwvxfsn3tbfPPuT/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=drrFAzIuqaLUtYr5TQ3og1sZqMSd62qzQzLGIgCfXM3ks6He/a0J7ZTod/aoeFh8T
	 V7I6hW5yV4qhYDez85fnxN/qM4HquDsXG9f4LwxBZCzj9IRqqUzErMzaGve9mm9RTb
	 75x68NNX/V5ZK3fdYj6ZDdfxEZOjgkiu2p8b/UWRKYaOH/GzKIXZJcYprGgl5w2b6T
	 ICQxguWPVgFqpoBXbmRVzDPD+9AqTaDeS0Vdw4i/9GRLVjonL1C1DCpsit7jJpKcH1
	 CqkANTF2tFEojo61Toj0M0z9xqHV1kLhhaEr5FGdF/LjP587A75ec8yfD9iEq4GJ3B
	 fJwjjWSjNJp1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 1/8] bpf: Extend BTF UAPI vlen, kinds to use
 unused bits
Reply-To: sashiko@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416143904.1220662-2-alan.maguire@oracle.com>
References: <20260416143904.1220662-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 19:05:07 +0000
Message-Id: <20260416190508.8F093C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] UAPI C preprocessor breakage: Converting `BTF_MAX_*` constants to =
self-referential macros breaks existing `#if` evaluations in userspace.
--

commit ba6ded5102d9dc62d6101147f738a8a12d499303
Author: Alan Maguire <alan.maguire@oracle.com>

bpf: Extend BTF UAPI vlen, kinds to use unused bits

This commit extends BTF maximum vlen from 16 to 24 bits and kinds from
5 to 7 bits to support upcoming BTF location information. It converts the
BTF_MAX_* macros to an enum so they are encoded in kernel BTF, leaving
self-referential macros for backward compatibility.

Link: https://lore.kernel.org/bpf/CAEf4BzZx=3DX6vGqcA8SPU6D+v6k+TR=3DZewebX=
MuXtpmML058piw@mail.gmail.com/

> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
[ ... ]
> +enum btf_max {
> +	/* Max possible kind */
> +	BTF_MAX_KIND =3D		0x0000007f,
> +	/* Max # of type identifier */
> +	BTF_MAX_TYPE =3D		0x000fffff,
> +	/* Max offset into the string section */
> +	BTF_MAX_NAME_OFFSET =3D	0x00ffffff,
> +	/* Max # of struct/union/enum members or func args */
> +	BTF_MAX_VLEN =3D		0x00ffffff,
> +};
> +
> +/*
> + * Macros needed for backwards compatibility; enum above ensures values
> + * make it into BTF.
> + */
> +#define BTF_MAX_TYPE		BTF_MAX_TYPE
> +#define BTF_MAX_NAME_OFFSET	BTF_MAX_NAME_OFFSET
> +#define BTF_MAX_VLEN		BTF_MAX_VLEN

Will these self-referential macros break existing C preprocessor logic in
userspace?

While #ifdef BTF_MAX_VLEN will still evaluate to true, the preprocessor
does not have visibility into enum values. When evaluating #if directives
like #if BTF_MAX_VLEN =3D=3D 0xffff, the macro expands to the identifier
BTF_MAX_VLEN, which is treated as an undefined symbol and evaluates to 0.

This means the check silently evaluates to false, which might break
build-time feature detection for userspace programs depending on this heade=
r.

Could these macros be defined to their exact integer literals after the enum
block instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416143904.1220=
662-1-alan.maguire@oracle.com?part=3D1
