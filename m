Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8941732E6BF
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770751187; cv=none; b=MPLWhuhHo6xieW+cocpa+qKInrM4f6rsCkEY1SeulqoZ//eAG3T72bAgjS9eZCKtsdpWmJ4Zvc9HAVpbH1akeHFtgcOR9ug2JGJVTZJz8O7pQ3KLfr6w/r8WAp9XLSiezizeBpQlTTAH2hsR9vs7ofXY0JANsp1E/1aTeLoHaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770751187; c=relaxed/simple;
	bh=SGP2+kon+6/3eugtxY6Rsq5yyqsbMYDTPjww7DFr/z0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=X/pI2JgYLuO5ab97Vh596uGk4nFxuAhX3+4GTbU0gzVlu5UGyumvOigTPsSDeYVzmpx6L28C13DGoFQAuPbewjyX+eXUY67kL1fPV4va9pIyg1nmW+tBXpGNAvMMnC5fkJrdkKmHDkNdYw1MQ+3QdJHV1qUY29GjwNu6xusikUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGMpLdmM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGMpLdmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03872C116C6;
	Tue, 10 Feb 2026 19:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770751187;
	bh=SGP2+kon+6/3eugtxY6Rsq5yyqsbMYDTPjww7DFr/z0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NGMpLdmM3pMA1yfBkniRXrMPSziU+OClt9LC7RuLi+P9eNZfXaOZp/U9dlcuXS4kT
	 di8p/WilL4yTJyYByEOM4uEg9yTK/S1Jvbpgmet80Ox59dI07dWPGp0w+6qSxmW6Tk
	 QOoWT5BsNWcG4SVH+T1EkFID65KaMs6glDWPGPC73fi57kC5WlbGWJ004Sbip3xMdT
	 jUEGo2AkIoyqOkR0bfhhWnjjJiSmFAgUNzMDjavf1k+1WteX7mgYYiTwtHt2QlyhI/
	 a54/htp3aHZpo9UIrGmdlIP43kfpHWcfhM2xAk7+aWzB1igjr7bTmLja2dXNm9BK6s
	 bKo5HFzDefRIA==
Content-Type: multipart/mixed; boundary="===============4730977871711708424=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <848c629364521da9cb0fa24c52d6e034f3346c5cfd824faa12b0f139de16ce74@mail.kernel.org>
In-Reply-To: <20260210184532.255475-1-emil@etsalapatis.com>
References: <20260210184532.255475-1-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4] libbpf: Add gating for arena globals relocation feature
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,martin.lau@kernel.org,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 10 Feb 2026 19:19:47 +0000 (UTC)

--===============4730977871711708424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b842b83e2480..9689e408ac58 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c

[ ... ]

> @@ -581,6 +643,9 @@ static struct kern_feature_desc {
>  	[FEAT_BTF_QMARK_DATASEC] = {
>  		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
>  	},
> +	[FEAT_LDIMM64_FULL_RANGE_OFF] = {
> +		"Full range LDIMM64 support", probe_ldimm64_full_range_off,
                 ^

Andrii requested in v3 review that the description should start with
lowercase since it appears mid-sentence in error messages like
"Detection of kernel %s support failed". Other feature descriptions
that don't start with acronyms use lowercase (e.g., "global variables",
"minimal BTF", "kernel-side __arg_ctx tag").

Should this be "full range LDIMM64 support" instead?

See: https://lore.kernel.org/bpf/CAEf4BzaLqWT1oj-EXibyAfE0ExmiaCCqhosRujDi7Y0Nyho6dA@mail.gmail.com/

> +	},
>  };


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21878398162

AI-authorship-score: low
AI-authorship-explanation: The code follows standard libbpf feature probe patterns, includes iterative review responses documented in changelog, and shows natural debugging artifacts from review cycles.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor style issue - feature description capitalization should be lowercase to match other feature descriptions.

--===============4730977871711708424==--
