Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C964ADDB2
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007907; cv=none; b=j4jmiVlAy6xhQGQUMf4a9Otqe8/+D7NrN4QVOA2Q+0f+SeJEu7Vfxr5864Kyn3qgo0KEW/2Im2ibwFjpidzoOkrGN8sJCAO5fx6f+dq0rI/vzzgdW6PSnekwIZv+PWxL0RGS70XPkwaVLmsq+5X88eXL74DmzPwYjAiQcyES/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007907; c=relaxed/simple;
	bh=/mA7E81rQ7EQE/QzInvLyp/p8RJyVczhGxbbrbdTGio=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LxwsKL1HK8t8jIie2+An2zncNuWuc61VZ8JJHf80SGbzf32zOKy9tqhh8zNkIPIy6I6Sl7vDb/HWH6kbACUtWT32D1ftXwzkwkt6j3qaNcGYwEuYXFnIwIu+wkQSPqo6DPEzvYJSrSRnl1f71MAlN5RpcPgHe2QP7y4o/IjGsds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jxetf8UQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jxetf8UQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698BEC2BCB4;
	Tue,  5 May 2026 19:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778007906;
	bh=/mA7E81rQ7EQE/QzInvLyp/p8RJyVczhGxbbrbdTGio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Jxetf8UQtm39b1YhxXhTC5jr0prBUSxLNO51Y+1VA3p53CGkKmIKmRxQ4yEQvVZyT
	 ZOOmDUNtBGUAFU8NiECoEOnRTcb0mjROKi8pdzibZXIJxw34jjVbzibcoWmAtOg/RD
	 eK5jaEAQ8ddXTHtwH7eK4YYE4v90DQET+SItEtGI8xgGUO58mMOrx30f1iV5FCtLR6
	 9jLmY+K1cEEaUIV76mimBIcyOngNr4L2xxHnhlytSwRvjpk/8W4kr8FeKVYxlyD1Z6
	 CXBP6vlKM0QZZOiRDVsv/zWrnMgjOmrG6xMZtVes5d/oBnfZd4FOpIRwMEfBHFXFhH
	 mw/OAfmyDizyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 17/19] unwind_user/sframe: Separate reading of FRE
 from reading of FRE data words
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-18-jremus@linux.ibm.com>
References: <20260505121718.3572346-18-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 19:05:05 +0000
Message-Id: <20260505190506.698BEC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] A malicious user can trigger a kernel panic by providing a cra=
fted `.sframe` section with `rep_size` set to 0, which causes a division-by=
-zero when the kernel attempts to unwind the stack.
--

commit 1aeb36f953ce26b15e30e2b228bfb48239924c2b
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/sframe: Separate reading of FRE from reading of FRE data words

This commit separates the reading of SFrame FRE structures from their
data words, which allows linear searches to skip data words until a
matching FRE is found. New fields are added to struct sframe_fre_internal
to cache the necessary information to read data words later.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 2ba2c8b385f96..98346412078b8 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c

[ ... ]

> @@ -455,6 +450,7 @@ static __always_inline int __find_fre(struct sframe_s=
ection *sec,
>  	bool which =3D false;
>  	unsigned int i;
>  	u32 ip_off;
> +	int ret;
> =20
>  	ip_off =3D ip - fde->func_addr;
> =20

This isn't a regression introduced by this patch, but while looking at this
area, can a crafted sframe section cause a division-by-zero just after
this line?

In __find_fre(), the code does:

    if (fde_pctype =3D=3D SFRAME_FDE_PCTYPE_MASK)
        ip_off %=3D fde->rep_size;

Since fde->rep_size and fde->info are populated directly from the user-prov=
ided
sframe section, does anything ensure rep_size is non-zero before reaching
this code?

If a user provides an sframe section with rep_size set to 0 and the
SFRAME_FDE_PCTYPE_MASK bit set in the info field, will this lead to an
unhandled division-by-zero exception and crash the kernel during stack
unwinding?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D17
