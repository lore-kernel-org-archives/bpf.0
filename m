Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4360147043F
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705786; cv=none; b=Of53Ovi1id/COMGsUftSR1Ra6w0diEw+N3DR+ZmYzW3iiFDEBeeOaOL70QO+MUv93RnGsYxRKmRXhMdsV1aoltuRc/n8i59yeDIhtg+ZmHMZklOTLQIZX51zyzZI53cgTDbUhsMPAuBragYacBWp9JNma3jGZATkdqUWOd7AyOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705786; c=relaxed/simple;
	bh=vCILx3PNWMlOaGBY7kq/mgw052Xs6QR/tLpz4S21Ma8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nCiYYEN+0NiuViKIIMQOoZMrE8WeDmGKqmAKTmLv180/AL924s20ThKkSuzqUacO7afVyllaWC0L+UZ1dzEivY+NOvpn/kh4OaHT/gF8u6q2RbHwvcN5/JlX9JGwNbRwMTwpZBsEQyXdSHn34t2klI66ST0V7/ARhqGbzQjwSCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVPwOUzP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVPwOUzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAAC1F000E9;
	Wed, 22 Jul 2026 07:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784705785;
	bh=ws0sWm4uWtCLFV4G2UvCYhgWdxJx7mYaZ85f9F1VXQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aVPwOUzPgt01yarEI3CyRN4w1CeGzYjKMfwUzOHhJ87TFwReMTGhruOkDrN8wwG+c
	 5i7vm9rkrHAA9DYbaTkjZBblv7MnMr4KNERf5swc5NpcBrj/o65+d++p63C4xRAzDw
	 Edfyh0wnDwSJCa/dluDSjnDnqyPI9ExqHbwo699BHavLgK0tiC4xTJSKU07TS/op28
	 MO04g7WrcKSIJV01keAdeVhKeWusA0mmEqWxonzwlvHoRvaRqmApWjkXH1xKe0rVM/
	 j3BtnVDw9q3fnSZOP3VnX5GdpdZ7MDTZh6RWwzHEQP2UR7eMOtssuM6vFrZ+NybWMI
	 AqOtJJynSq7/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v6 1/4] bpf: Fix potential UAF in
 bpf_netns_link_update_prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722072326.1545677-2-pulehui@huaweicloud.com>
References: <20260722072326.1545677-1-pulehui@huaweicloud.com>
 <20260722072326.1545677-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:36:24 +0000
Message-Id: <20260722073624.CEAAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting Use-After-Free in generic bpf_link information retriev=
al and mprog attachment due to lockless access to link->prog.
--

--- Patch [1]: [PATCH bpf v6 1/4] bpf: Fix potential UAF in bpf_netns_link_=
update_prog ---
commit d5c566078955c1f4dfc1d9f1e23e9f6213c3dcfb
Author: Pu Lehui <pulehui@huawei.com>

bpf: Fix potential UAF in bpf_netns_link_update_prog

This commit fixes a potential use-after-free issue in
bpf_netns_link_update_prog() by moving the old_prog and prog->type checks
inside the netns_bpf_mutex critical section.

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

[Severity: High]
This isn't a bug introduced by this patch, but while this change fixes the
concurrent update race in bpf_netns_link_update_prog(), could the subsequent
xchg() of link->prog cause a use-after-free regression in other functions
that read it locklessly?

If a user-space application concurrently calls bpf_obj_get_info_by_fd() or
reads fdinfo, the retrieval functions read link->prog locklessly without
holding rcu_read_lock(). If the reader thread is preempted immediately after
reading the pointer, and a concurrent link update replaces and frees the old
program, will the reader dereference freed memory?

This can happen in bpf_link_get_info_by_fd():

    if (link->prog)
        info.prog_id =3D link->prog->aux->id;

It also appears in bpf_link_show_fdinfo():

    const struct bpf_prog *prog =3D link->prog;
    ...
    bin2hex(prog_tag, prog->tag, sizeof(prog->tag));

And in bpf_mprog_link():

    if (type && link->prog->type !=3D type) {

Do these lockless accesses need rcu_read_lock() protection to safely read
the program fields when updates can happen concurrently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722072326.1545=
677-1-pulehui@huaweicloud.com?part=3D1
