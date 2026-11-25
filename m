Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630224;
	b=IE94M6t4BpPBn0XDTcmb7QrCZG8UhGj53IgHiCWJVcJZJcIho2EwOLvUm8Ns4MfYRsj2
	 IZPoglVxtEHNhAuV+mbZIpiIY+6A0kQYAo613P9/3c1wK8BQwjmvWTuDd/YzoNy1L5miJ
	 onBUMnDtVz+dJL+kiAi3b4X0fF14YVRlj0b7UWtOdERsUuVSRXao6kpgslWnBaba7R0G1
	 NTOWyRgzczIQoa0k6citbexN/qlXxf1SwzIhnTw3EB+z6MfBTlb8r0mgLykhnzQnUHHa2
	 c1HBvoZqmgBBWw197FGy3tpmm1AVL4LXugkYGtS3+bEEXrzws0GECgIJfnLYLtBiI8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630224;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bUPkULm0ERvcOEBaH5LTUpgpgXRHEuozkr4SU7TMIqU=;
	b=aFWFRPx2lL9oZrBNWpLSsPVKePBZr9hCS6uLGPTZZWkCCnIF/yFGaMaa0ht8+xklC7u8
	 NK6yjT8B+sNW+xwigphcyeCQP6TV5wGWncUfR0fDloxNq3jLtrdyeqHyDjP18rAUJABmE
	 w7E89e3v4EsqVpqeK9rBdyEGIdGCyJU9AVYqJWCo4bQbJWy7tSKufNqLTeOMvpfl4dSkZ
	 qdcnfNiV2umb3lR4gLYjbw/l26m7i7jYLW/H++nvoFtuqw0x3Y++v+LpVW3KTsoSHTgE2
	 sPpdnZi4mACT+x3mW25beLJFTA4ZyTyhZs1TrA5MmvIVDRR7IhwLicQLuCvRfpFjG/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYQyImdL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6D606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYQyImdL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43571F000E0;
	Wed, 25 Nov 2026 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630223;
	bh=bUPkULm0ERvcOEBaH5LTUpgpgXRHEuozkr4SU7TMIqU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bYQyImdLvoKj1NlDkP5MgVryZMnLzkSDeKfk35kd6DVRd44UjIzeDsd2ACzu5Jjx5
	 U1dvT0WMIQqF3SrN0R2rBoIwhHPWGX/ehvwT01QDaBtApC/zxLr3AuDbbozWpInQC/
	 /2/iOwD/tw/n49Jb9huHKVkNkdJ7R3UokIo0W9OFJWAB438PyHZDYgrsQ/ITsbLIZu
	 6/Xc80L4iY4y8xaSx9NjAueHe6as16uTqzVLLGTZ28v/zIyhGY2JGtRN5cQWZpZxmI
	 v1sZyR7haCtV8hbtnMt/SiQBzMCCWRMUeWvY+hWUdWyEWVgkkeA2S5Gl6jl9NYyyuZ
	 kMba2U4mcfZOw==
Message-ID: <sashiko-outbox-233914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf, lsm: Mark IPC control hook perm parameters
 nullable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Quan Sun" <m202672221@hust.edu.cn>, bpf@vger.kernel.org
In-Reply-To: <51ae120f0b3cd8c20dbaaf02c9c384dc2afab6bc.1795627805.git.m202672221@hust.edu.cn>
References: <51ae120f0b3cd8c20dbaaf02c9c384dc2afab6bc.1795627805.git.m202672221@hust.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:10:23 +0000
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
- [High] bpf, lsm: missing __nullable annotation on kacl in
  bpf_lsm_inode_set_acl() [1]
--

commit 77496f1a0298baa887511d2928e2317763dbc7b6
Author: Quan Sun <m202672221@hust.edu.cn>

bpf, lsm: Mark IPC control hook perm parameters nullable

This commit adds strong overrides in kernel/bpf/bpf_lsm_proto.c for
bpf_lsm_shm_shmctl(), bpf_lsm_sem_semctl(), and
bpf_lsm_msg_queue_msgctl() to annotate their perm parameters with
__nullable.

> diff --git a/kernel/bpf/bpf_lsm_proto.c b/kernel/bpf/bpf_lsm_proto.c
> index b81179ae2e086..7c48af32c2d40 100644
> --- a/kernel/bpf/bpf_lsm_proto.c
> +++ b/kernel/bpf/bpf_lsm_proto.c
> @@ -5,6 +5,7 @@
> =20
>  #include <linux/fs.h>
>  #include <linux/xattr.h>
> +#include <linux/ipc.h>
>  #include <linux/bpf_lsm.h>
> =20
>  /*
> @@ -32,3 +33,31 @@ noinline int bpf_lsm_inode_init_security(struct inode =
*inode, struct inode *dir,
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +/*
> + * Strong definitions of the IPC control BPF LSM hooks. The informational
> + * commands have no object to authorize, so they pass a NULL struct
> + * kern_ipc_perm: shmctl_ipc_info() and shmctl_shm_info() call
> + * security_shm_shmctl(NULL, IPC_INFO | SHM_INFO), semctl_info() calls
> + * security_sem_semctl(NULL, cmd) and msgctl_info() calls
> + * security_msg_queue_msgctl(NULL, cmd). The __nullable suffix marks per=
m as
> + * PTR_MAYBE_NULL so that BPF LSM programs have to check it before
> + * dereferencing it. Without these overrides the hooks fall back to the
> + * __weak prototypes generated from lsm_hook_defs.h in bpf_lsm.c, which =
carry
> + * no annotation and let the verifier type perm as non-nullable.
> + */
> +noinline int bpf_lsm_shm_shmctl(struct kern_ipc_perm *perm__nullable, in=
t cmd)
> +{
> +	return 0;
> +}

[Severity: High]
This problem wasn't introduced by this patch, but should
bpf_lsm_inode_set_acl() also have a strong definition [1] marking
its kacl parameter with __nullable?

When setxattr() is called on a POSIX ACL attribute with size =3D=3D 0,
do_set_acl() passes a NULL acl through vfs_set_acl() and
security_inode_set_acl() to bpf_lsm_inode_set_acl().  Without the
__nullable annotation, the verifier treats kacl as a trusted non-null
pointer and neither requires a NULL check nor rewrites loads to use
BPF_PROBE_MEM, allowing a BPF LSM program attached to inode_set_acl to
trigger a NULL pointer dereference.

[1] https://sashiko.dev/#/bug/linux-bc5e250e-6772-4ebe-b887-e6439d751142

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/51ae120f0b3cd8c20db=
aaf02c9c384dc2afab6bc.1795627805.git.m202672221@hust.edu.cn?part=3D1
