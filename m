Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35253366DCD;
	Tue, 10 Feb 2026 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732732; cv=none; b=EBO90x950p4OXS1mBEDNRp8wEhLDWZc+pyY3PtQorqJ6VmpAtG+SUX692n8LhbUFgK+OIXsBZR1UGmagV3hiBYRp1tqJm+P+h/NLP3kyS3fEzqQKo7WstLYJSnjFCWJQJ+IkCgYXKkwriyoxAGQxou/r+uuonnmiHlG1/dU0VVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732732; c=relaxed/simple;
	bh=g6fcwoD6r7DkFxDYlR2jqmzuzQXDsPDISdawLX/9A6E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NlGKEuAdXc6k1gQe7vQcoO37fGFMqF6r75zDa+6OJYUtYv0O0JklqLXbNEsePXyaNODDaL92rEFFsKy0wWYlFB/Rp54ybAEUmk5O49fIEMFHVRRb8d02Y4LCPv2yO9q22Na+88UAjkQUglXMqRNNor733bqBjIk2whWqgBMGmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPPZqd8L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPPZqd8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E94C16AAE;
	Tue, 10 Feb 2026 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770732731;
	bh=g6fcwoD6r7DkFxDYlR2jqmzuzQXDsPDISdawLX/9A6E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dPPZqd8L8gJhVi3cNOflmruPf2nKA9FuDADRuywuwq6SwrNJA/cFgi8Tls1v6WlTg
	 nWUT9GSDEqG1zvWnfQ6wFhrXx7f24c/WHXD3QIlVbtde+2JC6IFveZkVqdhZRrj7bG
	 54P+5/LglaG/k7qyRJTRADTysNgRBuJ+AAygSBl8u7py7i7oMgwcK7LMjTXW3Q7yAY
	 YJZn+6mLyoKQJWNd7/DHKyPpBEYY68LylezGjXB37PAhSaLla/+n0RevSVhq3z/62v
	 bMBqYsGbzyQ6GysZcBW3OnGCIcpwu9wI6FGLgio1kA0g5/GAfz+UyJBNzqsg6CD9ml
	 FpXkONNms+85w==
Content-Type: multipart/mixed; boundary="===============4456647132742211868=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aab191dcc7036e9ee105171cb4414df51c2ac0593daffff06c00e484b89c48b0@mail.kernel.org>
In-Reply-To: <20260210133649.524292-6-jolsa@kernel.org>
References: <20260210133649.524292-6-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 5/5] selftests/bpf: Add usdt trigger bench
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,songliubraving@fb.com,yhs@fb.com,john.fastabend@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 10 Feb 2026 14:12:11 +0000 (UTC)

--===============4456647132742211868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
> index 4ea0422d1042..f631706bbdc9 100644

[ ... ]

> @@ -180,3 +181,10 @@ int bench_trigger_rawtp(void *ctx)
>  	handle(ctx);
>  	return 0;
>  }
> +
> +SEC("usdt")
> +int bench_trigger_usdt(void *ctx)

Should this use SEC("?usdt") instead of SEC("usdt")?

All other programs in this file use the '?' prefix to disable autoload by
default:

    SEC("?uprobe")
    SEC("?uprobe.multi")
    SEC("?raw_tp")
    SEC("?kprobe/bpf_get_numa_node_id")
    ...

Without the '?' prefix, bench_trigger_usdt will be auto-loaded whenever the
trigger_bench skeleton is loaded by any benchmark using setup_ctx()/load_ctx(),
adding unnecessary overhead to unrelated benchmarks.

> +{
> +	inc_counter();
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21867569087

AI-authorship-score: low
AI-authorship-explanation: The commit exhibits natural kernel developer style with real benchmark data, informal comments, and follows existing codebase patterns with minor inconsistencies typical of human development.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor pattern inconsistency in test code where SEC("usdt") should use SEC("?usdt") to match the established convention for disabling autoload by default.

--===============4456647132742211868==--
