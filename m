Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A9F32F75B;
	Wed, 14 Oct 2026 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946442; cv=none; b=bylnP8EZerMZkcGIcmX1YMhcAcDWAte5L3HrFu3j8SndMQTtWqQGNQGvo52+sEeEdon9C7TCrqodvcmneGCnoXnp4dx0+plL3RxXMbm2M7YEzdtdEFztl5auMRAxS9A5nC3bIXOTJvOgpqVt+cJoB49AAd4I6Em+P7E3RgH0veA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946442; c=relaxed/simple;
	bh=UOUMOjQCN34mEMkC15zOKtQhiGH8pPrI/2Hy8y06+LI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GT2lfXwIlWEMTxs8yQlWSlo8mJESsSeSaKyLNjRsbuu3q5OXf162SG+nioB5BjhHsKWScJOLCjLQqMts4W32WlwwLTm0Jy0RjkWK1f47t9sigKF71SkP2JXJLMw0pCGQfXz4fW+J+6tukUjfe+SUdu3kIVSJd/GzYHgoP2nYAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mugsJNRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mugsJNRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4B51F00893;
	Wed, 14 Oct 2026 02:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791946441;
	bh=z/36UB7zLZVKfT7/izGBmFoBpzWxmAReGZgGNu4qmXk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mugsJNRLnJaf2w3ynSpKL9ypOP8bS2lAQgEjSoSxtF+PaJqFbnVa0vjX2QNRY3NRE
	 Iap1lQY71KCZjLMhaxAtLVpzMCn/my8g0RCxWFjP29QuxMKWGVlOeiY1km+u8Z4qXV
	 wH+hQcvVId3PGsz4t7LP7lZzBI5k8/hxQpuBodNNkjnIblwwZQK5i853M5hVofjGr9
	 Gzvu3aCiCW8k16ZwDBF9XZHEuQC/LVN1KflZF1nmmPVeQE7lAJQJy6QIH2OIBAS6ss
	 LjILXK3H2P080adjGcjHttNBXh85wUExQ7ELccxO93tJxY8+qOb3i7VzsX5VHB40vH
	 dMd6VKK2kgz2g==
Content-Type: multipart/mixed; boundary="===============7992559996201943304=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f8c821cc97a2e46cae72802b781429ebbc0e6c4213c6f93e586b77255fa2abf5@mail.kernel.org>
In-Reply-To: <20261013-fix-lru-node-type-kcsan-v1-1-0b743f5af2f3@gmail.com>
References: <20261013-fix-lru-node-type-kcsan-v1-1-0b743f5af2f3@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Annotate data races on bpf_lru_node type
From: bot+bpf-ci@kernel.org
To: nicholasfvelten@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,syzbot+1ea4f564bf6f1f3d1dc4@syzkaller.appspotmail.com,nicholasfvelten@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 14 Oct 2026 02:53:59 +0000 (UTC)

--===============7992559996201943304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Annotate data races on bpf_lru_node type

TL;DR: Commit message only: it may be inaccurate about the locking for the
node->type writes, and "the sanity check only feeds a warning" is questionable
since the check also causes an early return.

> bpf: Annotate data races on bpf_lru_node type

[ ... ]

> node->type is written under the global l->lock when a node moves between
> the active, inactive and free lists, and under the per-CPU loc_l->lock
> when it moves to or from a local list. It is read in two places that do
> not hold the lock the writer holds:

The commit message says node->type is written under the per-CPU
loc_l->lock when it moves to or from a local list.  Is that complete for
the writers this patch converts to WRITE_ONCE()?

The failure path in bpf_common_lru_pop_free() writes node->type after
taking loc_l->lock has failed:

kernel/bpf/bpf_lru_list.c:bpf_common_lru_pop_free() {
    ...
	if (raw_res_spin_lock_irqsave(&loc_l->lock, flags)) {
		/* ... */
		WRITE_ONCE(node->type, BPF_LRU_LOCAL_LIST_T_FREE);
    ...
}

so no lock is held for that write.  Could the commit message mention
that this write is safe because the stolen node is not on any list and
is owned by the current CPU at that point?

[ ... ]

> Both races are benign: the type is a single byte, the sanity check only
> feeds a warning, and the re-check exists precisely because the value can
> change concurrently (any change sends the node down the check_lru_list
> path, which revalidates under l->lock). Mark the two reads with

Is "the sanity check only feeds a warning" accurate?  In
bpf_lru_list_push_free() the WARN_ON_ONCE() condition also controls an
early return:

kernel/bpf/bpf_lru_list.c:bpf_lru_list_push_free() {
    ...
	if (WARN_ON_ONCE(IS_LOCAL_LIST_TYPE(READ_ONCE(node->type))))
		return;
    ...
}

so the racy value affects control flow and not only the warning.

Would it be more precise to say the race is benign because a concurrent
writer can only store BPF_LRU_LIST_T_ACTIVE or BPF_LRU_LIST_T_INACTIVE
for a node being pushed free, so IS_LOCAL_LIST_TYPE() gives the same
result for any value the read can observe?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38500297852
--===============7992559996201943304==--
