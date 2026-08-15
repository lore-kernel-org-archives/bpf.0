Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBAF242D62;
	Sat, 15 Aug 2026 05:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786770855; cv=none; b=Vh5O7s78disiHBThye/3FH98vJqy3CshRbPRJFf3gKgGeuI5y81tUji1yuq0I6miZMaCHsnZu9wc2ViYorBXeC5SSHzCXPVkmYdSeciIgfr5gFucX33WDstEPu24xnwz/kvqWzTPnmgnzf6vPQ7VQbu+YFGwS+FKhPhwTg4fGw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786770855; c=relaxed/simple;
	bh=fVrAZuBn9D3+XJALB6SlWuv25Saayv/wWiZcltx1vzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rYhfWl3qBNPSeM9Mz2WGhsNGvpJWeM1ci9oc4ymWp15LAGd6ECiFOG7D7iWlgTKCOuxiqmgDwMUaUytNvae2KHHNclVnO2xjFjhA/Q1KRhgjj37secXP2maOOzx9QqWz3AhgXsiZBsJCupwgvjZlkhxjUJgVAk+i6OCQTc07enE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc0/j7UD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc0/j7UD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DA91F000E9;
	Sat, 15 Aug 2026 05:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786770853;
	bh=vNisZoS8fde1QbnfBhEf3fnChNpaxnOYKkO/NK9idbc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qc0/j7UDv9DMtKJYkKBouDyldFQm3mN/QcvijEZHGcNVfTVDd2lz0GYJWQ5atAoGk
	 oq8rqxloM8+VXgOi9BOphP6XCCyQHfmeZP6pfgTio50WqIjigQ4+Tq+mvxR/VBywg7
	 K8SHwCqRsWlRoLWItF0PxnQ6Nq3GoePAZLGUOHjQ4tBr4va9hZVpDur4clsZt8WQMm
	 d/cOKYy963ekkpLWO28Rpgo+18l02n0bLdKwKKLQQ80H9LfUPEjOHSSFvsvaiIZHsf
	 W+E3dZZjCsSSxxUjlCf7fGC3dCKqTVovp1znxsdCfMlcwt2N0QVQTVS1DzjkLDwYIf
	 hc8lt9AtL2isw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext/scx_flatcg: Fix cvtime true-up on slice
 expiry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260815045905.3431991-1-cui.tao@linux.dev>
References: <20260815045905.3431991-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 05:14:12 +0000
Message-Id: <20260815051412.C8DA91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Priority inversion in RB-tree due to unprotected cvtime wraparound=
 in cgv_node_less().
--

--- Patch [1]: [PATCH] sched_ext/scx_flatcg: Fix cvtime true-up on slice ex=
piry ---
commit c84c79d28fee1a17412c6846489091841b03f293
Author: Tao Cui <cuitao@kylinos.cn>
Date:   Sat Aug 15 04:59:05 2026 +0000

    sched_ext/scx_flatcg: Fix cvtime true-up on slice expiry

This commit fixes the cvtime true-up calculation in fcg_dispatch() when a
cgroup's slice expires or its DSQ runs empty. It addresses a bug where the
unsigned division by hweight was inverting the sign of the delta, causing
massive jumps in cvtime_delta instead of minor corrections. The fix properly
computes the delta as a signed value and uses fetch_and_add()/fetch_and_sub=
()
to keep dividends positive.

> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatc=
g.bpf.c
> index 0fd214cc61dae..ddcf6bc03b11c 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c

[Severity: High]
This is a pre-existing issue, but was not introduced by the patch under
review. Since this file handles cvtime accounting, could the red-black tree
comparison in cgv_node_less() suffer from priority inversion due to cvtime
wraparound?

Looking at tools/sched_ext/scx_flatcg.bpf.c:cgv_node_less():

static bool cgv_node_less(struct bpf_rb_node *a, const struct bpf_rb_node *=
b)
{
        struct cgv_node *cgc_a, *cgc_b;

        cgc_a =3D container_of(a, struct cgv_node, rb_node);
        cgc_b =3D container_of(b, struct cgv_node, rb_node);

        return cgc_a->cvtime < cgc_b->cvtime;
}

If a cgroup with the lowest possible weight (1) advances its cvtime rapidly,
a 64-bit nanosecond counter could wrap around in approximately 3.25 days of
continuous execution.

When a cgroup's cvtime wraps to a small value (e.g., 100) while other cgrou=
ps
are near the 64-bit maximum, the standard < operator will evaluate
100 < (2^64 - 1000) as true.

Would this place the wrapped cgroup permanently at the front of the tree and
completely starve other cgroups? Should this use a wraparound-safe comparis=
on
like time_before64() instead, similar to the time_before() usage elsewhere
in the scheduler?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815045905.3431=
991-1-cui.tao@linux.dev?part=3D1
