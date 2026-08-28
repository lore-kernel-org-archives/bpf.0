Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E836E466
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914205; cv=pass; b=mWiXuY08PkWeJOdCdzI8opgTJnGo8BFRrbgNoPmKWSnhqsFz/5OeyCQJQAH4RUCoo/yxJrzgHqn/6Y/r68hYPqNAYRpFuqKFLiW6r8Wms4yFW9s1FcOsk/p96LgSz98HCqzTTvcznxAnpBDJpgCzzOWhoDKaRDEz97bG2Al01Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914205; c=relaxed/simple;
	bh=/cmKlDq8DFYSfOEtJaUMv5tjE2XNmgf878iFonULAYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/+i1vJYHrBqu4+04znllEFKVQAIVxIeJGxr5oyCyah/fueIWl7ErgZrcdrXSVtDu4j3g9qNu9DWdjgXu0MElexbKftPr46vJoVnwLRtxd9YYkyiiRxTzFnlSPFvcUvJe9T71VzSZid6aIIoBl2CHfL1QeGBX9jWAI7r+vVi/FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=none smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b=hk8c+ewE; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b="hk8c+ewE"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c652293bcdso864534e0c.1
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 03:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787914202; cv=none;
        d=google.com; s=arc-20260327;
        b=MaT7ZpEILjZTFnR2R7FVwahrLERCV1+d1qtbQihAVQf7pLHqY2mpWfT9n8P08y5aRW
         cWRl4/Y6qttKBEXAQKwx2bYxry32hDi48y2OxCUxvkMemQ5VASvgCOevMa4Br483LFc3
         n7J1Xx4dtnbdyQcORMmRt+0Jj/2Jlk/d62RQ0usbtlKV/GPFZoCZGjgByNWPRoE+Xttq
         n+7YKSCfaw68fe1qFpyLMBvH//eGU2lBIjwPL9bIWJg8BZxoMhmLcScz31VWuo8VbbNC
         zN4c5V/Zn9xBOK65ji1d8+pl2eRocvHfXcPOlG/V9utIRVH5ugSJWBeDgQADGzvIauj6
         LuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u8lFH0HcIkW98kTciUv5DunOUausL9QXc09fXIwSfCY=;
        fh=WoqQ6PhBFU3cpND7yr5ZQAvHBPtLsQfLaxtoIRxbaS8=;
        b=UKE6AI8VsLPhVdLz1MmYp/lNWAho1rxG9OsqrvXDpPAKB3LsPKdb8mw54h5iw+HJWM
         dOAWDUduNRB07AGVfrla0HrNeY6/PSgy7yBjqdFOnecx26trvqXNtJNeC11qTatjWEbO
         mz/8cZHIKtJhTfFWJsSaSpLkMquEvYTjlD6FwO0jLn3X0liHQv+shPNMOO/UzDJ9WZGG
         j3nvuqO/rfNy2c5d46qUocNI1b6UFWUSjkV3sz33JSokMLgzJMI+Lyx8B8ZLxkzvtp+c
         IdpphD0MgOTJrjQyI/t565Nb5XQJPgdnslq7SJdDzR3usOg6bjmRSAF3GveFBxGniJk6
         sUCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20251104.gappssmtp.com; s=20251104; t=1787914202; x=1788519002; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u8lFH0HcIkW98kTciUv5DunOUausL9QXc09fXIwSfCY=;
        b=hk8c+ewE0E7JdEzNTQ4K9HZ8m44/906X7j2n5FSgllioAW6FiJswuo7vLJ88sz2km3
         /I/imYCSm28c/IPK9f0Ts7uVjTpWFKS6tQL2X+JWo84oTZsn23RgIB0B6J7NGQVWvNWF
         DoTzs7SMykRzGF9gE9Gw6b5uwTDWsIv/Xutdrq6QclZ0EA20SvVh45diZ2lGRaSt8Weh
         zrMQtNvgLpKJm/vzUVXbEbwb7VLdM4H4EofD7szdp9nwXHqzUyffnytTG+qWRV8UM0bQ
         PyNav6Qnnr2NvkrFiWXLnOtUkw5frqGaSsZc3m5Gha3tSweh+69ePR3YVUn15rSv0h/d
         XXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787914202; x=1788519002;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u8lFH0HcIkW98kTciUv5DunOUausL9QXc09fXIwSfCY=;
        b=qacvtLF1UYTC7cJaIQI0IWWk+1VgYwX+PUusoD/HkBfcXCqXpWQIVlB4WeBn+FiACS
         Lp+SzrJ+uIxhEAYgpeN5ylXFFeErGth4tVd200Au/Av1/xxLX5iPQb03CI77OKdstwfG
         cmCUsOGuymD5zVwClp+uFCDblKB4msAOs7nmlTPKVHECnxF1SuBHKOrtDrOsCHcptzmF
         I3Zj6QecxB8j5zVdlGe8pvgbjTojv64OmYTTEm+gYe+KVoAfqDg7ZKUXAcYf8guMa0o/
         vgDrqA16d6Wd6Emg9e+eHAG8wkEIkwAEHyk+SvpK0tz5CuzYZmh9vaVhIzAXlYvOz63+
         3BKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqdcvw13eB3/tX91287Uk4O89unTkL90gIfboZtnGdgX0arMkkncu2Bs78I1FWH7Pk9iZI=@vger.kernel.org
X-Gm-Message-State: AFuF++mjnbNhbHW72aHRa/HIWz5pc6ETniMy7SHi4TTbe+5wpwqx9Gnf
	CT0aMwhwXp8jMiEV0HksrYcVX2a7dVTnZKvTKq6pq3Es2NqGbMsxhAAJuhy4Rv8HENecm+8waF+
	5kyL4SCJwwiPj/fa+oh0RrcrFfp6DveZ16aIKspMdhQ==
X-Gm-Gg: AR+sD13tJf69qSdTVqtG/Dlkz+O0i2J84aP3QsDJZysPedvD3BwnQHuYHTRDlhw78aM
	2XqDHQxAEeh50n4N/PLLxgAyoW43E+M2KAmru01odMyeL+Va4LljPzRY6xAJESuaXbRtSt3V2kU
	TwYz8wIx24qXYuNHS2MAaHoeaMAhBRNTH8Wl+or+i/P8syhCMePenSnXcRdPROc+9DXDp//I8Xv
	P9d12MUcTU+hWuVCKekyoc21QjgQwIEfHBZETlnwdt7xma8u6G1mWc9ySH4jMPduDqYSX2oLmWR
	ThUf7b905ZSpD2ZS8gA96knw5dKNwJWQ89wIPmIQJEmT
X-Received: by 2002:a05:6122:9001:b0:5c6:7f44:b001 with SMTP id
 71dfb90a1353d-5c680967056mr2568641e0c.0.1787914202558; Fri, 28 Aug 2026
 03:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821024640.1601299-1-main.kalliope@gmail.com> <20260821024640.1601299-3-main.kalliope@gmail.com>
In-Reply-To: <20260821024640.1601299-3-main.kalliope@gmail.com>
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date: Fri, 28 Aug 2026 12:49:51 +0200
X-Gm-Features: AcwNN1UMwJxqSjr7UcYRArvxGmZya0K67Rn2WYUklgep4iJra1Tjsl0TpYlszf8
Message-ID: <CAM1=_QQTv--NiWorjiFSrF+Ua9XaBL1MobNZSOgFqOb9w1FPKg@mail.gmail.com>
Subject: Re: [RFC bpf-next 2/2] bpf, mips: Add BPF_MEMSX support to the JITs
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, paulburton@kernel.org, tsbogend@alpha.franken.de, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	bpf@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nicholas,

>  /* Narrow load operation: dst = *(size *)(src + off) */
>  static void emit_ldx_narrow(struct jit_context *ctx,
> -                           u8 dst, u8 src, s16 off, u8 size)
> +                           u8 dst, u8 src, s16 off, u8 size,
> +                           bool sign_extend)
>  {
>         switch (size) {
>         /* Load a byte */
>         case BPF_B:
> -               emit(ctx, lbu, dst, off, src);
> +               if (sign_extend)
> +                       emit(ctx, lb, dst, off, src);
> +               else
> +                       emit(ctx, lbu, dst, off, src);
>                 break;
>         /* Load a half word */
>         case BPF_H:
> -               emit(ctx, lhu, dst, off, src);
> +               if (sign_extend)
> +                       emit(ctx, lh, dst, off, src);
> +               else
> +                       emit(ctx, lhu, dst, off, src);
>                 break;
>         /* Load a word */
>         case BPF_W:
> -               emit(ctx, lwu, dst, off, src);
> +               if (sign_extend)
> +                       emit(ctx, lw, dst, off, src);
> +               else
> +                       emit(ctx, lwu, dst, off, src);
>                 break;
>         }
>  }

I would actually prefer to keep the original structure and not combine
ldx and ldsx into a single function with a boolean lever. The helper
does two completely different things depending on the boolean
argument, and the two modes have nothing (MIPS64) or very little
(MIPS32) code in common.

Another aspect to consider is this: An implementation principle has
been that each emittor should take care of its own "dirty laundry".
This means that the emittor should mark everything it touches as
clobbered, and emit necessary delay slot(s). You could easily call
clobber_reg() in the emit_ldx_narrow() helper, but it does not have
enough context to know if a load delay slot is needed or not. Without
the load delay slot in the helper, an implicit contract between with
the calling function is created. That is fragile and is easy to
overlook if the functionality is further extended in the future. If
you keep the loads inline in the ldx and ldsx emittors, the delay slot
lives together with load that needs it. Note that the clobber_reg()
helper is just idempotent JIT-time book keeping, whereas a delay slot
has a run time penalty.

Thanks,
Johan
