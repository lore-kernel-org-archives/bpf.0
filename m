Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28227CCE0
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206346; cv=none; b=czK+MLiUtEy+6GFPAgUMPYTaVp0vjOZIyF52WJyYveYWBI+/GduFzpjCKj7fyktq0XlUoHj6zDomkasJzc4als7aAPiqoZ6VpzjJ6BPhIcqkJNGi4lQKJrtM2dXPmogR1fhptgwjs1Mn8est4J1JDVgpjkaodl8XYElp7FC36Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206346; c=relaxed/simple;
	bh=v2LsHiqJ+crjzKaHY85oT2H5A8FQu+zsipWKzgnz+CE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B3ZqyG+QWcnnvWyQIGVwvil7DKKGTBAFYzJhWKqTd7Z6opNmk3ACFMcDU2hrTD7BBzHxaHJyyiImbvsanR3OyZe9POd7YS3Vh/T6pI0jQg4kW+FiHgKYTTZYurhKLLTvlUHnJeuDh9arb95dT7JnQXZDqm8ASzp+A8BMnQa7Svg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxBdYt08; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxBdYt08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF9A1F000E9;
	Tue, 28 Jul 2026 02:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785206345;
	bh=GoQtLB4s0Y0NKreArpKs8OEXfIXMQAcTITSlqgTq0ck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UxBdYt08B2j7IsZFjO1thlv8yZK/slztnMt0MG7lLt5R1lZi4LjQF1tU0WjUZcUEw
	 Ii1l+fZh/DjHvxh6ScXI6VOhu9R6DbpAZO5OnQH/a5jYCKFriwVK/KQW1nPmF/+QSj
	 8x/ZSRtVsyZ9sSGplbuXWPfgwg8VmrksOYA4lpoWx5l4gbMUygO4qSVjmrZ8WUmHYm
	 +/S/hn+O6Ju/heIoCw+Kfv6KEMyzStEZEJBy6WxACvXcnq2V0hxuDmMZG4/2rEUM0X
	 wf0BLPjG4isAmlGm8usMsgd65Cb6j3dqYz3WeK1HjM7l6B19+ViSMc8sfoLZsziTCG
	 SjwptJzkgD+SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: Fix potential UAF in
 bpf_netns_link_update_prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260728023259.2813482-1-pulehui@huaweicloud.com>
References: <20260728023259.2813482-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 02:39:04 +0000
Message-Id: <20260728023904.CCF9A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lockless, unprotected access to `link->prog` fields allows Use=
-After-Free and TOCTOU bugs when a link's program is updated concurrently.
--

--- Patch [1]: [PATCH bpf v2] bpf: Fix potential UAF in bpf_netns_link_upda=
te_prog ---
commit afa2c5a0786c29e2f3227e6c9b10cbfcd8407bc9
Author: Pu Lehui <pulehui@huawei.com>

bpf: Fix potential UAF in bpf_netns_link_update_prog

This commit fixes a potential use-after-free in bpf_netns_link_update_prog
by moving the checks for old_prog and new_prog->type inside the
netns_bpf_mutex critical section. It also uses guard(mutex) to simplify
lock management.

Link: https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@huaw=
eicloud.com [0]

> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
> index 25f30f9edaefd..81006a242618d 100644
> --- a/kernel/bpf/net_namespace.c
> +++ b/kernel/bpf/net_namespace.c
> @@ -171,33 +171,28 @@ static int bpf_netns_link_update_prog(struct bpf_li=
nk *link,
>  	struct net *net;
>  	int idx, ret;
> =20
> +	guard(mutex)(&netns_bpf_mutex);
> +
>  	if (old_prog && old_prog !=3D link->prog)
>  		return -EPERM;
>  	if (new_prog->type !=3D link->prog->type)
>  		return -EINVAL;
> =20
[ ... ]
>  	old_prog =3D xchg(&link->prog, new_prog);
>  	bpf_prog_put(old_prog);

[Severity: Critical]
This is a pre-existing issue, but can this concurrent update race with
lockless readers of link->prog in other parts of the code?

For example, in bpf_link_get_info_by_fd():

kernel/bpf/syscall.c:bpf_link_get_info_by_fd() {
    ...
    if (link->prog)
        info.prog_id =3D link->prog->aux->id;
    ...
}

Or in bpf_link_show_fdinfo():

kernel/bpf/syscall.c:bpf_link_show_fdinfo() {
    ...
    const struct bpf_prog *prog =3D link->prog;
    ...
    if (prog) {
        bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
    ...
}

Could these lockless reads lead to a use-after-free if a thread executing
bpf_netns_link_update_prog() swaps link->prog and drops the reference to
old_prog, and the RCU grace period elapses before the reader accesses the
freed program's fields?

Similarly, in bpf_mprog_link() in kernel/bpf/mprog.c:

kernel/bpf/mprog.c:bpf_mprog_link() {
    ...
    if (type && link->prog->type !=3D type) {
        bpf_link_put(link);
        return -EINVAL;
    }
   =20
    tuple->link =3D link;
    tuple->prog =3D link->prog;
    ...
}

Could this lead to a time-of-check to time-of-use error or a dangling
tuple->prog pointer if a link update occurs concurrently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728023259.2813=
482-1-pulehui@huaweicloud.com?part=3D1
