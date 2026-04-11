Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A141A681D;
	Sat, 11 Apr 2026 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918636; cv=none; b=oh7Nw9rQ6PDVUpLcoxZjgaqyHVwfMoTxiWSzrA0sPhDWYcu19Eh0c+XDlgJeeE1FTisSXO7hWBb60lGD+x4XgYAMMJO8FMVNBvOWuxO4V5O6Tb9DKdrxMA5cvd5PghGIcFMVdGPWwF/zk8C6OeKbUOABo3g5q0nFQOSX7Ywo9hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918636; c=relaxed/simple;
	bh=tR0CGk7NejHiG1PUmXuw5oIHI38lBuPh+l/CGQhbhJs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=B1Ofr5ZQ/YCZS5FkjY072u9EPPx8We3JVhmTWQYP4KCH79gVREJcxeGvmkOdVqGVoyEVhMJxEj4Bb6LYbQWgOSnkprySisvmNCIN9nNmVt9XpHlx9JPHPVQu/19Lswjf0yTTGVTvXknJf7+5JW9L7nrWvG4QL0bXY9CjjHieIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL/J3LhR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL/J3LhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF06C4CEF7;
	Sat, 11 Apr 2026 14:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775918635;
	bh=tR0CGk7NejHiG1PUmXuw5oIHI38lBuPh+l/CGQhbhJs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EL/J3LhR9dyOXmqwHxsYPXMk0f6pauFrF252TuYfSSi2Ka2w1+FfkCn56TEX3Q14O
	 irX3T4/9hS2LlVSSRKjeRKLuZFx+n7sDXssdZg/oBcgPqa2oduk4IyfsQIeHWfoMgn
	 3DN9xNXNWJWisMqqqbJ42EnNeRRhCqeOM/Yuvo/UbgnMdUVeQgcXWU0jQIpgR0xtne
	 grdvy45v4BVqrx4+bfks/D00ng9kQuOsDo4RkwYZETFIceCzVr+CIlaSljqJMsJRTC
	 4GrqsWNjCH/ktjRlpkPKOjWmbzd/z/LGoK6XaIS7CYjKJB5m10oTSez5QYhDjTwBKH
	 nFbOtwuoRMmVg==
Content-Type: multipart/mixed; boundary="===============0546946895092955607=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a33924088b2be9bbc553442c810a63b94e23045fbcab9c2ff9788adbd9dc188d@mail.kernel.org>
In-Reply-To: <20260411133847.1042658-4-xukuohai@huaweicloud.com>
References: <20260411133847.1042658-4-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v13 3/5] bpf: Add helper to detect indirect jump targets
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,a.s.protopopov@gmail.com,alexis.lothore@bootlin.com,list+bpf@vahedi.org,linux@armlinux.org.uk,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,davem@davemloft.net,udknight@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 11 Apr 2026 14:43:55 +0000 (UTC)

--===============0546946895092955607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index dd6dbd41b06d..dd8949874d1b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -22544,6 +22551,17 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
>  		data[i].seen = old_seen;
>  		data[i].zext_dst = insn_has_def32(insn + i);
>  	}
> +
> +	/* The indirect_target flag of the original instruction was moved to the last of the
> +	 * new instructions by the above memmove and memset, but the indirect jump target is

This isn't a bug, but the BPF subsystem prefers the opening /* on its
own line for multi-line comments:

	/*
	 * The indirect_target flag of the original ...

> +	 * actually the first instruction, so move it back. This also matches with the behavior
> +	 * of bpf_insn_array_adjust(), which preserves xlated_off to point to the first new
> +	 * instruction.
> +	 */
> +	if (data[off + cnt - 1].indirect_target) {
> +		data[off].indirect_target = 1;
> +		data[off + cnt - 1].indirect_target = 0;
> +	}
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24284268460
--===============0546946895092955607==--
