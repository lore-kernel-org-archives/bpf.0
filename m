Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439E837B02D;
	Mon, 28 Sep 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606798; cv=none; b=HzvuWXv/x8HDn/YbYuf3AqQeuR5S368BGHDIQDu1aUcfusqaIaMKp793JepmwNza+jUiCSnCgf/bwokJma9CNFvecjc+GOqY1M9lYwrH8xosglL8LyIWNQvtbn4X1UOkWAnVYssf5CHqNm2euJ9IYbe9E8eJ/BFe6sWs0cEdHbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606798; c=relaxed/simple;
	bh=eThcIUpBTWLYG3dJBm7jdVqG55rhMpk0EZmx7FEW6mk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YuQfTJvD5jPqNifrF7bymWu01S/YYYxuPYPDP2LObAyHtR+Z6qc4GXfJv66s6UdQlvdsGuxSZbmojVjrdRKSWw2y/up7CkztH6riAxRfXUDez++OjntR2v6a6UcVPPtcAa2itZCmc1GKe3wa2Gt2WeSWHIkiHP4aWhVekUUccAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1c5/8i1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1c5/8i1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2531F00893;
	Mon, 28 Sep 2026 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790606796;
	bh=WzWGHrbNn89goxNYZlLyoKltxYQs9+9bqeHSre8uukQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M1c5/8i1KoAQsLD4TS9XT2/FoOBi64tBKEqcxrTbVqROS7Kyb7TiDthoFS2ScLIKS
	 xr4s2e21ltaUFWdEVb6iZLrfmLKorVt/Sf9ErnNU4fGQ3Qp2egtDBoOPxQiHEzMURH
	 W1sYDbqaPV8Thvrh7Z/Tw6yqLSmJrrtH+TutWC1soiD1zJjV3gmYMy4u22rXfMIV3X
	 kP/N4fFgNqIK05DWsnx9Tof6zP7pO9YzfTz0PnR6mCklHG8IHtqEtWMmIsZy+CDvvY
	 HPzRQDlMgb5YMjF/LjuY3yr1PIr5QZYPuV7HNRbPXJGxAW5PijLROyz4yH/eetkTK3
	 7VARFWF4YaFmQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] fprobe: Switch fprobe and BPF kprobe-multi to
 Tasks-Rude RCU
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179060579456.372125.8753302103085829884.stgit@devnote2>
References: <179060575297.372125.10581329083761385407.stgit@devnote2>
 <179060579456.372125.8753302103085829884.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 14:46:36 +0000
Message-Id: <20260928144636.9D2531F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] trace: Use-After-Free in fprobe_module_callback during rhashtable =
walk
- [Low] trace: sparse context imbalance due to missing RCU_SCHED annotation
--

commit b3e36a52547a2b577250e858535265a49a8ab8b5
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

fprobe: Switch fprobe and BPF kprobe-multi to Tasks-Rude RCU

This commit switches fprobe entry/exit callbacks and BPF kprobe-multi=20
asynchronous unregistration from standard RCU to Tasks-Rude RCU. This=20
prevents potential use-after-free races during RCU grace periods by=20
waiting for preempt-disabled execution contexts to complete.

> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 9f2d98181779a..b7850df17575a 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c

[ ... ]

> @@ -76,8 +76,14 @@ static const struct rhashtable_params fprobe_rht_param=
s =3D {
>  	.obj_hashfn		=3D fprobe_node_obj_hashfn,
>  	.obj_cmpfn		=3D fprobe_node_cmp,
>  	.automatic_shrinking	=3D true,
> +	.use_tasks_rude		=3D true,

[Severity: High]
Does setting .use_tasks_rude =3D true introduce a use-after-free race during
module unload?

Since deferred bucket table reclamation now uses call_rcu_tasks_rude(), the
table walk in fprobe_module_callback() might not have adequate reader
protection:

kernel/trace/fprobe.c:fprobe_module_callback() {
    ...
		rhashtable_walk_start(&iter);

		while ((node =3D rhashtable_walk_next(&iter)) && !IS_ERR(node))
			if (fprobe_remove_node_in_module(mod, node, &alist) < 0) {
    ...
}

rhashtable_walk_start() solely relies on rcu_read_lock(). Under
CONFIG_PREEMPT_RCU, rcu_read_lock() does not disable preemption, meaning
a preemption during the walk satisfies the Tasks-Rude RCU quiescent state.

If the walker is preempted, could a concurrent background resize complete i=
ts
grace period and free the bucket table, causing rhashtable_walk_next() to
dereference freed memory when the walker is scheduled back?

>  };
> =20
> +DEFINE_LOCK_GUARD_0(rcu_sched_notrace, rcu_read_lock_sched_notrace(),
> +		    rcu_read_unlock_sched_notrace())
> +DECLARE_LOCK_GUARD_0_ATTRS(rcu_sched_notrace, __acquires_shared(RCU),
> +			   __releases_shared(RCU))

[Severity: Low]
Does the rcu_sched_notrace lock guard declaration omit the RCU_SCHED contex=
t?

rcu_read_lock_sched_notrace() acquires both RCU and RCU_SCHED, but this
DECLARE_LOCK_GUARD_0_ATTRS macro only declares __acquires_shared(RCU) and
__releases_shared(RCU).

Could this cause sparse context imbalance warnings due to the missing
__acquires_shared(RCU_SCHED) and __releases_shared(RCU_SCHED) annotations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179060575297.372125=
.10581329083761385407.stgit@devnote2?part=3D3
