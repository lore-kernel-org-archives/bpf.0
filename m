Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051769;
	b=KVY5qDnspsB0WAZ57tgeYjrn7rf7a1kMrhc0OIj6xedpxUSKzQ3eWPYBi/70D75I8QL6
	 INWGY2dugDDmgxh/6S/dQc+MmjYxMmmZMorvIYaNRaVlfe3uvKlECd13ZxHlq6QTgw7Hr
	 xxPDY6Ep/wddiqz1QMhJk8KYhnL24kPUl1i9GHL0LK8R7DhnJazMwgJrAZPqsqaH8Gj4U
	 93dkwazAzoCAJE2dv//pZhQzuYhjWe0OZUDT+3ZAluYgzoORO2yxXyGpa2cCAUDr/P6/L
	 p/huF23WeXLlU/f6k9eJ+lmqcXrpHobLkP/eQzUt+OF/O3uxuEw9r99mV8CNFtbGg3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=MCaOqkvghFdjPjEBy1YWJcxG17ikaMSWnkn1If8Ln38=;
	b=GYhkiacng+jj17qSE2JwpOu0fOq8SuvrVXoBzbub//td8LUfYqI5DywR0Zr0gdPW5mCk
	 oE+Gyum/gXBs5v1xviGJ2fCj2vWpFNtDNdLYP6Nj/Mxk7oTIwA0XL07eyq2Mlw1WrcaCy
	 ifwSZ9NUlHP5dBerqN1FC34MjGQcX/tSj2u2T2aV3dTu7MmouJ4eveObSjR3qsFMxIEJx
	 9SIpRoYaO0+M5JA6/cg1WgQB0EtLLNyVHJSMiP2QuCUpqvwlaV3PqJGboBCJfhFcBC37A
	 WUdtXbm5qL6Cx/0PoqFiGcALdcfOKM7qBphjswBEL6eVL4oF82BhC6Id8CxVnyiiTiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=r6qzBHbJ;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0512D606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 21:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0512D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=r6qzBHbJ
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e942864693so18398035ad.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1793051767; x=1793656567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MCaOqkvghFdjPjEBy1YWJcxG17ikaMSWnkn1If8Ln38=;
        b=r6qzBHbJ+Y6VySD4piiJQaxG3nmkcim5EedbVvJDLrFKh/z/zfWGVfhzESZgtJcOTT
         mOo5hPQeKtOllDCqHQ+bRmmdG88imPwjlx7DaOoM0KaMz1KXsKT7apGPB22NyoerYTZQ
         /4vIHuibqhucsMEMxk6fldlNHvt+fNxp1ovjKGI/eW/I63Ib5IBoE4CjQEJudyO76Wtf
         1D4vXfgdUVq64lyBYfYwd63VG89p4VOSXiOVGnpeaDouPGJAbGZiYCtI1VTyrXIr7v33
         A771pKw10Qc39HU/IR1PbeHnB+RlD52C7qD/1DVFZS4Ju3IhXtUDcV290iNJz9ZhBNR4
         wpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051767; x=1793656567;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCaOqkvghFdjPjEBy1YWJcxG17ikaMSWnkn1If8Ln38=;
        b=TCRVNWeqgTb2Wm2KZmNannj+C8P8F5NvBAWkXvRa3TTZTdNN7ebmJlJYHD9Bdq3gGl
         VQqJzN8luFXaW6t+MPiXwr9NYgrBO72nv9RC2kqAT6KSAEjeol2RreFz77NABR1XI1n6
         92Vf8vNfEkLyDjhEBoc+q2XJaN9uLkRXuyBSDQ1XBK1U5G5PW/offJ/1KfQiK6qBIVTI
         TcO3auhFMo9aXN42/bcAMgF5w3O4//HDSZMV+sQafSsrtfafzj9jPYP0/87gbMQMdoKU
         mFxfkddJbxJBcdg8TX8xDoV0X+eGnmoionjmuPT2aSNUmZOAh4hAF3Ys2N/AKNF9j2aX
         zxyg==
X-Gm-Message-State: AFq9FYJndvSZ8kJ9dU/2N5y2ayeK00eRQK32L9AeJZuD4e12Cr2CcUVn
	NP/HWsI/pUPCe3ymktY0uPDfyQFKbqJG0W51vl63UpuYX/v+w3duE+UFgSWPDD3nCn1k
X-Gm-Gg: AYBFou0E2brOsF2Lq646tbMbAEBL/8EACnQG0l2Jw4xkXGzjoqxWONo35ViQgF7NYlb
	DCmI+tVr6G6LQvys0hNvUBYYVyXtf8+M0EKegbPIhBvnxUKHIYOKIs7WJjf1BDs1Ko0+PAzzfLT
	42giymAqvyHD259EfjSHXQOd4xy85H82SgZ67B7FdULxbFWunVZ1cyZ+4CA/ItKopwW7X+oZi85
	eldz1ElEOOdz74dMHVcI3WKhInGeNW425OokkcEbPmGJfvtATdoYEpuVVxDqgpwZwx2RfTQIbvO
	S1mu4rFI0mCs+aJp51Mud7SPHUtS9wp2KeqawBooops2QCA8AKY5vSEbCIluLQPQD/rbR9+TZDc
	2tFyk1mNtFqJl0MYVr+4sd3PBPyhEL57uf9NGhUz2CXXv9vtxFJL+gOR1sNpfWay86YBohVtLT3
	PFGrBDafssiiwahiI2UxfdrGTCDYek4FE6g3qZkfC4KY79EZphT+8CSsQiORSSbtpKLgigMYSlT
	EHauzdcQbROKh+vgQorlYnEXbsconBfCJEvfwUvLF3Og9R9s68cq3I6tagkj2YEXKmIcZu1/xqs
	76GwliQLbKOp1DR0D1Qhc9210RoAggkESA==
X-Received: by 2002:a17:902:db0f:b0:2df:9a7e:d41f with SMTP id d9443c01a7336-2ea9c8740edmr75437265ad.41.1793051767231;
        Mon, 26 Oct 2026 14:56:07 -0700 (PDT)
Received: from lima-development (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6455a00sm1186455ad.2.2026.10.26.14.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:56:06 -0700 (PDT)
Date: Tue, 27 Oct 2026 08:55:57 +1100
From: Matt Bobrowski <matt@bobrowski.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for
 exiting tasks
Message-ID: <at_MbcW0OlciNLrE@lima-development>
References: <20261020105014.97985-1-matt@bobrowski.net>
 <20261020105014.97985-2-matt@bobrowski.net>
 <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>
 <atiawbBo6WRPA6QA@lima-development>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atiawbBo6WRPA6QA@lima-development>

On Wed, Oct 21, 2026 at 09:58:09PM +1100, Matt Bobrowski wrote:
> On Tue, Oct 20, 2026 at 06:24:42PM +0000, Alexei Starovoitov wrote:
> > On Tue, Oct 20, 2026 at 03:50 AM Matt Bobrowski <matt@bobrowski.net> wrote:
> > > Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> > > is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> > > cannot race with that.
> > 
> > The crash is gone, but so is the path. file_release progs will get
> > -EINVAL for every file that a task still has open when it exits.
> > 
> > It also breaks what works today. The d_dname branch in d_path() returns
> > before it looks at current->fs, so at task exit a pipe or a socket
> > resolves to "pipe:[123]" now and to -EINVAL with this patch.
> > 
> > And it's not specific to bpf. The comment in fs/cachefiles/namei.c says
> > that current->fs == NULL in do_exit() breaks d_path() called from ext4
> > open.
> > 
> > can we fix it in d_path() instead ?
> > With an empty root prepend_path() goes up to the global root, the same
> > way d_absolute_path() does. Then the check in bpf_path_d_path() is not
> > needed and the selftest can expect the path. A chrooted task gets the
> > path from the global root, but it doesn't have a root anymore.
> > 
> > Something like this (compile tested only):
> 
> Prior to sending out the fix, I also considered addressing this directly
> within d_path(), much like you've proposed here, but decided against
> it. d_path()'s contract is to build a pathname relative to the current
> root. It does fall back to a root-independent name when the path isn't
> reachable from that root, but that fallback still presupposes the caller
> has a root to measure against. An exiting task past exit_fs() has no
> root, so d_path() has no correct answer to give in that state, and I'm
> not convinced we should invent one for it.  That's what
> d_absolute_path() is for.
> 
> You're right that my patch regresses the d_dname case though, since
> pipes and sockets resolve today without ever looking at current->fs.
> Rather than replicating the d_dname check in bpf_path_d_path(), which
> would mean duplicating VFS logic such as the mounted pseudo-inode
> special case, I think the cleaner fix is to move the "no root, no
> answer" check into d_path() itself, after the d_dname branch:
> 
> 	if (unlikely(!current->fs))
> 		return ERR_PTR(-ENOENT);
> 
> That keeps d_path()'s semantics intact, keeps pipe:[N] and socket:[N]
> working at exit, and turns the oops into an error for every caller,
> including the ext4 open path you mentioned. Nothing that works today
> changes behaviour; only calls that currently oops are affected.  Callers
> that want a name in that state then have to choose one explicitly, which
> I take to be Al's point.
> 
> For BPF, that choice could be a new BPF kfunc wrapping
> d_absolute_path(), so programs can pick whichever semantics they actually
> want, and file_release programs that need a name at exit get one whose
> format doesn't depend on how far the task got through do_exit(). I'd
> prefer that over silently falling back to d_absolute_path() inside
> bpf_path_d_path(), which would return chroot-relative names before
> exit_fs() and absolute ones after, and still wouldn't help pipes and
> sockets since d_absolute_path() rejects internal mounts.
> 
> Al, would a check like the above in d_path() be acceptable to you?

Al, what do you think about what I've proposed above?

> > diff --git a/fs/d_path.c b/fs/d_path.c
> > index c253090..ea49d33 100644
> > --- a/fs/d_path.c
> > +++ b/fs/d_path.c
> > @@ -265,7 +265,7 @@ static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
> >  char *d_path(const struct path *path, char *buf, int buflen)
> >  {
> >  	DECLARE_BUFFER(b, buf, buflen);
> > -	struct path root;
> > +	struct path root = {};
> > 
> >  	/*
> >  	 * We have various synthetic filesystems that never get mounted.  On
> > @@ -284,7 +284,9 @@ char *d_path(const struct path *path, char *buf, int buflen)
> >  		return path->dentry->d_op->d_dname(path->dentry, buf, buflen);
> > 
> >  	rcu_read_lock();
> > -	get_fs_root_rcu(current->fs, &root);
> > +	/* Past exit_fs() there is no root to stop at, go up to the global one. */
> > +	if (current->fs)
> > +		get_fs_root_rcu(current->fs, &root);
> >  	if (unlikely(d_unlinked(path->dentry)))
> >  		prepend(&b, " (deleted)", 11);
> >  	else
> > 
> > pw-bot: cr
