Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9752C3CE083;
	Tue, 23 Jun 2026 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204263; cv=none; b=lxy50FIyhsGmFJlp40js4QK6eizqW9AXnDGrWrTowenJU3G7qXYOB6nM2LMIrosbx+vMx4M2B08HGsK7gQZnIZsQIQ2l/BPwcCjwBsGScSBrcD20Y/tONMTyafAeDeZqNDTvweSwUEBVSC8QEKa7aO6EpyrxgVTkBsL2Ac/fqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204263; c=relaxed/simple;
	bh=xw9NRBVUkFg8CCVr2f3+oeKtZEjveSdW5q17uZHSmbU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=hhiwbQ+syPIaDdDfUC9cs6nspzNTmCHPEzcdE/K3gJJLxKQVBgN33tn7+0gW7pVLMyJBN1JqoN5f2yCTwhO2UvJL1KP/l44bS0GF18D8VT9I8+OEIG5lrqXZvHC7qKv78bb/M8RJwNkjWDYSKrMPS8SMNxet4agKmglZyk4EW78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKyzie0K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKyzie0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40FA1F000E9;
	Tue, 23 Jun 2026 08:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204262;
	bh=jTF1xPaRcrdYfpGJO/1QRwXrYeuBiryYE8AtPeKO+f8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=PKyzie0KHr9LI9sg/tNB6Kych6nKA4sSRMSgh1HGRhg8JQX2jHfHxn5Gqb873n0qz
	 e7yIGHxqqu36O1EMpvhMVEl7WtsZSsIcvqwh5DyVyCTlExBXhNPCqlvrkXXEs9dk4J
	 dcBaA2n8ZSZevF+/o/Qh7iZM6+1zFIATm3nODRHWWW3fx/N+SQCSq3Q61VbzZrP3iF
	 qtnkAdn9upGO6LmsoU6R8vFg/chzllA3sKqM7kKSCdiMcJHYTybfC03EAUefty4Uj/
	 ggYrJMyOLySTjF3WUWHXUaUOxAQcNxevKw/P881oFe7rS68qlFf0WgRwFoP3mNtA0m
	 S3q2nAn5BBa7A==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: have bpf_real_inode() take a struct file
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAOQ4uxiaD3NnUDBCTYzjS-8+y8boxzwVs1p8QsWaC4AkVFPu5A@mail.gmail.com>
References: <20260622-work-bpf-real_inode-v1-1-4014eb4cbefd@kernel.org>
 <CAOQ4uxiaD3NnUDBCTYzjS-8+y8boxzwVs1p8QsWaC4AkVFPu5A@mail.gmail.com>
Date: Tue, 23 Jun 2026 10:44:18 +0200
Message-Id: <20260623-defizit-unerkannt-einnimmt-779e270d8868@brauner>
X-Mailer: b4 0.16-dev-e7e48
X-Developer-Signature: v=1; a=openpgp-sha256; l=2577; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xw9NRBVUkFg8CCVr2f3+oeKtZEjveSdW5q17uZHSmbU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZuadIXPrdZzJVI/PnfYcv65IWdj7Ta/lwMZvnyV7t6
 I8sbN8TOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyu5mR4ap0yyvex1tk3t3a
 97DH+6Nl0llH0dapAUnmab45f5Sr3RgZ9qg0a4awGfrVeFc5zglZ033iSN9sZaW5gdMs3y+YZbK
 NHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-06-22 19:15 +0200, Amir Goldstein wrote:
> On Mon, Jun 22, 2026 at 3:58 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > bpf_real_inode() must be usable from the bprm_check_security, mmap_file
> > and file_mprotect hooks for systemd's RestrictFilesystemAccess BPF LSM
> > program. It should take a file instead. The kfunc landed this cycle so
> > changing the signature is safe.
> >
> > Fixes: 9af8c8a54f6e ("bpf: add bpf_real_inode() kfunc")
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  fs/bpf_fs_kfuncs.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > index 768aca2dc0f0..f941c29d26ef 100644
> > --- a/fs/bpf_fs_kfuncs.c
> > +++ b/fs/bpf_fs_kfuncs.c
> > @@ -360,18 +360,18 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__s
> >  #endif /* CONFIG_CGROUPS */
> >
> >  /**
> > - * bpf_real_inode - get the real inode backing a dentry
> > - * @dentry: dentry to resolve
> > + * bpf_real_inode - get the real inode backing a file
> > + * @file: file to resolve
> >   *
> > - * If the dentry is on a union/overlay filesystem, return the underlying, real
> > + * If the file is on a union/overlay filesystem, return the underlying, real
> >   * inode that hosts the data.  Otherwise return the inode attached to the
> > - * dentry itself.
> > + * file itself.
> >   *
> > - * Return: The real inode backing the dentry, or NULL for a negative dentry.
> > + * Return: The real inode backing the file, or NULL.
> >   */
> > -__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
> > +__bpf_kfunc struct inode *bpf_real_inode(struct file *file)
> >  {
> > -       return d_real_inode(dentry);
> > +       return d_real_inode(file_dentry(file));
> >  }
> 
> The problem with this API is that for special files it is a bit ambiguous
> to say "the real inode backing the file".
> Is it d_real_inode(file_dentry(file))? or is it file_inode(file)?
> The old API avoided this question.
> BTW, did you notice that for non-regular files, this helper returns
> the overlayfs inode?

Yes. Very aware.

> This may be important information to document when exporting a kfunc.

Ok.

> If you take my suggestion from the previous round to name the kfunc
> bpf_real_data_inode(struct file *file)
> the intention becomes a little (bit) less ambiguous. huh?

I don't remember that suggestion. Maybe I missed this. I like it!
Let me send a new version.

