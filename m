Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3776A2010EE
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782186569; cv=pass; b=TketOP273eZZOt/WhH546ZQlA9DpC88/pDdyrh1VyOffRFdvT2oSI1PB7xaEisZrtbIFWfr+cU6UDvaCfmQkmQqf+UEPW0OfwwPTgvd/4Dc+oemt7uYCZB27MqOMx7P2Oh2Vq2e77oXTsRU3OhJEd5foh79EfeydFBaunX2294U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782186569; c=relaxed/simple;
	bh=RR1hHV2J785WpEVHL0k8zZuvODXfgsvw/MD1CpAaxyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwAbSoXelZB8JYKWpbI+fYsYNb164cktPiKpDMv+QAjNs5DH1hd7NuK0aTBNXV/c7+meRV9kW6dHLPyonomly83oPtv4C+qRUyokeScazBxd2FJT/JU42mV4ggqtH/pupD7QkfjjM6w3O7uXYCMXIC23COWh4jJGfXd5MmX5WoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2VXEIsq; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2VXEIsq"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8dc544dda2fso45262766d6.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 20:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782186566; cv=none;
        d=google.com; s=arc-20240605;
        b=Ae7E/jxAJqUdOANaQofRrOV/X1YikTo7xjWRgp+0wcQm4azIuk5UpjAuJ3Ii/DCfBb
         rJp3JvfvgozlcsFwDikSvOqogCWyzix3sU1QOIC/KxYu1XTN09dLus7/XI4CgEK2YGTI
         JfT3jrIWQp9pzErpudq3NgZ5PyJjlnPkH0Y4eRm97LBwttl1d7EER+mkP16Lcah5x1hM
         GWZR39eH3C7feWjX6w3fhhmGVzgXJHQcdrYUvOWra9ejd5XGmIMr1Ktzs2sOB/yz0jsH
         kFPxr15aet7R9h3VTf6JvN4Ro82e9ToXZR8b7PzH1FFrBWZimLQBXYUYXlHcHlO9T0oE
         Ew0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hg2qvAeQyfTz4Manlgss62I8/Xh54jm/4GmfoVCRIRc=;
        fh=nKQMyIsx4bng9N6kb3usbo1vFfQmzmOwYNL9TITmzHQ=;
        b=W9FWQyarJFw+cp+6b2MReRvTjCnu7NH9aqFsrsY0tsVfw987DyiGYPZzgT77q+2Urt
         Rh/lv65oIipO/7IjA8v6qZvFlvrGoFXuD4Oo8TjziFEHwAx6FibelfKg6CBuNrKg5Vp9
         CB9ac3whPt601gmxWn3QqcGE3kusDO7JOSfr94MfFcjIAyS2QiWhsUTBTSfK0J9Kn4jG
         Q9dSswGnZ+kWGYStW1Au2kqlTiJIrYn8yBR4Q2giZ4tBeRjaImXM0hXTvC1ojVtYqHSu
         AjlJiTeDCVhrvjPYtT0yBbjXKLKtp0goEL82IeANHgN9a6KuQEEwPsKMBtamDzjkK5e/
         BIvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782186566; x=1782791366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg2qvAeQyfTz4Manlgss62I8/Xh54jm/4GmfoVCRIRc=;
        b=f2VXEIsqUPpQtjzWk0AALYcAw5dv8DgPoC1lxGm4F7afw/MKVYqNjJNlgIpQXVMtgB
         dW5+xn/gyQj5jdqGUMXn+Jfp+EpOjWIh47APFF4MBi94JfvRNK62E0uyJceJpIZ8f19v
         NZAIB1LF6TxkN29Hp/30I1I+5xCSibfaWZpgPvb1wuPYAHHQ5QX1y5Bnz6TsJHlZbeec
         ufbpPfihOBmn6fcoPthWWE8D+UgNn1K1XFX8Jyfer0Y29qAdXkbr53xdgWpZ+JI1oEyX
         GB0KzvLZRKvJfuNkCb8lVZE0sn5SavxJfY1+yCEH7FZuZMAv9zqTicbx1jkwweQl5SyK
         1Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782186566; x=1782791366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hg2qvAeQyfTz4Manlgss62I8/Xh54jm/4GmfoVCRIRc=;
        b=UrCCfcPgR8Tosepksconn423+4C54gCqoLH+D/77e9BaAP3+iwMbpmjCMUVBCaHthe
         m309weq1er4/InXsARA4+qUf52IH6j0sFRfvBLlhd3zN2b/fd0dKvAWOjtrkjvCIng4A
         Qak/V2/8KQFWavJeu1wSwmSjqNmr19wqiUWL1ZTXSf2kbqMbmfN9DVXJ6qtkIX4UEllT
         4i2rkmYjqDxY6/8Zc/GayuTuI2g8c03Lp1NYegoB550O+1goHZQ5j91BiHwj8pLFi2qq
         onJsutirdBNGiOHlLqksfhbgu2e2noAXRmFASt8IhLaOttwCnPTN3lwrPYA+RYw6O2sB
         qlWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq78X36Z/Nf+Xs39q0y9t2Y0Nrss8Yby8d/1inYGP3wxmBYzPFmV/LdIgjwbt+q5phGPMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMKteRT7Xqdplx7SbRzbJ7Fu1X6pDjbM3bV1RVp/A/doCkS4YJ
	QBooIvU7TkSYYtJcy3MuA/8iLJ+sC8BoZNV641tVUS0Hp9ocYU6DZvQNz82BvRtsUGx2zGh+wqH
	2yMdD9/eAogAvBvTsudeFW5qlKobo60U=
X-Gm-Gg: AfdE7cl8Q2SuoyVJKsDAF54DaL1RKL9TlSo1xFc2O9spQ0LFN7UonLgYxB9kJFhnIey
	qtDB/DGWSB53ps4q245XVZQp9kjEgqvtZDlDQeS2AACyi8PoLNq+cKGzuR7gG5X0UvpKlY/doba
	7cjA/aXRHKnW7KwMEqvQ51o3sOSAvThtvo0JMmj3U1nK+Dqm15QA2ueg5mEqpT2EZicT6s+MYbG
	EvfVKO4mxU/qJ73mIb31UUVMDbKKNnFJTEs44gwJG1+p4h0zcT81AF2fJ4n9gucAT4l6fJ3ulVB
	e/EwECxSOydwMf6eA8s4U+vWByM=
X-Received: by 2002:a05:6214:c4a:b0:8dd:a358:ee8c with SMTP id
 6a1803df08f44-8df91338058mr230818586d6.23.1782186566075; Mon, 22 Jun 2026
 20:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-1-dwindsor@gmail.com> <20260618203411.73917-2-dwindsor@gmail.com>
 <DJFZGYZFMN73.1799LMXW49WZO@gmail.com>
In-Reply-To: <DJFZGYZFMN73.1799LMXW49WZO@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 22 Jun 2026 23:49:14 -0400
X-Gm-Features: AVVi8CcisxKRwafLGJbgn3FDnILUrTQohjbGOcGFK09DM9CZwfDUyuni252s2_0
Message-ID: <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 7:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu Jun 18, 2026 at 1:34 PM PDT, David Windsor wrote:
> > +
> > +static int __bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> > +                               const char *name__str,
> > +                               const struct bpf_dynptr *value_p)
> > +{
> > +     struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)v=
alue_p;
> > +     size_t name_len;
> > +     void *xattr_value;
> > +     struct xattr *xattr;
> > +     struct xattr *xattrs;
> > +     int *xattr_count;
> > +     const void *value;
> > +     u32 value_len;
> > +
> > +     if (!xattr_ctx || !name__str)
> > +             return -EINVAL;
> > +
> > +     xattrs =3D xattr_ctx->xattrs;
> > +     xattr_count =3D xattr_ctx->xattr_count;
> > +     if (!xattrs || !xattr_count)
> > +             return -EINVAL;
> > +     if (bpf_xattrs_used(xattr_ctx) >=3D BPF_LSM_INODE_INIT_XATTRS)
> > +             return -ENOSPC;
>
> This check is good to have, but it's enough. No need to duplicate it.
> More below.
>

> > +
> >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
> >  {
> >       if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > -         prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > +         prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > +             /* bpf_init_inode_xattr only attaches to inode_init_secur=
ity. */
> > +             if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &&
> > +                 prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_secu=
rity_btf_ids[0])
> > +                     return -EACCES;
>
> This is unnecessary. Only one hook will have xattr_ctx type.
> The normal verifier type enforcement will do its work.
>

Good point, thanks.

> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 1a721fc4bef5..b41b02173e24 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_tramp=
oline *tr,
> >       }
> >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> >               return -E2BIG;
> > +     if (node->link->prog->aux->attach_limit &&
> > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_limit)
> > +             return -E2BIG;
>
> No need. The check inside kfunc is enough.
>

Paul wanted this check because it occurs at bpf prog attach time,
whereas the one in the kfunc is at inode creation time.


> >       if (!hlist_unhashed(&node->tramp_hlist))
> >               /* prog already linked */
> >               return -EBUSY;
> > diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> > index 40efde233f3a..d7c44c5c0e30 100644
> > --- a/security/bpf/hooks.c
> > +++ b/security/bpf/hooks.c
> > @@ -30,6 +30,7 @@ static int __init bpf_lsm_init(void)
> >
> >  struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init =3D {
> >       .lbs_inode =3D sizeof(struct bpf_storage_blob),
> > +     .lbs_xattr_count =3D BPF_LSM_INODE_INIT_XATTRS,
> >  };
> >
> >  DEFINE_LSM(bpf) =3D {
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm=
/evm_main.c
> > index b59e3f121b8a..e0a05162accc 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -1062,14 +1062,16 @@ static int evm_inode_copy_up_xattr(struct dentr=
y *src, const char *name)
> >   * evm_inode_init_security - initializes security.evm HMAC value
> >   */
> >  int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > -                         const struct qstr *qstr, struct xattr *xattrs=
,
> > -                         int *xattr_count)
> > +                         const struct qstr *qstr,
> > +                         struct xattr_ctx *xattr_ctx)
>
> the rest looks good.
> Pls split the patch. Introduce xattr_ctx first across the LSMs.
> Then another patch with a new kfunc.
>
> pw-bot: cr
