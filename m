Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB536AB62;
	Wed, 28 Jan 2026 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613997; cv=none; b=b0ZqQFOCF2wxlZxzOL7fmnWgbAAYUKEOQELZmNy2vu6rezWFnX/zaVi/m5nDlRUYaH6hC0Cq7wLFSwOVrmGa+VUEwN5HZd+a7GqZQBxdShKuIB/pWza4yu2OgMdUjFxhsmmThN/xCuRq/t/BSZ2N1w92KbzS+xy6VsMZ573yp7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613997; c=relaxed/simple;
	bh=+x2W09IBIk3INSEl7OwPB86JYpVGAaj9EY3AYr7fB1I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZIT1HiA4EggRqiib08b1SKRITNDBBHTbIwDOhq9i47OIT3UywS8f1DEsv0wxRRqORE+vWcnzLX/G9VR0/OnPw0UoFtGhmxtua5ya3UD1aSKCrmEok9nfStI9m7oUCfdu03iRP1DkKzO4j9hAmdAS/oymg8lBcRYwXaAT5ThEnAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8I+aIIS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8I+aIIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A0AC4CEF1;
	Wed, 28 Jan 2026 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769613997;
	bh=+x2W09IBIk3INSEl7OwPB86JYpVGAaj9EY3AYr7fB1I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=e8I+aIISjFUOTCo8UMRVcezinf0WvfCFN3QhWeGtJKpm6q5u4f2nXrJkOUr3F+MBl
	 dCHVC2Ml8fOlSV+tX4TzIS0MPvuN46tLkSfgMCmgMEyQHdTxvemzRG6K6l3NsR0/8d
	 mYJOhpVDe1CY+VzlX/yRZC+TWmeSFwzbypgMqLp1InAE2A4uQQN6WRF78fVXZhtRjJ
	 CS/rFpxgBdS3oSlN55yez6S7OTr5K0MI+tUXhWYGGDG3pLyt9OHJmtVT526VVkxeOY
	 VKbBRWTcYcu3FGezFYGsCsMpJAPjDMDkNxumHyE36JZLuiFuPzblciF+RceZxorr7B
	 rQrz5AAuoxnTg==
Content-Type: multipart/mixed; boundary="===============5864326751367574456=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e64c4137e7f262e6fdab272e8ee44c8a129a36eb6d0186914375d6ba20d88474@mail.kernel.org>
In-Reply-To: <20260128150112.8873-2-leon.hwang@linux.dev>
References: <20260128150112.8873-2-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add bpf_arch_supports_fsession()
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,puranjay@kernel.org,xukuohai@huaweicloud.com,catalin.marinas@arm.com,will@kernel.org,shuah@kernel.org,menglong8.dong@gmail.com,leon.hwang@linux.dev,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 28 Jan 2026 15:26:36 +0000 (UTC)

--===============5864326751367574456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 5a075e06cf..070ba80e39 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -4112,3 +4112,8 @@ bool bpf_jit_supports_timed_may_goto(void)
>  {
>  	return true;
>  }
> +
> +bool bpf_jit_supports_fsession(void)
       ^^^^^^^^^^^^^^^^^^^^^^^^^^
This is the actual function name in the code.

> +{
> +	return true;
> +}

[ ... ]

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index e0b8a8a5aa..3b1eb632bf 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3142,6 +3142,11 @@ bool __weak bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
>  	return false;
>  }
> +
> +bool __weak bpf_jit_supports_fsession(void)
> +{
> +	return false;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21443677441

AI-authorship-score: low
AI-authorship-explanation: The naming inconsistency between commit message and code suggests a human renaming the function during development without updating the commit message, not AI-generated content.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Documentation-only issue - commit message function name does not match actual code, which may confuse future code archaeology but has no runtime impact.

--===============5864326751367574456==--
