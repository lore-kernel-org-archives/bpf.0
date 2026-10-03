Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DBC39CD1B
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050179; cv=none; b=r8a+grszJCrpPHauPEGzIszI1/pT1btM3P1qxJlS+DRAQULI5ARBIvx1+PvBiLkxh8P4L3r4kNqaGiVOeosFfUw7Ck/GxF2WI6sL+IhNBUbDsIv5OlyYMDBiruZoD47Y2pk10A1oPFH5lJnmhavL4cDQSTIClJ71kmb7HIKX6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050179; c=relaxed/simple;
	bh=PzZxQXT0Yw4nSn8RaoiNfFzszvW64UfF8tdDgHR8CzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fYv/9oTZOZpCGJDqkKBL3SgQZP23O1a91HrJle0eBc9d/W/p6pBbiWPGUmod1/5CB5GXS49eAsoIgBsh2tT+iuaCQiqlDQFddzmVULoZTKD1ieTovhcByd4eFXt+GB3soERIGUG1OMjl5Zt0msHKAS54vg0J3N5kZKf5a5NjV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJbk1kl4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJbk1kl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186971F0089C;
	Sat,  3 Oct 2026 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050178;
	bh=/xj/mZPyTtqStvtYFatulhmo94Ebv5rZTDr+15eEy3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QJbk1kl4dnYHimAPk6rpT/rUcM+7tB+sFyOP0gPnkAulyXEMMuyWd9LvK7qTgHz7l
	 yG1awNNjAaa9WW8czkL8AVByJc5KEmejCvuNlbYoG+awHnofo9rT5rp7CSX9iTgA0I
	 3E4PePnDGclcfHYqvpxNiySWX1Cwr3Btaj52KHDZ8WiEuF9bKvBxJemTUc33IUkyLU
	 GF7LeKxVaANowBuMa87Z1BWIXtfJN/K7F0Y3tNS9HW7s7PBZ2239Qg/+jm4oFbXtkg
	 t63YtMmQBt1hI7xrAHrE9fm/snoll65gMd8fd6TMFSD7QyPePNO3096vXtztt+xaFO
	 9XQMu0CHc2NtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 3/3] selftests/bpf: add tests for percpu map
 flags combination
Reply-To: sashiko-reviews@lists.linux.dev
To: "Masoud Aghasi" <maghasi@disroot.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261003160213.2641506-4-maghasi@disroot.org>
References: <20261003160213.2641506-1-maghasi@disroot.org>
 <20261003160213.2641506-4-maghasi@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:17 +0000
Message-Id: <20261003175618.186971F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: test falsely passes via libbpf size validation masking buff=
er under-allocation
--

commit 1b911e2bbe76c9b313409a279ec05f4a4e42cb74
Author: Masoud Aghasi <maghasi@disroot.org>

selftests/bpf: add tests for percpu map flags combination

This commit adds tests for all possible combinations of (BPF_EXIST,
BPF_NOEXIST) and (BPF_F_ALL_CPUS, BPF_F_CPU) flags across percpu map types.
It also merges testing of percpu cgroup storage into the existing
cpu_flag_percpu_cgroup_storage test.

> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tool=
s/testing/selftests/bpf/prog_tests/percpu_alloc.c
> index 7b4a1e24363b5..f50f51c91164b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> @@ -449,6 +449,37 @@ static void test_lru_percpu_hash_cpu_flag_create(voi=
d)
>  	test_percpu_map_cpu_flag_create(BPF_MAP_TYPE_LRU_PERCPU_HASH, 0);
>  }
> =20
> +static void test_percpu_cgroup_storage_flags_combination(struct bpf_map =
*map, int nr_cpus,
> +							  struct bpf_cgroup_storage_key *key)
> +{
> +	int err;
> +	u64 flags =3D 0;
> +	size_t value_sz =3D sizeof(u32);
> +	u32 *values =3D NULL;
> +
> +	values =3D calloc(nr_cpus, value_sz);

[Severity: Medium]
The values array is only allocated 4 * nr_cpus bytes, whereas a valid percpu
map update requires 8 * nr_cpus bytes. If libbpf's size check were bypassed
(e.g., by directly using the bpf() syscall like the other tests do), would
this buffer under-allocation result in an out-of-bounds read when the kernel
attempts to copy 8 * nr_cpus bytes?

> +	if (!ASSERT_OK_PTR(values, "calloc values"))
> +		return;
> +
> +	flags =3D BPF_NOEXIST | BPF_EXIST;
> +	err =3D bpf_map__update_elem(map, key, sizeof(*key), values, value_sz, =
flags);
> +	if (!ASSERT_EQ(err, -EINVAL, "bpf_map__update_elem noexist|exist"))
> +		goto out;

[Severity: Medium]
Does this test incorrectly pass because libbpf intercepts the invalid value=
_sz,
returning -EINVAL before reaching the kernel?=20

validate_map_op() in libbpf expects value_sz to be nr_cpus * 8 because neit=
her
BPF_F_CPU nor BPF_F_ALL_CPUS is set. This seems to mask the fact that the
kernel's map_update_elem syscall is never actually exercised for this speci=
fic
flag combination.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003160213.2641=
506-1-maghasi@disroot.org?part=3D3
