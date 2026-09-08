Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4A145A1F
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788826795; cv=pass; b=ji3krSkGMeehW2ktQ8GQvsV0sQ5iG98B7o/9rv1xzz1fjwHkeNymzfAukCbz7gKHsTd92NAFMR2tcld0kjEHV9gDu+o0NyqfZLd5LBm1K4JTuDzx6/P1YcWs7ITF5X9dIogJrhD/9+zxOcsyKrsP3HyJHj6LqBR905vudxrEOQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788826795; c=relaxed/simple;
	bh=Q8k4JBwkn9qj97tJmtIvdRGBltVIRsnJA54YWSJ8ygQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIFHP8Rphzu+axrJF+0RNyWzBzM5tYSAm4m2HJ2cFgV+FY8gdc1yyyN98Yl45W4OkQX7DcEI3ETCLj05WGDhTUWktTOZQQA7KvQH8K7ArU2BoGASfIokjiBBSBpu1PBJ98EGsZoJLNvH9KzdsYWRESz+0OlypbF/u/y/egoUfGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN5x/Xyu; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN5x/Xyu"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-853c07a76adso3802187b3a.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 17:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788826794; cv=none;
        d=google.com; s=arc-20260327;
        b=GxN4ZPHfS8J0JiSkwoWUIU7WhzzvaceLsRrFmHK3KbjcppwvKU2i3WNBjnsmWvfqPV
         kfMtQ0JcFjgS9xzjJ10yt8uV9acRtu9HKZkLRpBvgBGy2mI9FUJQhcIk08r4v/Sq9YWY
         +rzLYmIdsozDUyWlJ8Q5ISM4hRCoJeBjpLrHULF8G4JCuLb0TI1MHAOS8iMiD8lHglA7
         ojnOGzAMTOeT2O3Ya1qHozJ7tyG7+BtBW82ze4inrzRBREcsTOKaTp06RowjChQJsIjV
         kTRbDBKG3TgxIDJq24r2u/sB1TmCrol0kyUYnAPPMq67PJvQxyyTf90hbwYYTiANJ9cj
         g2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aRhPX2DkqiPbS5/gszpBUQmRnfwNaa4WG41QYbV4fTg=;
        fh=MLy5ZjI4LjI6MnLIHL43jpxxQmmAX4U0hcjiE+bPyG8=;
        b=dNkmiD5JOiysSv5oScrIUW/CVGQfyb4RBXQHatAyU6fAdjgAZwGVl49Ub6RgZlpa2y
         p/KEAdebFG/ltOEUPV88JpWgUFUZWqDS5reWk0m3tWa7h3qoYKudypxPSrvwRkTL4biS
         GhrY0Fphe2aOR0VjOmpUNfmx1L1NUN8rxdiCY9UGRo+NhlzKgQbHhEFXSuIMUPqKzfwg
         87WdE7F8Y7b+2a0JOdlVxsy8RvULGI/ZZxHFvzchgHjvKmXStQrldWDboW0DDglM4jeq
         VMLeGsoSL4tKcvwNpXsUkHOZqij10+NDhYgr2H4vkyH1SjSKKovpHfiNFVA4Cmw2L+8r
         NrGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788826794; x=1789431594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aRhPX2DkqiPbS5/gszpBUQmRnfwNaa4WG41QYbV4fTg=;
        b=QN5x/XyuVhNJzaR+f4UqEjGLd6CyAUfcW5Nhyj+qz4eLfhZfVziBNwT5plusaUidwE
         RLhU6BSAVnQwwIlnKRwwSyZAFXzaUCYSKwf0IqNkPCQHDB3IMeiXWrKoCKsrHYt+9ly8
         tDHgn546uhj650qdoUUF6+8IVyvEZ+W4cK9DTnveYCUs9TYqFiQ49+2JKiYcMyWtNd8/
         GnKAG3T7eFbwO20a+FQyw1AIrFzkpgeuHrI/5Hot92Hba69iNerdqQR97lU00qf1eXvG
         FSa59Sxj2pv8VBEfHpo2DqHbniQp9l5dWX4e015N+WO6RpXZKaGoWhmboEBKYFABJKKh
         SxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788826794; x=1789431594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRhPX2DkqiPbS5/gszpBUQmRnfwNaa4WG41QYbV4fTg=;
        b=jFvjkm6z6ws5J2J3R22yrlq3ScgG4ENR/EEO2m4jwSvZ19+IDpC6z/nlOywRxQCEKo
         mTGIGzEWhGWug/VR9jFVmyLxUq0YXhWXImscmGHc25P38pDCj5kBcF6aWvaK8ZRcgugs
         H4DFVx3PHFTEW4V/L+HBSoGLERiuR9HA3As0Kk35dOXNcyJ2QGinVj08tG7eTGe2Vk2R
         Ar0EChsIsZXmwfMHp3+LGalX8qoegAN3oXu7wQvE/w1GOhz5fn4SuUcXmk0MuZh9GeOA
         IXQOxm4CTy8n9x06lWOO+blEZ9OwHAhPzASzREV9lJ6uzlwFfXv9TYO/Dz+S4DwZhJbp
         dOzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMvPyZdOdMPa0l3iJHlXcfRsgF3lDjbBVzDatKdZPBNPscxKgz3Gs80/HlOFv3gUBjQZM=@vger.kernel.org
X-Gm-Message-State: AFuF++lQJMlMV6JEUZEC0JnK649iNquGJhRl90foU3GNzB5jGTP+oO7W
	1Z3Sz9n5E4hOilfaN0dL2DVp5DRqz/LLicuHhrF8RCJYY0XbUZH0uI+uZV39iMq4aNM87HF3iJS
	IvrvYGSNrDDYaXGuEmlbh99E6Q9V1c1Rju+Ra
X-Gm-Gg: AYBFou3uU+cfcrk6I1jgVUdVom7y+sY3ATV9jVFpRylPjSifmmbioGp9U+EoYILaUq6
	yB+8y1AiM4RETWTYYE6XVmUefkIZ69I5C6psm069BNTaPw2C88y4I4hFGGx+BUglTkKqCLFQqoY
	2zMg4C8sqgVlYBJ9UmMdLhUdAPj/9XlX9aeNUPLuEnWo6CjpoYpKIihE2/KQBtPvUn29Mn/Hazi
	b5Ke3Xt6YerBuo+82gA4bGvhSVk3JRjhhWVE+R3ltydyZpmmtTIPoMjJMR4rQkN4eIoYav/jVaz
	IluhaN7iXVp5PsZMX3ZlulP8giKc9PDL4qx3aXeHSQRPjI8lKabhP+m9cg0ty1aPXv78yxku6Pg
	XUvmGmi3tHjmar+bcRuhq82UOXyKv
X-Received: by 2002:a05:6a00:2d81:b0:842:7296:dba with SMTP id
 d2e1a72fcca58-86166bc04cemr33898479b3a.7.1788826793606; Mon, 07 Sep 2026
 17:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907134552.1772405-1-puranjay@kernel.org> <20260907134552.1772405-2-puranjay@kernel.org>
 <20260907140642.B02581F00A3A@smtp.kernel.org> <CANk7y0j33fmyQyTvL37Tx6Ua_bGfT5n_=Smw44u_H7G6rMcr_Q@mail.gmail.com>
In-Reply-To: <CANk7y0j33fmyQyTvL37Tx6Ua_bGfT5n_=Smw44u_H7G6rMcr_Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Sep 2026 17:19:40 -0700
X-Gm-Features: AcwNN1UDzjWhlQqa_zuA9xBANyMEKplEHlSnjEttoFs_1HeOjm_Le8Sd_yIyMX0
Message-ID: <CAADnVQLeCzCAF1Ku2Ri=PUfespAKPMEO_qQLJ1XEhAtLERgeBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Add bpf_call_rcu() kfunc
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 7:39=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> On Mon, Sep 7, 2026 at 3:06=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] Calling `bpf_call_rcu` from NMI context causes a raw spinlock =
deadlock because `call_rcu()` is not NMI-safe.
> > --
> >
> > commit 3385037afe11a72dffbb6db99b4174626596c231
> > Author: Puranjay Mohan <puranjay@kernel.org>
> >
> > bpf: Add bpf_call_rcu() kfunc
> >
> > This commit adds a new bpf_call_rcu kfunc that allows BPF programs to d=
efer
> > operations using RCU grace periods.
> >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > [ ... ]
> > > +__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__con=
st_map,
> > > +                          bpf_rcu_callback_t callback, struct bpf_pr=
og_aux *aux)
> > > +{
> > [ ... ]
> > > +     rhk->callback_fn =3D (bpf_callback_t)(void *)callback;
> > > +     rhk->map =3D map;
> > > +     rhk->prog =3D prog;
> > > +     call_rcu(&rhk->rcu, bpf_rcu_run_callback);
> >
> > [Severity: High]
> > Does this code risk a raw spinlock deadlock if called from an NMI conte=
xt?
> >
> > Because bpf_call_rcu is exposed to tracing programs, it can be invoked =
from
> > NMI contexts, such as when a tracing program is attached to a perf even=
t.
> > However, call_rcu acquires rcu_node raw spinlocks and is not NMI-safe. =
If
> > the NMI interrupts a path that already holds the same rcu_node lock, th=
e
> > system will attempt to re-acquire the lock, resulting in a deadlock.
> >
> > Should the verifier restrict this kfunc from being called in NMI contex=
ts,
> > similar to how it uses btf_record_has_nmi_unsafe_fields for bpf_obj_dro=
p?
>
> This set is supposed to land after the rcu changes that allow call_rcu
> to work from NMI have landed. Please see the cover letter for the link
> to that patchset.

The patch would need to be updated as s/call_rcu/call_rcu_nolock/ ?
or more will be required?
If the former then we can land it now.

Also notice how your LLM doesn't know about your earlier work ;)
+ rcu_read_lock();
+ migrate_disable();

that should have been ...

pw-bot: cr
