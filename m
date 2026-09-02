Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE19081724;
	Wed,  2 Sep 2026 03:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788318193; cv=none; b=jS6b1mm7AnOmrCYSfQbAGj2nboJnc73IHF6CfK3HZDIXKe9wAdFFrFFFtXDdlkIX8CxqvQna9YJr5WrGZW3omclOxp0RXaqL2KdvwoiBA6SnRH+iqgX7EITPZiHVMabpT/D/vcozupQN/ncNPvHqsBoaRSjODT2L3uIooznW8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788318193; c=relaxed/simple;
	bh=Ra17aOp1PBdGrZVa7ycjHzC10hcTBqip7TI3O02pcbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ug1SWmubY5K2UUCqxcpznud7mpkEnAHz/mANd7gFZKCOArevrVUlIGko+fIh+wRqPKZwnQ3T9hhdE2BaDkf/SV6vPX+gOmNKnGoGRRb7qWTLD+hz8oBJDNpYWhMSUdd6rp6Osv6NY/njFTM9FQz8pHPmHkLK2LH33gBCmdJnkJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOm1+9OW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOm1+9OW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A3F1F000E9;
	Wed,  2 Sep 2026 03:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788318191;
	bh=dl8oTB6DdwkOLdmdai6fx/C47kIEgRoEDTOpE+1lv2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EOm1+9OWcSbrboGxTgqk6pL4YRrSTNGuo8J/wKM58BWgrMolbgR64FvwI9ePrmkLg
	 7HhjFgLDmu5gsDQvtth8vYrAz5CBgDntU8LkLaRVBb3m45i0dkLK8DbOF+csiV5DVB
	 IZ4YdQryldJL9qUFaI497bMh+KeczbFqj7hTIr0lJDOmB5rwKKehV7xdxRg+AYq1Jm
	 ZDeEKowbWLYFgQacx9TkbKuH4StH0+v8KR3ZrZbOa5b/etjXaAjAWyZjoi9GFtjPoV
	 fHvxEOxKiMif3OaOfCxemWCkPdTYPsSa/Y2eZS2okwehLBumnsl4q8qxqkHGD6qdc7
	 HSSjqeAXnOFoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] sched_ext/scx_flatcg: make cgv_node_less()
 wraparound-safe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260902024812.794879-3-cui.tao@linux.dev>
References: <20260902024812.794879-1-cui.tao@linux.dev>
 <20260902024812.794879-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 03:03:10 +0000
Message-Id: <20260902030311.65A3F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsigned division on a wrapped negative time delta causes massive =
artificial inflation of virtual time for expired cgroups.
- [Medium] Race condition in cvtime_delta extraction using __sync_fetch_and=
_sub(ptr, *ptr) causes double accounting.
--

commit 069998f7546e450b1de3ae56c137b9e1dd16b919
Author: Tao Cui <cuitao@kylinos.cn>

sched_ext/scx_flatcg: make cgv_node_less() wraparound-safe

cgv_node_less() compares cvtimes with a plain <, which misorders once
cvtime wraps: the wrapped node lands at the front of the tree while
the unwrapped ones get stuck behind it. Each CPU picking a cgroup
charges it a full slice, making wrap occur earlier than a naive
estimate might suggest.

Link: https://lore.kernel.org/r/3f1ce004-e259-4e72-a5f7-14a5050053bd@linux.=
dev

> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatc=
g.bpf.c
> index fec3595818269..acc1995630e6d 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
[ ... ]
> @@ -144,7 +144,7 @@ static bool cgv_node_less(struct bpf_rb_node *a, cons=
t struct bpf_rb_node *b)
>  	cgc_a =3D container_of(a, struct cgv_node, rb_node);
>  	cgc_b =3D container_of(b, struct cgv_node, rb_node);
> =20
> -	return cgc_a->cvtime < cgc_b->cvtime;
> +	return time_before(cgc_a->cvtime, cgc_b->cvtime);
>  }

While reviewing this file, I noticed a couple of pre-existing issues:

tools/sched_ext/scx_flatcg.bpf.c:cgrp_cap_budget() {
    ...
	delta =3D __sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);
	cvtime =3D cgv_node->cvtime + delta;
    ...
}

[Severity: Medium]
This isn't a bug introduced by this patch, but does this create a race cond=
ition
that leads to double accounting?

Because __sync_fetch_and_sub(ptr, *ptr) evaluates the second argument before
the atomic subtraction, a concurrent __sync_fetch_and_add() from another CPU
between the memory read of cgc->cvtime_delta and the atomic subtraction
will cause the added delta to be subtracted but still partially left in the
counter. The atomic operation returns the new value, charging the cgroup for
the increment, but leaves the increment in the counter to be charged again =
on
the next extraction.

If CPU A executes fcg_stopping() or fcg_dispatch() and calls
__sync_fetch_and_add(&cgc->cvtime_delta, val), and concurrently CPU B
executes cgrp_cap_budget() and evaluates
__sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta), a race in the
tiny window between B's argument evaluation and the atomic subtraction could
trigger double charging.

Could this be replaced with an atomic exchange (e.g.,
__sync_lock_test_and_set()) to safely extract and clear the counter?


tools/sched_ext/scx_flatcg.bpf.c:fcg_dispatch() {
    ...
		bpf_spin_lock(&cgv_tree_lock);
		__sync_fetch_and_add(&cgc->cvtime_delta,
				     (cpuc->cur_at + cgrp_slice_ns - now) *
				     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));
		bpf_spin_unlock(&cgv_tree_lock);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this calculation suffer=
 from
unsigned division on a wrapped negative time delta?

When a cgroup's slice has expired, the current time 'now' can easily be gre=
ater
than 'cpuc->cur_at + cgrp_slice_ns' due to interrupt latency or normal
scheduling jitter. The '(cpuc->cur_at + cgrp_slice_ns - now)' is computed u=
sing
unsigned u64 arithmetic, resulting in a wrapped large positive number. Since
all operands are unsigned and hweight is a u32, the subsequent multiplicati=
on
and division execute as unsigned arithmetic.

The resulting huge positive quotient is then added to cgc->cvtime_delta,
artificially inflating the virtual time by a massive amount and potentially
starving all tasks within the cgroup.

Should there be an explicit cast to a signed type (like s64) before division
to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902024812.7948=
79-1-cui.tao@linux.dev?part=3D2
