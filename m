Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3EA3A9DB1
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825748; cv=none; b=fbhnCYDU/GSSjz6IuEGoDbP4hVN3D7w//cWYru3lKbDA1xangqyttaOZ09FoVGhqLgURrNxsMvQYx04E4Jwnmb/6KKv5M+mKn79AVcALnBlm9fHxU3z4rqTzG/2ll3QSnD5U7rv9o9+z2K+XNDu1w585GQDQeZtjGjCwUi0nprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825748; c=relaxed/simple;
	bh=zdQfyw+NHSbacn+Ssm+GYZ+1mDyewg7VPm9UIDtW02Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZYn7y3kAD6r1JQMHvIo6Md8+dDCPSyaIhC+MF2Vfe5lMl9iPzAl0X51yMgELWD+mth50fuSyaElNnWRLL+JPGj6YkqRH+HUTQh2aT73DggZMhKkrkqqKyl/404/6WcUEyJaRHjxHE9m8BmxRhRCYH6i121XrFL9vRhRRgeGfSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuLUn1MW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuLUn1MW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44601F000E9;
	Tue, 30 Jun 2026 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782825746;
	bh=Rfgwmm1aIxtI+X2o7NflIw0RHu9EgvU24Zc6/Oaq/jY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OuLUn1MWW9b1Wf9bYH47ahbl0sOfJ8KwsPmyz1or9uG481ha9FNTOeBS2oUQnipti
	 z8ntrzxfeMttswukSSQBiTbL9vL8ZgM6L891exQshCvEPKzB6SRax2N2g4pDTwHjV5
	 tqIgX/ikGo6CZ55njT7MOK5js5303hqNOIiI5oQtlrCK0qPQR2vtVISY+YV91xRc4d
	 CU2T5END6fVMqKWjBaWhXZq5YPwbojyIc/BdwAALMwUVzY1d8sEjUlINqU1sKQ5m4l
	 Yg4B9iYTTmFSFMUooXe3M8eJlGuuYf3fZOUItexGJ7oNHKqhxlP2qd8QoQAlspVyWa
	 xAzgyx87jM/aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] bpf: Fix smp_processor_id() call trace for
 preemptible kernels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Edward Adam Davis" <eadavis@qq.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_4F9E5F1B854B1D1BB42574BA76BB5133BF08@qq.com>
References: <tencent_B6259ABAF5BB63335B9E3C1BB74B071BD608@qq.com>
 <tencent_4F9E5F1B854B1D1BB42574BA76BB5133BF08@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:22:26 +0000
Message-Id: <20260630132226.C44601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Wrapping the entire batch operation in `bpf_disable_instrumentatio=
n()` elevates `bpf_prog_active` for an unbounded duration, leaking the stat=
e across preemption and blinding BPF tracing globally on the CPU.
--

commit 121a3f2517b4814c567c049b787ed0317746073a
Author: Edward Adam Davis <eadavis@qq.com>

bpf: Fix smp_processor_id() call trace for preemptible kernels

This commit addresses an smp_processor_id() warning in preemptible context =
by
wrapping the batch loop with bpf_disable_instrumentation() and
bpf_enable_instrumentation().

Closes: https://syzkaller.appspot.com/bug?extid=3Dfd7e415d891073b83e1f

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9f394e1aa2e85..d3f2f8a379e86 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3299,6 +3299,7 @@ static int __rhtab_map_lookup_and_delete_batch(stru=
ct bpf_map *map,
>  	dst_val =3D values;
>  	total =3D 0;
> =20
> +	bpf_disable_instrumentation();
>  	rcu_read_lock();

[Severity: High]
Does wrapping this batch operation in bpf_disable_instrumentation() risk
blinding BPF tracing globally on the CPU if preemption occurs?

bpf_disable_instrumentation() increments the per-CPU bpf_prog_active counte=
r.
Because migrate_disable() and rcu_read_lock() do not disable preemption und=
er
CONFIG_PREEMPT_RCU, the task can be preempted during this potentially long
loop.

If preempted, bpf_prog_active would remain elevated on that CPU, which could
cause subsequent tasks scheduled on the same CPU to silently drop BPF traci=
ng
events (kprobes, tracepoints, perf).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_4F9E5F1B854=
B1D1BB42574BA76BB5133BF08@qq.com?part=3D1
