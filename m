Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D5C23BD06
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769193629; cv=pass; b=lmjLZKIs+hR+jRBpOh1o1u81fcDPP44I2JN14pe2GTDBPSjawswul1gMZQWQQ+4bn3AurJBzZkZkAk+v3r5BuyHEEJVmxEgYcf0Q7eN5+kR455CbYAWGW6J1CBqOOFQkazYNYXzdqylkAlI2VS7cSWQUMUisROb9sKJDGdtjIUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769193629; c=relaxed/simple;
	bh=9q4mimbXORirokos5L1QLvxfE3Z5VpoFjEUFamGhitQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+fuWrkHjn2K4kbqWM60Fx1qrIh/Wzp+VvI3pd+vpYyO/XAwBOpnF/J4klwjvTApVaZv6M/CYyb243FyS5N/HCjfMiYQ1b4c1XnZcXNKXu2EsvHC4F8ryYNP2GiCdUHdwAB1OF3WI5ooonR2rt6bVhZf/7H172A/lKHgK+ODuYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG55c+zS; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG55c+zS"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29f102b013fso23380305ad.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 10:40:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769193627; cv=none;
        d=google.com; s=arc-20240605;
        b=OaH3Vzrow6cF1aL25GDQdIDWUoGNSbXJsMw/+TXIY3vJlyniolKC49TOQDJpLaH/ww
         bDF3GbBVCkjj5ERoAFJGpCPkbYbJ2Ks8wAZXrj6mFrqtulcO+MpyPZ4/xTlqWTvmGZA3
         oFjpBFJ6IwEb+jYz/Kde6V2Ikzr8Ehfl3wZikiuvfGq4xraHCbUF/U0VGCAB5qKn/t86
         SugIaqKdMewRlH1TifqkgxQ9bbYKZqHrZeW1piMcVg42Ma3kCXFGoWNcRDc9A/87Sf1X
         Uo+hjt73Qvu1NKlnPuRkBFUYIXDDg/F2NprKhmx+/wc3js4wkYWkFJP/vO3n57RKFsMY
         LFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=40SwQh/No31of3qGMee9ATI15Dgrf8z7NoPIMLwQa5c=;
        fh=jgR6gZskU0nIN3A8XcipgUdLow7AYm2wUuNVF2/3JjM=;
        b=MgglkmmBGu7T1k4tYc9XEDyj8V/Fl6BdiD5OTQ36x4P07RSxHI4LO/rIYllT79d96n
         dYK3i+6qy8Dafw3G9tG+bbvTXvGYMW9j9II0Zn/8c/hvJwh29XWkhV2ktU0g2gOSZDsN
         D1uM953yPJdioizTtYdRzRIh5cijfrxOfLMjtJF/tFioKtNDVyyh1nz6Pe5+ChcIno7j
         yNq79jYdEbTCceaubFEtgpHeEKf4FHI3WL1eu4cBkTLMwMLYHJkIqKEIrhbt4b/yw+NI
         2xvoVpedE/p9Y+AN+pbsWw3GEZSXu9w5dFJdU+Qacanso8JbOT7yJMh78++v4oj1OaqI
         F13w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769193627; x=1769798427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40SwQh/No31of3qGMee9ATI15Dgrf8z7NoPIMLwQa5c=;
        b=OG55c+zSVibs3dIx63zT4a0sIURj+Lwzg+p/q635/1h12EzSxO0dB5u6UvrygfhKQU
         fCcyiUzpsIDiR4cJn5b9N34JeMlQDnHzLSNB8NgX7F9a/dBsabljTGjUSCa/uIn4zlzI
         NR2FTEBG5qpdvmJ91Jh3hGRZMVEgxaYg+pbf6UIHXIj49HrGxtX8tk9HMaVzg6fMbwdb
         W5bkM70yqu5l6k0lxGS58eRVLBvjWo2XWRPazfpKSfxCU1q1yJ7Ke0fjgM2o06dZjRsM
         oLKjqaMfxlheLnCVfvFu9bdTSAFxQjk62Fu1CxYvULGMrVjvEoWdFSlusKrUrjgJRJQS
         bvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769193627; x=1769798427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40SwQh/No31of3qGMee9ATI15Dgrf8z7NoPIMLwQa5c=;
        b=DAt+JemtKD2B2ISmNiyCLG3nPhFd8f8PxYB7/8DWPSLAHp/6ZUyouGLkUKos4bkVGx
         /2IxnzXgA5iGJTgipUobhWVJTHu+nGRBoX5x/T/trjF0Sy/agu6+/6jNzR+NW7LnOF7n
         l1wm63vulmodLV3SGdFpkdVePM2oFqe5+vBk9p2mvYAWaDGx71l2qu1n0Le9tSfkbsza
         kye5mvlsULxYcXdI0jwSCUhQWkc7Ey0Yll4Kir2qVxM9iriAYHDDf/zlHlwnYNKqLojH
         ou9WfzyaiHr79zAOBEwABifr+JBDeq3vcyOIi83d0l3M2a/0reapyPa3eTUiybSDsqau
         zHtA==
X-Forwarded-Encrypted: i=1; AJvYcCV9/X/oyXVKpinMK1UdV90HTfTLUCDXkNR2OIoIvhOpr0XU6iNolWmpH5dX6Mfg19xUte4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZOVWy+haUZX7QLWWxaEkKKaF/z+n8GEcCv/mj+A/MqhwQY1cm
	WWuRNy6f7FNdCSARkM/aeB8RRnjgfNFDMxV97YQ/Ask1Rbn1YHDlHtMPxg0p2ligqLlS32YtKJW
	l9fE1H2CAmPKDg54h5EqE0DGLip95XFE=
X-Gm-Gg: AZuq6aI3aAXlcISeCDelbrk7zD3bZYRxWyrrcho8Clt6OlHZRsMG8wj7/OnhBU/sH5U
	AuUmLFenEaz3bJ9jW3XInyRBlQUGxl35bQg5ex5lm6mvjSOzxTLJpF50IJa+/CAvd7mEg3lUpRD
	759XFbSn+RDGPpiY6sjwEkjlZ2gpM4rsaUY1nTrzR0TG0TAvTCoFNBHkA/DF0t4+8d3ksHJg7/R
	IXWav2Dsg9VNrM5ELrn+st0Ozszeo/UPe1wCZnEdAaRZvC2fhlYl52NedrdllN2Z+gYywVp8mp2
	bIpf49b8g94=
X-Received: by 2002:a17:902:e851:b0:29f:1bf:642a with SMTP id
 d9443c01a7336-2a7fe43ee93mr33047475ad.12.1769193627283; Fri, 23 Jan 2026
 10:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217093326.1745307-1-chen.dylane@linux.dev>
 <20251217093326.1745307-3-chen.dylane@linux.dev> <CAEf4BzYEsKQxT--=oQELZ7g402FWpEuDEmxcovZXkck+k2U8HQ@mail.gmail.com>
 <a65cd17e-75a2-4fd3-ae10-bd5b3fe06c4d@linux.dev>
In-Reply-To: <a65cd17e-75a2-4fd3-ae10-bd5b3fe06c4d@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jan 2026 10:40:15 -0800
X-Gm-Features: AZwV_QjioUl3t9zLV82uK8h0iCWY7fqLt9ZS76N4bgcC4L1WKapxN0cX_Kd2Sm8
Message-ID: <CAEf4BzbbxpDmvJrV6s3dupP4Ysx+vVaHYBk+KNZtthag5OvosQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/2] bpf: Hold the perf callchain entry until
 used completely
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 9:42=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2026/1/23 08:38, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Wed, Dec 17, 2025 at 1:34=E2=80=AFAM Tao Chen <chen.dylane@linux.dev=
> wrote:
> >>
> >> As Alexei noted, get_perf_callchain() return values may be reused
> >> if a task is preempted after the BPF program enters migrate disable
> >> mode. The perf_callchain_entres has a small stack of entries, and
> >> we can reuse it as follows:
> >>
> >> 1. get the perf callchain entry
> >> 2. BPF use...
> >> 3. put the perf callchain entry
> >>
> >> And Peter suggested that get_recursion_context used with preemption
> >> disabled, so we should disable preemption at BPF side.
> >>
> >> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >> ---
> >>   kernel/bpf/stackmap.c | 68 +++++++++++++++++++++++++++++++++++------=
--
> >>   1 file changed, 56 insertions(+), 12 deletions(-)
> >>
> >
> > I took a bit closer look at these changes and I'm a fan of the
> > particular implementation, tbh. It's a bit of a maze how all these
> > different call chain cases are handled, so I might be missing
> > something, but I'd address this a bit differently.
> >
> > First, instead of manipulating this obscure rctx as part of interface,
> > I'd record rctx inside the perf_callchain_entry itself, and make sure
> > that get_callchain_entry does have any output arguments.
> > put_callchain_entry() would then accept perf_callchain_entry reference
> > and just fetch rctx from inside it.
> >
>
> Hi Andrri,
>
> Try to implement this briefly with code, is my understanding correct?
>
> struct perf_callchain_entry *get_callchain_entry(void)
> {
>          int cpu;
>          int rctx;
>          struct perf_callchain_entry *entry;
>          struct callchain_cpus_entries *entries;
>
>          rctx =3D get_recursion_context(this_cpu_ptr(callchain_recursion)=
);
>          if (rctx =3D=3D -1)
>                  return NULL;
>
>          entries =3D rcu_dereference(callchain_cpus_entries);
>          if (!entries) {
>
> put_recursion_context(this_cpu_ptr(callchain_recursion), *rctx);
>                  return NULL;
>          }
>
>          cpu =3D smp_processor_id();
>
>          entry =3D ((void *)entries->cpu_entries[cpu]) +
>                  (rctx * perf_callchain_entry__sizeof());
>          entry->rctx =3D rctx;
>
>          return entry;
> }
>
> void
> put_callchain_entry(struct perf_callchain_entry *entry)
> {
>          put_recursion_context(this_cpu_ptr(callchain_recursion),
> entry->rctx);
> }
>
> And then no need rtcx in bpf_get_perf_callchain.

yes, exactly

>
> bpf_get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>                         int max_stack, bool crosstask)
>
> Functionally, this seems fine. The only concern is whether the perf
> maintainer will approve it after all, this change involves modifying
> their core interfaces.
>
> Peter, Yonghong, can we do this?
>
> > Then instead of open-coding get_perf_callchain by exposing
> > __init_perf_callchain_ctx, __get_perf_callchain_kernel, and
> > __get_perf_callchain_user, can't we have __get_perf_callchain() which
> > will accept perf_callchain_entry as an input and won't do get/put
> > internally. And then existing get_perf_callchain() will just do get +
> > __get_perf_callchain + put, while BPF-side code will do it's own get
> > (with preemption temporarily disabled), will fetch callstack in one of
> > a few possible ways, and then put it (unless callchain_entry is coming
> > from outside, that trace_in thing).
> >
>
> Exposing only __get_perf_callchain will make it much easier for BPF
> callers to understand and use. And following Peter's suggestion, we can
> mark _init_perf_callchain_ctx, __get_perf_callchain_kernel, and
> __get_perf_callchain_user as static, then have __get_perf_callchain
> encapsulate the logic of _init_perf_callchain_ctx,
> __get_perf_callchain_kernel, and __get_perf_callchain_user. What do you
> think=EF=BC=9F

That's exactly what I proposed. Except I don't think we even need to
have __get_perf_callchain_user and __get_perf_callchain_kernel, keep
__get_perf_callchain almost identical to current get_perf_callchain(),
except for getting/putting callchain entry

>
> > It's close to what you are doing, but I don't think anyone likes those
> > exposed __init_perf_callchain_ctx + __get_perf_callchain_kernel +
> > __get_perf_callchain_user. Can't we avoid that? (and also not sure we
> > need add_mark inside the ctx itself, do we?)
> >
> > pw-bot: cr
> >
> >
> >

[please trim irrelevant parts]
