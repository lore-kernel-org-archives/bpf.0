Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126301E868
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077959; cv=none; b=m4mnYTrMeLMzf+/ysfbLC5arr8J1J6m3/akuQWsgWgkqsOTIaUJniOG90Sx4conqCfb/VXGKqy9y55MJziQYVDARFU86W6j61nKPEhm30G5BlOxunSY65WCi9XMmrNe20nxa3Md3hwzWvoAQ3vtFs3wKx3jpDOnWn781hFXGCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077959; c=relaxed/simple;
	bh=bfrv0tAjK1NcYTDWPjqWBhMMFR03KkNVtZrE78nb0TU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uH1+1RzBD94Dbm7sj9pBRhIdMx+IaDrk/dO39PlCTEqvOe+Ys/6oNLkg2pX8mTmGQPUhyZIHv3UlPN19R9GNdQMYSZPTzBnsYhs7mv8ih3et2nlIaNfHcIRIN0zhjLRvhTZGde+7Kgyuh9IdMbUxnIOY0NCrwln3HG/8FPZR7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYc1NeSu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYc1NeSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748D2C116C6;
	Tue,  3 Feb 2026 00:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770077958;
	bh=bfrv0tAjK1NcYTDWPjqWBhMMFR03KkNVtZrE78nb0TU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tYc1NeSu/IMdOOC5vjr+/xeMGtYK/uid9yEJ1RlhqzGRPbTxeLLooXMAQqnhWRykw
	 T8SgUBeOdTmdf938EgMLO5BPDIZMTOtVeoZx0/Q6p4HYNsiEu+PpVkzkR2VSI74BTt
	 69e8mp2yrnnlez6RBqE5rmmwsUlaLGElSDHJj7qCBaU5GrydL3NlhI9wSUtgH6MWzm
	 mbYkbfN0DCAsYFK2V1OGQ488sd1T1tVLgq7CU41C9sNiJCsluE17X1XJnVuu3uxTp7
	 0Lz3vuM4KqOVbpH/iXE7FL3HC0rqjWWdGn8V5O7j5Jr0ZHAOmdaq7Qh+odh66h+t5p
	 CWQTLSDOkl9sQ==
Content-Type: multipart/mixed; boundary="===============4518992147532936599=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e3472b618ca3f4c00a78556992af9c819c3a6c93215358ab2e8d8264a7901e7f@mail.kernel.org>
In-Reply-To: <20260202233716.835638-1-emil@etsalapatis.com>
References: <20260202233716.835638-1-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next] bpf: Bump maximum call stack depth to 16
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,martin.lau@kernel.org,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  3 Feb 2026 00:19:18 +0000 (UTC)

--===============4518992147532936599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 8355b585cd..9f7fc990f3 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -317,25 +317,25 @@ struct bpf_func_state {
>  	int allocated_stack;
>  };
>
> -#define MAX_CALL_FRAMES 8
> +#define MAX_CALL_FRAMES 16

[ ... ]

> @@ -346,7 +346,7 @@ struct bpf_jmp_history_entry {
>  	/* insn idx can't be bigger than 1 million */
>  	u32 prev_idx : 20;
>  	/* special INSN_F_xxx flags */
> -	u32 flags : 12;
> +	u32 flags : 13;
>  	/* additional registers that need precision tracking when this
>  	 * jump is backtracked, vector of six 10-bit records
>  	 */

Was LR_FRAMENO_BITS in kernel/bpf/verifier.c intended to remain at 3 bits?

The linked_regs packing uses LR_FRAMENO_BITS to encode frame numbers:

    #define LR_FRAMENO_BITS    3
    #define LR_FRAMENO_MASK    ((1ull << LR_FRAMENO_BITS) - 1)

With MAX_CALL_FRAMES now at 16, frame numbers can be 0-15, but the 3-bit
mask (0x7) will truncate frames 8-15:

    collect_linked_regs():
        for (i = vstate->curframe; i >= 0; i--)
            __collect_linked_regs(linked_regs, reg, id, i, j, true);
                                                       ^
                                                frameno can be 0-15

    linked_regs_unpack():
        e->frameno = val & LR_FRAMENO_MASK;
                          ^^^^^^^^^^^^^^^^^
                          mask is 0x7, truncates 8-15

This means frame 8 becomes 0, frame 9 becomes 1, etc., causing
sync_linked_regs() to update registers in the wrong stack frame during
precision backtracking.

The comment at linked_regs_pack() still documents "3-bits frameno" which
now conflicts with the 16-frame limit.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21610711856

AI-authorship-score: low
AI-authorship-explanation: The commit follows standard kernel conventions with concise technical language; the oversight of LR_FRAMENO_BITS is characteristic of human error rather than AI-generated code which would typically catch all related constants.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: LR_FRAMENO_BITS remaining at 3 bits causes frame number truncation for frames 8-15, leading to incorrect precision tracking in the verifier which could cause incorrect program acceptance or rejection.

--===============4518992147532936599==--
