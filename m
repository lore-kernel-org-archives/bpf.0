Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C35A37C10C
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403618; cv=pass; b=MxcRfaODIqnRYySs9aIPnAFAHP1nS4DvSvOh8t7u1jQx3XeBgREBWSY3vm0iztkjUYEwcOo6zTR+LwIKRTkYocMyiHcUHSIORogBBg6tJ+vRjAhcQdw6jhQw766jrbrpHeF90SOSzPaxErVoDzAXIUicY0FaOyf6b4Ulwkul2t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403618; c=relaxed/simple;
	bh=agsr2jSOniKtJMF+X0oXwibByddxXJqtF6YncOKFIEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcK2qWTKP4G81i9awPTP0WMEztCNHYp52umsVUF5BvdR6eWe8pk20+IRtzjLqtXMOdrHc95yhXPQq9CWsSXSDZXV0tZlMq+Y7Iv7TD3Pr5ors53wKEWTwk6KTpuy1omX7xoq9OQY1hDJQ6mE3+wECnwkm0agYtl4vcD+y/2ZiNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QvSsjVPq; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QvSsjVPq"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8453f568e84so2769284b3a.0
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 09:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782403616; cv=none;
        d=google.com; s=arc-20260327;
        b=I56SldQoyEnckah7NBk0/OdjkYSSOe7NS8NDgVqSADcnrFvjjs2ZkeYcJ1uwZR/h3K
         X5ERCHvU/bn6nSWrvZR9Ywdj6fmlQbnvm905Iet+TaYNNZjXTd2IQoQs8QpPr5dkOsSS
         zV3CQcRux9utGKJzDNYBd+H6IjjX2C+pBpfMNBps/uTRyK30ysLQeyy9Abt1AccKexSJ
         J9Nx6aCh2oV/w0vmcdB3RFKWWYtdGETbstRgbpI+wlH/sVu+v+/2W25JeMNhY/i/5X7b
         pEbfl6RXmdFsajpff60xPO2IoBDZYF2btK+hdEaF9AFCrPhrIW2UgWh4pFOKmnrdo0lP
         wvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tj5Ca+YrVkSkclVchnHXzQO8ttUEujxWnJ/JyckdB0c=;
        fh=kh/ErA4P/kkbd33tmO3aHDDzHnXX2pS5a9t24keefPI=;
        b=dRelQM4z4IGbpawuJdX9mcc8h1/wiMzp2dUsi1LY8QUaITpQ32uX+B/+WcQkmLSv51
         T7A473ykm671zgo7gXVmYCMWN6+yzgcHh/hg8et32C4eTpS8rHC94uZYGrO79BswlVau
         nOXMfO7CeS5NHhpB20f6/9ZmiEvALg2IGp2ExFdDAGbQXf0rY6g5G8HC+4seA9iHvkDi
         Uo5uvff7JGRwWR8N81OjYi7jJIeS8IQTBvOKToyu/mtKyPDMjv+Lk5iEc8n0P3ZyDxH9
         mhTXxLO5+rcFkLXvRTpZj+PoihlmtSCb+HIQ3PHqAmicLyQZw1RDaDYVKyRgnMt/xGBO
         LO4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782403616; x=1783008416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj5Ca+YrVkSkclVchnHXzQO8ttUEujxWnJ/JyckdB0c=;
        b=QvSsjVPq3M1JY0gxDJT0dGWAhQEabdh6KoWw3JBpzBtI3rtnb3lWRsn8ta0q85U6l4
         Ua9fc9jZSlTlQCTuDpP5pl3PJpzmygJREv8s5m4jjU/kpKu1yQeSbGs6Bu+QQmxV2ezi
         e6NPDfevXKkBchG/zqVyPXc/kFOhBiI2W3jBrwdKpT5ZZaWOTSIRUKTJNjQJ0AbZcUec
         vgdp30jAhElXeS5k7V28unI7eOz9LvmVrSUmQlBIQCVGaSXpNXiOqN/qFRoYC/XGgKOC
         9iAuA/CZaq2dfEavbG5gNF2LFQUOsab5a9SZvIIiNeh6NvKgnQyIElT7hrMSadP+7MFu
         n1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403616; x=1783008416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tj5Ca+YrVkSkclVchnHXzQO8ttUEujxWnJ/JyckdB0c=;
        b=DKLesMrmVpp02/WoteEGmMxe/kJbp9LxJYXlaNz2u1iByZknSbN9lITnOWVw8+KBtk
         NsfRGicYO/LjiORXcQ++/2TOHbISL4bvpY8IA+yl/iJ7Rqy8CjB/p39JFTGEIcjtEQC0
         i4m93ZQJWtj/smE/lOACt75xZt6t8PbykoB9MSNXLbunuPGquKj0D3DsILrcF6bwR5Ie
         Zc+XyoVzcA8exExPDg2qmjNDyP+YyDIajMRDdEZwYWBdPQIu8Z9JGgGoPCU6YJs2Lh9w
         t0x1YWVnmdZ/kBSvvzo22LuJ/7Bfmxk/trYIx+OGhCzRySL5vry6J0nxgTgwFlBnDzoR
         cVBw==
X-Forwarded-Encrypted: i=1; AHgh+RoZOzoxYa40c+GQkQZ8SJ5iTlRGcYnx5LjqWG2FZY/nsoVroOLoweB1kD/z2jhsmEmctcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5JdlJSse4A+3AjSkcO1ImD6NDIJANWU8me0qqlYAPRd63drS
	r2vifn5NFulZGj3WTp3C+Scx9VJMbon2twX27cDRKdNJz6NI5IZ6/RPwbXPRryyz6rvj85GBUfD
	9KU91DYQ0GCqwVcGhiu7qVETdz5qa2VceCQVYy1ce
X-Gm-Gg: AfdE7ckLQ3HxWkDnN25pvMlg0guHnxTGO7sY/3Edl8RS/aofns4ijs0XrQFeUy0KfeB
	eYdCDOoprry5XrPFGDMyE8Ey2GnvzvioAKpAiaqE6NSubJkDk4dUmEuDZ3UC3xdh17XSITtLUHi
	0RHjbFlGdbza1JrATA6QqiMysF7E/aVNy5o2FqIISIJBV+dGAWkeqI+VXRMl8/Vh4wapE6/su6O
	F8zIK6aCCTTL2Z54A90E1xAhZwLPpJNU3BhMm5RwOvyVv2FI9ON8sT1C0Ij4iBY2eCuGdm7
X-Received: by 2002:a05:6a00:1a8e:b0:81f:5037:a317 with SMTP id
 d2e1a72fcca58-845b39d39c6mr3865503b3a.11.1782403616175; Thu, 25 Jun 2026
 09:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <75d39fd9847cca915d704235264ab474@paul-moore.com>
 <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
In-Reply-To: <20260625-schnabel-rennmaschine-parieren-bcb352c3cf59@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jun 2026 12:06:44 -0400
X-Gm-Features: AVVi8CfVp_1nha_FxdKkksJCUmgb3NBLBVh62tn1q5iqee01wbI4MgNkgsJUBlQ
Message-ID: <CAHC9VhSP54b9UZLJ5RRaWfnV5J6mD4iLCFXxwwv9pFqDrCAH3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Christian Brauner <brauner@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 10:23=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On 2026-06-23 20:12:32-04:00, Paul Moore wrote:
> > On Jun 18, 2026 David Windsor <dwindsor@gmail.com> wrote:
> >
> > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically s=
et
> > > xattrs via the inode_init_security hook using lsm_get_xattr_slot().
> > >
> > > The inode_init_security hook previously took the xattr array and coun=
t
> > > as two separate output parameters (struct xattr *xattrs, int
> > > *xattr_count), which BPF programs cannot write to. Pass the xattr sta=
te
> > > as a single context object (struct xattr_ctx) instead, and have
> > > bpf_init_inode_xattr() take that context directly. Update the existin=
g
> > > in-tree callers of inode_init_security to take and forward the new
> > > xattr_ctx.
> > >
> > > A previous attempt [1] required a kmalloc string output protocol for
> > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs =
to
> > > provide xattrs for inode_init_security hook") [2], the xattr name is =
no
> > > longer allocated; it is a static constant.
> > >
> > > Because we rely on the hook-specific ctx layout, the kfunc is
> > > restricted to lsm/inode_init_security. Restrict the xattr names that
> > > may be set via this kfunc to the bpf.* namespace.
> > >
> > > Link: https://kernsec.org/pipermail/linux-security-module-archive/202=
2-October/034878.html [1]
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D6bcdfd2cac55 [2]
> > > Suggested-by: Song Liu <song@kernel.org>
> > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > ---
> > >  fs/bpf_fs_kfuncs.c                | 106 ++++++++++++++++++++++++++++=
+-
> > >  include/linux/bpf.h               |   1 +
> > >  include/linux/bpf_lsm.h           |   3 +
> > >  include/linux/evm.h               |   9 +--
> > >  include/linux/lsm_hook_defs.h     |   4 +-
> > >  include/linux/lsm_hooks.h         |  16 ++---
> > >  include/linux/security.h          |   5 ++
> > >  kernel/bpf/bpf_lsm.c              |  10 +++
> > >  kernel/bpf/trampoline.c           |   3 +
> > >  security/bpf/hooks.c              |   1 +
> > >  security/integrity/evm/evm_main.c |   8 ++-
> > >  security/security.c               |   7 +-
> > >  security/selinux/hooks.c          |   4 +-
> > >  security/smack/smack_lsm.c        |  27 ++++----
> > >  14 files changed, 166 insertions(+), 38 deletions(-)
> >
> > I have a few specific comments below, inline with the patch, but I want=
ed
> > to make some general comments too.
> >
> > The kfunc additions really don't belong in the VFS kfunc file, please
> > create a LSM kfunc file (call it security/bpf_lsm_kfuncs.c) and add the
> > kfunc code to this new file.
>
> We expose a bunch of VFS heavy operations for various security modules
> and this is really not different. For xattrs we have it all centralized
> in the VFS and in general all VFS related bpf kfuncs should continue
> living there and be registered there.

This is really LSM specific code dealing with more LSM bits than
anything else, it belongs in security/bpf_lsm_kfuncs.c.

--=20
paul-moore.com
