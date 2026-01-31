Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F47320A33;
	Sat, 31 Jan 2026 05:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769837605; cv=none; b=B56BFvDbZGFUaaJuNVmy0jP5sSmcvpSDTnb4Tb+6kXbefnWcEoXh2exgmbAMWvnSQiLDHbZ20sp1l5FWLkcZgB6FVsr6kGEr3iqFPJAQQ8EHUj0OaGQu34pDi4xw2CDELDEg8woDLjV4ZXztxQf9DhIb7c4ikyJ73XCvSQ55HOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769837605; c=relaxed/simple;
	bh=SlhFn8ll3nbK9MeEPTU4dJC5q8r59ONtIcd+eD4o1Fk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Bga0J/14CNW36V4wEclXjQbBYajT7wj8IZS7wkg96wd3CC4d07Yx1marb9pfaUHue99VVsqQowmnB06xoyaL7BV3fFzDvonY6/yyRCZXMteub9cntJq1L7UOUJ6pdRbicwgg28trVS/iY9iHGb72OGJiBSt06n5QDcuAMCCg7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGYy9BCA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGYy9BCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13774C4CEF1;
	Sat, 31 Jan 2026 05:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769837605;
	bh=SlhFn8ll3nbK9MeEPTU4dJC5q8r59ONtIcd+eD4o1Fk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dGYy9BCARwPn0bo9RlsOa/IRUbkbdx27PjweLGiGmxRXgYAAXVFpnd9ioolxY5Ujw
	 ynPJ1/3S/KM3QuKn0NVqdyIsFZDXl9yR1OmnePVTBWMEYKi9lm7YLXTJDRSe+Y6t0l
	 w6zQ5y4r6foW9zL87U0fJIl3iwMoce9necmluuV6521rhPLbdWuHHKuJ8p18yNkBbH
	 bH+r7axreRUPdh4Ltu3K8l98TUCkaf/hOdFGeDHry4KHTfUeAyNosSZsaHij2Ksm91
	 31Bi6turwkJs1mELdKb3ukXeSky//BIgKW5pPgfS3IHwFfVzZRTmWCcPFDDHdgKS2G
	 Ltov9lkm4qxjQ==
Content-Type: multipart/mixed; boundary="===============6839947873873130110=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <82944fa5ded226a7a91da123ec384e8e353df448628c47850c6bfa9917f85960@mail.kernel.org>
In-Reply-To: <20260131050920.2574084-14-ameryhung@gmail.com>
References: <20260131050920.2574084-14-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 13/16] selftests/bpf: Update task_local_storage/recursion test
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 31 Jan 2026 05:33:25 +0000 (UTC)

--===============6839947873873130110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> index 42e822ea3..559727b05 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> @@ -117,19 +117,19 @@ static void test_recursion(void)

The comment just above this hunk at test_recursion() says:

    /* Refer to the comment in BPF_PROG(on_update) for
     * the explanation on the value 201 and 100.
     */

Should this comment be updated to reference the new expected values 200 and 1
instead of the old values 201 and 100?

>  	map_fd = bpf_map__fd(skel->maps.map_a);
>  	err = bpf_map_lookup_elem(map_fd, &task_fd, &value);
>  	ASSERT_OK(err, "lookup map_a");
> -	ASSERT_EQ(value, 201, "map_a value");
> -	ASSERT_EQ(skel->bss->nr_del_errs, 1, "bpf_task_storage_delete busy");
> +	ASSERT_EQ(value, 200, "map_a value");
> +	ASSERT_EQ(skel->bss->nr_del_errs, 0, "bpf_task_storage_delete busy");
>
>  	map_fd = bpf_map__fd(skel->maps.map_b);
>  	err = bpf_map_lookup_elem(map_fd, &task_fd, &value);
>  	ASSERT_OK(err, "lookup map_b");
> -	ASSERT_EQ(value, 100, "map_b value");
> +	ASSERT_EQ(value, 1, "map_b value");

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21539340647

AI-authorship-score: low
AI-authorship-explanation: The commit message demonstrates deep BPF subsystem expertise with detailed execution flow diagrams that suggest human authorship from a domain expert.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Stale comment in test code references old expected values, causing potential confusion but no functional impact.

--===============6839947873873130110==--
