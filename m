Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56FB38A2A1
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101090; cv=none; b=haiwYQ66aVIsamFYXahAsEMlV+rkANHeX/Qr4+LWOmXLlPJVLQ33gltt2bsPINbHC0fjB376THWkPbG/qJ+lxeKB7jvCoe2kIKK8tFDBGYXB9FRyOBkkOEEydDolGL+May1Hhwkc3q0m1EOualtcvUlnNI/imB3Ro1zmIKZ1d0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101090; c=relaxed/simple;
	bh=ZWatjv+uZ3iWNVGalmiW36fsVICZR2Nk2dnCfsVLMR0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kY2bMnp0bwgCFA0PX3ZcUGS6UCVf7ZBV1KNPEitm9h12iPOWKd+MvvcoGWItWmjAak+El0dJ5/db+t6FeTGRFFL3wA8cSnxIwkKzf2a1GFrMAo8jbDqgNJ7qKXaY9vYs7XKN2m61tRKETBpA2+F0hbs6Q53Mu9CsjCriNqRYaEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZUSMd+X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZUSMd+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04831C116C6;
	Thu, 22 Jan 2026 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769101090;
	bh=ZWatjv+uZ3iWNVGalmiW36fsVICZR2Nk2dnCfsVLMR0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kZUSMd+X3KssbhWp+2p6F5GXZF6MA42oc93eLIv8XNB/nlZ4H589RW5NFkmm8Cm9p
	 Xkx4nXQx95ea/RY0gsVDd4itpNNvNSdhkwlkSfbNTjdweHUQbRXZJM4Q+4+sKWCCCs
	 sGcZhJhjWVlEtBTydWkfymR4fj8xZmrIGG6Ki6FV6i54hc0G/TwWa/Kwb8PlPFpUhx
	 Qbw3gZ/JqaS2QJBfFgmvq/1cB4s574PgLtJiwgSE5Um9PTKor8NXj7yS4nGmVTJOyt
	 iFqOBgBxTPgYBOQ8wUgW5cbmEl9NMf1Duu7Q1khlrNE6+65oAJsa9wXlnu8wQ3VbyV
	 QImwbtQsFPAUQ==
Content-Type: multipart/mixed; boundary="===============5850965550779422075=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <161065237f7ad567f93be5052ac9f15673909e5089388f71fbdf8ddd5dbed49e@mail.kernel.org>
In-Reply-To: <20260122160131.2238331-8-etsal@meta.com>
References: <20260122160131.2238331-8-etsal@meta.com>
Subject: Re: [PATCH 07/13] selftests: bpf: Add ASAN support for libarena selftests
From: bot+bpf-ci@kernel.org
To: etsal@meta.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,daniel@iogearbox.net,memxor@gmail.com,puranjay@kernel.org,song@kernel.org,etsal@meta.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 22 Jan 2026 16:58:10 +0000 (UTC)

--===============5850965550779422075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
> index 2e4c0830fed9..4d7db66e75ed 100644
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
> +	is_asan = strlen(name) > (sizeof("selftest") - 1);

The ASAN detection logic compares against "selftest" (8 chars), but
the actual binary names are "test_libarena" (13 chars) and
"test_libarena_asan" (18 chars). Since strlen("test_libarena") > 8
evaluates to true, the non-ASAN binary will also be detected as
ASAN-enabled.

Should the comparison be against "test_libarena" instead of "selftest"?
Or perhaps using strstr(name, "_asan") would be more robust?

> +
> -	printf("=== %s ===\n", "libarena selftests");
> +	printf("=== %s %s===\n", "libarena selftests", is_asan ? "(asan) " : "");
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21256973563

--===============5850965550779422075==--
