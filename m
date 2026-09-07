Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13038AC68
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760311; cv=none; b=d20QsF4lOASfDozTHJ7w4LEbH9uTGMDBkPMXdteBjIPrAxbOnjBP3OKXRK+pH2+2d9YRN0zMkzBZ3pdauJ4g0SASx4k2C5sjwZTQLhHkNljtTvmMJrAT+xqVQNI4D5yX+WzUYZWxF8bcsgkUwXdnhJA9S2lydgM3TQOLWqxqnMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760311; c=relaxed/simple;
	bh=/UjtUFP8xz45spIpTntDBlzlAlsYmyu4uffrg7MI31M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cRQj1TGycjZYLOnoWIsRXbNh+CkEktGgrXORVx49pHQhfhu6v3lWOOQ1ewNOubG/1cF0ufLtZAtGn3ZyJ+85bE93wq/t+8vnK6i/ELsbMWT0U5LRU/G6WLPOQbeew0NXwbJS9Aty0IFrbmLXR7qljFohu2p7AYA1GFcG6yVYom4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdqrFfDh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdqrFfDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FC71F00A3A;
	Mon,  7 Sep 2026 05:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788760310;
	bh=ZvYkqFYjZJpqyH0rr2QUkuivQ4HrQbfIzQ0K3Q4wy6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GdqrFfDhXD9str7bO3vxS4A5ZGjW2lOzyMP1pxNJElT/A1XvSVnx3jpoeQWeAMFvZ
	 GiJp83vhsBFvfXn9nTAeGRg3LIUle6q86ObSNPzKyc3bFhIRGrw0U1X/GUfpiXpAf2
	 oliNfzuwdUbTFPTCYvlRrv9XYK/DJzQrpYuPEt6TIlbg7WZW0RmYCRAMF3jzqpZ8lK
	 U9zGkIKgE8HdQRBq9aqTo7px+kqK56B2BHbBFixscVFBgj10AZ9doHCk7RuYq6qzGj
	 HOw47k2hH8TgHepT5AvBNS2S2ksMMXPLBrA+UBK6RvZeJgvqjx0E7OqslBRWSZrIs+
	 qZnzWavyV58rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 2/2] selftests/bpf: add tests for selective
 module BTF loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuyu Zhao" <zhaofuyu@vivo.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260907053847.1115-3-zhaofuyu@vivo.com>
References: <20260907053847.1115-1-zhaofuyu@vivo.com>
 <20260907053847.1115-3-zhaofuyu@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 05:51:49 +0000
Message-Id: <20260907055149.C8FC71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Flaky Test / errno Clobbering

Pre-existing issues:
- [High] NULL Pointer Dereference in bpf_object__close() on allocation fail=
ure
--

commit b3d2f975120fb1ef7382fad8983c653ebd2ae39c
Author: Fuyu Zhao <zhaofuyu@vivo.com>

selftests/bpf: add tests for selective module BTF loading

This commit adds selftests for selective kernel module BTF loading using
bpf_object_open_opts. It verifies that valid allowlists succeed, module BTFs
not listed are skipped, and invalid inputs are rejected.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.=
c b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
> new file mode 100644
> index 0000000000000..fb1b9ffb6c7aa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c

[ ... ]

> +static void test_invalid_input(const char **list, int count,
> +			       const char *test_name)
> +{
> +	struct btf_module_allowlist *skel;
> +	char assert_name[64];
> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
> +		.btf_module_allowlist =3D list,
> +		.btf_module_allowlist_cnt =3D count,
> +	);
> +
> +	snprintf(assert_name, sizeof(assert_name), "%s: open_opts", test_name);
> +	skel =3D btf_module_allowlist__open_opts(&opts);

[Severity: High]
This isn't a bug introduced by this patch, but does passing a negative count
or encountering an allocation failure here lead to a crash inside libbpf?

When btf_module_allowlist__open_opts() calls into bpf_object_open(), if the
count is huge (e.g., from passing -1 in the negative_count subtest) or call=
oc()
fails with ENOMEM, the array remains NULL:

tools/lib/bpf/libbpf.c:bpf_object_open() {
    ...
        obj->btf_module_allowlist =3D calloc(obj->btf_module_allowlist_cnt,
                                           sizeof(*obj->btf_module_allowlis=
t));
        if (!obj->btf_module_allowlist) {
            err =3D -ENOMEM;
            goto out; /* out calls bpf_object__close(obj) */
        }
    ...
}

Then bpf_object__close() iterates over the unallocated array:

tools/lib/bpf/libbpf.c:bpf_object__close() {
    ...
    for (j =3D 0; j < obj->btf_module_allowlist_cnt; j++)
        zfree(&obj->btf_module_allowlist[j]);
    ...
}

Since obj->btf_module_allowlist is NULL but obj->btf_module_allowlist_cnt is
greater than 0 (or -1 cast to a large unsigned type), won't this blindly ac=
cess
memory and crash?

> +	if (!ASSERT_NULL(skel, assert_name)) {
> +		btf_module_allowlist__destroy(skel);
> +		return;
> +	}
> +	snprintf(assert_name, sizeof(assert_name), "%s: open_opts err", test_na=
me);
> +	ASSERT_EQ(errno, EINVAL, assert_name);

[Severity: Medium]
Can this cause test flakiness?

According to POSIX, standard library functions like snprintf() can clobber
errno even on success.

Since snprintf() is called right before ASSERT_EQ(errno, EINVAL, assert_nam=
e),
is it possible that errno gets modified here and causes the assertion to
fail?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907053847.1115=
-1-zhaofuyu@vivo.com?part=3D2
