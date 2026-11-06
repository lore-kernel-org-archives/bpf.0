Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961544;
	b=oxth5kUJTOZvJg7H2S6oZCPu1w/U5EEK06DPzoo5IgFc4XVuLPLnDipLRyzD7+snFQbe
	 TUXQdH3x+o5/O7V2vmQByUkdcqcXPubI1kS1f+C6sk1IJ6/AxWWjkFrjYdNn1XQjeueM6
	 Ri37kB7ru/tIxpFBwG/rL8Ksa/g1QlMqhjPIw4ao2dJxPIi176cz1gNKkDVaMzQAiHf5z
	 YUN77sjFLHisl4fft88rcpjdZiYZnxSE8TfdYitiSehe6eCNnOmpwgvBx1KMRHijNUUld
	 guZaTA+O/UOr3W59CvUynTXIytCQbpFH29rw35j1G8SHdYpNcgmtBG/Hl/j5VACyVqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961544;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8rKoindS11SlgH8X/W9bp1ADs8Tf7HyDhi301qbbGFs=;
	b=KJbrPThD6iQDn2duMcw+Xm4wOOROwpwkaNV2eEsr5nBugInX1Z4JKk3TIZPrzMO8Rfgn
	 yp1gpermy3VV85JNXs3r+y1rPVgeFXqEClRkCnqo6PBESD8ZXML9szPouArZY0D49DmdQ
	 SV4/O4QwOVLANWSHhem+ccyYZzaBddVzWzq3JywoW1J4GwY/cGg4Z6Z381X7zIZyrFDia
	 EO0Mh/WehHaZTlcKuHIrcd5sSxtkq/ZqgV0DV7jRRQpVldNbNMNcFs4Zbg31yhwN9x4nf
	 JFkIP9el/vpjrYeZOHHxJTBZ8Fru6yzO8r/Z0ddqDsNIaonkQMmZg8ZLwIBAxfLujWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gm856xek;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C2606A329;
	Fri,  6 Nov 2026 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gm856xek
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3A81F0089F;
	Fri,  6 Nov 2026 10:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793961543;
	bh=8rKoindS11SlgH8X/W9bp1ADs8Tf7HyDhi301qbbGFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gm856xekwxuX2FuCKILVecUsWz/KcrUrNkUadVoZ53d8RqI+wiT2nIvlwGF2gF9P9
	 kPCWXmokyGKhvptwA8RjAN3PFpOcrUI8t9h25DKAMSSaRgg5FVRO3jo1gH0qj/GnAA
	 25JI89mtiuFg3BKfDX1a6ZGRP8Uk9d+bHOBrs3CjcqKBJy7+HsTDYZEsW5y9+J+vlj
	 S7TMg5wDlUZ8qxs98hwnKJW/nviH2kHBAY6AixQewZspQi84DxywMIkI/9p5k7uFBb
	 atWjuaR7j2QByk1ppEOi9JTOzdvGreQ04A6Tt3tknycrDp8aTX9eH1ipZ4r3nVhckj
	 e4pi1eQehPVEQ==
Date: Fri, 6 Nov 2026 11:38:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH vfs-7.5.bpf v2 1/3] bpf: Add bpf_path_getattr()
Message-ID: <20261106-spurwechsel-entwachsen-wildpark-e6322e9caf35@brauner>
References: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
 <20261102104655.70901-2-tasos.papagiannnis@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261102104655.70901-2-tasos.papagiannnis@gmail.com>

On Mon, Nov 02, 2026 at 12:46:53PM +0200, Anastasios Papagiannis wrote:
> +	ret = vfs_getattr_nosec(path, &stat, request_mask, query_flags);

This blocks on the filesystem and it's callable from every sleepable LSM
hook. It's trivial to get a trusted path via bpf_get_task_exe_file().

So the issue I have is that some of those hooks run under locks where
blocking on the filesystem is a deadlock...

For example, a synchronous NFS rpc is transmitted in the caller's
context,

	__rpc_execute()
	-> call_transmit()		/* XPRT_LOCKED, xprt->snd_task = T1 */
	   -> xs_tcp_send_request()
	      -> xprt_sock_sendmsg()
	         -> sock_sendmsg()
	            -> __sock_sendmsg()
	               -> security_socket_sendmsg()

so a program on lsm.s/socket_sendmsg doing

	file = bpf_get_task_exe_file(bpf_get_current_task_btf());
	bpf_path_getattr(&file->f_path, STATX_BASIC_STATS, 0, &st, sizeof(st));

When the attribute cache expires and the file on the same nfs mount you
get:

	nfs_getattr()
	-> __nfs_revalidate_inode()
	   -> rpc_call_sync()		/* T2 */
	      -> xprt_reserve_xprt()	/* XPRT_LOCKED && T2 != snd_task */
	         -> rpc_sleep_on(&xprt->sending)

with T1 never finishing the send. cifs has the same shape with
server->_srv_mutex held across smb_send() and ocfs2 with sc_send_lock.

There are others of the same kind:

- bprm_committing_creds and bprm_committed_creds run with
  exec_update_lock held for write.

  A FUSE_GETATTR on bprm->file deadlocks if the daemon does
  readlink("/proc/<pid>/exe") or reads /proc/<pid>/stat of the
  requester because both take exec_update_lock now.

  I just massaged that codepath and moved close_cloexec_files() out from
  under that lock for exactly this reason.

  Fun fact, request_wait_answer() is uninterruptible once the daemon has
  read the request.

- sb_show_options and sb_statfs via statmount() hold namespace_sem.

- inode_free_security runs from evict under s_umount or from reclaim.

- task_setscheduler via cpuset_can_attach() holds threadgroup_rwsem for write.

- file_receive from seccomp addfd holds notify_lock.

The worst part is that - as I said in the bpf session at LSFMM -
bpf_get_file_xattr() already brings in similar problems.

But it needs an NFSv4.2 server with xattr support and a cache miss.

In contrast, getattr is hit on every attribute cache expiry and every
fuse getattr.

So we need mechanisms in bpf to guard against things like that
architecturally. Ideally it would not just be a filter like in the past.

And really, request_mask and query_flags reach the filesystem
unfiltered and do_statx() does:

	if (mask & STATX__RESERVED)
		return -EINVAL;
	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
		return -EINVAL;
	mask &= ~STATX_CHANGE_COOKIE;

and we should do the same here.

And STATX_CHANGE_COOKIE does changes to the inode. generic_fillattr()
calls inode_query_iversion() which sets I_VERSION_QUERIED. That forces
i_version bumps. That's kernel-only infra.

> -/* Side-effecting kfuncs that stay exclusive to LSM programs. */
> +/* Kfuncs that stay exclusive to LSM programs. */
>  BTF_SET_START(bpf_fs_kfunc_lsm_only_ids)
> +BTF_ID(func, bpf_path_getattr)

The other thing is that struct kstat uses very different formats for say
device numbers than userspace.
