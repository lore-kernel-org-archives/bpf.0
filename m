Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CE83AE1B1
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807595; cv=none; b=q8nYPaUudJLLl1DGm9fRSni7GcvtaGNdFrEwuqqRP84SAGfc9LoM95dNPfhJ+byQTPStBXP4GsIn/GRB2/wFw4Br2KDtHgWeFQzJzwa145BUs+L1WFckOOVtXc9qrIguS0yRYsssBCgh6FvClGRzliE/YVYS/Eq0jL1Fylzs5Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807595; c=relaxed/simple;
	bh=+evz7hnDCORarFj6m+SPxacj0Eduaq/1rN3NYXRbEXw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WRODyzWfJK5InNh87kkRiAYEzZneXqcvzcQ2YaItlYpLRv0tQV/lH9wPb9iUy5bjP+0pnRSczEolMg3H+JysNHMM9kMACQqXDHc3nY0nIT2bfdehSWsE+Bxq72yCWhzcwIiTiTm8idsQYJxY7nwt/oNJgs5sFJeFfVBKgf3Kfr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTNK+m99; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTNK+m99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF601F0089B;
	Mon, 12 Oct 2026 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791807593;
	bh=WZn3e+ZvTYijT+k8bU14G/QxUPwn5O+XbYuy8YlsFuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nTNK+m99QXpOo2xoK1c2bhfeaqzEkdO07xDYNHBQSsCaqSGtxC1I588LO1KiStyP1
	 yZpK/8ktD5sU1nOOKj7J3fV8Apq13+qd7rNVPAXmAzHBSznsCwwuJwTzqKw+0lPDEU
	 7sGBA/SvWOoT7MDB5gg5XwxJyAfxYj0ewC1WQ8XPHnzsGeFa7mf77vKC1UXPURjqJ4
	 8arG6NboRSiZiRkeYy0jViXiuY0o3AyKMZHE9CRwcaxAv2Nhjtj2Nv7sb1SykszrEK
	 it3WnG2RT2vPVn31dmx99WOQI3CwS8wBrCn2Fkp9kS6jh2VRf4omcE/Z+gPzE0J+SW
	 BvR1KA/Hn0YVw==
Message-ID: <sashiko-outbox-168087@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/3] sched: add helpers for numa balancing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, tj@kernel.org
In-Reply-To: <20261012120438.52849-2-laoar.shao@gmail.com>
References: <20261012120438.52849-1-laoar.shao@gmail.com>
 <20261012120438.52849-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 12:19:52 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] sched: Incomplete refactoring leaves direct sched_numa_balancing=
 accesses
- [Low] sched: performance regression in task_numa_fault() due to incorrect=
 static branch hint
--

commit 6333e53c9f6ee67bda34cc209d9f45e01a0af5fd
Author: Yafang Shao <laoar.shao@gmail.com>

    sched: add helpers for numa balancing
   =20
    Two new helpers task_numab_enabled() and numab_mode_tiering() are
    introduced to replace the scattered direct accesses to the
    sched_numa_balancing static key and the sysctl_numa_balancing_mode
    bitmask.

> diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/n=
uma_balancing.h
> index 52b22c5c396db..353772b49c5f9 100644
> --- a/include/linux/sched/numa_balancing.h
> +++ b/include/linux/sched/numa_balancing.h
> @@ -32,6 +33,28 @@ extern void set_numabalancing_state(bool enabled);
>  extern void task_numa_free(struct task_struct *p, bool final);
>  bool should_numa_migrate_memory(struct task_struct *p, struct folio *fol=
io,
>  				int src_nid, int dst_cpu);
> +
> +extern struct static_key_false sched_numa_balancing;
> +
> +/*
> + * Whether NUMA balancing applies to @p.  The @p argument is unused for
> + * now: a later patch will consult a per-cgroup BPF policy with it.
> + */
> +static inline bool task_numab_enabled(struct task_struct *p)
> +{
> +	return static_branch_unlikely(&sched_numa_balancing);
> +}

[Severity: Low]
Does this wrapper unintentionally flip the branch prediction hint from
likely to unlikely on hot paths?

For instance, task_numa_fault() is almost exclusively called from NUMA
hinting fault handlers, which only trigger when NUMA balancing is active.
Before this patch, it used static_branch_likely():

-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!task_numab_enabled(p))

Because the new task_numab_enabled() wrapper hardcodes
static_branch_unlikely(), could the compiler now outline the body of
task_numa_fault() and other functions that expect the condition to usually
be true?

[ ... ]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c52c29dcb6a2e..451e26da5af24 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4199,7 +4200,7 @@ void task_numa_fault(int last_cpupid, int mem_node,=
 int pages, int flags)
>  	struct numa_group *ng;
>  	int priv;
> =20
> -	if (!static_branch_likely(&sched_numa_balancing))
> +	if (!task_numab_enabled(p))
>  		return;

[Severity: Medium]
Are there a few direct accesses to the sched_numa_balancing static key in
kernel/sched/fair.c that might have been missed by this refactoring?

For example:

kernel/sched/fair.c:exceed_llc_capacity() {
    ...
	if (static_branch_likely(&sched_numa_balancing)) {
    ...
}

kernel/sched/fair.c:get_pref_llc() {
    ...
		if (static_branch_likely(&sched_numa_balancing) &&
		    p->numa_preferred_nid >=3D 0 &&
    ...
}

kernel/sched/fair.c:get_scan_cpumasks() {
    ...
	if (!static_branch_likely(&sched_numa_balancing))
		goto out;
    ...
}

Since get_pref_llc() and get_scan_cpumasks() already take a task_struct
pointer 'p', shouldn't they also be updated to use the new
task_numab_enabled(p) wrapper?

If these direct checks remain, might they bypass the per-cgroup BPF policy
that the commit message notes will be consulted in a later patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012120438.5284=
9-1-laoar.shao@gmail.com?part=3D1
