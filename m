Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540711758B
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734847; cv=none; b=aamxpWWEX+szGv9f5QnDegkjBUcXTYQ71q4JSZXkunfOF32h1IO/if443YSb7fqzZEvVKxQJ1F/5OppiSThV9+viHReW9Ff01Q2qTb80giR3w8YfiECOb0eUF4MzvSDdij8S1vXZx2r2SlD5CqnViERWw7T3mH695F3zs3kJZEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734847; c=relaxed/simple;
	bh=FRtyP073TEtbbR1T/dvmqVq2dQy/URR5WnpWo8L+4kE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XvYRJo14AiwCt6b0LWuS68OlHA/JigsTYM6WjroGfg/E0j4pzUdZ/fQNOxuBiWmQb8vLybz0gIOfw1yfTNmyfhLat9/KNky9bjnsw7+/htrzs0YdAaVgq9Hn6kdu98JRMASf1V2sTkaZYHGwVSTomL+4tWy4z2ls52UjFLNupDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH4tkuVR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH4tkuVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0A1C116C6;
	Tue, 10 Feb 2026 14:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770734847;
	bh=FRtyP073TEtbbR1T/dvmqVq2dQy/URR5WnpWo8L+4kE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fH4tkuVRec4V+DBALCyTgEQCrOO0HAWXgJgxnYBIL5e2tCCJ5wR1V0sSBfNwHGe1M
	 225OwPdtPi0WiorD+wdCSl8Hc+ldfuuTVHBuTnlQc/BrLgyq+ipUEo/8c281f154H0
	 82U57efhgLQSEKw5vzyzBUIMQmlg5N+1HPk0QYnvwuTC7M/deeHOiWllzhGOJmyra+
	 opqD206AR6OMaC5yVmE2A6Z8/5qLui7JZrbYSdQ6ClBEiz5tQ4YqNwJ8j5lMDTXbrB
	 S8JLiUuZU7Qtx9Zt9OWsUFnYhrXVsdQdUIagE19+QJiEYnYm6ser2SOJx3A2wrMXy/
	 hrHiux6lWoHRQ==
Content-Type: multipart/mixed; boundary="===============3999898492399259330=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <43f670cbd6c288b344f2f217b102fbc325893d97977d2df6ec6aca2978ae8315@mail.kernel.org>
In-Reply-To: <699a95dfb6493cfd588524f388214db1250518f3.1770732776.git.vmalik@redhat.com>
References: <699a95dfb6493cfd588524f388214db1250518f3.1770732776.git.vmalik@redhat.com>
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: Split module_attach into subtests
From: bot+bpf-ci@kernel.org
To: vmalik@redhat.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,linux@jordanrome.com,vmalik@redhat.com,qyousef@layalina.io,houtao1@huawei.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 10 Feb 2026 14:47:26 +0000 (UTC)

--===============3999898492399259330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
> index 70fa7ae93173..8668c26c202f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c

[ ... ]

> +static void test_module_attach_prog(const char *prog_name, int sz,
> +				    const char *attach_target, int ret)
> +{
> +	struct test_module_attach *skel;
> +	struct bpf_program *prog;
> +	int err;
> +
> +	skel = test_module_attach__open();
> +	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
> +		return;
> +
> +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> +	if (!ASSERT_OK_PTR(prog, "find program"))
> +		goto cleanup;
> +	bpf_program__set_autoload(prog, true);
> +
> +	if (attach_target) {
> +		err = bpf_program__set_attach_target(prog, 0, attach_target);
> +		ASSERT_OK(err, attach_target);
> +	}
> +
> +	err = test_module_attach__load(skel);
> +	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
> +		return;

Shouldn't this be "goto cleanup" instead of "return"?  The skeleton was
successfully opened and will leak if load fails.

[ ... ]

> +static void test_module_attach_writable(void)
> +{
> +	struct test_module_attach__bss *bss;
> +	struct test_module_attach *skel;
> +	struct bpf_program *prog;
> +	int writable_val = 0;
> +	int err;
> +
> +	skel = test_module_attach__open();
> +	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
> +		return;
> +
> +	prog = bpf_object__find_program_by_name(skel->obj,
> +						"handle_raw_tp_writable_bare");
> +	if (!ASSERT_OK_PTR(prog, "find program"))
> +		goto cleanup;
> +	bpf_program__set_autoload(prog, true);
> +
> +	err = test_module_attach__load(skel);
> +	if (CHECK(err, "skel_load", "failed to load skeleton\n"))
> +		return;

Same issue here - should be "goto cleanup" to avoid leaking the skeleton.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21868797729

AI-authorship-score: low
AI-authorship-explanation: The code follows standard BPF selftest patterns with no signs of AI generation; the inconsistent error handling suggests human oversight rather than AI template output.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Skeleton memory leak in test code on error paths; affects only test cleanup, not production kernel code.

--===============3999898492399259330==--
