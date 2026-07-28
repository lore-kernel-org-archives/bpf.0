Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB2F3AE1A9
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245842; cv=none; b=GbfOGn+nfWdTYn/fLPekbRn7jlcn6F8MuWC9Aa2R4X16FRI+1/1ybohHx5vUOF2Ho4Ne9eGmR7HLgPa1+67+gVzOXP2UahisyZgl4hus/xdm6sFP9AvcDK72kXObvhJT9nVbcoeAJXSAfQHNNUk1R9uK4Q4bE2TgPWqoLa8fItg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245842; c=relaxed/simple;
	bh=OsQS28snu694awNh5VfXkbyD/mvcAViP1XZYcEH371M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D60bLklGFgDLR8eRdxFebW/RiDlwFuxcJp8d8JMMwfc/N6wPTsDstVaR1tldap1FoO2A/CFm/vCk0AFJxNZVyiXsnzetPkiadX+uuKm8zFDyq9v0TpJCKpQnFWKt2vU16xFkpkXlvArNYgkIdomtRtzy2TzjloY4PPK1UXhMS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVFfPtKD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVFfPtKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAFA1F00A3A;
	Tue, 28 Jul 2026 13:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785245839;
	bh=MYkIICDsqoFAls1+GQXDhi+xxDvrTVTI6+Bacg9pFIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JVFfPtKDK5oizezPY4iQYB9jwWn5TxSr44SN4gMRa5PJAH+NBiE6xehA7BO2xBQIh
	 s+2MA+VkMmWIFvfHNJ2oTNMi+z6S68mkwz3IprB66yqHFeDS3WG1NC2ozAlbLsG9BY
	 CyqxUzF0c9jCt1KAaqZIul6y3DopDimp+4PwZFNf04yncEvzUT8yE8LOQxfY8euzkv
	 EheHbhsjKHDOFnSfsg+y+3PsIWPBGqk2rUXEzfeIhZ0PpWueGiYyrYMBNHahM/d5H7
	 NmoUxLkJTbg60hlqgxydaedBGoFC4rbf6gbASbLIO7mjgUdeQnPdSa+Kapp0b6a/iE
	 sYttJrytZGJqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, cgroup: Fix potential UAF in
 __cgroup_bpf_attach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260728132336.2857800-1-pulehui@huaweicloud.com>
References: <20260728132336.2857800-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 13:37:18 +0000
Message-Id: <20260728133718.DFAFA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Replacing a `bpf_link` in single-attach mode leaks the old link, i=
mbalances the static key, and causes cross-destruction of the new attachmen=
t when the old link is closed.
--

--- Patch [1]: [PATCH bpf] bpf, cgroup: Fix potential UAF in __cgroup_bpf_a=
ttach ---
commit b6405e259cc6a35d8ca8d34002993bcc191a22c5
Author: Pu Lehui <pulehui@huawei.com>

bpf, cgroup: Fix potential UAF in __cgroup_bpf_attach
   =20
When replacing an existing bpf_link in single-attach case in
__cgroup_bpf_attach, old_prog is NULL while old_link holds the active
link. This patch fixes an issue where the cleanup path wrongly treated
the existing entry as newly allocated, properly restoring state on error.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 4355ccb78a9c6..1c070ae7bf170 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]

> @@ -865,6 +868,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
> =20
>  	if (pl) {
>  		old_prog =3D pl->prog;
> +		old_link =3D pl->link;
> +		old_pl_flags =3D pl->flags;
> +		bpf_cgroup_storages_assign(old_storage, pl->storage);
>  	} else {
>  		pl =3D kmalloc_obj(*pl);
>  		if (!pl) {

[ ... ]

> @@ -912,15 +919,18 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>  		bpf_trampoline_unlink_cgroup_shim(new_prog);
> =20
>  cleanup:
> -	if (old_prog) {
> +	if (old_prog || old_link) {

[Severity: High]
This is a pre-existing issue, but since we are properly handling old_link
in the error path here, should we also address it in the success path?

If old_prog is NULL (which happens when replacing a bpf_link in
single-attach mode), the success path right above this cleanup label does
the following:

	if (old_prog) {
		if (type =3D=3D BPF_LSM_CGROUP)
			bpf_trampoline_unlink_cgroup_shim(old_prog);
		bpf_prog_put(old_prog);
	} else {
		static_branch_inc(&cgroup_bpf_enabled_key[atype]);
	}

Since old_prog is NULL, this takes the else branch and incorrectly
increments the static key, while completely leaking old_link.

When the leaked old_link's file descriptor is eventually closed,
bpf_cgroup_link_release() will call:

	WARN_ON(__cgroup_bpf_detach(cg_link->cgroup, NULL, cg_link,
				    link->attach_type, 0));

In single-attach mode, this blindly detaches the active entry (which is
now the newly attached program or link). This unexpected detachment could
corrupt the cgroup BPF state and lead to a use-after-free of the new
program.

>  		pl->prog =3D old_prog;
> -		pl->link =3D NULL;
> +		pl->link =3D old_link;
> +		pl->flags =3D old_pl_flags;
> +		bpf_cgroup_storages_assign(pl->storage, old_storage);
>  	}
>  	bpf_cgroup_storages_free(new_storage);
> -	if (!old_prog) {
> +	if (!old_prog && !old_link) {
>  		hlist_del(&pl->node);
>  		kfree(pl);
>  	}
> +	cgrp->bpf.flags[atype] =3D old_flags;
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728132336.2857=
800-1-pulehui@huaweicloud.com?part=3D1
