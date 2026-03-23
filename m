Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B272AEE4
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255838; cv=none; b=UPGkxy75JpVG/sSXht6OcAJv5ZoVt438+Y4Vno9T85YlCi1VqLmyG6ZBLf7kQXKgWdZ1slya9WF4QUehmZ1Tnsl12ac/DBOq+QZPeufHfRm0ANBKuPC4K4EiiklnebICWd/LTAvp4b+CGsbiqxC/Z7kk8wfbheQdntVshkNWric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255838; c=relaxed/simple;
	bh=Pg0B0Jd5pF+9JY6m3Bm7ErLWKcQCKrk2QS0W4UTp5Lg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dAB0okHeu7+9xec1c+j8cHUaYVwUYhxjWlqfp0ky5hoPwfkR0zoNmnJvhZ+oKz4sW0ffxnsrC+lM03ZM9g/2qPpOVewh31K/qbJumsfwsxoFoWLhNg8l4ZpbwcGEQhqjj3NGr+6MjLQmygrJkz15kLRDXhMRR2dbuy2DRrYGmm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W92AJgLU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W92AJgLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A48C4CEF7;
	Mon, 23 Mar 2026 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774255838;
	bh=Pg0B0Jd5pF+9JY6m3Bm7ErLWKcQCKrk2QS0W4UTp5Lg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=W92AJgLUmpUm/z9ZHaa4uMYC0zi10aulIht/VKl/8HNkkued+NeeANDcV+rZBYWnV
	 eI3TkCaLv868t8n9yxQA605FGPMQlcHt1pJEmw+kXtEI4AtgbCR0ia5T81o6jbwXfA
	 fbVLRk7yBi7R/EOEr3MzeDeXztvpcwxdcFpmgmX5Z8d214uwEk2Z9RgLNUfn5TfUr7
	 KLSICXESO4IfeRcsU5XoL67Waa4bYFKmhqiLSbLVCAGNwqibTj0lssg+ljv5dEe6rl
	 DvWG4HtlajLq1tBr2FW1MP857ezKJPJl7vUQZ9AnD/wi2BVndCiQ9uYwTOZCSqGs6P
	 MI/adRy+MXyrg==
Content-Type: multipart/mixed; boundary="===============0583515415362923393=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6aaf314ebc289e6f2f598132aceb02ffa486992f3e846b260df28076c8da5afe@mail.kernel.org>
In-Reply-To: <20260323081748.106603-2-tangyazhou@zju.edu.cn>
References: <20260323081748.106603-2-tangyazhou@zju.edu.cn>
Subject: Re: [PATCH bpf v2 1/3] bpf: Reject bpf-to-bpf call with large offset in interpreter
From: bot+bpf-ci@kernel.org
To: tangyazhou@zju.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ziye@zju.edu.cn,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 23 Mar 2026 08:50:38 +0000 (UTC)

--===============0583515415362923393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 7b675a451ec8..cf3c8b7cefe6 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2386,13 +2386,16 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
>  #undef PROG_NAME_LIST
>
>  #ifdef CONFIG_BPF_SYSCALL
> -void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
> +int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>  {
> -	stack_depth = max_t(u32, stack_depth, 1);
> +	if (insn->imm < S16_MIN || insn->imm > S16_MAX)
> +		return -EINVAL;

This fixes a bug introduced by commit 1ea47e01ad6e ("bpf: add support
for bpf_call to interpreter"), which added bpf_patch_call_args() with
the truncating cast. Should this commit include a Fixes: tag?

Suggested:
Fixes: 1ea47e01ad6e ("bpf: add support for bpf_call to interpreter")

> [ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23427947087
--===============0583515415362923393==--
