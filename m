Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B43EDAA0
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339353; cv=pass; b=NkSn+VDUcJ+eXKsVd9rjgwXi1r1+lBMGt/LXEdnjlsoHutua9DX6MZxkd7fmqTckYchmRJLcNKUHaNGH2FWIVrobl5UKqe1WWCEHZiSbYQjck6+c7CkBF9SBq/ueT1KDWdsxiFDvQ/CVamj6BebTA8q0AejgyE/XqOGWBWOF7zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339353; c=relaxed/simple;
	bh=ceIUUz0QUk7dm/8ISeRpOOGqbccQMk4npZ+3ANrKM3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwG/zXs3R/nuG5Mn1G7M6d8D/ZFXtD6k8tJdMsi5CdnXO3VYZ7y77Qv4gW2cFSdobeqADBJV0KfGwPGlkWkhc5ehYFCKZX/kBTMN/XIfqV6397OeJh7NozzQJ5qSuW/h0HyBiAdPGcv+L51H/C6ZYwCgbx1OsNlLX28vfk7tiUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwvftzJ3; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwvftzJ3"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7e16f05fd79so21473657b3.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 11:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780339350; cv=none;
        d=google.com; s=arc-20240605;
        b=NoXVgJpcchqJSMwq2m9zUi+LZErWz8GNVfiFMU15qQz00i1rtMsg5NpipMnBKopeyT
         f+U0qohZFHMXNaj+50PStC0z+RcTUE3xC/OShphMmDQMzfIwOCiAg2pIc9wJmdAwE2yJ
         y5ga7CERLgdaQmnrjwawbxEh7wp9ZT98grRRqtDTSaoutcq3q+Xy++dkBYrhcWnjSED7
         Z8QUORq1MBEe4n5GNEcrMoL17yeHOL03+l6KxiZJNxLa0TrliIWm00MzZPdgYFL0FaCe
         Z6ZY6u6elkEmSjXdZG/3EO4en34OqVWoVIif5iyDlGwTOTmSKqUZrdYXfvjmEsUunSjj
         /q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UTE/QKE/3UTjUldWGrtLCLw9TUPITkTTkFp5FaHAxB0=;
        fh=7x+PkoI5vDT7yAplLp+0dlbQd8Tn3BnmA3JaljVbDvI=;
        b=FQ8ErQ421gAtwwNdK81qeYBDAwaXllb0fEKDN+FKwRMJVkYZIaYyAmvOu236hiYoir
         UOs9Eh6AHr0LVYwR1yWl1FPi3tU1eYi0IdIW6bzHqu2fYtUhoRCMQ9p7hKvyhKWM3Hcb
         C0EhvtOViIiDPi03fDeBJx4gw33iOF950aEKVcqtKKh7j+SIGdMDtNxhURhy8zQfGmoh
         HQgc/btCt9BOdqX38FhDj/g86WVjxc018vonINpLtNBxfrDi0Bj2f0yNunZvGRiKGF5q
         OUky7Q/ICIe+RHax7RRKFGHuIpGuYWI1gRj4rabuaZkBd3YRLfGpUEIX9dLvTSIC8aVE
         8pTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780339350; x=1780944150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTE/QKE/3UTjUldWGrtLCLw9TUPITkTTkFp5FaHAxB0=;
        b=AwvftzJ3sRAvQlcI4u6l+7Z81hqt+sqIS+YTWZysG8FIwrJAbirPdd28MZ++8ZffcJ
         JVmATe9vLdEmIDaUfU1Ok7NHOFm+KEknpwy4XKCUPS+JORuDdh853DXZ45VkfGtEjue4
         95HZRYoTqBbeDuVMGuSdxStHCLceyihb9cA/Og+mefaVU6Dq1t0Ro8EhxTJ9Mion0QoL
         lz8Rd3a/2fZ3aYe7E4MIi+Jeip9aa2Q/gtF3DUaipNxUrikbYtDku+NUMxPphKe9JqN4
         tOpqLnvj2QPrZs9+i6aO+9G7RF08WuIQPz37ddQPpIRyOm9eD6P9MCnNMlqCvBYFHAPe
         4Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339350; x=1780944150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UTE/QKE/3UTjUldWGrtLCLw9TUPITkTTkFp5FaHAxB0=;
        b=bt2IH7JtbVEnemep9BGhGzBhu+rOdTAiBGSh9l1gXSpusDUIDks9U6oZ9moW149c09
         QRzme38YZtLP5QFQ+MuhkykkXp0x94SlSOFWgHQky7oRdUGILl7EYX5K6fpQ2iG05rUH
         1JRSM93Uv7Q5CytD/0q6B9+RcGZkilYbCOUJWyXllPNgvXjXg7h3c4uXL7bmMi3H7mDu
         pG9Pnxp1TY47U4vTyAARP8s5c1+yi85spHbRHT081X06HU0ZJ4o21N0Khiv7+jSGSf9e
         5vqantUmAjTlENnCEeyBzywKgNr2gdPG2kBA0o/deUTmAdbUNl3IoWEOJ62rZm8jkj/7
         hvvQ==
X-Gm-Message-State: AOJu0Yzc8sIRjZc5yT1PHS4AV2xxX2pX7ny7oM6msNMUUG9BjalqBLrn
	1WRVJCHOYt3J9MoTChcSJ1A3Kgadav6/0iVNYB63WNhKGSkMbYjnk7FuBpeSSc+p+LxkgTvFrdL
	gIMJb6dN86UK/2SfgcYRnSbuvdPJywR8=
X-Gm-Gg: Acq92OG9FemPQWAzY4isqUEZZwJYiglupUF+zcfCfAPtvsUOBb7y7tBswpFwb+Fu5hg
	l4WpAxRdbYaYvEOv6QjGIQt03FWmU4z8Ov6nhXvn5T5//gAfg8KwObzBdJuoGlXJIPQAnigRIH1
	lGlYM/zb9/EC0lGWDnD+3jABqO1dbV/I16iZ3a04lOkDixsCmLc1TSvyt0yl/tAILUuQiG6+kPa
	uaZpmC27pYFGABCvkt4RNkzphKYGjL2zNd3eJU4IqrgAbyENKsxnhUAGBGF/Xid8fEatyaDfrdo
	p6StJ/M3W2Bmjhwy3QJKc3OPIQqtw2PWGg==
X-Received: by 2002:a05:690c:6202:b0:7bd:a4dc:c22a with SMTP id
 00721157ae682-7e061bcfb82mr110330297b3.48.1780339349532; Mon, 01 Jun 2026
 11:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529014936.2811085-1-ameryhung@gmail.com> <20260529014936.2811085-13-ameryhung@gmail.com>
 <29eaa2d6-784b-4a12-acb3-099052ba0933@gmail.com>
In-Reply-To: <29eaa2d6-784b-4a12-acb3-099052ba0933@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 1 Jun 2026 11:42:16 -0700
X-Gm-Features: AVHnY4J6STqccTyyKpq94c2tpQzdQmVj-nX3qCB_-eVaQzAEU1Tt8OiWPvMh6CE
Message-ID: <CAMB2axOb0Bi9Xn5RS1J+n0_vdD2oFygAa1xCH6O3JR4JJfihyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 12/13] selftests/bpf: Test using file dynptr
 after the reference on file is dropped
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 5:05=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 5/29/26 2:49 AM, Amery Hung wrote:
> > File dynptr and slice should be invalidated when the parent file's
> > reference is dropped in the program. Without the verifier tracking
> > dyntpr's parent referenced object, the dynptr would continute to be
> > incorrectly used even if the underlying file is being tear down or gone=
.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  .../selftests/bpf/progs/file_reader_fail.c    | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/too=
ls/testing/selftests/bpf/progs/file_reader_fail.c
> > index 0739620dea8a..d5fae5e4cf9a 100644
> > --- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
> > @@ -50,3 +50,63 @@ int xdp_no_dynptr_type(struct xdp_md *xdp)
> >       bpf_dynptr_file_discard(&dynptr);
> >       return 0;
> >  }
> > +
> > +SEC("lsm/file_open")
> > +__failure
> > +__msg("Leaking reference id=3D{{[0-9]+}} alloc_insn=3D{{[0-9]+}}. Rele=
ase it first.")
> > +int use_file_dynptr_after_put_file(void *ctx)
> > +{
> > +     struct task_struct *task =3D bpf_get_current_task_btf();
> > +     struct file *file =3D bpf_get_task_exe_file(task);
> > +     struct bpf_dynptr dynptr;
> > +     char buf[64];
> > +
> > +     if (!file)
> > +             return 0;
> > +
> > +     if (bpf_dynptr_from_file(file, 0, &dynptr))
> > +             goto out;
> > +
> > +     /* this should fail - file dynptr should be discarded first to pr=
event resource leak */
> > +     bpf_put_file(file);
> > +
> > +     bpf_dynptr_read(buf, sizeof(buf), &dynptr, 0, 0);
> > +     return 0;
> > +
> > +out:
> > +     bpf_dynptr_file_discard(&dynptr);
> > +     bpf_put_file(file);
> > +     return 0;
> > +}
> > +
> > +SEC("lsm/file_open")
> > +__failure
> > +__msg("Leaking reference id=3D{{[0-9]+}} alloc_insn=3D{{[0-9]+}}. Rele=
ase it first.")
> > +int use_file_dynptr_slice_after_put_file(void *ctx)
> > +{
> > +     struct task_struct *task =3D bpf_get_current_task_btf();
> > +     struct file *file =3D bpf_get_task_exe_file(task);
> > +     struct bpf_dynptr dynptr;
> > +     char *data;
> > +
> > +     if (!file)
> > +             return 0;
> > +
> > +     if (bpf_dynptr_from_file(file, 0, &dynptr))
> > +             goto out;
> > +
> > +     data =3D bpf_dynptr_data(&dynptr, 0, 1);
>
> File dynptr is always read-only, so bpf_dynptr_data() always
> returns NULL. Verifier does not know this (not sure if we should
> address it). Maybe it makes sense to remove this call or substitute by
> probe read, just to avoid confusing example.
>

Thanks for taking a look at the selftests and pointing this out. Does
replacing it with bpf_dynptr_slice() make sense to you?

> > +     if (!data)
> > +             goto out;
> > +
> > +     /* this should fail - file dynptr should be discarded first to pr=
event resource leak */
> > +     bpf_put_file(file);
> > +
> > +     *data =3D 'x';
> > +     return 0;
> > +
> > +out:
> > +     bpf_dynptr_file_discard(&dynptr);
> > +     bpf_put_file(file);
> > +     return 0;
> > +}
>
