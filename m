Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D83483BD9
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280959; cv=pass; b=CFe8DSelWDL4GWzWguKWEUuGvN6hA3zh+qL1PelHq70JajhkSIod02GIx9oQMoXGr7v7zIsM5rlslrvrP9coJnurtZf13Y9ucUkykG62eoXM9M3eQD6g6qn9WlHKGtoGtEk8BNn6+mdkFbZgRaKAuXqvEEhHX2Fq8x1MEHxBUow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280959; c=relaxed/simple;
	bh=APD9AC0VOr/0fRwikJ9+mcsezV71BAyGtcZk+VzYP7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTCxIMif0WQLVbsRCodiDjwg7Gq2hTecRxAG9qnSYV7JMDsnPsqRRLpWmGAeLiwRRkciApaRZk/MkEmPcQA5++8FaSQ1SRsNU4omFbVKmFwYAX+8fuGRN+Z86c/L4HMmaVO75m0flWbKo1LvWMaQX53Y2+xCRrR34LRw8+Z5KkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFvcYJrw; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFvcYJrw"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-467cefc56d2so61409fac.0
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 09:42:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788280957; cv=none;
        d=google.com; s=arc-20260327;
        b=m69Lpwzjn+A4UgHV9M5pQq2Ve7V0RCvMlKXOkE3gKniHZ8gx1fjjCSUJOCCvJbOLFz
         rRNNdkgn8AWw6GFCiRX6+eWmax5icEM/OAoHUFuAbk7TMuMsxnlRzVnPdP5pDmzm/KI8
         z5sa/jdiFVFWo2O0niZR+2oEbRRzGPxJI/PiIBHA7r8yvi0DN3QBrdvaIsqYADP1vViq
         xlXx/4FSl45yybEPPJ1EQ52pI8VtmZJyhz+Lo3EuygX2eqTKvwPBQ84JWoD4iRI2A5uH
         dPzrN7WJTw5b22ddF/TLXIKjLVAECTnvzP4VTaoDXBnG04QBtMwa/3l26WazYEGue310
         BnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6m3dH9dLlajhbBspVJfRfQW3YlOmSaiwmzKjeGKmwMs=;
        fh=agL7o8EEnTSqg0UvDhQgMHqO4ECJRvrfhvCPF/VtBwo=;
        b=IqLeeMS1/p5E2YhAUQM2bFdy6fKg0Qu40zENlveuLAKiRwkjrGlN8lFtm7hqlJfcOO
         Pu9rghxaUDFJGImCVG06xAOlmmtx4TGhSzuSXVAzZva7dWu0Z04XNTfkJ0IIycgTew5h
         Lgh1xFUGqZWKwcs69mp6TMFZENCZJsm6o3MHlhbEbpkKwzn4Yf17g8z3oqLUis2fTHsr
         vj84p6Saou344fYU2m7QJOXmqWetauT6JVbBsDg6Xjis8sewGqJwNApU05XTojdYG9WL
         4qVmmYlIESoHT+LEBT2ZCFy9U0xnBUDliTHCgvDQl8U9m64HSxfOiIqu9IdyNkOWJfEk
         p2Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788280957; x=1788885757; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6m3dH9dLlajhbBspVJfRfQW3YlOmSaiwmzKjeGKmwMs=;
        b=QFvcYJrw0LCntf8iHn62OP+TBJFIwuOL5d5xrw9fxz1fpD/TFaKHA1FzZG61ET/2y6
         uDHufMXKKbXeSvIzbIfR+k/HjhuP2vk3TSlJ3Mq+6kvERFjBnQI5Ny2TbmmNRp6H9UyB
         ijncTJ15oRwIAMuTTHC7eH5WoezrIyYY4Uwr+z8whkF769cHS2EwbQQHCIZLCuCRNaSW
         XJdERkG2yEfp11tIpTdS/axOwYI9c1KO512eDmB30qgc24CUYaubTqYnRSM+zhtdBCb+
         jhgcAYl3FHmGjy49OOHJHxNcQbADrjfwpgHvoFXFbQcBRGbaIdKBWV+6r5HSMqk0hQuZ
         skWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280957; x=1788885757;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6m3dH9dLlajhbBspVJfRfQW3YlOmSaiwmzKjeGKmwMs=;
        b=JK8K2YCbgPrd0W6K/HQPXXZDbSPzFfae6UUHQCxOguYSQVznPZ0qDWlKjslJDk9Bp7
         KN2VOxaoiPxu5/NRy8udCIv9r9RFW/BM4Sk1CXF2mo45gNgnE/S9hQo78XuIbFCk9vnD
         7TaBtbffo8HR9QoyPs4F+lQawyF3nmTk64DYsMMq79lJNaqd4WkHvnxVsl8tBsoXR1TS
         uDCzlwsFyrm6L/NsyEwsjG1vWGbnP1fKhqasw0yzq+Yky9h51q3h7E9TNmgb4xgdzHI0
         gD07AcbOcW1crs1/vBP3UY2uZAN3j13yes13s7vCfRNgNmw3Ssv9FbrTAOInKypW3Lh4
         Ym1w==
X-Forwarded-Encrypted: i=1; AHgh+RqsoyYQ5XNXXJL33tEp/81DtOsKy4vDfXYWkweEZoIsa9iMnL8Ps2Nof7YBWvfBNCoNXgg=@vger.kernel.org
X-Gm-Message-State: AFuF++nepa4xaRhRNIZsa5nLv2ONg5v6Fj1VihY591pLUJ7s7rkZ0mAF
	IXYXUaa0sEp7fcJqcAaOzabJ6vW9IxwqLhghBFnrNfcqSnnEYZHxcYWRH1WynyX/eLfCKg+980V
	o0MKXuehdsxyTAtwpUIkxyAC3D6X5wPI=
X-Gm-Gg: AR+sD10sitDac5QGJndPDfsmjSVJv76ZvDTr8aea9Px8NNeyD6HqWrS7nxo0Axy+4k/
	sTFr8Ilkl1IURU4b2G8mjSDsu7JBbx9N9jy1H2da4SHSIGarwR+CnSNLTEFryKR/0zn6gOtRHEE
	H90dbwukSMtP08sJhlrbcrzFnvoaAVVG8gTlAXBgi76cwY5Cbc8/8YMtxLU0tsqMfXv2QZRilEB
	Y8gi77dNk1MkoMhS0Uhtoi90pahg1Wblsata5b3iV+IAuDMWiVOoJefPJOvOHtHDKBP8hiGiXIP
	omWiBU+ozoTSwPfhfBJyH2qNU0RsFV31V3DOkdnKuHjBEEr3UTm7qbo0jYGhH0qA2J31jfrXG6P
	UBQ4=
X-Received: by 2002:a05:6808:c1ad:b0:495:f8a6:81f8 with SMTP id
 5614622812f47-4b3981e5467mr36568177b6e.13.1788280956611; Tue, 01 Sep 2026
 09:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901141954.29449-1-suchitkarunakaran@gmail.com> <f987bc5dcd678e13cd661ba9830f30d43cf612f3ee8548020491c791c35308fc@mail.kernel.org>
In-Reply-To: <f987bc5dcd678e13cd661ba9830f30d43cf612f3ee8548020491c791c35308fc@mail.kernel.org>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 1 Sep 2026 22:12:25 +0530
X-Gm-Features: AcwNN1VTsGU1S3oWDW34w5U40oz9d5dVHDDH7j-njxkFdJ5jL3ARP666FqPTbvM
Message-ID: <CAO9wTFigd7Wgx9x0fZTK1uYht06G0sKjkecyTEJPyDbyuQSRAg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix map_lookup_percpu_elem on sparse CPU IDs
To: bot+bpf-ci@kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	memxor@gmail.com, shuah@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, jolsa@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, zhoufeng.zf@bytedance.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sept 2026 at 21:04, <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
> > index bfb1bf3fd427b..849f33259c003 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
> > @@ -2,29 +2,45 @@
> >  /* Copyright (c) 2022 Bytedance */
> >
> >  #include <test_progs.h>
> > +#include "bpf/libbpf_internal.h"
> >  #include "test_map_lookup_percpu_elem.skel.h"
> >
> >  void test_map_lookup_percpu_elem(void)
> >  {
> >       struct test_map_lookup_percpu_elem *skel;
> > -     __u64 key = 0, sum;
> > -     int ret, i, nr_cpus = libbpf_num_possible_cpus();
> > +     bool *possible = NULL;
> > +     __u64 key = 0, sum = 0;
> > +     int cpu, nr_cpu_ids, nr_cpus, ret, slot = 0;
> >       __u64 *buf;
> >
> > -     buf = malloc(nr_cpus*sizeof(__u64));
> > -     if (!ASSERT_OK_PTR(buf, "malloc"))
> > +     ret = parse_cpu_mask_file("/sys/devices/system/cpu/possible", &possible,
> > +                               &nr_cpu_ids);
> > +     if (!ASSERT_OK(ret, "parse possible CPU mask"))
> >               return;
> >
> > -     for (i = 0; i < nr_cpus; i++)
> > -             buf[i] = i;
> > -     sum = (nr_cpus - 1) * nr_cpus / 2;
> > +     nr_cpus = libbpf_num_possible_cpus();
> > +     if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
> > +             goto free_mask;
> > +
> > +     buf = malloc(nr_cpus * sizeof(*buf));
> > +     if (!ASSERT_OK_PTR(buf, "malloc"))
> > +             goto free_mask;
> > +
> > +     for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
> > +             if (!possible[cpu])
> > +                     continue;
> > +             buf[slot++] = cpu;
> > +             sum += cpu;
> > +     }
>
> Does this buffer layout match how the kernel expects it?
>
> The userspace side fills buf[] with one entry per possible CPU, storing
> the logical CPU ID at packed index 'slot' (0, 1, 2, ...). For a mask
> like 0,2-3, this creates buf = {0, 2, 3} with 3 entries total.
>
> Looking at the kernel's update path, both percpu array and hash maps
> index the user buffer by logical CPU ID:
>
> kernel/bpf/arraymap.c:469 bpf_percpu_array_update()
>     for_each_possible_cpu(cpu) {
>             ptr = per_cpu_ptr(pptr, cpu);
>             val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
>
> kernel/bpf/hashtab.c:1038 pcpu_copy_value()
>     for_each_possible_cpu(cpu) {
>             ...
>             copy_map_value_long(&htab->map, per_cpu_ptr(pptrs, cpu),
>                     value + off + size * cpu);
>
> With the mask 0,2-3 (num_possible_cpus() = 3, nr_cpu_ids = 4), the
> update walks possible CPUs {0, 2, 3} and indexes the buffer as:
>
>   cpu 0:  *(value + 0)  = buf[0] = 0   (intended)
>   cpu 2:  *(value + 16) = buf[2] = 3   (expects 2, gets 3)
>   cpu 3:  *(value + 24)             (past the 24-byte buffer end)
>
> The userspace layout is packed (3 entries), but the kernel accesses it
> as sparse (indexed by CPU ID). The test sized the buffer for
> num_possible_cpus() bytes, but the kernel's 'size * cpu' indexing can
> exceed that when the possible mask has holes.
>
> Should the userspace buffer either be laid out by CPU ID (sized for
> nr_cpu_ids, with holes at non-possible indices), or should the kernel's
> update path use packed indexing like the lookup direction does?
>
> > +     if (!ASSERT_EQ(slot, nr_cpus, "possible CPU mask weight"))
> > +             goto exit;
> >
> >       skel = test_map_lookup_percpu_elem__open();
> >       if (!ASSERT_OK_PTR(skel, "test_map_lookup_percpu_elem__open"))
> >               goto exit;
> >
> >       skel->rodata->my_pid = getpid();
> > -     skel->rodata->nr_cpus = nr_cpus;
> > +     skel->rodata->nr_cpu_ids = nr_cpu_ids;
> >
> >       ret = test_map_lookup_percpu_elem__load(skel);
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33521264909

For context on the review, there's a commit that's directly relevant
here but isn't in the mainline or bpf-next tree yet, so flagging it
explicitly:
Commit: 75b0a6db4300e4c2c9e97a0848deaa7acfb42fb7 ("bpf: Fix percpu map
update indexing with sparse CPU IDs")
That commit changes the array, hash, and cgroup-storage update paths
from value + size * cpu to a dense running offset, matching the lookup
side. With it, a possible mask of 0,2-3 maps the packed buffer as:
    slot 0 -> CPU 0
    slot 1 -> CPU 2
    slot 2 -> CPU 3
  I developed this selftest change on top of that commit but failed to
state the dependency.
