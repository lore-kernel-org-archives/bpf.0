Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E831F91F6;
	Mon, 13 Jul 2026 02:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911558; cv=none; b=KoZiQQKkDyw2QyAKw4HzXJg3Ar22Ou4ho28A4x698Gd80X+R6QqUAK8xv95C4BJGiFXAC8ew+LrhTUYsamentIFoMOD7DYu39f4TsLK8rNcAH5lSD9F54DT44SzL20Ww8zR1RWFV3ajNb9D8ubZdUmj8V1IZbmMdj/OINwepfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911558; c=relaxed/simple;
	bh=HTRyhcc/qN58USeJ9eVkO/cCQOk3o43lfBhkZKaeVgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ocMqdcvqJwZA3ZFtUEpKrQ9dU5QpwYXi64mwOthPvWMjMoxSG6Gdm91UI2hzuM+J2ENIMFmozG8Wrbyqrc200z0gvoWnof1Q2T0bRmyKqwz7htl4xgr9WqteywVQyNoRHVoPhF5uW4+svHlzHuNn6let63twp4hHNLMP+9AOydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj8DpWcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj8DpWcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A941F000E9;
	Mon, 13 Jul 2026 02:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783911556;
	bh=y6MyiMjgVSv5G8GXHj6PRKFf506/otqsdvkkiVYkFgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gj8DpWcTPpuNry9IRsvv5QWMJf/V65cdkvrwrs5OTWgkqokCKp//5/AhRM5khGWgg
	 Bb6cMv0ovuG2M/5T818yj2c9Sebk/KPOBLr8/MSbNX/WjVjWQDsMqWzonA0TstWe3D
	 HR48qQYf6cTeUnTKlLQTJUnool7KkovQFIM8KlHHvGV0FrslNi8kGoPfQpAr4u7UTJ
	 6XkT4eg58MHqWXyho770+N7/diyHFGrJ6/u81XjRKnYcT0hOi8mFmKSWTTVd0//NXk
	 f9531XOWJkpsL6lb18LRkSnN+tP7mYal7Ku6zxVggU5kz/bBGe8OVJbaq1/5PuNhX4
	 w3O4mb5mVpxpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHSET SLOP RFC 6/6] sched_ext: Convert
 scx_bpf_cid_override() to take an arena pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260713024414.3759854-7-tj@kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org>
 <20260713024414.3759854-7-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 02:59:15 +0000
Message-Id: <20260713025916.68A941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing READ_ONCE() when reading from shared arena memory allows a=
 TOCTOU race leading to out-of-bounds writes.
--

--- Patch [6]: [PATCHSET SLOP RFC 6/6] sched_ext: Convert scx_bpf_cid_overr=
ide() to take an arena pointer ---
commit 0bba9b04cbf24d912ae66699e643f62ba90a630b
Author: Tejun Heo <tj@kernel.org>

sched_ext: Convert scx_bpf_cid_override() to take an arena pointer

This commit changes scx_bpf_cid_override() to take an arena pointer for the
cpu_to_cid array instead of a verifier-visible buffer. It validates the
entry count against nr_cpu_ids, relying on the arena's guard region to
prevent out-of-bounds memory accesses.

> diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
> index af83084ec740a..872f699cb1acc 100644
> --- a/kernel/sched/ext/cid.c
> +++ b/kernel/sched/ext/cid.c
[ ... ]
> @@ -314,14 +314,24 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cp=
u_to_cid, u32 cpu_to_cid__sz,
[ ... ]
> +	/*
> +	 * @cpu_to_cid__arena arrives rebased to the arena kernel mapping.
> +	 * nr_cpu_ids * sizeof(s32) stays within the guard region covered by
> +	 * arena fault recovery, so no explicit bounds check is needed.
> +	 */
>  	for_each_possible_cpu(cpu) {
> -		s32 c =3D cpu_to_cid[cpu];
> +		s32 c =3D cpu_to_cid__arena[cpu];
> =20
>  		if (!cid_valid(sch, c))
>  			return;

[Severity: High]
This is a pre-existing issue, but since the array resides in shared
userspace-mapped memory (and now an mmaped arena), should READ_ONCE() be
used when reading cpu_to_cid__arena[cpu]?

Without READ_ONCE(), the compiler could potentially reload the value of c
from memory after the bounds check in cid_valid(sch, c). If userspace
concurrently modifies the arena memory between the check and its subsequent
use as an array index:

    if (cpumask_test_and_set_cpu(c, seen)) {
        scx_error(sch, "cid %d assigned to multiple cpus", c);
        return;
    }
    scx_cpu_to_cid_tbl[cpu] =3D c;
    scx_cid_to_cpu_tbl[c] =3D cpu;

Could this Time-of-Check to Time-of-Use (TOCTOU) race result in an
out-of-bounds write to scx_cid_to_cpu_tbl[c]?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713024414.3759=
854-1-tj@kernel.org?part=3D6
