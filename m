Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49255403E9E
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 04:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784608105; cv=none; b=F6bClgsGZtjRC2jGuDSwwfKAUzsCboiqACcq8SlB9WLAfQ4drzWVPiGRzLP/MBq79WFFECQAPQmfnjvdk3tn11nMa9s9E68yMHNWVPCHno5PfVyQ6Q8esZdw8eTPBIqTOsTMRF4sq0aEWksvlyMcm+p7dbIEbIyya3LDBvgZQE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784608105; c=relaxed/simple;
	bh=PrXIV+O6EjK9VB1pfJpUjXKRL/d5xXyqilodVSjVc4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ih+ciJOAZAAhNHY7pnjhn+JZODUda8V7F0r0cWYGO/eawGIyWNKWrbyv2Q3pRd4rza4Ssc8hzkrfTGvAxhASbwVmZ1cCrWPM7006CrbRNkL/ZDzxAWVy2xDCJOWSeNMnyD38Eo9AfoekQ72DJcux48V39wNy+6HKzrTLDbcyWh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvqqmjHV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvqqmjHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9901A1F000E9;
	Tue, 21 Jul 2026 04:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784608103;
	bh=ECx0lZULKz1wcSrwQtwMHDH8RPnQUdLUO4Mlp6DTbM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KvqqmjHVS0fhPt3jRUnb9h9pc7CTbYdTMpUTrgnoVn+dMhPOpj1jkMr/T7kEQ4Vcv
	 1XIRWP1Nw0RfdsJI4cEIKa0+Allic4fLByi/3csgqqikzegitJMKenfCK6xOIj80PR
	 ZmnG/YRaT0/bJNQL0OJvh2tTm2O5nh0ryVLVHDgfDW16oRAjYAm2LwS7waoALseSG2
	 tc1nQl443u9ae2QNVOJK/TA635wN9nFhwaD9mvW0wZrn6CFQ+xbygKLDWRDU2Fl4TT
	 0TYF9whFUt0HtlXuAUggSs9Hz2pjLvynGGtxPaBcGyZWfzkr1eprlNuIH4/lg9qyUy
	 r8ntco9kqFIKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v5 1/4] bpf: Fix potential UAF in
 bpf_netns_link_update_prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721041048.1394085-2-pulehui@huaweicloud.com>
References: <20260721041048.1394085-1-pulehui@huaweicloud.com>
 <20260721041048.1394085-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 04:28:23 +0000
Message-Id: <20260721042823.9901A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to `link->prog` in generic link VFS operations (`b=
pf_link_show_fdinfo`, `bpf_link_get_info_by_fd`, and `bpf_mprog_link`) can =
lead to Use-After-Free if `BPF_LINK_UPDATE` executes concurrently.
--

--- Patch [1]: [PATCH bpf v5 1/4] bpf: Fix potential UAF in bpf_netns_link_=
update_prog ---
commit 5e4c7fbc6ffdce928d3526471c4a856d31dd1aba
Author: Pu Lehui <pulehui@huawei.com>

bpf: Fix potential UAF in bpf_netns_link_update_prog

This commit fixes a potential Use-After-Free (UAF) in
bpf_netns_link_update_prog by moving the checks for old_prog and
new_prog->type inside the netns_bpf_mutex lock. This prevents a race
condition when multiple threads concurrently execute BPF_LINK_UPDATE on
the same network namespace link.

> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
> index 25f30f9edaefd..9fc62db1441c6 100644
> --- a/kernel/bpf/net_namespace.c
> +++ b/kernel/bpf/net_namespace.c
> @@ -171,13 +171,17 @@ static int bpf_netns_link_update_prog(struct bpf_li=
nk *link,
>  	struct net *net;
>  	int idx, ret;
> =20
> -	if (old_prog && old_prog !=3D link->prog)
> -		return -EPERM;
> -	if (new_prog->type !=3D link->prog->type)
> -		return -EINVAL;
> -
>  	mutex_lock(&netns_bpf_mutex);
> =20
> +	if (old_prog && old_prog !=3D link->prog) {
> +		ret =3D -EPERM;
> +		goto out_unlock;
> +	}
> +	if (new_prog->type !=3D link->prog->type) {
> +		ret =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +
>  	net =3D net_link->net;
>  	if (!net || !check_net(net)) {
>  		/* Link auto-detached or netns dying */

[Severity: High]
This isn't a bug introduced by this patch, but it looks like other generic
link VFS operations might suffer from a similar concurrent update issue.

Functions like bpf_link_show_fdinfo() and bpf_link_get_info_by_fd() in
kernel/bpf/syscall.c, and bpf_mprog_link() in kernel/bpf/mprog.c read
link->prog locklessly without holding rcu_read_lock().

If a userspace thread calls bpf_link_get_info_by_fd():

kernel/bpf/syscall.c:bpf_link_get_info_by_fd() {
    ...
    info.prog_id =3D link->prog->aux->id;
    ...
}

And a context switch occurs just before accessing link->prog->aux->id, coul=
d a
concurrent thread executing a BPF_LINK_UPDATE command on the same link repl=
ace
link->prog and call bpf_prog_put() on the old program?

If the RCU grace period expires before the preempted thread resumes, would =
this
result in a Use-After-Free when accessing prog->aux->id?

Similarly, in bpf_link_show_fdinfo(), could reading prog->tag and prog->aux=
->id
locklessly trigger the same race?

kernel/bpf/syscall.c:bpf_link_show_fdinfo() {
    ...
               prog->aux->id);
    ...
}

And in bpf_mprog_link(), could dereferencing link->prog->type locklessly
result in reading freed memory?

kernel/bpf/mprog.c:bpf_mprog_link() {
    ...
    if (type && link->prog->type !=3D type) {
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721041048.1394=
085-1-pulehui@huaweicloud.com?part=3D1
