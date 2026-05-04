Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201D3451B2
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884285; cv=pass; b=Y1MW61SKx4fr+xzGuyOrD7GiEBZdq5GITb9rZNr+xz/3mkhjVf4fRSYk+KypmRwBugXY5H9EwUa5XdWI1puhFOChRJKzsxLF7+VPdffgkPJKIyF++xa/ultdXQlS2PYV4R3CCm5ZoGjdnojixUhTUzEKTTLJV6aiR32AGa9MmEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884285; c=relaxed/simple;
	bh=Qss+U8wLLo/f7M25oY4It/y3e4/yeO8e1s7iZDkFkYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koE8qnpO5quCEnQ69KmWhP2P+8sHePxeHbCwvvLxOdQcYh+rJLOI6l4ZTKIugaolOfD1ih2j5RbIiI/022Elo+UVd5zQc59SCup1sXvZEFjMmFirsj8BjPiANenB6D+CJ3ekoBKaR6vps+z1x5DGNp2YGHUnYpOj/XjB7+a1fxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1CeAr9R; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1CeAr9R"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso46017555e9.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 01:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777884281; cv=none;
        d=google.com; s=arc-20240605;
        b=GF0Bqj9pX/C2NBMSvOHx/aTkKjSUHab0prairlbSjGWOy0CHje+W+E2cfBOmZ3UXqs
         ISMpQgShb2dkq7cAamdS6kPxb9MKDJoTMRmTPfe5tA4p5milH4MoxdNxoywGhX+0P6aU
         tIbyyeRsHsnGQUsm3nMHerpaO/KinXH8fopBglz1F5gqa0xRP1VzI22oV5VLmyRAVN08
         SPamWvIZsjfyC4EY/p4ppC+EWqrTctpUY3UgROr5c/fhcWYwFUDt1lueZQrcY0NjTEye
         uyPmdqFtlLyij5tAM7pUwL2xIXJK6RRixZTNVJHKFZxUTHJb9qJtR7DIN253WJ1B93S4
         +wNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jv9NxqtRyL2CP+9T7R4yPhEDtmnf2mNkhJO8Wz5finE=;
        fh=Aey5tJ8DhbksTf0EgoDLfFyEfGwNdDcZGWw4qFU/2no=;
        b=GNnxFwSzFaFXPeO/P8X9lhCbgY72rUr4cSLUdaPU4I2G1Gw8KGLHsi5zu9HwfIv+id
         vGSKuYxmBWhn5Qh5EA8WG0h9DZLrhoyWNObOY4Xbp2uEVN2EBXz9m3NKyjwr3yMfPRBh
         JgkS4bZgMDnd5SnuZ2hu9jdIHG9n8VkN37ue4oDuzmf5UPA2nqetXdZDiRH4rjDMxSMa
         568oZeBUsCDpu31zvfC/Ju8bXoxkl9MpjMJySKSkv2LNN2cjzFOmqRBcKJLkFwBwYM5d
         Vy7i5Wnz4ifxC1ahVxzVgjROorMnlL8BPJ4Gz/ZmE7eo6tYMQp19mtoyLn3ce7PZ62qc
         ZCIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777884281; x=1778489081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv9NxqtRyL2CP+9T7R4yPhEDtmnf2mNkhJO8Wz5finE=;
        b=k1CeAr9RoIWU3UKzYwtTuQ4eIpRSewZvELf4NAC4bMh0QQUMODwRGapadbSBV3Z/Wa
         xo4XTmHY8DPEicPCIYpErpNIKDCX/JOdil8X0Q63KHh5Nc2Vq9EuWlBCYqJ/BMcRDegJ
         0+BkeO6mwi2XqCXGt31fTZach2+zJEg+JJruf5MtlewOE/xjvTT/j4TY55kC8yxwS/El
         XvCMysfj5heGNL5g9m0YJv6nn08JpgiIZHURuFQx/E3HKjM9PVFLuucitKPpmosVHueD
         449PzEmvxXJ8jgDKp0FNYhTzbmi0O3MMAcZRHZBnWpPnkjM4qY6bYjx7m4Uq4ztCvnW5
         xl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777884281; x=1778489081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jv9NxqtRyL2CP+9T7R4yPhEDtmnf2mNkhJO8Wz5finE=;
        b=NGthsaV5I+YQWSbZa8Pnxy9DaVMFQ4GvsKTsa5hXNh7tpEw9TwIgIJnlTNcTcpwBSg
         6LwtEAD5SH7dMEw3poLJRKNTQLGXKOy5RrkasPsKbDZbBZPXDbFkBfRXlrvE007j2v/5
         Vv2svOmwOz9n/EuviZR1n1sx/Q01iC+xRseTxIPgT0wT/8e9ENKQz4NfnM8CathF/P5N
         v/0ukfiwjNEK8liTWyPxQRBb8m+fvbGYZduFEeCGOfHrMFwNQ6YZL3XRirIoITH1iAm9
         J70auTxQ+scHg/p9T92nYC6dAoAqLccKjRt/v8bbMrwAwGObexg65hTwiVA0ftoINFdZ
         NhSA==
X-Forwarded-Encrypted: i=1; AFNElJ87siAJu1qIfY41IDo+gCtFj/Z1+o3cZxCueYeJgPtOE1z56yTv7z7m279FBD/ngBmU+94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfemAVj1AzT8mwFRnqAZ0xQLIR2khc1rNyIsAPw+aiWdxjFr7z
	r/yTAxeK3wOI5QiZzy/ODbrZkg09aZ0qhWkWSvJooKINBvVIuQIvPtuiKNtEBFSEsLHVVQKU1Yt
	Z1byNIWvInCWy2YOhiV+9AP/tOa/L7Ek=
X-Gm-Gg: AeBDievx7hzzMe/xi1gEvWao6aJI4E8DEBc5B7Xfcsji6MFmMlqPBM1D/s8wBp7UXcE
	l1ejhgwlwrMZ2WCtgVHJQVFGyTXKtFAzVgGr9ObL+qe1jpaEH51EQvc8hyJHxaRiDo6v9voE2Vu
	jkWOYmC5VfGYbYP4BDS016LzxlkYizZWXin3lVQdDXmfu++G8QHo4uzBxoOmMX7c9eqlGLQqsUk
	lNcxEDiSfF1Zg7PoyX5JHqcVKWxoE11vlgrZvNr8YsIZ/PTdCp0MS/WQa/jKJLFfbDe2wnJrkUz
	uPmli5THH1O7X3p/Poy49kGjFtzFGxh/3cxxFgp+Kilr4qivGs9t91fzMEN+M9xBwaUvxDbAKQg
	IMRo=
X-Received: by 2002:a05:600d:f:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-48a9867756dmr114115895e9.27.1777884281056; Mon, 04 May 2026
 01:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <362eaba2-54dd-4b59-81f5-65abb916e916@linux.ibm.com>
In-Reply-To: <362eaba2-54dd-4b59-81f5-65abb916e916@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 May 2026 10:44:30 +0200
X-Gm-Features: AVHnY4JZ5hfoCAF-GdNeTg5qxvY890QoN5Fk7GQtaHRmuk32fVJ1xR5wgivEK84
Message-ID: <CAADnVQL7Hm592aGOKbmOMRiPuKz1uCLKu9KE3poZqyR51y4HhA@mail.gmail.com>
Subject: Re: [mainline][bpf] build failure: conflicting bpf_arena_* prototypes
 between vmlinux.h and bpf_arena_common.h
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, bpf <bpf@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 10:42=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
> Greetings!!!
>
> I=E2=80=99m seeing a CLANG-BPF build failure in tools/testing/selftests/b=
pf
> related to conflicting prototypes of bpf_arena_* helpers between
> vmlinux.h and bpf_arena_common.h, on mainline kernel.
>
>
> Error log:
>
>    In file included from progs/arena_strsearch.c:12:
>    In file included from
> tools/testing/selftests/bpf/bpf_arena_strsearch.h:4:
>    tools/testing/selftests/bpf/bpf_arena_common.h:47:15:
>      error: conflicting types for 'bpf_arena_alloc_pages'
>        void __arena* bpf_arena_alloc_pages(void *map,
>                                            void __arena *addr,
>                                            __u32 page_cnt,
>                                            __u32 node_id,
>                                            __u64 flags);
>
>    tools/testing/selftests/bpf/tools/include/vmlinux.h:135295:14:
>      note: previous declaration is here
>        extern void *bpf_arena_alloc_pages(void *p__map,
>                                           void *addr__ign,
>                                           u32 page_cnt,
>                                           int node_id,
>                                           u64 flags) __weak __ksym;
>
>    tools/testing/selftests/bpf/bpf_arena_common.h:49:5:
>      error: conflicting types for 'bpf_arena_reserve_pages'
>        int bpf_arena_reserve_pages(void *map,
>                                    void __arena *addr,
>                                    __u32 page_cnt) __ksym __weak;
>
>    tools/testing/selftests/bpf/tools/include/vmlinux.h:135297:12:
>      note: previous declaration is here
>        extern int bpf_arena_reserve_pages(void *p__map,
>                                           void *ptr__ign,
>                                           u32 page_cnt) __weak __ksym;
>
>    tools/testing/selftests/bpf/bpf_arena_common.h:50:6:
>      error: conflicting types for 'bpf_arena_free_pages'
>        void bpf_arena_free_pages(void *map,
>                                  void __arena *ptr,
>                                  __u32 page_cnt) __ksym __weak;
>
>    tools/testing/selftests/bpf/tools/include/vmlinux.h:135296:13:
>      note: previous declaration is here
>        extern void bpf_arena_free_pages(void *p__map,
>                                         void *ptr__ign,
>                                         u32 page_cnt) __weak __ksym;
>
> Tool chain Versions:
>
> gcc (GCC) 14.2.0
> # clang --version
> clang version 23.0.0git (https://github.com/llvm/llvm-project.git
> bd6bfba3e50343c112a04b639394ab85be17c29b)
>
> # llc --version
> LLVM (http://llvm.org/):
>    LLVM version 23.0.0git
>    Optimized build.
>    Default target: powerpc64le-unknown-linux-gnu
>    Host CPU: (unknown)
>
>    Registered Targets:
>      bpf     - BPF (host endian)
>      bpfeb   - BPF (big endian)
>      bpfel   - BPF (little endian)
>      ppc32   - PowerPC 32
>      ppc32le - PowerPC 32 LE
>      ppc64   - PowerPC 64
>      ppc64le - PowerPC 64 LE
>
> # objcopy --version | head -1
> GNU objcopy version 2.35.2-67.el9_7.1
> # ld --version | head -1
> GNU ld version 2.35.2-67.el9_7.1
>
>
> If you happen to fix this, please add below tag.
>
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

The issue is in your setup.
It was brought up a couple times in the past.
Please search archives.
