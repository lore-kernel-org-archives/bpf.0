Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580318;
	b=TjDcG7Qkpw7J+w8erNawVzU71/uoQATqq9eAvqJ5KM4yxcBKtasOGlLGywUuvY16fKVD
	 xE3lRzrQubZifnLNLC+YHRx5F5WncNyQqTTxgde3jjzZu9GdpTQGuEKppxhMsKBmVeM73
	 HO6TL/efHEbt36wg6Y2eP0FytsdSwngJhToacc6cbXnDhdZWXCB5V/fHOsEhZXtLotvm2
	 6gr6XlDNAn1fnXQ2uxH1E9vfz8gZPbPJsh+215scrsRbp6QG42WByApcraNM8n7KRZDyY
	 GVkDoAp92Tir7MjpRkIbOVeP6r9HojGU8PEpxKk8wx4RRiMDwErCrtuU9uamA14FA3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=t/rAtuw8L0JVO1MzbBUMP/K+LGokTIDtHsowAZbEJHg=;
	b=vr7dbUEgm3iS7QhsaL2LyYv+xj/GnaJkPg5Vo2A1I8aZ2AFq5mtdIPY4OlK9M9uMfHvJ
	 ybT7tTGU+75yIA0v/7TVRgM5TN3q0mQOxt8IRSSdD/9cn9y6ZjFdVPsOqEBRqLus0NxIU
	 E5Zat3Xn1xVUlHqDR/5Lg3pV4/SbEQvWAlEh3riANrv6dA52xxGJH1ECeJwqOI8GeWyd4
	 KAsjo41ARwzalzU/EIfo0pOqojatd6wglQUvqVy3+UzYPSqL+YNcjuWLxdMgneRFnBRCf
	 ZSi23yc/kRVacoYynvLQYLuVjGies+aLmGY8hCfIkAFaAvf5vvLOAQVOnA99iJqXX5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=HHNDkB5Z;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B055E606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 10:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B055E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=HHNDkB5Z
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a070781f63so246492b3a.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1792580317; x=1793185117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t/rAtuw8L0JVO1MzbBUMP/K+LGokTIDtHsowAZbEJHg=;
        b=HHNDkB5ZzLBhcoftqluBfZzfk4FH8wqvFihietVucu3AcUZ2N8eU/TTlxfrIw6DLfj
         1a8W/7mx/j8/kp4xIxcA21hhjb0fB9pr5EZZX7iBMO/KKIP/GGfzgLjAt2gZalRQcKM7
         AnH11A5NWmfD7vXByk1SGh2GmRnXVcG5XI9Rza+srIZzailb/5tz+lK6qrKO+NUYDLT4
         JHFj3HB9npVsefJH3zwmWSvy+HReCVoSn7l9cR04PABVYFzHOxZy5OpxGRdN37QaJ8oD
         N84LLbssL3LEgR7A0kyTlogxWFxWLY4kLkv9wkhzmI1PFjr84+c2+MTuIPc+Rjz9oO/v
         Jc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580317; x=1793185117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/rAtuw8L0JVO1MzbBUMP/K+LGokTIDtHsowAZbEJHg=;
        b=h8RohxHkdKK5gH/UH10wuO/PHBtNk1ObFHvuXiPu2nmMuzhhxqTM4yZ5N32SUDLgOA
         LcfipdLzXOQ7D9YC3nszgg8ZjsobQ0ZTpfHAckIvgKOJIFLcCdATiyYAv1lZtyfwx3gp
         MkjeOncdLmiywcgRlDDBsWsRotegih9+EZ/CvDwNMsoeAS5jayyxDf5yDAm/E8eloFbL
         RfrsFV41uNgmdsbIMT9ILZKj5RGhLSiHZgAVd7naHcgqWKxoFROs2CL5+oE8TstYVkJH
         7pdNWt6NlcB9+UF0Lek/vnRdgndY2qcuC7obpK7JzvUgvQNxWX6gsQbl1reZiD+lNs/U
         a7mQ==
X-Gm-Message-State: AFq9FYL67piRK9rvGGh8sYSPnTuErYBwjGHT46XTyndjWH7RVCqcOcXK
	mrC8cCGtWs5lvup+ShjtIMMhOBnsvzNfnRdl78EBxYtsS9OlWoDsOWAacxmUZh0R1Uff
X-Gm-Gg: AYBFou05icSqQv2tLNQmGLaqC8S6Ws+0Iepq9qn+VhNV/0/XU3wcS7QdpLhwA3Kmx+B
	ADERyRpe3SOtLzoCo/qf08M1FLH1uO21tpIMHT2C9LTpet5TT5bWTsiTKwwLb/GUdfvVIVpkfDE
	NPpzWjrnCowriSSKC0tWsLVNgARJ+JJuf2rh0dSSdfO71CJ4TFgxbrCBUUC4GICOIIG+W9Ws1OM
	ib/7TXZrJks+i0gZIAdQUmGMlsDzwjmL2jptWP+UH/mfWKpZ9HTUfsRbaq4LAMIY9f3LkPghe7s
	nUDSEyBu5TEybLir9znbbP7nolD6Lxi8tVg127bdVbL3+/008nB9xvF2LunrnKHTJwdEEYU7S74
	rtaPvTXeWe+Y9k/VFjBemRxc75kApYgabVNHsxvw+UL/4Afg39V2iRqoWEJbFGPRuvsD+BbEnwp
	1Oq+7kG2+y/wKsTAYRKlpcmQiWt2pWvGhk1494B194A2tQdw2uk3ckKIn8JImu5dqeKPYUOf2yQ
	T81YGfYmlKvzmLOXkf7sfF88dQe1AFmqnXvgOjD2U81s4Y3aSc7+lDgcn03iW3z93/q1VrIFe2e
	vkOZN3uF3dUZeg2xSycQoT1/fusX5Z4=
X-Received: by 2002:a05:6a00:3d11:b0:89e:9c7e:fd51 with SMTP id d2e1a72fcca58-8a089d0783dmr1174185b3a.10.1792580315723;
        Wed, 21 Oct 2026 03:58:35 -0700 (PDT)
Received: from lima-development (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49dcsm730783b3a.16.2026.10.21.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:58:35 -0700 (PDT)
Date: Wed, 21 Oct 2026 21:58:09 +1100
From: Matt Bobrowski <matt@bobrowski.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
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
Message-ID: <atiawbBo6WRPA6QA@lima-development>
References: <20261020105014.97985-1-matt@bobrowski.net>
 <20261020105014.97985-2-matt@bobrowski.net>
 <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>
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
In-Reply-To: <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>

On Tue, Oct 20, 2026 at 06:24:42PM +0000, Alexei Starovoitov wrote:
> On Tue, Oct 20, 2026 at 03:50 AM Matt Bobrowski <matt@bobrowski.net> wrote:
> > Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> > is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> > cannot race with that.
> 
> The crash is gone, but so is the path. file_release progs will get
> -EINVAL for every file that a task still has open when it exits.
> 
> It also breaks what works today. The d_dname branch in d_path() returns
> before it looks at current->fs, so at task exit a pipe or a socket
> resolves to "pipe:[123]" now and to -EINVAL with this patch.
> 
> And it's not specific to bpf. The comment in fs/cachefiles/namei.c says
> that current->fs == NULL in do_exit() breaks d_path() called from ext4
> open.
> 
> can we fix it in d_path() instead ?
> With an empty root prepend_path() goes up to the global root, the same
> way d_absolute_path() does. Then the check in bpf_path_d_path() is not
> needed and the selftest can expect the path. A chrooted task gets the
> path from the global root, but it doesn't have a root anymore.
> 
> Something like this (compile tested only):

Prior to sending out the fix, I also considered addressing this directly
within d_path(), much like you've proposed here, but decided against
it. d_path()'s contract is to build a pathname relative to the current
root. It does fall back to a root-independent name when the path isn't
reachable from that root, but that fallback still presupposes the caller
has a root to measure against. An exiting task past exit_fs() has no
root, so d_path() has no correct answer to give in that state, and I'm
not convinced we should invent one for it.  That's what
d_absolute_path() is for.

You're right that my patch regresses the d_dname case though, since
pipes and sockets resolve today without ever looking at current->fs.
Rather than replicating the d_dname check in bpf_path_d_path(), which
would mean duplicating VFS logic such as the mounted pseudo-inode
special case, I think the cleaner fix is to move the "no root, no
answer" check into d_path() itself, after the d_dname branch:

	if (unlikely(!current->fs))
		return ERR_PTR(-ENOENT);

That keeps d_path()'s semantics intact, keeps pipe:[N] and socket:[N]
working at exit, and turns the oops into an error for every caller,
including the ext4 open path you mentioned. Nothing that works today
changes behaviour; only calls that currently oops are affected.  Callers
that want a name in that state then have to choose one explicitly, which
I take to be Al's point.

For BPF, that choice could be a new BPF kfunc wrapping
d_absolute_path(), so programs can pick whichever semantics they actually
want, and file_release programs that need a name at exit get one whose
format doesn't depend on how far the task got through do_exit(). I'd
prefer that over silently falling back to d_absolute_path() inside
bpf_path_d_path(), which would return chroot-relative names before
exit_fs() and absolute ones after, and still wouldn't help pipes and
sockets since d_absolute_path() rejects internal mounts.

Al, would a check like the above in d_path() be acceptable to you?

> diff --git a/fs/d_path.c b/fs/d_path.c
> index c253090..ea49d33 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -265,7 +265,7 @@ static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
>  char *d_path(const struct path *path, char *buf, int buflen)
>  {
>  	DECLARE_BUFFER(b, buf, buflen);
> -	struct path root;
> +	struct path root = {};
> 
>  	/*
>  	 * We have various synthetic filesystems that never get mounted.  On
> @@ -284,7 +284,9 @@ char *d_path(const struct path *path, char *buf, int buflen)
>  		return path->dentry->d_op->d_dname(path->dentry, buf, buflen);
> 
>  	rcu_read_lock();
> -	get_fs_root_rcu(current->fs, &root);
> +	/* Past exit_fs() there is no root to stop at, go up to the global one. */
> +	if (current->fs)
> +		get_fs_root_rcu(current->fs, &root);
>  	if (unlikely(d_unlinked(path->dentry)))
>  		prepend(&b, " (deleted)", 11);
>  	else
> 
> pw-bot: cr
