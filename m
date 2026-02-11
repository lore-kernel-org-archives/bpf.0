Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E3B2F0C6A
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775611; cv=pass; b=M5hkEgintnXb65VDYALXqX+wTUvzZmP0uIeRzh6gp/RJxvkf7eOnmSxLd/l3Klq7d8EghWYxVDrmMMPItVJgv8oJGnOi148UXy2JY9umtZRqzDAUiYhBsow8IKvoxHRp/nOlaiZ/W647Bmm4ORNTrG8qmXTsCOl48+3L8EJly2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775611; c=relaxed/simple;
	bh=pwLh0r37vgsFHAU0MAB3eNcnz+CzhRUkGq/BN051KKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bW1LRehFh3VAtioS8JKfk3OSJZDR+yOl0HbDZ6Of8Lt9ZP08Jhd5reT8I/6KC8Q9DUWs4lvj91CPd10E2mPk1sgrylDZwS0uiPZsn+OhRSn89sRJ85gPHf7z1PhL0VSiJM48BhpvMI3FIDI6soy1R0ZnkniX67DMyPysFgwsqzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTgED7Ty; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTgED7Ty"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4359228b7c6so3102733f8f.2
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 18:06:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770775608; cv=none;
        d=google.com; s=arc-20240605;
        b=SdaR/+RmMxtqI69rxKhHvpliyAA9tqhUYHAv0+y4JTLw04s1w4McE+I5p/3mM7MHLa
         5oXCDZLYvx/lyfnA34CJkXUdxBQtRUxHcPHqb7QRdbzqCcg4X2y7zhwFYHHr7UhhyXkL
         vvQDGow5KeMnTJNSRStNQdbr5odmoQS/k/jkxYK5xKeh46NQe4Lpltw3f5RbQntIy2gM
         bdtjyvWnS5avkQnnNLjHoDXiD0gsavIowE6H1D4LmksLrKFb2ctC+FzU76cNHqOmkXeK
         wHsqrq5jGFBFZCYX0TU9nzO6LcvejCjPAw528F04Bc9EQySihaJbh8GmnhCyTfsCXuHS
         8jSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cYUJHU3Za9nmLUNSTIvWOQ3reaEP9nyWSSICji7VFk8=;
        fh=Z/Fl3zYaxAxSKlqkB4M9/PWWF8CMchl7hxkyvqSANMc=;
        b=QRRJ6fMVppL/K1lqItmzl2klR0KnCarjhNHzaiU3CMMocwtaMmjQuMZ5j49buoGotp
         fMjPujT7DqN642Cg5CeLdZMNFdxrzvSp/F/FgJoxh8+XZ8ZIWha5sMSHHG0RrmIxLcJQ
         sPqmWkg3rJX4Zjo5+JKc+CyTEtzodDGtS/O9WfXxXGNv4jzBO4kAUYZm365UxZ1R8xio
         KKAtKVb25SHte/eJqsrl3OIR2J2T+D9BKAU9URRJcMvbifCGZrhaAp54CMGGyMOETF2H
         tqyq9T8aKbGFipzGAWHYo6/1BGlfh8nmz1q5Pa/pbEiUk2YsNRrsQl67O7iWBx4R3n4K
         gpKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770775608; x=1771380408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYUJHU3Za9nmLUNSTIvWOQ3reaEP9nyWSSICji7VFk8=;
        b=JTgED7TyDXxEwwNrzwbLXjGcDGm2mwDmVZketLUAafl6bXSMzxhxr/petTu3YWsqiY
         i6kz5BCzXo144iUb5UJfbkMgxDBbAci8YQoHpuhih/5aLepETuU35bE3QTqsiYt8og1w
         7scje5vLd6ReYw7tHHhOuxSV0tpwbEDVmSgFQqQfGFZ/fmj1RF6cLFXsIaKSLT7UQsTQ
         JFCm4dRRVvT4+WlSJEjHeBTEGuc/h8CGkVdWGhaJxljIxYhFN5IzzmGHREFqtHGr8fFw
         9IYv/mSRFSqW8FR8QIBVjL90a2a+4feZFMIcVgJvDm0w3lokYK5iHVQo1Irc8J0OLuZr
         KYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770775608; x=1771380408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cYUJHU3Za9nmLUNSTIvWOQ3reaEP9nyWSSICji7VFk8=;
        b=XlZ1NDZ+XaLrToA6xYi1XQ9Ip72KLxAvUb/G/Un27TNg7zWd6VAeje564j5/e16dYV
         /ZgZGj2aY/IeIxuLq/kJZoM0eWpu85ASWFXTV7Jf/r/aPiyYEzUzLohD+sqi/45caS4m
         sTWlp7vPqRwAta4WaTPkLh1BtXr0LAlunS3tWvrBOJ1rTs1wiSJzjB/rm7n7ehyuJT65
         MrdjbEvJtmRVknwTKa31v/TbWc6yy0Syda2QxW7JpqcfGnext5GkulO7c4Q9ZdV0A2Hx
         5DKsAbh9Rtg7ubudvrQ3PANOfOTGvxU69KlbXvPWTHGFTxya+ywfAE1FiNb2JQoL5Hye
         X0eA==
X-Gm-Message-State: AOJu0YzU0/sStotZlu3RwAJMUXL55WYySckoYpgO1CUmmFouMDIYrGiu
	+STkhk9pCLdpkypvkpKyNx8mM+geXSXZbS/wAj0JSDle5cgSMuvaAsCjmkoJ4qj8c9kSXueyLxJ
	Tqllmjw7Jjc0WfRMyMdkreBI7U33VcVw=
X-Gm-Gg: AZuq6aJ7LmeMig07NnD5cJQaY4TkYdyJflF4RUBNqoNK4p3PxGSkeYz1SXFS7l+ms4d
	pcjsO48KL8GZDOXcdhxR11OxYQX06Qnq5y1MuXWgEsZh5/BDcZz/nNzcTn/sR9eTtP3zQMO3wQt
	7SLdaiEI1jNmkloha5uiJz28sTLA4JrfVK6+28e1SSIai6Xe4blEzhyoF/CtCKWYm7/2l1vgZhO
	QhUKgmb7MlK2mg7b1bSu8t4atNmhF/hi7Fd5EIlgNIP3PuZuMt0zkNCsEI/QxedlefSsDRMboer
	us1ENnqIk6hTwLDM9OY5GkaEOnqQjemTOpJGBo44C6LXc2BzgYy//eVSrXlIwyGmCF0DWMSr7IS
	kLosVWwyqee3Rz2UP/vc2VjU7GQ==
X-Received: by 2002:a05:6000:24c8:b0:435:9770:9ecb with SMTP id
 ffacd0b85a97d-43782cbd132mr1531731f8f.56.1770775607675; Tue, 10 Feb 2026
 18:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com> <20260205-rhash-v1-2-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-2-30dd6d63c462@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Feb 2026 18:06:36 -0800
X-Gm-Features: AZwV_Qh_Ls2mfmm7sdeL3_2wIjyu9Hk-W6NadfeLhRawgHgUqO9fL6k5PNgxWMc
Message-ID: <CAADnVQ+C+=5o2mRHD5CpdRcZ4fsxg2vOOQHZp1T1KLfs=KTSEg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 02/12] bpf: Implement basic functions for
 resizable hashtab
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 12:27=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> +
> +/* Helper to get next element, handling -EAGAIN during resize */
> +static struct rhtab_elem *rhtab_iter_next(struct rhashtable_iter *iter)
> +{
> +       struct rhtab_elem *elem;
> +
> +       while ((elem =3D rhashtable_walk_next(iter))) {
> +               if (IS_ERR(elem)) {
> +                       if (PTR_ERR(elem) =3D=3D -EAGAIN)
> +                               continue;
> +                       return NULL;
> +               }
> +               return elem;
> +       }
> +
> +       return NULL;
> +}

This helper is not used until the next patch. Move it there.

> +
> +static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *=
next_key)
> +{
> +       struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, m=
ap);
> +       struct rhash_head *he;
> +       unsigned int slot;
> +       struct rhtab_elem *elem;
> +       bool found =3D false;
> +       struct bucket_table *tbl;
> +
> +       guard(rcu)();
> +
> +       tbl =3D rht_dereference_rcu(rhtab->ht.tbl, &rhtab->ht);
> +restart:
> +       if (!tbl)
> +               return -ENOENT;
> +
> +       slot =3D (key && !found) ? rht_key_hashfn(&rhtab->ht, tbl, key, r=
htab->params) : 0;
> +       for (; slot < tbl->size; ++slot) {
> +               rht_for_each_rcu(he, tbl, slot) {
> +                       elem =3D container_of(he, struct rhtab_elem, node=
);
> +                       if (found || !key) {
> +                               memcpy(next_key, elem->data, map->key_siz=
e);
> +                               return 0;
> +                       } else if (memcmp(elem->data, key, map->key_size)=
 =3D=3D 0) {
> +                               found =3D true;
> +                       }
> +               }
> +               /* if key is not found in this table, search future_tbl *=
/
> +               if (key && !found)
> +                       break;
> +       }
> +       tbl =3D rht_dereference_rcu(tbl->future_tbl, &rhtab->ht);
> +       if (tbl)
> +               goto restart;
> +
> +       /* Key not found, wrap to first element */
> +       if (key && !found) {
> +               tbl =3D rht_dereference_rcu(rhtab->ht.tbl, &rhtab->ht);
> +               key =3D NULL;
> +               goto restart;
> +       }

Two restarts? Looks odd.
This is a tricky logic and it's open coded 3 times with small
differences. I think it's better be in rhashtable.h

I think we have to treat 'struct bucket_table' as internal.
Outside of rhashtable only nfsd is using it, but that's not right either.

Some kind of for_each macro or always_inline function in rhashtable.h
should do it. cc Herbert Xu, of course.

Does any of it need to deal with nested table?
I mean, rhashtable can become nested when table grows and
kVmalloc is not available, so it will be a bunch of kmalloc-s
that will create a slower nested table.
See rht_bucket(). Once nested the bucket selection is complicated.
