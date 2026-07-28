Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79D3AB285
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242646; cv=none; b=D0GIfI/Vxo1NYbBYhXEhCaViMKyZyiBruAnJzF29SBEaDMsoI5Fc7vRV2jXEvJLGhtq0Zt9TxH405PbPtsibSy44qbWwYcge5MPARbfV5VXsxXc3IMT1PBJBYR0T7genOMqR5CNpKo8y8OskAHmWHolLXPip+Cc2GnhL4lACIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242646; c=relaxed/simple;
	bh=F07q63faSFu832VYV7z5nrY6FCd6sB8Dd4u+RWYorMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r4dHI3VZG2ROm5tXVKtLsSxcSgDn921snGqTgT2BFSw19kULNk6Jq7AurN0sRQctH34ofmycVA9ZPH9jg2L6wUeAPCplf0zdZFVt+wBZWK/nAEVGp8mAFTYoYxcy5HeKra1ziNe4ychLTy7J4nSCHZLc426VRuJ7+B4NfPD9xPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BD2OWDOi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BD2OWDOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23671F00A3A;
	Tue, 28 Jul 2026 12:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785242645;
	bh=X9ZJXLFe2h3/rcRng1fKbMU8jZPba0dQVKWMrAzUGyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BD2OWDOiSFFMVidYQmV1jKS2fjXVm73RELt5dYrzKj04CIdcNFoccLNzyULA6lwx/
	 MpTazjMLUDAOrTfSj83+ld3xqnI6VDMP7h1a9Ag1jRU9PzSz9R3zT6r3tuzeBY8FLI
	 ptgUyF4OLduFtRL+YKI/A/fAdC6hLQc+CqP0vGn/wTGHQaHF/AxUccQDofPx2FhUkw
	 CdFn+nNMvmBVUc54myUDbowupbL7VrcPwdyEUGWNm+DF27WONbEzkkpmXbFep41aIv
	 qeVxzvk29M4ROHoY3WF6Q/BByRubCvDavw9cjwyBb0uGtxrjRO0GEUL9UDQzZt12Yk
	 Z7mu8WZZjEIJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] binfmt_misc: don't let an 'F' entry pin its own
 instance
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260728-work-binfmt_misc-selfpin-v1-1-74df5daeca5b@kernel.org>
References: <20260728-work-binfmt_misc-selfpin-v1-0-74df5daeca5b@kernel.org>
 <20260728-work-binfmt_misc-selfpin-v1-1-74df5daeca5b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 12:44:04 +0000
Message-Id: <20260728124404.B23671F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The user_ns reference obtained in `bm_get_tree` and transferred to=
 `sb->s_fs_info` by `sget_fc` is permanently leaked if `bm_fill_super` fail=
s.
- [High] Deleting a `binfmt_misc` entry registered with the `F` (MISC_FMT_O=
PEN_FILE) flag leaks the negative `i_writecount` of the interpreter file, p=
ermanently preventing it from being opened for writing until reboot.
--

--- Patch [1]: [PATCH 1/2] binfmt_misc: don't let an 'F' entry pin its own =
instance ---
commit 69b9018135a8cbdf7775e3461daaa6ac7c2e2eb2
Author: Christian Brauner <brauner@kernel.org>

binfmt_misc: don't let an 'F' entry pin its own instance
   =20
An entry registered with 'F' opens its interpreter at registration time
and holds that file until the entry is freed. Any entry nobody removes
by hand only gets closed once the binfmt_misc superblock is shut down.
If the interpreter lives on a mount that keeps that superblock alive the
two pin each other. This patch ensures SB_I_NOEXEC and s_stack_depth are
set to prevent this circular dependency and pinning.
   =20
Cc: stable@vger.kernel.org # v6.7+

> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 84349fcb93f13..659a9f215db2c 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -938,6 +938,10 @@ static int bm_fill_super(struct super_block *sb, str=
uct fs_context *fc)
>  	if (WARN_ON(user_ns !=3D current_user_ns()))
>  		return -EINVAL;
> =20
> +	/* Never exec off this instance and never let anything stack on it. */
> +	sb->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> +	sb->s_stack_depth =3D FILESYSTEM_MAX_STACK_DEPTH;
> +
>  	/*
>  	 * Lazily allocate a new binfmt_misc instance for this namespace, i.e.

[ ... ]

Looking at the rest of bm_fill_super() in fs/binfmt_misc.c:

	err =3D simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
	if (!err)
		sb->s_op =3D &s_ops;
	return err;
}

[Severity: High]
This is a pre-existing issue, but does this error path permanently leak the=
=20
user_namespace reference?

If simple_fill_super() fails, or if a memory allocation failure occurs=20
earlier in bm_fill_super(), sb->s_root remains NULL. When vfs_get_super()=20
handles the error, generic_shutdown_super() will skip calling=20
s_op->put_super(sb).=20

Since fc->s_fs_info was already cleared during sget_fc(), does this mean=20
the user_namespace reference in sb->s_fs_info is never released?

Could an unprivileged local user trigger this by intentionally failing=20
userns mounts (e.g., via memory exhaustion) to cause resource exhaustion?


On a related note regarding pre-existing issues, looking at=20
put_binfmt_handler() in fs/binfmt_misc.c:

static void put_binfmt_handler(struct binfmt_misc *e)
{
        ...
        if (e->flags & MISC_FMT_OPEN_FILE)
                filp_close(e->interp_file, NULL);
        kfree(e);
}

[Severity: High]
This is a pre-existing issue, but does this teardown path leak the negative=
=20
i_writecount of the interpreter file?

When an entry is registered with the 'F' flag, bm_register_write() uses=20
open_exec(), which internally decrements the inode's i_writecount to preven=
t=20
concurrent writes. While the error path during registration calls=20
exe_file_allow_write_access(), put_binfmt_handler() only calls filp_close()=
.=20

Since filp_close() does not automatically restore executable write access,=
=20
would deleting the binfmt_misc entry permanently leave the binary unwritabl=
e=20
(returning -ETXTBSY) until reboot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-work-binfm=
t_misc-selfpin-v1-0-74df5daeca5b@kernel.org?part=3D1
