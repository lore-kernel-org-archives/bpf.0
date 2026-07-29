Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397D27D786
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289198; cv=none; b=tSOwaE/Nrxm3oNc5iEzDpmLgPQPgqugYm5aCT7dAAllx7vDyr3/JDQOlfYNZ4JXqHo7uRXWZQ8U1+ovwn4W+Ai9WTxwPZzdo84SvyOaPgkXd8QP6W9OrQcnrfL3mS843m932tYQ6yodFLPyvnMig9sNmCdhw8cNXDvD4Ik+kNcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289198; c=relaxed/simple;
	bh=/lJFey9/7jVSUrpIz8K2d1z5AG/QReACxr9MYTTy5UE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HFS0L17lzgOsJU6T7uAjOHPyhzb9MQKHr/qESbAdgj8pNU1Ba+ne1u1Xoo6zGvSKgEfx/uwNu6egKCfFjpyMqcaDYdK8zZZ0Ub+4ANqZgBhLzMP/J2idukyeDyxQoaMyLWw6GjRlSheksG8kyLgQ9pRX6dB4KdWGIkcoo8Yg/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7kZWXnr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7kZWXnr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A065E1F000E9;
	Wed, 29 Jul 2026 01:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785289196;
	bh=KS04MSEyutV+m/1FhI1mN4RmXoze2rmOvde0lhtdgH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P7kZWXnrueT2wy4ZKw4Dz/RK/V+KwFPtPhSeERJwyEbjRvOSIn71KYDwCZeaYZk1G
	 /41kmGmg/DR2BHCEgw/pOdj38QC1PebFSvrzMgOmaaxnJ1pL0FSWaucWYJZwCL1CfN
	 ml2xQlXb68zRSreFdPZSnPX5m2BgrSddl8Xv/zRIfjlhHHYqSGzJhGUALuYtn527q/
	 2ebtcvbtiaNUyXPow2aoT6OFjj4DXqyvQZMgJUy937UyiZnSBq+30tQaAu9fbtgQlV
	 0XU43Q3U8+2Iq6zq0PF1JNjKhINZaoCExzu4VGUSSE0jp+WB8khoYMkWJzEyq5CeDn
	 BPfNP/l1It9gw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 2/3] kprobes: mark ftrace-based kprobe ops
 permanent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260729005959.3853865-3-andrey.grodzovsky@crowdstrike.com>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729005959.3853865-3-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 01:39:56 +0000
Message-Id: <20260729013956.A065E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error propagation in `__register_kprobe()` causes silent f=
ailures when `arm_kprobe()` fails, returning 0 (success) despite the kprobe=
 failing to arm and being unhashed.
--

--- Patch [2]: [RFC PATCH bpf-next 2/3] kprobes: mark ftrace-based kprobe o=
ps permanent ---
commit 97fc5419ead104f2c26b158adf549fba313680cd
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Subject: kprobes: mark ftrace-based kprobe ops permanent

This commit adds the FTRACE_OPS_FL_PERMANENT flag to ftrace-based kprobe
operations. It prevents kernel.ftrace_enabled=3D0 from silently killing
ftrace-based kprobes by allowing them to function independently of the
global ftrace state.

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index bfc89083daa93..5a54511eee791 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1122,14 +1122,15 @@ static struct kprobe *alloc_aggr_kprobe(struct kp=
robe *p)
>  #endif /* CONFIG_OPTPROBES */
> =20
>  #ifdef CONFIG_KPROBES_ON_FTRACE
> +/* Same protection livepatch gives its own ftrace_ops. */
>  static struct ftrace_ops kprobe_ftrace_ops __read_mostly =3D {
>  	.func =3D kprobe_ftrace_handler,
> -	.flags =3D FTRACE_OPS_FL_SAVE_REGS,
> +	.flags =3D FTRACE_OPS_FL_SAVE_REGS | FTRACE_OPS_FL_PERMANENT,
>  };

[Severity: High]
This is a pre-existing issue, but does adding this flag now cause a silent=
=20
failure during kprobe registration if ftrace is disabled?

With FTRACE_OPS_FL_PERMANENT, register_ftrace_function() (and therefore
arm_kprobe()) will reliably fail with -EBUSY when ftrace_enabled=3D0.

However, in __register_kprobe(), the error code from arm_kprobe() is
discarded instead of being propagated to the caller:

kernel/kprobes.c:__register_kprobe() {
	if (!kprobes_all_disarmed && !kprobe_disabled(p)) {
		ret =3D arm_kprobe(p);
		if (ret) {
			hlist_del_rcu(&p->hlist);
			synchronize_rcu();
		}
	}

	/* Try to optimize kprobe */
	try_to_optimize_kprobe(p);
	return 0;
}

Could this cause the registration API to return 0 (success) even though the=
=20
kprobe fails to arm and is unhashed?=20

If the caller later calls unregister_kprobe(), it might fail internally with
-EINVAL because the kprobe is no longer in the hash table, skipping
__unregister_kprobe_bottom() and potentially leaking architecture-specific
resources.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729005959.3853=
865-1-andrey.grodzovsky@crowdstrike.com?part=3D2
