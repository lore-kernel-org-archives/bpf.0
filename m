Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E4C3D331E
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180375; cv=pass; b=EaV3jaGW4yHpSzOMo+Qg2EQtoYYzsCNji/iW8QF0vBxqTv/vEdFTA3kNqtPww2HvVeenmGbUnsvc+JgWZ5apfZTHM++hHVSsoPgdxlDAVCIrHsAWnWHVrHvx9I3sULHyXSKGmXmJgRT0iB45w4XJ/HCZcgJHlMacewFqbjxrB4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180375; c=relaxed/simple;
	bh=aKy0WhmuZ0KSTA2scN/gWrfv9TWutXxLU9SljZLRv3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7B2C/e00Dkv7LZzu5tyl8iJQsQzr7jH9QO4gSExF2FwQrm5yyRQ3lY9vsMerr3vTzHMEh1RgDMZLuMCvq0+mWFKDqXhvOaqoQCoGIV3edOEnVEuDs6ykpS5hj2NHhGcd88wtmy4BD+pz7A3MT6iREzpw6881gMZWy3oEokPsSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZugPm/VX; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZugPm/VX"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e87c66e556so7432545ad.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792180371; cv=none;
        d=google.com; s=arc-20260327;
        b=njR4sNb52jNXy+ODnvw16P/3rJwd4Hfok+SLAYsYzLL98rztoZsUr5RiZxYCAZfFxh
         3zN+Y8xQl/EVu7khmb0mxin83zBRSqa9On5F0+A+yzArp1Dz0lBI8cLJ+cNK+/XrTqWi
         esAPzNRVHSz+zmYTDgHawOdQXw4U+wEuLJ8oyrhGff1FpfaGDL3QLzhFHTqzUmMFug1D
         1KJtvULpNIv7QP12BIunRiDOVj7T/e9t0AlHw9tneLEuXRKW6Q0539Qh9RqNqSgXeYH0
         a9eof/J2l6xmaYtu6lZn0eJ78pnc1C2Ha5KTuCQhit8gMG1wZfMvyZRZR2U+fBcJSIbe
         qyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aKy0WhmuZ0KSTA2scN/gWrfv9TWutXxLU9SljZLRv3c=;
        fh=P7loQgRJG1ZZ2FPdvlUiTabagPyWNsPx6ygRjCPtagI=;
        b=MsB7ikIPrYGLPFDSsC4bXuMMLo4VMl/M8Fw/reK7W6fH9T+XE+pCYJMkJUjnwzIBJk
         zA3NYLh8KAHzgZmW1QyhzSXR9e4QxGsuZxPBxodPIqSEyPipVNOQyhYyJtMz7BazPP08
         p7hspaElhkT8Tc64oAMqJF2SNKsQQBgbiqNYjAOmHwDY3E1bd+1bfP//sCDFxW+Ou/kQ
         HeUbETCrSMrI+2HONkYAF/glP6SFc9ouzBJ6JO8Qr1my33nNZsK7+zXgeKcFwlfOF3TN
         F/tpVPw+Oa+7NTkjM9SqJhNedEgNMfmili/XhCtCvKF8scsu5SjQ3MAyh0ME9IZXseSU
         IpWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792180371; x=1792785171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aKy0WhmuZ0KSTA2scN/gWrfv9TWutXxLU9SljZLRv3c=;
        b=ZugPm/VXd59lSpe2cfl0srkX1DsKn/fdwvToZIlIMp8oIs+fZSrQHHhCs5ukCSIMDF
         8GSe/dE+fos7ltNXPE1C9hwszMEN0HvjkKw8TSmvv4bkIACGpdVNBzPppUfBDqA34PBs
         kdqIlAKc2BaJ3VCYw+xkGWRVKZ/4YW7RPb2G/tHV4hTblCBiXxsXnAwrnD8RH22nwCZk
         DYHxwzQoRwpQ5fk+N3zrf6HYrqtB4Ox7MlTHfaBvZaclYMw1f1wYxsUL3HSmHrfeIFZK
         9aPIzF+FOV3kA0IWaxcQlFUpMNouG6MFmQssGEJI15bL4yfG+HxBS3HVzoP/5ToQmoDb
         5ToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792180371; x=1792785171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aKy0WhmuZ0KSTA2scN/gWrfv9TWutXxLU9SljZLRv3c=;
        b=YH6BKGpc9NjB8kC7O8IuikPcRiJScar4I7zWncAnEe9FgMbDH99sGBTLv1yUc57d0F
         myQzdIEofG2/sZaCd3wkA5mTxh55QSP2/vFbGzvgliFjqIxjIPHL46WaHcpGOeOnxnOE
         QzdR+fZdld7oExhDz2iF5b4p/PTApb+UEWIN6M0bay0yqCB5JhAEptSAomxJB8VZ/3OP
         XRqIaQAXvHj5Nu7bQW5imXlBiKhiZUSfHFN4ELPQ3+EIuMkfRfsDQj/uSvF7fLosD0Oq
         C7XSTQAqO+Z7177sGSrSCsfZ2KbjLAf4OAFWmhY39/P/zCpKgjnjU62xWXSV9ZCvx99p
         VRaw==
X-Forwarded-Encrypted: i=1; AKwUvBzK5R07k1JUNYQ+q8bEPEtKRLvFNU+Q1LWAieZwUXU8MLFnKGYY/PpJYX0PzsQMhJ2IyKg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqDMjNU9Z7olV/RP6eRMEOLeazPEna18MRRq8ECW4Z2S1SUo1O
	J4HZ36rmkvzDEfS16fYtsCinoCz6l7qgQ4opPcjvAAFf7CGJ6Kvm2tU7560IyWKCaAG3o7jZmfK
	splwKzg4H8Fx/mP2gkBKWaoahTskG5+U=
X-Gm-Gg: AYBFou1i0bZtjy7BBg6oDhBGxGj2ZLRoOdNUGjKPQGz++nBMAZZ2MYg2Lf5LH0matpq
	l4D7tMFDz6t+6sQ1we6nUrF7vh+s0YfNHGs6RI9rvdf/i+raSIa0+me4c/LePy6ILe4up0sNqhM
	a7jOQJrHpunZTHhvz8HetiONsSgZd7Lk3QJx3ZSt7ECgjrgaD7i5AQfKykRViX1Qsx442d3Vnwv
	sMpAHl80XsLkc8jZ9mfAx0VIWtauZWOxPNmoz9VxQclwKvAe958p46Zd5QpH9jVEhoC9Os342jk
	WxJ03oQesl8uG60lN9nkdUmblrEj+VLAKjTr1gtqaNi3lVMnz8lN6lgoErQa41bP3G5lD0MRzQN
	MVEzQ6zI/RUTKTwHJVZNS3IgH6JJTyF6zSev/pK0Xlf5xOBgVuOjKzNpOhfA7PP4sqcbhSx3eXZ
	1OoDrB+igf4U0Bd9AHIPc/Vf8Vq/jVxe/W6Ooi6Ic=
X-Received: by 2002:a17:90b:3a4f:b0:3a0:2900:f55e with SMTP id
 98e67ed59e1d1-3acef3e9905mr462690a91.29.1792180371201; Fri, 16 Oct 2026
 12:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010224902.1232178-1-arighi@nvidia.com> <DM6HVNSP3USV.AJSWS289Z3I9@gmail.com>
In-Reply-To: <DM6HVNSP3USV.AJSWS289Z3I9@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Oct 2026 12:52:38 -0700
X-Gm-Features: AclHuK92INr4JCwk1GxOJAxDUUIr236c_xuz0zXWx3fjiZTY4wmHwQ-mmYgfdw8
Message-ID: <CAEf4BzZZRrD86ZswsB2r-swqNi7D1p52Vs=fQ9MXSgGATN31Jg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Expose pinned arenas as sized bpffs files
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Don <joshdon@google.com>, 
	Vineeth Pillai <vineethrp@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	Shameer Kolothum <skolothumtho@nvidia.com>, 
	Himadri Chhaya-Shailesh <himadrics@protonmail.com>, NchangRoy <royfru44@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 12:03=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Oct 11, 2026 at 12:45 AM Andrea Righi <arighi@nvidia.com> wrote:
> > The guest scheduler can create its own arena and allocate pages from
> > that NUMA node. Those guest physical pages are backed by the host arena=
,
> > so host and guest BPF programs can access the same memory through their
> > respective arenas.
>
> in addition to what Josh said...
>
> That node is ordinary RAM for the guest.
> When the guest scheduler exits arena_map_free() does __free_page() and
> the page goes back to the guest's buddy allocator. Nobody tells the host.
> The host prog keeps writing at that offset into whatever the guest
> allocates there next.
> NO_FREE in the guest doesn't help. It covers the kfunc only.
>
> Patch 5 needs a 16M node (256M on ppc) to get one page into the guest
> arena. Arena is 4G at most and it's one arena per prog, so that's
> 256 guests per host scheduler.
>
> The NUMA node is a way to avoid teaching arena to use pages that it
> didn't allocate. I think that's the missing piece in either model:
> host allocates -> guest arena is populated from a BAR,
> guest allocates -> host arena is populated from pinned guest pages.
> As Josh said the BAR is needed for the doorbell anyway.
>
> If arena can do that, can the host side take the pages from memfd
> with memfd_pin_folios() like udmabuf does ?
> VMM can map memfd at any address and offset already.
> Then no need for NO_FREE, EXPORT, sized file in bpffs, 2nd kind of vma
> in arena, etc.
>
> The loader does memfd_create() or opens a file in tmpfs, calls
> bpf_arena_import_memfd(&arena, addr, cnt, fd, off) from a syscall prog

As briefly discussed at LPC, I have nothing against adding support
like this to the arena.

But as I was reading Josh's reply and thinking about multiple VMs and
multiple vCPUs (that can also come and go), I kept thinking that it
sounds like a pretty good fit of map-of-maps and ARRAY maps, where key
for map-of-maps would be either entire VM or vCPU, whichever is more
convenient. What is missing here is the ability to create an ARRAY map
from memory that was already allocated before, instead of asking the
kernel to do that. But once we have the ability to create ARRAY from a
bunch of pre-existing memory (e.g., from memfd), this can be used both
in a guest and in the host, and both models, guest allocates or host
allocates, could be supported with the same model.

(regardless of this particular use case, I think it would be great to
be able to create ARRAY from memfd for some other potential use cases)

One disadvantage of ARRAY that was mentioned before is the need to
bounds check/limit access for PTR_TO_MAP_VALUE. I agree that's
annoying, but what if we teach verifier to just automatically add
bounds limiting sequence (e.g., masking if value size is power of two,
slightly slower sequence for non-power-of-two, of course) for all such
PTR_TO_MAP_VALUE accesses (e.g., if map is marked with some BPF_F_xxx
flag).

Is it doable? It would be great, if so. Arena's singleton nature and
4GB limitation might not be the right fit for all cases, so it would
be good to have an ARRAY-based solution available as well, IMO.

Thoughts?

> and gives the same file to QEMU the way patch 5 does with the pin.
> The imported pages stay until the arena is freed, so it's NO_FREE for
> the shared part only. libarena keeps working in the rest of the arena.
> arena_map_ext_pages() is what a BAR in the guest or pinned guest pages
> in the pvsched model would call.
> What is missing: user space has to mmap the memfd to see these pages.
> The arena vma gives SIGBUS there.
> Something like this (compile tested only):
>

[...]
