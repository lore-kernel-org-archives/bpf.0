Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBED52CCDA
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912129; cv=none; b=g26cenEDT+GwH1FlVOUQvqvoT3TUZHvNHjSO+qAgCWzn2YMwrUsxGZ8v82cZutJ3CWM9Zfgs3sL5mGQs4YWrI06a9B3iNbGe7We9Z/ZXRiD4wrE9eD4vuf2rdfG4ykW+53IjUiO/7VJxT6T06/rlygofY3VkUwPsKSgeCmEvWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912129; c=relaxed/simple;
	bh=bAGzD+TnxWRT0uO/puNei7pkXIMKmTJj+BaOYDTdiAk=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=EeGSr83+WQQFqA1mr0oGTwTl7Moox/pDl6PJX1aM6dAXp16Ak11yLNMYuJHf/Clg2daH7qAJiZKnOJpIXdDDSbENj+U6ps2NekHfqmkvvPG1sFXku1t5hbrT6I9jZcOZq4c1sPKsYdB/F7B+1KlNpdl4Rs2+qPtci53bPQkR2AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri9JiLvz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri9JiLvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5431F000FF;
	Tue, 13 Oct 2026 17:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912128;
	bh=x/FlSJNgmtDJKTKpG3XdQm24df/xKBpUEmxLwe10+N0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ri9JiLvz/aXrKbRDuU/rO6JSNvXsxKfPOkwDww6ojrmO2Z9pejSZjiZqc0rhnJVHw
	 bNQGuT2rfdsaSlGQwewRi8ymorMSVfGrL6nGxE5Ke/OgbLG1/Rq5ylc3pj6h3Q2Men
	 2WfZzzpG6LBsUlRMWv9s+e7R+YbaHkOqSf+L/kGZkTTpqnHZgN+JWmPQkcvPca9DGd
	 39y9pjejZOeRf7svIfq1wwrJ5acgozkSdD6m0/LExi2N/vxVhLwXZwmuFs6JqXQ+tN
	 QvIcOYqHGSITsFSJhqDivrwp6AcaIAXQvpkjB4bxujIZqsOa46CTqEdpfEn7XN46o+
	 mLI8PYyq6U2uQ==
Message-ID: <sashiko-outbox-170215@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add tests for memcg kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: listout@listout.xyz, bpf@vger.kernel.org
In-Reply-To: <20261013171211.1661726-1-listout@listout.xyz>
References: <20261013171211.1661726-1-listout@listout.xyz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:22:07 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: Missing negative bounds check in enum memcg kfuncs allows OOB=
 read
--

commit 555191733d8248d3b4bb6e02814568e60e2be094
Author: Brahmajit Das <bdas@suse.de>

selftests/bpf: Add tests for memcg kfuncs

The existing cgroup_iter_memcg test covers bpf_get_mem_cgroup(),
bpf_put_mem_cgroup(), bpf_mem_cgroup_flush_stats(),
bpf_mem_cgroup_page_state() and bpf_mem_cgroup_vm_events(), but
bpf_get_root_mem_cgroup(), bpf_mem_cgroup_usage(),
bpf_mem_cgroup_memory_events() and bpf_proactive_reclaim() have no
selftest coverage.

> diff --git a/tools/testing/selftests/bpf/progs/memcg_kfuncs.c b/tools/tes=
ting/selftests/bpf/progs/memcg_kfuncs.c
> new file mode 100644
> index 0000000000000..5e2ea19a072da
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
Does this test inadvertently trigger an out-of-bounds read in the kernel?

Looking at bpf_mem_cgroup_memory_events() in mm/bpf_memcontrol.c, the enum
memcg_memory_event parameter is treated as a signed integer, and the bounds
check uses a signed comparison:

	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
		return (unsigned long)-1;

	return atomic_long_read(&memcg->memory_events[event]);

Since the BPF verifier does not check enum ranges, passing a negative value
like -1 from this test bypasses the >=3D check entirely and accesses the
memory_events array out of bounds.

Similarly, memcg_vm_event_item_valid() in mm/memcontrol.c, which is used by
bpf_mem_cgroup_vm_events(), also uses a signed comparison:

	if (idx >=3D NR_VM_EVENT_ITEMS)
		return false;

	return !BAD_STAT_IDX(memcg_events_index(idx));

This allows the negative index passed by this test to bypass the check and
cause an out-of-bounds access in memcg_events_index().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013171211.1661=
726-1-listout@listout.xyz?part=3D1
