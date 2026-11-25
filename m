Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795584921;
	b=nDjL/7Tebh8XL+WE5viVqBJFuOuHq3LmWdiKhRSHcquAWFkMEzzGQiiQH7b9ueWHCors
	 Y4MLd7F/hFoiKfFZgPbenclT7OfEzGO8gxVucao5xgs37a6EEZ+3E6uwkImTq11qOgXFf
	 l0QD7N9p3lcJIOgro/oBqq/8tKDm3e5Z18HpzW3qUvruF4UDqFXdVWJhFt72SxZqr07EW
	 yPKnBbvXwigfRhlODwGtfQf6XGVm0EZuwi29TucFHFu+tUNa7SsycW8kh0jhJlijVuf9H
	 Sp1yIoBrpmRG0NSYZeYzrSh7RQyukUdNcgcf1zccJrj7kTNnQk3UyeZEHjgSQi+IV4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DIXlRqv/2z9juZ40YrnkT5CgsYY3lUKcwDePl9HeFiQ=;
	b=IDZ41xIZ/r6+o/ZKrMbVclVk9b62yjO8kx9n84ALScaM3vlqbI1JAcl4LucS/nzSVcWX
	 QziEdP4x8vzX3RYIA9KINSeLdamKHi6KiyJ7lHPefGniVj+uPca9+uSY+CydA+JwHdQuv
	 CapiHAMdcmIhbMe2sONvjCPSk3KkQZUm9gIrNyzulMdvIen3/c/PHguNC4GKw0wrLUZcN
	 0xgNu/h7ebyGs5unEUFm1yd2oqWqZVv8zIh7JHDjFxoNMj4HFZa3lvkn8epIJZ49MGJ7x
	 cbwVg9lAbS7V0P2/kp26BDwi9qYrzbXnId62HSH9HRMC66pTk/W+Un4OqSz/wUlpGTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9EY6P+m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7C5606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A7C5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o9EY6P+m
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a9be758734so3312352f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795584919; cv=none;
        d=google.com; s=arc-20260327;
        b=VUv/7LeJudHPMxlRDSAy87SEduSOTuSYLjk2T95Xl6Fv6GcevTuNY54pS8aWZ1Zsls
         b6c32+tQSsieHLiUyv2OPLUW0xmuBLJE2AMeCkd3mP8EpP/8D40hFasAltfi7N2HQNZ1
         59qW8rOhjSotYKeaxH+RDS1dzs939BTaPuiE8Wle53l+zUw0VAfgD2jFKs46S990St7q
         ZlCfXmrpeD8FjFK9pny4PyNbwKcd4BRJ7qR2x998y+/T1cShrwlI7dcD0NotbOCThdLh
         hvJOYnVNs8K62owC63L9giwt0NhgDXOICFLCNhy5MtRbz79zwNr5QRjFkwkaESRKUVck
         O7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DIXlRqv/2z9juZ40YrnkT5CgsYY3lUKcwDePl9HeFiQ=;
        fh=AIB1Cdu/Mj1sKIx7kqH3xjTyubKW5ZxwK+dPnWodCPI=;
        b=P0Ratqh/iVlrbYN9c55HFEsp1aEAbbbpB5Mtz/9hb+ipMbZ3Rs4LcJQCr4J9Ipi3DD
         ZfA8hIfIUBaS75iN/YpBJ4zCmGwOp9Au8pXeM427OLVhj9Z5Gh/lzQLJqfK6qOMtib6Z
         LkT3dvQiEQb8/fYb9jRtvKD8CR6Iy/X/Vz5P3fSk639wu/WZ2C760d8GA2sp4+W8hhde
         Fv8yJLEr6oP9CHnVBuTYHac+DVniHxo+XpmNsTfw3bzZ2Tp5gEkMzRpMYQuWRWnvpgTe
         c1pzGsfLFBONmdmd3VeTZROI4L0/rmMQybBx2BBMdYCMK1H94XIosInHJssAgzPY2X/u
         2WCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795584919; x=1796189719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DIXlRqv/2z9juZ40YrnkT5CgsYY3lUKcwDePl9HeFiQ=;
        b=o9EY6P+mlgR+Kct33Mf3oZ0z1Oc0os21EYW2QyzW2/KNaGbvnLvNQ8sbCG5zDp9ueM
         u74Zm24oxxRQMNK8hqfFaWEdJFH0cN3a1TcZczjJ+aIs34Nsl6I4SwyHwsjmQQ9F0x+J
         OK6h9X81phhEYtjBsFd2navN8SjSL+p0LFwLU6L4ln0fwBt3dCRFnn3mfiHM6Km9sSgH
         JmscklCVftyGv/9ZF0tvRlyZkOao23jFBabCKvBC/8mdzxVOGENVkH3HPv3veqfyKrdW
         J9O+RFR7TCiRwUn5t+45pLuktAgdua12wVTdocQvIPwTjpkpwZIhpwOLoTqMOz3yzhLQ
         ERjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795584919; x=1796189719;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIXlRqv/2z9juZ40YrnkT5CgsYY3lUKcwDePl9HeFiQ=;
        b=ujQTIW+W9jmkT++vuCGeAyN2JmO/9Ue1JkYc+A47KIuT4ipFzZETHm0yzQ3Oyvtpur
         kX0JhMLLkmMsxokjuUbZ/b6O5WSlYBbZiq38dTE9D3WrmBuHB5a+TTtU1guTa5KBw7ya
         Vr7WyCm+2KQ1NaZzLk/V7fajsBbMZdwTpAGN992Ui/BIL09GdDi40yjr0W/NV9SzfpTj
         jBtYv5HPil9WWnkw0lRKK++NHmpXj/Uq+pGlxTaOscUr8RAOM3z9GBiKL49xhD2JD/Cx
         bbV47q6mwS2nuCnQ3TZzs9TVdTbXt66vzYciA3/R5UejM0G587YfSrgwiSaSqkP742GR
         FoEA==
X-Forwarded-Encrypted: i=1; AL+hErH8SFnk+kElsX1sm0R46+2233HuP3TWzGW9PO74OZ0IX6iM0d2xi0K/Hndqn7Fh1t1kL98=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zArdrViIb3si0+bkNd8CYGAC1qyf4aKjKIGx8O4xeXQcwV482
	rFEqLaLnPyIXg8nhDRiwmVKW4oUb9SwvFi343q9guwscfZj3dGanpGQovJhyYHmRaCUghhmD0Oz
	46Ipyq1cHaUH0gPerXT+YdQ+z12drQY8=
X-Gm-Gg: AZFdTZda58EwJqXfgewi3qt2XIZkKteJ0O7ZQllz/MFKb0Jgol72gQCUojWvkx6Ye/u
	xz0QLdyNBOOhLO9lp7Kle004+zf5vTMFU4wdXJH3Tc2nVePJ78pZucobe6L1ljJEbtYEAJ7je33
	4LAoLD0p3qitJamddlBJIWsEcfuPLNEEn/Q1sUuQkUPpbLo9iF57XhG9FsfJfrcTA07s8JNHdVn
	lhftAAL5k9xXy4NKRNEf0SbWX2q4fzC+CZGDwyzowhmpS/Ach2cXrwUjK7p3QRvYxhJekk5JPou
	TOCEJQJH/rEYlFwyuyhTyP/E2s0fNJHDExB6Kic8+p5kbyX3B9BbhmzCubCdk5W7qkxK61K9uwh
	pn2RoD3/WKU4tYm7PPqCi8yUHubi5KN0cTm5yzoe1fYJYIrHr4YFXgqZiq7aMHZELr/XGw9xaVK
	98db5T93p8ykN9ktFBd3cEWW8Tt+q2fKBSvpt/p0c=
X-Received: by 2002:a05:6000:1788:b0:492:3176:3d6f with SMTP id
 ffacd0b85a97d-4abb400aefcmr31101621f8f.47.1795584919374; Tue, 24 Nov 2026
 21:35:19 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com> <CAEf4BzavErcSOZhGobqEo68d+2bCnJ8vFxxT_vqb+oQw1j1d7g@mail.gmail.com>
 <DN3X5OIRXSWR.2Y70DWFMPDXQF@gmail.com>
In-Reply-To: <DN3X5OIRXSWR.2Y70DWFMPDXQF@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 21:35:07 -0800
X-Gm-Features: Aa3M54pxoPCdtejSbeLTFS7uA2H68O1zStyUPispdlpA_6QwbCBs5gPBT8bsyj0
Message-ID: <CAEf4BzYxBM3R1s6XDSpN5htzMho4Jp2uBsx9ZBKTPNBvmEffxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: mikeba@sentinelone.com, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 6:00=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 24, 2026 at 01:47 PM Andrii Nakryiko <andrii.nakryiko@gmail.c=
om> wrote:
> >> +       for (ctx =3D old_ctx; ctx; ctx =3D ctx->saved_run_ctx) {
> >
> > do you mind checking if unlikely() around ctx improves performance?
>
> Mike,
> pls try it on respin.
>
> > So basically to opt out from this behavior BPF program would need to
> > stop using any per-CPU maps and just implement its own poor man's
> > per-CPU storage?
>
> poor mans's per-cpu with bpf_get_smp_processor_id() shouldn't work
> as an opt-out. See section 6.

it's hard to weed through that verbiage in section 6, are you
proposing to mark "needs per-cpu protection" if BPF program is calling
bpf_get_smp_processor_id()?

>
> > And even using SEC(".percpu") would still be detected
> > as per-CPU usage, right?
>
> This one is pretty much brand new, so there is no data to make
> a decision. I can see arguments both ways.

.percpu is backed by PERCPU_ARRAY, so we don't need any data to say
that it will trigger the protection, do we?

>
> > Should we give a way to opt-out of this protection explicitly while
> > still using per-CPU maps?
>
> After looking at the data, I think we shouldn't allow it.
>
> An opt-out is for a prog that protects its per-cpu data on its own.
> In the v1 thread your example was stack_trace_scratch in wprof.
> It doesn't work. wprof is broken today, without this series.
> An event gets args or a stack of another task. wprof 8dd41e18 on
> bpf-next, corrupt events / all events:
>
>   -U                             what's wrong  lazy      full
>   -----------------------------  ------------  --------  ---------
>   u:func (arg:0, arg:1:str)      args          1928/16M  9111/17M
>   u:func (..., stack)            stack         683/15M   3419/15M
>   raw_tp:sys_enter (arg:id) and  args          3491/48M  16673/44M
>   tp:syscalls:sys_enter_openat
>
> utrace_scratch has no protection.

yeah, I was lazy :)

> stack_trace_cur handles nesting, but not preemption:
>
>   task A                task B                task C
>   idx 0, st_cnt =3D 1
>   preempted
>                         idx 1, st_cnt =3D 2
>                         preempted
>   put, st_cnt =3D 1
>                                               idx 1    <- slot of B

yeah, this is true, just a stack-like approach doesn't give 100%
guarantee (though in practice it has been good enough so far, though
perhaps I just didn't heavily run into new preemptible kernels), but a
better approach would be to use bitset + find first unset bit
approach. I'll play with it.

>
> With -S offcpu task C is wprof_task_switch. Then the utrace event has
> a record of kind ST_OFFCPU.
> uprobes have no protection. That's what an opt-out gives to raw_tp, tp
> and fentry progs:
>
>   -U, lazy                 today     preempt off  opt-out
>   -----------------------  --------  -----------  --------
>   raw_tp only, args        0         0            2849/45M
>   raw_tp only, stack       0         0            4081/27M
>   raw_tp and tp, args      3491/48M  0            3166/54M
>
> The series doesn't touch uprobes, so wprof needs its own fix for them.
> The default mode of wprof, without -U, is fine.
>
> Now the bigger question: do we need preempt_disable() at all?
> We do. Without it progs of 17 out of 69 projects in [1] corrupt their
> data. 12 of them have progs that are clean today.
>

"Can corrupt in rare circumstances (in practice)", but sure, sure :)

Still, choosing between handling all events and having bugs (fixable)
of handling per-CPU data in my BPF program, I'll choose the former.
Even if we don't want to make that a default, that's fine, but please
at least give me a way to opt out from the kernel's
over-protectiveness :) and not using per-cpu maps is not a way to opt
out, it has its valid uses even with preemption. Think about simple
per-CPU stats/counters updated with atomic operations and aggregated
across CPUs in user space, periodically. E.g., I believe BPF
selftests's bench uses this approach, why would it need preemption
disablement just for this?

[...]
