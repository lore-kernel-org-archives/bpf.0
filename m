Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1650A3D79FE
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884388; cv=none; b=KgPHCvBYc+e90PZAthWlP6k4oimfws4Bho+ELdfERt65p3aJDPcIJIjZ/PlPeS3dKtcOZp+d7SPMxpcXWBK+JgGKb6Bxgt5EZF/3yvqZBR/UtA6cFiNjEicqKSO2KaCgIaDjpG56JTTEq7U8Xqf7b+IN/xKlmCJD62HE6wFSTpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884388; c=relaxed/simple;
	bh=aQQCqIseNulzRuLY55iW2dBPTLbBDxt7SfTclJzYTs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAItN489VEY/91vsCjDsddEbeUfJGsFJ4U4nMyNBBStYgRRK6P+EJzkPbKiXxmaqrRTZoiGaTJfCMHV3dTUIBRRM67nA3ZWoEKL98hALF/Fi7maYMc6j7cxZDzxJquqqHvMxYaJ6CdKi4BKfzQioKSX3tp8ANHLR6gUJ50RZOMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFdwj5fo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFdwj5fo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392491F000E9;
	Wed, 27 May 2026 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779884386;
	bh=Ay/ukQY16GAVwWTydSM74z/AwUN+HiS9be4Z+1BVj+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fFdwj5fotPA+TzhH8W5Va1Y44Cz1gJYlOPTsZXu2xg3ivrva+rVkNO20pT47c9S+Q
	 jEwBCjtKIMMPGy4zpuCjQlYdXSbIUzpiI4q1AehLePPI2bRwk3rgQRQCVkOAHL97T6
	 +Re/OuXdLsfAEhe6vlI4EZS3y8h09rEJq4nLvhyVHuCCn0D4HffiyfEpTjn3IAq0nF
	 qeMBWDS6dQO+omzixRO83FH7EfisZKWc1flCg4HIq5RLvJnI9sXuL54EomLhY1nDhG
	 cWbNitMaOfUhXqfpns9jGpJ8LDUiX2yg+t8ktSFcmmuCIFF+0X5XIc9Sa1l8rsJFAk
	 NWt+ruXbJ76aw==
Date: Wed, 27 May 2026 14:19:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, kpsingh@kernel.org, john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Add simple xattr support to bpffs
Message-ID: <20260527-irrtum-holztisch-risiken-690a7fb93843@brauner>
References: <20260522135626.120732-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522135626.120732-1-daniel@iogearbox.net>

On Fri, May 22, 2026 at 03:56:24PM +0200, Daniel Borkmann wrote:
> Add support for extended attributes on bpffs inodes so that user space
> and BPF LSM programs can attach metadata, for example, a content hash
> or a security label - to a pinned object or directory. BPF LSM or user
> space tooling can then uniformly look at this (e.g. security.bpf.*) in
> similar way to other fs'es. The store is in-memory and non-persistent:
> it lives only for the lifetime of the mount, like everything else in
> bpffs. The modelling is similar to tmpfs.
> 
> bpf_fill_super() is open-coded instead of using simple_fill_super(),
> because the root inode must now be allocated through bpf_fs_alloc_inode()
> i.e. carry the bpf_fs_inode wrapper and come from the right cache -
> which requires s_op (and s_xattr) to be installed before the first
> inode is created.
> 
> bpf_fs_listxattr() is only reachable through the filesystem via
> i_op->listxattr, so the BPF token inode is left untouched. Name-based
> fsetxattr()/fgetxattr() on a token fd still work since the get/set
> handlers are installed at the superblock.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Christian Brauner <brauner@kernel.org>
> ---
>  kernel/bpf/inode.c | 254 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 237 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 25c06a011825..638aa996cbaf 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -21,6 +21,9 @@
>  #include <linux/bpf.h>
>  #include <linux/bpf_trace.h>
>  #include <linux/kstrtox.h>
> +#include <linux/xattr.h>
> +#include <linux/security.h>
> +
>  #include "preload/bpf_preload.h"
>  
>  enum bpf_type {
> @@ -30,6 +33,22 @@ enum bpf_type {
>  	BPF_TYPE_LINK,
>  };
>  
> +struct bpf_fs_inode {
> +	struct simple_xattrs	*xattrs;
> +	struct inode		vfs_inode;
> +};

Note that we are in the process of making this a lot more elegant and
the interface changes significantly because of this.. The patches for
this are currently in vfs-7.2.misc. I can shove them onto vfs-7.2.xattr
and keep that branch stable so you can build it on top of it. You can
merge that branch into -next. I won't touch it again. Just tell me if
you want to do that.
