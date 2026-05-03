Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBF3296BBA;
	Sun,  3 May 2026 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777829720; cv=none; b=qwdW/68HBouNyFwU+nxAHdwY4p2z/SySEd9CsSAn75kUa2MyiuErMb76197/Ew7CkOW57oHhFIFAKgjIkl8rXBqtBATwXLNLTjBtYD3Di35pD8p5WQBVshEchbBE27ykAtXpiFSXqEpVW6C9TTBhxTNdMu7ZDeHp3XzglkqmDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777829720; c=relaxed/simple;
	bh=CdlmhbfZE6Tu9vJOU5Y1P7jHBS+VbmaeGREcszsgiNc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bw5Lm7xuqPRn1tyI4vP4nZ3wJU5RpRpBnGq6aCqPno83Am0JzdUoNxm/4I437EL/3Eulb4wgh2/k5QvjnHOGPWVZMQh6wzr9hNwiIyyXvKQ9ER8YLNWI5wotXWsjPv5+qeJ5fjgvk6Kg5k2lDnGjPhBZUA5sovehsFWiSsOH1m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/qnPCnN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/qnPCnN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FABC2BCB4;
	Sun,  3 May 2026 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777829720;
	bh=CdlmhbfZE6Tu9vJOU5Y1P7jHBS+VbmaeGREcszsgiNc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=r/qnPCnNeJ+NKDnTJ7j57PzGW896Y7T83OKbIbQf6UnyOnTNsW8ZD1RqqmoikZD0+
	 ZUCzaK8YhhWNN+a+sxtY7K0+9da4zzaKRoMkYf9FN5xX0PYdutbEoznDtDBJBCU36O
	 A7JCXoo9e3w9f3uVolU20piDR053kkYiXYKrjBEB0GEQwCv71TkHRpknUXboJJq+dJ
	 MMixH8bkgBGpjJw2mpdMZVJBlIAk65ij0MhISd9Y2pe0Gc5Fd+UJye+AY71g1nsrvt
	 6dzIzxw+1nrRLcdwu2FKi9yTtjv+WyJFFNegYyzGLfBD+srQFNtorNmQjPhHnitovT
	 Rfyy1oD5APRTw==
Content-Type: multipart/mixed; boundary="===============5550520783914532141=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a74b6b1d137439121917216ef386bbab9107afcc89819d1fd94e389b8c54b4f1@mail.kernel.org>
In-Reply-To: <20260503165024.1526680-4-vernon2gm@gmail.com>
References: <20260503165024.1526680-4-vernon2gm@gmail.com>
Subject: Re: [PATCH 3/4] mm: introduce bpf_mthp_ops struct ops
From: bot+bpf-ci@kernel.org
To: vernon2gm@gmail.com,akpm@linux-foundation.org,david@kernel.org,ljs@kernel.org,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,ast@kernel.org,daniel@iogearbox.net,surenb@google.com
Cc: linux-kernel@vger.kernel.org,linux-mm@kvack.org,bpf@vger.kernel.org,baohua@kernel.org,lance.yang@linux.dev,dev.jain@arm.com,yanglincheng@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  3 May 2026 17:35:18 +0000 (UTC)

--===============5550520783914532141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_huge_memory.h b/include/linux/bpf_huge_memory.h
> new file mode 100644
> index 000000000000..1c8a6f7ad8f1
> --- /dev/null
> +++ b/include/linux/bpf_huge_memory.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __BPF_HUGE_MEMORY_H
> +#define __BPF_HUGE_MEMORY_H
> +
> +/**
> + * struct bpf_mthp_ops - BPF callbacks for mTHP operations
> + * @mthp_choose: Choose the custom mTHP orders
> + *
> + * This structure defines the interface for BPF programs to customize
> + * mTHP behavior through struct_ops programs.
> + */
> +struct bpf_mthp_ops {
> +	unsigned long (*mthp_choose)(struct cgroup *cgrp, unsigned long orders);
> +};
> +
> +#if defined(CONFIG_BPF_TRANSPARENT_HUGEPAGE) && defined(CONFIG_BPF_SYSCALL)
> +/**
> + * bpf_mthp_choose: Choose the custom mTHP orders using bpf
                      ^
The kernel-doc format for functions uses parentheses followed by a dash, not
a colon. When scripts/kernel-doc processes this file, will it skip this
function documentation?

> + * @mm: task mm_struct
> + * @orders: original orders
> + *
> + * Return suited mTHP orders.
> + */

[ ... ]

> diff --git a/mm/bpf_huge_memory.c b/mm/bpf_huge_memory.c
> new file mode 100644
> index 000000000000..e34e0a35edac
> --- /dev/null
> +++ b/mm/bpf_huge_memory.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Huge memory related BPF code
> + *
> + * Author: Vernon Yang <yanglincheng@kylinos.cn>
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/srcu.h>
> +
> +/* Protects cgrp->mthp_ops pointer for read and write. */
> +DEFINE_SRCU(mthp_bpf_srcu);
> +
> +unsigned long bpf_mthp_choose(struct mm_struct *mm, unsigned long orders)
> +{
> +	struct cgroup *cgrp;
> +	struct mem_cgroup *memcg;
> +	struct bpf_mthp_ops *ops;
> +	int idx;
> +
> +	memcg = get_mem_cgroup_from_mm(mm);
> +	if (!memcg)
> +		return orders;
> +
> +	cgrp = memcg->css.cgroup;
> +	ops = READ_ONCE(cgrp->mthp_ops);
                ^^^^^
> +	if (unlikely(ops)) {
> +		idx = srcu_read_lock(&mthp_bpf_srcu);
                      ^^^^^^^^^^^^^^^^^
Could there be a use-after-free here? The pointer is read BEFORE entering
the SRCU read-side critical section. If bpf_mthp_ops_unreg runs on another
CPU between these two lines, synchronize_srcu returns immediately because
no reader holds the lock yet.

Race sequence:
(1) Thread A loads ops (non-NULL) above
(2) Thread A is preempted
(3) Thread B calls bpf_mthp_ops_unreg, clears the pointer, calls
    synchronize_srcu which returns immediately
(4) Thread B frees the backing memory
(5) Thread A resumes, enters SRCU section, then dereferences ops->mthp_choose

For SRCU to protect the pointer across its use, the reader must hold
srcu_read_lock before reading the pointer. Would moving the srcu_read_lock
before the READ_ONCE prevent this race?

> +		if (ops->mthp_choose)
> +			orders = ops->mthp_choose(cgrp, orders);
> +		srcu_read_unlock(&mthp_bpf_srcu, idx);
> +	}
> +
> +	mem_cgroup_put(memcg);
> +
> +	return orders;
> +}

[ ... ]

> +static int bpf_mthp_ops_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *st_link = (struct bpf_struct_ops_link *)link;
> +	struct bpf_mthp_ops *ops = kdata;
> +	struct cgroup *cgrp = st_link->cgroup;
                                ^^^^^^^^^^^^
Can this dereference NULL? When bpf_struct_ops_map_update_elem calls the
reg callback at kernel/bpf/bpf_struct_ops.c:873, it passes link = NULL for
maps without BPF_F_LINK. When link is NULL, st_link->cgroup dereferences
NULL before the check at the next line runs.

> +	struct cgroup_subsys_state *pos;
> +
> +	/* The link is not yet fully initialized, but cgroup should be set */
> +	if (!link)
> +		return -EOPNOTSUPP;

Does this comment match reality? Looking at bpf_struct_ops_link_create in
kernel/bpf/bpf_struct_ops.c:1397, the link was fully initialized by
bpf_link_init and bpf_link_prime before calling reg. Also, struct
bpf_struct_ops_link does not have a cgroup field in its definition at
kernel/bpf/bpf_struct_ops.c:58.

Also, does struct bpf_struct_ops_link actually have a cgroup field? Its
definition shows only { struct bpf_link link; struct bpf_map __rcu *map;
wait_queue_head_t wait_hup; }. The patch does not add this field to the
struct. Would this cause a compilation error?

> +
> +	cgroup_lock();
> +	css_for_each_descendant_pre(pos, &cgrp->self) {
> +		struct cgroup *child = pos->cgroup;
> +
> +		if (READ_ONCE(child->mthp_ops)) {
> +			/* TODO
                    ^^^^^
This isn't a bug, but per BPF comment style (subsystem/bpf.md), multi-line
comments should have the opening /* on its own line in BPF-related files.

> +			 * Do not destroy the cgroup hierarchy property.
> +			 * If an eBPF program already exists in the sub-cgroup,
> +			 * trigger an error and clear the already set
> +			 * bpf_mthp_ops data.
> +			 */
> +			continue;
> +		}
> +		WRITE_ONCE(child->mthp_ops, ops);
> +	}
> +	cgroup_unlock();
> +
> +	return 0;
> +}
> +
> +static void bpf_mthp_ops_unreg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *st_link = (struct bpf_struct_ops_link *)link;
> +	struct bpf_mthp_ops *ops = kdata;
> +	struct cgroup *cgrp = st_link->cgroup;
                                ^^^^^^^^^^^^
Can this dereference NULL? Looking at bpf_struct_ops_map_delete_elem in
kernel/bpf/bpf_struct_ops.c:936, it calls unreg with link = NULL. When
link is NULL, st_link->cgroup dereferences NULL.

> +	struct cgroup_subsys_state *pos;
> +
> +	cgroup_lock();
> +	css_for_each_descendant_pre(pos, &cgrp->self) {
> +		struct cgroup *child = pos->cgroup;
> +
> +		if (READ_ONCE(child->mthp_ops) == ops)
> +			WRITE_ONCE(child->mthp_ops, NULL);
> +	}
> +	cgroup_unlock();
> +
> +	synchronize_srcu(&mthp_bpf_srcu);
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25285279315
--===============5550520783914532141==--
