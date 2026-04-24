Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFA03E6DF3
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053644; cv=none; b=VRq+udnS/2PZXVXmd8zLtvDwUuT71PnLyUhU0mSn/P/OqNYjp4ccCbSd7ZktTtMNXZJR9KPHhof9BUBxOKfaa6Q+naJANI8bahgYXsv/jq82MKYrzvR/GfBsGoQfQIMByko44142GJwMnLPpoGZOvYngGQpqvxXMPM+Vf6Km4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053644; c=relaxed/simple;
	bh=nAbSojfdm1yw82Vgg68q57ofr136m4APEOtNgf+S+hE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=D8CV/KXWHsOAjac9+g7tTYglVXWdj849zFhjdyyA9Q+wsPhD8MD3vi3JxTlbKpiisMOUMP/KPEvk+cBQWiGGyBeUy1vXUfNRyuS8g6GOttF9ZgoBbonPztMAxzD1t7r27CKILDzMfJBP1wjTosCgHVHhlcGuwgMtPNMQL3VcRWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag3ZYX44; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag3ZYX44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F2FC19425;
	Fri, 24 Apr 2026 18:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777053644;
	bh=nAbSojfdm1yw82Vgg68q57ofr136m4APEOtNgf+S+hE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ag3ZYX44sR01D/SWLAa4DmfDkALP+AbLTUMq4ha36e5abrx9VPSIgYaCFAfo0fcn0
	 hdDSjfejKYIWhkt0Olg6NPYa6uwWQVq0nORCUkiyeFwv2mlmaJfVJthp0EfyJ5XMdQ
	 A6RCqY4KrFdoFmwD8I7s054vEcm12IVBOcxjGBlwihp7rORa+49QLedx5/71Ud3ZtG
	 HHn8vhQSRvL5tt33XByGcrFrOMIqJaphNkDtqL1b7gN7nxYtGGEI3BeDMA9PDW5BBk
	 v2Pu+3IZw44R4zpmYWhjmFkuuui22a2aHEF1VMlIscGqIEDgBygtJkEe3dMgVxbYLP
	 b+NkxN1ncjQMA==
Content-Type: multipart/mixed; boundary="===============1241699041822174397=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6deff9aef8ef4f3d5ba6f9dde696f7d62c0b8c5a9baade13e99030209a2a60df@mail.kernel.org>
In-Reply-To: <20260424171454.2035580-1-yonghong.song@linux.dev>
References: <20260424171454.2035580-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 04/18] bpf: Extend liveness analysis to track stack argument slots
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 18:00:43 +0000 (UTC)

--===============1241699041822174397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Extend liveness analysis to track stack argument slots
>
> BPF_REG_PARAMS (R11) is at index MAX_BPF_REG, which is beyond the
> register tracking arrays in const_fold.c and liveness.c. Handle it
> explicitly to avoid out-of-bounds accesses.
>
> In liveness.c, extend the arg tracking dataflow to cover stack arg
> slots. Otherwise, pointers passed through stack args are invisible
> to liveness, causing the pointed-to stack slots to be incorrectly
> poisoned.
>
> Add a parallel tracking array (at_stack_arg_out/at_stack_arg_entry)
> in arg_track_xfer() to record FP-derived values stored to outgoing
> stack arg slots and to restore them on incoming reads. Extend
> record_call_access() to check stack arg slots for FP-derived
> pointers at kfunc call sites, reusing the record_arg_access() helper
> extracted in the previous patch. Pass stack arg state from caller to
> callee in analyze_subprog() so that callees can track pointers
> received through stack args.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

The commit message describes fixing out-of-bounds accesses and extending
liveness analysis, which suggests this fixes a bug introduced in a prior
commit. Should this include a Fixes: tag? Looking at the commit history, it
appears this should reference:

    Fixes: 8ade62ae1543 ("bpf: Support stack arguments for bpf functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240
--===============1241699041822174397==--
