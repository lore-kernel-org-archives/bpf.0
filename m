Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C33C1D6D
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419279; cv=none; b=sfymCsbP6mmpSCWHm7xFbqLhQVC13Nzj7qNGADG0hGpImF/XCHyCOIduJSn/5jQDAxu3m+RrhgcOW1qSYsDhv24unCsOe2WbWWEHTJz2LIDznRq2/3fOamGdZc7eekPYYIQQ4kap5CDjSDq3x2u/a7AXc7gHPtCPi2ya/SExEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419279; c=relaxed/simple;
	bh=h7Ez55/QIBp3vyyXp6Pjhh8R2UXXAxRs2yI9ALIMkXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U6iBRmPi2gYynbGSP8ne7QvUDqHK0BocTklMHbugggBJQpXA6f7sczi5+qj39wZI1X8zU7s0aH+WOoNlzGvUQfwoAgS3raZGzxGfF9nLemBrrsjbLKab3ekYxefr0yHsPS5OSA8KPepmepEnU3uLBbEmIsHCq5tXByQhu1jVhLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1EEDtG8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1EEDtG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21231F000E9;
	Thu, 30 Jul 2026 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785419277;
	bh=5/G8IZhjC7KxG4e7LbxnIZGRW8WIvuANfkGVvRHdCUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H1EEDtG8wbZTznjh1lT4JWhrRCz8vWmKFMR/bRC6AGGuzrmZiTXMVDKp31aLfWEJj
	 Pw2jYWOS0ZIaCpCPkb7LrmgWBh0F3nBR3RWxMOyLq0dt5gDaoz500wCiDNyH41hDh1
	 eZWzJsuUIzvxrD+Bt2Wa0WXt11qtW7LReONMQLAEE110DQTAm706I1v99mWW/ANg6i
	 WoBxVFLgxqV3b2o6M1Aqs3DgfHyylPdfNRVoVMNOIh5zGgLPNogg/xuk8tA5IiM4K9
	 CWVJrCVe7T9RVuxwjxTCwlZ5YHQIztrIm4jgmAB5oqUf7yfGilPLJR4dH63w/rawCu
	 nUeMNXfSx9U8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] binfmt_misc: let a register string create an entry
 disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260730-work-binfmt_misc-preopen-v1-1-4a0b0da71f16@kernel.org>
References: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
 <20260730-work-binfmt_misc-preopen-v1-1-4a0b0da71f16@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 13:47:57 +0000
Message-Id: <20260730134757.A21231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Inconsistent VFS lockdep subclass usage for the root directory's=
 i_rwsem in bm_entry_write().
--

--- Patch [1]: [PATCH 1/9] binfmt_misc: let a register string create an ent=
ry disabled ---
commit 804ba816d20f57c8b2fa3e1866d3a8ae54eeeb11
Author: Christian Brauner <brauner@kernel.org>

binfmt_misc: let a register string create an entry disabled

This commit adds a 'D' flag to binfmt_misc registration, allowing entries to
be created in a disabled state and activated later. This separates creation
from activation and keeps staged entries out of the search list until enabl=
ed.

> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 707f8a14f8a63..ca7840b01a2bb 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c

[ ... ]

> @@ -1067,9 +1110,27 @@ static ssize_t bm_entry_write(struct file *file, c=
onst char __user *buffer,
>  	case BM_CMD_DISABLE:
>  		clear_bit(MISC_FMT_ENABLED_BIT, &e->flags);
>  		break;
> -	case BM_CMD_ENABLE:
> +	case BM_CMD_ENABLE: {
> +		struct inode *root =3D bm_root_inode(inode->i_sb);
> +
> +		/*
> +		 * The first enable publishes a 'D' entry into the search
> +		 * list, whole. The lock keeps that ordered against a second
> +		 * enable and against removal; a removed entry has nothing
> +		 * left to publish.
> +		 */
> +		inode_lock(root);

[Severity: Medium]
In bm_remove_entry() and bm_remove_all_entries(), the root directory lock is
acquired using inode_lock_nested(root, I_MUTEX_PARENT). Here in
bm_entry_write(), we're using inode_lock(root) which uses the default subcl=
ass
(I_MUTEX_NORMAL).

Does this inconsistent VFS lockdep subclass usage defeat lockdep's parent-c=
hild
ordering checks? Using different subclasses for the same directory's i_rwsem
might split the lockdep tracking and hide potential deadlocks from the
validator.

Should this be inode_lock_nested(root, I_MUTEX_PARENT) to match the removal
paths?

>  		set_bit(MISC_FMT_ENABLED_BIT, &e->flags);
> +		if (hlist_unhashed(&e->node) && !d_unhashed(e->dentry)) {
> +			struct binfmt_misc *misc =3D i_binfmt_misc(inode);
> +
> +			spin_lock(&misc->entries_lock);
> +			hlist_add_head_rcu(&e->node, &misc->entries);
> +			spin_unlock(&misc->entries_lock);
> +		}
> +		inode_unlock(root);
>  		break;
> +	}
>  	case BM_CMD_REMOVE:
>  		bm_remove_entry(e, inode->i_sb);
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-work-binfm=
t_misc-preopen-v1-0-4a0b0da71f16@kernel.org?part=3D1
