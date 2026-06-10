Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F9A32B105
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116774; cv=pass; b=aDg4VkRlmBF1ZOrp37dJ2JmBemK1R4KLL1ukPQ/rkOjvsJmN368ltPL6sdv7D2W7VZVvUbSbNr5R4HiUF1zco3da7JNvD0wp0bZ9u7Yj/yO/9OJEMZXZ6ypqnAti61C+thc7iOSXFpAo9t+zhxK5bFf7OI9IkNUKb1G9IfWrtU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116774; c=relaxed/simple;
	bh=aRSQey8t3zeVlUBixJVoeRN2sHbAyrNfCVqldIQvljQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXoyIBBeiUWz0vrHwtzLh8zPibNt9A3efLxT4RcF/wM5lVw5BKhMuapkNn11W/HbbbAGYUXj1/0GUHn4UIqGV8gZMhI+0CnDeWPnWLmE+Ncu++f19wxFt+mf618K847B+94sta73iMjR4cwixwoiK92P7IlwPYFUMXWC25v9qI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULHqXCpB; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULHqXCpB"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490d1e54b3bso34240035e9.1
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 11:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781116772; cv=none;
        d=google.com; s=arc-20240605;
        b=P33lnqOob0KiSEtMeCF6y9/RNY87mkvOVMOg5KWgLimR6+PQPtdgssm0uOdCsySmaN
         f4dQ9EfXOD3rT9Y3N0VvH9ibZFhXxRuiXIaahO4PVo1jILVRrd5VI3KIOXGAWxcIWbCz
         i5+YkpaV3DoB4bxYTP6Sdw2wUMPBDtPlN5Oqrxy1CV1dcpwygTYcEqfQQRdqPvBiCel+
         q4rAKulAuHt6yPXWEwrVgl3cMqmehBGm775x+4HQxa3cZwHz4jZ3De1NSTeB5eaMvECF
         zODetBVZDrsn/Tto6xIquwMUG3N0Edp9RLTrPV5s4iOsVtDEOjJmGJcurq4gZ6K3Omx2
         ivqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QAI5rGE1lcochlZ5iYlpDGay/XmnlZU+2TzD3/+oOuo=;
        fh=5J72raPVtknhZsRN8/PgThEXnbSw+jyrPljNPHEGcuc=;
        b=JTjINQ0gH0FsWovyKfgijvPKg/kBteaOMrcl72jPd0duCweHDk1VkrpF7IS2m33kSl
         6gWbTshyem0lnHQfN/4R/sy4uFrzejwvFlWCae54bX7VVlAEy7hkDUYOpREMKbmDVMam
         K13md8BcWu9oj8NpzsvqdXjx3cF29Zd5Wo/QwU9GAF7KnKMvkcf9UT9zvxz9+FKeZVgA
         IX7Vi3lwTI/BQbYopRD/YbIRUj5kdT+v+pYFdMVaqHzpTB/I7yHrIcy7UjMuVAxVOOdg
         a4/HgMUzUN2eCHOW9IznoLiUA/0Vfa0BCuPQvrcELn2ZJ8nrrwgBlmtyTXZIQSG3S2W+
         mimw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781116772; x=1781721572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAI5rGE1lcochlZ5iYlpDGay/XmnlZU+2TzD3/+oOuo=;
        b=ULHqXCpBIu7BNPilpKVAEAQvv3KQ9RqLflKC29BWdwXxXV1rsYl5variAgw8kc8smM
         d4zaKNk6yNCMlF8CFbziHKB1pekkWzqq8yRBVh1nMGedI5zYZFCM+OVZPlf6S+UDpa/y
         42/X2CYSr6b+bwgqRgQOqtXukKqs5RWmIKCETx0EoH/psb3JHQDe1HdgeAEnvYsCV6Kk
         N1i0YEESyh4hIUE7HTiqYumoHOYOu+TBcMD5dKcpwaHkksXHrEjv1Ne1ZbMo4AFiF9rG
         XIc9twHNIhW8EEL7J1BMiuNIwe/Q+oUUGU5r9XUZWCmpYCYQUiAipujXsbsxldvHsVgV
         c3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781116772; x=1781721572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QAI5rGE1lcochlZ5iYlpDGay/XmnlZU+2TzD3/+oOuo=;
        b=jQjWLhGTvK4k6iaStgnUrsgQlHxLZnvIJi9nJkVZbBguJ1Up6D8jBfJR1d4CpOdHgF
         iRvxExd88vbebg6hQL+O4NVVYeWN68cbtJXwL2inFKJVUUmjq3/YUzOk3oICWCvlUAvK
         D4laD/O/r8Jo+p/+drrA0eotK1qoQWrOuWYpGU/KdrXE5x6d7apdeDzYt2dJr+7W9LEI
         NJqyOFYOubsBd2c6VrcbMOIH2p7p7xGIlRUWeYVoaUevzhvhENvpvB6hrDHpW1WeCr32
         gvMdDaFnfheC7fUbJ8IxxKL6urgzobectfcSqfX0c5tD9hD2JSyzW6clzYq3S1WjLfLt
         oHkg==
X-Forwarded-Encrypted: i=1; AFNElJ8EcbSGBAW41t6PkR5G5woYhGKho+ImJqpAT78b2Cfksm/wm/g+5IVlZzb1U/1k3k6STZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKgi+GynjKEhHQcf/BZvjSlzro3HTOz5U7SKHO65cN9tBYVh3
	9DyphNC8HDBlxsk9aneBz8HcIJX1IfiZh5q2rXV1Zn5UgMrTTtaMc0LrEIfE6k0SfIKM6O3Xebb
	SdWp2Pqf8S2syI0/obuN94zTAGm6BGQc=
X-Gm-Gg: Acq92OFLclaD+DKslRcGRoAhBfKFNuimIfouCtAh3MU5iCb9lFntuBIdCNz9zH3IfEW
	NuQFTqtmOyjN7tz0ZVFtBIxdpAWVbZcYef5SU5nVcarrMiS3X+YN+yqx6q3m1paFoFCB9X5q/R6
	09FyFtkwPW5J/ZwNRpXvJL84b1yLPGC2Foa6ER3Q8F/Trs874cZHWKANMm6cjkDF8QDvbafMfk5
	gC+xHUTjWvtR+hlguCcBhZssjVdQJBpDy/xA5sWlJFRyLWgciczY6k77H7TmwYBMTYhthHFs2aS
	8EqPYbmgs8DXhSiaOaaZT1R0Dsr7fm2zeX3/BRn3TIsuk9/IHbCF
X-Received: by 2002:a05:600c:c059:10b0:488:b187:3c with SMTP id
 5b1f17b1804b1-490c265b439mr323245315e9.14.1781116771269; Wed, 10 Jun 2026
 11:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610175651.647515-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260610175651.647515-1-ihor.solodrai@linux.dev>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 10 Jun 2026 20:39:19 +0200
X-Gm-Features: AVVi8CcOmKKzzKpfqJi3RQYIzBaDejV9oYlpv_30ztPULZsRV2up2gs-F5uqBVw
Message-ID: <CA+fCnZcRLZS4r=FBB6EX-G3+=X675q96hkdR_wLJexeuW-tPVw@mail.gmail.com>
Subject: Re: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86
 under 5-level paging
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 7:57=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On x86_64 with 5-level paging (LA57) and inline generic KASAN, the
> following flaky splat may be observed on boot:
>
>     BUG: KASAN: wild-memory-access in do_raw_spin_lock+0xcf/0x260
>     Write of size 4 at addr ff110001000c90b8 by task swapper/0/0
>
>     CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.1.0-rc5-gcba33e0b2=
907 #1 PREEMPT(full)
>     Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,=
 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>     Call Trace:
>      <IRQ>
>      dump_stack_lvl+0x54/0x70
>      kasan_report+0x117/0x150
>      ? do_raw_spin_lock+0xcf/0x260
>      kasan_check_range+0x264/0x2c0
>      do_raw_spin_lock+0xcf/0x260
>      handle_edge_irq+0x35/0x770
>      ? do_raw_spin_unlock+0x51/0x2a0
>      __common_interrupt+0xae/0x120
>      common_interrupt+0x7c/0x90
>      </IRQ>
>      <TASK>
>      asm_common_interrupt+0x26/0x40
>     RIP: 0010:identify_cpu+0x2b2/0x3460
>     Code: 00 41 c7 07 00 00 00 00 4d 89 e6 49 c1 ee 03 43 0f b6 04 06 84 =
c0 0f 85 a3 1c 00 00 41 c7 04 24 00 00 00 00 31 c0 31 c9 0f a2 <89> c7 42 0=
f b6 44 05 00 84 c0 0f 85 ad 1c 00 00 41 89 3f 48 8b 44
>     RSP: 0000:ffffffff97807df0 EFLAGS: 00000246
>     RAX: 0000000000000020 RBX: 00000000756e6547 RCX: 000000006c65746e
>     RDX: 0000000049656e69 RSI: 0000000000000000 RDI: ffffffff98632fd8
>     RBP: 1ffffffff30c65fc R08: dffffc0000000000 R09: 0000000000000004
>     R10: ffffffff98632fc4 R11: fffffbfff30c65fb R12: ffffffff98633050
>     R13: ffffffff98633048 R14: 1ffffffff30c660a R15: ffffffff98632fe0
>      identify_boot_cpu+0xd/0xd0
>      arch_cpu_finalize_init+0x24/0x1f0
>      start_kernel+0x31e/0x3e0
>      x86_64_start_reservations+0x24/0x30
>      x86_64_start_kernel+0x13a/0x140
>      common_startup_64+0x12c/0x137
>      </TASK>
>
> It fires very early in boot. If kasan_multi_shot is set, the reports
> are non-fatal and keep repeating, and the boot CPU wedges before
> userspace is reached. The accessed addresses are valid 5-level kernel
> pointers, so the report is a false positive.
>
> The root cause is in generic KASAN not seeing
> cpu_feature_enabled(X86_FEATURE_LA57) set, because the bit is cleared
> in identify_cpu() when the offending interrupt happens [1]:
>
>   memset(&c->x86_capability, 0, ...);   /* clears X86_FEATURE_LA57 */
>   ...
>   get_cpu_cap(c);                       /* re-reads CPUID, restores it */
>
> addr_has_metadata() then uses the 4-level threshold, and 5-level
> kernel addresses fall below it, so kasan_check_range() reports them as
> wild-memory-access.
>
> Define USE_EARLY_PGTABLE_L5 in mm/kasan/generic.c so
> addr_has_metadata() uses the stable variable, as
> arch/x86/mm/kasan_init_64.c already does.

It took me some digging to find which stable variable you refer to
here; I think this needs to be better explained.

>
> Some context on how this was noticed and reproduced below.
>
> We started seeing flaky splats as above [2][3] on BPF CI runs after
> runner hardware has been upgraded. Specifically, new x86 runners are
> c7i.metal-24xl AWS EC2 instances, which are Intel Sapphire Rapids
> machines that support LA57 feature, and have it enabled.
>
> The splats can be reproduced with qemu on any x86_64 host with
>   -cpu max -accel tcg
>
> Build a kernel with:
>   CONFIG_KASAN=3Dy
>   CONFIG_KASAN_GENERIC=3Dy
>   CONFIG_KASAN_INLINE=3Dy
>
> Boot it with kasan_multi_shot. The fault fires fast before userspace,
> so no rootfs is required. For example:
>
>   qemu-system-x86_64 -display none -serial stdio -no-reboot \
>     -smp 4 -m 5G -cpu max -accel tcg \
>     -kernel arch/x86/boot/bzImage \
>     -append "console=3DttyS0,115200 earlyprintk=3Dserial,0,115200 panic=
=3D-1 kasan_multi_shot nokaslr"
>
> It's a timing race, so a single boot hits it only sometimes.
> However running several qemu instances in parallel on the same host
> significantly increases the hitrate.
>
> I confirmed the proposed fix eliminates the splats.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/x86/kernel/cpu/common.c?h=3Dv7.1-rc7#n2001
> [2] https://github.com/kernel-patches/bpf/actions/runs/27271262414/job/80=
542509369
> [3] https://github.com/kernel-patches/bpf/actions/runs/27260143782/job/80=
505353689
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  mm/kasan/generic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 2b8e73f5f6a7..b5f430f2dbb6 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -9,6 +9,13 @@
>   *        Andrey Konovalov <andreyknvl@gmail.com>
>   */
>
> +/*
> + * check_region_inline() and addr_has_metadata() can run very early.
> + * For example, in an interrupt taken while identify_cpu() has the CPU
> + * capability bits temporarily cleared.
> + */
> +#define USE_EARLY_PGTABLE_L5

There are other users of addr_has_metadata(), besides ones in generic.c.

Thus, should we place this definition into mm/kasan/kasan.h? And
likely guard it with ifdef KASAN_GENERIC || KASAN_SW_TAGS (HW_TAGS
should not be affected by this AFAIU).

And let's also extend the comment to explain better what's going on. I
like the way the issue is explained here:

https://elixir.bootlin.com/linux/v7.0.12/source/arch/x86/boot/startup/sme.c=
#L36

> +
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
> --
> 2.54.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev=
/20260610175651.647515-1-ihor.solodrai%40linux.dev.
