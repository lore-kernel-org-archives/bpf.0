Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B68353EDF
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555725; cv=none; b=RbSKsY6YF3vuNzMTOB0sgNGqRmk7NMPpbn8D8Sz5Y6IEoZE7hhkBWuWua31b4MbrzI58dSOlcmYmKSZGEIlO3yoWAmIq8/2tiWApn40UpBBl11mehJSrHvphlEh9BCs1x6yUym0DCmXF4RUwTwmj8iRP7sm0fNLt1Ui7UUSky2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555725; c=relaxed/simple;
	bh=0WUV12pQQp82+/Jivpu6a/p6bQQ5GTYa4FBLUJKhjcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ovBEtkIk9UbkvxFQ7pangug022n04n6CJVnIyN1vmoFukY/AJdr4MfQI/DNe2mL6a8EhV0Lf7lbNHWr3odIsl83vjKdvvMfLj0xFiw5JlJQAGrKkQd3zIWfXYsETcyDjwcuig4MBnvYAOOr/RN0l8yVi2VgXmv/fKB0xsdMlMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md0rGbC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md0rGbC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3461F000E9;
	Mon, 20 Jul 2026 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784555723;
	bh=166MG0fuA9oHN/tLfAvCvwYrL3MlnOD8WHw3K5raWms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Md0rGbC8osPsbVuxE1ilJ35GKvBkLFFrRfSiYl+SvKayvMew9Wx9uXWNVTZkHN6ZV
	 PZOhVxfkOH6fLmM4MbM6FHAgHZo7rFPvpg/fuq0oATWO7XEdCbKg1aSky2NxVDDnkI
	 BjbvwhhhjOFiPimKdMsPT9otdvFVnsF1yGqGJqix+UQiGHbDOA3BgtdK2EDAZpJT96
	 50FASMEAxmoWF+Y3mr2rwgQtbsodPPMtHQ78k+mb01wKRa2YL45SeKOVLAW0l/uYgU
	 qgkRWAsxHXW0cmF1WHkq2Pp8R9IukK0GtZfIurg6lEsoZv9pTPgEPsB+LxY41YeBT4
	 sMMsGLdNKJr8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 1/4] bpf: Fix potential UAF in
 bpf_netns_link_update_prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720134547.1289964-2-pulehui@huaweicloud.com>
References: <20260720134547.1289964-1-pulehui@huaweicloud.com>
 <20260720134547.1289964-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 13:55:23 +0000
Message-Id: <20260720135523.AB3461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to `link->prog` in generic BPF link info retrieval=
 functions and mprog logic can lead to a Use-After-Free when an updateable =
link replaces its program concurrently.
--

--- Patch [1]: [PATCH bpf v4 1/4] bpf: Fix potential UAF in bpf_netns_link_=
update_prog ---
commit 1e9631860a41f1ee87e0b9afa5e2e3ca3f35147e
Author: Pu Lehui <pulehui@huawei.com>

bpf: Fix potential UAF in bpf_netns_link_update_prog
   =20
This commit fixes a potential use-after-free race condition in
bpf_netns_link_update_prog. By moving the old_prog and prog->type checks
inside the netns_bpf_mutex critical section, it prevents concurrent
BPF_LINK_UPDATE operations from freeing the program while it is being acces=
sed.

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
This isn't a bug introduced by this patch, but while looking at the lockless
accesses of link->prog being fixed here, I noticed other places that might
have similar race conditions.

For example, in kernel/bpf/syscall.c, bpf_link_show_fdinfo() reads link->pr=
og
locklessly:

kernel/bpf/syscall.c:bpf_link_show_fdinfo() {
    ...
    const struct bpf_prog *prog =3D link->prog;
    ...
    if (prog) {
        bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
    ...
}

Similarly, bpf_link_get_info_by_fd() in the same file accesses
link->prog->aux->id locklessly, and bpf_mprog_link() in kernel/bpf/mprog.c
checks link->prog->type without locks.

If a user-space thread calls one of these info retrieval functions and is
preempted, could a concurrent BPF_LINK_UPDATE (like tcx_link_update or
the one being fixed in this patch) swap out link->prog via xchg() and free
it?

Since the reading threads do not appear to hold rcu_read_lock() or take a
reference on the program, it seems the RCU grace period could complete,
resulting in a use-after-free when they resume and dereference prog->tag or
prog->aux->id.

Should we add RCU read locks or reference counting around these generic info
retrieval paths to prevent the program from being freed out from under them?

>  	net =3D net_link->net;
>  	if (!net || !check_net(net)) {
>  		/* Link auto-detached or netns dying */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720134547.1289=
964-1-pulehui@huaweicloud.com?part=3D1
