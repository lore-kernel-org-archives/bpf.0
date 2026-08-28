Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8108D40BCBB
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912192; cv=pass; b=BVlASwyizwrBUMt1N/k+ApkT/jQ3di6SaD2sjM87pSGiR2Y/IyeOM2XNIpnhFIe8tYzbhBfdjbF15alr0qJtFpxvYCEfUtiz/sbGm8OOUN2QZKkSL2bhssmXu2ZDvVPf+HRby9tk61K1trJJjwdYke5cdZ+49ow+JkXMN2aAFH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912192; c=relaxed/simple;
	bh=9nPb6ofpYX8RiPQ7x2iuJEPkGK91/1J8FKtfNZIcC5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HV09VSq8hXott3hWYZUiqatRtcBGuIv8U6i7EoQDIi8hhlU/4FH8TYZO91KVvglqbtMzQNP7XFc52tA4FuQq3QBwIwlk3dhJkQPMKtGbITE0qnsn9EiogOKYPp0L2NBoi3vVgvBQv7a4ctBl7fG+ZZSgLPaePOH303rQEO9lAgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=none smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b=eDi1EAHE; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b="eDi1EAHE"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bf8e1edc3aso647676e0c.0
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 03:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787912189; cv=none;
        d=google.com; s=arc-20260327;
        b=U8VooJFx/vEwFPyg8UkeI4bImRokMnqbXsAsp3BfbJJlfwtAfTv2i38jd7sR+F/SFe
         TGy+GjVa3t6zbSdEqra4L6j6a/lf7LEXxBSr4N3lwxpIYxWgLCAQ2XiQOLy36FyDjhYD
         bGCP/i634QXUGQlLIXL4RhWel0WvmzWJwrhxUCjqaQFn6PkmQPBQE6kFZBvla/sP3IiF
         kqZr/NboQQkg1HTONj7l7nmfctccXdnDAMUh0kLTKaKYC6eztPUYknVhZLRX+2qqAO5i
         RldIJQe8o5lxkmZagg6DeXJWLIXvmvI6QmXfhYklo03gzNKAZ5kmJsz+nPT8cSUFueQd
         oLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6GcVt68ylb4fqLmficxbeoWwxWTUsNtsQKfhwJMCoe4=;
        fh=Y/2ixQEA5nj61iCWVRnP72RLAsq/xXGTLp1+9E5wm9E=;
        b=HUQE2BMoHIlTGGDPsApbIgFEwZiMe3mLTIGJVfE7vGZQO8wXWazgVKTmnq+kP/J3ty
         EGkIhCRj172FZ9dsfMA+5YeH/yGG4FeyzZLg05rvktTCM5dFeQr6TZnlXOPgxOy6mPJa
         oMbtjDANWfxIUUat+w9hEH7uBfP2w+jfjQWRnWYlM3N4tq+6DYKvd8xIaStaic8oEp5q
         lXW2DYwMXQxEGaiC+VCYWniV5W+2aqa3MTf4A1lX4Irn5++ePiPOIVfV1D/8aKy1GJHN
         6jD+JkuudEc+U6n9a0gXLwQML9oi66xEeCPMDjxKro3duw8Wh8sYB8ZXYwpVkcSZ91xV
         NzYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20251104.gappssmtp.com; s=20251104; t=1787912189; x=1788516989; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6GcVt68ylb4fqLmficxbeoWwxWTUsNtsQKfhwJMCoe4=;
        b=eDi1EAHEZnV8UO/NrhF4uzDO53/ZiBqe/Kv6LlPMTl1AifjnJFoy3N7vl8W54G2rrA
         2xGtcLViQ6E6TajV3LATlqLSrIK4+DtympTvOkkbRVZHCDB6RacvwJ7CPPDE/wW6YeTX
         uxrK98gVIaDpR9GKb/hPnm7ODAtM3r4KvfBlgB+Aug+U+k7whdR2Uk3otkCkkG2RdjhJ
         nmF7fSrrOry1e4Pw+qwkM/VDMvXTfwBkp1Vbp8rgAT1II2Ot4WBQQuwaeJJJdvgtIyHA
         O+WwqciUVopEQTvIDGa450fP5ZMTIxqTR/P7LYQuYSlteI3ge31ORyszsMnD/HsiSfya
         g/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787912189; x=1788516989;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6GcVt68ylb4fqLmficxbeoWwxWTUsNtsQKfhwJMCoe4=;
        b=lBaqwaNWbH5ng56E2pkuY8QD5QlrWqnGiFNxTr9dRg8fy1Om5M0nBXqIkXGgqvnG3u
         3T4NTcfZ2lTzhjOBVzFNeyVzgZ2W5G/G6JA5/XIZk0HZgNAla3436HyCpl2qA/67G038
         8sZeDldKeBxxHFvhEjjEQdahdvXThgViz1CQljHzvo4Uje/9nkqZM4I/KM0bRWd1nT+y
         GgfBb8L3i9gerTOlTWcjFCNLAPS1BA9qE2SZLLtv2ybfaUmGS8f6KuxXk8ZsCzrhrdfE
         C7wKpt2zzg9g8FW1ed+SU3TZoeG0uuhEEU49Kyo87o7KbPoTX3d6HOB7/gS/+HiCgq12
         +IFw==
X-Gm-Message-State: AFuF++kHoazR1juKbRpcF6ehjHGwm3PBtFha8VzsCSAU13+m88myn3Kz
	J9lutuKG/zqv6THEMvhVRnmA1AmgzjlbZzArkewjRRW1ndRgJG0YyjrhqUPHa9MhTr9zz5QPayA
	765wtXDghiJWlCUwkQYzE8Og4ztHzPgV3i5bxJlTaZw==
X-Gm-Gg: AR+sD12ATKoTjJXDeXGeySfal16OGZ013KzwkoAELlRwuXmMXNi1po45Cozw+OT2RHE
	zWjOkhZa4Y8LLYrkwodCtrAyw9S+3+JtzThSTe3ptG11QjLywqm0vT8g4cQhGkiQ3h94TVBMf5D
	wHLD+YS741H51Xc0tO0QImeOtBqDqHzgRH7fHPIMNNSssvXtoGxbM8RVyTzL1swC57VTqGUzrFC
	YdZH2jj1T+eLZsaCPlYSLuJ/LolSkr6R6fl9Hx+AhfjBMQw3RMIIHSPHRrDxJ+jyz5UjkS7CKPK
	nk3iTONhJE01EFaX2wciuTZbGNcLUU7dQodrNMp9GY19
X-Received: by 2002:a05:6122:88a:b0:5bd:8c84:59aa with SMTP id
 71dfb90a1353d-5c681777357mr2723173e0c.8.1787912188834; Fri, 28 Aug 2026
 03:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819010523.1057789-1-main.kalliope@gmail.com> <20260819010523.1057789-3-main.kalliope@gmail.com>
In-Reply-To: <20260819010523.1057789-3-main.kalliope@gmail.com>
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date: Fri, 28 Aug 2026 12:16:17 +0200
X-Gm-Features: AcwNN1UufzODx6ajZ2Cvlnuoud8Jym1z7VvkRIkj38LXxzb7tykFlkvxDcgn1Wc
Message-ID: <CAM1=_QTDhirxjCmXUqvPqTqXMY=uVVcPXE0H=qHH_B+7XFrnpQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 2/2] bpf, mips: Add support for BPF_MOVSX in the JITs
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, paulburton@kernel.org, 
	tsbogend@alpha.franken.de, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nicholas,

The MOV/MOVSX structure looks good in general. Some remarks on the
implementation of individual emittor functions.

> +/* Register move operation (32-bit), optionally with sign extension */
>  static void emit_mov_r32(struct jit_context *ctx, const u8 dst[],
> -                        const u8 src[])
> +                        const u8 src[], s16 off)
>  {
> -       emit_mov_r(ctx, lo(dst), lo(src));
> +       switch (off) {
> +       case 8:
> +               emit(ctx, sll, lo(dst), lo(src), 24);
> +               emit(ctx, sra, lo(dst), lo(dst), 24);
> +               clobber_reg(ctx, lo(dst));
> +               break;
> +       case 16:
> +               emit(ctx, sll, lo(dst), lo(src), 16);
> +               emit(ctx, sra, lo(dst), lo(dst), 16);
> +               clobber_reg(ctx, lo(dst));
> +               break;
> +       default:
> +               emit_mov_r(ctx, lo(dst), lo(src));
> +               break;
> +       }
>         emit_zext_ver(ctx, dst);
>  }

I would move the clobber marker to the end to reduce code duplication.
That is the pattern used in other places in the jit. Also consider
collapsing the cases off=8 and off=16 into one, with the shift
argument computed as 32 - off. That would parameterize the shift logic
instead of duplicating it.

The above applies to all four variants of the mov emittor.

> +/* Register move operation (64-bit), optionally with sign extension */
>  static void emit_mov_r64(struct jit_context *ctx, const u8 dst[],
> -                        const u8 src[])
> +                        const u8 src[], s16 off)
>  {
> -       emit_mov_r(ctx, lo(dst), lo(src));
> -       emit_mov_r(ctx, hi(dst), hi(src));
> +       switch (off) {
> +       case 8:
> +               emit(ctx, sll, lo(dst), lo(src), 24);
> +               emit(ctx, sra, lo(dst), lo(dst), 24);
> +               break;
> +       case 16:
> +               emit(ctx, sll, lo(dst), lo(src), 16);
> +               emit(ctx, sra, lo(dst), lo(dst), 16);
> +               break;
> +       case 32:
> +               emit(ctx, move, lo(dst), lo(src));
> +               break;
> +       default:
> +               emit_mov_r(ctx, lo(dst), lo(src));
> +               emit_mov_r(ctx, hi(dst), hi(src));
> +               return;
> +       }
> +       clobber_reg(ctx, lo(dst));
> +       emit(ctx, sra, hi(dst), lo(dst), 31);
> +       clobber_reg(ctx, hi(dst));
>  }

I have tried to avoid returns in the middle like this. If you combine
cases 8 and 16 as suggested, you can put the sra sign extension into
cases 8/16 and 32, and get rid of the return in the default case.

> -static void emit_mov_r64(struct jit_context *ctx, u8 dst, u8 src)
> +/* Register move operation (64-bit), optionally with sign extension */
> +static void emit_mov_r64(struct jit_context *ctx, u8 dst, u8 src, s16 off)
>  {
> -       emit_mov_r(ctx, dst, src);
> +       switch (off) {
> +       case 8:
> +               emit(ctx, dsll32, dst, src, 24);
> +               emit(ctx, dsra32, dst, dst, 24);
> +               break;
> +       case 16:
> +               emit(ctx, dsll32, dst, src, 16);
> +               emit(ctx, dsra32, dst, dst, 16);
> +               break;
> +       case 32:
> +               emit(ctx, sll, dst, src, 0);
> +               break;
> +       default:
> +               emit_mov_r(ctx, dst, src);
> +               return;

This return is not needed. Replace with break. Consider using the
emit_sext helper instead of raw sll to b better convey intent.

Thanks,
Johan
