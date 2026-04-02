Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7343845CA
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116613; cv=none; b=iEV79DmPR7BcK/Fs14tABO7CHrw99UgHTh3Wc3FSx6VHXxycwsCeyAZGrbS628cylpZjgNXgQFaIt1KlVeEaQp31zEcGe5q+ZMoltU58UGrcOCzJtdUhnJ7bXg8srOvsMnOzFZrEh6epnidonIhJEBW1oS2Vn+590DtrU2Y3C2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116613; c=relaxed/simple;
	bh=gHk3NrA8LeBkCPVySL9klQu00sYKBrHQxKIbtqpY78g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=K4UxYjvow8muFodZCAsSoDwpjfXZTYBnrgQkxCR+bj1V8UlOiOP62MeytqxKfKkhZAnjYkwAlbrDGOh+BKzSAF+1XxczCBF53JEN7ZNixB33xU8CquFwdXzf65ZZU/XLaKFm9ViZdJQqYRLLNw49GQULTS07/iQbDdNlGpFq1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3bvHUhA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3bvHUhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B13C19423;
	Thu,  2 Apr 2026 07:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775116612;
	bh=gHk3NrA8LeBkCPVySL9klQu00sYKBrHQxKIbtqpY78g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=J3bvHUhAPa85Fy2ZKZ/PDTzJTsWmQO/21ZULHlYekti5wGLTwxPG5o7lP8rbKTOWs
	 lBcVpaImVfkzyLF6uTRSmYfMIBwUJS6x6ramqwOdu1uPKOHgocpmzKQoQxKmbW1vdx
	 PIlblxvWTe3bgjyqzL/jhHyUQIGSpNxCuGFN9WReF2wRwdnpSdnFw2kGdJNxwFF0Ki
	 JEA52UiQG3uaw5w5BVDbt0yV/T4r+oiyv1EWanO0gDHI3XmXc7AydQ6CZARTqUbjhI
	 /WKyZuPzw9BRsAGN1UKSGyHheRIx8RCS0USJN2UhaZ9auoTU2qCk5xb9Buc4D14Eun
	 +Odoo8zHsf7IQ==
Content-Type: multipart/mixed; boundary="===============9104523390547012111=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <990f6097eb8184cc1895c622c8fa70d7aef9899d77b893ce4241825ba4fd5116@mail.kernel.org>
In-Reply-To: <20260402061744.10885-7-alexei.starovoitov@gmail.com>
References: <20260402061744.10885-7-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/6] bpf: Add helper and kfunc stack access size resolution
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,memxor@gmail.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  2 Apr 2026 07:56:52 +0000 (UTC)

--===============9104523390547012111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2a5d862a82db..bca8129fd1ed 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +	/* ptr + __sz/__szk pair: size is in the next register */
> +	if (arg + 1 < nargs &&
> +	    (btf_param_match_suffix(btf, &args[arg + 1], "__sz") ||
> +	     btf_param_match_suffix(btf, &args[arg + 1], "__szk"))) {
> +		int size_reg = BPF_REG_1 + arg + 1;
> +
> +		if (aux->const_reg_mask & BIT(size_reg)) {
> +			size = (s64)aux->const_reg_vals[size_reg];
> +			goto out;
> +		}
> +		return MAX_BPF_STACK;
> +	}

Should this check is_kfunc_arg_uninit() before the return MAX_BPF_STACK
fallback?  When the size register is a known constant, the goto out path
handles uninit correctly by returning -size.  But when the size is not
constant, this return bypasses the out: label's uninit check entirely.

In bpf_helper_stack_access_bytes(), the equivalent path handles this:

    if (at & MEM_UNINIT)
        return 0;
    return MAX_BPF_STACK;

If a kfunc with a __uninit pointer and a variable __sz companion is
added in the future, this would return MAX_BPF_STACK (indicating a
512-byte read) for what is actually a write-only buffer.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23887359808
--===============9104523390547012111==--
