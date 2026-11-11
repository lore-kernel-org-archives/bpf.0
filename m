Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794426865;
	b=EpcHQpuapcnBh5WBM0EBLtA3onZOnjDFJ7DvYUoSP246TJn+tVrVJhA0S6eYbKaV0685
	 iNRD8vqNWFlFvcuxdo4Hg3mhYumTGyI/Dox0Iel1sbIrvEYYU6wpksHclp2IlIXSCYkU3
	 yz8l9CBwuhJjKL9axPHzEKdJj9cYQzNxZ6mdmVvbHnVKbEHDblMAyoaOmmRIwP27YbNkQ
	 Szq1qDr3uYj9SScxi4oZX0jl1yieNmSS964Wr87ewGMUxx9taQV61DuugGRA+2B8B5NCt
	 pJ7+1cVJvC8nUIVFtzh7epvJPtgIAIcGv59vWuu9IXAkEDuyuR1pmrnaLhhGeZ5PCkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uz4m71nRD6f+qddgfa2gOOtoUGlSJn5F5ou4PIom6y8=;
	b=5MKnnFAsypBPOSLy4zKUB+31e8K7lsLKAdtKD7EbXqfK/8s+WCyeTqLr4ciaG43kjk75
	 dtNcfgZQo+DlFoSPQi2QVioc1uXgZJiByL3+GbqrMqzNyr/FX0lr4Gcm1bx25RcuQLjkW
	 a5UTmkV+XPEgXVCl7IJx5N90IePzdRWGIqTzcVZiIjHMvaL+UchlzoUx+U+++JJUYvJ4j
	 okUxKtknF9c62ArgaezSkPe5Y6HZFISDZ8bXs/SHz6z4dABErE0sm2/6is5x5sob7kNpX
	 uxKsuC2CenCKUnGguJoPzmhSOqNGHllRWNoboPApvPVmEjBFbzZYU+b4G4OV5Q2JQnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UyUZKoyQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3276606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 19:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3276606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UyUZKoyQ
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-535f598d126so32581cf.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 11:54:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794426864; cv=none;
        d=google.com; s=arc-20260327;
        b=oolgX5+Zot7mxDSMl0s4I+cw3RIfg8ny0bnozGo1fgoYErMiKcRfdrKiFF+0JE72mA
         W/dK4yOfd1G2lVCgZYtjT+8Drqt5P2MiuE02KPB02LMmvt125/4IXfzUGiR8V7+KCkhB
         iIiVTToob0044uNdKYT3sB2eLhQm5Ja6yO8wqtZxQoX5pW5ZnIGF5otDrklYS89HDM2F
         Xpe4DZdXDb1tbYbf0qDiqReVoGK0BYTvlqrAZ4vKodzmRnG+0audVkdSczDdpYi8rRGg
         F2V3tHecYCBj/O8Z6TO9n/5+knRgZ5pUDSdGwgiClCmppmSMt9rYhAdh3rfj+6X4iQyr
         envQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uz4m71nRD6f+qddgfa2gOOtoUGlSJn5F5ou4PIom6y8=;
        fh=ZPk7+PshKA2ZcMR2zlN79h7q8k4YIplkE8HiQlo7kHM=;
        b=Sdc3CfOf4BR0dVXVor3BqxZrse6QVPrND1yQE7kmO5TEdkXeA7HrGP1+ebntEQf00A
         Hdp5PTL0NhlZnxMOaOnr6ERudjpLRPgKof/i1rRN2wr0j3/a6oEupSRjsQVuZoMkEMsJ
         Nz1v4D1dcK0K43ejcdR4G2UkJZx+bsyqogw5N0MqrDdsK0wojKshrWuDWO1L4f837f2a
         WWq4r1B4S94us5g7oi+o6aQZjtn6Hzziwjj1X9C8toSlVEQCvOS0cxmtBEjCYVN2r+fK
         AJNOzpE7k54zNZjx5jCwVkrKbztzUf9fcHUMeVbEPq02jsjd0CFJrJn/CnWCQiGs4CVQ
         7u5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794426864; x=1795031664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uz4m71nRD6f+qddgfa2gOOtoUGlSJn5F5ou4PIom6y8=;
        b=UyUZKoyQc0C0giSLwUmxi3MjzDIMTkNydYBrUKpGmXE86lj7P2571vjHiVadD3usgo
         G2eI+g1ON6s3QZHWVAyr7MgPtq8nMO+pMx7BbLCgWOmoY/jaZ5NJGWm/b9Mt27iqvUW+
         ZHxX3KnWpNdxRbCKWGatvcZulAqvLgyfEAqDO39YYc5aiGTltRysfpYqwy7Nsr8bhlyT
         XTkSQTJ0yqM5343RIt+l33F44sTt9lFHYDFyAvv8nrPkrbsCGcnROBJ1Ui5pXOWJzawK
         zRjTymLwLhxhQ+rxlHrdIiYV0b5dK9mK7yTdtdLjBuq1zt1BxM3yYSL4sNtNa98eq/w2
         mSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426864; x=1795031664;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uz4m71nRD6f+qddgfa2gOOtoUGlSJn5F5ou4PIom6y8=;
        b=kzqk3QnmJOuLGMEcRl0QxmjnMjN6pIk/ezM0d1mFPCvw2LtMnh4VT8GzO0vSlJ5/gH
         58oy/TKL10iCDZoDV89RL+AvtUZ2cu2GBCbTOIWTm62IPctlHcDNFL8ANCQk4NsfEJzc
         qbUEVSe7LCvJCiZ9dbm6lgvF9CpDXnGexBiHAqskNPTliJydVn9CzoNORgtMBVeosbxc
         5LhlKgV+Loe8JTCjhrbsRIGfYYK9xjR0ELm37SH892IiHjmPKrE2UVSR7CESfR00dxdy
         mags/KIuAAhNgIx/sZlxVDRayX592C6OdBJiqESiniAsVk4na6UWVCMXexbNKiX6Ey9C
         IR6w==
X-Forwarded-Encrypted: i=1; AL+hErGOJUKe/lpFbSgsDIzMyQt6GMpwswa+BjhLx5drwWQpL9F66Njg8umbwRB4bpS3beQp3gA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sdcWNa3u/V9jSv1eICn8LJDL9Y1z72+YwMGyMfClK6lDnhNT8
	rgSKM+qc6FLCRDdUnCrpOz8Je9JM5ixtuvVk4A7VT4nE32slEz2VtqIx0lFyjCSVv+W4dsgqQZF
	ZndIGq8pbEXZWDph+yUXzKBZxvDHNwYj5cCNYzdfl
X-Gm-Gg: AYBFou0IhYgxxhBSmpcn8G3xED8GlN65j3emHWDdW9eLvecwUyjnMWzyF8wABulbHz8
	ysudH51bOaJlO536hki4mrisn0w25tui++E+3bSJhuWRsZsEXvhNUbTdfcJ3fZsSich0QbFQTm2
	LjvhlyZlvycvmIWX+EFVu30KLImWuzmoezDJoOZcLNZZWybMzlFL55FEgyOdGcXzZnMHmolZIVG
	wSGEUOIqZSVhEKinhcTe5PGOupqqgzyD7aOdxRronw+F0GzOwdZp28WRcPza60gzrRYTvXH3+d0
	6ezcDXktL8Tj+9sXyD7+Ov9anDhWj2fZLYccDGsm2mbtfXO/OUyEvNmWeV4Uz0UumEw84GCRrzl
	2bhjzVjh7VFDR8ugqrG9KkIMszWQmuPcbZC3d7n4myebFIEGEM8yTn4cxg32pw95xeV5zOe5uDP
	4LiY8+JtXJ70PGT31OdnsHUw==
X-Received: by 2002:ac8:610a:0:b0:536:6ea4:e6a0 with SMTP id
 d75a77b69052e-5596dcd0110mr2182331cf.11.1794426863094; Wed, 11 Nov 2026
 11:54:23 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn> <1e7fe0eb-2b06-4db0-98b1-3535218847b3@amd.com>
In-Reply-To: <1e7fe0eb-2b06-4db0-98b1-3535218847b3@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 11 Nov 2026 11:54:09 -0800
X-Gm-Features: AclHuK842ds_mKapn9TcQRUw1syxLEFrhFQUvpEEkUm30hfHXep4Wlia77qvmLs
Message-ID: <CABdmKX2hLTrxmZCRRLKFd3GuYP7tr1TX0-JGuXiKAZ+ZV8U36A@mail.gmail.com>
Subject: Re: [PATCH] bpf: make dmabuf iterator stay drained after NULL
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Kang Chen <k.chen@smail.nju.edu.cn>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sumit Semwal <sumit.semwal@linaro.org>, Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 12:18=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Adding T.J. to comment.
>
> Regards,
> Christian.

Thanks I've had to aggressively filter emails, so for the most part I
only see stuff where I'm on To: (and I still can't read them all). I
would have expected get_maintainer.pl to add me here.



> On 11/10/26 13:51, Kang Chen wrote:
> > bpf_iter_dmabuf_next() uses kit->dmabuf =3D=3D NULL to mean "iteration =
has
> > not started".  dma_buf_iter_next() also returns NULL at the end of the
> > list, so a next() call after exhaustion restarts from the list head.
> >
> > The verifier relies on the iterator contract that once next() returns
> > NULL it keeps returning NULL: process_iter_next_call() marks the
> > iterator DRAINED and treats the result of later next() calls as the
> > constant zero.  A restarted dmabuf iteration therefore hands the BPF
> > program a kernel pointer while the verifier believes R0 =3D=3D 0.
> >
> > Use an invalid pointer value as the drained sentinel so the iterator
> > state keeps its one-pointer ABI, and skip dma_buf_put() for it.
> >
> > Fixes: 6eab7ac7c5ee ("bpf: Add open coded dmabuf iterator")
> > Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
> > ---
> >  kernel/bpf/dmabuf_iter.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> > index cd500248abd9..a2b7c38f9ae6 100644
> > --- a/kernel/bpf/dmabuf_iter.c
> > +++ b/kernel/bpf/dmabuf_iter.c
> > @@ -156,6 +156,13 @@ struct bpf_iter_dmabuf_kern {
> >         struct dma_buf *dmabuf;
> >  } __aligned(8);
> >
> > +/*
> > + * The iterator state is one pointer wide because struct bpf_iter_dmab=
uf is
> > + * part of the generated vmlinux.h ABI.  Use an invalid pointer value =
as the
> > + * "drained" sentinel instead of growing the state.
> > + */
> > +#define DMABUF_ITER_DONE       ((struct dma_buf *)1L)
> > +
> >  __bpf_kfunc_start_defs();
> >
> >  __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
> > @@ -173,11 +180,25 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(=
struct bpf_iter_dmabuf *it)
> >  {
> >         struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
> >
> > +       /*
> > +        * The verifier assumes that an iterator which returned NULL ke=
eps
> > +        * returning NULL (see process_iter_next_call()).  Without this=
 check
> > +        * the NULL left by the last dma_buf_iter_next() would be inter=
preted
> > +        * as "not started" and the iteration would restart from the li=
st head.
> > +        */
> > +       if (kit->dmabuf =3D=3D DMABUF_ITER_DONE)
> > +               return NULL;
> > +
> >         if (kit->dmabuf)
> >                 kit->dmabuf =3D dma_buf_iter_next(kit->dmabuf);
> >         else
> >                 kit->dmabuf =3D dma_buf_iter_begin();
> >
> > +       if (!kit->dmabuf) {
> > +               kit->dmabuf =3D DMABUF_ITER_DONE;
> > +               return NULL;
> > +       }
> > +
> >         return kit->dmabuf;
> >  }
> >
> > @@ -185,7 +206,7 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf=
_iter_dmabuf *it)
> >  {
> >         struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
> >
> > -       if (kit->dmabuf)
> > +       if (kit->dmabuf && kit->dmabuf !=3D DMABUF_ITER_DONE)
> >                 dma_buf_put(kit->dmabuf);
> >  }
> >
> > --
> > 2.34.1
> >
>
