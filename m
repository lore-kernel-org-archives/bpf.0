Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C74534B7
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072125; cv=pass; b=GbnEKyCYlnIqdfvSWCaAo/B80/HkWLk11tAlQz54ClNjON1j/XmI7EisQOaIJFXAiVRtf2DGNY0WJjsK/Kwt04l8qRKjHNWN5TU/3SFFnF8oyf3lk2xYptWctnx3AqvJKXrIG7+N/+D6UixNlET6Llx2j4ZMO34occNeyl5zZGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072125; c=relaxed/simple;
	bh=8TJpJxru8Ade5BKDFxSEZFsJc4R/utyuFPVV128Dcmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spq6GJKuA8L6FiLFGPPNpTMK32lUITSfPgmOWx4WrJ0ECr8wCRMYNCwHvToYAYp09rxOxAAA1KzHjr83exhDNGQEKQC7wXLzTxQS/6WU8+7P4iJcu9VhSPoAtUEo3/9NVMjPR6YC9MHw1rRlyxi/mnkIlCYhgXgsyejxKHEtCc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPhS4/A6; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPhS4/A6"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-393a44854d2so25362591fa.3
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 05:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778072116; cv=none;
        d=google.com; s=arc-20240605;
        b=erkhEHvcu60rEVAE3JLT9RUEi983ie9cgfclOIEa1E1Xv41ueAz4swrAUXfPKLhJhP
         iY9dOzGuHusvGtnAOJzVV2FCf3gsY/FW2yDgaCPkfMFwxF9sbAvVIZWBa+joxm9rLYrT
         DZsI5Zq+xrDO5b+qviv/eHD1gvUoc03f4xucmVOF6eco3FvShCx2+OVjjTJ6kpbZPa7q
         qsF/JBv+d9Z6DrRoPhrK6KmyT4dymzgYY6gTevJWeDiaJSrKlU0ONTvYWyBZeeJmTNOB
         F16RdhKzxaB/ULjziQ8TuOavkRvkSfoL82ZZsOypQK0Lw7LmFUCe+KuYrfHtDGEc2D9R
         AvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HKcm7qSGID1d7+0fCs/2lQ6KEpi3TnEwsbyagB0V9rA=;
        fh=TehjY1t5eGpLR12A70uh3MyGVP6T186N9ByKaUcxf4Q=;
        b=cKwhm0Kzike84PTsgO/GowgLadiFvDvhgcHmKXyv8BXDOu9EH6/GHYP/NCLgjJGMJc
         UtPdH6Hl+QrMyaSv/31HKAJ7y558XSguRm5p91bXvyeBIhOAGRtYHfrfQ5szOwVG0cnL
         mgeO9U1kbhDeAHNCxFgVlfOIPi2Ix5/sCBfMRzy+CtN5jU+30sWz250ayKXdqpnN4cmS
         oSNOeM+RGnxlqdfGtNTySiHzvLsF4UMABtqea/CD79FRDQEWdDjGxu0V9+q/6Z59K6mK
         JQUsA8s7rHzhz4DiIZhxZJJeKuBTs/a/fb9WM8dcfDSRzGXJnQoJR/KOZf2quCMvyts5
         5ctQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778072116; x=1778676916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKcm7qSGID1d7+0fCs/2lQ6KEpi3TnEwsbyagB0V9rA=;
        b=KPhS4/A6nI3OCfaiKRiumhXBaOxMgOPjc0fo2KE+d0Vd0dbb9sVY3bffjoKux8MpHz
         j++Ef7gCDEgQbRCkqZrmciItAq1MH9ya2wAS44UxA6QKO29/NPhpCejsc/sqXSgQB1nP
         hJPoCA8TqNW6vCsWVynPecMtzl9I2qDev1o46n0da0yUBodPvrtjX6PB1MD4J6ro7tHN
         LifAMVycHxdzkf/JMHAFPu7uOfdZ2gVqvrgyjnTenAyk1nHKQU6cTXsZE6/vLwXhx4Tx
         M/Vj/Y0q0CDH1JAFlxVgu04r8D7NnjeTxd2OSA/9mvmDVk/5rje3uvOHmPqzjZMoi9Qk
         5ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778072116; x=1778676916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HKcm7qSGID1d7+0fCs/2lQ6KEpi3TnEwsbyagB0V9rA=;
        b=h0SxinHygnIgo3JkfR2wHsKHE9fGxPMV/F+T3icqS8PgQQ2PuKmrzNpMfffSM2C4Hn
         BknfJ6OZkb9ALqL22eIZAHTmYVX8K5zVtz3rtPs1a9RUN47FlF5UHqMa9pClEkMnKgqm
         T7j0P8aPWUxi69Ucjt4duJLXGJU4vCSVtf69fbgtxJItvNNBKRlHgkHEVcU+YyISJ+n1
         kywRMmN60K5OSOud9XFXBfXbHLD8lJEMuH2sXRXqnpIWPP0wLcVnXOJwdhQmKCCGKxl9
         GGdYOF2bHqCxwHoM6JBR8jBYS9TUGdzJ3JsNxHb3InUZ8TdQ92vue02IYDOT4+LSE3H9
         7ExQ==
X-Gm-Message-State: AOJu0YwwGi6lWuSVW33ce8G7M2lWSIvW1JNwgdF9XcX8Zzh80Zadg/u5
	gDoLQA1Z5OTEccPO01QpQTbkabwXiKMAv0VIM/G35zkDECs3De+pDgltbqv5b7wOh08pINcHbFr
	JONRoVWpYBEbfi4AY8MejfQcayiLX/Wg=
X-Gm-Gg: AeBDiesqcp4cjmXE9h74f/uG0SqbUxSVrZy4H5ER5fvE0uoGmIh+k72Szbz5a0aYgwO
	ybECkWI9QhDCJm+AsJOUaU51H+nzFa8YI+CvxOucz4njh6MMWImPbWPZR4OrMMF97vnRwPhtxwL
	gU5QwqAOxjmZwvdMU4jm+l4dXJk/qMMrOnUxWBxyBEwJcBbfxnVMlz1ZEytplHM5ymTtBzXop6g
	nmPVDsH+bwxBHQ5uOPpWGYHNTRGhs5OsJ+epxFaVJZV0k+ISJP0yFT+T2mKLSNESB0fwQPL8waR
	njhHLiUVu32kT/bo
X-Received: by 2002:a2e:9d86:0:b0:38e:7a75:8763 with SMTP id
 38308e7fff4ca-393c41e12b9mr10705851fa.18.1778072115706; Wed, 06 May 2026
 05:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503165024.1526680-3-vernon2gm@gmail.com> <20260503172520.376AAC2BCB4@smtp.kernel.org>
In-Reply-To: <20260503172520.376AAC2BCB4@smtp.kernel.org>
From: Vernon Yang <vernon2gm@gmail.com>
Date: Wed, 6 May 2026 20:55:03 +0800
X-Gm-Features: AVHnY4LN7DcPgfQAMn9z_9QQ6cdKCWiSeJ-qn33sbqiuvSP62RoVofl8dYPVkWY
Message-ID: <CACZaFFOJEBC_yJyprzUsbBzn7Rn6MB60Yi5jwxCm890TgjV4Ow@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: add bpf_cgroup_{flush_stats,stall} function
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, inwardvessel@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, ast@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, baohua@kernel.org, Lance Yang <lance.yang@linux.dev>, 
	Dev Jain <dev.jain@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forwarding sashiko review

On Mon, May 4, 2026 at 1:25=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] Missing bounds check on the `states` enum parameter in `bpf_cgro=
up_stall` allows out-of-bounds memory access.
> - [High] Both `bpf_cgroup_stall` and `bpf_cgroup_flush_stats` uncondition=
ally dereference the pointer returned by `cgroup_psi()`, which can be NULL.
> - [High] Compilation fails when `CONFIG_CGROUPS=3Dy` but `CONFIG_PSI=3Dn`=
.
> - [Medium] The `bpf_cgroup_stall` function truncates its 64-bit return va=
lue on 32-bit architectures.
> --
>
> commit 11e75919a882d61e2b11423881cab05305d77c18
> Author: Vernon Yang <yanglincheng@kylinos.cn>
>
> bpf: add bpf_cgroup_{flush_stats,stall} function
>
> Add bpf_cgroup_{flush_stats,stall} function to prepare for the
> subsequent mthp_ext ebpf program.
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 2bb60200c266..87f3072adce3 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
>
> [ ... ]
>
> > @@ -2819,6 +2820,32 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u6=
4 cgid)
> >       return cgrp;
> >  }
> >
> > +/**
> > + * bpf_cgroup_stall - acquire the total stall time of cgroup
> > + * @cgrp: cgroup struct
> > + * @states: psi states
> > + *
> > + * Return the total stall time.
> > + */
> > +__bpf_kfunc unsigned long bpf_cgroup_stall(struct cgroup *cgrp,
> > +                                        enum psi_states states)
>
> Is it possible that div_u64() returns a 64-bit value that gets truncated
> here on 32-bit architectures? Since unsigned long is 32 bits on those
> systems, would changing the return type to u64 prevent the stall time
> from wrapping around?

Yes, I will fix that in the next version. Thanks!

> One more thing regarding the build, what happens when CONFIG_CGROUPS is
> enabled but CONFIG_PSI is disabled? Since struct psi_group might be defin=
ed
> as an empty struct without a total field in include/linux/psi_types.h, an=
d
> cgroup_psi() wouldn't be declared, would it be better to wrap these kfunc=
s
> and their BTF_ID_FLAGS in an #ifdef CONFIG_PSI block?

Indeed, this is a problem. Compared to adding =E2=80=9C#ifdef CONFIG_PSI=E2=
=80=9D, I
prefer adding follow, as it is clearer, Thanks!

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 7b4fd8190810..243dcf97bea4 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -52,6 +52,10 @@ static inline void psi_memstall_enter(unsigned long
*flags) {}
 static inline void psi_memstall_leave(unsigned long *flags) {}

 #ifdef CONFIG_CGROUPS
+static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
+{
+       return NULL;
+}
 static inline int psi_cgroup_alloc(struct cgroup *cgrp)

> > +{
> > +     struct psi_group *group =3D cgroup_psi(cgrp);
> > +
> > +     return div_u64(group->total[PSI_AVGS][states], NSEC_PER_MSEC);
>
> Could states be out of bounds here? Since the BPF verifier treats enum
> parameters as unconstrained scalars, a BPF program might pass an arbitrar=
y
> or negative integer. Does this need a runtime bounds check like
> states < 0 || states >=3D NR_PSI_STATES - 1 ?

Good catch, I will fix that in the next version. Thanks!

> Also, is it possible for group to be NULL? If cgroup PSI tracking is
> disabled at runtime via the cgroup_disable=3Dpressure boot parameter,
> cgroup_psi(cgrp) can return NULL for non-root cgroups. Does this derefere=
nce
> of group->total need a NULL check first?

I will fix that in the next version. Thanks!

> > +}
> > +
> > +/**
> > + * bpf_cgroup_flush_stats - Flush cgroup's statistics
> > + * @cgrp: cgroup struct
> > + */
> > +__bpf_kfunc void bpf_cgroup_flush_stats(struct cgroup *cgrp)
> > +{
> > +     struct psi_group *group =3D cgroup_psi(cgrp);
> > +
> > +     psi_group_flush_stats(group);
>
> Similar to bpf_cgroup_stall(), if PSI tracking is disabled, group could
> be NULL here. Since psi_group_flush_stats() might unconditionally acquire
> a mutex, does this code need a NULL check on group to prevent a panic?

I will fix that in the next version. Thanks!

> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503165024.15=
26680-1-vernon2gm@gmail.com?part=3D2
