Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B03AEF5D
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785384; cv=none; b=sT6XV3BxNgBmHgmnPEbnm7u///Ub7Yl6otQF/iRRlYPHVOoIsSfCbZ+jbMy3MEkaE9WPW4d2cu8MkXZAdA+DetK809RqFs5vx2S+FUW+Oh0feO12m+bZksH44gYuL/qwETGtlkfpa1EOIsGS0sscRqp9eflc6qsVlBjn0qPr2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785384; c=relaxed/simple;
	bh=hAmuRpG/cu+ZtgIZPvmT6COeeSdzGrDuSgbNXDSXv1I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=a0FINpGf2XLmcEpdCLba1IXeD63s/ekJaPd6oxm8rXX8TGU7EV3jO8b3M1a/Ky65GY1mR0Oh9g95JF9IyySkyFsvX/qUbwkd4eMHiJxIPKmMSiJkP5ZuUwlkuINyiwHDpxPqsE5g3JIUGt4aKu/+rcYVqmgSpY2rrDxRXhBLVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDrlMhkJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDrlMhkJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC3AC2BCB0;
	Tue, 21 Apr 2026 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776785384;
	bh=hAmuRpG/cu+ZtgIZPvmT6COeeSdzGrDuSgbNXDSXv1I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EDrlMhkJg9yh3ptMKs2Zhep0ToEGi6EGAH3kFuTSAE2rOU6VR999iVT2FSuJ6kwnx
	 67re3eRwqZ5OSk2tvTkYu9E03Ipz8Tam+AXfW3MM0JJNFtFoB/t//kZIkNlQxdQtP5
	 rsqMQ7+MgjPI2/thQawKLdUYiNKpb8Lr+R9lv004TKqrZknvqH6HrxvYMi9JHv/0tz
	 uHBSbMmmE4HRqP2e0QGzTbQaGljmeMNPuHzlk5aKVY9L6tY2Il3A7P9ooJeB47FQcZ
	 bwcJvm4cx93K7rmSMFNq43TA3ooM6lL7wfcVa2tOIeT8Dd6uGYEfQfI+IQoD02qIXi
	 WWZxuM1+JWDCA==
Content-Type: multipart/mixed; boundary="===============8675324797701230467=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3cf100927b1aa3f5f53e8ab7176a76d7f8bf7ec083c001e8107cc16037c77e82@mail.kernel.org>
In-Reply-To: <20260421144504.823756-2-tangyazhou@zju.edu.cn>
References: <20260421144504.823756-2-tangyazhou@zju.edu.cn>
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Fix out-of-bounds read in bpf_patch_call_args()
From: bot+bpf-ci@kernel.org
To: tangyazhou@zju.edu.cn,bpf@vger.kernel.org,ast@kernel.org,eddyz87@gmail.com,emil@etsalapatis.com,puranjay@kernel.org,xukuohai@huaweicloud.com
Cc: daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tangyazhou518@outlook.com,shenghaoyuan0928@163.com,ziye@zju.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Apr 2026 15:29:43 +0000 (UTC)

--===============8675324797701230467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fix out-of-bounds read in bpf_patch_call_args()
>
> The interpreters_args array only accommodates stack depths up to MAX_BPF_STACK
> (512 bytes). However, do_misc_fixups() may allow a larger stack depth if JIT
> is requested.
>
> If JIT compilation later fails and falls back to the interpreter, the verifier
> invokes bpf_patch_call_args() with this oversized stack depth. This causes a
> load-time out-of-bounds (OOB) read when calculating the interpreter function
> pointer index.
>
> Fix this by changing bpf_patch_call_args() to return an int and explicitly
> rejecting the JIT fallback (returning -EINVAL) if the stack depth exceeds
> MAX_BPF_STACK.

This patch fixes a bug that appears to have been introduced by commit
1ea47e01ad6e ("bpf: add support for bpf_call to interpreter"). Should
this commit include a Fixes: tag pointing to that commit?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24729984210
--===============8675324797701230467==--
