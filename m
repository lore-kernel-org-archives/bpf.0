Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505319;
	b=z1k3RNsQGHrJg9rAsR0EhA/9uOtaMhsoqmpJw9tpJyuQBZGGKXTdTQBSKb849jx+AQB7
	 R3oFtsTbZNyQPDkAnboOpReD2FbCI7vSfKyqu3xgwA/wpKwxA5QLnUjPkf96HlgGzLXk9
	 QQq9crqDBP3hSM6tCAjTiiAWVqQwyALTB6ZxRTun+uyEXjaauce2464x6y/Vnrii3AZH8
	 nV9NYp/AjTt2JMc/AerBI7GI8N15+FqtzZftTM8H+8DS3U2HUjO4HIeVRLaEnRdvf8cfd
	 YWT+J4tJo9/gi/OjTnhCzcOxq0nj4r/i7FiNEfqrlOeoTR6H7Bi/Q451CaWN/hfJ5sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505319;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bxgTpxD49+1W6N2PhN39OWU+VyXn6pcS6qCNbnjMUwA=;
	b=ccLKjFBUdkcXR0jatcxq1n0sH97u8jMNRPe3nOq8tlyAwozLy5FE7ME5RZoMs9NXBStR
	 iCYe3KlFAFeorgi76gomgsCySWqFN4wP8929ps0lTaMMyyxaB/yNKeeXCRBK6TsRRWzDv
	 zJ7dS8CpVPP2DdQIk8DRKLKHok2rNnEEkto4AnStN1qlz7GWPsfsxVTu+nd5RCttJ5eZy
	 nuJSooiSQ+0sA7Hwfy57dpQaVio2AxyNUukAmQ5pIh0zWGOPZQucbKjOcUXjvX5ikvrCq
	 Y0isI698tc0q4ZGExzUiaUPt6eIi4QP3tryxXnKY6l5miBnDdG4wYfFC/OWNANRg1Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bM63jO19;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7412606A8A8
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bM63jO19
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A081F000C4;
	Thu, 12 Nov 2026 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505318;
	bh=bxgTpxD49+1W6N2PhN39OWU+VyXn6pcS6qCNbnjMUwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bM63jO19frTnl8Qv/YyrHFTCdhN4Mozj8RxOE8qvwtsIG0wwV+ZiaAVe20fkSWS6b
	 W7qqRcZhlIIK9frAJQnh5c/SsRuG0WAu0y4Ll91ny9bDF3wUFjfiCz1bnX9eV0ldTm
	 0f/VzFhgm2a+3sC5bc9pUn2628mMdTsRsOTjr4wrBEiThyZVkj6k6MbUwi8TN96FrX
	 +zviXcKljTl4XKSnrsI6swgrIulR/pqYK9mochAuBlr0CNIloH6y/Ghypkrep82xNw
	 eyWCkyTVRBSNf3AEhzlVwgrOhbQ9n71HIc8Fu8VDisQShNWCdtwlzCxctmB+f9lP+z
	 EQv5Up5xs/ytA==
Message-ID: <sashiko-outbox-211618@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/3] bpf, cgroup: Protect cgroup_bpf state with
 its own mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shakeel Butt" <shakeel.butt@linux.dev>, bpf@vger.kernel.org
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261112172721.440275-4-shakeel.butt@linux.dev>
References: <20261112172721.440275-1-shakeel.butt@linux.dev>
 <20261112172721.440275-4-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 17:41:57 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] bpf: lost error codes in __cgroup_bpf_query() [1]
--

commit 20190389f8922442abed742617dfa9e59bf26340
Author: Shakeel Butt <shakeel.butt@linux.dev>

bpf, cgroup: Protect cgroup_bpf state with its own mutex

This commit introduces a dedicated cgroup_bpf_mutex to protect cgroup BPF
state so that operations not modifying the hierarchy do not have to contend
on cgroup_mutex.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 334237096759f..ae082ac86130b 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]

> @@ -1518,7 +1565,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>  	for (atype =3D from_atype; atype <=3D to_atype && total_cnt; atype++) {
>  		if (effective_query) {
>  			effective =3D rcu_dereference_protected(cgrp->bpf.effective[atype],
> -							      lockdep_is_held(&cgroup_mutex));
> +							      cgroup_bpf_held());
>  			cnt =3D min_t(int, bpf_cgroup_array_length(effective, atype), total_c=
nt);
>  			ret =3D bpf_cgroup_array_copy_to_user(effective, prog_ids, cnt, atype=
);
>  		} else {

[Severity: Medium]
This problem wasn't introduced by this patch, but can assigning ret from
bpf_cgroup_array_copy_to_user() drop an earlier -ENOSPC or -EFAULT error
[1]?

Before the loop, __cgroup_bpf_query() sets ret =3D -ENOSPC when
attr->query.prog_cnt < total_cnt:

kernel/bpf/cgroup.c:__cgroup_bpf_query() {
	...
	if (attr->query.prog_cnt < total_cnt) {
		total_cnt =3D attr->query.prog_cnt;
		ret =3D -ENOSPC;
	}

	for (atype =3D from_atype; atype <=3D to_atype && total_cnt; atype++) {
		if (effective_query) {
			...
			ret =3D bpf_cgroup_array_copy_to_user(effective, prog_ids, cnt, atype);
	...
}

When effective_query is set, bpf_cgroup_array_copy_to_user() overwrites
ret with 0 when the truncated slice fits in the array, or a later
iteration (for BPF_LSM_CGROUP) can overwrite an earlier -EFAULT, causing
__cgroup_bpf_query() to return 0 on truncated or faulted queries.

[1] https://sashiko.dev/#/bug/linux-20442c38-bcc8-440c-9711-1977ea6cd04b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112172721.4402=
75-1-shakeel.butt@linux.dev?part=3D3
