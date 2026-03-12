Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445213FEB1C
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338915; cv=pass; b=uOZnG6k0pUw9UWMd0Xz1EN5BdDL/wQtzIssS3bGYIAsh9jDafbHViJ89+s2CCDQOijd9OeiQSdJYQL98tgG1/FBk2t1zhksZBie7WvG5ukpbCbaUNnB3eipjan87BnO+5uOKmfOWsOZRrYR5SWbZ5e9EUmdqH19Hus8YsCF77eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338915; c=relaxed/simple;
	bh=VEbM2YclUUYQaWM+BdFASZHpoHQN5KAqJ76vXhyVpwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFkuqz+iPgBgwnm11A5m7AOgxZo1CP3i74eTEzT98kMMc7ObhntVvqb4kKV0CzYUJVXFK4ZClpqAmSOWgih93A/5J5H7gCTiVlPaawbz5PNxPxubxjS9S8FvFEhKAcdWn3Shz4X4qgksaFgkOFiD37NgZUqHanDlFGxIojooLbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he3iqWTI; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he3iqWTI"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9704cd6951so137037066b.3
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773338910; cv=none;
        d=google.com; s=arc-20240605;
        b=j2HsZuwM9+Zo7kI+DwFk0ceqbk+CE9iT78rthuGY2+8VL3AEUQQFr/VoTNcFgPtIa/
         3ooOagnMkGWxsbbYspPqdHKS0UKsIDkuRyHctWbdoRUdfYX2um2OEONojsc/XAijH4+o
         ysRxAWYOpXs2Nlt/FAhNTr7uHPvKpHiESMG3GeTrWyJm/Sd8S6FwLCuR8XzdhH5FuqW5
         x2oNY4bHipzCMoh7URKoyIpJXzyiyDEvD33qqE3nJzdYaGcZaaL9cxZobDOcWCVe1cTJ
         pM1rV8Eelv3N9JZ10LouqpV0CzKS89ROMCezUcoRsq/+ZBMA1mE6BUZzXwVqeiGIEFuV
         xYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kJaafjqCN/XuRvQnrN+7UUF5StR4H54kKex3pGifkJ4=;
        fh=s/U2tX1QyS+6Cr3UC+tsC37VXjN1NmMqAyctztF2ai4=;
        b=HtuIm0/pAcb0EGDxDEOacS24PShQPTuwEkPylIwUvhgN+MTwjyDVdxpUKIU9jXDJYp
         rvIlUUaOMBS9XnlpY1Cotev+BeABl9ApITbhaP+DLYMNrKr8SABMtK/i83yDsT5YN7hV
         mvdCqGrsHcUrRnuxU9fXSRMNrOydc+qfEfun8Jymce9cEZItls3gd6MVNj0lZWtwS9+V
         yhOUNL5keB4TFrHrOu+b17KoX0EcW2jv6a/SRqHizECrQEgUcur8Z2B6smnN4SI4QeDb
         SvoOXn+c90wA5QtSP7aJeHR3vFO833fXmLgJWzrRNQNjge28+5yWJEeSnsqnZ5qRIl4w
         4fiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773338910; x=1773943710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJaafjqCN/XuRvQnrN+7UUF5StR4H54kKex3pGifkJ4=;
        b=he3iqWTIvYxgbKL/OsfanxLbgbkc3NQzmL0RmTUzDdfMm009ajTWc7dnFDl4bIzlje
         SkNAwCX0SmqThexASWjgCAF4RYKxs1M3Thz0bQJNXQ/QidMLcjmlrJwjiIJl5AAMGlwQ
         yxMI+WnOiuuxFJyquS30slR7OVgMJP/Rso0zJbqH0hPhn2WvuUfWeWMXfLSMX1dB73sN
         ku/tgG3umjXndtrML1ZvP6dk75QJm7whpT2UBxVmtvkuoKMbtm7S9d5jBPoxH9iYYoYz
         OpN+dPGahOU67dMVeZ8TYF2paDzirLotYMbS/8Qh7uRVUuPsa5hvjMsrhpjdGFklIkGc
         B80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773338910; x=1773943710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJaafjqCN/XuRvQnrN+7UUF5StR4H54kKex3pGifkJ4=;
        b=ZGZnLmKtEczSiiIfPl00m0OZTxTdYHkX+XM/psIMnVDSZyKuXX1ziHZQZvTv3YuiHV
         DtPsayNkuvnm5pDOmMdranDXDfLp8Dmr9Mja2c9A8dFGA2H6NbCknJPg48/e/gTpDJpk
         elufTykxTw9VsHzNJV0wIpn9zxmZ3r5QoxnFdW5OYV+vAFW1XFqJwXmbaEDgNsi3IQIm
         yvV2ziIkixm2/ojJSPKjIcYhzhz95uPh70Vd1yNt0x0g63fS6elAvjgluWhjeoaqjYWx
         4FG4/wEri/Z9rex0aZsxh4Xl3X3eCHx/5QkWf1u4sdruVYzBOwK+JVWgWW31foFoBtGh
         m+Vw==
X-Gm-Message-State: AOJu0Yz9xxx3Au5CV/uuMb1PqsRPgOGm1tjdrBhEakvJxiqkxss6zGpe
	alJXHBhWcnZSi9YIpI3tAb+e6ZDFDh7v11CbziA8ih7+gZHvj7VlAmaZgfId1Hbel0znJUw/+/I
	NzGfJxOZkLnUWxJgK+Qe6jJD6ibHOZnA=
X-Gm-Gg: ATEYQzztyNLPkNADTfryDVoF0FpyCuvhhU3DXbsIXMve4gsT33s7IpIE5WHmLntBj0O
	2x+Tvb83XQop17cxtR0ruoU8KhK8B+vrxORbSfErer5GyxfcyXFXITjNx4CmPiwQ4E1mCdntwlk
	xVdsjUVTlTQexWPySeLDwqGcuPSrY8ow1FvScE7aSWt4fuGx8P/SQ/nxgEqOE6aUE94X9D0Lwlb
	PLLGY0cg9MuAyQf/BdxAIK66CbZ340iOo8XLd3UgNU4R6VX9NwsurEowN36pdFxu9sYtSIAT993
	fkPpbRgUGoSxKYRLDxa6dWU=
X-Received: by 2002:a17:907:26cb:b0:b96:eb74:3152 with SMTP id
 a640c23a62f3a-b97650e804fmr22777566b.22.1773338910097; Thu, 12 Mar 2026
 11:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311225726.808332-1-puranjay@kernel.org> <20260311225726.808332-4-puranjay@kernel.org>
 <CAEf4BzYXpKh=6Bsme-=wv5CG=-X4uycgggJEF6UASiMgawej0w@mail.gmail.com>
In-Reply-To: <CAEf4BzYXpKh=6Bsme-=wv5CG=-X4uycgggJEF6UASiMgawej0w@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 12 Mar 2026 18:08:18 +0000
X-Gm-Features: AaiRm52mpTR6WH8Zihnth_Nci3s1Szkuxq87ahCuFIxap-t0Qot_5FmUwwDVn7Q
Message-ID: <CANk7y0hhx+S1MuKaMNn-B+MC8-ke+OaETy4nyu4EA+Zw8rC9WQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/3] bpf: return VMA snapshot from task_vma iterator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 4:44=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 11, 2026 at 3:58=E2=80=AFPM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > Holding the per-VMA lock across the BPF program body creates a lock
> > ordering problem when helpers acquire locks that depend on mmap_lock:
> >
> >   vm_lock -> i_rwsem -> mmap_lock -> vm_lock
> >
> > Snapshot the VMA under the per-VMA lock in _next() via memcpy(), then
> > drop the lock before returning. The BPF program accesses only the
> > snapshot.
> >
> > The verifier only trusts vm_mm and vm_file pointers (see
> > BTF_TYPE_SAFE_TRUSTED_OR_NULL in verifier.c). vm_file is reference-
> > counted with get_file() under the lock and released via fput() on the
> > next iteration or in _destroy(). vm_mm is set to the mm pointer held
> > via mmget(). All other pointers are left as-is by memcpy() since the
> > verifier treats them as untrusted.
> >
> > Fixes: 4ac454682158 ("bpf: Introduce task_vma open-coded iterator kfunc=
s")
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/bpf/task_iter.c | 34 ++++++++++++++++++++++++----------
> >  1 file changed, 24 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index 50dbeaeafd86..83e3c3983341 100644
> > --- a/kernel/bpf/task_iter.c
> > +++ b/kernel/bpf/task_iter.c
> > @@ -799,7 +799,7 @@ const struct bpf_func_proto bpf_find_vma_proto =3D =
{
> >  struct bpf_iter_task_vma_kern_data {
> >         struct task_struct *task;
> >         struct mm_struct *mm;
> > -       struct vm_area_struct *locked_vma;
> > +       struct vm_area_struct snapshot;
> >         struct irq_work irq_work;
> >         u64 next_addr;
> >  };
> > @@ -862,7 +862,7 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_it=
er_task_vma *it,
> >                 goto err_cleanup_iter;
> >         }
> >
> > -       kit->data->locked_vma =3D NULL;
> > +       kit->data->snapshot.vm_file =3D NULL;
> >         init_irq_work(&kit->data->irq_work, do_bpf_iter_mmput);
> >         kit->data->next_addr =3D addr;
> >         return 0;
> > @@ -928,23 +928,37 @@ bpf_iter_task_vma_find_next(struct bpf_iter_task_=
vma_kern_data *data)
> >  __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_i=
ter_task_vma *it)
> >  {
> >         struct bpf_iter_task_vma_kern *kit =3D (void *)it;
> > -       struct vm_area_struct *vma;
> > +       struct vm_area_struct *snap, *vma;
> >
> >         if (!kit->data) /* bpf_iter_task_vma_new failed */
> >                 return NULL;
> >
> > -       if (kit->data->locked_vma) {
> > -               vma_end_read(kit->data->locked_vma);
> > -               kit->data->locked_vma =3D NULL;
> > +       snap =3D &kit->data->snapshot;
> > +
> > +       if (snap->vm_file) {
> > +               fput(snap->vm_file);
> > +               snap->vm_file =3D NULL;
> >         }
> >
> >         vma =3D bpf_iter_task_vma_find_next(kit->data);
> >         if (!vma)
> >                 return NULL;
> >
> > -       kit->data->locked_vma =3D vma;
> > +       memcpy(snap, vma, sizeof(*snap));
> > +
> > +       /*
> > +        * The verifier only trusts vm_mm and vm_file (see
> > +        * BTF_TYPE_SAFE_TRUSTED_OR_NULL in verifier.c). Take a referen=
ce
> > +        * on vm_file; set vm_mm to the mm held via mmget(). All other
> > +        * pointers are untrusted by the verifier and left as-is.
> > +        */
> > +       if (snap->vm_file)
> > +               get_file(snap->vm_file);
> > +       snap->vm_mm =3D kit->data->mm;
>
> ummm... why? you were making a copy while VMA was locked. If you are
> afraid that VMA was moved to a different mm_struct, we should detect
> and retry instead of overwriting snapshot's mm, no?

This is just to make sure the person who reads this sees it that only
these two are trusted. We don't need it because snap->vm_mm and
kit->data->mm will be equal anyway, I will remove it in the next
version.
