Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B987A577E29
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653767; cv=none; b=cOZalb0JgZo6ugRpgPJoCrgBupnvNX9/bwSO5T33XiBMmBz0qZ2vRmk4tmPMrTvDwGRppSVbL73Y+nvcrAxub/eOWrk9d/BSYtB6OiWtm0HVHMDyMnuRQyF+W3SwzSDVK1BLc7uLsV+IKJCIq/hIn9f6E/ZccJcsU7+5QA+RUmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653767; c=relaxed/simple;
	bh=/JQ0dqE3UFEkHU8hHZV7tiA53Dqo9IIP4vXYsjqJ5OI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pSEnegwkUe6KrBGM+yhA3Y2UJ+xTezeXCiqLt9Hm01jS/6Eq6ZW2qwCkNyIArl29cU+5yFsjExkxqSjJqdxf8W2b126l2j+G9t/p4CPrUcQ6lLCVBZyzxaAb1FQDYOHN5CAPy43WO8RSImCloR5E42MIDN2qvgZdBuw0PVO+Bx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouu4ZzkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouu4ZzkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574A21F00893;
	Thu, 17 Sep 2026 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653765;
	bh=u8n/Zr9l/ED9/cTbDpEeLhzsHcoVXbtwpTzM6VG8iU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ouu4ZzkS0Ha2jzhhxTLLu3VtX4RoLjqOQKqlCNYOHQlg8TcsCUk/SHx2zZbqdi+20
	 RPc8AictukSyUeYq0bFQLgdFWoEPGof7dy9EA21eFQ3L0vddTCBHkm/Q8DlVU3Qnla
	 2cpEbQ5jHT7lBAXgT+613OwolemAuqlUyGUVZKing3qR20T3wgCG6MDUGNNnGvz6XE
	 6CMwiif8EqNvbH8uKH5SUxmGpPqwGlR8Gj7Bhm0Rx7xv3W/k+bUVqUJze+6DTWrE1E
	 QjOiohi18TOqEcgZfd0LElNb5U6KneV+wxhatd8dV4upvDlovqw+iK91H2VVOAtuFJ
	 Z5TwYQ+nGyJaQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next] selftests/bpf: Test XDP LRU hash rolling-window
 map updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917135433.2260048-1-anilkaushikwireless@gmail.com>
References: <20260917135433.2260048-1-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:02:44 +0000
Message-Id: <20260917140245.574A21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: unnecessary FD validation for skeleton-generated fields
--

commit 382196b03e5bc2ae66b47677cc5a9357a9560542
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

selftests/bpf: Test XDP LRU hash rolling-window map updates

This commit adds a small XDP program that writes packet lengths into
BPF_MAP_TYPE_LRU_HASH at seq % AGGREGATION_WINDOW. It also adds a test_progs
case using bpf_prog_test_run to check wrap, parse-fail isolation, and 5-tup=
le
isolation.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c b/to=
ols/testing/selftests/bpf/prog_tests/xdp_lru_window.c
> new file mode 100644
> index 0000000000000..fffbb4a0418ef
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_lru_window.c
[ ... ]
> +void test_xdp_lru_window(void)
> +{
> +	skel =3D xdp_lru_window__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	prog_fd =3D bpf_program__fd(skel->progs.xdp_lru_window);
> +	map_fd =3D bpf_map__fd(skel->maps.flow_table);
> +	if (!ASSERT_GE(prog_fd, 0, "prog_fd") ||
> +	    !ASSERT_GE(map_fd, 0, "map_fd"))
> +		goto out;

[Severity: Low]
Are these ASSERT_GE() checks necessary in test_xdp_lru_window()?

Since the skeleton is successfully initialized with
xdp_lru_window__open_and_load(), the BPF selftest skeleton framework
guarantees that all generated map and program fields contain valid file
descriptors.

Validating prog_fd and map_fd manually here appears redundant and contrary
to the established skeleton API contract. Could we remove this check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917135433.2260=
048-1-anilkaushikwireless@gmail.com?part=3D1
