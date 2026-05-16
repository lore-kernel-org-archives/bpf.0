Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A527FB1F
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778898037; cv=pass; b=TIlGepVTWYT0QV5s3Ix9NOK62DbTXX+HHS7Tjrmng+LF0TgsEFrfV1h4CartaXq3D6UOMkwAd3ntB2EHTJBfy/FDsHQcY3glmor1S+AXMUgbGNWk27KLjHdX9NQIVBKva1v7/JNYldjtaNOj1LaFkNbj6YyHX0w/JlCdchJN/ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778898037; c=relaxed/simple;
	bh=iq9s9HNnif1wbnsJptZ9gsyYVcpcsnRDV8YHttQa7A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dihH14qcNpM42ZiZ9Ctk5zDkDXKi2zDxY0/3RBjtqV0LJp8uZe4MgeTYDTx6hBjlijbwB+pz3hZeWpG3fpuKtx/ZpLID5B4QTBVbtLUD9NyuMF5WB5sTLQJMThKrIp/pLZHJ1FXnLgnFXwiv9a1mDME8mW9tn8UIJcnHJN0CdPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPF55NM+; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPF55NM+"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b458ca2296so3557415ad.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778898034; cv=none;
        d=google.com; s=arc-20240605;
        b=E7NfQukyHN9nt0GIHnheQ1ms7laLVHa0zmgNKbgpWkojko24/vqNYjY0Qkk++bOEKh
         VFi3DIFpBh8iS7yeCu36TDNNkR1Ais5KfsgINX4b1pSFOwdpgkN8CzbFIYQxp3+OQhJi
         2CmGn+Q2c2boo0z2Z0Lvgvud8M+Zu4cJOFBP/1BTBc8sIUPJvJ3jLlsyYaVAtd0+wQZY
         z7P5Pagcza7F8i20qo2FPG/zijx5clltwePRd/ygQCC5e7ZzyyC5/JqQywxCWoJXMdsk
         i15Ta8uCH4vDbiNfl4nY6tZFhNLASuenIwzKgyip3h41TAthA/OSU7o/emhFvzegxk9B
         aB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fk66sr8wCDkHrd19LciGzBUvpn+vNw4bbCG2bSMDaA4=;
        fh=OJSXE/sFFcIjbdKQOBao09LDliNqnf0Rtt+mkCyu1Cs=;
        b=SzkeT694a0rlSjze6Y1npYZZOlmdVA3sXX0SskF57XkJ51MP2vKtAt0xvcI6mXJsYv
         PJILr4kHkOD+1oYGy83xLi9mZBZc+5He7Z+eJzljGAEMOANisW2lsNIeAFn8TSYf6UMc
         ea+NYEvMbPNaNBaucryvY1CJ56iCPPcGTFAYeb4NrsIPrf4eTKqRJ/8XFafoJglIAEuV
         E6F6DG5IDthCigRhSDmF9Hfg4JRg5c831ubfYbdq+y4R/1nQ+F513yErCrTZ89TKhM87
         IerOgQEFsp4LViz59uN5aCh5QSTBEMUurzhjkV90OxRYUbddaZvIgYv71FetEOQ0yfaW
         c3sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778898034; x=1779502834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk66sr8wCDkHrd19LciGzBUvpn+vNw4bbCG2bSMDaA4=;
        b=gPF55NM+LqjUTORuojc/SRxNvdvVItPi9m82D/7XAyLI/0UqxBqUga4qyWQebV7/br
         75jCT99IFtC1NjaRCWPMVX8nDIKGv1xOyOrMNiQ7d21jfBWtM6TDDjC/4g8z+wq/9fcW
         +JG5mbnDza7++qijMySNfFvMlIxYqlygEvJACJOBAtfRjR97m7RLOcscd9jLk7y+NVGv
         SSNE/si/4PSCNbk0FL8HYsCz7J8Acu9BtyolMafn2O0dv/tXDSwisA/bbBOZCEpCi14y
         1K3JlCIpUzp3b+k/XPvfjK1lZ83fx24A75E5pm15psolkPEPL6teMRkUlWGHuc11MNBf
         n7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778898034; x=1779502834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fk66sr8wCDkHrd19LciGzBUvpn+vNw4bbCG2bSMDaA4=;
        b=RizFFouVwm0uaQfkjsnlrhvWlEwzkktdHLOA3YWyXc0B4l34HBPA5wYB/GpC8pCrGN
         36Qfm9B0bdcTl6B+0VUkihk5e5Yo5KXKsVUw7Dul4dXvucYwJTRYocSrz3ww095aCCsN
         Ednx9TbUZ4V0I5So9i2dyPBxwRNr7iIZ2jrmHYK6KXxDVy1eX+mOLc2G7x7EdzUJm2kG
         7PLhoxoa70i31oXLkpiaAFw+quKzvkiEFPEZb4qs6tk4OZ1bv7Ln6sA1KqvhNMd96tI+
         INItjJehDWa3vmT9yJpoZl1km3F5TFOTJwQdhlceoodFuV2gaHADraQjeyuTgUcKMYck
         PhuA==
X-Forwarded-Encrypted: i=1; AFNElJ8lwP3gln5HpHqYOqo1PrHl4sCIeTzs5d8eAhIxtvVOdCqyE+60OcjPiveTuiGQcJb2u90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNHFdIqidJriLI2wHZSGOeXAEBNQgjdbHJKkoB8Eh/NcxMtMiV
	/uSNSGdyKnlFx/ZrJ8UVX4LB3RJtNbvXxoL4XGPMPOXJiQVT3+XuCZN5RRr+suoZRX5pqHA9oFu
	HfB+kJIvzPtdCo0u+jD5xzThodAC+mBnCd2R7
X-Gm-Gg: Acq92OG2E1oF5DgCyJFW7GnoVJQ6tsB5opehCMNClXWgENUw44305NcEZFz4RETBUaj
	JN1ygP4F7z4VCKDE+0i2PSQqEljQ/CsFSTaQEliIEPhKHrcg2qfo8p0XqCNltpIn6c97+FTvA53
	Fqx/dn50pQpet6YEppB/F0Ui4RorcRtA8JF3rpO8zoOT42U4JGljwMP1KKoMpcNIBN2XfvMAszZ
	MaoZ/sC5OEc68PnjkgAR6lQk8mJCKcN9J5G3LNFDizqElCIwiarQ4X6hbSLZoy/fPTF7qmxwMXb
	WCSFFU0=
X-Received: by 2002:a17:902:ffd0:b0:2bc:e299:4c9e with SMTP id
 d9443c01a7336-2bd7e8786bcmr69172795ad.18.1778898034322; Fri, 15 May 2026
 19:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515005244.1333013-1-ihor.solodrai@linux.dev>
 <20260515005244.1333013-4-ihor.solodrai@linux.dev> <CAEf4BzYYmA7=pSe--McfQNP=SEkPnZyhBLb-_-eB8XS4Gtw2QQ@mail.gmail.com>
 <c99ca87d-2835-4e49-815f-663452c9c156@linux.dev>
In-Reply-To: <c99ca87d-2835-4e49-815f-663452c9c156@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 May 2026 19:20:22 -0700
X-Gm-Features: AVHnY4K0vEVPCME1a3Yvc_gI1O5FaaP6z98dmjUSHG_ShBjKjxEkomiPhrXdJ7Y
Message-ID: <CAEf4BzbO3ygRafsQVXF5_4ssFMJq+q1=UcK0LpNua2+-RDCBcA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/3] bpf: Cache build IDs in sleepable
 stackmap path
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 4:59=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 5/15/26 3:40 PM, Andrii Nakryiko wrote:
> > On Thu, May 14, 2026 at 5:53=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> Stack traces often contain adjacent IPs from the same VMA or from
> >> different VMAs backed by the same ELF file. Cache the last successfull=
y
> >> parsed build ID together with the resolved VMA range and backing file
> >> so the sleepable build-ID path can avoid repeated VMA locking and file
> >> parsing in common cases.
> >>
> >> Suggested-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  kernel/bpf/stackmap.c | 56 ++++++++++++++++++++++++++++++++++++++++--=
-
> >>  1 file changed, 53 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> >> index 08f7659505d1..7336fd55c856 100644
> >> --- a/kernel/bpf/stackmap.c
> >> +++ b/kernel/bpf/stackmap.c
> >> @@ -230,13 +230,33 @@ static void stack_map_get_build_id_offset_sleepa=
ble(struct bpf_stack_build_id *i
> >>                 .vma =3D NULL,
> >>                 .mm =3D mm,
> >>         };
> >> -       unsigned long vm_pgoff, vm_start;
> >> +       struct {
> >> +               struct file *file;
> >> +               const unsigned char *build_id;
> >> +               unsigned long vm_start;
> >> +               unsigned long vm_end;
> >> +               unsigned long vm_pgoff;
> >> +       } cache =3D {};
> >> +       unsigned long vm_pgoff, vm_start, vm_end;
> >>         struct vm_area_struct *vma;
> >>         struct file *file;
> >>         u64 ip;
> >>
> >>         for (u32 i =3D 0; i < trace_nr; i++) {
> >>                 ip =3D READ_ONCE(id_offs[i].ip);
> >> +
> >> +               /*
> >> +                * Range cache fast path: if ip falls within the previ=
ously
> >> +                * resolved VMA range, reuse the cache build_id withou=
t
> >> +                * re-acquiring the VMA lock.
> >> +                */
> >> +               if (cache.build_id && ip >=3D cache.vm_start && ip < c=
ache.vm_end) {
> >> +                       vm_start =3D cache.vm_start;
> >> +                       vm_end =3D cache.vm_end;
> >> +                       vm_pgoff =3D cache.vm_pgoff;
> >
> > isn't this unnecessarily convoluted way of doing things? If we are
> > here, we know for sure a) how to calculate offset and b) we need to
> > memcpy. So just do that here and just then maybe jump all the way to
> > id_offs[i].offset setting. Or just fill offset, status and memcpy
> > build id here and continue.
> >
> >> +                       goto build_id_valid;
> >> +               }
> >> +
> >>                 vma =3D stack_map_lock_vma(&lock, ip);
> >>                 if (!vma || !vma->vm_file) {
> >>                         stack_map_build_id_set_ip(&id_offs[i]);
> >> @@ -244,9 +264,21 @@ static void stack_map_get_build_id_offset_sleepab=
le(struct bpf_stack_build_id *i
> >>                         continue;
> >>                 }
> >>
> >> -               file =3D get_file(vma->vm_file);
> >> +               file =3D vma->vm_file;
> >>                 vm_pgoff =3D vma->vm_pgoff;
> >>                 vm_start =3D vma->vm_start;
> >> +               vm_end =3D vma->vm_end;
> >> +
> >> +               if (file =3D=3D cache.file) {
> >> +                       /*
> >> +                        * Same backing file as previous (e.g. differe=
nt VMAs
> >> +                        * of the same ELF binary). Reuse the cache bu=
ild_id.
> >> +                        */
> >> +                       stack_map_unlock_vma(&lock);
> >> +                       goto build_id_valid;
> >> +               }
> >
> > same thing here, file matched, so memcpy(build_id), calculate correct
> > offset, set offset and status, unlock and continue. This logic is
> > pretty straightforward, IMO it's cleaner to copy-paste these 4 lines
> > than dealing with the goto maze...
>
>
> Eeh... it's a style preference I guess. I had two memcpy() points
> originally, and then Mykyta suggested to consolidate them, so I did.
>
> Having a single "build_id_valid" point with a common "ok" sequence
> makes sense to me, but at the same time I am not allergic to 4-line
> copy pastes.
>
> AFAIU with your suggestion we'll still have a label at
> id_offs[i].offset =3D ... so it's not like we'll get rid of goto right?

I'd forego goto altogether. You extracted stack_map_build_id_set_ip()
for absolute IP case, why not add stack_map_build_id_set_offset() (or
something a bit more reasonably named):

void stack_map_build_id_set_offset(struct bpf_stack_build_id *dst,
unsigned long off, void *build_id)
{
    memcpy(dst->build_id, build_id, BUILD_ID_SIZE_MAX);
    dst->offset =3D off;
    dst->status =3D BPF_STACK_BUILD_ID_VALID;
}

and then `stack_map_build_id_set_offset() + continue` for each of
three possible build id cases

>
> >
> >
> >> +
> >> +               file =3D get_file(file);
> >>                 stack_map_unlock_vma(&lock);
> >>
> >>                 /* build_id_parse_file() may block on filesystem reads=
 */
> >> @@ -255,11 +287,29 @@ static void stack_map_get_build_id_offset_sleepa=
ble(struct bpf_stack_build_id *i
> >>                         fput(file);
> >>                         continue;
> >>                 }
> >> -               fput(file);
> >>
> >> +               if (cache.file)
> >> +                       fput(cache.file);
> >> +               cache.file =3D file;
> >> +               cache.build_id =3D id_offs[i].build_id;
> >> +
> >> +build_id_valid:
> >> +               /*
> >> +                * In the slow path cache.build_id points to id_offs[i=
].build_id.
> >> +                * Cache hits leave cache.build_id pointing at a prior=
 slot,
> >> +                * triggering the memcpy here.
> >> +                */
> >> +               if (cache.build_id !=3D id_offs[i].build_id)
> >> +                       memcpy(id_offs[i].build_id, cache.build_id, BU=
ILD_ID_SIZE_MAX);
> >> +               cache.vm_start =3D vm_start;
> >> +               cache.vm_end =3D vm_end;
> >> +               cache.vm_pgoff =3D vm_pgoff;
> >>                 id_offs[i].offset =3D (vm_pgoff << PAGE_SHIFT) + ip - =
vm_start;
> >>                 id_offs[i].status =3D BPF_STACK_BUILD_ID_VALID;
> >>         }
> >> +
> >> +       if (cache.file)
> >> +               fput(cache.file);
> >>  }
> >>
> >>  /*
> >> --
> >> 2.54.0
> >>
>
