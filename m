Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753BF14A4CC
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778897723; cv=pass; b=VaToszX5DF9dG67YUuJFAI0+Lfy2fgdmzSSGJnF5uFsluts7lPEpcuLtlzX3xgR4mqiIaNKyfnuHnHwg/gnalOlyGdned356QmY8uev/v5mnr4LtXZIYxfvepnSeBDLIyz0Y6dq+JNXd8V7jwImGzJ2r3lW5SqNSfh6uEhGUvaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778897723; c=relaxed/simple;
	bh=rhvfoiZmhgq9CNbwxTcwypKIECvHaaPUX5mpjXzk07w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9WLq0y0md6axvI3nrNrsnBEQmsXBLQI78L8g/EmkGJa+sFfpCGS5VXs6OnM0M9MRfsnQgq33KVN5HFM+ZN3vce2hT70viKlLeJNH2b47pYyfjhyBT1rgMAKCT7EZL1p6vm4kGlvw90XsQ9oeYVJ3fETJiO8DrKf2FWOZEncppw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQ+XECBw; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ+XECBw"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so172021a12.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778897722; cv=none;
        d=google.com; s=arc-20240605;
        b=PoxVaTlPGvHlUJP2pmBrJBPTw73HftBDx6mrjnUyMtb8M7d7tjlXgMTg9nVt9Sobtt
         Xyk9pxZ6ZJx2WEug0Yz/VZqO80jY+eluYSnj6mpyoEAPmY+E64HIw7MFzKwv/DMkp8e7
         65DFzL+tkkHl2arVc/pqpk5CYF3jRIOm5ktKroN/tzTawvVCb0S4dJRfepbgpKkZbgC6
         Lwbill6XGQsu3/FzNqGhP1y1JLkQsAsMjZj8oe/iw72o/DdPaoC86gBrBN8o7xcSEEKg
         LcYo6ihdZoRo+ABiC5fD/7xPnJzLFnvvRwl2azZs07UvV8CbH8ciTAmcbFGDCRrqesal
         a9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9rfMTdz04H2IRFOpjEHZ/6dNIDGSsh/3dFZcYbnzKVU=;
        fh=zBSgc0HpKxyYiT5nZU6nE2KAa/G4N82IXu9b6hxyeW8=;
        b=VkL++k6FXNiC/jcCG+VNr7jY6/ZNiDZANhvxlD38sv8kW33RzpA16bx/jpfQVUsLbv
         HLDPGUKbJVHHH83OBH9JzmzSBMS9P3Q/fIH6FVhzebkICNJaNWVE5PHi+OzQnS0AOvCI
         /6+D1YK0Alm90gJ21fzUQQ9Id70CXkFN4EdfJ725Gm1pIoUdnjaARvOd5OBu4bQJd0RK
         AD8IO1sj0IdTFHm8AsW1UZ2jpbX/tZ6zDQxuSf0uF2iILZLxrQ/Iax48LBqH52iiTzbY
         a/nzD/+NcqlrtiRqkllAnu0XIVp0V/FylqS9RT9xpnHmKOzsRShD+yNEj2yNdQaG+HeW
         /0BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778897722; x=1779502522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rfMTdz04H2IRFOpjEHZ/6dNIDGSsh/3dFZcYbnzKVU=;
        b=JQ+XECBwM1zc/8biRKjZXJCMq36PJDuwA364CaopcU0aWbfqy0o7glKQFp8Mm1VoUQ
         Ul/jUpsXBBZ7aMXOxgnzIekkDuBuhZJgDQ2ju3wwRiHxrzUYphG7WYEQnKxCbuCtYYrx
         GsS84+/K5RvvB3LhUs6uJb3CL8seyZaeENDpD8I/oDQZNQ3jW1F5DqZJfS6uM5AVOOCP
         xumjTT5JSSYeRRwzV/eFzYB7ehiRytkgDEFsAF2yqff+e6k1hicX7NEfCpqfDGOsG2D9
         IMUFe53awvc/ovJAM16P2KfZf7/GsuULhXoNdCLo5pkCu93/8CseQxltctaRJN2az6aT
         qA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778897722; x=1779502522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9rfMTdz04H2IRFOpjEHZ/6dNIDGSsh/3dFZcYbnzKVU=;
        b=Ybt2K9Gx18mNTpXMj394QZEJCtMgastoGwG847Gq4LtJ39JQmwuT+/11LK2x8Hg5ov
         /PZmS4TG6aWa+arHzCSLDpqNGZ4NN26rBQG+gh8FweQzPxVmGxhBgNeUl2hE7rJbbi3P
         8DtdPFk5LAGPxoXKFewy4xthLIe2UkBx6ICUtAQEm6s0vNj2nSE68Pc3Wi96wJ1kSZIH
         DpSercwAPFOdXtQZO8Z+JQwUTTjkJ+HtLxLJYYu/X/1QLbniwg/TVdIDQWn6jBfNHSZH
         2Gnw2aHI4Ye/wzp+KSBjePiapz/6Fhufwn7FOL/ua9us9fTjh0uiXfT1Qt5iB5rTTbQj
         MItg==
X-Forwarded-Encrypted: i=1; AFNElJ+lSnZOp30JRuw/SVMqrPzO5bmlSbftFmf0V5TKidP9XwyWMsVinlEvfE/2e+Dq6cc8wYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1HXMW96eZPwTSMjijM1OXm93nSEMvjrpI/cnoyRcUDumqWsFm
	pnoTRIWWhl6DH+lrv4f2Gvrxe1FnupNGTEESr5dd1ouJS8UXWXU0D7kOaInL9kWQ/qObgqvn1cT
	52MAlBPfwRZ2ojgCu0/bUJpoMw1Z2BC4=
X-Gm-Gg: Acq92OGPtKLcwVU3NqA7UyVvR+TGKCt6hCQZmsIBzmBg2/SKs8DmbY3YcqY+bUdJYNJ
	EN7HeYefD9r71NmRp0SeNSSrDPtoWRZE6SyEYcC511twnokiJJRPjBGO2QKJCLUr7/SwrLxY9Kq
	elqqoHfXUQ6X93WMd5ML2pLNRdqChgoO3HeCFQOyiJRtT6or5sSy3sOy07p2QEx9VEfkqYE3zUA
	hY2uZjV6HqY0s/sYCtp3yJiovMi6eRXLfhJrZXD1xvl2NakpPZFiiv9AvYFqbh8oWp+jzCDKK0W
	fb4DE8uCgwmq+BNHsQ==
X-Received: by 2002:a17:902:c194:b0:2ba:6013:eeaf with SMTP id
 d9443c01a7336-2bd7e8fbda6mr50838405ad.19.1778897721569; Fri, 15 May 2026
 19:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515005244.1333013-1-ihor.solodrai@linux.dev>
 <20260515005244.1333013-3-ihor.solodrai@linux.dev> <CAEf4BzZ1u6N2+cSkkSn65F_D_jEZK+4Gy_M1GNOVXkD36h0Now@mail.gmail.com>
 <e3879e7d-08b6-4bb7-bf76-b2f4d6f59a11@linux.dev>
In-Reply-To: <e3879e7d-08b6-4bb7-bf76-b2f4d6f59a11@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 May 2026 19:15:09 -0700
X-Gm-Features: AVHnY4Jd1TcSDBDMjjXmmOFjdCGXzEA28nyMdZ8HfNjpS0vO1gQxool6RVXiXkU
Message-ID: <CAEf4BzbAXGH+iaXqg3Uzs4t3vpNn-fmgvxNxDqF0vhqcmUhykg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] bpf: Avoid faultable build ID reads under
 mm locks
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 4:44=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 5/15/26 3:40 PM, Andrii Nakryiko wrote:
> > On Thu, May 14, 2026 at 5:53=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> Sleepable build ID parsing can block in __kernel_read() [1], so the
> >> stackmap sleepable path must not call it while holding mmap_lock or a
> >> per-VMA read lock.
> >>
> >> The issue and the fix are conceptually similar to a recent procfs
> >> patch [2].
> >>
> >> Resolve each covered VMA with a stable read-side reference, preferring
> >> lock_vma_under_rcu() and falling back to mmap_read_trylock() only long
> >> enough to acquire the VMA read lock. Take a reference to the backing
> >> file, drop the VMA lock, and then parse the build ID through
> >> (sleepable) build_id_parse_file().
> >>
> >> We have to use mmap_read_trylock() (and give up on failure) in this
> >> context because taking mmap_read_lock() is generally unsafe on code
> >> paths reachable from BPF programs [3], and may lead to deadlocks.
> >>
> >> [1] https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@l=
inux.dev/
> >> [2] https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel=
.org/
> >> [3] https://lore.kernel.org/bpf/2895ecd8-df1e-4cc0-b9f9-aef893dc2360@l=
inux.dev/
> >>
> >> Fixes: d4dd9775ec24 ("bpf: wire up sleepable bpf_get_stack() and bpf_g=
et_task_stack() helpers")
> >> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  kernel/bpf/stackmap.c | 109 +++++++++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 109 insertions(+)
> >>
> >> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> >> index 4ef0fd06cea5..08f7659505d1 100644
> >> --- a/kernel/bpf/stackmap.c
> >> +++ b/kernel/bpf/stackmap.c
> >> @@ -9,6 +9,7 @@
> >>  #include <linux/perf_event.h>
> >>  #include <linux/btf_ids.h>
> >>  #include <linux/buildid.h>
> >> +#include <linux/mmap_lock.h>
> >>  #include "percpu_freelist.h"
> >>  #include "mmap_unlock_work.h"
> >>
> >> @@ -158,6 +159,109 @@ static inline void stack_map_build_id_set_ip(str=
uct bpf_stack_build_id *id)
> >>         memset(id->build_id, 0, BUILD_ID_SIZE_MAX);
> >>  }
> >>
> >> +struct stack_map_vma_lock {
> >> +       bool vma_locked;
> >> +       struct vm_area_struct *vma;
> >> +       struct mm_struct *mm;
> >> +};
> >> +
> >
> > tbh, it feels like this should be provided as some sort of primitive
> > by vma/mm API given how common it becomes when one tries to work with
> > VMAs efficiently (in terms of avoiding unnecessary mmap lock)... but
> > that would be a question to Suren maybe
>
> Shakeel raised the same point in v4 [1]. I don't know of any potential

PROCMAP_QUERY and BPF's VMA iterator?

> users of this pattern, and refactoring this into a generic mechanism
> now (with only stackmap using it) seems premature. Although I agree
> with the premise. Let's see if Suren has an opinion.
>

we shouldn't block on this generalization, just something to consider
for the nearest future

> [1] https://lore.kernel.org/bpf/agYzuDIJszA_7rp3@linux.dev/
>
> >

[...]

> > why is this only sleepable case? the only difference between sleepable
> > and non-sleepable is the use of build_id_parse[_file] vs
> > build_id_parse_nofault to fetch build ID, no? Other than that the
> > algorithm of locking VMAs is the same, no?
>
> There seems to be a difference in lock lifetimes, because
> non-sleepable path may run with IRQs disabled. Right now it does:
>
>     bool irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&work);
>       ...
>     if (!has_user_ctx || irq_work_busy || !mmap_read_trylock(current->mm)=
) {
>       // fallback to IPs...
>     }
>     for (i =3D 0; i < trace_nr; i++) {
>       // fetch build_id ...
>     }
>     bpf_mmap_unlock_mm(work, current->mm);
>
> While on sleepable path we always release the lock before parsing with
> the new stack_map_unlock_vma(), because build_id_parse_file() can
> block.
>
> Not sure how this could be reconciled in a common lock/unlock pattern,
> if that's what you're suggesting.
>
> For me it's easier to reason about when sleepable / non-sleepable are
> on distinct codepaths, although we may be able to factor out some
> common helpers.

The problem is that the rest of the logic is not exactly short or
trivial, so it's a bit of a liability to have multiple copies of it
across sleepable/non-sleepable implementations.

But never mind, we don't have to do it right now.

>
>
> >

[...]
