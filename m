Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D62D3EFFDA
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972861; cv=none; b=lZzrrsYNnonA7oYV22CSbm7OCF1nxPalUGy4DxGUtnGGZ7sDC0Q71Qc+cR5ft1W9aEe8BJ2M/5bSlg7nVWZ1SHvHAqBXYxLsNg6FD/6DIQ1qBF6ZfBpGoJ2yauFKOz3M4bQICVQvfn/WVL086wxSkPLfgdlmDkVmtxVcyCIdhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972861; c=relaxed/simple;
	bh=nelb3JHUd2bRmym29uyM7SUdtaaEBlKEVO4UvhR95Sc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=HsxPv61A8ZJxA5TOZAyjqVnZn2y8KWXR/PcqPI/fI0N8rWOJstcxLz8RrjR2RhHbfucLD+xz4bX3T3xJ1jNkheJj5wqjS8V+GSh7BprXPJ+K1A+1macORwsP6I7vfW6NoXhhWoaDHtOpNY+RTgkR7Hg/UxZkW6iqPwSs7myT/vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH2NjL9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH2NjL9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807A91F000E9;
	Thu, 28 May 2026 12:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779972859;
	bh=apgN5tVwLSkhI2Rb4wcdSBtUQ+3pkMQ/1+xrFga40y4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ZH2NjL9Fcr597DukI11PV0Fm7jRWb3A+XrZ1JAiePbYAF9AFDC4ZK1BLr7SWjf69J
	 B8G7Xa+3Cj97qVCXroT/vhbhl5f4co0Y5PrMgRXJ14piaOnfFWvHOb2blbsxUdH9C+
	 a5fFLe8t//EW8KQULFawO4UQACiwYS1k470RIoljXdsKK6QJBCG/Wi62QypcjTWP/b
	 T9bzddwe11pWQ5zfC0C58IxaSNJo/6v/vMmWOPOml7PcoMCmr1RiH/5eHbulrLNXkp
	 QwbJGhvK9wpeLAtzzU0jZYd6yoYxwva3HvLjtv9WJaZDIKDFzAHYIYJVHfU7/LI/m7
	 MNocp+P9sJweQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next 1/3] bpf: Add simple xattr support to bpffs
From: Christian Brauner <brauner@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org, 
 kpsingh@kernel.org, john.fastabend@gmail.com
In-Reply-To: <576b6350-6635-4544-9a06-f4777e3a0e65@iogearbox.net>
References: <20260522135626.120732-1-daniel@iogearbox.net>
 <20260527-irrtum-holztisch-risiken-690a7fb93843@brauner>
 <576b6350-6635-4544-9a06-f4777e3a0e65@iogearbox.net>
Date: Thu, 28 May 2026 14:54:16 +0200
Message-Id: <20260528-verraten-innig-sprechen-fa8bea6696f7@brauner>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2845; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nelb3JHUd2bRmym29uyM7SUdtaaEBlKEVO4UvhR95Sc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRJWP2Sv3cj9bDqfr7Pfy/GvblWvmKpuKvXbdk8g6Oi+
 1YG1V3n7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI+15Ghp2mM/LbPb7ecGm7
 GrBaLPde2pY1td0ejK9VzrX8SmCR7WZkeF2T+/DrFdbAnrMfH+T0mZwW+2C1s3D1yYv/chjvmCV
 wMwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-05-27 14:36 +0200, Daniel Borkmann wrote:
> On 5/27/26 2:19 PM, Christian Brauner wrote:
> > On Fri, May 22, 2026 at 03:56:24PM +0200, Daniel Borkmann wrote:
> >> Add support for extended attributes on bpffs inodes so that user space
> >> and BPF LSM programs can attach metadata, for example, a content hash
> >> or a security label - to a pinned object or directory. BPF LSM or user
> >> space tooling can then uniformly look at this (e.g. security.bpf.*) in
> >> similar way to other fs'es. The store is in-memory and non-persistent:
> >> it lives only for the lifetime of the mount, like everything else in
> >> bpffs. The modelling is similar to tmpfs.
> >>
> >> bpf_fill_super() is open-coded instead of using simple_fill_super(),
> >> because the root inode must now be allocated through bpf_fs_alloc_inode()
> >> i.e. carry the bpf_fs_inode wrapper and come from the right cache -
> >> which requires s_op (and s_xattr) to be installed before the first
> >> inode is created.
> >>
> >> bpf_fs_listxattr() is only reachable through the filesystem via
> >> i_op->listxattr, so the BPF token inode is left untouched. Name-based
> >> fsetxattr()/fgetxattr() on a token fd still work since the get/set
> >> handlers are installed at the superblock.
> >>
> >> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> >> Cc: Christian Brauner <brauner@kernel.org>
> >> ---
> >>   kernel/bpf/inode.c | 254 ++++++++++++++++++++++++++++++++++++++++++---
> >>   1 file changed, 237 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> >> index 25c06a011825..638aa996cbaf 100644
> >> --- a/kernel/bpf/inode.c
> >> +++ b/kernel/bpf/inode.c
> >> @@ -21,6 +21,9 @@
> >>   #include <linux/bpf.h>
> >>   #include <linux/bpf_trace.h>
> >>   #include <linux/kstrtox.h>
> >> +#include <linux/xattr.h>
> >> +#include <linux/security.h>
> >> +
> >>   #include "preload/bpf_preload.h"
> >>   
> >>   enum bpf_type {
> >> @@ -30,6 +33,22 @@ enum bpf_type {
> >>   	BPF_TYPE_LINK,
> >>   };
> >>   
> >> +struct bpf_fs_inode {
> >> +	struct simple_xattrs	*xattrs;
> >> +	struct inode		vfs_inode;
> >> +};
> > 
> > Note that we are in the process of making this a lot more elegant and
> > the interface changes significantly because of this.. The patches for
> > this are currently in vfs-7.2.misc. I can shove them onto vfs-7.2.xattr
> > and keep that branch stable so you can build it on top of it. You can
> > merge that branch into -next. I won't touch it again. Just tell me if
> > you want to do that.
> 
> Good to know, thanks! We could probably pull that particular branch into
> bpf-next once you push it out, and then I can rework & resubmit the patches
> on top of it.

Nice, thanks. I've pushed vfs-7.2.xattr and marked it as shared now.

