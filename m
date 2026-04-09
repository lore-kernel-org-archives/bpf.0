Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE82309AA
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 02:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701701; cv=pass; b=JDis9EJNBBtw8LdrIGzQiHG0Q5IW+cJ0rdsqdyYdGXpWfdFUvrIKzHnurDKtIcUfo20+eCpbu9lH+3Jl+YVMlrW//TQ+qcy++7lN+AOVFW7gIVjL6P5h+OYaKG4Hotug9zTjACXfCf3vMHF5qiHGhCca5akmAtk+woRagHjTJTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701701; c=relaxed/simple;
	bh=Wsjd4wf9kaem2S35Hl93re5ukqCSWQjB5gwANngiNC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSkjH9ZjSoc267ec97mI390AvtE5KKvuLeaqqXKtyD6oWpLbR8SNjwWGuMLWnj3PVmuFprKDSTf0O8C0VbexWQIXI5hL9X5vdzQITJ4mUk3XSxLBbhisu1SXVPfAoXqQR8/jeReZVko6pn7FIM7E7XITmAm/x5dsLb7NtBn8Wcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY9wvrbN; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY9wvrbN"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cf5d14d6eso191504f8f.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 19:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775701698; cv=none;
        d=google.com; s=arc-20240605;
        b=h5NS/Yu0wJaN2tyM7T7C5qqXW8OnHvYAs59HcZ3/+8zk+Wi+LvcEBG6UzD6Q6GqLhI
         fMsnD/Fo8ytCKaXn5QcXz7ltUYO6JzDz8Lw8thoNsqztFrkUI5zcSXAoiIZ2CgKAvTLU
         jlXC/gy05lwxsqUdDjOoG+v2N5jt5Kx8I8GXlS8NAWB8PRS050kTg06SqZmeSLR28j3L
         oXyDETtYNLzj8BAIl6gW8QqeBlM963JPlxpaovla56J4sZDaL7RK8J3bfH0yvHy6PeWl
         GNcuAXmjy2H3EEqOR71bcGGdFPqbCPZI4ve+Rgz+kyR345WR1f5Zv8Mo3AB6BhRKdnX/
         og+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z3bd+PHd9+tjI7Jp5TgPURkM2f0KAKSiJC2HCfcIIPg=;
        fh=hfRje2veXRgnK/5UbF368BTRuTdPC/oA5JvW+CkXkIA=;
        b=YjfKKGzVzR0smrmXVik3DuesqcafySZ+WsNA6yCuzI4vfPTnBbfV3+GuzlxG4qBNrf
         XNjNLLZBT5R4KKqfmNmQv9A9fIAeQW8YwyOEfIId2cmBmgN2T/rYWAdDt1n23q3+bc3l
         wtk+BTD2hXXHcg98/LCwAyE7P53CcVaceeQ3dINgP+wVdrRWsRkEvRSyYG3Gw2hu4B0v
         G/mrIJ25DKSiqlca6uL1o2Wci+zDFHj1JcS2n19bwJBseImyr5uTYXsS6Cb6i8ztLmDR
         YZzW5dxiaWd5xJEWatpyDSAqYSg6xiUAYOVyrgdPkLdV/+ApUO75JiCjiwjk3FAKQrTu
         BwGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775701698; x=1776306498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3bd+PHd9+tjI7Jp5TgPURkM2f0KAKSiJC2HCfcIIPg=;
        b=NY9wvrbNFcfcFntxGJnT+b6+mHAPJcyuQFOU6mJ5/lHzVsTjalTozX+cFdBfEXS7ta
         HoGK/XB4KaeBpkxfNxG1z7W/MWMe8UHok52klZUJmeIl9v784awlbVqsA4ZJjrsR+aRv
         9T3RC9/AhjtF7La2B4f/dPUKuaFGPyPStFXYbTnnPGWCDjzdd8krg1q7XEJjkmGvbI51
         crCNrCNl5i1khiXrg03HyOP9mIdORMsfhN7i/yHzAkAvtBkTLqkDalp+w/qw4x2kPm2R
         vgNyfOhEvzaoQtD7r6A//p7fbpYhf/2DT/di1gsaW67jEcikmXnkrsNUsPVjgOhtIQww
         AgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775701698; x=1776306498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3bd+PHd9+tjI7Jp5TgPURkM2f0KAKSiJC2HCfcIIPg=;
        b=Mxtoy18jlp2WvxCWq4cFJGMG8BVfl1nFp5uBtIb5GKHKg+LYPnAJE7tojkkxYPgpvC
         8olk3ThQObiYYlNLKXYYC9gecojm6FjUpni6tnZKbWGTb7rEYtp4PhnqeZ00monFm/Ao
         JLkqmbeuqghQlPAx7V4rSrZ3q4dWnQ5XvSbz3xKOWPMc+hpiODJr+8OdO5gO+jjfyLGb
         xLPjce/dRZRMWAuKn+Fp4RRmHXS/9oNaaL72mCSTnlk4b1KFDNa7gL3Fj0CsbN2jrFu8
         wu/u0Q5xtNhszx5yjPwpBm931Y9I1akKW8xcebPmGaM35uf8RMu1yUaZiQy0U2qCMZUw
         6LQg==
X-Gm-Message-State: AOJu0Ywaj/TasFBwQvReyVtLdTetnMMhuJJmry812/SrCP0NYxgHAZXp
	vnRtjnB36DPmngOc7gme1UxG/W+sjRq26IA8y5y21N248lamOKz2YdENDwCPjI14JrnAcfpzBem
	dzvwGIusOtzZzAlafYW9T+sq1/vISWP8=
X-Gm-Gg: AeBDieuprSZsIOb8kW8tE93K4OF0BlQ4W2o2YXUb7pDtL2XLKmlhCdgezoKF5DiyvWK
	vJwfFnNvD/e37s7a4+Acz2jyahlgtj9NZi7x+NKhkr9iGUt4tt0vP5oSDwGhx43nhk8Blx/NATn
	SYjAbXK4i9VOXfZ929mavoHF2ciuZoCTFHQc3qXy1oHXextD9bRTaOdY3Zzs/qK6PdAYU0XZkjj
	h7YHMatxkt0r4DRbNyGonKdAk2lDcOq0PvJ4gNZedEZAgEqwSYbnAaeSZf3SUmD4ilhXP7Vx+CT
	chzzf+PO2lTz/HvMJXeQl3flNWq/55kV18pfY5Df/KBJlAZX6u2rdv02DFkb9XkmGQjBaGtFWHy
	SEcJAvyeebEBWrtZYYqvbEhY6zw==
X-Received: by 2002:a5d:5d08:0:b0:43d:500a:1e5c with SMTP id
 ffacd0b85a97d-43d500a1f0bmr8281093f8f.26.1775701697902; Wed, 08 Apr 2026
 19:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407045730.13359-1-emil@etsalapatis.com> <20260407045730.13359-7-emil@etsalapatis.com>
 <CAADnVQLHFZE3AFzP3gtZKvcaX+3hbp3pCw3JLqEtpdoQ+OUf7g@mail.gmail.com> <DHO7DJ574EL1.8O0NIINEBJMR@etsalapatis.com>
In-Reply-To: <DHO7DJ574EL1.8O0NIINEBJMR@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Apr 2026 19:28:06 -0700
X-Gm-Features: AQROBzBnZYOJRdGG9R8wjuhCkYD0S2Lwqftlv7mGHSIdg9NhWpK2CVPMbC6tuYM
Message-ID: <CAADnVQ+mv56x_0HftRzwWkpiBK-3ZmW7wCXUVa47UVDqmFeCCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/9] selftests/bpf: Add arena ASAN runtime to libarena
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 5:38=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> >> +int asan_dummy_call(void) {
> >> +       /* Use the shadow map base to prevent it from being optimized =
out. */
> >> +       if (__asan_shadow_memory_dynamic_address)
> >> +               ASAN_DUMMY_CALLS_ALL(NULL);
> >> +
> >> +       return 0;
> >> +}
> >
> > so every bpf prog with arena will have this asan_dummy_call() function
> > just for BTF info?
> > It doesn't smell right.
> > I think it's a bug on LLVM side. It should be preserving BTF
> > when it emits calls to __asan*.
>
> This only gets emitted for programs compiled with ASAN, so it's not
> there by default. That being said, the issue is ultimately that LLVM
> doesn't inject debug info for the __asan functions. I've been able to
> remove the dummy calls by adding a postprocessing step in LLVM's
> AddressSanitizer (github.com/etsal/llvm-project/tree/asan-emit-dinfo).
> I've also gotten the dummy definitions removed by replacing them with
> a function pointer array, like so:
>
> /* Only required when compiled with ASAN flags */
> static void (* __asan_btf[])(void *) {
>         ASAN_LOAD_STORE_SIZE(1),
>         ASAN_LOAD_STORE_SIZE(2),
>         ASAN_LOAD_STORE_SIZE(4),
>         ASAN_LOAD_STORE_SIZE(8),
> };

yeah. Just this array of pointers is certainly much better.

> Wdyt about either keeping the dummy calls or using the function pointer
> array for now, then removing it if/once an LLVM-side solution gets accept=
ed?

Ok for now. Pls cc us on llvm diff. It looks landable to me.
Explain why it needs to be in BTF better in the commit log.
Since it's not about debugging and not really about pleasing
the verifier. BTF is used to link. So it's part of accurate linking.
Since we don't match by name only. BTF is our way to avoid mangling.
