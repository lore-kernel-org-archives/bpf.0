Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F438D41A
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729869; cv=none; b=euH/grEn/JO1xFhPLiyPGA5ivJ2QPXmUUm9LyOadag7K4EM4FoFrAoHNkGn/fJxWYd+xgM9WKi18taIjST4wGz2n2InP+olMVA8LfiAEW4nzM+xVumB6f/P/chtsT7FNsXSR1IclnDiiQTj9tISCNjaSVcqUf2F/H9TlzgeKtBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729869; c=relaxed/simple;
	bh=8KBgAdWMpNP+Q9cpUh714IVOgHG9AVuzjBPAMjo91eA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eEpkUgth6PoM7yOGyNMQ827gPOP0WM0M3us6qdUHJBq4yeKL5kbOhbXp1BvzVWKfEv1ZmoqEs2oWKyTvBItHXNQ5QmDCMNKBe7doBenvLixpKI8He2nQdH8uCstRT/s1ixqb20mh3+YLn7TK/RXfhrs9wV1repiDPF4xX4xMwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpbESnk9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpbESnk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C101F00A3E;
	Wed, 17 Jun 2026 20:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781729868;
	bh=zSTSTzCXDaDo/0f1PZAcFA2/uZ+Z9F3gNJddueTYy+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fpbESnk95R9PSwYHTKWu/BFvYcr8+NypWuh56Fss0u9mm/rUORz25zWctOUn03v07
	 X5Kwdww5jKxvq5s2gzDU+1trdawGxNpNBurSoBJReMIlJ1VzzsZ2l6Mrv1dYhY/pmd
	 JHr6DrlaQwMcmu2S5TI12irVy27VEdtlCR+JlBx1pDxj9Z9JAEgjRWO0eM+Dq81Ob7
	 QDxuSn0S9p29UxiVcYLzu6Gx/eRInN3uclpXcTzZ/eZZI4WWK138psDMeZvwTDdjwr
	 /yb8YDPz1QamhfxFXL8+JWoZRXkvd/drhAh9HVZQyhMPQpyu2wYYBshXGlRnNSgkz5
	 byCKW+lGD9RPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/bpf_memcontrol: mark BPF memcg kfuncs static
Reply-To: sashiko-reviews@lists.linux.dev
To: "JP Kobryn" <jp.kobryn@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260617202147.78347-1-jp.kobryn@linux.dev>
References: <20260617202147.78347-1-jp.kobryn@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:57:47 +0000
Message-Id: <20260617205747.D8C101F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The kfunc `bpf_mem_cgroup_memory_events` lacks a negative bounds c=
heck for its enum parameter, allowing an out-of-bounds array read.
- [High] The kfunc `bpf_mem_cgroup_vm_events` uses a signed enum parameter =
without a negative bounds check, leading to an out-of-bounds array read.
--

commit 69ebb23c6ec72d0bfb8ea52e71248a3737fbb2f4
Author: JP Kobryn <jp.kobryn@linux.dev>

mm/bpf_memcontrol: mark BPF memcg kfuncs static

The patch marks kfuncs in bpf_memcontrol.c as static since they are only
referenced by BPF programs and resolved through BTF. This removes unnecessa=
ry
external linkage for these functions.

Closes: https://lore.kernel.org/oe-kbuild-all/202606150332.Xy4Egd9s-lkp@int=
el.com/

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d76477..eff79bb2c7581 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> @@ -89,8 +89,8 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *=
memcg)
>   *
>   * Return: The current value of the corresponding events counter.
>   */
> -__bpf_kfunc unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *me=
mcg,
> -						   enum vm_event_item event)
> +__bpf_kfunc static unsigned long
> +bpf_mem_cgroup_vm_events(struct mem_cgroup *memcg, enum vm_event_item ev=
ent)
>  {
>  	if (unlikely(!memcg_vm_event_item_valid(event)))

[Severity: High]
This is a pre-existing issue, but does memcg_vm_event_item_valid()
adequately check for negative values?

Since the BPF verifier does not validate enum ranges, the event argument
could be negative. Looking at memcg_vm_event_item_valid() in
mm/memcontrol.c, it checks:

    if (idx >=3D NR_VM_EVENT_ITEMS)
        return false;

Because both operands are signed, negative values bypass the check.

Can this lead to an out-of-bounds read when the negative index is
eventually passed to memcg_events(memcg, event)?

>  		return (unsigned long)-1;

[ ... ]

> @@ -122,8 +122,8 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct=
 mem_cgroup *memcg)
>   *
>   * Return: The current value of the memory event counter.
>   */
> -__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup=
 *memcg,
> -						       enum memcg_memory_event event)
> +__bpf_kfunc static unsigned long
> +bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg, enum memcg_memory=
_event event)
>  {
>  	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))

[Severity: High]
This isn't a bug introduced by this patch, but does this bounds check
handle negative values properly?

Because the event parameter is a signed enum and the BPF verifier allows
arbitrary integers for enum arguments, a negative value bypasses the
event >=3D MEMCG_NR_MEMORY_EVENTS check.

Can this result in an out-of-bounds read when accessing
&memcg->memory_events[event] right below?

>  		return (unsigned long)-1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617202147.7834=
7-1-jp.kobryn@linux.dev?part=3D1
