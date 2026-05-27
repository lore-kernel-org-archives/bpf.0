Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F6E33FE26;
	Wed, 27 May 2026 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879001; cv=none; b=t2AO5qcg9Dl0aiENirahpREthp0T+KYs/i2e/q3eUfKOPBRhqxFZHaxx485yQXkkPaZ3f5twB2uHZXnN+fuYyH/ClngjI7Dk7j+/i4Cmli3sTKQwYZpwZHTigZ/iY8BVUUN0R+vZKiJgJyVY17bJVlE2KXZpTX37E7XnB8WltlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879001; c=relaxed/simple;
	bh=qkXguhw9Lj7KxUlDUZrKpnoM4gew1szbHrWB0Da8rCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZWLLiFwN7qXpVBuIFKli1OjBvPjcg9IdBWDJyCZ4WiFpNLLPcnuEFtNb5KlIBtTUun8FeMIaJI4LqprWGCw/kZfV8tyd/Fa9S3CVC/TPo+y6qh1uCo8FXLA8LeUlZiX8fggNhdV0iABumOlM+V/Q8NAkdnYT9X2vEOR1WQY4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3Go9fQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3Go9fQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713B61F000E9;
	Wed, 27 May 2026 10:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779878999;
	bh=jM/2pFJ9+Fn1zigNI4bh/4GwIdduylqLEmHeVHkx+X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q3Go9fQeeQEMdUsBCFXbE3EfTsSScyGZInAAMtERM65YW0BBz7i2/aDjE1JZ5a+5/
	 av10PZtRRUT1U0JPrFZJvSn5KxJ2B+Nw6Imu+RXE4wczJFxSlwJBNArhBCtyhMuDtQ
	 T9mxNXcXze0w5XxrMhT1TS/3X6IRhY/Zgpm5QKoAzsIEnmstBfEV+DkJQIyB7Z5+gA
	 cLnf6oIrrxlSTbz7CWbgNLsvkVGXn8x/LKKcrrl0fGCAISo97S03Pb6IA4UV0vyTRv
	 ipYRMPb3y6Av0wWdQCTkAAzUiwEVQl4gxjNVdxpoZY8vaugvPi9Js2QhQeIlMy0CBF
	 9/Ag2paxR/ZXQ==
Date: Wed, 27 May 2026 12:49:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2] bpf: add bpf_real_inode() kfunc
Message-ID: <20260527-seenplatte-flecken-gekettet-af97aff1186e@brauner>
References: <20260526-work-bpf-verity-v2-1-cd0b1850d31b@kernel.org>
 <20260526130517.DE6A01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526130517.DE6A01F00A3A@smtp.kernel.org>

On Tue, May 26, 2026 at 01:05:17PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] bpf_real_inode() fails to resolve the real underlying inode for directories and non-regular files on overlayfs.
> - [High] bpf_real_inode() can be exploited to trigger a kernel warning (DoS) and bypass security policies via pending signals.
> - [High] bpf_real_inode() exposes overlayfs internal locks to BPF, allowing trivial self-deadlocks.
> --
> 
> commit ea7b29442723e30589a55df64a725a8aaaaeddd8
> Author: Christian Brauner <brauner@kernel.org>
> 
> bpf: add bpf_real_inode() kfunc
>     
> Add a sleepable BPF kfunc that resolves the real inode backing a dentry
> via d_real_inode(). On overlay/union filesystems the inode attached to
> the dentry is the overlay inode which does not carry the underlying
> device information. d_real_inode() resolves through the overlay and
> returns the inode from the lower, real filesystem.
>     
> Link: https://github.com/systemd/systemd/pull/41340 [1]
> 
> > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > index e4e51a1d0de28..761fbe0fec5d5 100644
> > --- a/fs/bpf_fs_kfuncs.c
> > +++ b/fs/bpf_fs_kfuncs.c
> > @@ -353,6 +353,21 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__s
> >  }
> >  #endif /* CONFIG_CGROUPS */
> >  
> > +/**
> > + * bpf_real_inode - get the real inode backing a dentry
> > + * @dentry: dentry to resolve
> > + *
> > + * If the dentry is on a union/overlay filesystem, return the underlying, real
> > + * inode that hosts the data.  Otherwise return the inode attached to the
> > + * dentry itself.
> > + *
> > + * Return: The real inode backing the dentry, or NULL for a negative dentry.
> > + */
> > +__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
> > +{
> > +	return d_real_inode(dentry);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: High]
> Does this code fail to resolve the real underlying inode for directories and
> non-regular files on overlayfs?
> 
> When d_real_inode() is called, it invokes d_real(dentry, D_REAL_DATA), which
> maps to ovl_d_real() in overlayfs. However, ovl_d_real() contains an explicit
> short-circuit check:
> 
>     if (!d_is_reg(dentry))
>         return dentry;
> 
> This means it will return the overlayfs dentry (and therefore the overlayfs
> inode) for directories, sockets, and symlinks.
> 
> Since BPF LSM policies using bpf_real_inode() to restrict access based on the
> underlying real filesystem will receive the overlayfs inode for directories,
> could this cause inconsistent policy enforcement and allow security bypasses
> for non-regular files?

No, this is expected.

> [Severity: High]
> Can this implementation be exploited to trigger a kernel warning and bypass
> security policies via pending signals?
> 
> When bpf_real_inode() is called on an overlayfs regular file, it delegates
> to ovl_d_real() which calls ovl_verify_lowerdata(). This attempts a lazy
> lookup using ovl_maybe_lookup_lowerdata(), which then calls
> ovl_inode_lock_interruptible(inode) to acquire a mutex.
> 
> If the user process triggering the BPF hook has a pending signal, the lock
> acquisition fails and returns -EINTR.
> 
> Because ovl_d_real() treats any failure from ovl_verify_lowerdata() as a
> critical bug, it will trigger a WARN(1, ...) and fall back to returning the
> overlayfs dentry.

This is at least strange behavior on overlayfs. But it wouldn't be an
issue. The overlayfs indoe would be returned and execution would be
denied. So it would prevent execution, it wouldn't escalate privileges.

> 
> Does this allow an unprivileged user to intentionally trigger this path with
> a pending signal, reliably spamming kernel warnings, and returning the
> overlayfs inode instead of the real one to bypass BPF LSM restrictions?
> 
> 
> [Severity: High]
> Does exposing these internal overlayfs locks to BPF allow for trivial
> self-deadlocks?
> 
> Because bpf_real_inode() is marked as KF_SLEEPABLE, it can be called from
> sleepable BPF programs such as LSM hooks or fentry.s tracing programs.
> 
> When operating on an overlayfs dentry, this attempts to acquire the
> non-recursive mutex OVL_I(inode)->lock via ovl_inode_lock_interruptible()
> during the lazy lowerdata lookup.
> 
> If a sleepable BPF program attaches to a kernel function or LSM hook that
> executes while OVL_I(inode)->lock is already held by the current thread
> (for example, an fentry.s trace on ovl_do_setattr or ovl_do_copy_up), calling

Fwiw, ovl_do_setattr() doesn't exist iirc.

> bpf_real_inode() on the same dentry will cause the thread to wait on the
> non-recursive mutex it already holds.
> 
> Could this result in a self-deadlock, completely freezing the thread and
> breaking the verifier's safety guarantees?

Does the verifier protect against calling

bpf_set_dentry_xattr() from:

security_inode_setxattr()?

Because that's a trivial deadlock right there already.

I have not idea what promises the verifier gives but if it's supposed to
extend to avoiding deadlocks then we probably have quite a few issues
right now.
