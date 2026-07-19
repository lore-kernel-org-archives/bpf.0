Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A539C63E
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784471431; cv=none; b=mZ/3IxcGyPyO67Jwn+wwAkn4sM3n5+az1AoqSA9tX7RMLgtYFuabftwgrCixq5c7/rKg/QKxKF6RSmGCZ33piQGSVxy9hX27VA9VBSspUcsQb8ZmcELkGQowWB3EJxgXBj1OaCdbZ2fHl8GbKUtu83qiSV8+xZBgrdBbUsMTuy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784471431; c=relaxed/simple;
	bh=GkDhHk7WlCYTZy2WSZ1NENRNFwonEr26CkbW9fBaxgE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uh+y3jl8p7zeocL6rQfhr5rzW0lKJ5QYXxFl43xDfEgeEsg0AhWx87xiedfz/O9CGt+VncsKE7st/b9xSKQD1/rUX2Gd0Z8mV8s6iV0be6Oe4v7+Vy8GZwAjkJfVYTTHQBloIxqC8eNv6hMgnRwUitZGYSQkGPU3xfKgx1xhz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n448m5il; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n448m5il"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694951F000E9;
	Sun, 19 Jul 2026 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784471429;
	bh=fhNP1eQoMOmHgIx5vxsoJqwahcGA4Qzr+qIOjvQoSJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n448m5ilpC4FhvKrslbnESvCErmxsFhsRVQ1nv1w5myDGfYXiGl+th4cPkz+DuemA
	 8gR8D26xSYsKbPYyfu1fA6YJRVWPyEtZUi+yjYkvJuuov17zmn0Zuxt3dUC7F0b92g
	 u437nSxacsul/73K0he6lnptzomxYiP8yFBsOiKiEQCczQVKlfJoe75/Bvh32Jmo14
	 37IzyNg3NBK+7lp+PrVu0ac6yTEgRbbtGtknFCzfUOj12Ec6GehoqOuYzGwdIELPak
	 u/+cIY6h1MwtHEQlTw0rQfaz8FHYEzm7LtGZPjqwASfPr9rPTxPVO3vbbBMaky66Pj
	 yiXn5MvAKBhcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Test duplicate unique
 fields in nested structs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260719142401.2420111-3-memxor@gmail.com>
References: <20260719142401.2420111-1-memxor@gmail.com>
 <20260719142401.2420111-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 14:30:28 +0000
Message-Id: <20260719143029.694951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment style violates BPF subsystem guidelines.
--

--- Patch [2]: [PATCH bpf-next v1 2/2] selftests/bpf: Test duplicate unique=
 fields in nested structs ---
commit 9b7a72ba7e7b55aa85d89f130fc6922658c4bcf0
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Test duplicate unique fields in nested structs

This commit adds a raw BTF test with a spin lock directly in a struct
and another in a nested struct to ensure duplicates are rejected during
BTF loading.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
> index 66855cbd6b73f..02c4c60c841ee 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
[ ... ]
> @@ -4250,6 +4250,32 @@ static struct btf_raw_test raw_tests[] =3D {
>  	.max_entries =3D 1,
>  },
> =20
> +/* struct inner {
> + *     struct bpf_spin_lock lock;
> + * };

[Severity: Low]
This isn't a bug, but does this multi-line comment format violate the BPF
subsystem style guidelines? The BPF guidelines prefer the opening /* to be =
on
its own line rather than having text on the same line as the opening.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719142401.2420=
111-1-memxor@gmail.com?part=3D2
