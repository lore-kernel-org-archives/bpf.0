Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90791F131A;
	Wed,  4 Mar 2026 03:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772596255; cv=none; b=qTpC+7fHC1iPBTYIf9hRbhRBU82WrNJ1+MAgwziQCMJVZS02GbtMHgFoUL0nHyyyqaOr28opwvrE1W4oM+of7Q+IJqDbgiPEzbfQaLRRM3bLPyeEfSvC2ZpxZ6iMINFVspYnBPCW8btpGF7LZbGpk5agoP//pVf+cgO8qerOWQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772596255; c=relaxed/simple;
	bh=ssyrvWLOeENTXQ0PnbBkM8vPG9r41B/xlAWkb839LMQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IptrF5KlJfEO04hdyb87z0mVBZ27dpjLiF53ylUSTtsIIE03G2S8KGhVKwFtp67JL/XOpRyDeSk9wU9AFO3/DicG2mQc3i3WMZUqM6UGboobOpoTEJzM5F7+ohAm+qX+ukcrF3dECGdD5z4hArdvGXrBnBQIPQH+G/IUFyRmKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYLbak4L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYLbak4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007A5C19423;
	Wed,  4 Mar 2026 03:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772596255;
	bh=ssyrvWLOeENTXQ0PnbBkM8vPG9r41B/xlAWkb839LMQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BYLbak4Lo7C5Vr7if3CMmKRtJDpXx2SrQG7efwJLVa6ZGIN2svGpR4Lym4p/a/Ssr
	 BiR4UudjXwRGgcKbXnFssmjTUbQPKUi+Y7dSKX2fR4ZWqaDS2UHpuuoAZ0roTgFd+o
	 5vjqLePTqVf+HQSbELwzaAKNOlKhCrbZFb1N2SPRGSaqDlxONTsmMpFFdyVWAGXxHl
	 u+u0WkTuyDmHmgmSIpF50w/Sg/XVkl+JDXe2LF7zkHbXxPIPVUhgTjz/uaYSq1WY3b
	 bIi8ahby42jVSymVKCwF1aefpEc6M7o08kUz/8ZeTRNRrKIQirgU0q3ucZ39xKnxm3
	 OXLoqsRFidYug==
Content-Type: multipart/mixed; boundary="===============8003559126966592615=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <272e6aa8c6be8933c8440a19f3101f26f8ca76712620ed01a78f3dc748ecc519@mail.kernel.org>
In-Reply-To: <20260304031606.43884-4-pilgrimtao@gmail.com>
References: <20260304031606.43884-4-pilgrimtao@gmail.com>
Subject: Re: [PATCH v5 3/6] bpf: add bpf_list_add_impl to insert node after a given list node
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 03:50:54 +0000 (UTC)

--===============8003559126966592615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add a new kfunc bpf_list_add_impl(head, new, prev, meta, off) that
> inserts 'new' after 'prev' in the BPF linked list. Both must be in
> the same list; 'prev' must already be in the list.

"Both must be in the same list" reads as though new and prev are
both already present in the list, but the code requires new to have
owner == NULL (via the cmpxchg check), meaning new must not be in
any list.  Would something like "prev must already be in the list
headed by head" be clearer here?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -23195,13 +23200,15 @@ struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
>  		*cnt = 3;
>  	} else if (desc->func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
>  		   desc->func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> +		   desc->func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
>  		   desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>  		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
>  		int struct_meta_reg = BPF_REG_3;
>  		int node_offset_reg = BPF_REG_4;
>
> -		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
> -		if (desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
> +		/* They has extra arg, so args-to-fixup are in diff regs */
                   ^^^^^^^^

"They has" should be "They have" or "These have".

The original comment also explained why the extra arg exists
(rbtree_add has a 'less' callback).  Could this be updated to
mention both cases, e.g. "list_add_impl and rbtree_add_impl have
an extra arg (prev / less), so args-to-fixup are in different
regs"?

> +		if (desc->func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
> +		    desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>  			struct_meta_reg = BPF_REG_4;
>  			node_offset_reg = BPF_REG_5;
>  		}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22653666378
--===============8003559126966592615==--
