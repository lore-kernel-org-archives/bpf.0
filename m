Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8A32B99D
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324729; cv=none; b=uVNQv2IEOq7H1h1mqIl6qvH688DD3lHiSFNzkl/3p43KFMBjI7L+pzEbamGIr+x+EwJrNo8uU4MX6VGTAOxcN3IGtKJCXVIXb64ZaGXtVC51RTmsbUge9i+CL4TWhkIL76NPi/ELzH3JtI1zsoV12TmjGbYiRqoX/Frmxz+mMjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324729; c=relaxed/simple;
	bh=MGIWMzvp0yBqfEHS1asRKm2NRp0onorY9rg43izfoTw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KkWDCzHRv6+yHQv43wjJzOEaBURrNQ1R8K5mGQXokhLK3nG6nTRlzmtAPPr9boHB6B3ByVlZuaczbjJdMj6qqiGpd5eYqUobRJexrSLVGlStAQiBzEYI41MvXZauPYex76e95lC7Y1mrDnQuV8/gyNfrgSyjs2qczDmnvbukAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aff+PLU/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aff+PLU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD236C4CEF7;
	Thu,  5 Feb 2026 20:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770324729;
	bh=MGIWMzvp0yBqfEHS1asRKm2NRp0onorY9rg43izfoTw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=aff+PLU/P0ZEA8QCqEN4CB3NGvecZ9E8fZY28MMkSp5vbWE3l4m2KWe1dE54RZe7E
	 A4Tu6rP1N4zGUuVLo+OWJjyfjPUPgNXk1AzI/Yq5KutLNb5kVGDDdkSr8hgPjX2o3K
	 EOj+n0J/yvQbCmzWMRt7G2sT5GshZPqVAbgv5dbW+Nm16MdFhlhWHYB7rrmwxdJF9d
	 hm3hy8aJVgXlcI/mzIAbru/V/72tToOQAPW2zKVTBwi5hYomPu1mZ30eAgLSf1/Upt
	 g3/XQ3PEO7zCuBl3O/Fxwt+MYo8tuHXJYj/Jd9Pyd8YpHo0RDi5RUiOD1nRB1KFNai
	 RnftmGSLcL2Ow==
Content-Type: multipart/mixed; boundary="===============3915595939143734042=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <403adcda0f0d3b5c3fb3ec56012190ae2d9af4d6823a207582e912154b1e3a1d@mail.kernel.org>
In-Reply-To: <20260205-rhash-v1-6-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-6-30dd6d63c462@meta.com>
Subject: Re: [PATCH RFC bpf-next 06/12] selftests/bpf: Add basic tests for resizable hash map
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,ameryhung@gmail.com,memxor@gmail.com,puranjay@kernel.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  5 Feb 2026 20:52:08 +0000 (UTC)

--===============3915595939143734042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
> new file mode 100644
> index 000000000..be6e5e01b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
> @@ -0,0 +1,62 @@

[ ... ]

> +static void rhash_run(const char *prog_name)
> +{
> +	struct rhash *skel;
> +	struct bpf_program *prog;
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	int err;
> +
> +	skel = rhash__open();
> +	if (!ASSERT_OK_PTR(skel, "rhash__open"))
> +		return;
> +
> +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> +	bpf_program__set_autoload(prog, true);

Should there be a NULL check for prog here? bpf_object__find_program_by_name()
can return NULL if the program name is not found, and
bpf_program__set_autoload() will dereference prog->obj without checking.

Other selftests follow this pattern:

    prog = bpf_object__find_program_by_name(skel->obj, prog_name);
    if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
        goto cleanup;

See for example tracing_failure.c and type_cast.c.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21727734472

AI-authorship-score: low
AI-authorship-explanation: Debug print statements with cryptic identifiers (kkl 2, kkl 3) suggest human iterative debugging rather than AI generation.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Missing NULL check in test code can cause crash during test development but does not affect production kernel stability.

--===============3915595939143734042==--
