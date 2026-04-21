Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3D399345
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760156; cv=pass; b=A5mFVBbpCJr1ul+WST83buzOa4XEIYt0uACglRr08nwKQUWQExrI0JGC9D5kNLAEVOwIyYvhr8kfe1NX8gcBTBmp4oLNVFDATrscmP1k9jwSbM+X1dEZZX/tqN6oPjsDQNOxUH2VQ+9pygS6nQsgHWN/hQIrKeykMdL3Brdvi/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760156; c=relaxed/simple;
	bh=DxweTDA1HWr3vdrk61H0Qs8so9f8NrtGRJglz2zsZwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ve8wWZVWDj5ifjqd23tvq2T0S9CGLv4mInthsN2INI5Li9TExCNLL6xJ6h3YQOmB4HEoliedxMO6BO4Q9gDRVbSXTv/5x8bjoNwULV9Vg9LPlbgYDPXEkkEqtKJnjzZEsP3eJGCPEMGZnHFOjy+Dsn4tk8bgqXf1Fn+EHogjmOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODKlNKoV; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODKlNKoV"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4779b2497b4so2331746b6e.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776760154; cv=none;
        d=google.com; s=arc-20240605;
        b=If0JRP72e6mZ3dMsKg5p1DJS9+MhB7NE7NWyeBNO98um/kgKQ/091TEQ2rtRdDa7wC
         T0mC4L7dQ3XUmjyN4nhOyKa0FD39ta3HpFdI4Twt4U6VmkKXl4WZ5nGFDrC6jJ5nwz4a
         yMlxtQjG5K94iAcxqMPPfbgPYqUiFeAOZvRePjax6uhBhFLuAw5aG9LADiC4c7Hivgu6
         D0skZuFtZis6sgrnUjww4uWxWWI4X4RyOFCde5s/98TYaHHSkQzmmtg/g6jRsaOk2pfZ
         Z5fpoDMk+fJpIWkhUx4V2rmuqS+iOfT8csEfQI46OIo+XK7MgOe31+NH58r681Vdlmpd
         7ZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WBVIXswxrTHLxN2X8g7ZfdzVtDIvweY9RptkLep9mS8=;
        fh=iJ/Y6mooKg8w9V941YofMm4Ar8PUH/p5dED8m8WJDcQ=;
        b=RjETtFIY2yDXnj5vUS+eIVImWWnPw4H4Q8u9w5xCV2QfBwthIIVHERcQGAMXSjfdY/
         Qq3FKbVXb6sTlL6bKn00gq0cCecoJxtTh45kiOzW5flYhwX5oX+3indrRkDDhhuzz5G2
         eKb4HBHIpTr0fk8Mj5XIeW/zcsF/aNbY+vjEe3UapxCfYeHfeSNpBP7kJ42s4HHQUV4F
         XUKZSLxPlum9Kgc84/JFQ+9SbXOE2GeGfFgFnOYETRuezPW5azJyXL9pQOW6PFhWNVGB
         77pS8iZ/ooLW04DtkIYa3LQQMNcbreqlvw0C3SuKf8gcOlyDzzqP3dKxly2OZV5HjIoO
         UgBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776760154; x=1777364954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBVIXswxrTHLxN2X8g7ZfdzVtDIvweY9RptkLep9mS8=;
        b=ODKlNKoVpoYR7ZtDrpgoYZIk5C+LYuJvvcve8MZqbT6vxzbFpl4rnKD6O00N23Z/ak
         aa/cUhM8p+sWnmJ6NozplgnznQSbS/WjQLaLNuPA+htSyTHKVLXoWjaKTecIqTgUiwlq
         3AATGg9rmdptnkskvLuluZqm/S5GROPv8iY7aLQtl/8ZSefwcshiOI2HJOkKUSm0mk/R
         nL0KncRj+UZDct1slQ72OTtEQf1FqVUkBgbKTZRnozA2mUXUVowtIaq10r1FOJQYi7IE
         fHLG82RB9D+685XMc3f1FMq+AunrD+4UTa+as9sL1kzOdgV/LCX/NrL83yNvJbptToc1
         CoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776760154; x=1777364954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WBVIXswxrTHLxN2X8g7ZfdzVtDIvweY9RptkLep9mS8=;
        b=mvzw9SbC+8ldejWeo/+/SFINSpll8pvJGmFAN5lVybpMKtcPAS5QYkiCaOK0OR3L5g
         5FNauL+IynusdbJXxpLuFfCx757ZRFozQIXMCzTxLlwQflWlAHsHk/6TrUWUrGCgkrMI
         6LVY1yLgiU7Q1gJpcqtecPwgjYwcXSjKeU2qSyBajpjrBjYI3dhTRvsIdvYPuQfxWlA6
         oLmN40cxiBEdjqK+5wehc08XuW0+1pCPwn1xTh16OD8TlR2r18Vd2SUbnjv5CyqYZmHJ
         herQXRUmGt1km2YgYkrhIiLcOuulRKruIKryFvq0pUbixxEU3xBlufMxi7Q0TYPGV9UL
         ypPg==
X-Gm-Message-State: AOJu0YxgPrgJkyXRIG5P+9+NZUMrzzJM2Jrd1qUQrHd9w2b3+gDvryxI
	N6+xx+y06lsjhg8aYrudJZin3VK9QtOtLhyx56FpX9oMfzgDdIM1mKiv9FI9plfoZzrHzvIEIMo
	Ve+ZYB6BBay1OHG+v4Hq7E+m4A7ec3TRc0wCi
X-Gm-Gg: AeBDieu2rtdZMwB8M9wLcATuPS+z8IkVZ45ONmHA/OA1gp24/2GVUFETSBuwJShPLrj
	jCao8IWPISxJonxQJTIVN83+B7ZFFYBe935X2AkCr3CrowaAjEi8t6cv+CP0evCr4SzMsw1B7wD
	Fi5IPqt8vC6jrzIUWd8qKFgE2YBp+EtXqoRkZy9AZra/wqJbUwLOw+SX84ZzSqcPxMIW+IyuIg9
	KZAwitbwkdPbvneeBT8ATejVdxyIioLJaiw2dC/DCFEIlYF+g+14AZ36tivf9/DOlDDQf1dtH7o
	qZU1a4s3JDAuW88Jf3bT
X-Received: by 2002:a05:6808:4f21:b0:45e:69af:6bc6 with SMTP id
 5614622812f47-4799c8efc88mr9708304b6e.13.1776760153594; Tue, 21 Apr 2026
 01:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420184656.331306-1-suchitkarunakaran@gmail.com> <20260421004512.CDE13C19425@smtp.kernel.org>
In-Reply-To: <20260421004512.CDE13C19425@smtp.kernel.org>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 21 Apr 2026 13:59:00 +0530
X-Gm-Features: AQROBzB2-lB0ULwE7TD80N0d04Nl5b0rwS9pxFz-WQLDkYLwQhO5hDs3zwW6nSw
Message-ID: <CAO9wTFiFRSRjMRSAA+vV-AF1rJQGdoCK_p6TXvQ+V1ToaqMs0w@mail.gmail.com>
Subject: Re: [PATCH] perf/lock: enable end-timestamp accounting for cgroup aggregation
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Apr 2026 at 06:15, <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [High] Incomplete spinlock and rwlock contentions are silently dropped =
for LOCK_AGGR_CGROUP because account_end_timestamp() skips the per-CPU tsta=
mp map.
> - [Medium] Inconsistent cgroup attribution between complete and incomplet=
e lock contentions when a task migrates cgroups.
> --
>
> commit 7ba25dc647534f97eb1ae9f34c6c8d38e7fef074
> Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
>
> perf/lock: enable end-timestamp accounting for cgroup aggregation
>
> This commit adds a cgroup_id field to struct tstamp_data to properly acco=
unt
> for incomplete lock contention events when aggregating by cgroup. It reco=
rds
> the cgroup ID at contention_begin and uses it to build the aggregation ke=
y
> in userspace.
>
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bp=
f_lock_contention.c
> > index cbd7435579fea..1a5bd2ff8ee4c 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -463,8 +463,8 @@ static void update_lock_stat(int map_fd, int pid, u=
64 end_ts,
> >               stat_key.lock_addr_or_cgroup =3D ts_data->lock;
> >               break;
> >       case LOCK_AGGR_CGROUP:
> > -             /* TODO */
> > -             return;
> > +             stat_key.lock_addr_or_cgroup =3D ts_data->cgroup_id;
> > +             break;
>
> Does this fully enable end-timestamp accounting for cgroup aggregation
> on per-CPU locks like spinlocks and rwlocks?
>
> Looking at account_end_timestamp() in tools/perf/util/bpf_lock_contention=
.c,
> there is an early return that skips the per-CPU tstamp map:
>
> static void account_end_timestamp(struct lock_contention *con)
> {
>         ...
>         /* Now it'll check per-cpu tstamp map which doesn't have TID. */
>         if (aggr_mode =3D=3D LOCK_AGGR_TASK || aggr_mode =3D=3D LOCK_AGGR=
_CGROUP)
>                 return;
>
>         total_cpus =3D cpu__max_cpu().cpu;
>         ts_fd =3D bpf_map__fd(skel->maps.tstamp_cpu);
>         ...
> }
>
> Since account_end_timestamp() skips iterating over skel->maps.tstamp_cpu
> when aggr_mode is LOCK_AGGR_CGROUP, are all incomplete contentions for
> spinlocks and rwlocks still silently dropped?
>

As per my understanding the tstamp_cpu map stores per-cpu entries
without a TID, so there is no current task context available to derive
a cgroup ID. Unlike the per-task tstamp map where cgroup_id is
captured at contention_begin time, per-cpu entries represent
spinlock/rwlock contentions that are inherently CPU-bound and not
attributed to a single task at contention_end time either. The
original LOCK_AGGR_TASK mode has the same early return for the same
reason, cgroup attribution without a task context is not meaningful.
This patch addresses only the per-task straggler case.

> [ ... ]
>
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/per=
f/util/bpf_skel/lock_contention.bpf.c
> > index 96e7d853b9edf..d0e2cad02fa36 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -536,6 +536,8 @@ int contention_begin(u64 *ctx)
> >       pelem->timestamp =3D bpf_ktime_get_ns();
> >       pelem->lock =3D (__u64)ctx[0];
> >       pelem->flags =3D (__u32)ctx[1];
> > +     if (aggr_mode =3D=3D LOCK_AGGR_CGROUP)
> > +             pelem->cgroup_id =3D get_current_cgroup_id();
>
> If a task migrates to a different cgroup while blocked on a lock, could t=
his
> lead to inconsistent attribution between complete and incomplete contenti=
ons?
>
> The cgroup ID is statically recorded here at contention_begin() and used =
by
> userspace for incomplete events.
>
> However, contention_end() continues to dynamically resolve the cgroup ID:
>
> SEC("tp_btf/contention_end")
> int contention_end(u64 *ctx)
> {
>         ...
>         case LOCK_AGGR_CGROUP:
>                 key.lock_addr_or_cgroup =3D get_current_cgroup_id();
>                 break;
>         ...
> }
>
> Would it be more consistent for contention_end() to also use the statical=
ly
> recorded pelem->cgroup_id, ensuring that both completed and incomplete ev=
ents
> attribute the contention time to the exact same cgroup?
>

I think the fix should go in the opposite direction. Instead of
calling get_current_cgroup_id() at contention_end, I think we should
be using pelem->cgroup_id. Semantically, the cost of lock contention
is incurred by the task that had to wait for the lock. So it makes
more sense to attribute that cost based on the cgroup at the time the
wait started (contention_begin), rather than whatever happens to be
current at the end.
I=E2=80=99m not entirely certain about this, so I=E2=80=99d really apprecia=
te any
input from maintainers and reviewers on whether this attribution makes
sense.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420184656.33=
1306-1-suchitkarunakaran@gmail.com?part=3D1
