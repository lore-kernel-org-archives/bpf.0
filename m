Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83B42188D;
	Mon,  2 Mar 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466793; cv=none; b=PWVBqwRefeF2Y0cRyCBEZ1eH8wt7nd4a6/f2USLe9ArMcXEBs9JCISZXgfI58nU5MX2S9jWDQ0wxlD1MF+OExb+ERlbMy989dP5hSJZM1d6upRNPJ0mqkUHouYiTLJml/PHdCRv/iifQTUmG6/8F7vxxhx6RdtTKxJ6G4O5/JFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466793; c=relaxed/simple;
	bh=Ke8jQXU3J+29aY5FbS509phyVwX7VpZYTaFtOaKVIbU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bDZmip+Mdl7ho9KDSwy6pl+vABb5Z1s7zXPzlUOQPykxHFkLLNqarJcJOTySPv3zy4NmsphaTqpFhRmoBpScMzz42yKniPu6On1OSZPdG0PdtQ8qvn5w6Fp4vysU/z8dT7d0n5qEnjzald9nxT20f1VWdpu7YBpopRpMAwVsxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSemX7Mh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSemX7Mh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0594C2BCAF;
	Mon,  2 Mar 2026 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772466793;
	bh=Ke8jQXU3J+29aY5FbS509phyVwX7VpZYTaFtOaKVIbU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=lSemX7Mhwb7tWRnQ2XXqo4XH2ao/oQqPIKL7j72M0w9j0lV+/9TRuYXvdq9hjpUM8
	 +bfji9dg+m7yPW16SaNpvUlT4UQInJa0Ms0IXJJSJnECRMQfMJEDa0D+JiPnwaVx12
	 uAekXOg0iNiEu6yFlA937cWsf605ThboZiBYwus73KkXXYKMITxxQjN49lBpOhyijs
	 WRI12WH8WP5rq/bccIEPAZFv8STqO3KfXZ2TUssMYhQP4Bty1/8Sn82f+0kY9nH7Vw
	 jhx6aS4ipbPWs/wA552qwVTYFk9tRrvS1RUeKtrLKbV/+9aHL7UZzxRZw6pwrlLFk6
	 Ky/cQ/UQ28SfQ==
Content-Type: multipart/mixed; boundary="===============8515939307212125773=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d1728faa022db83c9e5ab0245579eb1b1d176495744953f9ab66e0864ed31025@mail.kernel.org>
In-Reply-To: <20260302150342.55709-4-leon.hwang@linux.dev>
References: <20260302150342.55709-4-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx progs
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,yangfeng@kylinos.cn,leon.hwang@linux.dev,menglong8.dong@gmail.com,puranjay@kernel.org,bjorn@kernel.org,pulehui@huawei.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Mar 2026 15:53:12 +0000 (UTC)

--===============8515939307212125773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> +enum bpf_map_owner_match_type {
> +	BPF_MAP_OWNER_MATCH_FOR_INIT,
> +	BPF_MAP_OWNER_MATCH_FOR_UPDATE,
> +};
> +
>  static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_prog *fp,
> -				  enum bpf_prog_type prog_type)
> +				  enum bpf_prog_type prog_type,
> +				  enum bpf_map_owner_match_type match)
>  {

[ ... ]

> +	switch (match) {
> +	case BPF_MAP_OWNER_MATCH_FOR_INIT:
> +		if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
> +			return false;
> +		break;
> +
> +	case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
> +		if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx)
> +			return false;
> +		break;
> +	}

In the v1 review, Alexei Starovoitov asked for strict conformance
both ways rather than one-directional validation:

    "Don't be fancy. Require strict conformance both ways
    in *all* patches."

https://lore.kernel.org/bpf/CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM3Az197eL_0A@mail.gmail.com/

The BPF_MAP_OWNER_MATCH_FOR_UPDATE case still uses one-directional
matching, rejecting only !owner->kprobe_write_ctx && aux->kprobe_write_ctx
but allowing the reverse. The v2 changelog lists other Alexei comments
as addressed but does not mention this one.

Was this an intentional design choice, and if so, should the changelog
note the disagreement?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22582690876

AI-authorship-score: medium
AI-authorship-explanation: Confirmed LLM involvement in v1 development process (selftests called out by reviewer), but core code changes and v2 revisions appear human-authored with genuine design engagement.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Unaddressed maintainer review comment requesting symmetric matching in the UPDATE path; not a code bug or security concern.

--===============8515939307212125773==--
