Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06633FF89B
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790353757; cv=none; b=IyB3/mPO/3huibYmJjt/H0zbaFGLNNzbCV+k1hmrx4Ct7hWWY4nu4xaKp3JpnaGuhJcPicHUWr8mLRSjCiw94qtB/zTdY+gqQMi/GvXJi44thoc/l2wU+hbHKyIRvKHS2A9/agABvr9ItoO0X+zXJ7y0kLnQZA2HCoqiHwK9nRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790353757; c=relaxed/simple;
	bh=TPNs6g47OJRWEYtxkGzlcP2gTN2fVWshq366DOpsdBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RSZVDPnTkoo9SbNv4n9tZ5//xnUCZrC4fYbenQaxNyzBX0KuLPqzcga+SKlipMFlcLTONOYOALosBSFfBgVvDeyHYqoBKDG7yffy5jWkAQ3TqVMUGK3I8yoObUJLObxQ5qVhyhr8Es0HjF6JCygPNa/QKs5rRYFhgfPf8n1897A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ojb1F7dg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ojb1F7dg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB261F000FF;
	Fri, 25 Sep 2026 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790353755;
	bh=d1XQgqQLGtwJ+EYaXw8P4JmHmVg3xYTqpAI9d/6tHfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ojb1F7dguJ7awQIS+BLz1EKR78Om6XGWAno35m3uAKa1B539YhGv1BUDmSYz1SE/v
	 GEMHEBKhlmA3GgYrLDBSbQPHajPWgxL0n+BjE9k7eI7XBlb1xyfj7bjWywmcvZVFom
	 z23T3N5vOOUcqY7zwiNbtNq5PQsZlS3Sbn0exIPy9eWOmQf8wWOhUC0ToYdqlGu7Nv
	 xz46gEPMufOSeCSa5gr/sTqy10tU96KZ/nef4C421DUACY1mwacYb3vcAOnrIZnXNt
	 5oFCSmvZueAttKjUuV71bsd2tfs14/u/l0ftNFunG88YO4bflhfRkFQxhQT55XyIO3
	 gTJUQCqDFEEqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Check that bpftool map
 dump fails for socket storage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Skokov" <skokovmaksimevg@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260925162031.27259-3-skokovmaksimevg@gmail.com>
References: <20260925162031.27259-1-skokovmaksimevg@gmail.com>
 <20260925162031.27259-3-skokovmaksimevg@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 16:29:14 +0000
Message-Id: <20260925162915.2CB261F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: missing unlink of pinned map causes permanent test failure
--

commit 602b2c7f146f62e2714d566e5a1fb9912bee7425
Author: Maxim Skokov <skokovmaksimevg@gmail.com>

selftests/bpf: Check that bpftool map dump fails for socket storage

This commit adds a test to verify that bpftool fails to dump a socket
storage map. It creates a map, attaches storage to a socket, pins it,
and checks various output formats.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/=
tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
> new file mode 100644
> index 0000000000000..0a0fa8926b239
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
> @@ -0,0 +1,88 @@
[ ... ]
> +void test_bpftool_map_dump(void)
> +{
> +	int map_fd, sk_fd =3D -1, value =3D 42, ret;
> +	char output[1024] =3D {};
> +
> +	map_fd =3D create_sk_storage_map();
> +	if (map_fd < 0)
> +		return;
> +
> +	sk_fd =3D socket(AF_INET, SOCK_STREAM, 0);
> +	if (!ASSERT_OK_FD(sk_fd, "socket"))
> +		goto out;
> +	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &sk_fd, &value, BPF_NOEXIST),
> +		       "add socket storage"))
> +		goto out;
> +	if (!ASSERT_OK(bpf_obj_pin(map_fd, PIN_PATH), "pin map"))
> +		goto out;

[Severity: Medium]
Looking at test_bpftool_map_dump() in
tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c, will this cause a
permanent test failure on subsequent runs if the pin operation fails, or if=
 the
test is interrupted early?

If bpf_obj_pin fails and we jump to the out label, the test skips over the
unlink cleanup. The map then remains pinned, which means the next run will
encounter EEXIST when it tries to pin the map again.

[ ... ]
> +	ASSERT_HAS_SUBSTR(output, "can't dump sk_storage map",
> +			  "plain dump explains why on stderr");
> +
> +	unlink(PIN_PATH);
> +out:
> +	if (sk_fd >=3D 0)
> +		close(sk_fd);
> +	close(map_fd);
> +}

[Severity: Medium]
Since the out label is positioned after unlink(PIN_PATH), the cleanup is
bypassed on failure paths.

Should the unlink be moved after the out label so the cleanup is always
executed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925162031.2725=
9-1-skokovmaksimevg@gmail.com?part=3D2
