Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DE039E17E;
	Tue,  3 Feb 2026 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113634; cv=none; b=jYLJdmL+QrKH7NVtEL1lSJRGj1iyj5q4GVrRs2RiLeHyxSRGPTBEK+DbzRRHGyevCho5QgImhWaywUz4JnzvVQ7oSVyxHjVzECeLhi8xWgm+A0KIZ6ugiWJW9Ri69dWbNy2yLiPZmdvmkF05BhXpZxyIcCHr9kPRsR3/oPNMjUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113634; c=relaxed/simple;
	bh=62+dKi/sGs0cWaY6sK1LDp3kcrF+2c/L50jRccikQd4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QUkwjmhC4VEp6hoaJyazOEX4jNPpYl++DPOpwCjCA5r20IutUCDzEMIQXBIZrq7qDw6nMJiLpvC+V+n3VERYQBso/gz+7h/lOaXUz5PuLBgjg9Ccz/CXdPVZv/zU87vnH+e+Ghz53B/eI9O56nEtChnrqPkHQ+Rxd74lVPFfdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpGozJRa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpGozJRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C23C19422;
	Tue,  3 Feb 2026 10:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770113634;
	bh=62+dKi/sGs0cWaY6sK1LDp3kcrF+2c/L50jRccikQd4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=JpGozJRa66xyWaJpviqL5l56CTE1Jj6aanmgF18rfosyJvN+oNTiRId2PXSufUPxT
	 ufaQ0cTi2m3Va/YvJGl1ISsUjhsaZK0t60V31FCG1qvNiGWgyXQM2ccMaMX6pFl3BQ
	 tEz66PrngEgem+EKoh7vGNik84AtWW9FlzA56vYycaOgmvsYSwC5ZKpdAn6DsyTALl
	 rM9IAGEuwnEJIFn2OWyg8duPtn94P4d6MRx8G8qeJXczsmFxCpazaX18ZO3RamfQO7
	 dV2pv5GL3UPmTnvapZKSdrlRo41I6xJUG9CdYCTK2q/oStCJxW0eCr2zIDe55GwPlo
	 dDVhnjmUHvZ+w==
Content-Type: multipart/mixed; boundary="===============6018976010174444517=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9df0acf7860b7e4a90b3e93e2d6924e9bad35fe307bef0bf9b50f8afb5cccacc@mail.kernel.org>
In-Reply-To: <20260203093819.2105105-6-jolsa@kernel.org>
References: <20260203093819.2105105-6-jolsa@kernel.org>
Subject: Re: [RFC bpf-next 05/12] bpf: Add multi tracing attach types
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Feb 2026 10:13:53 +0000 (UTC)

--===============6018976010174444517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6b62b6d57..fb52ba2f7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -25069,7 +25074,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>  		return 0;
>  	} else if (prog->expected_attach_type == BPF_TRACE_ITER) {
>  		return bpf_iter_prog_supported(prog);
> -	}
> +	} else if (is_tracing_multi(prog->expected_attach_type))
> +		return prog->type == BPF_PROG_TYPE_TRACING ? 0 : -EINVAL;

This isn't a bug, but should this branch have braces for consistency with the
preceding branches in the same if/else chain? The BPF_TRACE_RAW_TP and
BPF_TRACE_ITER branches both use braces.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21625440628

AI-authorship-score: low
AI-authorship-explanation: The commit message contains natural colloquial language and personal attribution typical of human kernel developers, and the code follows established BPF patterns with typical human oversights in style consistency.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor coding style inconsistency with missing braces in an else-if branch that does not affect functionality.

--===============6018976010174444517==--
