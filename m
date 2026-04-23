Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735943A7F60
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965432; cv=pass; b=W9CI3anwWgJiXa05Z5SYi7IDjXv6WI+eSuYfOi5zqmqnl6stUVcV3zHuFp7jNDO9+NMqubryoXexraPpviEtZ/1+VtP+OoeUG8UKTMEj6v3XQI0eeVWqH/RoB2tdmAcRDDo0DTjJogsNy/tH65GccD9ScEfe4M+Qn6YZ187UNEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965432; c=relaxed/simple;
	bh=OHxZOrHjriMxHjho2VJUv8h1fFH1e65QaiQENIiJcY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gc71CSjcbExzarNZIrTgcqjT68GUqqoEpHqSVI/JlCfjQJljLtJ7FT5Oa643/qsfC+9EB8mf9giLU2fAsVCIWkqal9B1mGN5IG6BgMrQdxpT9CGxOhY1t6KwCMan+xEWIYKRsKzxaXdjW4mDusZZTmm3i8io0Z0lrbgJQxmyzzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO9OHzlA; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO9OHzlA"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479f7e75a6bso1243559b6e.2
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 10:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776965428; cv=none;
        d=google.com; s=arc-20240605;
        b=AiLb74QZgdzqEj4G6dhHjrIr4aqvsHWLymP9n66PH7fgiLV53933RzecIyC/gTBnN9
         Gv8IGUWwMkEv5vs2ntYCC83bD1S/W3h53H1pF6ZJUtAUN52zQoEqZ9GvqZ4mBPrt1Mq/
         tHzxpZl59T0ouZwyGtiSFTWP53B9VtxoQxmZzqbJbvwOkNIT8csar35k9DNMftGNUd0w
         I5bKUzQUbeB0vvQjJrZ35eK1f/hcEyJvVHcPlA8dgPo5UEV6SMqw0w2i97THfSliYGOB
         HKy+KGj6cx1RTqC5IrEffiA6pEpv+jjW8IA8bPeuW4Z3Eh5KaMTGen6bOulvSY7nwu1b
         rXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9npysP+5yV0pgdZL0GRM903p/ov5VmLa5E1kgEUBOlI=;
        fh=U0nyVii9wxrZ6cnrVyCaagdwBuhkwbYEg6+iRybJcqs=;
        b=P4ALJK+LIS6PhyEPdyO7+acxyQ1p5Zr/hJQZrS4V/ixiOsBAmohwNAMpsGvwtyqKK2
         gg9QurIf/FahVHEBd3yAKYoGCLcdS8fz4bQi/oMCKSNQOwxOAm/+mx6tlSsewMxjxUSc
         i2JS54EDncjebRZWwaDpAtaWp2jXoW22PxT8hSYmP9DRIPjfxCDAANRiJO6c5ftVKGgt
         WuJZTc84uHB1BohIPw0zNduX+dqjl1ERFwsaMifJcQNwGnUa8T3DAWkgRelADajbqFN4
         7IkDQLTHkz0YzcMBJ52tNKuHzgKnzoMI0aYRW3aLpf9NKPneLInDfZ2UP/IxycuHj6Rg
         /wLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776965428; x=1777570228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9npysP+5yV0pgdZL0GRM903p/ov5VmLa5E1kgEUBOlI=;
        b=TO9OHzlA8K4NVB5rhoytTydVvshy9vKW/w3BPSSIcQDk3hgX2sBt845v2DG4SN79un
         pgquTvZ8h5hkgpmEZosWAQxcirUzMTozG98bibOyq5uWyP2IG6lq61RECLfPEsJNsXCD
         4k9mC/AQdPF7QvGEytzD6FZpQl9ryTZy39D2ZedW7i1FwrBecT3RkyGIGEQKon/gLEhJ
         ISL+8IBOkyOLvLxej4lVqg0iQ4KA8+9P6BFZCRavj6vq5TYUoJruX6biJKBEiqBr9YRW
         tFhWaohVyMvEVarnc2UrKcew4S/vUgw2VmrDs1RVPNG2qNEzL8AZdkGOdFrMcIFguCZG
         Hrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776965428; x=1777570228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9npysP+5yV0pgdZL0GRM903p/ov5VmLa5E1kgEUBOlI=;
        b=K/VDFWXE20l3fOpGCQjkpVPs/4az3kJq/uZ1Tr/q0P53uYHS6DhQdMixpkC6yz9RKV
         wgKDvLka16ioEVi9IM4UYgpPBuucT1ZQ6+yJN130liSCvlT5x2PXUD8R1cOVPnUrtPD1
         Ra/Yte0xmTOVRE5VkBc41cYXDz41ZDgIoXA5W+vXalOoDDGHqoEE9pP0VQcYzYsNXFZA
         zPKCJ1Y/CbYFFlHmQwh8GcqcrQQp626TwJsljupHloFQfJGTZwIxrop8EebYbzc6nB0h
         N712RAY7Hf6s1RXnbchb9YbMASpn7SSWqJkVQzNLfb8cL2x6xGtmqWgQEgEROgDjHTIQ
         gdLA==
X-Forwarded-Encrypted: i=1; AFNElJ9Zt1eaF8RNSDx5SYC8QfvsFGk0RTLA1WlExX1gyl0jbimDqp/ugFrUgQUE0AOKdv0L5q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7K4ZrxvgvX/+BXWdzpbXE2M+I0LPj8LQVAFFgn7tYGYyIlzfS
	bDEAOm+4VfPsL9UtMIGcaP31medoESQnd/rP64b5kRaJyh7ces/BVmrXoc93pYSZgJDj8K40BLm
	zGadbCpS8+oopJMGt2uTSWKrdMNXA48goXg==
X-Gm-Gg: AeBDieuC8aeXPA5P8Dda3LIW3pM2Hwl8/B2tsEgAhODNXMowSqzX3NKY10qY2Un0/p6
	uqDw8uXUo7J38NY2zi1gPN77Qu9Jr7vFOZ0saPdH1CHWvAfBktZKH40iWpkkTwbE8QFCabeDvU1
	LZSwupuB+HM6/oAxJtUkAtKsPmEFeMxFkbB5K2mpw4NDoewkWIu5OW6HMl/RvEgR31sveVZZG+U
	yRSjI3aGJPcNMSB/14JPqI08k/qvUUFpIfbSiMS+MnEdr+FUSKxjwGwjbrf0EtmOOXXmLlxUa+C
	Lz9CkXFTOvPq7aTReE0=
X-Received: by 2002:a05:6808:e659:b0:479:e9d2:26a3 with SMTP id
 5614622812f47-479e9d23f66mr6239447b6e.19.1776965427827; Thu, 23 Apr 2026
 10:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420184656.331306-1-suchitkarunakaran@gmail.com>
 <20260421004512.CDE13C19425@smtp.kernel.org> <CAO9wTFiFRSRjMRSAA+vV-AF1rJQGdoCK_p6TXvQ+V1ToaqMs0w@mail.gmail.com>
 <aelx3_VdT_PfsNjd@google.com>
In-Reply-To: <aelx3_VdT_PfsNjd@google.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Thu, 23 Apr 2026 23:00:16 +0530
X-Gm-Features: AQROBzCPMzU5pdTXIwzSBgqZUjnJDYTQmeSHfacHJvSFBm0vWjNwGE6EVqX6rAU
Message-ID: <CAO9wTFhoZ5MR4Gv_mgnqSLYz_bemtd3DYusg8OQp_+i_PA3atQ@mail.gmail.com>
Subject: Re: [PATCH] perf/lock: enable end-timestamp accounting for cgroup aggregation
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Apr 2026 at 06:42, Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Apr 21, 2026 at 01:59:00PM +0530, Suchit Karunakaran wrote:
> > On Tue, 21 Apr 2026 at 06:15, <sashiko-bot@kernel.org> wrote:
> > >
> > > Sashiko AI review found 2 potential issue(s):
> > > - [High] Incomplete spinlock and rwlock contentions are silently drop=
ped for LOCK_AGGR_CGROUP because account_end_timestamp() skips the per-CPU =
tstamp map.
> > > - [Medium] Inconsistent cgroup attribution between complete and incom=
plete lock contentions when a task migrates cgroups.
> > > --
> > >
> > > commit 7ba25dc647534f97eb1ae9f34c6c8d38e7fef074
> > > Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > >
> > > perf/lock: enable end-timestamp accounting for cgroup aggregation
> > >
> > > This commit adds a cgroup_id field to struct tstamp_data to properly =
account
> > > for incomplete lock contention events when aggregating by cgroup. It =
records
> > > the cgroup ID at contention_begin and uses it to build the aggregatio=
n key
> > > in userspace.
> > >
> > > > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/uti=
l/bpf_lock_contention.c
> > > > index cbd7435579fea..1a5bd2ff8ee4c 100644
> > > > --- a/tools/perf/util/bpf_lock_contention.c
> > > > +++ b/tools/perf/util/bpf_lock_contention.c
> > > > @@ -463,8 +463,8 @@ static void update_lock_stat(int map_fd, int pi=
d, u64 end_ts,
> > > >               stat_key.lock_addr_or_cgroup =3D ts_data->lock;
> > > >               break;
> > > >       case LOCK_AGGR_CGROUP:
> > > > -             /* TODO */
> > > > -             return;
> > > > +             stat_key.lock_addr_or_cgroup =3D ts_data->cgroup_id;
> > > > +             break;
> > >
> > > Does this fully enable end-timestamp accounting for cgroup aggregatio=
n
> > > on per-CPU locks like spinlocks and rwlocks?
> > >
> > > Looking at account_end_timestamp() in tools/perf/util/bpf_lock_conten=
tion.c,
> > > there is an early return that skips the per-CPU tstamp map:
> > >
> > > static void account_end_timestamp(struct lock_contention *con)
> > > {
> > >         ...
> > >         /* Now it'll check per-cpu tstamp map which doesn't have TID.=
 */
> > >         if (aggr_mode =3D=3D LOCK_AGGR_TASK || aggr_mode =3D=3D LOCK_=
AGGR_CGROUP)
> > >                 return;
> > >
> > >         total_cpus =3D cpu__max_cpu().cpu;
> > >         ts_fd =3D bpf_map__fd(skel->maps.tstamp_cpu);
> > >         ...
> > > }
> > >
> > > Since account_end_timestamp() skips iterating over skel->maps.tstamp_=
cpu
> > > when aggr_mode is LOCK_AGGR_CGROUP, are all incomplete contentions fo=
r
> > > spinlocks and rwlocks still silently dropped?
> > >
> >
> > As per my understanding the tstamp_cpu map stores per-cpu entries
> > without a TID, so there is no current task context available to derive
> > a cgroup ID. Unlike the per-task tstamp map where cgroup_id is
> > captured at contention_begin time, per-cpu entries represent
> > spinlock/rwlock contentions that are inherently CPU-bound and not
> > attributed to a single task at contention_end time either. The
> > original LOCK_AGGR_TASK mode has the same early return for the same
> > reason, cgroup attribution without a task context is not meaningful.
> > This patch addresses only the per-task straggler case.
>
> Right, it'll miss spinlocks and rwlocks but I think it's ok.
>
> >
> > > [ ... ]
> > >
> > > > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools=
/perf/util/bpf_skel/lock_contention.bpf.c
> > > > index 96e7d853b9edf..d0e2cad02fa36 100644
> > > > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > > @@ -536,6 +536,8 @@ int contention_begin(u64 *ctx)
> > > >       pelem->timestamp =3D bpf_ktime_get_ns();
> > > >       pelem->lock =3D (__u64)ctx[0];
> > > >       pelem->flags =3D (__u32)ctx[1];
> > > > +     if (aggr_mode =3D=3D LOCK_AGGR_CGROUP)
> > > > +             pelem->cgroup_id =3D get_current_cgroup_id();
> > >
> > > If a task migrates to a different cgroup while blocked on a lock, cou=
ld this
> > > lead to inconsistent attribution between complete and incomplete cont=
entions?
> > >
> > > The cgroup ID is statically recorded here at contention_begin() and u=
sed by
> > > userspace for incomplete events.
> > >
> > > However, contention_end() continues to dynamically resolve the cgroup=
 ID:
> > >
> > > SEC("tp_btf/contention_end")
> > > int contention_end(u64 *ctx)
> > > {
> > >         ...
> > >         case LOCK_AGGR_CGROUP:
> > >                 key.lock_addr_or_cgroup =3D get_current_cgroup_id();
> > >                 break;
> > >         ...
> > > }
> > >
> > > Would it be more consistent for contention_end() to also use the stat=
ically
> > > recorded pelem->cgroup_id, ensuring that both completed and incomplet=
e events
> > > attribute the contention time to the exact same cgroup?
> > >
> >
> > I think the fix should go in the opposite direction. Instead of
> > calling get_current_cgroup_id() at contention_end, I think we should
> > be using pelem->cgroup_id. Semantically, the cost of lock contention
> > is incurred by the task that had to wait for the lock. So it makes
> > more sense to attribute that cost based on the cgroup at the time the
> > wait started (contention_begin), rather than whatever happens to be
> > current at the end.
> > I=E2=80=99m not entirely certain about this, so I=E2=80=99d really appr=
eciate any
> > input from maintainers and reviewers on whether this attribution makes
> > sense.
>
> Agreed, as I replied earlier we should use pelem->cgroup_id.
>
> The tstamp_data is saved per-thread so it doesn't matter which thread is
> calling this.  I think the concern is when - IIRC I put it at _end()
> because it may reduce the overhead when we have some filters.
>
> But it seems it's already after checking the filters.  Then it should be
> ok to do in _begin().  Maybe it's a better choice doing it in _begin()
> since the thread is about to go to wait for the lock and doing nothing
> critical.  While at the _end(), it'll start the critical section soon.
>
> Thanks,
> Namhyung
>

Hi Namhyung. Thanks for reviewing the patch. I'll send a v2 patch
shortly for using pelem->cgroup_id instead of get_current_cgroup_id()
in contention_end() as well.
