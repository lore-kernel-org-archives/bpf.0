Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1BD31986C
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801756; cv=pass; b=cJqT9JQmhbPQtuMAczJhwX5rP7uFEZu4BuL5s4WCLhOcnamWCuXD7iGro3YmNVGELCoEECwZpvsRlnJ0Lm8W7NpE/0xC4U5brvcQG9P9iO9EGJinatcqY2fpKTy/XKEcMc/EJFbJj2QSmsmkXGNbEXAtOHcpmkdknmhxR8Icxic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801756; c=relaxed/simple;
	bh=rPPOr0JG4xhr2R0+yJyZpqv/ajLuzTC6KrkK8VdfWmw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJ6TvTefczm3Ljt5PJltKN33V1jgl3RU/xPTIetxyLV+cjxCqTIdTNkfoKydWY5fWG00fczSdWvcFDEwoPKM2nLeeGWKskqFJNBpYYMRbWVbMb/zRe8BmxDwoFiBSgGwiKy0A0nDaJMyzb1F1ISc42+TqmnE9mes2v4swSjSkMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPcXyU8/; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPcXyU8/"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66077ebd1d3so133869d50.3
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 09:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781801754; cv=none;
        d=google.com; s=arc-20240605;
        b=f6tCOuE4RtmFHVhmCIYv3JmgTFIDRjV65cv883l4Barqe8ixxmF/7QEY9MTd2xzSTa
         JiMyVofue1hUeXc7o5byux8IKui+F+6R6CEuLAC7SH/PyNNVluKUHo6ZBQvjRimu3qVE
         mH5UG9yED6rxRuU3Qfs35Jxl9hlZzttGPogupfyuOLm6vYtNl139HsS5JLNT/nnjukqD
         utYan1FJH4OTQ3/572+rgVTrKuBYO3BrdIwgShEejoCBr2SwVCTxwPLpVnvEM6CMYpsQ
         sotblDe0AMsdldGvX2zq3D9iCW+XWypYiEgqdh6V6mAH3Ki6MKeCcbRMb0d5hYTTfLEm
         lrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=bWncoALx8y7YAXsHTWY7bN7qmkvqPbp54N8U5jbHY04=;
        fh=s+H+D6fy1UQtX2LJtmSJKuDEoUs7Xb80NMjGQ6mPops=;
        b=NnLymYT4ahP6BaggW+b7SjYRCiYGEjdb81cP5p+CtPLMbOWybFbM1wiZWYBoVJI1lC
         fP5ddLOKCgFLdf34gmpUhACY0+ldXWd2QFBx/V9OqEVxcTycJ34usn0FeglDgdyVlxlH
         Q+44u63Lj9a0tg4zQ7Dofl50Fdp7NYNqL4oW+upxIidO41dDYHpX/tYVDrqe+EA5JTlq
         ZnYNqnp4hejN3/s1bQg9/aIcLJP+DwCQqb3dUlfPkIo+TirWMMOe9nZ2DpJnypwkWaBW
         2FEyIY0KSJySpXuAB34erJ8kvZ0NvTRABxQWK1Q4dSKTzFzCFBe8B8MYyJHIiQ46qQLK
         ZXzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781801754; x=1782406554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bWncoALx8y7YAXsHTWY7bN7qmkvqPbp54N8U5jbHY04=;
        b=PPcXyU8/Ww8Uq1VdUAj6flPfj1iBLqtB99smFDzM4PHIzaK9/+N14KYmjWNOiIpx5p
         /4mLZpgEahY4aVghucsJHb7mmsBn6mJCXPDAgTyRTpTlIIW41ZDntzjMHbIGh8hiAQY2
         YOEJYnZiFNKJqTa4OxQy1f5mdgj/cm9FinfmTQNDXN/VISkK5/dtZzXyIF2gmt5ZKxRu
         bgJ6+L9QZNlIyz416oV5l/DEx1PFw7OPULlBlaym5qlQlmmvlB/k5p/Sa0bAbQaJgepm
         xbcIFF3SxhqF6BCoZcjS9kwp1TKHfH36OvN0+jtwupAicImAxp3JowMsvdF8gHDap7xC
         NmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781801754; x=1782406554;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWncoALx8y7YAXsHTWY7bN7qmkvqPbp54N8U5jbHY04=;
        b=CxjI3IRvrxl93aVxK3xNvwUPBIFtjT3WGJuFqS9lIJD2lL1VgNco8obMPPHQOLOMRn
         cPl2tjTiBfE9/X1RIzYvRzSeGrIzK+hU5QXQT5jHLnARbEsVuY2QX7p8kn5UHjFfxnrI
         Z2f50olEp7C8n5/DuLjt03vWNyAdwRxiqrLyxso1RgYqE0CvxvLokFvxjNJuGsyVr9BV
         ZwPw+ORrKCiF2vdqU8TRQLYPOyuXVewrDeRYO3QOjB2BUU1Vd7HGF9dsXEtYGimZvnGf
         I1a+P1z54A6poU/3zIwOC3tEHZWik1C5Uk8fZxawedDRCt47TtqM9UBJC5ZV2ATntxjH
         LcjA==
X-Gm-Message-State: AOJu0YzowFYncBBifdS8we9KeDmTYshO0VRFQg4sJwwp2KvOPdDBznhW
	PSmvsbNek3+OtVtDn+WEtNri4W+pbU9bxhYyxQA6IV1oUTRduDnbdO2uu5jH5HXio0SehTC8YML
	zyk+r2MDDyiQ+WDht8KEkL0ydf4CJS3E=
X-Gm-Gg: AfdE7cmnhr1lQrdB5NuIaL2im6OIOpTTxtFnoPBj+4NqivDgYzvIE4qSjw/XJi0WLcF
	osHjki6BwasCUYe4LxrMsxhkJJs9iqRYeczFbIpriDmAZLHW4sv2fQpSbv4jcjWKmVe2peLHZcr
	bt42y5s7cTilUATRVsq2Jd5wttxITSd10xwQlHlLoqZZ6iQ22pJARUlWlRPXpiUv3cJHqDGkySn
	cgAUY+ATE2iJK+yBGUjnjMsr6iOYn9XL68JJHn1IRuGBYPDgsvC2rvjmINzw/9aKO8A9L0=
X-Received: by 2002:a05:690c:d:b0:7b6:40ef:6fb6 with SMTP id
 00721157ae682-7ffc7ea1c61mr30001467b3.6.1781801754498; Thu, 18 Jun 2026
 09:55:54 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 18 Jun 2026 11:55:51 -0500
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 18 Jun 2026 11:55:51 -0500
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <326b85af-c41a-4387-90a0-60720111934d@linux.dev>
References: <20260610175651.647515-1-ihor.solodrai@linux.dev> <326b85af-c41a-4387-90a0-60720111934d@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Jun 2026 11:55:51 -0500
X-Gm-Features: AVVi8Cd8zcauPYY70qCYHcPTSLhz0VbjxmEcRhSzqIS7BkkbKJS50phWPBzrVPY
Message-ID: <CAPAsAGxSu4JmiiXsXMebcH3dKTD89ksYUL_BtduHffgKbnwEAg@mail.gmail.com>
Subject: Re: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86
 under 5-level paging
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Ihor Solodrai <ihor.solodrai@linux.dev> writes:

> On 6/10/26 10:56 AM, Ihor Solodrai wrote:
>>
>>  [...]
>>
>> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
>> index 2b8e73f5f6a7..b5f430f2dbb6 100644
>> --- a/mm/kasan/generic.c
>> +++ b/mm/kasan/generic.c
>> @@ -9,6 +9,13 @@
>>   *        Andrey Konovalov <andreyknvl@gmail.com>
>>   */
>>
>> +/*
>> + * check_region_inline() and addr_has_metadata() can run very early.
>> + * For example, in an interrupt taken while identify_cpu() has the CPU
>> + * capability bits temporarily cleared.
>> + */
>> +#define USE_EARLY_PGTABLE_L5
>
> Hi everyone.
>
> Bumping the thread, as it's not clear how to proceed.
>
> From the discussion, we've got three approached to the bugfix:
>
>   1. USE_EARLY_PGTABLE_L5 in generic KASAN
>
>   This one is probably the simplest. We add USE_EARLY_PGTABLE_L5 to the
>   files that call addr_has_metadata(). It's KASAN / LA57 specific.
>
>   The downsides are a performance hit pointed out by Kiryl, and that
>   it's an arch-specific switch in generic KASAN.
>
>   2. local_irq_save/restore in identify_cpu() - Kiryl's suggestion
>
>   This looks like a better fix addressing the actual problem of cleared
>   capabilities being accessed from interrupts.
>
>   An open question for me is whether this fix is complete, and whether
>   the scope of irq_save/restore is right. We might also be ok with it
>   even if it's potentially incomplete.
>
>   3. Static key for LA57 in KASAN - sketched in the thread
>
>   This is essentially a bit better implementation of (1). Still KASAN /
>   LA57 specific.
>
> So my question to maintainers is what approach seems best?
> I am open to other suggestions if any.
>

AFAIU, this is not only KASAN's problem, at least in theory, so #2 seems
like the most appropriate solution.

If we decide to go with a KASAN-specific fix for some reason, Instead of
#1 or #3, I'd suggest using kasan_disable_current()/kasan_enable_current()
in identify_cpu(), the same way as as we already do for a similar
problem in apply_alternatives().

> So far this is mitigated on BPF CI with no5lvl boot param, but the bug
> is real, and I believe we should fix it in the kernel.
>
> Thanks!
>
>
>> +
>>  #include <linux/export.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/init.h>
