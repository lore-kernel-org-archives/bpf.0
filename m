Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F151DAEF;
	Fri, 18 Sep 2026 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755812; cv=none; b=Mpku4GGRNThn7lyez+4QVZeJc9uyYT1jeblFPmdJZH30ctgsmsVXzMwVG23V+O+OPDu1KDzV8/Lge+vkcg3T5xabHkON38v2inmFaSXTxZYzKftT554i1W5AWH2KrOzkRjnT5ric4yMBbj+xJwKoZF6yY5sJYJXQTymBILC4KoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755812; c=relaxed/simple;
	bh=d+rGlc0pbtVK4XzoV8uWfY8OXZOU+LcdoVVlgtwJD40=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GinjiB5OFetXQzO5EB6mL1XPCclfmA/TnHnVo8rCs6/DnI7lS1vP0EdyHeA2wBDwliteGQt5KfM5br1QOVdL9zCSrJTwShi9+ZgoYOmj0ykJ+txoNeYNio0HrZh5EseFAzNnQuZLMuyHcSRYJJHgjaDdKagx9zi4alnn2Q7DRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LigytgLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LigytgLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8051F0089A;
	Fri, 18 Sep 2026 18:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789755810;
	bh=A+EMHsiUq4MhvZlbqLzyCoCrUQotlt+rAXyNc18cwYU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LigytgLMtFnkhfymH5Dpn9meYqBLq72Tj1S3KkX4IbFf+FEeJeueYW+xlro2G5QEv
	 y8IODQkydHoLSe/33rxidXXYAOHLCOgavo+f78vEaB4pajPIPuvkU2Z3IMvLEZIWq+
	 F4LzAWUihN0hLf6pAdr3rLgBsN/qYLCyMlY3HIUZPmpju/w5oxU2SbajezGx101+c/
	 UlM9sFu9KbucetHWkIg43yY+HB1/uD5tw8njgPgUAQA71ExUN2Pg0Qgu2QecI7ZEzO
	 PNL5lGWG5F2yI0P2xBotQnhL/5P/DSalNXYjCufioFUfyz/MpW00MBgTQ1wrnIrH0S
	 Kl09bhYtEgoww==
Content-Type: multipart/mixed; boundary="===============4857884969883362252=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aef608763223e20b18f1aeaa837dca130fac90207177723508254a41b756ff98@mail.kernel.org>
In-Reply-To: <20260918172407.3459188-3-sh_def@163.com>
References: <20260918172407.3459188-3-sh_def@163.com>
Subject: Re: [PATCH bpf 2/3] selftests/bpf: Test querying BPF_F_PREORDER cgroup attachments
From: bot+bpf-ci@kernel.org
To: sh_def@163.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,qmo@kernel.org,martin.lau@linux.dev,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,sh_def@163.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 18:23:29 +0000 (UTC)

--===============4857884969883362252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c b/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c
> index bb60704a3ef92..343357d9c460e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_opts.c

[ ... ]

> @@ -357,6 +380,34 @@ static void test_preorder_prog_attach_detach(int atype)
>
>  	assert_mprog_count(cg, atype, 4);
>
> +	optq.prog_ids = prog_ids;
> +	optq.prog_attach_flags = prog_attach_flags;
> +	optq.count = 10;
> +	err = bpf_prog_query_opts(cg, atype, &optq);
> +	if (!ASSERT_OK(err, "prog_query"))
> +		goto cleanup4;
> +
> +	ASSERT_EQ(optq.count, 4, "count");
> +	/* Direct query reports attached programs in cgroup list order.
> +	 * Lookup by prog_id to verify per-program flags independently of slot index.
> +	 */
> +	err = find_prog_attach_flags(&optq, id1, &flags);
> +	if (ASSERT_OK(err, "find id1"))
> +		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI, "flags id1");
> +
> +	err = find_prog_attach_flags(&optq, id2, &flags);
> +	if (ASSERT_OK(err, "find id2"))
> +		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI | BPF_F_PREORDER, "flags id2");
> +
> +	err = find_prog_attach_flags(&optq, id3, &flags);
> +	if (ASSERT_OK(err, "find id3"))
> +		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI | BPF_F_PREORDER, "flags id3");
> +
> +	err = find_prog_attach_flags(&optq, id4, &flags);
> +	if (ASSERT_OK(err, "find id4"))
> +		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI, "flags id4");
> +
> +cleanup4:
>  	err = bpf_prog_detach_opts(fd4, cg, atype, &optd);

[ ... ]

> @@ -460,6 +520,34 @@ static void test_preorder_link_attach_detach(int atype)
>
>  	assert_mprog_count(cg, atype, 4);
>
> +	optq.prog_ids = prog_ids;
> +	optq.prog_attach_flags = prog_attach_flags;
> +	optq.count = 10;
> +	err = bpf_prog_query_opts(cg, atype, &optq);
> +	if (!ASSERT_OK(err, "prog_query"))
> +		goto cleanup4;
> +
> +	ASSERT_EQ(optq.count, 4, "count");
> +	/* Direct query reports attached programs in cgroup list order.
> +	 * Lookup by prog_id to verify per-program flags independently of slot index.
> +	 */
> +	err = find_prog_attach_flags(&optq, id1, &flags);
> +	if (ASSERT_OK(err, "find id1"))
> +		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI, "flags id1");
> +
> +	err = find_prog_attach_flags(&optq, id2, &flags);
> +	if (ASSERT_OK(err, "find id2"))
> +		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI | BPF_F_PREORDER, "flags id2");
> +
> +	err = find_prog_attach_flags(&optq, id3, &flags);
> +	if (ASSERT_OK(err, "find id3"))
> +		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI | BPF_F_PREORDER, "flags id3");
> +
> +	err = find_prog_attach_flags(&optq, id4, &flags);
> +	if (ASSERT_OK(err, "find id4"))
> +		ASSERT_EQ(flags, BPF_F_ALLOW_MULTI, "flags id4");
> +
> +cleanup4:
>  	bpf_link__destroy(link4);

This isn't a bug, but since the patch already introduces a helper
(find_prog_attach_flags), would it be worth folding this
query-and-check block into one too, so the two preorder subtests
share it instead of carrying identical copies?

The pattern appears twice: first in test_preorder_prog_attach_detach()
and again verbatim in test_preorder_link_attach_detach() - same query
setup, same comment, same four id/flag expectations, together with
duplicated locals (prog_ids[10], prog_attach_flags[10], flags, optq).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35376083935
--===============4857884969883362252==--
