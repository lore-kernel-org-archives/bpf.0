Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED443F0B3
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511109; cv=pass; b=BcewNEqhujHm03+EV20rJk8V99Q888e/G1CJfrn0krzTYlaCNe6+DXec2h39d6746t5WP5qqPJVRmq7reffmaQHQ7H6AvtjqBb3jFj9b9ppr1iCw+B4eX2YAQpMtq538Of+rjxjMukU/5CD4+THhSbGMrDTsZGYqA2ZDB78grDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511109; c=relaxed/simple;
	bh=chfVzJeTQjSbzx3vPhdLe6Aosf8+Gh5xMo2mpbfajNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlA2VPPSLWg2ZwiqWqRa9pscCSzx8KuuiTS8m2pwX1hTDIlLe5/wdpjCpqCYBunMGBX1vbol6kL7W1LdpczvzWPa/ZYG6xFcSYhbEKaO1CXbpoZzhmD0HoKHrKuzUAUfc6cxUzVHDWyzcR1bTOv2etfEHui2JjtP1w9iPLp0C6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+D/859z; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+D/859z"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8487214ad2bso1679030b3a.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 08:18:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511108; cv=none;
        d=google.com; s=arc-20260327;
        b=fegEkjArdnZprDbkNVmtw9rHpiY9GLqUphzkOCvQYR3g0CuEVCYZy+UInP2oQSOMrk
         c9JmxZOH0ZOMGhMKaGmUt2rGmhUxZCo9dMhh7qykPPVFGPlJu61H217BbSsYlVtmTgV7
         n6hrvVnhK8kvNa/K1BcDRHj44iAX+BI0Dlg0nGxaEbY/7xUPqs+6+KOGr+AO56mbNhuK
         0ykdPzLTm8HIBI8CvEord8CSvXGeV/5yU5iUxmsZl9OTSXZLK3kKwl0fuvk7erx+kxXx
         IYRrKIT0gVt1H6xiza0gxyHrMh64SYduwZTAQuCKhmEerLiN4Sm6S1I10JqCj7cEZCWe
         bwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VOuuaXCuP7sxLKwstq+rEEGqoqff9gkJvO6v1dD1d8w=;
        fh=qBbwu35lH5PnYIlJ2vv6c5Zhi+C5J9NHUWjZN0eGCxk=;
        b=BfxxLci+iU6S3N5McVl+hEH2MlqrNinwW1Ixg7tpSJWpGo96IEQMMoFMTC71I/sOx3
         z9ghYLO8lQciUp/ch1Xq4KKlqRPgCxUJ3YiOhBvNore3bQVElGyXzRZvmgARcnXeKZbL
         tQeYbM8m0L6K08RSEVDF3DB3UuhzbtkY2Am4zoRDcd+vWQZBoVdmEofL441n1PBb+d+u
         CO8HDRxAs04ppIlZjeUhp9B4ppfokawQvBwfTzAf+z2uaUGhgK6m+i99rGkMO0ahTfVW
         zaX4/QkYQbPmwGRVg8v87BMjGEfGS0GO9UEyA7RldUtpSr6nGpdAbVA5dE971Frgka6E
         K9yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511108; x=1786115908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VOuuaXCuP7sxLKwstq+rEEGqoqff9gkJvO6v1dD1d8w=;
        b=n+D/859z0M/qP2WR6eLkArz0gL4NXFgUUNpU/n7hFqyhASswZyI8pVu5ZrfU9+dqXX
         nzpMftPE7soQHzrMen1Feths4CwlVecd8tHybCEG6RPaUHBJ9mYUPXct0z7O/ES+F2gI
         jF7kas3SxKXkQAckSL3f1oWyhKs/wAbj9/AwCFYz7khWIODKC1lfOVZaPsCv99glOKpU
         iZZ4W4yGHutrFd5Qz+eHZ2OpUNGA8a1plfoGIU67xOLq+MKEgpOrORAbAJyMzvX9SOeA
         HU+t9oBPnNAufT+9QzStC7JE5ILxsZmfU48nn0Byx6KKvhBNeXy1crbknWjZff+Ajf2v
         Nlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511108; x=1786115908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VOuuaXCuP7sxLKwstq+rEEGqoqff9gkJvO6v1dD1d8w=;
        b=X2vJhlZ3s+m+/yt+c63b+HrgBkwjIaCAzVxj+JzB4KEkzzlP+5hQzKBF/mFP7JRpQi
         dKtwP4G8xc3XcojuoU3Sxkh4h29rwZU5dXAtOtCk2Se+ib/05R7rQxV4gMf9todwhw+X
         PMowK+dQiTz3EqIzaeCTc/gTHpr7J7ijYQYYbZSsyE2i8mFTFLaeuPlwUY/HonMgjJBr
         5zyEPY81zg296B0cJf+zfhGM+wrTX/Iyln1ZAAkuNaTsVjIxon0yAhs03/N4vtzXGhgf
         +OGq3CBdSe+KB/ZYHI+vnZ5ptVU6AY+2ZwY3CjXGzRtiKrQ4vP4Mjw86rkD3WXcAX5rZ
         /vdg==
X-Forwarded-Encrypted: i=1; AHgh+RpC5qiZQ11zcZ8QBfPFv3M1dP09IgKSO9xypsRdAnR8CCVMklf9ht5zOscnx9olCvLDMaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34gwvAhK+5ef6kvG9j5oZj4KdEO6ceyP9KBXZb2uqblZMj+AF
	QNfVRPc62bk6JDzgtjzxd808Ro0MnjBl9R9ikkCsnYTeez5Nt1yp4V2KBGGH71V2yJlFuC9zGKD
	Nx93I4JESNvKx8qaZF1mL3i8jg9+4SHk=
X-Gm-Gg: AR+sD11KzQ9TuglWY9A+pFecWUZU9y2mYOcaCUmPZIgYWVWlom5Xd+KV65wQZFP7Tpn
	Fh2bhEzFahLjGq5/N5aaesZgzZWDxCrlOk/BP9AntxMTQL3XDFppT2jdLij52Klr/uS9JkXOMKN
	XrKx53E+k6je2gSTDQGIH6s2NXfr7nSj0MkVqdvFOK+no5+3GIEDoX6AjmuvZYU8NADF3jFI6YJ
	NfYIYCR83Kxsz2uhCKPqT1PKDQ/XeFDE7O94hc0X1ER+nZJYQMxcDhwbAdlKiyOc1/FppQKbmoP
	711aBvIFbxPPga3tq2iQ+tlriQf/IpaxA0YZnek5KRCFKk9H+IC0SxkM1sJUXkAIMoCsemYCeAj
	C77Z3jcjwaxZwcq9mZy1/KyjbiA==
X-Received: by 2002:a05:6a00:94fd:b0:848:2c2e:c7a3 with SMTP id
 d2e1a72fcca58-84ee47e4316mr88460b3a.16.1785511107513; Fri, 31 Jul 2026
 08:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729083807.1588544-1-jolsa@kernel.org> <20260729083807.1588544-12-jolsa@kernel.org>
 <CAEf4BzYvmVJ7bFZ_dmW-HbwwM1yUxzs40yHNdF_JTn+Hr+0w4A@mail.gmail.com> <amykLSjSzayP4WHa@krava>
In-Reply-To: <amykLSjSzayP4WHa@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 Jul 2026 08:18:15 -0700
X-Gm-Features: AUfX_mwD2HKwvrwhCDe-0LGRMqvPmSikoTaOZkWKBbiOqII39yaydWeqyBt9B-Y
Message-ID: <CAEf4BzY8Mn1oRofO4oeujUmihizZt_DkKuBdtjM3TyfgP8a=iA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 11/11] bpf: Clear buf on error in __bpf_get_task_stack
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Sashiko <sashiko-bot@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>, 
	Tao Chen <chen.dylane@linux.dev>, STAR Labs SG <info@starlabs.sg>, 
	Arnaud Lecomte <contact@arnaud-lcm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 6:33=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jul 30, 2026 at 04:11:02PM -0700, Andrii Nakryiko wrote:
> > On Wed, Jul 29, 2026 at 1:40=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Both bpf_get_task_stack and bpf_get_task_stack helpers that use
> > > __bpf_get_task_stack have buf defined as ARG_PTR_TO_UNINIT_MEM
> > > argument, and we should initialize the buf on every return path.
> > >
> >
> > why "should"? what's the point to initialize it to all zeroes if we
> > failed to get stack trace? we shouldn't allow grabbing stack trace
> > without CAP_PERFMON, and with CAP_PERFMON we shouldn't be worried
> > about "leaking kernel memory" because CAP_PERFMON is plenty privileged
> > and allows to access any kernel memory.
>
> hum __bpf_get_stack already clears buf on error, so I did not question it=
 ;-)
>
> there's this comment:
>
>         /* Pointer to memory does not need to be initialized, since helpe=
r function
>          * fills all bytes or clears them in error case.
>          */
>         ARG_PTR_TO_UNINIT_MEM           =3D MEM_UNINIT | MEM_WRITE | ARG_=
PTR_TO_MEM,
>
> IIUC from verifier POV bpf_get_task_stack switches un-initialized buffer =
to
> initialized regardless of the returned error and such buffer could be the=
n
> passed to another helper that allows only initialized buffer
>

We used to not allow to read stack slots that were not initialized,
but then we changed that and we treat uninitialized stack slot as just
unknown scalar, so it wouldn't be a problem.

But for consistency, let's clear it. Looking at the code some more, we
set the "tail" of buffer on success with zeroes as well, which makes
it possible to use buffer as hashmap key (deterministic zeroes at the
end will result in the same key for the same stack trace), so ack for
the change, but motivation is not preventing reading uninitialized
memory, it's more the usability angle.

> jirka
>
> >
> > or am I missing more reasoning behind this change?
> >
> > > Adding missing buf memset for __bpf_get_task_stack fail paths.
> > > The __bpf_get_stack call does clear the buf properly.
> > >
> > > Fixes: 06ab134ce8ec ("bpf: Refcount task stack in bpf_get_task_stack"=
)
> > > Fixes: b992f01e6615 ("bpf: Guard against accessing NULL pt_regs in bp=
f_get_task_stack()")
> > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  kernel/bpf/stackmap.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > > index f4827afbfed9..9ab0c2523a41 100644
> > > --- a/kernel/bpf/stackmap.c
> > > +++ b/kernel/bpf/stackmap.c
> > > @@ -890,14 +890,17 @@ static long __bpf_get_task_stack(struct task_st=
ruct *task, void *buf, u32 size,
> > >         struct pt_regs *regs;
> > >         long res =3D -EINVAL;
> > >
> > > -       if (!try_get_task_stack(task))
> > > +       if (!try_get_task_stack(task)) {
> > > +               memset(buf, 0, size);
> > >                 return -EFAULT;
> > > +       }
> > >
> > >         regs =3D task_pt_regs(task);
> > >         if (regs)
> > >                 res =3D __bpf_get_stack(regs, task, buf, size, flags,=
 may_fault);
> > > +       else
> > > +               memset(buf, 0, size);
> > >         put_task_stack(task);
> > > -
> > >         return res;
> > >  }
> > >
> > > --
> > > 2.54.0
> > >
