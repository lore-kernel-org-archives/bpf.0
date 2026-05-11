Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034AA2C3252
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 06:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778480390; cv=none; b=eUwBqT0e47I7YKalW79dMPs7FJqEssC68etyb4RdWC8jzxaEUg15qcSLEdmBMboB6fpzvtT7RS+d0QTkWrgLvZcEJX4+VzGW+MAinbge8Kdn/7S06IrBIcfwUhbQwOQabRIWeRa7hTry1H4uTp/zL/sWR+j2SrvA7EeO2nAmzBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778480390; c=relaxed/simple;
	bh=tyUElYqrF4iGdnlg4H9Rm4Hpn80YPj202MfgcvQSBEk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OomZnt5aqXIA5G6BC1adW+cugclKvR2h1Qj4KZ2xc61Fl5tZlDUA9KU7q0RvISXHr+TIft6QPw1STqxzRq90VwV94QmVKFKKG83MARsGrSws6bm3JBBNjdRXWqXpllCab5MKlpDBHKI09y1xH6hmsIOYIrbTNTJWcvdEZwyLm6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwWfn2qk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwWfn2qk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B37C2BCB0;
	Mon, 11 May 2026 06:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778480389;
	bh=tyUElYqrF4iGdnlg4H9Rm4Hpn80YPj202MfgcvQSBEk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FwWfn2qkUZ+816fjmyS8aA4yEU1Rmb+QIHErJn5t7X8AxkHYCZg1jph1pfXE7g8pF
	 gLsTaTJilFdUtUZXjbvRtoJ5tg0fw8u0a9FgUXPYezpihbtxMyw9XKNZ58zC7zzaSK
	 wohFlaPS8+YR31HkiOigOy3nBDMrJ2FpJP91lYcSQx7T+CxcNnFbVzGNukOKTruBYo
	 fqspw90LiRyIjIaLP1uLVZo3bvru2ApeUJx1r47ps50jtofZw/6kR2F33iz7CrhugU
	 cOC8wBWNyldD96KexjpLGBS/ctbWpsNMiYc5YLUrvqAG1WLmJeAQ6pn4eZeytboaeS
	 PxbwIBu0l3zxQ==
Content-Type: multipart/mixed; boundary="===============3061080492489964304=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9807060ec039594f53533aceaf5808b667bbceed625575fa146871e3a05a4634@mail.kernel.org>
In-Reply-To: <20260511053322.1883474-1-yonghong.song@linux.dev>
References: <20260511053322.1883474-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 04/24] bpf: Set sub->arg_cnt earlier in btf_prepare_func_args()
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 11 May 2026 06:19:49 +0000 (UTC)

--===============3061080492489964304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 77af44d8a3ad..a33a5b4122f8 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7880,6 +7880,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>  	}
>  	args = (const struct btf_param *)(t + 1);
>  	nargs = btf_type_vlen(t);
> +	sub->arg_cnt = nargs;
>  	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
>  		if (!is_global)
>  			return -EINVAL;
> @@ -8067,7 +8068,6 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>  		return -EINVAL;
>  	}
>
> -	sub->arg_cnt = nargs;
>  	sub->args_cached = true;
>
>  	return 0;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25652623893
--===============3061080492489964304==--
