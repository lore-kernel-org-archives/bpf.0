Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B75724A07C
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400214; cv=none; b=YraEyvKOoP8SGc7gq25891rB+rQaruBVAciFLkH3vK3oILr/eK5YDJdU8s7OXNT9Vj094Lxlzyve9mOjoDPNxda8G/z3ALwfLIeUbbZWbnj5X/BkpRSgvB2CSTGJuMcWEE4isQqyfoprA1xHCQabKh/fy2HzXuGeYMSdwlG3mvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400214; c=relaxed/simple;
	bh=HK9VluUcDUNgaNE0WCcyebugNsq+ZEwkvEuokZPnwhg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NmIKrIRCKqO94qc+vfcAsFQFhqUM1aBtYFU8ga9RqDcG4cRLgyvzdqGnGZ3QG6zIfcBsYebWL4GbyvVrbh7b4B4hwVOjb2rjsb4jg+7h/zKL2GZM/aQ8vmv+QBdtwR3qDRIsjXTBJDgDsgrmGQBFa66JjBLvwtEUedMaYd1WuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxFkVwij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxFkVwij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B42C19425;
	Fri, 17 Apr 2026 04:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776400214;
	bh=HK9VluUcDUNgaNE0WCcyebugNsq+ZEwkvEuokZPnwhg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=UxFkVwijStzvTKpTTvrHoBbw+hOcj4nRqcuL2hlgSg1/EHg+vd6gdGVKi6HqnnUyz
	 Gv8Ugg0xdTJmOeTMLaQVOsawkjPdPjpU+1bBKCujjdYodXQ1rCkxJ5HrnbNvo5mYYD
	 cepyo1E69KLBPRkv8366oanVqftFI65b3eBVBnMHhVkqshA1zWGA3EWZQGsP9BY2Gb
	 lSjFhgPbakWqx+Ct3N6eWPioHBjSUB5RrUHHN3qHLayXakTKnq53VGzTqBS8KLiMh6
	 GORJ/hy1VQj8nd78uakZcy/IuvpGcv6L5mb3/knJ3TANFRTNGfHPr+od/d7bDTMvVQ
	 krs2kAaGxiDJQ==
Content-Type: multipart/mixed; boundary="===============3769579060809962377=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45793b600244e5488a7a16ab1d75729bd8b3398627de6d34b37d47141245aff4@mail.kernel.org>
In-Reply-To: <20260417034800.2631277-1-yonghong.song@linux.dev>
References: <20260417034800.2631277-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 12/16] bpf: Enable stack argument support for x86_64
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 04:30:14 +0000 (UTC)

--===============3769579060809962377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 96653dbc686aeae7abf4f70b15720267e083674d
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Enable stack argument support for x86_64

Add stack argument support for x86_64.

This commit fixes a bug but lacks a Fixes: tag. The commit adds JIT
capability checks (bpf_jit_supports_stack_args) before allowing stack
arguments, which was missing when stack argument support was originally
introduced.

Commit 212295359353 added code in btf.c that unconditionally set
incoming_stack_arg_depth when nargs > MAX_BPF_FUNC_REG_ARGS without
checking if the JIT actually supports stack arguments. Similarly, commit
173008b815e6 extended this to kfuncs in verifier.c without JIT capability
checks. This could lead to programs with stack arguments being incorrectly
accepted on architectures that don't support them.

Suggested: Fixes: 21229535935384 ("bpf: Support stack arguments for bpf functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24546989054
--===============3769579060809962377==--
