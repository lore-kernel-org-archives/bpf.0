Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42434F497
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191874; cv=none; b=dRzgHYSbkz3CGLsuWfrcxX6O9A96CwemVCCk2BhPMulIlZkDCuGPjxrzYJEPA+RezDWlTS9ibf6s4MBJG+0ADaAUCfLpv2/YYiS2XypG8Jjvi0uBgd3eMYR98xeI846C1NlanM+Hre4yLXqgerRvjwej3IRWxG2PAHw4huascYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191874; c=relaxed/simple;
	bh=DVpKXC6B14LZBrakJy+XDd8AGlBD01p8xPSCpyYPA6g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KOUrTXYCnAUk4UN2gKU89ETtNQ9BoIXonHq9vaWNtiCHmOsxBe+XLCYWvt0oirCPINDYCuHv6nMs18QaNcU8xjph3QMdLAnP6RZEz0Y7CJTa5KXwn+I1HIHUfSyV419y9JWps4hXLLif4Wwr1waV3e6/peiNBQf1tdCxWAYjrvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvR9SCoB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvR9SCoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC81EC2BCB2;
	Thu,  7 May 2026 22:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778191873;
	bh=DVpKXC6B14LZBrakJy+XDd8AGlBD01p8xPSCpyYPA6g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=LvR9SCoBnlP3qFmCKUtM7k+dioK2FxlAhGLFcEOtdsXalJCMZlsHs5AOJn9M0fmV+
	 gI4YLnMLPtpQbfM2YmuL5IWjY9VlVBZ83C93S3jvUQvP1FHy3pOzbT3fSHpO6KRFKM
	 ZpSCP1uKmJBChcdX8wy77XxyDl02hh/2E3qUcThSb65ZWu6Ogt57QBuRohrWYDMZCm
	 90mRUy2+skwycosUZQ4NtXCHHCOCiayo2Dz3V9htrekxmhJX9KguDD6R/VYnilppFa
	 ZE69mCypmZTfyuuKp0/leIGrcCWFEHhBExoHjCWxEhFDhMBbjopB9wAnuqZVCD9VCv
	 /sN7Mm7jH1lRg==
Content-Type: multipart/mixed; boundary="===============7386073106910258888=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <25d29e25e7715da21371ee7d4a7b5445cd8c8eca4dad9ff2d3e34d39fb68c906@mail.kernel.org>
In-Reply-To: <20260507213003.1125144-1-yonghong.song@linux.dev>
References: <20260507213003.1125144-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 04/23] bpf: Set sub->arg_cnt earlier in btf_prepare_func_args()
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  7 May 2026 22:11:13 +0000 (UTC)

--===============7386073106910258888==
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

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25523765323
--===============7386073106910258888==--
