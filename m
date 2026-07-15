Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1D44682F
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114886; cv=none; b=ad3CVwoyhr+VLZ6sdE5A9kovyMdWuI7gvuEI4YN0CNoNIQ6MuauGhmLRSljAgSG+/vkuw8oY7bNY4UTlyKITvdCGSEvphY9qRA3DYFzyYuEFNQ+vRsjJMKb7kLm/RF348Oxe69+nP7CsNH98+vIEpsmG12yJhHgWLvjNzHAf4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114886; c=relaxed/simple;
	bh=AEifz8ptWmQAavU/dMZjGdygAhbjhtFpTW180tB3K8M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rEFb5OnBUXmOG1ejfDyV4UvN00xAwHORVPi8WUbMx6EelLEWSswrZDwss9tw1VQHvS9dDrDddM2oPGmVKZ5TDKLxzavIAR8q16YRp0ouZ8JYfVW0xj1cTU+og1kYzrlRCPdQRE6KsF3UDZItXtIKiPCefDseazu78A+h0Y0q5TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxtwd/Aq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxtwd/Aq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB3A1F000E9;
	Wed, 15 Jul 2026 11:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114885;
	bh=HVCWLD0oYIwnG3lzerc+bUWBerKUQVBzGz3hysYuhs4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qxtwd/AqH8dF6tZMjSmRM7pttYhcMaS6zIoJI8OjwqZbH0We75qXQZskJWgAc+yQk
	 NyZWA+bgwhCh+Zazpkg62LzRivWyGc/b1a/EjoGoC7tZdTsu9pxj0sWq+0YA+VnDh3
	 wq6tkRd442RlfmdGJH3nJX49i+on2Le2Xp5yfBDhjIBhQePYEAxZrKM8eZf7CKWEGt
	 ugLPLqD+EnoB5Pqmc6mj7Lzn0QiUSRwl1eB2HtAEGD8tWpX+lx4Itn4jgxe00u34Sm
	 +DwBt4c3ND3DJ7v9YfhxK/TtippXxVpWE67JuZPJEix2Vlvrd1TbzBzNefPit11ALl
	 hI3wWNwLmZNVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Silence array bounds
 warning in global_map_resize
Reply-To: sashiko-reviews@lists.linux.dev
To: "Viktor Malik" <vmalik@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <57765bc465a27923c3c093eba222cc24d08d8c40.1784112948.git.vmalik@redhat.com>
References: <cover.1784112948.git.vmalik@redhat.com>
 <57765bc465a27923c3c093eba222cc24d08d8c40.1784112948.git.vmalik@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 11:28:04 +0000
Message-Id: <20260715112805.0AB3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment opening '/*' is not on its own line.
--

--- Patch [3]: [PATCH bpf-next 3/4] selftests/bpf: Silence array bounds war=
ning in global_map_resize ---
commit 477df4be9ab84dd41e948528c2cecec30f56ae6a
Author: Viktor Malik <vmalik@redhat.com>

selftests/bpf: Silence array bounds warning in global_map_resize

This commit silences a GCC false positive array bounds violation warning in
global_map_resize. It achieves this by accessing the BPF map array via a
plain pointer after it has been resized from within the BPF program.

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_map_resize.c b=
/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
> --- a/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_map_resize.c

[ ... ]

> @@ -58,10 +59,13 @@ static void global_map_resize_bss_subtest(void)
>  		goto teardown;
> =20
>  	/* fill the newly resized array with ones,
> -	 * skipping the first element which was previously set
> +	 * skipping the first element which was previously set;
> +	 * access through a plain pointer to avoid -Warray-bounds
> +	 * since the array was resized beyond its declared length.
>  	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
coding style?=20

The BPF subsystem guidelines require that multi-line comments have the
opening '/*' on its own line, even when modifying surrounding code that
uses the old style.

> +	array =3D skel->bss->array;
>  	for (int i =3D 1; i < array_len; i++)
> -		skel->bss->array[i] =3D 1;
> +		array[i] =3D 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784112948.gi=
t.vmalik@redhat.com?part=3D3
