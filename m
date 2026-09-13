Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6037C930
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341910; cv=pass; b=fXH2GM3P8UnIWbbTw7HJNsLDlWhhq5Si/NB2Kynxj/y5UGl6L9PBF/kiutO9L61esBS8ekqbgXizTxyu+j28gylQk38IoUA776nZn18wmG/XrsDumnM6pyEks/0Uhs82PvWzb9i/gh6+gIw5GegKyGEizP4++d0mqZwuOkM8yPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341910; c=relaxed/simple;
	bh=MKz9YMkBGISCMtma3zl4V6/L6vHskNHtuEKv8FNHu8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzzOVXUZnwwDB+gezC33+/hb37EMdskvyAJuifSqL1mJjQCOGWNmRNI7viiUnN9sY0o34fnqIHyXVs2kHnwJv5DI6wnlXbYnzpIcWVxIVTExVwXQ9MzyhPx8kg+HdJ7X3n0pG6QmUD7TKSl176KXLq/kyWSc5gZWujF9sy8xQ9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdcNQvqv; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdcNQvqv"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86dd69a1b15so239357b3a.0
        for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 16:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789341908; cv=none;
        d=google.com; s=arc-20260327;
        b=iWHBLue1HGKM/VnDnUYYMIqd4PKxvW7OTGxy6Et/GJxGlLb/Il0RIUNNJPUgeWzt+1
         jNA7kIgh5qSVhGGn5ncQGNb3VPNwakxIFqNNw/ZtoNsQuNtwRKM75cujrApn0X07FKTB
         H1/RdIk+614it5vYX9xsrkpd7LCClR42RUn2xk6yMVGGHOqzTxY8PGaZdw4HCRSn4bCq
         Q8FlkcDoqdNh96BZmNPdR6/5gH8D5V4pRZEKrkBIkjAaf44xnmFUI5oexVVt8TOcM091
         XNY3vbSfpo0Y/lPb04BWBmsQ6uG/q0TU2V0xGAq01MOzDf8ZWD2BfOzhHP76K5eg5QU3
         LVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pbPc/varaxQSoxoCvlzbtZpSK7urW4ExB0j1Yox4pVo=;
        fh=/q4jvpyhLt948RYqFlHw/2K0M+2R2oQT5yAek1zr5wk=;
        b=ccL8CoRxtqE+nkREF1ITbqu1JHjgMuAgPh6kwv+sHCxmDiccuSS/OCye6g4mUbDXdX
         2lg9vVx4JbVqFt5lTdohlKeFfTIwXx+Iizx8MD+0TjYiHyCYtSW4Dy3bD84sgoVnasRY
         DDqV92mTuXFCCxtxrdl5wvXzx4xUpRdMYoHEDprbDyzlzfKq0T+73KgAHHcQYVkjb3c6
         QRM2urlUpGN/tAZnp61Z8qvK2X+41ieE/2gmOvmH65z8nI5LYK5WR8K0fc3udITjIeFK
         4XVLKIzkk05sZcaBjP+sYxjd195/BQMN7dMEn4KH9pzens4+/N7PY+C0+QEOmXUqgV8B
         2kmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789341908; x=1789946708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pbPc/varaxQSoxoCvlzbtZpSK7urW4ExB0j1Yox4pVo=;
        b=GdcNQvqvWwzquJgXATB7kfNOSBVXqpwZjNMNOmOLbnz0ldHeslnRK4hic72ZE6oMun
         j0UC1uJAtCxu/RtUqx3a48H9RqiknvMPC/qnc892eLGXJPITtSWmP8PVhhJlVbU6P7Tf
         Y1QZOZc6g4xrYqKwTDuq3vreKroCNZenh6wbkDL4djFzwJYR7t/9F+yQ3GMPHAKFAheX
         5+hKGTS6VtDjMns8RAs/X54vgQJ4yDJ98hocOuPqa13IM7OebUb3n11GwWaAHF6eld2R
         eclqt386plu4Uw3CVp64recHkjCK/Ez8iNbo6OakvplDIX+YKRJgZfNDf22UfYb5sOLG
         ZKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789341908; x=1789946708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pbPc/varaxQSoxoCvlzbtZpSK7urW4ExB0j1Yox4pVo=;
        b=N8JFZQELR94vy5tZzB0uWjG6sg19tPy3vdsVFOkE+oKagmRP/pb45hq2jOFG17JaZF
         OPvqzwyt9K+iEcSlLrFfb8QEZ5WDDkrBIpD3dWAifa5MXCuhjJJUjYws36RS8TG955WX
         gBjmJpGUzunut834JpHNxG0C1oBNjH0NE9OO8GHD0fLCMyPUbrR5jf12y73v773Uufwp
         Rp3vMVfXxiM6Neudt8NcGyS5QGsWQoZJ3KeIStPFryF/txZqJUbEQ6rt4Gh5Omd0zToI
         IQa78jQz72fECMG1uOTHky1cp6EPgO8Z5j1yv4D6ivjbsi6VZrr3XH4mTcp6wSRjRFKp
         NneQ==
X-Forwarded-Encrypted: i=1; AKwUvBzf4SyTdoIZ5qKpUkYicnPDfNyOGYNprDpTp7QP6WvJa6RUUFjWG+2t9bu7wYkcD+0c5bw=@vger.kernel.org
X-Gm-Message-State: AFuF++nCKrXnKe0mGxUh0WoyGkLYy8fjpGCmbAkoUG5X+dSlE71tdzBB
	InY3muqTKWhNlMsnXmb4wA4ROX9m+PDfmcWtv2MOrd/1KmD8ZIGtKag83KD6G8I+c5XJYIBkV+v
	qF6ZwpBTDnzRXcVa+E4ZqfrdO7Js2IC4=
X-Gm-Gg: AYBFou19kJ387hTVUEDBVWwBgrG2fvmsWvLanJGBaFE0d1DGCFEGu/XoTSjLqVRGeUf
	kuPkDQ6no+KvVdAL7oLUUk2SNrt3pEf4AXNGcRwahkxkE0y0cwJtsaSDG3F5C2QJlfYFXQRdimw
	LgCSkeioyVj8HT4yboVTSZfe7m6LGLW4rybEAFql4aMCwBRnR9cH8jE4bHzT7/Ts/pUSvLVKGW0
	PUqGOnZtIaCCpgLdOLDFq3mkUzQMO9Y4KyBaF0Svakm2Bitrl5hG3l9ouyxfxi+TBmdfhC43G0o
	0tEdqKH9KO30mBkgqW+WRrFbKdnNpJweKK+gnQkPH3EiBsnS5jkZIoPGYPtxzhTI0qWtP57OnV4
	zVdnowN1Pr4oG8SlMfN6FWJlkm3CQMudj+u1O5ZY=
X-Received: by 2002:a05:6a21:4c0f:b0:3d8:effe:34f2 with SMTP id
 adf61e73a8af0-3db3f1e2442mr103161637.12.1789341908038; Sun, 13 Sep 2026
 16:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com> <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox> <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com> <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com> <CAHC9VhS0JckwfomqLTUJkZZkDSgeRXYOjMmPQYErgYynQYqMKQ@mail.gmail.com>
In-Reply-To: <CAHC9VhS0JckwfomqLTUJkZZkDSgeRXYOjMmPQYErgYynQYqMKQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 13 Sep 2026 16:24:56 -0700
X-Gm-Features: AcwNN1U6X57XXPgvs7wBUo1AVpm-fnxQGl3Bt0cNbgPT5Dz1tG3b1h2XibzcFQ8
Message-ID: <CAADnVQJCJjy9Eiwn6-88c0iOk4LfgPU6KBv+w0JZdBzmXBMUCw@mail.gmail.com>
Subject: LSM boundaries. Was: [PATCH bpf-next v3 04/15] lsm: Add the
 bpf_lsm_policy_release kfunc and policy object destructor
To: Paul Moore <paul@paul-moore.com>
Cc: Justin Suess <utilityemal77@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <kees@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Jan Kara <jack@suse.cz>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Tingmao Wang <m@maowtm.org>, 
	bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 12:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Sat, Sep 12, 2026 at 3:33=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> > >
> > > If fs/, mm/, drivers/, net/, are permitted to have kfuncs, then why n=
ot
> > > security/? kfuncs.rst doesn't seem to forbid this.
> >
> > because fs, mm, net see the value in bpf. bpf helps these subsytems
> > to focus on their core technologies and moves policy decisions out of
> > kernel and into bpf.
> > while lsm people treat bpf as arch-enemy.
>
> It's amusing to read this when just this week we merged a patchset
> into the LSM tree for the benefit of those writing BPF LSMs.  If you
> look at the discussion around patch 2/2 you will even see a reasonable
> exchange between Matt Bobrowski, a BPF LSM maintainer, and me about
> the patch.  Alexei is obviously welcome to his own opinion, but I
> would encourage those reading this thread to look beyond his comments.
>
> https://lore.kernel.org/linux-security-module/20260904-lsm-mount-idmaps-v=
3-0-920a1963675d@amutable.com/

And that's an example of unacceptable land grab by LSM folks
that I'm concerned about.
security*() calls sprinkled around the kernel are not LSM territory.
It's a decision of subsystem maintainers to pass more or less
objects into lsm hooks.
VFS folks could have decided to pass a subset of the object to
avoid exposing internal details to abusive LSMs or, as in this case,
they decided to pass struct mnt_idmap as well to increase
visibility into vfs operations.

Paul,
it's not your call to ack or nack their decisions.
Your job is to review security/*.c side of changes
and give feedback.

The needs of the kernel subsystem are far greater
than all LSM concerns combined.

Daan's patch:
-int security_inode_create(struct inode *dir, struct dentry *dentry,
umode_t mode);
+int security_inode_create(struct mnt_idmap *idmap, struct inode *dir,
+  struct dentry *dentry, umode_t mode);
 void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
  struct inode *inode);
-int security_inode_link(struct dentry *old_dentry, struct inode *dir,
- struct dentry *new_dentry);
+int security_inode_link(struct mnt_idmap *idmap, struct dentry *old_dentry=
,
+ struct inode *dir, struct dentry *new_dentry);

broke a bunch of production bpf-lsm programs for many companies.
It's annoying, but I cannot complain, since it was VFS
folks' decision to change their hooks.
Pls at least cc bpf@vger next time.
If you didn't mention it we would have found out about
the breakage only during the next merge window.

Anyway, back to LSM's land grab...
Because of LSM people's behavior, networking folks dont
want to add new LSM hooks.
It's really starting to feel that LSM hooks are like
tracepoints of the past.
They could be in the way of subsystem development.
Hence it's important to stress that it's a subsystem
maintainers' decision to shape LSM hooks in their subsystem.
Neither LSM people nor BPF cannot nack VFS's LSM hook changes.
