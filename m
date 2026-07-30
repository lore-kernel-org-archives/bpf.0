Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC463C3C16
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454208; cv=pass; b=J5dckdIrPemPUKBUfATLQ/gA5SNH2I1JeklFze+NazOJ9LrZrtIb6OqTuIMJB7MgHXew0z+QuYb4jE6AaYWl8dKrms512OMbqpztwMmLF88sF92a8oBHbEBQ9aZdtpuIz8uQw1+owITJ6LU0m8/7lDY09F7oks4cQBs4EAS9vvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454208; c=relaxed/simple;
	bh=fBDmjgHe5RTkIlnri7NkXziV7svQwY0D2SJhp079PxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCNGO9p4J8MCbM2SA8pq3uaBBNi0yKztaQO/4mWIC0TKKkISUel1Az6i0EXu2FoYPVVF3Z+11pGT43OHFm6TLo51i8bNt+4sR88NnkML5CIGmXx0WNr78y0eKrV12ENu/LuafxqnKh2oepVILCLBLpn8D2yHoTYlBZgPgS5IOgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ea+pjPUc; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea+pjPUc"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so382082b3a.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 16:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785454206; cv=none;
        d=google.com; s=arc-20260327;
        b=p26l0v78h/tnX17IMqKPevT/0dAIxN1+X0+5B5e5CUPv01HPEAlO8Ukz6kONmvIKAk
         d0ozzc5J0EjgmJXTRWhOXXUU9pWopsSqwD/eaKkV/vdiI26CBVzcdoIM1f7WQh36W+rq
         w3Rj77XftdukSPGEieFwfWWS/wk+eibym1FOs5duRrusXITChNjTPwCMv+Oyx7s6e9BS
         ZFi72s1IyQCIwIwuJyOPBdqcrCd/XksSoInG/iXXQEMRIszfvWugndsi4TO5nCtshkDw
         iKPSVW7+9nGGQ3XJRwQXghyb2ABtctCFhuQguF5KN0SaAMJzkOlb4dIrSFXapZNoLMpV
         aI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pmuDJv0Djz+3jbheciPPXYSek2Ir+J2dOseeHdpYpWc=;
        fh=bwY/keYBrpINPtM0N8HRy1WOs9ejoNVyHi7e3hbxkUc=;
        b=h7tmcTIw02et8Wyi0l4A4VonFoRQfeaRPmhlxIX/F+9Xpc6yooszH159bAb5AARjXb
         X4CdDDChvzJiRZtTHPxR9ktNLAPggsPRQF6pS+RMdK//mOKKIvNwW4w/l12rBnu/9skd
         aHNZhisQmp7Ebi68lcgHuEJ/0GGGgrZaf5knom/2iifoititJgAQ+vLVkUcj20rYDyce
         /VLz0MMakVywUk8bMBjpNEADglkBZyZLx40JvC3C+jfS6WEWxVFJhGuUwH7wqNbon3iA
         7YFxsP02jMK9jrNz0/z+kJSq/h67qwhKNJAgrOXs9dXJJQUA3s925FYv58XgBDy8T6st
         PivA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785454206; x=1786059006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pmuDJv0Djz+3jbheciPPXYSek2Ir+J2dOseeHdpYpWc=;
        b=ea+pjPUcyhwG25TDAS2gFJt/fqGdFvWLQzKODyhoHb0EE4uZK5NvUVwqeFIrGwBwtb
         HWEfbrSKYAUHO8ijkV141Ug34iq3kNno4/DEZMJMk7S+U3I17z561U73qAEHii1f6qhd
         3c6zNxCdW8PVnE4COv1n4Y8OwG5Yp5X4ACjO6UpgR81gPUB3tYlTBN39Al8yLGpciiN1
         oZ5PhbK3SbyICXEJdM3CPTtigQMnjUpmaKcup2K5Xjs++55au4V8jbr65n4qc2iUlyAF
         awd9MoKhlr99q9x5MM36GxzH768xXJF4aiD/DsNk8n8rRRyJetEQrXF5Qlds3RDuJTUU
         fqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785454206; x=1786059006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmuDJv0Djz+3jbheciPPXYSek2Ir+J2dOseeHdpYpWc=;
        b=igZRyUoNBGoklMcU+P0+GNhISnigNkIcAEUpeZquQEW2Nr4Wr0udutGRWSY+v8Dy9R
         6E10NpYO7Fw0ZAfLids/2itnqodiSYRQQKEB7P2DXT1Nr1S9yhLDMWeL/nLR50LlLnak
         Ybmvyk4U/EC/XZrjM5dKSxaax0cSA1Nx7O6T03fhyzbcaNYM6V4hKFKRSm2XvairYOKn
         6n189Ygx8bz+YR5BjjA6wDnBa8PcSr0XJYvh2HE434Tn3tk0U1D40ureZRMRGwz0ZnQF
         lWkXjfipkYsutbR6eUADFdoj11o9ZiAyT95xEwRf+11CxneuhwKV5u9isyuDHT7TACdB
         XnlA==
X-Forwarded-Encrypted: i=1; AHgh+RqQ2RvLYR3RtKIOVb7VT/fftXKQwzhv4FIDRr9xIrstSIKARxtGwUG8Gxq25z/lgI+rPFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmxGHPytBAyJbGUZNGquZQ99w11P6BQwIZTHaE7J+yB0bZbff5
	Mkgk/eoKk8rywe4iyQnC+v2N5fp5V3Kg0acY9j3ueqUSdx/sb3HbzuXcxlgO/mqmPlakFyAewCJ
	tpnetahZh4b/md5Cz4qXFjcL2GnKqejc=
X-Gm-Gg: AR+sD13oBaWkj5RuUcGFcqs5TzpFbJFNWPoZ6/hw4U7yMm/Jt5sdBCS5CWFzRASC7wT
	5+rhC5l0VXh24lWD5wt8UdHi5lOocHYlrOk8eaGRiJc69jYAM2A4DRv/cl8Vq5EVFOkGMfqObo7
	Uk0YuJjU16Rw975A70wNhfjwmFnKdsZPniFtyViht5i564UOGl4voxN4guf0+rur+hYMuGMJKuD
	vYgsKMC+Pl43dbAnRr5lv6gwsOLIBoRP/WEk7pcF+78epXrOLJFsvGAQ+kEBK8s9i8PiFp0MqbF
	7GRFYor3eGvLIG3CGQBe1ljv4fOOg7K5x9o4mO6kbNRqwBFneQpgeyPafvtp5vOcwqYZuAPAfMg
	QHGp3Q3lUI22JczJ+6mxuabQR6U3qcyTmvgS4SWDbtg==
X-Received: by 2002:a05:6a00:1a87:b0:848:4810:2b71 with SMTP id
 d2e1a72fcca58-84ebc409d47mr4259786b3a.51.1785454206129; Thu, 30 Jul 2026
 16:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729141159128mEJmS_aujBKr-cBu1p_UI@zte.com.cn>
In-Reply-To: <20260729141159128mEJmS_aujBKr-cBu1p_UI@zte.com.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 16:29:49 -0700
X-Gm-Features: AUfX_mxBw2czr1emw5KNW0-RYrXiw2oqpXIGXbZ9J0CPcZxi2Y1LgbtASnX50Sg
Message-ID: <CAEf4Bzba=w2BwpUoMfOPXFszh-8z_kmAO2kWpxNjHb0gikOFyw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_bpf=2Dnext_v4=5D_bpf=3A_log_error_code_on_tramp?=
	=?UTF-8?Q?oline_unlink_failure=C2=A0?=
To: xu.xin16@zte.com.cn
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 11:12=E2=80=AFPM <xu.xin16@zte.com.cn> wrote:
>
> From: Xu Xin <xu.xin16@zte.com.cn>
>
> Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
> code from bpf_trampoline_unlink_prog(). This aids debugging of race
> conditions during link teardown, while keeping the warning rate limited
> to avoid log flooding.
>
> This will be very helpful for speeding up trouble-shooting of some crash
> UAF due to bpf_trampoline_unlink_prog failures.
>
> No change to unlink behavior.
>
> Signed-off-by: Xu Xin <xu.xin16@zte.com.cn>
> Acked-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> Change log:
> - Small fixes according to the v3 disccusion:
>   https://lore.kernel.org/all/82926caa-e16a-457a-8d75-61dfc8dac102@linux.=
dev/
>
>  kernel/bpf/syscall.c    |  8 +++++---
>  kernel/bpf/trampoline.c | 12 ++++++++----
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b47..52c57f8beb37 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3626,10 +3626,12 @@ static void bpf_tracing_link_release(struct bpf_l=
ink *link)
>  {
>         struct bpf_tracing_link *tr_link =3D
>                 container_of(link, struct bpf_tracing_link, link.link);
> +       int err;
>
> -       WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link.node,
> -                                               tr_link->trampoline,
> -                                               tr_link->tgt_prog));
> +       err =3D bpf_trampoline_unlink_prog(&tr_link->link.node,
> +                                       tr_link->trampoline,
> +                                       tr_link->tgt_prog);
> +       WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", =
err);
>
>         bpf_trampoline_put(tr_link->trampoline);
>
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 1a721fc4bef5..49dceea3d51e 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -997,12 +997,15 @@ static void bpf_shim_tramp_link_release(struct bpf_=
link *link)
>  {
>         struct bpf_shim_tramp_link *shim_link =3D
>                 container_of(link, struct bpf_shim_tramp_link, link.link)=
;
> +       int err;
>
>         /* paired with 'shim_link->trampoline =3D tr' in bpf_trampoline_l=
ink_cgroup_shim */
>         if (!shim_link->trampoline)
>                 return;
>
> -       WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link.node, sh=
im_link->trampoline, NULL));
> +       err =3D bpf_trampoline_unlink_prog(&shim_link->link.node, shim_li=
nk->trampoline, NULL);
> +       WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", =
err);
> +

I changed wording to "bpf_trampoline_unlink_prog failed: %d\n" (in all
three places), applied to bpf-next

>         bpf_trampoline_put(shim_link->trampoline);
>  }
>
> @@ -1712,15 +1715,16 @@ int bpf_trampoline_multi_detach(struct bpf_prog *=
prog, struct bpf_tracing_multi_
>  {
>         struct bpf_tracing_multi_data *data =3D &link->data;
>         struct bpf_tracing_multi_node *mnode;
> -       int i;
> +       int i, err;
>
>         trampoline_lock_all();
>
>         for_each_mnode(mnode, link) {
>                 data->entry =3D &mnode->entry;
>                 bpf_trampoline_multi_attach_init(mnode->trampoline);
> -               WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, m=
node->trampoline,
> -                                       NULL, &trampoline_multi_ops, data=
));
> +               err =3D __bpf_trampoline_unlink_prog(&mnode->node, mnode-=
>trampoline, NULL,
> +                                       &trampoline_multi_ops, data);
> +               WARN_ONCE(err, "__bpf_trampoline_unlink_prog returns erro=
r: %d\n", err);
>         }
>
>         if (ftrace_hash_count(data->unreg))
> --
> 2.25.1
