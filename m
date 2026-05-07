Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351D372B58
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179410; cv=none; b=f2NGX1MVn4DNrx94LoKn8zyIEJmGoQyY2zxmwypuIfCMcbeOvyYs7jKabw+tWqz2gGmpihF4uixdqni1nCg44YMXeh3bElDGPwS2QGzu79DuTTePMRsYU6pfdqHT+ze/dibbdiNL2/xe6tSnfDsF9c6novWVJmw2Gb0c1aB1R6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179410; c=relaxed/simple;
	bh=7ShwUQBeDfB2CqUpWF1c0vV2uQ4zUMuBcahcXqr9kXA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=niik62zlzMg1IiHtRKs67m2FKVCs+84Gle2X6iSgOmafML+9sZeRZSZPGPDl13RChmuaUOBlUrlyZu20eAwjueqz9B48t9C3T0wu6pf00zyyiG8EjJsGErqeHJpfQzJmNVDGjMK7+QumAa7JZAbH0xAA81GModc6GdCvMDWhkWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2Udz215; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2Udz215"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E9CC2BCB2;
	Thu,  7 May 2026 18:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778179410;
	bh=7ShwUQBeDfB2CqUpWF1c0vV2uQ4zUMuBcahcXqr9kXA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=O2Udz2151qsrnc6F5WDJI+vsDCIcsUIVPZdVKr/A7qoStfxj0xJ07dnEyBhb2Z4Is
	 oQV4u5Yk6w+9NP9SDQMLmw/Y5+Q57Qq/3XeIcEj1aFHfkuz+biGjsN9812eNsFulKF
	 /kpOR+r5S5EfBgqnxoWh2zbG7W6nU+k54iU2AtvCQ7BBD0KxX4JjFDzC55VarB2iEN
	 as7+pOpItsZPRrfDqQleAq25CqPs1JUqxdEZ8tBa5vIlzK7Pjcj9MGVhHEoj6q6Usx
	 J+5DByMbHgR92TbQ7K58rZmiH6ZYkO0Mivs/p0BujhrODyVHBYhaU6gdiKpEw2dtRI
	 nhONRxdLkhjvA==
Content-Type: multipart/mixed; boundary="===============4967670250085774504=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <77bd1e436e9b8a4679a4e60adf5971f93688ff28ad0a9b16a0adf2b8172dd116@mail.kernel.org>
In-Reply-To: <20260507175453.1140400-2-utilityemal77@gmail.com>
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bpf@vger.kernel.org,utilityemal77@gmail.com,mykyta.yatsenko5@gmail.com,alexei.starovoitov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  7 May 2026 18:43:29 +0000 (UTC)

--===============4967670250085774504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h

[ ... ]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c

[ ... ]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3b1f0ba02f61..d34fdb99eb8a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -7,6 +7,7 @@
>  #include <linux/bpf_trace.h>
>  #include <linux/bpf_lirc.h>
>  #include <linux/bpf_verifier.h>
> +#include <linux/bpf_mem_alloc.h>
>  #include <linux/bsearch.h>
>  #include <linux/btf.h>
>  #include <linux/hex.h>
> @@ -19,6 +20,7 @@
>  #include <linux/fdtable.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/irq_work.h>
>  #include <linux/license.h>
>  #include <linux/filter.h>
>  #include <linux/kernel.h>
> @@ -42,6 +44,8 @@
>  #include <linux/cookie.h>
>  #include <linux/verification.h>
>
> +#include "percpu_freelist.h"
> +
>  #include <net/netfilter/nf_bpf_link.h>
>  #include <net/netkit.h>
>  #include <net/tcx.h>
> @@ -65,6 +69,111 @@ static DEFINE_SPINLOCK(map_idr_lock);
>  static DEFINE_IDR(link_idr);
>  static DEFINE_SPINLOCK(link_idr_lock);
>
> +struct bpf_dtor_kptr_work {
> +	struct pcpu_freelist_node fnode;
> +	void *obj;
> +	btf_dtor_kfunc_t dtor;
> +};
> +
> +/* Queue pending dtors; the idle pool uses a global pcpu_freelist. */
> +static struct pcpu_freelist bpf_dtor_kptr_jobs;
> +static struct pcpu_freelist bpf_dtor_kptr_idle;
> +/* Keep surplus = total - needed = idle - refs >= 0 so NMI frees never need to allocate. */
> +static atomic_long_t bpf_dtor_kptr_surplus = ATOMIC_LONG_INIT(0);

An unaddressed review comment from the v2 discussion raises a design
concern about the complexity of this implementation. Mykyta Yatsenko
suggested an alternative design where bpf_dtor_kptr_work is stored in the
kptr map slot itself (a bpf_kptr_box approach) instead of using two lists
(idle and armed) with 3 atomics and headroom/trimming management.

From the lore discussion at:
https://lore.kernel.org/bpf/51a054a0-e57f-49dc-9527-36da0535087c@gmail.com/

Mykyta's suggestion was:

"I think this still looks too complex:
 * 2 lists - idle list and armed list
 * 3 atomics, controlling demand/supply
 * headroom/trimming management

The complexity introduced for performance reasons, but I'm not sure if
the tradeoff is worth it.

What about the next design:

Instead of idle list, store bpf_dtor_kptr_work in the kptr map slot
itself. Use kmalloc_nolock() to allocate bpf_dtor_kptr_work on the first
xchg just once per map value, then reuse it across xchg in/out."

While Justin responded with an explanation of ABBA ordering issues, and
Mykyta provided a more detailed counter-proposal with RCU protection and
atomic detach/attach, the v3 implementation does not adopt this
suggestion and still uses the pcpu_freelist approach with a surplus
counter.

Was there a specific technical reason to continue with the two-list
approach rather than exploring the bpf_kptr_box alternative, or would it
be worth revisiting this design choice?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c

[ ... ]

This commit fixes a deadlock bug but lacks a Fixes: tag. The bug was
introduced in commit 14a324f6a67e ("bpf: Wire up freeing of referenced
kptr") which added bpf_map_free_kptrs() that calls kptr destructors
inline without checking for NMI context.

When BPF programs attached to tp_btf/nmi_handler delete map entries,
destructors like bpf_cpumask_release() that take RCU locks are called
from NMI, causing system deadlock.

Suggested: Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25513277524
--===============4967670250085774504==--
