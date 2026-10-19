Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C643603DB
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392664; cv=none; b=JtYEB3oerpMU28siO02FZzP+7Sf7JYq7bks/m/10IfvWx6+fZ+d+8WubMz0oshxC5WPDWM1CZ4epQ6CrxMVQFzU1YXl0RX/vkCAPvI7X5opgQuX0CGLzFrUyetZ5cBtOQJODtNQsORFEnda8cbbxNiecSHDumP5sPmNqAEFJmFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392664; c=relaxed/simple;
	bh=5rhnnLtkBI7kyDwZ22M8wIYUIO+In3x5vIV5AN91BxU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=P/WfathPnrXXhq+pM3qiohs5JzT6UqywKdJ8h+m96UIF8c4FILnxsmIvXqYnboqptwB0NsgQBMW9wgHWeLZJ9woJeWTNnK/7WcNcbVyd8S5NMBm1VIOMQO86L5Fs5WHVTKyCy/OhvaKn2RsgcJ50wFC7guOL50HqKB8ZpzMbQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK8yiVz2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK8yiVz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573FB1F000C4;
	Mon, 19 Oct 2026 06:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392662;
	bh=UjzT6/G5Js5JKbN1AJPuPZCzSlx44rEhWlt25v9LylM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eK8yiVz22bc3c7SLLyS4ovWUifFP80iUT34W24jfl3flLu3r+DUOoSGOdHM3r8cfQ
	 dElja2Br5dHs3rZnAsGIlEVghloNop1DvS7fL3+ybPjzCLAygrc8asQNOyp3PfeAkU
	 GtWQUqWXIE6RNsXw+0QPmnuv9Yd+m4bWwuTS1Fs2nc5xdORyHIKhIqfznFngdEaL9a
	 PqfIyxpMltt5g2QMwtIUvmr+10H13A9rgoMoh07ljf1KWceVg4ve0id0yocgTZ6+vh
	 m5eZOxuKwmaeL8QPwJpG7EoX88bNvZ/vF1VBlgXPCLLqrOBmMkMQ/0NXqzXiH2Zwfq
	 fNHlwptS4YfpA==
Message-ID: <sashiko-outbox-176703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 bpf-next 5/5] selftests/bpf: add tests for the
 numab kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, david@kernel.org, gourry@gourry.net, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, yu.c.chen@intel.com, zhao1.liu@intel.com, tim.c.chen@linux.intel.com, lizhe.67@bytedance.com
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261019064157.29885-6-laoar.shao@gmail.com>
References: <20261019064157.29885-1-laoar.shao@gmail.com>
 <20261019064157.29885-6-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:51:00 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: missing kfunc BTF skip check in test_bpf_numab()
--

commit 07e4c14213f29b11a7ce19b88e46e524dc48e78d
Author: Yafang Shao <laoar.shao@gmail.com>

selftests/bpf: add tests for the numab kfuncs

This commit adds BPF selftests exercising the bpf_numab_set_mode() and
bpf_numab_get_mode() kfuncs across set/get roundtrips, mode validation,
invalid cgroup IDs, and cgroup hierarchy combinations.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_numab.c b/tools/t=
esting/selftests/bpf/prog_tests/bpf_numab.c
> new file mode 100644
> index 0000000000000..7ce4b8153c42f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_numab.c
> @@ -0,0 +1,227 @@
[ ... ]
> +static void test_set_get(void)
> +{
> +	struct bpf_numab *skel;
> +	int cgroup_fd;
> +	u64 cgid;
> +
> +	cgroup_fd =3D test__join_cgroup(CGROUP_PATH);
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> +		return;
> +
> +	skel =3D bpf_numab__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		goto cleanup;
[ ... ]
> +void test_bpf_numab(void)
> +{
> +	if (test__start_subtest("set_get"))
> +		test_set_get();
> +	if (test__start_subtest("invalid_mode"))
> +		test_invalid_mode();
> +	if (test__start_subtest("bad_cgid"))
> +		test_bad_cgid();
> +	if (test__start_subtest("hierarchy"))
> +		test_hierarchy();
> +}

[Severity: Medium]
What happens when test_bpf_numab() runs on a kernel built without
CONFIG_BPF_NUMAB=3Dy (for example when CONFIG_NUMA_BALANCING is disabled or=
 on
non-x86_64 selftest configs where CONFIG_NUMA_BALANCING is not enabled)?

Because tools/testing/selftests/bpf/progs/bpf_numab.c declares
bpf_numab_set_mode and bpf_numab_get_mode as strong __ksym externs:

    extern int bpf_numab_set_mode(u64 cgid, s64 mode) __ksym;
    extern s64 bpf_numab_get_mode(u64 cgid) __ksym;

calling test_bpf_numab() -> test_set_get() -> bpf_numab__open_and_load()
(as well as test_invalid_mode(), test_bad_cgid(), and test_hierarchy())
fails in bpf_object__resolve_ksym_func_btf_id() with -ESRCH and trips
ASSERT_OK_PTR(skel, "open_and_load").

Should test_bpf_numab() check vmlinux BTF for bpf_numab_set_mode and
bpf_numab_get_mode via btf__find_by_name_kind(..., BTF_KIND_FUNC) and call
test__skip() when the kfuncs are not present?

> diff --git a/tools/testing/selftests/bpf/progs/bpf_numab.c b/tools/testin=
g/selftests/bpf/progs/bpf_numab.c
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019064157.2988=
5-1-laoar.shao@gmail.com?part=3D5
