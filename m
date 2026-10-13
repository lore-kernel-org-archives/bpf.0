Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76003404BE9
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904997; cv=none; b=r+9eeig6GRMtO1O5qf27jkOKwy/nJLPy6vurwuk452Esm/oJzPBO51YhH/2A56QnnbooKB9W4SRa6DCPG+NZ9KtqqIrFQlrrCuKvHMET1yGQFJbRSjYFAWdsnxg82DHIrD03HcA4BbGB4Nwhbj07+JnpTmD60tDWOrimxaNrVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904997; c=relaxed/simple;
	bh=VF+Karj7+DhCDYzNousT6nvAkn3utvHTWt42N/msG5Y=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=q2UId46XETSVyv1fTIspR6x7sGIsGOj6qyUTkefMm9DsWh1dDoeNplaikBldIgdFIpXNK0YGrgf5BJcnttk+VtfMhdpoAT/j7laNbYEc6jhmX1QIXQf+TKvc2vC9/PRLr3sRa8kEtpucguFhufnJ9P30Lv3ShGrVtUJ+OrpKOhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw9eGrX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw9eGrX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C3E1F00893;
	Tue, 13 Oct 2026 15:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904996;
	bh=YpRzDDYCjerQlQNroSXSWKMyZD4YQoAJZC59344o8B0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Uw9eGrX2rdM5kTJevn6kYnYFStT6OjE6WoIaOwUt4I0HipWyPnl+6HOwsPTNZtNLa
	 ubHXj47V60m4w5apJ60FJJ3eL7ScyHG1PoeeH//QaADLhYYLJmm9oDwi1L3EJbK+Bk
	 EwmpEjt3iBUrzLkl8pVt9vErmo1Xt9k1f7LHeKbBPe8gPyqtHIUjMfLKOojvsciGVA
	 A9rLVqmx+E4xhn0lFXicgYl2bJQ5+1irZa6n93wZxdXsEkt2lDsUzI4Tff+fbLO6EG
	 N59XQMHsYotqEzsRoDGehETKrUX7NtmP9yvmF3QKHZfiV+noayDYtfE10m4p9/uBfL
	 15aPqSG48BNZQ==
Message-ID: <sashiko-outbox-169989@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Add tests for memcg kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: listout@listout.xyz, bpf@vger.kernel.org
In-Reply-To: <20261013151621.1526699-1-listout@listout.xyz>
References: <20261013151621.1526699-1-listout@listout.xyz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 15:23:15 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: Missing negative bounds check in bpf_mem_cgroup_*_events() al=
lows OOB read
--

commit a4794021755b1042b63dca630dda69e60c099827
Author: Brahmajit Das <bdas@suse.de>

selftests/bpf: Add tests for memcg kfuncs

This patch adds new selftest coverage for various memcg kfuncs,
including bpf_mem_cgroup_usage(), bpf_mem_cgroup_memory_events(),
and bpf_proactive_reclaim(). It validates their behavior against
a test cgroup from syscall programs.

Link: https://lore.kernel.org/bpf/20261013143853.1379307-1-listout@listout.=
xyz/

> diff --git a/tools/testing/selftests/bpf/progs/memcg_kfuncs.c b/tools/tes=
ting/selftests/bpf/progs/memcg_kfuncs.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/memcg_kfuncs.c
[ ... ]
> @@ -0,0 +1,106 @@
[ ... ]
> +SEC("syscall")
> +int memcg_query(void *ctx)
> +{
[ ... ]
> +	/* Out-of-range indices must be rejected with (unsigned long)-1. */
> +	bad_memory_event =3D bpf_mem_cgroup_memory_events(memcg,
> +		bpf_core_enum_value(enum memcg_memory_event, MEMCG_NR_MEMORY_EVENTS));
> +	bad_vm_event =3D bpf_mem_cgroup_vm_events(memcg,
> +		bpf_core_enum_value(enum vm_event_item, NR_VM_EVENT_ITEMS));
> +	bad_page_state =3D bpf_mem_cgroup_page_state(memcg, -1);
> +	/* Negative indices must not bypass the bounds checks. */
> +	neg_memory_event =3D bpf_mem_cgroup_memory_events(memcg, -1);
> +	neg_vm_event =3D bpf_mem_cgroup_vm_events(memcg, -1);

[Severity: High]
Can this test sequence inadvertently trigger an out-of-bounds read regressi=
on
in the kernel?

The BPF verifier does not enforce bounds for enum arguments, so a negative
value of -1 is passed directly to the kernel kfunc. Looking at
bpf_mem_cgroup_memory_events() in mm/bpf_memcontrol.c:

        if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
                return (unsigned long)-1;

        return atomic_long_read(&memcg->memory_events[event]);

Because event is a signed enum, the bounds check uses a signed comparison.
Passing -1 evaluates as less than MEMCG_NR_MEMORY_EVENTS, bypassing the che=
ck,
and proceeds to access the memory_events array with a negative index.

A similar pattern appears to exist for bpf_mem_cgroup_vm_events() which rou=
tes
through memcg_vm_event_item_valid() in mm/memcontrol.c and performs a signed
comparison against NR_VM_EVENT_ITEMS.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013151621.1526=
699-1-listout@listout.xyz?part=3D1
