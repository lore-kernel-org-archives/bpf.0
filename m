Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969095;
	b=49i/HfjnePXYAKXIRLr0HZArT6EAq9E2zU/hgamUuDBrYF/xRc/V65bto4NF+f5Oksph
	 qdV2d8zyBxsngtPOKdPuq6+Fpcv6We6ynbDgS4LVtXZk67wQMyPk4g4FkcAylaJabU9Bz
	 2nuMOFDPlCYNMGdXePFj2y8/J9rnboP4gZlX7zbXUc4Ym/QfEUzfebDSEU0dD0j3T0nLx
	 DrKblTIpyAuw4Jb9+0tHzKLtwF39vTW9+IAI9rzlDlCN4h8YHHy7+bB0djdh1OfeaEFVG
	 EQgxjS5Td92jWiGrb7b3B8K3ksTlFq1R7U/tzYICufhWCbqlVYhTPN3RHuZou1KNKdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969095;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2hEhmCtSs/8Z6r6FWqcdALadPIzK432yBaG7cvpOShM=;
	b=VSccTYyVae7pAtVqnfNj1OgiHRZKPllkfKsenUOHwyKFidnpXZMuoVLLDJvrLHjalJ1r
	 PDq2ZgtCWJsSDQujtGPgcuVYFyFr60hJmadR6Uh2FmJqGWru71OOiG1EFy0HrduxLQp6Y
	 P5zSUhXK5Ux8v82GG9JwCvoR9wDFw/W8rgRpLFFAF2nRf2wYm1OORQqLk4y1okV0zuxKP
	 9V1qqD9hvEFmFoIoRwkf8YGDuewFS4KsQcAcVmSK6xctyq3UZMuTQCHopTXCGt+WvWEEa
	 smWeRzeK6nq/WrgmHldiV0H7Md6AR0rG4U4DdW3s7O55ubXb6loTEEmaQxQtCl8aQ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdurMwRx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45680606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdurMwRx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE091F0089F;
	Fri,  6 Nov 2026 12:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969095;
	bh=2hEhmCtSs/8Z6r6FWqcdALadPIzK432yBaG7cvpOShM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XdurMwRxfoX+KpD1GipkQbk2E50PcaNLjjXineOw8ZzBfI73AbgWo2CYwUO/WMArk
	 qQLnzvjAnlynr6uXFd9QxB34aBycHC4/L/PGdqN3INDc9dCQlh8XtERs5U50uOVWys
	 a0qVfWlsISGmLVGjKJps1dOPO/ng0I8nSFh+N5r8WXHEsyHWRGcWwNVuWGsM4isCj3
	 sXSgIAaS5fCp5n8aOu1zOEpwao7Gn+k2bsKrUWJJ7J9u4Eg4HYKuSJIvBcnj1dUiOQ
	 jZdh65B47cVhOeCmFvyqZmkNxBB7w0k9Iqq57nLgGvBSJUEMwvX/bitPQxZdRCQitE
	 orFw9uEEa6NWw==
Message-ID: <sashiko-outbox-201410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v13 3/4] selftests/bpf: add iocost cost model test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261106122356.3224638-4-cui.tao@linux.dev>
References: <20261106122356.3224638-1-cui.tao@linux.dev>
 <20261106122356.3224638-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 12:44:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests/bpf: pread() in serial_test_iocost_model_streams()
  hits page cache
--

commit 371817062abb0b837764b9a93458f77eb2057dd2
Author: Tao Cui <cuitao@kylinos.cn>

selftests/bpf: add iocost cost model test

This commit adds BPF selftests and two example struct_ops cost models for
blk-iocost using a configfs-backed null_blk device.

> diff --git a/tools/testing/selftests/bpf/prog_tests/iocost_model.c b/tool=
s/testing/selftests/bpf/prog_tests/iocost_model.c
> new file mode 100644
> index 0000000000000..a714507c040e3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
[ ... ]
> +void serial_test_iocost_model_streams(void)
> +{
[ ... ]
> +		devfd =3D open(path, O_RDONLY);
> +		if (ASSERT_OK(devfd < 0 ? -errno : 0, "open_dev_ms")) {
> +			char iobuf[4096];
> +			unsigned long long u1 =3D 0, u2 =3D 0;
> +
> +			ASSERT_OK(read_cost_usage("/iocost_ms",
> +						  dev, &u1), "cost_usage_pre");
> +			for (i =3D 0; i < 500; i++)
> +				(void)read(devfd, iobuf, sizeof(iobuf));
> +			/*
> +			 * Two interleaved sequential streams: exercise the
> +			 * stream table, not just a single cursor.
> +			 */
> +			for (i =3D 0; i < 200; i++) {
> +				(void)pread(devfd, iobuf, sizeof(iobuf),
> +									(i + 1) * sizeof(iobuf));
> +				(void)pread(devfd, iobuf, sizeof(iobuf),
> +									(1 << 20) +
> +									(i + 1) * sizeof(iobuf));
> +			}

[Severity: Medium]
Do these interleaved pread() calls get satisfied from the block device page
cache without reaching iocost_ms_calc_cost()?

Because devfd is opened without O_DIRECT, the preceding 500 sequential
4096-byte read() calls populate the page cache for bytes [0, 2048000).
Both pread() streams read within that cached range ([4096, 823296) and
[1052672, 1871872)), so no interleaved bios are submitted to the block
layer and the multi-stream slot table is not exercised while the
subsequent assertions pass from the initial read() loop alone.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106122356.3224=
638-1-cui.tao@linux.dev?part=3D3
