Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80A3769FE;
	Mon,  1 Jun 2026 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296280; cv=none; b=Ma9NbPMHN0bOukze9t7FqoZ8wYDVioC6IKODCEcVv9ijUEJJ/yhU89J8HNYygucUHHfjOJN4jxeVzFSSungPBX2ERL6bxHCjaMUnimRHV1gR+bbk6fWlj1Rs520oV/cplwcheRtk3dcW3YLUSYZcUHqp1CGQRuhrnu5hY7MF914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296280; c=relaxed/simple;
	bh=ttQUf+905huvcZpWtMaS+slgotKVrs76Us+19mc7mlU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iMuYlMfHgabcwoB64unCC8gFO3X4Pp+7fEMRNwHU2hPP9RxjXN8aAEDvJlZsU4ahwWzPZJVSDWv3gfJU0ps8kjjgZ2NKYXA3LFZ36MBK/KBlE1CF2grtb68VSoPnX2csKCa1MAXQuobe6Zd/l841+B2A6fTzhN4BUbHCQge5FPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl8KaTYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl8KaTYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A397D1F00893;
	Mon,  1 Jun 2026 06:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780296278;
	bh=zfsGHuWuFTv1Cjd1l5nguThlUkiEd3QUifwDoadeDfw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Fl8KaTYSmsmiHMDvhhqROgmziV6pVWnmUAFN7nwzw6FuZ1ZAvqxDCvaX6Kp9BiSrw
	 Tx4l9o/B8Rm3Ve6eX/tZXsc6ta+82pDSzJQK+FOPsSJL/hOfTceuC5cpvsnZysejpr
	 iU89/n60E3z0LQ+Ww3qAzzpeG8nkiE6Z2iB9snwZD+nFt2xHCW/JJKJ+61PvCdrnJ5
	 C0czBINHjaTfrTn4+lz9IKmrQLJwofpHNjy9enWVUof3DS6z/mSG5GhRAmV4K0eMBg
	 6Dv2wlTFukrhp02AzXZk3xcNiVetc7TY+507Om3drSIZplqTPWfKjCQ/SOOtpodzNo
	 0spuDbxO0oayA==
Content-Type: multipart/mixed; boundary="===============5260575393648563333=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e0d90b33c6a5bd8323a919e4552862dd2b6b0cf99648b63c0ebf3ed37bb45774@mail.kernel.org>
In-Reply-To: <20260601055859.13888-1-kaitao.cheng@linux.dev>
References: <20260601055859.13888-1-kaitao.cheng@linux.dev>
Subject: Re: [PATCH] bpf: Clear rb node linkage when freeing bpf_rb_root
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org
Cc: davemarchevsky@fb.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,chengkaitao@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  1 Jun 2026 06:44:38 +0000 (UTC)

--===============5260575393648563333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9ca195104667..46e8eada463b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2307,22 +2307,30 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>  {
>  	struct rb_root_cached orig_root, *root = rb_root;
>  	struct rb_node *pos, *n;
> -	void *obj;
>
>  	BUILD_BUG_ON(sizeof(struct rb_root_cached) > sizeof(struct bpf_rb_root));
>  	BUILD_BUG_ON(__alignof__(struct rb_root_cached) > __alignof__(struct bpf_rb_root));
>
>  	__bpf_spin_lock_irqsave(spin_lock);
>  	orig_root = *root;
> +	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
> +		struct bpf_rb_node_kern *node;
> +
> +		node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
> +		WRITE_ONCE(node->owner, BPF_PTR_POISON);
> +	}
>  	*root = RB_ROOT_CACHED;
>  	__bpf_spin_unlock_irqrestore(spin_lock);

Since there is no verifier-enforced limit on the number of nodes in a BPF
rbtree, could this O(N) post-order traversal trigger latency spikes, RCU
stalls, or NMI watchdog lockups?

This loop runs inside the __bpf_spin_lock_irqsave() critical section, which
disables local interrupts.

Additionally, since rb_first_postorder() and rb_next_postorder() are exported
and traceable, if an fentry/fexit BPF program is attached to them and attempts
to acquire the same bpf_spin_lock, will it cause a hard deadlock?

(from review discussion at
https://lore.kernel.org/bpf/20260601061503.EFD881F00898@smtp.kernel.org/)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26738658508
--===============5260575393648563333==--
