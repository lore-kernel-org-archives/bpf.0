Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810342255C
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909735; cv=none; b=J32OMOU+Cjpw0lwt85t+No+MAg2vJAbkNRCAne/To8UCqL5a7BooGvhatn7zgcnXVU3LXHHaamaacYspYlgICWsFEJW4lEP4ONm2xfsePFFQz/JpkkqtDm3evdSVmF8HJccLkafzNSN7Z5XmI+TD40cZhifLlamSjO4+OV768ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909735; c=relaxed/simple;
	bh=W7BQJ5um/H8NLeCBuOz41naOBO3HvSSlAKpUQWVkHYM=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=aQzjCj3hkkyVA/iqdsakV6CjrhUWHV6AuqvIIyG2dVF2O3NWpCBJisAAUPuMDNSwiHBuom1hQKO8hwNH7TfSRxClGsw8+4AiS+22lztXBxqF5x8/bWc9fMzY2wEpjHQ7R2C9/t4KPM1YLaeI/PPEmKy3Md6r2Afw+3NTmA7J+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egJAeOC/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egJAeOC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD11A1F000FF;
	Tue, 13 Oct 2026 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909733;
	bh=5ZVK2bzk9A84Yz7oS+Qc92WMMk8fAqbc2YTUC5YYLYk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=egJAeOC/LaxRkenZsaKOdBUtazwjTwtSP/qdJB/v7W8s4rIlUefL58D6mJP5MVFZ4
	 w3X4xw8qLBxyv+HPOgddDg/N/nAb+n9kwnxr0VCWc4ksJOg+59DQEC7JbmFuahpe6M
	 FPD2Rn2MeoV0nqMa/DqPGxgVr3aE33b+l0i8knOprcBdWREMjtCxvnXGZuGYwZ1fRk
	 jTEc0D5T5UN172W4qGnp3Mx/hYE/nNKhivMLG+WmO/Ptp+sjuVysZmfDfaT/wNAGPL
	 FtWelMTA7Ch5MTydWrqfsLngqN4Z+QwFwHbFwWvWKfPRaY2s+XbmksFqhtb3cdxK3O
	 83IgoICUfPqLA==
Message-ID: <sashiko-outbox-170139@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: allow ksock kfuncs call from wq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261013163101.205638-1-mahe.tardy@gmail.com>
References: <20261013163101.205638-1-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:42:13 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: bpf_ksock_create causes NULL pointer deref on task exit
- [High] bpf: bpf_ksock_create in workqueue escapes network namespace
--

commit 34ed977b7943eebacf7e605dc8f26f2576ba2664
Author: Mahe Tardy <mahe.tardy@gmail.com>

bpf: allow ksock kfuncs call from wq

This commit relaxes the constraints on ksock kfuncs by removing the check
that ensures they are executed in a user task context. This change was
made to allow ksock kfuncs to be invoked from asynchronous workqueues,
bypassing the original LSM hook considerations.

> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> index e9943aeeadd32..21d5fd1eb403d 100644
> --- a/net/core/bpf_ksock.c
> +++ b/net/core/bpf_ksock.c
> @@ -73,16 +64,6 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *o=
pts, u32 opts__sz,
>  	struct bpf_ksock *ks;
>  	int err;
> =20
> -	/*
> -	 * sock_create() derives the network namespace, credentials, and cgroup
> -	 * from current. Kernel threads, including BPF workqueue callbacks, do
> -	 * not carry the context of the task that invoked the BPF program.
> -	 */
> -	if (!bpf_ksock_has_user_task_context()) {
> -		err =3D -EOPNOTSUPP;
> -		goto err_out;
> -	}
> -

[Severity: High]
Does removing this check expose us to a NULL pointer dereference during task
exit?

If a sleepable BPF program running via task_work during do_exit() calls
bpf_ksock_create() after exit_nsproxy_namespaces() has cleared
current->nsproxy, it appears this could trigger a kernel panic.

Without the bpf_ksock_has_user_task_context() guard, bpf_ksock_create() will
now unconditionally call sock_create():

net/socket.c:sock_create() {
	return __sock_create(current->nsproxy->net_ns, family, type, protocol, res=
, 0);
}

Is it safe to allow sock_create() to dereference current->nsproxy here with=
out
checking if it is NULL?

[Severity: High]
Additionally, does this change allow containerized workloads to escape their
network namespace?

When bpf_ksock_create() is invoked from a workqueue callback, the executing
context is a kthread.

Because sock_create() uses current->nsproxy->net_ns, a kthread will resolve
this to the host namespace (init_net), causing the socket to be created in =
the
host namespace rather than the container's netns.

Could this allow BPF programs inside containers to bypass container routing
and firewall policies by creating host-namespace sockets?

>  	if (!opts || opts__sz !=3D sizeof(struct bpf_ksock_create_opts)) {
>  		err =3D -EINVAL;
>  		goto err_out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013163101.2056=
38-1-mahe.tardy@gmail.com?part=3D1
