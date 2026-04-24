Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19BE3E8C49
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053639; cv=none; b=U9ivPwoUO7K8yiTaNw+udb3fWE1MQcCtOGL2Z1a1lI6iyKJrEgHbxBBdOniEdEDDgvcjq0c95OJq5csR5KvnnYkppEG9OgDYSYwJ9z2t5x8qEJwhaEWPYil9mKOUnA/xFt2QUWDJjfoKq0CU2GLEU/+GX+8ABRwS9b//0pOE57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053639; c=relaxed/simple;
	bh=zi0pcwvLgSkE16GQXaZaTytInMvC50AD/i1QQ3EcbyI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=M3s0eT7QtngSGUQ9MHM3iZ6BxcDqyV65ZRdMvQvROOA92Vldp6+DAFMgtoEt9NiCh83AS4tm0tAKh7sje00iTx2Ro2we/GSxhm4L5IupdHk2Ue3C+ytSbep+NiwYj/n/jy5i0eSPJpOD5A1Q3wM4MkdickSjqaA9iQtw1+A1v6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmkOhfGs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmkOhfGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4D3C19425;
	Fri, 24 Apr 2026 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777053638;
	bh=zi0pcwvLgSkE16GQXaZaTytInMvC50AD/i1QQ3EcbyI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EmkOhfGswIsaFWdDz3GYJHVGVTFy+qg7TMFihjfTzJp2MjbfAHE5hWfa6ADogB4n5
	 5bksfe2yZMTaj9Pgav2S8LYX3fuJ5VHvKy/lFnQYAuYKROdXn5GoXW4jWTO2uzvVn3
	 bh85eFPE2JyHpgN4UZciBFnkUZaZsWo5wJU6Q6UtUDf35mz2GTeV4cqqvcU1KpNj//
	 oFfB7gUtQXaBFV/H+/niOzWWJD07bkEqtIIqQrSl4XkzwP4kWbe6N9W9i8QTZR4aCR
	 7omYVv5HEAs7RzVqj1483iYQ2utKq1n008CEzyf1GaxD8Iz1znpZjsSDIOlKp5QLIa
	 9cRXHIvzYLjDg==
Content-Type: multipart/mixed; boundary="===============1267234860231037066=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4b232a5a7d66ec44a1e9b24304d269c47d6c6e209cb1c335c0ed9df5cea9570e@mail.kernel.org>
In-Reply-To: <20260424171519.2042600-1-yonghong.song@linux.dev>
References: <20260424171519.2042600-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 09/18] bpf: Reject stack arguments if tail call reachable
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 18:00:38 +0000 (UTC)

--===============1267234860231037066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Reject stack arguments if tail call reachable
>
> Tailcalls have been deprecated. So reject stack arguments
> if tail call is in the way.

Multiple reviewers (bot+bpf-ci@kernel.org and sashiko-bot@kernel.org) raised
concerns across v4, v5, and v6 that the commit message inaccurately states
"Tailcalls have been deprecated" when the actual technical reason is that tail
calls and stack arguments require incompatible stack frame handling.

The author acknowledged this feedback in v5 but chose to keep the commit
message as-is, stating "Stack arguments and tail calls CAN work together.
However, since tail calls are in deprecation stage, it is not worthwhile to
involve stack arguments and tail calls together."

Could the commit message be more precise about the technical reason for this
restriction? Something along the lines of "tail calls and stack arguments
require incompatible stack frame handling" would better explain to future
readers why the combination is rejected, rather than relying on the
deprecation rationale.

Reference: https://lore.kernel.org/bpf/f163dcbf46e9511eba14b22ed10467984bda3bf07a3d1bd6cd27ae14eadc2056@mail.kernel.org/

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

This commit fixes a bug but lacks a Fixes: tag. The suggested tag is:

Fixes: 8ade62ae1543 ("bpf: Support stack arguments for bpf functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240
--===============1267234860231037066==--
