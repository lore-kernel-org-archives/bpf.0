Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8352ED34;
	Tue, 13 Oct 2026 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913839; cv=none; b=fHoHUIB+3DaEPExc/TPIjU+4JSgOvsCVFxJfG0KWdz+acl0LWwAZKNCUmVuyVuy5qK+w9pTgdjj9mfcF+rpaIxZY/KJ8BKhG+sKUsMLQcnBibOGQoqzM7dFntzz3NrKpUJysyFmkvB6bLOUzUaWWeVH65chR1+ojD9O8PWUJjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913839; c=relaxed/simple;
	bh=tJBYIPty0wZGKXBsahlACcs5kyHe8Wvd8z8QWxPslsU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AwfriYWYEneVBf9y6dWkrceXeqo3yrwT3I6wolcg/infS937LSeWxMbzUZK31n32V6Q+Li0Ywx2kiHRnrEnpDM0jdb8uoGeo12asLaoMTLYUp/WeFo6uu5KJAF+AC9Hs4VHt1+z+6zKUV0GX5hNui2aqMixJHSgy7p+TyLvIg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUdwukG5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUdwukG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1631F000FF;
	Tue, 13 Oct 2026 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791913837;
	bh=zUjjV6Cmbrjfwa6o9ObEk59OU11hEIqLuHXUcxmn06Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PUdwukG53RfJVa6mSXZi8k8hkxiRShU8DwbxTwH1C9cLJxjgeP+zMCq5chpwzahRn
	 b9oCdwBBKFFEA5HxZ8/HOw6dmH0OBXlhxbXKjTzMKfmCRMnf2vgIvm2mVHoMuyjmHR
	 3pds3LFkkKmIp//yz+mhtQ09o2bDv+GW0nUcrEVqxMhWA2Ke/fs20Ay6ApmI7/462X
	 8DvhrayWSLyhOOx8bNO3tvorpn474FVntvKX2OtOx4rCMOnphmoSmDYKLm0MznvxhX
	 WQ7pzfC/z3qae7AvfB45dhh79oguNU3ae/fW9npOGBSDPyWNEw3mMlnVaTpHvQQOV0
	 Gryn+innZJhyA==
Content-Type: multipart/mixed; boundary="===============0643839994356313088=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0dda1ea4bbfdccac43ee6f9912def948628faa95450bc7b5a0cc6543838f3ee2@mail.kernel.org>
In-Reply-To: <20261013171211.1661726-1-listout@listout.xyz>
References: <20261013171211.1661726-1-listout@listout.xyz>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add tests for memcg kfuncs
From: bot+bpf-ci@kernel.org
To: listout@listout.xyz,bpf@vger.kernel.org
Cc: bdas@suse.de,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,jp.kobryn@linux.dev,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 13 Oct 2026 17:50:35 +0000 (UTC)

--===============0643839994356313088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests for memcg kfuncs

TL;DR: Test-only nit: alloc_pagecache() in memcg_kfuncs.c duplicates the copy
in arena_memcg.c, so fixes must be made twice; consider moving it to a shared
helper such as cgroup_helpers.c.

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/memcg_kfuncs.c
> new file mode 100644
> index 000000000000..4527000ae408
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_kfuncs.c
> @@ -0,0 +1,306 @@

[ ... ]

> +/*
> + * Fill the page cache with @size bytes of clean, reclaimable pages by
> + * reading a sparse temp file. Returns the fd, which must stay open, or
> + * -EOPNOTSUPP if the working directory cannot back such a file, -1 on error.
> + */
> +static int alloc_pagecache(size_t size)
> +{
> +	struct statfs stfs;
> +	char buf[4096];
> +	size_t off;
> +	int fd;
> +
> +	fd = open(".", O_TMPFILE | O_RDWR | O_EXCL, 0600);
> +	if (fd < 0)
> +		return errno == EOPNOTSUPP ? -EOPNOTSUPP : -1;
> +	/* tmpfs hands out shmem pages, which are not reclaimable without swap */
> +	if (fstatfs(fd, &stfs) || stfs.f_type == TMPFS_MAGIC) {
> +		close(fd);
> +		return -EOPNOTSUPP;
> +	}
> +	if (ftruncate(fd, size))
> +		goto err;
> +	for (off = 0; off < size; off += sizeof(buf))
> +		if (read(fd, buf, sizeof(buf)) < 0)
> +			goto err;
> +	return fd;
> +err:
> +	close(fd);
> +	return -1;
> +}

this isn't a bug, but alloc_pagecache() here looks like a line-for-line
copy of the static alloc_pagecache() in prog_tests/arena_memcg.c.

Both versions have the same open(".", O_TMPFILE | O_RDWR | O_EXCL, 0600),
the same fstatfs()/TMPFS_MAGIC check, the same ftruncate() plus 4096-byte
read() loop, and the same -EOPNOTSUPP / -1 return contract.  The skip
message that goes with it, "no disk-backed O_TMPFILE in cwd", is also the
same string used in serial_test_arena_memcg().

If the reclaimability detection ever needs fixing, the fix has to be made
in both copies.  For example, ramfs also supports O_TMPFILE and its pages
are unevictable, but only TMPFS_MAGIC is checked.

Could alloc_pagecache() move to cgroup_helpers.c (or testing_helpers.c),
which test_progs already links, so both tests share one copy?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38438128349
--===============0643839994356313088==--
