Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72703431E4A;
	Tue,  1 Sep 2026 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231114; cv=none; b=IwTr8mTbbjI+nndPy/xykQgIN0CQeHCkM5anyOFjWfT9J3c1a//jQAijHIlYAdg/C06gnI06x9zeq/GdJpTCo4RkRgL52ijzehoh8N6qOrFz2JNZPVYpSRqQbP/MA0MkrECVGnCgjkckLWHywxPl+8e5I4HZSDTCdsPKkUU2Gm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231114; c=relaxed/simple;
	bh=rSfb0pyyFRAsJKENAJm7gimrGwv0rGDJkKi1uzWlnMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B260TowH2X0VumI3emRAGnyW13ithSOMhZOFfOwOKSr/PB1U4w53a18qsprz1aO6tb0LU2vCpzAuOcbTBPk+PQ4i9JJFt4yt2pr5W3PfpLm2a1nLz14914+EDWbI6YpIO6XZMM9tsMcH8OpFAveLiuWJ8hKRQhiGGF1TK+TNAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRJiFh6b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRJiFh6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A321F000E9;
	Tue,  1 Sep 2026 02:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788231110;
	bh=7P52aV/VCgILK2OjDKPwkUA5cqEW0fjhODxg3UQxsho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RRJiFh6bI+ioBk2vv4CyNpRrhwA+s59eLaHA1q7e/z7opGGpqf+syFh9MwyFQKgsA
	 4llu0tpMeEm0XpGT7l3KpEjZvK7IoHOzAvl/NEVM+wdKH+NqOFzzFs02fWjavcjaio
	 tIGh2LIwvOGS1AOl56AUqOlcdrfhHWukKuP7r49LSMvT7Mr+lgnbGTrKr4ewrAhIi9
	 XaoSsyYEeEqh8RnIm0O5xk8gpv2WIDDfTuX/0Jd69rtBTvGziFek5jWX//aZajtSKN
	 5l9zKeTHpqzDM0kOtfihu1H3YSRlHqOMPg0Us82ecr5Q0SZLE/HMST4HtKtzd7cfB1
	 W44W6+74laafQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] sched_ext/scx_flatcg: make cgv_node_less()
 wraparound-safe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260901024038.730424-3-cui.tao@linux.dev>
References: <20260901024038.730424-1-cui.tao@linux.dev>
 <20260901024038.730424-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 02:51:49 +0000
Message-Id: <20260901025150.00A321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect usage of `__sync_fetch_and_sub` with a self-referencing =
argument leads to double-counting of concurrent time additions.
--

commit aa8a669e2d8a03160f8c5bfda45d4fd749f2352c
Author: Tao Cui <cuitao@kylinos.cn>

sched_ext/scx_flatcg: make cgv_node_less() wraparound-safe

cgv_node_less() compares cvtimes with a plain <, which breaks once
cvtime wraps. Compare with (s64)(a - b) < 0 instead, as CFS does for vrunti=
me.
A cyclic comparison is valid as an rbtree comparator only because
cgrp_cap_budget() clamps every node to within max_budget behind
cvtime_now.

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

[ ... ]

[Severity: High]
This is a pre-existing issue, but does using __sync_fetch_and_sub() with a
self-referencing argument cause double-counting of concurrent time addition=
s?

In tools/sched_ext/scx_flatcg.bpf.c:cgrp_cap_budget():

    delta =3D __sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);

If fcg_stopping() concurrently updates cgc->cvtime_delta using
__sync_fetch_and_add() without holding cgv_tree_lock, can this
sequence occur?

CPU 1 executes cgrp_cap_budget() and reads the second argument (the amount
to subtract), getting the current value (e.g., X).

CPU 2 executes fcg_stopping() and concurrently adds Y, making the memory
value X + Y.

CPU 1 executes the atomic subtract of X from X + Y, returning the old
memory value of X + Y, but leaving Y in memory.

CPU 1 then processes delta as X + Y, while Y remains in memory.

Could this result in the concurrent addition Y being processed immediately,
and then remaining in memory to be processed again later, incorrectly
calculating the CPU share for the cgroup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901024038.7304=
24-1-cui.tao@linux.dev?part=3D2
