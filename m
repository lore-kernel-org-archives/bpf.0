Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C921C84D0
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781823899; cv=pass; b=NWw8wT+6lbckgUUg0ja2ywWeMtCPK7WufQeDABY6t42dfLzpj5liobxEH58sTTORTlhX+4+rcGKjCx7hnNG0NOH8mc3l6mywOhXjS9Jge3GnSjEhl5iDMx4zAmg3Bzv/nOjks/DIW4xy1nimKTDlvcgyKeSmungZCN2JYQedkH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781823899; c=relaxed/simple;
	bh=EX8FRVIG00u8HGBnvXLPq8RIp5dwT/Ow4pDrpVHV+pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IX6eeIOzHD0cywCZq1giGQs4EG6Dw+jd2xJCXESBlNeIuxxlMSy+jvShjwgrI2LoW2/KDqP+sTEu1ctQosGHec02ySJj0B7iIcSMOOhwJJDaD+co4GPtzVWNblRbQstWCXcZD3IS0YwKnpuPd+T1MdqGu6NL997aebbzh/FONzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8Yfu7lb; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8Yfu7lb"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7fe36f1be74so16013117b3.2
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 16:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781823897; cv=none;
        d=google.com; s=arc-20240605;
        b=XW/ovf2eOQZFSg6vTb21BsBIsUn23fj8DUckAhCJJPIKmGkHwMT+BQDU5zbEFf1Y9h
         JiLsLWNC3KgBW4uOOpjXvGcAEIQ63ssvJv3dQdT9PmjqgBcsTr2t/q+uax0GEn4m9qXE
         1PFetp6iYr9ekGWOkGv3f9fgJf5N0C8nE+rY7GxpdHebQbiCjODAM+azqOLLzc30YsSo
         kYacjCSGiHMrCkio0KhhhUlektPh7g/nHGbbGTid++wn+oSo9AD1BfAStSTIUNXBrMzY
         A+VNbr0Af0KK/AnMO7g1tEmrU7Qpn/k80xhbXKCB5z794dTCj0oECcAiz1aCxpVIH0zo
         gG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n+U5LnBvxE2n7Stgu6vC4rG5e+TN4oQ5BlsbYeF7xXs=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=DVXMOidQEt75BLfrLJEp1p0HP3VAL0b/YW7Y+eCZF+w3KS4Dm/eNjYYYw5E11+vbMe
         URQIEwVdilOH/dipY+8/xq24T8g+w71c/MqxQxnd7f0U2mVwKzGNHboOBMXsMufexQuE
         IJvFhAeqvRjEMMNuL0WbQ81cR3hCNgyLFxFXGzsGWzZer7kH5D7yVo+URZrl5arv5V6F
         1nSn55Ei16yTDkbRYsoCMqPL3/QBTJTetSplfLBy8x5to1cGYKEqjnplCDzVc3+rFjKN
         xWlMT6LaTtdbHXOQylrxFj03ohtlsIRZLaW+PfH2+KWhZpU7J2X4hcZwd+X7cHaY/VkQ
         VCkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781823897; x=1782428697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+U5LnBvxE2n7Stgu6vC4rG5e+TN4oQ5BlsbYeF7xXs=;
        b=J8Yfu7lb8NzUlpYNHvyBxO2YWLvhygfDEYlcvAUdZ4A5gYJMMV6F4K8jgtpyChlmdH
         QveN6UzmF1Zj1fZgSa6cu+HdmjpaSb9HR7B/VoGhxoADgxLBocHni824MZIJHIgBJ5tE
         1H1my+NDdhVnEdpGTagfpLQKOGR525Yk5R3CBOWI/tH5btxmmZvpJyY6fI0dRolMi+DC
         taHFyRnPrki8hOqDCNigLhQIWMrolD2vsebItt0hKXnGnZA4gqs6R8uVIkD6I/bZSh1P
         WBZ49i4yt+J5ezCU6R26stuA8+PH9txawotyDaQHaEOxCc2fYb/IdJ3Y6zycOlv7y3YE
         XNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781823897; x=1782428697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n+U5LnBvxE2n7Stgu6vC4rG5e+TN4oQ5BlsbYeF7xXs=;
        b=XeBsWz6qChdptuJmzpVnTP9B3ItmocdPrQ4ot5UKHvvhTyPBQ3pgnJvMYeklUz2kEl
         wjKnWSlIaSZLnaKB4Ru7x7tKijZXlaPzgWiWNLeMmRO38SUlGQVzvr4Vsr8A1kuYD5GZ
         P2nPB9aWyeRvAjleLOCpc9HJgMtJQOxbvrFSWQhWFZBd0IyU005j6jn7fOwhk3XsfUL8
         DLr2LaeAeony7W0k8CVmKNVaByh7DZnyCniyL9pSajLl52LIEs7Bi9ocr4xBoLnEdqZO
         8qEb10GwuiQqNlVIrvhwlMvHA3fFEyjhrTwPmK3ZWhIw6oNTBb1gKn4jDJG7OGQruS1a
         /iSQ==
X-Gm-Message-State: AOJu0Yzh99mL5HTZJ3gqPM1rTMncxXQiu7AfCSmWZxhXhpUdNlKHdWEu
	fHkxc25tw8B2B3Eh5vTgMH96Y1Y+nhalIMVzwrZYKZjheokp11E7feIGYNjfJlKSXZKHT12AQB0
	tZhKxu8kpxGT/p+PSKVEFeaRik1BOV0zZiQ==
X-Gm-Gg: AfdE7cnmJT7sh7Y3GLapZDUsusxz3cRcUNFH0+byNyhyLAalW6h966MAjHk+HcC5BzR
	nmCXn+vrVGKthTCZVqa4sVm/iqBX7Kx6o4bDAF31e/PShXosYTX6dy9CXXI5+/B9fHnphI5gAEI
	WUT1PW2qCNNBBfy2g5+MpIPSbUrCSlpbxcu4DgbvyGoD+hTQUekHqoMLQ5CsvRWkPfzB4xj1qpp
	/ca3wiOPzL87LrpM2usnnLOMdwweJ4MFxfJSIdUcPgQCLtVdgTEvJBgWQrmGlPpS784G7Tg
X-Received: by 2002:a05:690c:d21:b0:7f8:7e31:28a3 with SMTP id
 00721157ae682-80138627d6cmr9137217b3.49.1781823896442; Thu, 18 Jun 2026
 16:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618221919.2919512-1-ameryhung@gmail.com> <20260618223119.4696B1F000E9@smtp.kernel.org>
In-Reply-To: <20260618223119.4696B1F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 18 Jun 2026 16:04:44 -0700
X-Gm-Features: AVVi8CcFVwA3MIjPhnuWrGMCYNKvR0MNN_Sax3m2dGf3JDq0ygI5IQkS2uUOJu0
Message-ID: <CAMB2axN2x0QXadyNm1FoDgkF9kfAOt58QXGw-0YbT3eEaUo+9Q@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix effective prog replacement with BPF_F_PREORDER
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 3:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Incomplete fix leaves `purge_effective_progs()` vulnerable t=
o an incorrect array index calculation, leading to a Use-After-Free.
> --
>
> commit 66001d04979b50f447c6655c1c7db45dc464ee71
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Fix effective prog replacement with BPF_F_PREORDER
>
> The patch fixes replace_effective_prog() to handle BPF_F_PREORDER array
> indexing. By introducing effective_prog_pos(), it properly replays
> compute_effective_progs()'s placement instead of relying on a linear coun=
t.
>
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 83ce66296ac19..b12e44ec5d8cb 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
>
> [ ... ]
>
> > @@ -960,22 +1006,10 @@ static void replace_effective_prog(struct cgroup=
 *cgrp,
> >               if (percpu_ref_is_zero(&desc->bpf.refcnt))
> >                       continue;
> >
> > -             /* find position of link in effective progs array */
> > -             for (pos =3D 0, cg =3D desc; cg; cg =3D cgroup_parent(cg)=
) {
> > -                     if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_M=
ULTI))
> > -                             continue;
> > -
> > -                     head =3D &cg->bpf.progs[atype];
> > -                     hlist_for_each_entry(pl, head, node) {
> > -                             if (!prog_list_prog(pl))
> > -                                     continue;
> > -                             if (pl->link =3D=3D link)
> > -                                     goto found;
> > -                             pos++;
> > -                     }
> > -             }
> > -found:
> > -             BUG_ON(!cg);
> >               pos =3D effective_prog_pos(desc, atype, link);
> >               if (WARN_ON_ONCE(pos < 0))
> >                       continue;
>
> [Severity: Critical]
> This is a pre-existing issue, but does purge_effective_progs() still
> compute the array index using the naive linear increment that was removed
> here?

I think sashiko is right about this similar issue in the purge path. I
will send v2 replacing the linear search below with
effective_prog_pos() helper introduced in the set.

>
> Looking at purge_effective_progs() in kernel/bpf/cgroup.c:
>
>         /* find position of link or prog in effective progs array */
>         for (pos =3D 0, cg =3D desc; cg; cg =3D cgroup_parent(cg)) {
>                 if (pos && !(cg->bpf.flags[atype] & BPF_F_ALLOW_MULTI))
>                         continue;
>
>                 head =3D &cg->bpf.progs[atype];
>                 hlist_for_each_entry(pl, head, node) {
>                         if (!prog_list_prog(pl))
>                                 continue;
>                         if (pl->prog =3D=3D prog && pl->link =3D=3D link)
>                                 goto found;
>                         pos++;
>                 }
>         }
>
> Since purge_effective_progs() acts as a fallback when
> update_effective_progs() fails, could this incorrect array index calculat=
ion
> lead to a use-after-free?
>
> If bpf_prog_array_delete_safe_at(progs, pos) overwrites the wrong program
> slot, __cgroup_bpf_detach() might later call bpf_prog_put() on a program
> that is still active in the effective array.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618221919.29=
19512-1-ameryhung@gmail.com?part=3D1
