Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0CC357CE8
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800719; cv=none; b=KGTFNs2YsGOoZ7HhM5mWD3VsNWx6OxAfQFWxs6XJbHZ5S+YFoe3KZak56ZXzxHSQCAyAjLxjiCIIPjdGU4AE90tsnsvKBUFH+ZzzglS77Bn36NmYo/2MKZ6hfvQikcdHENDc+h0Lg6L62VwOGVslb9y1tcfaW9qhR9bLDc5E1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800719; c=relaxed/simple;
	bh=AgwkCGC9ebLqShBPgzXIgWaQdCpONyC7wtdweo1VYK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bH3emdJF/w5WrsOEWeP+uoCzg+nUCsNCdL04b9AaAjUY05c41vuNJxJ+Hku5gSW2j82FCvsnhLLwUdn1UCO4SSjdF6qQJ9oipawG5mOJy83Nl5c5Q/ZrG2gkC9HncNRnf2DxEE9beWDLhqfpfXIrmwx+FfwHJxnRB91NTLDT6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR56/QV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR56/QV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6A01F00A3A;
	Tue, 26 May 2026 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779800718;
	bh=LpxK3svt1bGqckrEs8687ZoKDkqBGYU58nC6EKXoH7I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LR56/QV2grAuQVAQQ2h4jrh9JMJL3xfdCqJv0ZpRup36A6iBSyCu0C/ckKYJeNVFC
	 mlH4dFAXuAHUC+ZRw3h+wm9nQBspSLFm/gYmWsowSIdyJPOWOOHJ6DclXJquraWwMY
	 t+SVytDHNn0JEvs+75hsePn2cojLsbzgVsfIpiT5NVXbt5z/vFO7EM8dLVMbh9V+Tr
	 eeXU7kAsUhYhNF5xGFRG4X93P5/4VQQSji4Hbj2SklZFT1qrwy5tO9WkLHJOqMfI5a
	 tyV/wk3K/5j1UYi5wLTKBDaqmyAt3BO4IBmWt7SAyohx/nNMeLZzHj/xhnFR18OWJZ
	 Obn0/GCocp6HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] bpf: add bpf_real_inode() kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526-work-bpf-verity-v2-1-cd0b1850d31b@kernel.org>
References: <20260526-work-bpf-verity-v2-1-cd0b1850d31b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 13:05:17 +0000
Message-Id: <20260526130517.DE6A01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] bpf_real_inode() fails to resolve the real underlying inode for di=
rectories and non-regular files on overlayfs.
- [High] bpf_real_inode() can be exploited to trigger a kernel warning (DoS=
) and bypass security policies via pending signals.
- [High] bpf_real_inode() exposes overlayfs internal locks to BPF, allowing=
 trivial self-deadlocks.
--

commit ea7b29442723e30589a55df64a725a8aaaaeddd8
Author: Christian Brauner <brauner@kernel.org>

bpf: add bpf_real_inode() kfunc
   =20
Add a sleepable BPF kfunc that resolves the real inode backing a dentry
via d_real_inode(). On overlay/union filesystems the inode attached to
the dentry is the overlay inode which does not carry the underlying
device information. d_real_inode() resolves through the overlay and
returns the inode from the lower, real filesystem.
   =20
Link: https://github.com/systemd/systemd/pull/41340 [1]

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index e4e51a1d0de28..761fbe0fec5d5 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -353,6 +353,21 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup =
*cgroup, const char *name__s
>  }
>  #endif /* CONFIG_CGROUPS */
> =20
> +/**
> + * bpf_real_inode - get the real inode backing a dentry
> + * @dentry: dentry to resolve
> + *
> + * If the dentry is on a union/overlay filesystem, return the underlying=
, real
> + * inode that hosts the data.  Otherwise return the inode attached to the
> + * dentry itself.
> + *
> + * Return: The real inode backing the dentry, or NULL for a negative den=
try.
> + */
> +__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
> +{
> +	return d_real_inode(dentry);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this code fail to resolve the real underlying inode for directories and
non-regular files on overlayfs?

When d_real_inode() is called, it invokes d_real(dentry, D_REAL_DATA), which
maps to ovl_d_real() in overlayfs. However, ovl_d_real() contains an explic=
it
short-circuit check:

    if (!d_is_reg(dentry))
        return dentry;

This means it will return the overlayfs dentry (and therefore the overlayfs
inode) for directories, sockets, and symlinks.

Since BPF LSM policies using bpf_real_inode() to restrict access based on t=
he
underlying real filesystem will receive the overlayfs inode for directories,
could this cause inconsistent policy enforcement and allow security bypasses
for non-regular files?


[Severity: High]
Can this implementation be exploited to trigger a kernel warning and bypass
security policies via pending signals?

When bpf_real_inode() is called on an overlayfs regular file, it delegates
to ovl_d_real() which calls ovl_verify_lowerdata(). This attempts a lazy
lookup using ovl_maybe_lookup_lowerdata(), which then calls
ovl_inode_lock_interruptible(inode) to acquire a mutex.

If the user process triggering the BPF hook has a pending signal, the lock
acquisition fails and returns -EINTR.

Because ovl_d_real() treats any failure from ovl_verify_lowerdata() as a
critical bug, it will trigger a WARN(1, ...) and fall back to returning the
overlayfs dentry.

Does this allow an unprivileged user to intentionally trigger this path with
a pending signal, reliably spamming kernel warnings, and returning the
overlayfs inode instead of the real one to bypass BPF LSM restrictions?


[Severity: High]
Does exposing these internal overlayfs locks to BPF allow for trivial
self-deadlocks?

Because bpf_real_inode() is marked as KF_SLEEPABLE, it can be called from
sleepable BPF programs such as LSM hooks or fentry.s tracing programs.

When operating on an overlayfs dentry, this attempts to acquire the
non-recursive mutex OVL_I(inode)->lock via ovl_inode_lock_interruptible()
during the lazy lowerdata lookup.

If a sleepable BPF program attaches to a kernel function or LSM hook that
executes while OVL_I(inode)->lock is already held by the current thread
(for example, an fentry.s trace on ovl_do_setattr or ovl_do_copy_up), calli=
ng
bpf_real_inode() on the same dentry will cause the thread to wait on the
non-recursive mutex it already holds.

Could this result in a self-deadlock, completely freezing the thread and
breaking the verifier's safety guarantees?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-work-bpf-v=
erity-v2-1-cd0b1850d31b@kernel.org?part=3D1
