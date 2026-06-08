Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F13D9043
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942728; cv=pass; b=gcXBuki89Gf6MPkgCskl64ICpCDzzWBv9YZQpDv0Lu+HgRwNxUohHvjpnrOk2fVHT0OC46/ITfk9OgMp8BYP44QzvWqtJtydtlYUcRqeGFjH3NkcIhIBIJXrtSpLS51vQmVB0prOWjqEQ+q109AxlR7e20flT+PF7DVjrFnmX8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942728; c=relaxed/simple;
	bh=d2yZGc+pur2tsE9GREIpCITGt9vkKOB4lYnN0N72K0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G81MHZHfJ0Zb+nzUi7DwmzfcFGKJ6W+uaz/FRnMTuEkVVEEgU1KDcE9qr21h3OVoih+79XS6MIMtbvvyVjJe4PoYzbz5kaFDYXJ4Zp9npUaHJZEVWB6668+fusiduzeor40ASknHjzAU/qCOgQPurzp/X3pXo7OUC3wwGBKnvtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7O2yjPR; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7O2yjPR"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso2904853a91.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 11:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780942726; cv=none;
        d=google.com; s=arc-20240605;
        b=NnKyOigdyLpqPvDWQAWoW+dC5p5Yh0j3yxeINvk9oTi58EsSHlWdkXIfZlfNFM9W5a
         MkDCBsbcR5x/vxYNHlB9JUoH2W2FZMKqCto/fQqxq+lkJSuu68m7SuzfFMOWbKoi65Qj
         6whyyqWThFaXz7u5NvDJgLZFI5RG6rE11h6UPTHg33FI/TSUDTEj+H/3zoVLCA/e9rcv
         4EbTNYlcJEN8tT7PRthnCUX9cEC+JQtyzl7rcAJln+crFwK8+pKTW64pbI9Fa6AIsHFM
         dVZ30bICaV9nI4hct17JlD0mfTd8KKU4Vnt4kSrVFVXGzVirkBJ4Mt5nc4zcPGvVdqd3
         Ow6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QVGYoj/1AbUgccCQxiAjwRvdNqm7duAViNPULxhObvY=;
        fh=v5E3PfQzGx5WRpBUGhE1FFqq3b3hlA6f+CVO6RViyNk=;
        b=cdV9cT21i/rqtxDdX1QW3NINupydKyEL+I+jlUENX3RCNer5IIxnaN2GJmsas11U0s
         5NBl3VsmfW4qatdoTj0mTOovr08i6pF1A5e4EVTcomlikPf6hmSG7YnzGRhPlsLE+zd1
         B7yYcjbiot6/MdQDDKHNuII3OXMRpuaP8nwIs8BEI+j2MDk5WG3MqBLjkOIC+AswZwxy
         nq9lnmGO5tNsxqw8aBDMlmD0SRDtg1AUF2ZANLjSkGzQcZy28FIe74Py72dpLjGUUbLR
         MCSHxha8tpJ2F3Zcod634CLbu3iIwNBNmFJTuYcOGCWd0fG5R4T7ZVWRK2fa4LKhDgs8
         Y7Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780942726; x=1781547526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVGYoj/1AbUgccCQxiAjwRvdNqm7duAViNPULxhObvY=;
        b=m7O2yjPRJEOvX3Jn/IHY4LNewqwSiZKGNlgxItNEqywCga0k+HAj/kfVPk6UXYkKY4
         r6XaYqYEQcGkajdXou+3N/Ilfzf7RZzetvoig8yh9rMOfX2lFeBptKIFznCIZLRtPb4j
         SqwCvs7Z1LqKqPb5l/lBWRPUej8VuYOxEveHrnXuoaYxnxH6VVPpip5hCYOVwnvpGKG/
         NTRKAIJkpiXYHIgJ/PWyP9+XJVVHzeYPuZm6b+M2B8RAoCjH45+GVwUi7aSni1Tdzgkg
         Y1oE9s79/8YjrlrPBEZ0nfVtjm153oc105XX0AVgOHT5O1fj8knDaheu8hnwgU1Pd4/r
         UWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780942726; x=1781547526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVGYoj/1AbUgccCQxiAjwRvdNqm7duAViNPULxhObvY=;
        b=MPb/2reokJE2sNYSnMSscGpbfKt7An5XbaNI5hUvCfF+Kq881OfNsg4BAcFZTthLIH
         ZrjJ31ifEvO0hrCJO5YwvOVpJXEQDYB7iafPIagQAnhatvNhJaaBF3CVCovIbrXXnuRW
         iN4yX/j6nZYS53WoQStBcnV4lFW4H+QPw61gIFfN8Upt14yNuxhTiup1jzoAacbf/ICn
         eio71Pp8EwciQG3Bj/dw1vCCNZWrFaHqFqJcmXcwJtx1sA+ZDIFXhncfaWA88KOheObV
         sLwJqec+CleS3JBlsxBrxnGI0N7XSwDhrA0RZXTSKw92VlDb367Vjy/VN1j9jTb/I3Rv
         1klQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nj10A2DY5XXwXYkR9ojecnCwVacUWAxALk6zOY1IOnzQf5iwGjg5h+fcqmczw/vYhYRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiqjTds5B2iY+MJea6JKQdEFIplH9GQwyakicFzb201txQoGnt
	OlexQtJD+zz+qY/oMQnB0I5Azd0znt4TabNnEQy5XU32mU4naMWxS2oi00XmUliInSAaijVoXFn
	7to+inF3qBLl6eiKyhB6OEefy/GHqNyU=
X-Gm-Gg: Acq92OHg9hwe4CdnXNPB9zlkImUI4cEtHi090F0y3pL/p6VPL/FgvYwY5zdlc86+vO3
	yTAosLos7RYgMoOCBTL6ib+QzeC43lkYbaAyyZwrOD5FziJEFluy5zaot2beW4rpxRnIr3wSqQV
	3nGPlpC5VnxFM38Sk0XLF9Sz9Kvuk8ijLCDoUgsoPduPX2lz0xMBnurB9GZIx9tNUVEjB21xGsI
	0CHGvDoFaJ2wjR6xWSesdeiKfmGeoyHbImCCuxo+kE+NdFEUaXqTVTTUc4WAX57EjVcdMYie1EE
	Uj0+0yAm9K1Z3VjcqfmGBNuupHsIYOctMa5hpEqkmrZ0o5Hk6K0M5B97eFwBLJCdFRKK0LDOKfN
	041J4vYnT6Aib9Pc=
X-Received: by 2002:a17:90b:3fd0:b0:36a:3176:ad08 with SMTP id
 98e67ed59e1d1-370f0d52f42mr16776510a91.25.1780942725707; Mon, 08 Jun 2026
 11:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529031604.888137-1-chenyuan_fl@163.com> <20260604031033.806727-1-chenyuan_fl@163.com>
 <20260604031033.806727-4-chenyuan_fl@163.com> <a1561e36-08dc-4ad1-848b-88974f529d10@gmail.com>
In-Reply-To: <a1561e36-08dc-4ad1-848b-88974f529d10@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jun 2026 11:18:29 -0700
X-Gm-Features: AVVi8Ccp1BPMVe7rixi3BZCJ4sZctHvRQuY55dQObYYFeNddy9ZFd7YuHS4dJTw
Message-ID: <CAEf4BzbbmTFaNjT4bRTEm3BxAROkRrTdfxwPNy9HmMt_LFaSHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] libbpf: fix feature probe failures for
 implicit BPF tokens
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: chenyuan_fl@163.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, chenyuan@kylinos.cn, daniel@iogearbox.net, 
	eddyz87@gmail.com, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 7:40=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 6/4/26 4:10 AM, chenyuan_fl@163.com wrote:
> > From: Yuan Chen <chenyuan@kylinos.cn>
> >
> > probe_fd() converts BPF syscall failures to return value 0,
> > which feat_supported() interprets as 'feature absent' (ret=3D=3D0),
> > even when the probe failed due to a BPF token's restricted
> > program/map type mask.
> >
> > In a user namespace with an implicit BPF token, the sequence is:
> >   1. bpf_object_open() -> no feat_cache yet -> global cache used
> >   2. bpf_object_prepare_token() -> creates token, sets feat_cache->toke=
n_fd
> >   3. bpf_object__create_maps() -> feat_supported() runs probe
> >      -> bpf_prog_load(SOCKET_FILTER) with token -> -EPERM
> >      -> probe_fd(-EPERM) -> returns 0
> >      -> feat_supported sees ret=3D=3D0 -> FEAT_MISSING
> >      -> internal maps (global data) skipped -> verifier EINVAL
> >
> > Fix by making probe_fd() return the negative error on failure
> > instead of 0, so feat_supported() enters the ret<0 path.
> >
> > Additionally add a token_fd rescue in feat_supported() for the
> > ret<0 case: when a BPF token is present, a failed feature probe
> > is treated as 'feature supported' because token creation itself
> > proves the kernel BPF subsystem works.  Real BPF issues will
> > be caught during actual program/map loading.
> >
> > Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> > ---
>
> It looks wrong to say that any feature is supported just because there is
> token_fd present. In patch 1 we only checked that BPF is available, so
> it was ok skipping probing. This one looks a bit more risky.

Yep, agreed, this is not the right approach. Please double check what
kind of issues you still have with only patch 1 applied, and let's
discuss possible solutions (if there are still problems).

> Is the reason this code fails because of BPF_PROG_TYPE_SOCKET_FILTER not =
enabled
> in the token? I suggest fetch the first supported program type from the t=
oken and
> pass it down to bpf_prog_load().
>
> >  tools/lib/bpf/features.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> > index b7e388f99d0b..f934452e52f0 100644
> > --- a/tools/lib/bpf/features.c
> > +++ b/tools/lib/bpf/features.c
> > @@ -16,7 +16,14 @@ int probe_fd(int fd)
> >  {
> >       if (fd >=3D 0)
> >               close(fd);
> > -     return fd >=3D 0;
> > +     /* Return 1 on success, negative error on failure, so
> > +      * feat_supported() can distinguish probe errors from
> > +      * genuine feature absence.  When a BPF token is present,
> > +      * a negative return triggers the rescue path that marks
> > +      * the feature as SUPPORTED (token creation itself proves
> > +      * the kernel BPF subsystem works).
> > +      */
> > +     return fd >=3D 0 ? 1 : fd;
> >  }
> >
> >  static int probe_kern_prog_name(int token_fd)
> > @@ -725,9 +732,21 @@ bool feat_supported(struct kern_feature_cache *cac=
he, enum kern_feature_id feat_
> >               } else if (ret =3D=3D 0) {
> >                       WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
> >               } else {
> > +                     /*
> > +                      * A BPF token may restrict which program/map typ=
es
> > +                      * are permitted, causing the probe to fail even
> > +                      * though the kernel supports the feature.  When =
a
> > +                      * token is present the probe is best-effort: BPF
> > +                      * token creation itself proves the kernel has a
> > +                      * working BPF subsystem.  Real BPF issues will b=
e
> > +                      * caught during actual program/map loading.
> > +                      */
> > +                     if (cache->token_fd)
> > +                             WRITE_ONCE(cache->res[feat_id], FEAT_SUPP=
ORTED);
> > +                     else
> > +                             WRITE_ONCE(cache->res[feat_id], FEAT_MISS=
ING);
> >                       pr_warn("Detection of kernel %s support failed: %=
s\n",
> >                               feat->desc, errstr(ret));
> > -                     WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
> >               }
> >       }
> >
>
