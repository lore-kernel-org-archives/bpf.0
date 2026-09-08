Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DEC54DAC4
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878967; cv=none; b=bZsPt4mr7hoI4jSj0uIEFsAR0Sd2N+MVgi9M4HKcQbsDjydi5B9np7ZnKqYf++xgalyxU3a6jd22tdjsr+2kP+jQDnKYYZ8vZjKoxdicz9hxCYlqERHHvbzALNkCYHU+E7AWTK4QTAbMBljdLm55RWg34tj7Qzcr3AWBz49JF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878967; c=relaxed/simple;
	bh=b4ruYNTVkpoJ8+i7XZ7qq8B8hoDVN2T4NnLI6AZUQWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FgwzzqFEUGpGwrI48e55T59l5N/0V+oVweLclCD+X0QYorbpjBeTeFm7+cFGHPTcd15irhYH8bT8K+lF5pc6pVqUrKDk9dLWSiLsDxji14y7k6z3z+ZlZGdmVRVHFadwCuR/4uMtoy1ByKdI0gED8fRpJGFC14I63PrlKn56goI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D6C1F00A3D;
	Tue,  8 Sep 2026 14:49:15 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10.y] bpf: Enforce expected_attach_type for tailcall
 compatibility
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlndWVsIEdhenF1ZXogKFNjaG5laWRlciBFbGVjdHJpYyk=?= <miguel.gazquez@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260908-cve-2025-40123-v1-1-be62451196fb@bootlin.com>
References: <20260908-cve-2025-40123-v1-1-be62451196fb@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:49:13 +0000
Message-Id: <20260908144915.24D6C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for tailcall expected_attach_type bypass: BPF_PROG_=
TYPE_EXT programs bypass the check.
--

commit d87774423a605def68b6715a3edf5dc1feea5da7
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Enforce expected_attach_type for tailcall compatibility

This patch aims to prevent context confusion by enforcing that programs
inserted into a tailcall map share the same expected_attach_type.
This restricts tailcalls from violating attach type constraints.

Link: https://lore.kernel.org/r/20250926171201.188490-1-daniel@iogearbox.net

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -1795,10 +1795,14 @@ bool bpf_prog_array_compatible(struct bpf_array *=
array,
[ ... ]
>  	} else {
>  		ret =3D array->aux->owner.type  =3D=3D fp->type &&
>  		      array->aux->owner.jited =3D=3D fp->jited;
> +		if (ret &&
> +		    array->aux->owner.expected_attach_type !=3D fp->expected_attach_ty=
pe)
> +			ret =3D false;

[Severity: High]
This is a pre-existing issue, but does this check effectively become 0 !=3D=
 0
for all BPF_PROG_TYPE_EXT programs, allowing arbitrary mixing of EXT progra=
ms
with different underlying target contexts?

It appears that for BPF_PROG_TYPE_EXT programs, expected_attach_type is
reset to 0 at the end of verification in bpf_check().

If userspace loads two BPF_PROG_TYPE_EXT programs targeting entirely
different functions (e.g., XDP_DEVMAP vs XDP_CPUMAP) and inserts them both
into the same BPF_MAP_TYPE_PROG_ARRAY, couldn't a tailcall between them
bypass this expected_attach_type check?

Can this allow a program verified for one target context to execute in a
different context, potentially leading to out-of-bounds accesses or NULL
pointer dereferences?

>  	}
>  	spin_unlock(&array->aux->owner.lock);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-cve-2025-4=
0123-v1-1-be62451196fb@bootlin.com?part=3D1
