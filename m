Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48333E35C
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727169; cv=none; b=TknYiwgB7G2vLXzhd1WlXaMnHEiUdhdn8LsrAg2YH2xNnpNSrn9kuP59GJ1w16kS5q8dVUC12kBVevH1LF/y+XeXgxlR59EwRR0GR5Ztzzb8iaxJ/aaXKms28wHse2XuT82b9d3u6h7TLRaH+L3iYjXHN/nZ0rQvemVU+qyrAMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727169; c=relaxed/simple;
	bh=ab2DlUr/CgaNCKlmskyAXjr3b7qDV1eEtIP4TSipdtY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pAnJim2cdTGYhj6njmbVPwb8KihgId8oOAphkGADWi1jzc8aCdmeGENEAx+2XX7KJgPk0G+Me7zNOaWljd+prMZgg9PkNnm2U4ZSJR3EgAU4DkSr1bDtqJ0vkH9MZNsIMQvI9pEcrCoLy9C6pz4f0exdrdG/f6wncrmgV5uvAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VizkQnj4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VizkQnj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B33E1F000E9;
	Wed, 17 Jun 2026 20:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781727168;
	bh=STQrX+fla0a7tqawMQZ3XGYNWhDGiifJb0LhptEzWP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VizkQnj49p2BlIvXl94/NnCHQ5Ykcjuto7RteEN5nrC7QO6BjCiZxrQe9LRU9OHVM
	 KWe+02RWF0DPeHymvSwsCkh+1FDSdLMB7yfCMdhcLZ+YgoQfAXUCgQ4DL/LwJj/Cm8
	 CKl7sLQse7MKBzUIq8sMn9jNoZ18c4svyss4SBWmrFf4S3BJ4VVUUoTPKAm736NGCj
	 b/zOhx8oKuEA7qVwFfvRGncLwYepMEvYAfJiMIL+AW8WmhXjQcehaky0w6krgnegwq
	 Rw0N2L7L2bZ12xtfUA15AOpPtWez9AMQGJDChCUB8nIaAMuHEm35gFU2xBo8zlbrFt
	 GLVLf3jc7wBhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Cover stack nospec slot
 indexing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260618-f01-11-stack-nospec-slot-index-v2-2-ede9495359b6@mails.tsinghua.edu.cn>
References: <20260618-f01-11-stack-nospec-slot-index-v2-0-ede9495359b6@mails.tsinghua.edu.cn>
 <20260618-f01-11-stack-nospec-slot-index-v2-2-ede9495359b6@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:12:48 +0000
Message-Id: <20260617201248.7B33E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `__xlated_unpriv` expectation strings contain an extra space=
 in the frame pointer offsets (`r10 - 4` and `r10 - 8`), which will cause t=
he strict substring match against the verifier disassembly to fail.
--

commit 14e5b2945bb48da1c1729feb483806b25ccac3aa
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

selftests/bpf: Cover stack nospec slot indexing

This commit adds a verifier test for fixed-offset stack writes where two
4-byte stores initialize opposite halves of the same stack slot. The test
runs through the unprivileged loader and expects both writes to emit
nospec instructions.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/=
testing/selftests/bpf/progs/verifier_unpriv.c
> index c16f8382cf17d..d54e5b59e62e5 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
[ ... ]
> @@ -976,4 +976,26 @@ l0_%=3D:	exit;						\
>  	: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__description("unpriv: Spectre v4 stack write slot index")
> +__success __success_unpriv
> +__retval(0)
> +#ifdef SPEC_V4
> +__xlated_unpriv("r0 =3D 0")
> +__xlated_unpriv("*(u32 *)(r10 - 4) =3D r0")

[Severity: Medium]
Will this test fail due to the extra space in the offset? The BPF
disassembler typically formats negative offsets without a space after the
minus sign, like *(u32 *)(r10 -4) =3D r0. Since the selftest framework uses
exact substring matching for the __xlated_unpriv assertions, expecting
(r10 - 4) and (r10 - 8) might cause a spurious test failure.

> +__xlated_unpriv("nospec")
> +__xlated_unpriv("*(u32 *)(r10 - 8) =3D r0")
> +__xlated_unpriv("nospec")
> +__xlated_unpriv("exit")
> +#endif
> +__naked void stack_write_nospec_slot_index(void)
> +{
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-f01-11-sta=
ck-nospec-slot-index-v2-0-ede9495359b6@mails.tsinghua.edu.cn?part=3D2
