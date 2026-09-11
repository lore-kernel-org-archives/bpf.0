Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC230AAD8
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171072; cv=pass; b=fx2o0f2y7dM+2q7C9sBmAaxIOca/PM6fAB5iMjLnWPJBHqmNdOKjW19cA+Npw5CruJpDDAcvs/F4F2bXUL83bwZh1mwHVyhHr3SZ9FcFtXjsj3VldlBhVRf5ppp6+XJtLC7BRPZT1a9xR28qT9J+DoT5ruV3+b+aJalic0Wf+bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171072; c=relaxed/simple;
	bh=qqigLyivTHcdKKZGfiLkYN4G+hVE8x+JZnyaeqGuNMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3Rl7SBy6TFDRxUuu8glHmrpanqYlBdTNah6JzZOePOdJaCtpqdFK8ILsRE9IDe2desp4Y5bBETFuFaLBjwzYVXSIwyaFTj7/guiNM+GFuHW9iKR7nzl2Lt7fdh34K6qsSMQXIa/kCZSHosmPFM5zPSvWJoO3j9kIBn3Fv8jmPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAWCrmzC; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAWCrmzC"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so93579a91.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789171070; cv=none;
        d=google.com; s=arc-20260327;
        b=r2oLlfxvmPBJl5JCmmF8KMTMIxfbinXKqpg0gEKSRMuJVzjMQGw1RIrwg6nn3m4CzW
         qUYeG5fCqVw+kMjvfy/K6DDZiSo2fMwP+QM0RpFdKQAT4Y9agvtUwsnFLE1ydnjDczCG
         ZpqXtordnqII1ueMdZR6W9KHYvm9EjuxI2PbUCOjIJ+UVaoTugh+VZ4t+d2jgeQuIv41
         MbBdwTWAvRJIfFry91gUxW4T4NBGjg7A612xg3lcw3G/yblxz4oPVtOUI8XUuNeLARvE
         uVVPelHqktbwTI7gVEh9keTaHKLpNlH8rJ64aC99OFhD31VYxoFdG3Hfx9p68VFgGqGR
         T5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gxc9M8k5JwrSYuIthq2l7dyP0LawxROGQw8raVTurqA=;
        fh=A2o1Vx4ZLd+A2Zx0NvPI/qz//F2+c6xPgeap4Yu/3O4=;
        b=alB7zZDf1SBEk1R9d32J8dwX3f3+DSWvP7CrKBfxp/1EOThhaH/YB6QCvcVEorOi+C
         ZqRhnKlkyqIfpDCPXAY8izNxGlSO0hAZhpiT2tmb9Qp0gbFmvfoly5Tu8gadgNoa9bhg
         Q0izV1jSpAAwu9RD7YS9XZvbSbupgCiYG59Qi9NWU7jgho21jLsP+Xp4NzohpZbqT6hG
         kmb/17bZfZBHcYUbFdhmgv37p4761NrYHxxDUl8FfTG9Lwmzk9Qa6EaWXp344IeuUzlp
         q49bmypxZgzssXPHipwz0wNGycoZFQR/5srpUV0eDjisawmtQ1tA3HNkO8JFLyzOwHff
         paxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789171070; x=1789775870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gxc9M8k5JwrSYuIthq2l7dyP0LawxROGQw8raVTurqA=;
        b=HAWCrmzCqs5heGST0sME0bukt02AUNyluggDHYsxwuF5LXgzxdArBo1gX31UOOiBoR
         6XsdfJt4h+eKA3lUm+ILa/nvD19kx1wxGa/DLL6B1Nc/C++1XyVtCpwpEBbHHQtC1ndx
         hzq8xysX9c7txb0a9kLie9f63l6intSUpkFNPZJcbDUk+ndWdI1gmkzhB/8jf1Fkq3+c
         wZDxz5e+iQVzwGZ5h8xLl2JatqcSsI8g0rJM5GlalXZHDo6yQfi6LO2qPKtx4hG7DVDC
         0KvCHrE+x+o9RxRRIrq5uuVt+N828Xi3Ui88bJ/1+p9P1UctpGRqKsWt2TNv3WGPr0IZ
         xLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789171070; x=1789775870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gxc9M8k5JwrSYuIthq2l7dyP0LawxROGQw8raVTurqA=;
        b=WQYE4HjeUXVRkiSFYJjuT3jXv/H9DjXiHlUNPpJZs2nUp1SbUc39oa8Ui7v7H+Z/Lf
         T+fs97O7pc/XWND2F5qJfEVKP1qBAtIynhcvUP2b0r8+cFnaBWwlLMgBR1wrFD3NGBkC
         zoQhXBEJ6Z1IFHsRIGl3Km71vDgQofkgsopmFZAi7SvNbrMaWAHkRgSe3L+L222PHmVK
         XwMM7HFUyK+OT8ranosDFz4tdzzeJ6LlQdbuUrbvi2pzwBVq4uibHbG4oTplejZB2yIc
         cVV7ftmCUqGBiWPW4YfFfmlhV9PuskBbGOyYHAuf0/kx2lWZ12TXsF6DNFwGv8kIQGRP
         IjMw==
X-Gm-Message-State: AFuF++n8Oh9kuV9E2Vnf5BhjV/JC6HCgAJYC7fhUFAXXFpxA0iDugLc/
	HHz235DCu7okP4iL3luTFtOgEbJY6qv+vGWY5ZnsBrgcTbodM2+YkBf3BvA9jSyu67UctvhfjYS
	giaHOdFTSDI3gPPJV+18n6BJjBp1X8Tg=
X-Gm-Gg: AYBFou2UMe2qSHKaHIp9ogemZi/DHh8JCavX1hjqCh0odEKAeQusW8dzvdXxW2MaFc4
	gMCcmoYLpKId8XCOBNhVUKgo0cg3tfIJNraDwpea7FC3uFjHYxG5D+SGfyZoJr1oABmgU3kXEKj
	0q4H12gziDXENxyDJzZEW4rz7+QL3Fz4StOaBytuNz+7cFtWZ+qTRLJ7KSnNtpRZLi1iPbIK+lA
	RwaGgu3avixjUl2Fupj7NMl331Hx1htCZ9TXVmNA1R+m8u8x5xq2Frle08KBiuIoeN8cTAmbZ/R
	FCjZTIaD8qR/V2HpCg9EJCGjZMFaGv0kmBAPp1bpeCAvh7GrW7Qaan+tQlkXZsWrJZINzEOa1FR
	fxnvonMd88sqe6x5iGZKE9zXEmqM0VLpYhQRU
X-Received: by 2002:a17:90b:2dcd:b0:398:dcfe:967a with SMTP id
 98e67ed59e1d1-39dbc6d53e5mr844965a91.17.1789171070054; Fri, 11 Sep 2026
 16:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
 <20260908-bpftool_cyles_per_run-v3-1-60e86f325c35@meta.com>
 <CAEf4Bza_4ihFJyOJrJKRpiCvU3Mr6KXLVM+5fYnmb9ydNELOJA@mail.gmail.com> <74544b6e-205f-4878-8d7a-d27fac7bd946@gmail.com>
In-Reply-To: <74544b6e-205f-4878-8d7a-d27fac7bd946@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Sep 2026 16:57:37 -0700
X-Gm-Features: AcwNN1Wmw2DSCpI3C8sUP41XPUPDnV-WY0cjGS56EDeRMBXj3DVxVsba6ANHv74
Message-ID: <CAEf4BzYhMGP5Bcj-qnyTqLAXnZDs3JGsVqVg+-XB9pqEvNKfjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Track perf counter snapshot state
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, namhyung@kernel.org, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 2:19=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 9/9/26 12:56 AM, Andrii Nakryiko wrote:
> > On Tue, Sep 8, 2026 at 7:27=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> A perf counter can be zero at fentry. PMU multiplexing can schedule th=
e
> >> event during the BPF program. The old counter check then drops a valid
> >> sample.
> >>
> >> Use an armed flag to track each successful fentry snapshot. Reset all
> >> flags before new reads. The fexit path clears each flag when it consum=
es
> >> the snapshot.
> >>
> >> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>  tools/bpf/bpftool/skeleton/profiler.bpf.c | 25 +++++++++++++++++-----=
---
> >>  1 file changed, 17 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpf=
tool/skeleton/profiler.bpf.c
> >> index f48c783cb9f7..6c654bd9b346 100644
> >> --- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
> >> +++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
> >> @@ -10,6 +10,11 @@ struct bpf_perf_event_value___local {
> >>         __u64 running;
> >>  } __attribute__((preserve_access_index));
> >>
> >> +struct profile_reading {
> >> +       struct bpf_perf_event_value___local value;
> >> +       bool armed;
> >> +};
> >> +
> >>  /* map of perf event fds, num_cpu * num_metric entries */
> >>  struct {
> >>         __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> >> @@ -21,7 +26,7 @@ struct {
> >>  struct {
> >>         __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> >>         __uint(key_size, sizeof(u32));
> >> -       __uint(value_size, sizeof(struct bpf_perf_event_value___local)=
);
> >
> > this is not a bug, but... ;)
> >
> >
> > struct bpf_perf_event_value is UAPI, why do we need CO-RE-relocatable
> > ___local variant?...
> >
> >
> >> +       __uint(value_size, sizeof(struct profile_reading));
> >>  } fentry_readings SEC(".maps");
> >>
> >>  /* accumulated readings */
> >> @@ -45,7 +50,7 @@ const volatile __u32 num_metric =3D 1;
> >>  SEC("fentry/XXX")
> >>  int BPF_PROG(fentry_XXX)
> >>  {
> >> -       struct bpf_perf_event_value___local *ptrs[MAX_NUM_METRICS];
> >> +       struct profile_reading *ptrs[MAX_NUM_METRICS];
> >>         u32 key =3D bpf_get_smp_processor_id();
> >>         u32 i;
> >>
> >> @@ -56,6 +61,7 @@ int BPF_PROG(fentry_XXX)
> >>                 ptrs[i] =3D bpf_map_lookup_elem(&fentry_readings, &fla=
g);
> >>                 if (!ptrs[i])
> >>                         return 0;
> >> +               ptrs[i]->armed =3D false;
> >>         }
> >
> > this is preexisting, but why do we have two separate loops: first
> > lookup up fentry_readings pointers, and then separately a) reading
> > perf counters into local variable just to b) immediately copy it into
> > map_value.
> >
> > can you try simplifying this and doing bpf_perf_event_read_value()
> > into ptrs[i] directly? all within the same loop?
> >
> > it might have been some verifier issue, not sure, but I think this
> > should work just fine

you haven't answered this

> >
> >>
> >>         for (i =3D 0; i < num_metric && i < MAX_NUM_METRICS; i++) {
> >> @@ -66,7 +72,8 @@ int BPF_PROG(fentry_XXX)
> >>                                                 sizeof(reading));
> >>                 if (err)
> >>                         return 0;
> >> -               *(ptrs[i]) =3D reading;
> >> +               ptrs[i]->value =3D reading;
> >> +               ptrs[i]->armed =3D true;
> >>                 key +=3D num_cpu;
> >>         }
> >>
> >> @@ -76,16 +83,18 @@ int BPF_PROG(fentry_XXX)
> >>  static inline void
> >>  fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
> >>  {
> >> -       struct bpf_perf_event_value___local *before, diff;
> >> +       struct profile_reading *before;
> >> +       struct bpf_perf_event_value___local diff;
> >>
> >>         before =3D bpf_map_lookup_elem(&fentry_readings, &id);
> >>         /* only account samples with a valid fentry_reading */
> >> -       if (before && before->counter) {
> >> +       if (before && before->armed) {
> >
> > this is such an unlikely situation that I wouldn't even bother
> > "fixing" it, tbh. alternatively we can check enabled or running for
> > zero, I don't think realistically enabled can be zero if we actually
> > captured it an fentry
>
> Here we check before->counter for 0, substituting by enabled or running
> will still have the same risk of dropping the first sample.
>
> I could reproduce it by:
> 1. make PMU busy with 4 events to force multiplexing
> 2. then quick profile for 1 second
> Result: first sample gets dropped, because measurement
> at fentry is 0. This is not a huge deal by itself, but the fix is simple =
enough,
> in my opinion, to make it worth. For a pocket change we get clearer flow:
> fentry arms the counter, fexit disarms it.
> We have the same code in perf, I thought it would be nice to have this ch=
ange
> there (more choice of sparse events, subsecond timeouts possible)
> >

are you saying that you get zero even for before->enabled?

> > pw-bot: cr
> >
> >
> >>                 struct bpf_perf_event_value___local *accum;
> >>
> >> -               diff.counter =3D after->counter - before->counter;
> >> -               diff.enabled =3D after->enabled - before->enabled;
> >> -               diff.running =3D after->running - before->running;
> >> +               before->armed =3D false;
> >> +               diff.counter =3D after->counter - before->value.counte=
r;
> >> +               diff.enabled =3D after->enabled - before->value.enable=
d;
> >> +               diff.running =3D after->running - before->value.runnin=
g;
> >>
> >>                 accum =3D bpf_map_lookup_elem(&accum_readings, &id);
> >>                 if (accum) {
> >>
> >> --
> >> 2.53.0-Meta
> >>
>
