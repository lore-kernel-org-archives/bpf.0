Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C5442109
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332642; cv=none; b=BdWrc1m/4wI/W+KGZHn8FjAdMhTCwojXmebZdNvXr/Rm5wzesYUvlI0wK5g7jglKlGVtebP72sTgD6oFQIJ5vUWNtiWax+HTC31mQg+wYyH7rLmXF7NBH0/egwpeDH1SdrZypmciUlvSVkUm585nFCz33rz+BT4Khp4pm8zF0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332642; c=relaxed/simple;
	bh=c0sK1CXpc7Qs2ZeV6S+nUGed6s5aGvgPxYXu+cGzRzw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SFI7wAX1H2SfTTiDA9ozecFdw9vi52bgIC0VUKSmAbVOH54jpWCDkIEi5+wN2cfoKt8uADc6QlAm6SsfJQCDw20Lit7UZcABozZmJtXMTEJlaF+wcVdmpZTkim447kd5qu5IQqbYfOvzpiIni4ZO1XiAVii5AvCImn4JPJOvTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq9OuvB6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq9OuvB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDBB1F000E9;
	Mon,  6 Jul 2026 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332641;
	bh=WKugVy/tKItxc2QiBcTqI/qOcTw7yktiCZ/lrM7spHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lq9OuvB6pyniUgAIdAi0BRAvvuDt2v3crRmVIKU/r4MNWyeuD3qYxU3qwTsxaaPcC
	 y7I+xomsVYTRfhc3zdAKSh5wfYloo22Le6jzerplG3NAu2GBmLq/hhjFby2SzAFHl3
	 8wCJ8qvQzfiQqG4XzoskWrMbAjeyzLO5IVtimEjNcRqh7K9VxHS0yp60JjopL1Ge6j
	 C5pHm+RBha8e9LPgcNbcYKmyckjVE/e2t2XG+VlwZx5kk30JgOS0eEVkCUdvP+GZmO
	 6pGqneiZiM2qCrA4it4L4cHFvhbJoZ8b9cFCwFAimJJsWE1TkMDmmz+HNfpAjTXbQE
	 DFSQ5a5aqKDIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/6] selftests/bpf: Add ksock kfunc test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706093525.13030-4-mahe.tardy@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
 <20260706093525.13030-4-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:10:40 +0000
Message-Id: <20260706101040.DEDBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Dead code and flawed insert logic in `ksock_ctx_insert()` due to=
 unconditional map element overwriting.
- [Low] Unnecessary manual validation of BPF program FDs after successful s=
keleton load.
--

commit 559d17f26b2fc7936f58b27cbc4a4f83dacd3a73
Author: Mahe Tardy <mahe.tardy@gmail.com>

selftests/bpf: Add ksock kfunc test
   =20
Add a selftest that exercises the ksock kfuncs end-to-end. One sycall
bpf setup program creates a ksock context and connect the socket.
Another syscall bpf program lookup the context and send test data.

> diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testi=
ng/selftests/bpf/prog_tests/ksock.c
> new file mode 100644
> index 0000000000000..085ddb59067e8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/ksock.c

[ ... ]

> +static bool ksock_setup_ctx(struct ksock_basic *skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	int err, pfd;
> +
> +	skel->bss->ipv4_remote =3D inet_addr(LOOPBACK_IP);
> +	skel->bss->remote_port =3D RECV_PORT;
> +
> +	pfd =3D bpf_program__fd(skel->progs.ksock_setup);
> +	if (!ASSERT_OK_FD(pfd, "ksock_setup fd"))
> +		return false;

[Severity: Low]
This isn't a bug, but is it necessary to manually validate the program
file descriptor here?

According to the BPF subsystem selftest guidelines, after a successful
skeleton load, skeleton-generated program and map FDs are guaranteed to be
valid. Since this is called after a successful skeleton load, the
ASSERT_OK_FD check might be redundant.

> +
> +	err =3D bpf_prog_test_run_opts(pfd, &opts);
> +	if (!ASSERT_OK(err, "ksock_setup run"))
> +		return false;

[ ... ]

> +void test_ksock_basic(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct ksock_test_env env;
> +	struct ksock_basic *skel;
> +	int err, pfd;
> +
> +	skel =3D ksock_basic__open();
> +	if (!ASSERT_OK_PTR(skel, "skel open"))
> +		return;
> +
> +	err =3D ksock_basic__load(skel);
> +	if (!ASSERT_OK(err, "skel load")) {
> +		ksock_basic__destroy(skel);
> +		return;
> +	}
> +
> +	if (!ksock_test_env_setup(&env, NS_TEST))
> +		goto fail;
> +
> +	/* Step 1: Run the setup SYSCALL prog to create ksock */
> +	if (!ksock_setup_ctx(skel))
> +		goto fail;
> +
> +	/* Step 2: Run the send SYSCALL prog */
> +	pfd =3D bpf_program__fd(skel->progs.ksock_send);
> +	if (!ASSERT_OK_FD(pfd, "ksock_send fd"))
> +		goto fail;

[Severity: Low]
This isn't a bug, but similarly to the check in ksock_setup_ctx, is this
ASSERT_OK_FD necessary since the skeleton is already successfully loaded?

> +
> +	err =3D bpf_prog_test_run_opts(pfd, &opts);
> +	if (!ASSERT_OK(err, "ksock_send run"))
> +		goto fail;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/ksock_common.h b/tools/tes=
ting/selftests/bpf/progs/ksock_common.h
> new file mode 100644
> index 0000000000000..87d92372d28dc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/ksock_common.h

[ ... ]

> +static inline int ksock_ctx_insert(struct bpf_ksock *ctx)
> +{
> +	struct __ksock_ctx_value local, *v;
> +	struct bpf_ksock *old;
> +	u32 key =3D 0;
> +	int err;
> +
> +	local.ctx =3D NULL;
> +	err =3D bpf_map_update_elem(&__ksock_ctx_map, &key, &local, 0);

[Severity: Medium]
Will this unconditional bpf_map_update_elem call defeat the intended
collision detection logic below?

Because __ksock_ctx_map is a BPF_MAP_TYPE_ARRAY map, calling
bpf_map_update_elem with a zero-initialized value (local.ctx =3D NULL)
will clear the existing entry and implicitly free any pre-existing kptr.

Consequently, the subsequent bpf_kptr_xchg will always see a NULL pointer,
making the if (old) check dead code and causing the function to silently
overwrite existing entries instead of returning -EEXIST.

Could the logic be adjusted to perform the lookup and exchange without
overwriting the element first?

> +	if (err) {
> +		bpf_ksock_release(ctx);
> +		return err;
> +	}
> +
> +	v =3D bpf_map_lookup_elem(&__ksock_ctx_map, &key);
> +	if (!v) {
> +		bpf_ksock_release(ctx);
> +		return -ENOENT;
> +	}
> +
> +	old =3D bpf_kptr_xchg(&v->ctx, ctx);
> +	if (old) {
> +		bpf_ksock_release(old);
> +		return -EEXIST;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706093525.1303=
0-1-mahe.tardy@gmail.com?part=3D3
