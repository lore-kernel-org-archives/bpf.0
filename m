Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962563;
	b=Kwtwh67UDS3PM/NIvAoejRbt5zFqhsWpYl4rQO07TXJPUeXFIdsoOwU+KZ6hwk04l5d2
	 QF/M6iyMfPGxblw7chFDONYmS2WHC0xGSZ0JjdTAYy49VSUxeOuUfHA3bSinMw/9rZ8G4
	 zN16DdvJIHuDcom1ofqTiplk7PmO8q0corwBT5Xs9HFLeydG7mB6mJUOsq/hEJKlleOUX
	 D8tmI5pn749af5yqTqTBpWcfywMOWsFNqrVlbliurxKalo93yGm6EPD1f0/BOr7Zs35Gv
	 6+5B+iYbFZoWsmsltTaL1KlMAWueRGMZyIjox2JdME1P+A+hwabGIj/yOUu3JOKDYug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0baHs6cuUODsF5gF6+z9ZXva9heex8qx+wfbRniZZNs=;
	b=0w6Vqa9/3PhMoUU9JEdCNiL1bjmh6tB7Feuh5YPa0hffiM5erOA1oiWdAxz9I93sCIeM
	 XFPe0tE8fxdzEwu99fAn1DesmvDVNaWZ8WQduVpTIr6YsDHFrADRYae2U7vx8hiONWoND
	 W81WCeQPVdtiSvAHKULTOmbTNn1aeBQ2GvXPc+Bs3d2Vhsv28Bx0oJXgbR9csDTcUDG6B
	 HcLvaUfTAHekOHu3o5cBRKWxfooJ+nJN8nW4MDyuDFw10TORv2BE9fzABsP97SGTUujtk
	 jKO9k/N/NttacXu1oyeGEs9oea+94ADzulqQFmL9Q5V/hJjjzqd05Iv311XD5kIpfQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWrumthd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C2606A334
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWrumthd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C5F1F008A2;
	Fri,  6 Nov 2026 10:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793962563;
	bh=0baHs6cuUODsF5gF6+z9ZXva9heex8qx+wfbRniZZNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FWrumthdVLsbC2ZxPrGMX9k0WHtSjosu8mtUxSGspJKpU3ib+F1wokzxJRSPQVL0x
	 8Lqf8qHf1mAYbxeM/FybNY8CoKpDnePupCmEsQn5TeWQrwFHVcNBSnzltLzv19A+SV
	 Tnrah6ZG7/3S/hkO0qdRV+JZg5dBxvktIG3l2mjDeXD5Qm/riAahBz6J/3pxJiS4YZ
	 B8htl0ya8LQW6uOWJhWAGPlzK3ajW7Eec1kPjzvawcxFaJQ9WiZr2eky3vXyMSKikG
	 ISny4Zpw2qHFwcu7huZb1ma17iIEZ7J9e7mtQCcBJ6NVwy+mjwJiLY3DrL4SgM/UBR
	 MPCRQFsMksMYA==
Message-ID: <sashiko-outbox-201252@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/8] selftests/bpf: Check task work value
 membership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Lu" <luyun_611@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261106095747.471718-4-luyun_611@163.com>
References: <20261106095747.471718-1-luyun_611@163.com>
 <20261106095747.471718-4-luyun_611@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 10:56:02 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests/bpf: LRU eviction on CPU migration in open_test()
--

commit a48c230ac453ac2d2db53442d38749169b051723
Author: Yun Lu <luyun@kylinos.cn>

selftests/bpf: Check task work value membership

This commit adds BPF selftests verifying map value membership checks when
scheduling task_work across deletion, replacement, reinsertion, in-place
updates, and map user-reference drops.

> diff --git a/tools/testing/selftests/bpf/prog_tests/task_work_membership.=
c b/tools/testing/selftests/bpf/prog_tests/task_work_membership.c
> new file mode 100644
> index 0000000000000..0f5cdef3a24c7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/task_work_membership.c
> @@ -0,0 +1,392 @@

[ ... ]

> +static struct task_work_membership *open_test(enum bpf_map_type type, __=
u32 flags,
> +					      bool use_signal)
> +{
> +	struct task_work_membership *skel;
> +	int err;
> +
> +	skel =3D task_work_membership__open();
> +	if (!ASSERT_OK_PTR(skel, "open"))
> +		return NULL;
> +	err =3D bpf_map__set_type(skel->maps.values, type);
> +	if (!ASSERT_OK(err, "map_type"))
> +		goto fail;
> +	err =3D bpf_map__set_map_flags(skel->maps.values, flags);
> +	if (!ASSERT_OK(err, "map_flags"))
> +		goto fail;
> +	/* A full LRU map can evict the target while obtaining a candidate. */
> +	if (type =3D=3D BPF_MAP_TYPE_LRU_HASH) {
> +		err =3D bpf_map__set_max_entries(skel->maps.values, 2);
> +		if (!ASSERT_OK(err, "map_max_entries"))
> +			goto fail;
> +	}

[ ... ]

> +static void retired_value(enum bpf_map_type type, __u32 flags, bool use_=
signal,
> +			  bool replace)
> +{
> +	struct task_work_membership *skel;
> +	struct bpf_program *mutate;
> +	bool ok;
> +	int i;
> +
> +	skel =3D open_test(type, flags, use_signal);
> +	if (!skel)
> +		return;
> +	mutate =3D replace ? skel->progs.update_then_schedule :
> +			   skel->progs.delete_then_schedule;
> +	if (!insert_value(skel))
> +		goto out;
> +
> +	for (i =3D 0; i < REUSE_ROUNDS; i++) {
> +		/* Later rounds start with a ctx left by the live schedule below. */
> +		ok =3D run_prog(mutate, -ENOENT);
> +		if (replace)
> +			fprintf(stderr,
> +				"replace address map_type=3D%d old=3D%#llx new=3D%#llx\n",
> +				(int)type,
> +				(unsigned long long)skel->bss->old_value,
> +				(unsigned long long)skel->bss->new_value);
> +		if (!ok ||
> +		    !ASSERT_OK(skel->bss->mutation_err, "mutation") ||
> +		    !ASSERT_EQ(completed(skel), i, "retired_not_called"))
> +			goto out;

[Severity: Medium]
Can setting max_entries to 2 for BPF_MAP_TYPE_LRU_HASH still evict the live
entry in update_then_schedule() if the test thread migrates between CPUs
across iterations of retired_value()?

With max_entries =3D 2, bpf_common_lru_populate() allocates only two nodes =
(N1
and N2) on the global free list.  When N1 is inserted on CPU A, it is placed
on CPU A's per-CPU pending_list with N1->cpu =3D A.  If the unpinned test
thread sleeps in wait_completed() and migrates to CPU B for a replacement
round, prealloc_lru_pop() pops N2 from the global free list onto CPU B's
pending_list, and htab_lru_push_free() moves the replaced N1 from CPU A's
pending_list onto CPU A's per-CPU free_llist.

On the next round of update_then_schedule() on CPU B, CPU B's local
free_llist and the global free list are both empty.  Before stealing from C=
PU
A's free_llist, bpf_common_lru_pop_free() calls
bpf_lru_list_pop_free_to_local(), which flushes the live N2 from CPU B's
pending_list and shrinks the global list, evicting key 0 from the hash tabl=
e.
htab_lru_map_update_elem() then fails its BPF_EXIST check with -ENOENT,
setting mutation_err =3D -ENOENT and failing the "mutation" assertion in
lru_replace_resume and lru_replace_signal.

Using BPF_F_NO_COMMON_LRU with a sufficient max_entries, or pinning the test
thread to a single CPU, would avoid stranding the spare node on a remote CP=
U.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106095747.4717=
18-1-luyun_611@163.com?part=3D3
