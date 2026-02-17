Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA8E31064E
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771321444; cv=none; b=ZGGZRE7Sn1nh72QaYohtx3dnERoiFXhO7SFkMgkS2X0RGq5uGJPFkSM7uOFk59+ESVMbz4G9XLt2eiDUhc+dwKNQ1cjVXikLlaPTlAQSEA1EEeANm7mFU7UMJsBAcbdCeoToj6ULk43q5g1YRJCEuns9a8wVWMOn5NcJDJ1KiJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771321444; c=relaxed/simple;
	bh=slbx0opbpVETt74HdFz+0IHQZRiipFFAkkKf8sDcUoM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fcITYKB82QpFx3+fUFOcBr4whAESFrr87GftNsvuP7Ak/bnpXjvcPldd2shs2PKwSyhnM89sqGlkQbtXCYLcUkEynD+ctnTL7976pvjoEm4/5iknUDWcSL6wH9JGTY92/uXEinWMADPUsynmSp7yvUvi2OLnbAB8RRMMAss9eGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfO1UGM3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfO1UGM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E94C4CEF7;
	Tue, 17 Feb 2026 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771321443;
	bh=slbx0opbpVETt74HdFz+0IHQZRiipFFAkkKf8sDcUoM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=DfO1UGM3wg7ngax9UJte53IbEvakR3ibZD3IpCi4nvt9uLF9+DVOvGyDOJy/RkF19
	 CphHRDqh/QOR76G96RVjV8dZQdNidqdGvbTOzIdukVGYGA8Y56WG3CF4lWiHiCAzLU
	 DCIplb7z4Ff1IOwe2Ee5N/lGn0lhPucvyWM/oUur4c+LNxsH8bQn7HmYZ6RkWvPliM
	 Y9LY/mdcn+5AlKFhF8n+If66Md+O6IwmF3BS7ZivLXFk2/OUioJT18Frowb2ft7Jno
	 APxnmt67L/IZIsFgPXXd/t/1UtEGE0LQzQkIrCIWteaK7jvodQtWXmOwAda87yoxq6
	 pmiuGyEi5mo7w==
Content-Type: multipart/mixed; boundary="===============2029061182599837604=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <70e49d1210d1aa77ccf713bb39c5b6a19c0081553a2fad41a581714077663c0e@mail.kernel.org>
In-Reply-To: <42397d01c3662e85437ffdfa41f5e0c0799189fb.1771316309.git.paul.chaignon@gmail.com>
References: <42397d01c3662e85437ffdfa41f5e0c0799189fb.1771316309.git.paul.chaignon@gmail.com>
Subject: Re: [PATCH bpf 1/4] bpf: Introduce tnum_step to step through tnum's members
From: bot+bpf-ci@kernel.org
To: paul.chaignon@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,harishankar.vishwanathan@gmail.com,srinivas.narayana@rutgers.edu,santosh.nagarakatte@rutgers.edu,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 17 Feb 2026 09:44:03 +0000 (UTC)

--===============2029061182599837604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index 26fbfbb01700..55197c9fadc2 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -269,3 +269,55 @@ struct tnum tnum_bswap64(struct tnum a)

[ ... ]

> +u64 tnum_step(struct tnum t, u64 z)
> +{
> +	u64 tmax, j, p, q, r, s, v, u, w, res;
> +	u8 k;
> +
> +	tmax = t.value | t.mask;
> +
> +	/* if z >= largest member of t, return largest member of t */
> +	if (z >= tmax)
> +		return tmax;
> +
> +	/* keep t's known bits, and match all unknown bits to z */
> +	j = t.value | (z & t.mask);
> +
> +	if (j > z) {
> +		p = ~z & t.value & ~t.mask;
> +		k = fls64(p); /* k is the most-significant 0-to-1 flip */
> +		q = U64_MAX << k;

When t.value has bit 63 set and z does not (reachable when
z < tmin, which the function comment says is handled), fls64(p)
returns 64, making this U64_MAX << 64.

Shifting a 64-bit value by 64 is undefined behavior in C.
tnum_range() in the same file already guards against this:

kernel/bpf/tnum.c:tnum_range() {
    ...
    /* special case, needed because 1ULL << 64 is undefined */
    if (bits > 63)
        return tnum_unknown;
    ...
}

Should tnum_step() have a similar guard when k == 64?

> +		r = q & z; /* positions > k matched to z */
> +		s = ~q & t.value; /* positions <= k matched to t.value */
> +		v = r | s;
> +		res = v;
> +	} else {

[ ... ]

> +	}
> +	return res;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22092666641

AI-authorship-score: low
AI-authorship-explanation: Detailed hand-crafted mathematical proofs with academic co-authors from Rutgers University and references to SMT solver verification are consistent with human academic research.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Undefined behavior from shifting a 64-bit value by 64 in the j > z branch; currently unreachable from the only caller in the series but reachable through the documented API contract.

--===============2029061182599837604==--
