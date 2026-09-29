Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0AD528428;
	Tue, 29 Sep 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703502; cv=none; b=SArsEbVuPOF0gAI2ne5S4GyfBLDt4WK0UKkD5kuiDx7SGNsoJIn4GgSWJuX144EBCkC5IophOU6V73Bs7qpB5y6baH23CPVF/7FyuvNjKAteL/boaBXsTwDQxiLB7aPDjzcHIPU29l/lucI40ycEbcr6ZjgOAYsdQYn8RZj0z5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703502; c=relaxed/simple;
	bh=sMhfOsYRlw1oNQeIkAXv0p6U0oqD1y16erHz8e1YB3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qakJUzx/SoWBl/gRXLBVefltaERxJNJWzJqKy1ecknXrHtNCa17czgxwXPJwNOrGbbD3dhWt0Tq7HPW1a415lGbO3Zqbdhg/7rzXzuT+CCsw7PLi/rrvzB6iHfNkh1klNNwOrzqyiQnNMQ5zsEANkMVkzaUXeUD1+wqAXn4rfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZbgz6Kg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZbgz6Kg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125081F000FF;
	Tue, 29 Sep 2026 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703501;
	bh=gHHVxQFAvN3ZcewoO3CLmw+cArQRBdv7a5OEkmGubew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GZbgz6Kg3g0TGR1XlshPjv6nsnkmWt2zQzGKU4s2lzMf7he6YaUmt/e3WAwGTL4wK
	 Wc3O+hZgiWeK60t9msqX56eOWvQmrSOFznEvDI93eml3VdH5Twea7WRfyQtVd2fYht
	 xDAedgMy9tIHH9WcQw9Ye+jXmrPB5tYfz/b8LEHZ+uNlGuSTqkScL1D88q4JJlJUZ+
	 fDq7TliPyjEDbusyhRoVLK4+YvOsmOa4FBN2bjadXwM44OJ5mRzjKOdGkfRSpjTUn5
	 qBF03zxBwNC4tn6qGRkqw347/bPck/w8q01xOZBT2FPcxjUFzdHAFBeBeoxlkAaHBQ
	 V32OtGLvH3OqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Work around pahole 1.32
 dropping scx_bpf_task_set_lazy_resched() from BTF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <7c139810be5ffc9764ed4236efc28794@kernel.org>
References: <7c139810be5ffc9764ed4236efc28794@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:38:20 +0000
Message-Id: <20260929173821.125081F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] sched: build failure due to misapplied patch in scx_bpf_task_set_ds=
q_vtime()
--

commit 16f6b2129331609ed5db39cd3ea7260f54a1df1f
Author: Tejun Heo <tj@kernel.org>

sched_ext: Work around pahole 1.32 dropping scx_bpf_task_set_lazy_resched()=
 from BTF

This commit works around an issue with pahole 1.32 by forcing the lazy
argument onto the stack using barrier_data() so its location doesn't
name a register.

Link: https://lore.kernel.org/r/20260925213619.2187751-1-yonghong.song@linu=
x.dev

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 6b037d27c99d3..feaa784d7a0dc 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -10119,6 +10119,11 @@ __bpf_kfunc bool scx_bpf_task_set_dsq_vtime(stru=
ct task_struct *p, u64 vtime,
>  {
>  	struct scx_sched *sch;
> =20
> +	/*
> +	 * clang's register locations for @lazy make pahole 1.32 drop this kfunc
> +	 * from BTF. Keep @lazy in memory so its location names no register.
> +	 */
> +	barrier_data(&lazy);

[Severity: Low]
Will this cause a build failure? It looks like the lazy variable is not
declared in scx_bpf_task_set_dsq_vtime().

Could it be that this patch was mistakenly applied to=20
scx_bpf_task_set_dsq_vtime() instead of scx_bpf_task_set_lazy_resched()?=20
They appear to share identical context lines, meaning the patch might have
matched guard(rcu)(); followed by sch =3D scx_prog_sched(aux); in the wrong
function.

>  	guard(rcu)();
>  	sch =3D scx_prog_sched(aux);
>  	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
>  		return false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/7c139810be5ffc9764e=
d4236efc28794@kernel.org?part=3D1
