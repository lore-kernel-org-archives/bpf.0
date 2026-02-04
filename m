Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2A3A9D9E
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198025; cv=none; b=HphE1ceXisbI2hAVgI/stj+hNe84pNuKGCb+4M1QyNy2Mb0RAPNObf2HXQpMgj7HuBe2InCuH9k6u6icUFpBdEPABKAe3HFkgFxdv3Hi3T6DSFHYytrqb3Iu4tmvAlUotXuZInJUf974HELwVn64N7XlLmu5LMAJ/gk2BT+wGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198025; c=relaxed/simple;
	bh=9SOgdkscWj78nZbYk/OscIB4o8c+15DpyWvwhuFEpeM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Lg88iVUgKT+9eVVaKL+DSSWzgnH/4MoZ3I0Ymx1scY2WECHwn7m+B+oluThk5KdgHmbmK2VjtrP6r7WDwJtkrMuEL8UfkjJsFumsCZ1w7rKf9CwMHE5tgM5DlM81jw8PP3tvYSU49iRY619mLnWR7zGl9kw4voYGjMGwYDlAntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyojEzcE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyojEzcE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDEBC4CEF7;
	Wed,  4 Feb 2026 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770198024;
	bh=9SOgdkscWj78nZbYk/OscIB4o8c+15DpyWvwhuFEpeM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cyojEzcENSckxU+dy2i6xfD2iw1NBLwtTHj4d+EHrZYGOqmYZDiX1tIG33O/kYi8j
	 NnV8zc1wCzL6Uph6HyiQPNcOr68r75eLbSDXczR9jcSq0tGQWtII+h9QMqUjixiMEG
	 Ix0MqC0UKMQMMNfhgpbBop5e5kwVSV2BCd0Gf6OQjc/VfUtFgeCLgZC5UneOLTLoeY
	 LWoKOZgK1ERDquASLjyw2rk/kXI4775euq+Eh8Y4W2LIsgMiuJfbsKTXK1ejL4QCnk
	 RhKImIjBJYPEuHTlBIBNq7rHeFRIvv7mqv2zAHlfVr/oHhOtrda5JaRlUd6NoLkecl
	 Lom3ofkFXisDQ==
Content-Type: multipart/mixed; boundary="===============2659365845639206335=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b208ef9093c624823bec6fc78080f33d921f0911c5965505ddf8a88c6ab178af@mail.kernel.org>
In-Reply-To: <20260204091146.52447-2-ziye@zju.edu.cn>
References: <20260204091146.52447-2-ziye@zju.edu.cn>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add bitwise tracking for BPF_END
From: bot+bpf-ci@kernel.org
To: ziye@zju.edu.cn,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ziye@zju.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Feb 2026 09:40:24 +0000 (UTC)

--===============2659365845639206335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> 1. In `tnum_bswap(16|32|64)` (kernel/bpf/tnum.c):
>
> Call `swab(16|32|64)` function on the value and mask of `var_off`, and
> do truncation for 16/32-bit cases.

This isn't a bug, but the commit message says "Call swab(16|32|64) function"
while the code actually uses __builtin_bswap16/32/64.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 40a825214..8bb8ed1a5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +	case BPF_END: {
> +		/* Byte swap operation - update var_off using tnum_bswap.
> +		 * Three cases:
> +		 * 1. bswap* (ALU64 + TO_LE): unconditional swap
> +		 * 2. to_le* (ALU + TO_LE): swap on big-endian, zero
> +		 *    extension or no-op on little-endian
> +		 * 3. to_be* (ALU + TO_BE): swap on little-endian, zero
> +		 *    extension or no-op on big-endian
> +		 */

The comment says "zero extension or no-op" for cases 2 and 3, but looking at
the x86 JIT in bpf_jit_comp.c, le16/le32 on little-endian (and be16/be32 on
big-endian) always perform zero extension via movzwl or mov eax,eax. Only
the 64-bit variants are true no-ops on native endianness.

Should this read "zero extension (16/32-bit) or no-op (64-bit)" for clarity?

> +		/* Apply bswap if alu64 or switch between large and small end machines*/

This isn't a bug, but "large and small end machines" is non-standard
terminology. Consider using "big-endian and little-endian".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21665727000

AI-authorship-score: low
AI-authorship-explanation: The code shows domain expertise in BPF verifier internals with natural variable naming and conventional kernel style.
issues-found: 3
issue-severity-score: low
issue-severity-explanation: All issues are minor documentation/comment inaccuracies that do not affect correctness or system stability.

--===============2659365845639206335==--
