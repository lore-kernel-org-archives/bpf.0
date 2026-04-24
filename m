Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B58266581
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060976; cv=none; b=bnoutj/iy+Bp7T+95rjEvIv1UBkPGkgWq+SXsXakuO69gAb0JuRHb6oiC9p2049Xso9TWyUJtegqveKCRZBI1RPbDmhn+HIE4rlx4eR2mgjwG1ajOo7oaBRTuEAOvDcKkYGcwKeGciaB9X9areD05XbSkr0cDpHvGQFN5eV5t/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060976; c=relaxed/simple;
	bh=4BAfeI9+lP7+P9gZex+T1JM6Sj3OwZBROF6ymKtk8ms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O7HF3FiXzxg8K7mPCgeYzNta4h7X7uDOTjyMZNszrZsgC+ms2uEBtT5TXp05ZyLNH13H8OXY29RPPK3MLs+gEbypul9i155Q7OtRag6fuG+0tNKOXyeeKFMkksgDGNKLGfWUQT/52O8bxNsbVfAFWHR3zHdf0/8nUsIUvazGiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BL0RApVs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BL0RApVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C89C19425;
	Fri, 24 Apr 2026 20:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777060976;
	bh=4BAfeI9+lP7+P9gZex+T1JM6Sj3OwZBROF6ymKtk8ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BL0RApVsZEVne3HXj5aNZR8uLiAp6Kje0+yTjPNm2l2rVB04/YwoYTSRziTLo3H6R
	 /oOFQ7FgBNAL7AvgFaIKBYqqXNCQjb6e4qR2t6tJa82zJW3r6JotJzaPKlMpYXX/x6
	 0pQSz5uC9AXcDtNCzt8Rahb2HEjmZPjvw4/rrS0aUv0TYEveuzj97knOzCLP20TscQ
	 T4EYOVJ9BdQbwWK5mbIg5LjHYFLXA9lueYRqdtopH33Vq/XdLYtsrvWnW//vdWI0ri
	 49JBLLRDjsccD0Jdb35UgRDlFaON+WGpeuSlO+rtALxi5AdokyYCf+tBakThteqt2W
	 bHpjt17CP+u7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 07/10] selftests/bpf: Add basic tests for
 resizable hash map
Reply-To: sashiko@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424-rhash-v3-7-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-7-d0fa0ce4379b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 20:02:54 +0000
Message-Id: <20260424200255.D5C89C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The BPF test framework silently ignores test failures because it=
 does not check the BPF program's return value (`opts.retval`) and incorrec=
tly reuses the global `err` variable.
--

commit dc85c0ab999d049899213215cdd840f6c0a212f0
Author: Mykyta Yatsenko <yatsenko@meta.com>

selftests/bpf: Add basic tests for resizable hash map
   =20
Test basic map operations (lookup, update, delete) for BPF_MAP_TYPE_RHASH
including boundary conditions like duplicate key insertion and deletion of
nonexistent keys.

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testi=
ng/selftests/bpf/prog_tests/rhash.c
> new file mode 100644
> index 00000000000000..0f6eec4fe1fe1d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhash.c

[ ... ]

> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */

[ ... ]

> +	err =3D rhash__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;
> +
> +	err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
> +	if (!ASSERT_OK(err, "prog run"))
> +		goto cleanup;
> +
> +	if (!ASSERT_OK(skel->bss->err, "bss->err"))
> +		goto cleanup;

Does the test framework ignore the BPF program's return value here?

It seems opts.retval is not being checked.

> diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/se=
lftests/bpf/progs/rhash.c
> new file mode 100644
> index 00000000000000..9d066a22ce1865
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/rhash.c

[ ... ]

> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */

[ ... ]

> +SEC("syscall")
> +int test_rhash_update_delete(void *ctx)
> +{
> +	int key =3D 6;
> +	struct elem empty =3D {.val =3D 4, .arr =3D {0}};
> +	struct elem *e;
> +
> +	err =3D 1;
> +	e =3D bpf_map_lookup_elem(&rhmap, &key);
> +	if (e)
> +		return 1;
> +
> +	err =3D bpf_map_update_elem(&rhmap, &key, &empty, BPF_NOEXIST);
> +	if (err)
> +		return 2;
> +
> +	err =3D bpf_map_delete_elem(&rhmap, &key);
> +	if (err)
> +		return 3;
> +
> +	e =3D bpf_map_lookup_elem(&rhmap, &key);
> +	if (e)
> +		return 4;

Can this silently ignore test failures?

If this final lookup succeeds (meaning e is not NULL when it should be), the
BPF program exits early with return 4. However, the global err variable
was just set to 0 by the successful bpf_map_delete_elem() call above.

Because the userspace runner only checks ASSERT_OK(skel->bss->err) and igno=
res
opts.retval, won't this incorrectly mark a failed test as passed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424-rhash-v3-0=
-d0fa0ce4379b@meta.com?part=3D7
