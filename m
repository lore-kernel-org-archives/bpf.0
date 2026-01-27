Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5381233149
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539140; cv=none; b=iBGowIQujM1Nij9RMMKrXcKWuOufJ31Pgmx8aWBGZgdxyR8ga4h2xaWxbsVTP2mSsfM4WARwGL17XHmxFzcLyHleMyLwXy5h8K5ACY78ZXO6kY7OKHvieKXjS15Jl73pfhHqQxIS0Aw0Yghl7iQ4nSKZNL3W2EpIAPx5t0R59eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539140; c=relaxed/simple;
	bh=XA3Ark9IBHfExEM3ekIVH96LhPq6f0q+RgdZsoB3Xag=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Jp3px5pkUVcwMb4VVCP/3kCh629qgLzPTK/KcYGP5H0O6QM6M5kziA/TSR+oU8ygEYgHiXwyRdenzLJvgBKRUgM//Td9PxfyE1TnkNzdDjf6KtXZK2nZ/Oi/ClVqqy0ztNvjBKergYj4mJ/VJ+H36D+AALWNpZQ9BGHoLdKeQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTrz/hEh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTrz/hEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035E6C116C6;
	Tue, 27 Jan 2026 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769539140;
	bh=XA3Ark9IBHfExEM3ekIVH96LhPq6f0q+RgdZsoB3Xag=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QTrz/hEhXWHR0ID03Qypcs3XPizM02ePMKtPlTwL0mfhMH3fVvhkugtdaCQAssBEr
	 bP4U+YrKv/Six4Y1jTOiwfQkQLJU/vrLVWe1GdRvMnJYIxLg0GmU1ZWQxJwyh1K7t9
	 MREiCegf8wzi6BuVbYy/r3HZipzQcXspQPbr7++e+9jIkKp1VxzJj+2yn/rMZpArVe
	 qzBeK3nZXuo/OFp4EUgf1IdzUDWuVMD44zE56cL73UX/bdCVSqej+E6/qmM6mBO51a
	 3BofSBIqCER7xRKNW+XGp43O6rE+ehMQi4P7NugJUw4fkN0XqlbiAvSKe52G77wxUF
	 /8Pg9pegbcNGA==
Content-Type: multipart/mixed; boundary="===============6462976393826007233=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c754c6bb656d78e6ab566d3308a9a261cab980c622adab5213127e8d729efb03@mail.kernel.org>
In-Reply-To: <20260127181610.86376-8-emil@etsalapatis.com>
References: <20260127181610.86376-8-emil@etsalapatis.com>
Subject: Re: [PATCH v2 07/13] selftests: bpf: Add ASAN support for libarena selftests
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,etsal@meta.com,ihor.solodrai@linux.dev,martin.lau@kernel.org,memxor@gmail.com,puranjay@kernel.org,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 27 Jan 2026 18:38:59 +0000 (UTC)

--===============6462976393826007233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
> index 5b8d8b94323e..f63324a1cdde 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c

[ ... ]

> @@ -211,8 +269,17 @@ static void
>  banner(const char *progpath)
>  {
>  	char *name = basename(progpath);
> +	bool is_asan;
> +
> +	/*
> +	 * Check if our BPF programs are ASAN-capable by inspecting the prog name.
> +	 * Command line arguments are guaranteed to be NULL-terminated, use strlen.
> +	 * Calculate the hardcoded name's length at compile time.
> +	 */
> +	printf("%s\n", name);
> +	is_asan = strstr(name, "_asan");

This isn't a bug, but the comment mentions strlen and compile-time length
calculation, while the actual code uses strstr(). Should the comment be
updated to match the implementation?

> +
> +	printf("=== %s %s===\n", "libarena selftests", is_asan ? "(asan) " : "");
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21409286496

AI-authorship-score: low
AI-authorship-explanation: Code follows standard kernel patterns with a comment/code mismatch typical of iterative human development rather than AI generation.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor documentation issue where comment mentions strlen and compile-time calculation but code uses strstr; does not affect functionality.

--===============6462976393826007233==--
