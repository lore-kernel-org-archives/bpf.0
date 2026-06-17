Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4A42847B;
	Wed, 17 Jun 2026 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704994; cv=none; b=JTAFYG/ntWtJZrcqo4nP20h32WCffId4ZGeBK7UspIxlimK1V0j5ZHB6nTAao2ob1wbSvH+5ljVLHPufrLdB6aiIQzHW20uYU6fVrl1wMDRHTk7rt/gqrTMse9hbbRzHAEAtl07Qf7GRV8xvy0RhhvFq+kAAZ3Os2q6ZC25O3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704994; c=relaxed/simple;
	bh=fyXebLiltjSHyI0C9+G+AxBFVkRZs1Jjmc92wKPBSvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQu2tUKBf5NPgqRwzJtGjexRwzmJwMFCfRTyNRPd91uNhnxhoj2U999/6oNF37tz2HJFIlOSuTcQT01S4PaTu/4arrWWO0UrHy6ZVS/8TZeUxG072OyuTHNmtmqfehZc3iX6sVZYegtwoWMIboCO53bKGRJb0qyUpdAC/Jehfto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkNHG2cE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkNHG2cE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F741F000E9;
	Wed, 17 Jun 2026 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781704992;
	bh=Ur7+lgc4V1Q/ImkQI5CoXvHiLk63BK8pFxHtD6NsgLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nkNHG2cEeBt9LBN+0QB+6c1QP/OHJACFWKa5MKGSimMYgZQLbl+PnCxPeMV5IJymG
	 kzQNk7jAlol//WoD4geTI8yml9D4TdZzATRQhbrbfJO4UDmRAMpO39lpVDkRSywmfS
	 pD8dgU2rLo4KZjUeZnNq/JdkNtDmeis+Qvn5FKXPYFeYxx7vt62be5YerFLulZfqbP
	 aaZK994606Zx5VPnSKDoMAGlHMgCkh493licy5ZmGEytzArjRTCIhRJkbjBi3vTNUU
	 NVj2a+w8kuQC1KpOdDVUGgWnEPWBS0eDzPqBt83zjcnu4dVYUU4Z8T9q2ZH7bvCqPn
	 cGx92HEXhjG3A==
Date: Wed, 17 Jun 2026 16:03:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: Add bpf_sock_read_xattr() kfunc to read socket
 xattrs
Message-ID: <20260617-gericht-leerlauf-verzichten-a70f3725c8e9@brauner>
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
 <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>
 <20260617113209.8D4BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617113209.8D4BA1F000E9@smtp.kernel.org>

On Wed, Jun 17, 2026 at 11:32:08AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing READ_ONCE() on lockless access to sock->file can lead to a TOCTOU NULL pointer dereference.
> --
> 
> commit 9bf8c99c6cda345fa08537f5df5f36bc0aa367b9
> Author: Christian Brauner <brauner@kernel.org>
> 
> fs: Add bpf_sock_read_xattr() kfunc to read socket xattrs
> 
> This commit introduces the bpf_sock_read_xattr() kfunc to allow BPF LSM
> programs to locklessly read user.* extended attributes from a socket's
> sockfs inode. The kfunc is registered as KF_RCU, and retrieves the
> attributes using an RCU-protected rhashtable lookup.
> 
> Link: https://github.com/systemd/systemd/pull/40559 [1]
> 
> > diff --git a/net/socket.c b/net/socket.c
> > index 9e8dc769ff7af..3566f8c8ea3fb 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> [ ... ]
> > @@ -465,6 +465,31 @@ static const struct xattr_handler sockfs_user_xattr_handler = {
> >  	.set = sockfs_user_xattr_set,
> >  };
> >  
> > +/**
> > + * sock_read_xattr - read a user.* xattr from a socket's sockfs inode
> [ ... ]
> > +int sock_read_xattr(struct socket *sock, const char *name, void *value, size_t size)
> > +{
> > +	struct file *file = sock->file;
> > +	struct sockfs_inode *si;
> > +
> > +	if (!file || sock_from_file(file) != sock)
> 
> [Severity: High]
> Can a concurrent close cause a NULL pointer dereference here?
> 
> Since bpf_sock_read_xattr() is registered with KF_RCU, BPF programs can
> call it under RCU protection where the socket might not have a held file
> reference. If the last file descriptor is closed concurrently,
> __sock_release() can set sock->file = NULL without waiting for an RCU grace
> period.
> 
> Because sock->file is read without READ_ONCE(), the compiler is permitted
> to reload the pointer from memory. If the initial read for the !file check
> sees a valid pointer, but a subsequent read for the inlined
> sock_from_file(file) call sees NULL due to the concurrent modification,
> sock_from_file() will attempt to dereference file->f_op on a NULL pointer.
> 
> Does this need struct file *file = READ_ONCE(sock->file) to prevent a
> TOCTOU issue?

The function is intentionally restricted to BPF LSM hooks where the file
pointer on struct socket is either NULL or stable. This invariant is
also relied upon by other LSMs. The RCU makes it possible to use it in
non-sleeping contexts and the simple xattr interface was specifically
designed for that.
