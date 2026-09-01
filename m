Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F511367B61;
	Tue,  1 Sep 2026 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272371; cv=none; b=JJid+BJ0Up7CXSvxvcHgSKG/1VSt8i9dThRvgjOyKSV9Q4ocBf/alhjcz4PoriFB5rm7gb78oR7Hy9on4FBJjHm5Np3vsqXEQTq8crA41fxrvHL4ysvx77UxqgtNmF4lzcFUzQ7gia0ADLlcop0UKlQcXeZre/TDEVQjxN+xD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272371; c=relaxed/simple;
	bh=wYpSccLt51fQsSQfLWoO8ufpXp5+iH95y4ef53UW8PA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rtcdcWpnRi32w4cj2L21MUH9isRqakkZLSEHloRAVT1KY00hC7iN9UeWkZgSv9Lgp0Hh+dtpojFIKwyyK5kG2roRpOqkbwCn30M8WEOh+IWVoi/LRkWxoTWtkSIV71DPzYcmVi37Q0lgOtg47LI3tQYun/fUxm437llmi/pBf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZcWxEqO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZcWxEqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F010D1F000E9;
	Tue,  1 Sep 2026 14:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272370;
	bh=bymvG/mgNbxblbf+wmjzZg4NZClTphvsHUSlkFrAdvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YZcWxEqOjGm5GkZXuMO4jiIMoOHG5JRGVjnpJS7rqeNTWYtIMBc1GDvlC50gwVTr5
	 6AaDeTgeZlGp2KBsFlJ94otWTRmJgCXGV2Cwcj66SCLP5I58XVrBgS4R6CNiP9cr9b
	 /CDAZSiYco34HLGvueAl4cVM/Ht/qbw/RqV1HGgvEKYpugGoFqXKkDdHcwceq9ao92
	 Hrsesaq9HdqZ7sAdvdMVRWZtE9sjvLwGF2GIC09BG4+IIcBEPF8NaE6f5yCVdByz8U
	 JJWxBTXIxW0jPCaEAGzASot773iT2OonqqnVaZMYVDv09N5PhwCngJZujcBC2eP5IW
	 QfbIcKr/mnxQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] sched_ext/scx_flatcg: make cgv_node_less()
 wraparound-safe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260901140343.764080-3-cui.tao@linux.dev>
References: <20260901140343.764080-1-cui.tao@linux.dev>
 <20260901140343.764080-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 14:19:29 +0000
Message-Id: <20260901141929.F010D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Atomic read-modify-write race in cgrp_cap_budget duplicates cvtime=
_delta charges.
- [High] Yielding early penalizes a cgroup's cvtime instead of refunding it=
, and overrunning causes massive unintended penalties due to unsigned under=
flow.
--

commit 3be5a2d907efdab246afa9bb4e4577fd489ec842
Author: Tao Cui <cuitao@kylinos.cn>

sched_ext/scx_flatcg: make cgv_node_less() wraparound-safe

The commit addresses a potential wraparound issue in cgv_node_less() by
using a signed difference for cvtime comparison instead of a plain '<'.

Link: https://lore.kernel.org/r/3f1ce004-e259-4e72-a5f7-14a5050053bd@linux.=
dev

> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatc=
g.bpf.c
> index fec3595818269..3a25cfdc97092 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -144,7 +144,8 @@ static bool cgv_node_less(struct bpf_rb_node *a, cons=
t struct bpf_rb_node *b)
>  	cgc_a =3D container_of(a, struct cgv_node, rb_node);
>  	cgc_b =3D container_of(b, struct cgv_node, rb_node);
> =20
> -	return cgc_a->cvtime < cgc_b->cvtime;
> +	/* wrap-safe: cap_budget keeps nodes within 2^63 of each other */
> +	return (s64)(cgc_a->cvtime - cgc_b->cvtime) < 0;
>  }
> =20
>  static struct fcg_cpu_ctx *find_cpu_ctx(void)

While reviewing this patch, I noticed a couple of preexisting issues in
tools/sched_ext/scx_flatcg.bpf.c.

tools/sched_ext/scx_flatcg.bpf.c:cgrp_cap_budget()
> 	/*
> 	 * A node which is on the rbtree can't be pointed to from elsewhere yet
> 	 * and thus can't be updated and repositioned. Instead, we collect the
> 	 * vtime deltas separately and apply it asynchronously here.
> 	 */
> 	delta =3D __sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);

[Severity: High]
This is a pre-existing issue, but could this atomic subtraction lead to a r=
ace
condition with concurrent updates?

In C, the second argument (cgc->cvtime_delta) is evaluated before the atomic
operation. If another CPU adds to cvtime_delta (e.g. via lockless
__sync_fetch_and_add in fcg_stopping) after the second argument is evaluated
but before the atomic subtraction executes, the operation will subtract the
old value from the new value.

This returns the new value, which gets added to cvtime, but the concurrent
addition remains in cvtime_delta and will be added again in the next call.
Would it be safer to use an atomic exchange here, such as
__sync_lock_test_and_set or bpf_atomic_xchg?


tools/sched_ext/scx_flatcg.bpf.c:fcg_dispatch()
> 		__sync_fetch_and_add(&cgc->cvtime_delta,
> 				     (cpuc->cur_at + cgrp_slice_ns - now) *
> 				     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));

[Severity: High]
This isn't a bug introduced by this patch, but does this logic penalize
cgroups when they yield early?

If a cgroup yields before its slice is fully consumed, cpuc->cur_at +
cgrp_slice_ns - now is positive. Adding this unused time to cvtime_delta
increases cvtime, pushing the deadline further into the future instead of
refunding it.

Additionally, if the cgroup overruns its slice, could the subtraction
underflow? Since the arithmetic is unsigned, an overrun would result in a
huge number which, after division by cgc->hweight, produces a massive
positive value. This would heavily penalize the cgroup by adding days of
virtual time to its cvtime_delta.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901140343.7640=
80-1-cui.tao@linux.dev?part=3D2
