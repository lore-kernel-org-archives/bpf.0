Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC438F226;
	Wed, 17 Jun 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687868; cv=none; b=fg4imZ2P3TG1e+cVnbn3XurbRPNTpEtY1K6xuxHXY+zMNJPEI4eTM8OGOYYDlZtxFDlnSdTH+htWVJd0jvDcMdQV8awB8zJIM7irAv2W18pPILlreQbtV4DodO6RsgCF777U6zBDM7rh5U4/2HG6mK66/9cTU6V0XT+MdT3Vsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687868; c=relaxed/simple;
	bh=tl6VjhOFGcOgaOM3krpVaNsSPNSd5t/U8R9DOl8NxhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UfC12w+QBpYelffjrTbpzZev7Qd9FFB/Ik8nV+iJdknT4KGil8VsE3Rd/YDCKRFP81yOjOkyEfQn0MtzD9NEAudKH2sZDakw4TXRxwxn2c+mR/E39/MRzFr2iJW+AlZ8FGmrlwB4ieq42wl/PEGE8uR1HEUuov7M9tHxBxvWuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/8OG01m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/8OG01m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D18A1F000E9;
	Wed, 17 Jun 2026 09:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781687867;
	bh=Jce11rHzxBBOgSc1BZdLjwszjEFQq9n1/eHDvW2D/OA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G/8OG01mWJ6a1Rator2DwOigt72ZDTsaPoEBwYCIlN1OREeNk5ktCChO+QbfyaOFc
	 gMJ3ZPP62m0d2K9aDTsUI7Gz9iQqncx5fFJ6Jo2YQe51uC0ODx5lb1i/95GUSEAti+
	 qdDAIS7JgfpIbbFeV9Egs/PsPmV1WxT5skwEt/9mnlHFv1oTyEx/D7lQYz4Dg0wpGU
	 bp0UM0b/Xjr0fmPUM9G/nrjouZ7O5HhP2vEsRp8X57Dp/SUk9pql3LIFONKE3tSlDf
	 +ocB9GYvnDCLv3zkZi0Mu8or+zxODam+K6oBFs1SBgAvTDTF3uvYWx8JT0LHIoYbBQ
	 T0Tw2IYfO+Gdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tools/sched_ext: scx_flatcg: Fix inverted vtime
 delta accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: luoliang@kylinos.cn
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260617090348.4131187-1-luoliang@kylinos.cn>
References: <20260617064805.3901965-1-luoliang@kylinos.cn>
 <20260617090348.4131187-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 09:17:46 +0000
Message-Id: <20260617091747.0D18A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Casting absolute unsigned virtual time cvtime to s64 triggers a cl=
amp to 0 when the clock exceeds 0x7FFFFFFFFFFFFFFF, causing permanent starv=
ation.

Pre-existing issues:
- [High] Non-atomic read-and-clear of cvtime_delta in cgrp_cap_budget leads=
 to double-counting of concurrent time updates.
- [High] Bypassed CPU time is added to cvtime_delta unscaled, massively und=
ercharging the cgroup.
--

commit b06d8cd51f70901f471bd851ffb7fe016e3053b0
Author: Liang Luo <luoliang@kylinos.cn>
tools/sched_ext: scx_flatcg: Fix inverted vtime delta accounting

In try_pick_next_cgroup(), a cgroup is charged its full slice upfront.
fcg_dispatch() is then supposed to refund the unused time by adding
(expected_end - now) * FCG_HWEIGHT_ONE / hweight to cvtime_delta.
This patch corrects an issue where overruns and early yields were
handled with inverted logic, causing massive overcharging or underflows.

> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatc=
g.bpf.c
> index fec3595818269..6aa0c62b76d26 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -249,15 +249,26 @@ static void cgrp_refresh_hweight(struct cgroup *cgr=
p, struct fcg_cgrp_ctx *cgc)
> =20
>  static void cgrp_cap_budget(struct cgv_node *cgv_node, struct fcg_cgrp_c=
tx *cgc)
>  {
> -	u64 delta, cvtime, max_budget;
> +	s64 delta;
> +	u64 cvtime, max_budget;
> =20
>  	/*
>  	 * A node which is on the rbtree can't be pointed to from elsewhere yet
>  	 * and thus can't be updated and repositioned. Instead, we collect the
>  	 * vtime deltas separately and apply it asynchronously here.
>  	 */
> -	delta =3D __sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);
> +	delta =3D (s64)__sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_del=
ta);

[Severity: High]
This is a pre-existing issue, but does this non-atomic read-and-clear patte=
rn
lead to double-counting of concurrent time updates?

The __sync_fetch_and_sub() pattern evaluates the second argument
(cgc->cvtime_delta) before performing the atomic subtraction. If a concurre=
nt
context like fcg_stopping() adds time to cvtime_delta between the read and
the subtraction, the atomic operation will subtract the old value from the
newly incremented value.

This extracts the concurrent addition into delta, but leaves the concurrent=
ly
added value in cvtime_delta in memory to be extracted again on the next
execution, skewing the cgroup's virtual time.

> +	/*
> +	 * cvtime_delta may be negative (early-yield refund from fcg_dispatch()=
).
> +	 * Apply it in the signed domain and clamp the resulting cvtime at zero
> +	 * so that a refund larger than the accumulated cvtime doesn't roll the
> +	 * field negative.
> +	 */
> +	s64 vtime =3D (s64)cgv_node->cvtime + delta;
> +
> +	if (vtime < 0)
> +		vtime =3D 0;
> +	cvtime =3D (u64)vtime;

[Severity: High]
Can casting the absolute unsigned virtual time (cvtime) to s64 trigger a cl=
amp
to 0 when the clock exceeds 0x7FFFFFFFFFFFFFFF, permanently starving the
cgroup?

Virtual time is a monotonically increasing u64 timestamp that uses modular
arithmetic via time_before(). Because it is scaled by FCG_HWEIGHT_ONE (6553=
6) /
hweight, a heavily nested cgroup with hweight =3D=3D 1 advances its cvtime =
65,536
times faster than real time, and will exceed 0x7FFFFFFFFFFFFFFF within roug=
hly
39 hours of CPU time.

When this happens, casting cgv_node->cvtime to s64 evaluates to a negative
number, triggering the vtime < 0 check and forcefully clamping the cgroup's
cvtime to 0. Since time_before(0, 2^63 + X) evaluates to false in modular
arithmetic, 0 is treated as a time far in the future, placing the cgroup at
the end of the rbtree indefinitely.

Should underflow prevention be applied only to the relative delta, rather
than the absolute timestamp?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does the time accounting for
bypassed tasks undercharge the cgroup by failing to scale the elapsed time?

Looking at fcg_stopping(), bypassed CPU time is added to cvtime_delta unsca=
led:

tools/sched_ext/scx_flatcg.bpf.c:fcg_stopping() {
    ...
    __sync_fetch_and_add(&cgc->cvtime_delta,
                         p->se.sum_exec_runtime - taskc->bypassed_at);
    ...
}

cgc->cvtime_delta accumulates virtual time, which is wall-clock execution t=
ime
scaled by FCG_HWEIGHT_ONE / cgc->hweight. By adding the raw, unscaled elaps=
ed
nanoseconds directly, a cgroup with hweight =3D=3D 1 will be undercharged b=
y a
factor of 65,536 for bypassed time compared to regular execution, breaking
cgroup weight fairness.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617090348.4131=
187-1-luoliang@kylinos.cn?part=3D1
