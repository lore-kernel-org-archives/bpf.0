Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792899393;
	b=GdXEGca6KQCM7D/7LX10IZawUXoKfxIwJpOOhQONN2XcXrTLEh/6NkwVf19aM5e2jSfa
	 E0FbqZnGUQcsaTIks1DJq5doyPw/KTGBeV0BO6glwduNd0lPCUva4v7FJVdqrj3oaISP+
	 UD2x2stFOvhsdBPMxGLIWYAdXxnTSFveBPaRTRcq0LNMhsTQSVw4jqFjGH46yc7G5HaTX
	 WnMYLKrsLiKyDhCRzQEgieD32pteHnKJBeI7nH2ktFQewl/nIbR1Hcj8IkkKAZIPeJonA
	 IWLYy5LWsM9iU1zPOz6DkuWCsprNuEroQNDqdBjcmdl4mYxOrUUTMo+9YHcC5uEwLWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792899393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DjKh57N4UF4L0vPTEmwKkugiAf2AMgqPZ3+VipYde0U=;
	b=glIBC78ywDTjmJOgAyGNKL0m7yRGGcFz07yeOnEJ/CNSIuwAhDZ6NByY148d4O1M3hnl
	 IUxkvIWfToMF6OoT0/4mfABlLQG6TS9iMbNZPgibzg9NsI/XDVIXfnc8UUtoMxxsLlMVh
	 di2bUt+DMjZNdY6iQ3AaWG7YGzNrjfe75HHcrcN3GfYhbG0SBPVH7wHOrK3EGJ8NsHJ0W
	 3GpgKTli3OozQQME7UzNiLusmQ9R1N5vB87uAXH5061U0uCPly5N+4jO2Urrd16YStNMw
	 tIxlfIynClnfabgu77gRXBdE4FG+auxT/5Vyyi5a3PTs3WuLflt+QjyaFBkiB4+tCyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LeZq6DBI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE4606A31A
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 03:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2DE4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LeZq6DBI
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-679a420b5afso1840731d50.3
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 20:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792899392; cv=none;
        d=google.com; s=arc-20260327;
        b=IReF0+2YxonKVoa4OuvT3Wha6oXazCSNBFONFXRizQzIBokybjFK030+qZ/mY8oB/X
         70408DSz7tn6YTFJDAzgYHe3uLmruyvU7dOu1lMJIhzI41kEKHE8FmU4qnmwRkKnMsuO
         dEanNMpSID5XnmgvG+ApPj+8Izi+jDUwDso+CktoXVZWHk9PLUUt01LH9boJ4MfjWKm7
         wRhvgxEtVJn0qIsvqvJD6nm7KeuZPWiV9w6MUcg3Z8OqQZHzIvqYGauax1dvIp+Wha2D
         wPfhSG0tW8jQIof9RJDUlsGb40DaWY4eoQ8abDBQaBLDv2ihdcb7eYM6eQEtKnD0Wv60
         jf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DjKh57N4UF4L0vPTEmwKkugiAf2AMgqPZ3+VipYde0U=;
        fh=jua6jQTLjOHMgW90imJ3XmJYIkozOdoQLZQ16Kkb31U=;
        b=oV6ugwfvKkQNbLk4Ad12z4bYSMAk/e3gjnQe7zpXsDPVF7lVT29//1qCXceHCSQwOi
         V8Kha3xwZ82Q2/1rLToCy3BRK2APgzZSXUIrRt4/x7YjLlKmfOdRcP0nRO+F09FVeOn1
         AzWdb8o6NEkhTS1807mNcJ99PMpAENs2f/+chO6QA1gZns1YSPZ4SgzcvG6M6kkmKThT
         TaMa7FfZT7F6XfW2DTZHXX+NznE0h/yHmTXXgeh1Qh26CC40W9YWgxjOILwYPY1o+eJz
         yfV1SuF3xOyZ2+Fc4OG+iyIGK3/yFlRFPuez9lBmq1uMLgWnGrRgzVPt0xexCwkVhvB2
         3Byw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792899392; x=1793504192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DjKh57N4UF4L0vPTEmwKkugiAf2AMgqPZ3+VipYde0U=;
        b=LeZq6DBIc6AySagJ4h20GcT7Y5Ym0FgUVily4RFMHswaMVmTf3cY2VMsfzdZWu5zXX
         BMZ54TNQQDoRY1tcf1OiP+fqN3rVaR6wmL4DHf0MG8QKopQ9m7zCJeQ60e4w3mfIQI55
         0PtatJeBVWpbrPngvRuEXN8B1lUohAK6psht7aAVAtvTr6/IbAhko0bK7Y3Uz/dJV4oA
         iVx5HcZylhHvvqaEdAZkz2EJyvd08hcZbpvXzoZg+L5Bh7DXf/pCz7pCkYPdfnK1I78T
         2XBdvo6GSyaPrk3LL+iGGNpUEBtFYQhyZ0omidOMAQqD9p1i1Cs0SSrzPxFnIe9EY33S
         5SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792899392; x=1793504192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DjKh57N4UF4L0vPTEmwKkugiAf2AMgqPZ3+VipYde0U=;
        b=Q4aw4WEepQq360clDjdZ2BUz1qpoZa1Xxhq6YmFekDNbvhuavauCioemL7waBY6Sx9
         al2U+jVk6ZHhzjNjSExNRoqvIna7uIpASr0CUVPEUZ1u+LmZJD8rqhcLCmN6Ib/FiIos
         kO/mT7ULxlU7VbuuVgtzNCfVTjbozZUioJie5n2AVFS/2b2W7lPn31dbxZzQaXskOE/E
         wH/5GITICaxFUVSbqjhI/A/e5MtiZz2FhiL5rkmw6QkSVcs8hMfSxxmJXkYbak2FA038
         20myiavUAy7qJ/3muZ+rXV/bG6OZ8ScFYwKmUlRYjrsFzlqHcAEB+VTPkGB0WTivQvT6
         s4sg==
X-Forwarded-Encrypted: i=1; AKwUvBzBWhChG1P2KOP4lOXIzJviJLl9+QTOV+1xh4gdjiYg+eW+JQTrut1avLws7i2AhJwTvCg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJcByRHNqmN5+T/puZSYnYsSSppPxAt/omtlllKT6OTcPLx/T+
	0KO6GMLk4aTOYIY3dGFOtWygRrA7qAhsLlP62Pp6CD8ov2ahKcoZj53g8IdL+jTKEin2zwQaNZk
	rogam9IwR1a+LeO47bwCd1XJRaW1wDic=
X-Gm-Gg: AYBFou3yLDG+yNteHQvCcdsVE5FL4mgrQOGY4XOs66SdmF5WQs2QrsTwyE4qtwW1Z4V
	ReaKjLrg43PynORHOKILRBPya8WSxBoPfWbkTxFMg82ZiE7LIkYn7Rh/kUKSsJVT+LWgBVu8K4i
	LMekimTDypaI9xOdiKDzjon57xdcYHJlChHrKguDbqXw6tgapo5XbXhvrdMWkCm9ZZeLyUNsHf0
	PxWnAhU+BuqpkPphf/8IQfHs9cOijXQpXHRux22IsB/gNCJg4hEixDakWCrmxRHu2tNJcfDBS5d
	YNKL02mhKZNOb7SfUdQJVxQImsSOAVBgHSou8K5AkYDdmXB2hDqxe7Hk0M5jMfOofh0yLDbVClR
	c0OFgsdMEz0sVW8437ad1kq5D5tGoRHRgnjpPk1iscd/dSG+3UotSPfueZL0e4SySZlI=
X-Received: by 2002:a05:690e:1a27:b0:679:95cd:1aed with SMTP id
 956f58d0204a3-67a454bdfc5mr1270836d50.60.1792899391596; Sat, 24 Oct 2026
 20:36:31 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019064157.29885-1-laoar.shao@gmail.com> <f68e7f9e-6037-4087-b7cd-a17ea4dba279@bytedance.com>
In-Reply-To: <f68e7f9e-6037-4087-b7cd-a17ea4dba279@bytedance.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 25 Oct 2026 11:35:55 +0800
X-Gm-Features: AclHuK-Ie5-cJruVMuWsByPpF2E5memGw2rPj5uhPsydhaudr0vHLSJ1wQm8wZE
Message-ID: <CALOAHbBP3n1uyC6qE-678ZNvh+12HSQ-H24xg4RqGtaZXKbL1A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 bpf-next 0/5] BPF-based per-cgroup NUMA balancing
 mode selection
To: Li Zhe <lizhe.67@bytedance.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	david@kernel.org, gourry@gourry.net, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	yu.c.chen@intel.com, zhao1.liu@intel.com, tim.c.chen@linux.intel.com, 
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:32=E2=80=AFPM Li Zhe <lizhe.67@bytedance.com> wro=
te:
>
> On 10/19/26 2:41 PM, Yafang Shao wrote:
> > The Problem
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In our large fleet of Kubernetes-managed servers, NUMA balancing has
> > been historically disabled globally on each server. With the increasing
> > deployment of multi-socket AMD EPYC servers, cross-NUMA access has
> > become a critical performance issue, which made us reconsider enabling =
NUMA
> > balancing to address it.
> >
> > Enabling NUMA balancing globally is still not acceptable since it can
> > introduce latency spikes for latency-sensitive workloads. What we need =
is
> > to choose per workload whether NUMA balancing runs at all, and which mo=
de
> > it runs in. A latency-sensitive service wants NUMA balancing disabled,
> > while a batch service wants its PMEM-resident memory promoted when hot
> > without paying for scheduler-driven migration. No single global setting
> > serves both.
> >
> > The Design
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This series introduces the fine-grained per-cgroup NUMA balancing
> > control. It grows out of Tejun's suggestion to store the existing
> > NUMA_BALANCING_* bitmask per cgroup and expose it through BPF kfuncs.
> > cgroup::numab_mode holds the request: NUMAB_FOLLOW_SYSTEM (-1) defers
> > to the global sysctl state, anything else is a bitmask.
> > bpf_numab_set_mode() writes a request, bpf_numab_get_mode() reads the
> > combined request of the cgroup and of every ancestor back. The hot
> > paths walk the same chain at read time behind a static key, so while no
> > cgroup makes a request the overhead is one patched-out branch.
> >
> > An opt-out wins and binds the subtree: a DISABLED request anywhere in
> > the chain opts the cgroup's tasks out entirely. Otherwise the requested
> > bits OR together and the kernel reads them independently, the way
> > kernel.numa_balancing reads them, so a combined NORMAL|TIERING engages
> > both modes. A DISABLED request only speaks for the cgroup's tasks,
> > never for its memory, which follows the remaining requests of its
> > ancestors.
> >
> > The cost of the additive combination is that an ancestor cannot cap
> > tiering short of a full opt-out: a descendant's TIERING request
> > re-engages promotion for its own memory, and promotion is the mode that
> > consumes the shared fast tier.
>
>
> I am not sure that this matches the usual cgroup hierarchy semantics.

I think the usual cgroup hierarchy semantics being invoked here is
the semantics of resource limits: an ancestor's limit binds every
descendant.  That is the right semantics for limits: a limit
partitions a shared, finite resource, and what a descendant
consumes comes out of its ancestors' pool, so an ancestor's limit
must bind every level below it.

A policy request is a different kind of knob: it is a preference
about how the kernel should treat the workload, not a quantity
drawn from a parent's pool.  Nothing is consumed by expressing it,
so the limit semantics does not carry over; the question is only
how the preferences of several levels should combine.

We chose the additive answer: a descendant may ask for more on top
of what its ancestors asked for, while an opt-out at any level
still wins - DISABLED anywhere in the tree caps the whole
subtree.

This also matches our operational experience with policy-type
knobs in our Kubernetes fleet: letting a child refine the result
has worked better than having the parent's choice bind the child.

So with
                      Pod     (NORMAL)
                  /              \
  cgroup-A (none)  cgroup-B (TIERING)

the effective modes are

                           Pod     (NORMAL)
                  /                      \
  cgroup-A (NORMAL)  cgroup-B (TIERING|NORMAL)

> If promotion consumes the shared fast tier, why is a descendant allowed
> to re-enable TIERING when an ancestor cannot cap it short of a full
> opt-out?

Promotion can't make a cgroup consume more memory than it may
already consume: it moves the cgroup's own folios, within its own
memory limit, from the slow tier into the fast tier.  The cost to
the rest of the system is placement contention on the fast tier,
which each contributor's own limit bounds.

What an ancestor can't do now is cap only tiering while leaving
normal balancing available below.  If that targeted cap is wanted,
the natural extension is a negative request: NO_TIERING would
propagate down the tree like the positive requests and mask
TIERING out of the effective mode.  With

                  Pod (NORMAL | NO_TIERING)
                     /            \
            cgroup-A (none)   cgroup-B (TIERING)

the effective modes would be

                      Pod (NORMAL)
                     /            \
            cgroup-A (NORMAL)  cgroup-B (NORMAL)

For the RFC I would keep the modes minimal and add NO_TIERING
as a follow-up once there is a real user for it.  If you think the
targeted cap should be there from the start, it is a small
addition.  What do you think?

--
Regards
Yafang
