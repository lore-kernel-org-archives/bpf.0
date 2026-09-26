Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A0B3403EF
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790433183; cv=none; b=oYjeBnd82HAhqIdFBxjv60u+2yMTEQT+JFTLclHarY8WLQKP70kTZqACNnloFyixaBjI/vXCZH9clhpI/rbRTkMhx8KRF2ssjPl44Di/luU+xOJN4olJNK95oihTfG6Z2y4ejQHmElM07pctFV2QU/e0cFS4AN9JGYTqPNG+Cho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790433183; c=relaxed/simple;
	bh=X5Tjd7YFhWcqDhu52N6Uz+HWn+dNB4SFnZBkgxQ6Qt4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HBQxXklHXKX5eMscwzvvjFA1mgkPbLeebFIqF3rY3gag50E991HrovHxIcT9UdEBrCIQKUtejIH47EPBVXHfJnbAj/nO4upSDCa2cpyDtBlIE6Ysj/90Xr9LpS73aWZwfWpie7NJFeKkgHstB2s/Yd2itlMZoJIt+hvbn2vRV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS8lkQVG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS8lkQVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003FE1F000FF;
	Sat, 26 Sep 2026 14:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790433182;
	bh=XXwC68jK7fM00+2S7gr3FZS3UWBTOOOPGrACVEV/Ij0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PS8lkQVGC5zpYF8xZe73hYAbS8bAB3yc1cLM7uS5JvLW3NVHXtYh2SR+JS/irOcEa
	 Y4od7b7hFRJ38AYbH34YANJQVHtZSINRdaknwxOfDbdS7MUwFPvjfpB19kpesEQ4xL
	 pUD3g5oKZ06kyEzVAp3tgdgLdBVMfzpsJ9X7xZsxP86wMhmgSjjC62GSvjQ7X+q+EI
	 zi7jFhwXe4WI2VTtcJIA8KTo1n7AJHZ35Agv57gbOq9MWzYsTkJjW21JnEqyQzXjtJ
	 xS+GLux6X5gkGUxmW31/m++fhy5IDSjQi3iVEQpi/LzpfafNp0eoQJLiK1Nt/3TbNz
	 dFOXbyg0CI+zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 03/36] bpf: summarize live stack slots in
 insn_aux_data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926-scev-minimal-rebase-v1-3-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
 <20260926-scev-minimal-rebase-v1-3-c8e5ab5ba79f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:33:01 +0000
Message-Id: <20260926143302.003FE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: missing helper function promised in commit message
--

commit 86d6b186246ae90e5b5fd0f2e5d9c4148d983e50
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: summarize live stack slots in insn_aux_data

This commit precomputes the union of current-frame liveness masks from all
analyzed function instances for each instruction. It stores this summary in
insn_aux_data to help the scalar evolution analysis skip tracking dead stack
slots.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c6d617581e841..7f31ce5ea6b7b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -667,6 +667,7 @@ struct bpf_insn_aux_data {
>  	 * that this instruction may write to.
>  	 */
>  	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);
> +	DECLARE_BITMAP(live_stack_before, MAX_BPF_STACK_SLOTS);

[Severity: Medium]
The commit message explicitly states: "Store the summary in insn_aux_data
and expose it via a helper."

Could the commit message be updated, or is there a missing helper function?
No helper function is introduced in this patch to expose this new field,
and it appears consumers in later patches access the bitmap directly via
test_bit rather than going through a helper.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926-scev-minim=
al-rebase-v1-0-c8e5ab5ba79f@gmail.com?part=3D3
