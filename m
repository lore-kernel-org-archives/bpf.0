Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954FE51AEE0
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752819; cv=none; b=rmxU1f1roVi+LSbJ74X1PKhlKq0z7+I5Qn8ifOWkWG4pAr9jZLVZFXwiVMmQ/FO+RlyEVife8bRg6uoS4iF0Nsw7ArTEvfT+Ah/YJzS37Lo9+hdDJn5CJ5nkjC6j9pwDz7QmWUuFRYR54cnevylTTDwTivUAxZuajIKT1FUr2Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752819; c=relaxed/simple;
	bh=g2pdd91pqDn7MbrCdyg66jvZMSj4MJ1X/y+mJrwBhJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GnXtEQ0LuOtCEHuHop88uHI9vpau4TNBsQ+4cEtcodCLB1GRgiAxUQZtMCUGydZHiqRhNRwVej9N9CTn0g75lQt2n+0zVuR26u0HP6tPznlVO/xtxLGuxOF2oOTlInI/Y+p7sNfMJ1mi+A+yh/JyyEuZYnXB+KTYfCj1ZJb1yMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoL95bqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoL95bqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC791F00898;
	Fri, 18 Sep 2026 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752815;
	bh=wgfN9r0Krdm7QK7NBPTiuJiGZEhHJ9sKexWtLI3S7XQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WoL95bqMwhWEJhzhqaccFVt1fnYdAq/o237MCQ2foiflz3JR6FV/n1kE75c6YbhNZ
	 3NkB21GapQSNOuBzQy1GdmPYAeO8kIVpTktE89wCcuPONuaTBcewf3vmlnYVWNrCVZ
	 qmjnrWK4C6wX8kWpfg9w9XlFb7zjHjJAPLLlNYZQTDyT+Hn3QuM5aI75bfo8yxV+l7
	 P4jMv3CGJGrcmKaK3THcK5KByO9UuDiZ9ix3a6cSQoLQfmmBSmIchE6Aye6bbjYCoy
	 tO767Svc60q/uqqyD+cCrjWkAqkpXZYbXW+oo5GxmobPJKeHsixZZC4lo0XHHVqBCo
	 nwY7QhnMNIRGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/3] selftests/bpf: Test querying BPF_F_PREORDER
 cgroup attachments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918172407.3459188-3-sh_def@163.com>
References: <20260918172407.3459188-1-sh_def@163.com>
 <20260918172407.3459188-3-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:33:34 +0000
Message-Id: <20260918173335.1AC791F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation in selftests
--

commit 3e88ee3f08c0b0faed466f91d62f7c6939ba9fa3
Author: Hui Su <sh_def@163.com>

selftests/bpf: Test querying BPF_F_PREORDER cgroup attachments

Extend cgroup_mprog_opts selftests to verify that BPF_PROG_QUERY reports
BPF_F_PREORDER in prog_attach_flags for both direct program and link
attachments.

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c b=
/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c
> index bb60704a3ef92..343357d9c460e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c

[ ... ]

> @@ -357,6 +380,34 @@ static void test_preorder_prog_attach_detach(int aty=
pe)
> =20
>  	assert_mprog_count(cg, atype, 4);
> =20
> +	optq.prog_ids =3D prog_ids;
> +	optq.prog_attach_flags =3D prog_attach_flags;
> +	optq.count =3D 10;
> +	err =3D bpf_prog_query_opts(cg, atype, &optq);
> +	if (!ASSERT_OK(err, "prog_query"))
> +		goto cleanup4;
> +
> +	ASSERT_EQ(optq.count, 4, "count");
> +	/* Direct query reports attached programs in cgroup list order.
> +	 * Lookup by prog_id to verify per-program flags independently of slot =
index.
> +	 */

[Severity: Low]
In tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c within
test_preorder_prog_attach_detach(), does this multi-line comment violate the
BPF subsystem style guide? The guidelines require the opening /* to be on i=
ts
own line.

> +	err =3D find_prog_attach_flags(&optq, id1, &flags);
> +	if (ASSERT_OK(err, "find id1"))
> +		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI, "flags id1");

[ ... ]

> @@ -460,6 +520,34 @@ static void test_preorder_link_attach_detach(int aty=
pe)
> =20
>  	assert_mprog_count(cg, atype, 4);
> =20
> +	optq.prog_ids =3D prog_ids;
> +	optq.prog_attach_flags =3D prog_attach_flags;
> +	optq.count =3D 10;
> +	err =3D bpf_prog_query_opts(cg, atype, &optq);
> +	if (!ASSERT_OK(err, "prog_query"))
> +		goto cleanup4;
> +
> +	ASSERT_EQ(optq.count, 4, "count");
> +	/* Direct query reports attached programs in cgroup list order.
> +	 * Lookup by prog_id to verify per-program flags independently of slot =
index.
> +	 */

[Severity: Low]
Could this comment block in test_preorder_link_attach_detach() be updated to
match the required BPF multi-line comment format? The opening /* should be
placed on a separate line.

> +	err =3D find_prog_attach_flags(&optq, id1, &flags);
> +	if (ASSERT_OK(err, "find id1"))
> +		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI, "flags id1");

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918172407.3459=
188-1-sh_def@163.com?part=3D2
