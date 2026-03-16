Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B846B5
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689617; cv=none; b=FSYiBSF0Fni6yf0AUMFxxdoY2VPyQBUXEzpxtjWS3A8Q+MKS+bQhirnAhgMoW6kVsunuHoLrcjyixabcPyf48/TdmHoAG/PUhfFTto+sIXrLJgYcEG/aVKQbbMcpuEp2IPvQyG86n5Q9OWfPWJi/fiiF7qRonht8nPhnAa58Fs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689617; c=relaxed/simple;
	bh=FYmkINOfl0mrbI6Fb+Yq0R3TdkLBK7eOWBA2FX8ReMg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Vp7H1rMz++0951Q0XfEdiJ1VkUMVjm529Hj5QyOfJU7hTAtSf/9DiZZi+hNul8+dGAsdUDTOvPRRnbdVxERycMy/A1yQyuhsrpgtSIEsXTzcrMgHNb+DwjsWuRfvDhOm9c3wn9wlcqPLVJNB//zBUarkIEF/NABLSbtSF7qb/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/UyC1KQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/UyC1KQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7DCC19421;
	Mon, 16 Mar 2026 19:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773689616;
	bh=FYmkINOfl0mrbI6Fb+Yq0R3TdkLBK7eOWBA2FX8ReMg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=R/UyC1KQ2k0Euj5KrPZDu2BrsYPRujcAsYjDNaq21/G7w69n0CSzJm7OdseJYajIc
	 HmaWk6qtpJgtFzTEJMqwoLne+EG1xc4P+VjtJfcVbEmwO7ZwpHeFFiwPpnyNvMsNm9
	 Dt60WBUAZ2Jal6OOozAg7SPAh1DA8DobDDXMylXzMV2j6AlYn2vc3FC1+bAJYMzUbB
	 bX0GUUm/tK3uqbgUWTNLNxDA2mzv+gA38kzYQOZOp5kN0TDBMWD+MWP/7v8Mp5prhN
	 46u2kK0Iqf3dXrMgcoKtJZlrvGgwsxsJaLmRe59UKOUAYjHeTC/jVwUyBVQB6iB/S3
	 co5IIXhDHCkOQ==
Content-Type: multipart/mixed; boundary="===============5977400864146143524=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a5f3ea1ff2a35ef8ed8446383010ed81e20737a3bfcc7592f92e75e3f23b44cd@mail.kernel.org>
In-Reply-To: <20260316190220.113417-2-tangyazhou@zju.edu.cn>
References: <20260316190220.113417-2-tangyazhou@zju.edu.cn>
Subject: Re: [PATCH bpf 1/2] bpf: reject bpf-to-bpf call with large offset in interpreter
From: bot+bpf-ci@kernel.org
To: tangyazhou@zju.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ziye@zju.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Mar 2026 19:33:36 +0000 (UTC)

--===============5977400864146143524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23109,6 +23109,12 @@ static int fixup_call_args(struct bpf_verifier_env *env)
>
> 		if (!bpf_pseudo_call(insn))
> 			continue;
> +
> +		if (insn->imm < S16_MIN || insn->imm > S16_MAX) {
> +			verbose(env, "bpf-to-bpf call offset out of range for interpreter\n");
> +			return -EINVAL;
> +		}

This fixes a real bug where bpf_patch_call_args() silently truncates
the 32-bit imm to s16 via:

    insn->off = (s16) insn->imm;

Should this have a Fixes: tag? A prior patch from 2022 by Yichun Zhang
addressed the same truncation issue and identified the originating commit:

    Fixes: 1ea47e01ad6e ("bpf: add support for bpf_call to interpreter")

That earlier attempt was acked by Song Liu but never applied.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23161654757
--===============5977400864146143524==--
