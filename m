Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDCF3C13FF
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390356; cv=pass; b=dmzo+I2J22et4qFS4/1+R/wNRGDAHTTAVBeSuuYzPmyHkTCrvWhUa6X8qvklDuisv+is0/+eFaTgQZexaehput6MjBHFRn2dDutvuiarYoML3ATpht0+SpDVWePTTDSAxNDwrDVUhNRGzE8cRbmP2h1Q+9UllcMUJcKXbbmBKb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390356; c=relaxed/simple;
	bh=vk73hlPq9dpBpIG78tmJtBik5PtnFcRb2jxritRBVN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJ+FapyBruYOj7sVBmfMyZXERMqhenr0leo1OBzwLgfe3vriarssJH4/s6vX/o6dLr2zaP9gC3l45tmbLs7GZUjdmo7nFh+u8zmulW1UcdPFBAD2dBj7W3oZIsH1Vw7OoOXaI8NRUzqMuhZO5Jksq0SrUH77LUlU6k7tL4goVJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHMgd/kH; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHMgd/kH"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48704db565eso35665375e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774390353; cv=none;
        d=google.com; s=arc-20240605;
        b=iF2jNIwwBJNR0nwqtD4cz07wv0hFxEX4pAIX04Y1uD4Dm4JjudeN9ivAMQPdJ96pBz
         rIpsxSo6MQQQ3R9Zdqy0nlikXN9LuCl5JJNXHvwfdil99mSAUoZi3SqFoaMkvakZeqAT
         Dm/hJJlkFm6SG+7JzEXMQQt6tLIVfWNYDACkQqrQ2JwQrVFh27lPUhEYB+B609KZeQsX
         6virubpMSmWNkmS5uelq4wn3RQc10ENCELr9Yk1Fj0pWisXGlpgFv0y78O35MjWVsz3p
         tnAWndC0lntRAtjKBrQWaJ0f6RcS2yBY+DLcNX8xliemmkpH7g56ctxfE/il5cSRPBtT
         1Mxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kp54/l9qSAFn0F5Pkk228Vj1tjFpowG5w90PKDipm5Y=;
        fh=9Eucqq5vQ5myrTLYAMkb1pusjK6Ea69iu5P+Jvr7ylE=;
        b=Gi1aT91oe3XB9VA3bTqbWJZxZulGWfC6R77E9g3JN1Egh8RXmTKSAl+KqqCcizD284
         KUqH4MfTPH02NiYyTagM3SHJqC4Yxa7eKh03WjD673QesRnGuaj8o9n7hEfp1SXPu3Pw
         EO5KhK8YM5zyVcqjS19QLKfpIKcHmJCw5MEYuubLYPBwfQ84FRIBNoMiGiGDfKLAEebO
         kB+dLGSvSvsEzonbHYjk4s25B52sDm+yREuxWIXtSCEXl9tsIgMtl/f54YJFijT08bqa
         dfnZ71qFhFMcrvgScqufNvDWg1VqglN+l5NqYdrBlfBI66YTaSyLPI4s2y6REamB+HXn
         HGJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774390353; x=1774995153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp54/l9qSAFn0F5Pkk228Vj1tjFpowG5w90PKDipm5Y=;
        b=KHMgd/kHfg6zS/lL2qzdhM1WYz29/Cyn5YsvI/ChoUtzsJMOZuMWas3Mn+NSYH9meR
         GFyWCiVHXstbQd+T1SxaIpnByIPj73h6ygasQbmEYsaDHJoqGoQHW5D2QWO2H7+NOxQl
         xcJA01VH/ii87Jmtix2s4xvCSSuCsb7iI8wQk0ljgqjdGEdLUTJgwMvqqRK6a0nKc+du
         KL5IzReaWik5oS1LryYI7HEgOlk+L7SteRMA4HNXWSsxEStamKvTiIUw7QmMBy4uc1lE
         K49RpCB8RmKg5Vj3JtvymAQzP6K/aXLG/skOPdVAT+wy58Kq8Xja4SWhzlGNq+Pxsk6A
         9YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774390353; x=1774995153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kp54/l9qSAFn0F5Pkk228Vj1tjFpowG5w90PKDipm5Y=;
        b=XrX5n6KIV3zBEYRbFAa1zXxgRz0kpOrHuddRY2itrlys9ek1FYy2fVwptVdsuZYr37
         s3lGC2LkIB+4kIRtTqILnaxvsCpwgcRoLy4qnTkv6to8OJd46moZaYCsse2t7Q1hMMsD
         SxUH4Ku8UL8KI3z+4126hsIARUw5iI6l07NEnejp2Gp6KVAib7bd4eE8RMchsnu7vtks
         ogy2gblQ41StMtwn7Ip+H6toPWfrzn/36QKWY0YimMAZZwFDIO+PZoeGUiSURuo6gR3+
         irz3TO4sMoFSZYvWtRz63gOAikiWKLrKEG84v8tfeT9hYqc6YpduGtK4sMczw5I1dpUV
         jlyQ==
X-Gm-Message-State: AOJu0Ywz227GvrCg3+sAzMozlmqbALluYkXnhE+RaaIllvj9I27XpCHH
	KpfjoJF+HYHwo5wOdV9XJl+XvQZG2UNcuUN7M+7SiKw5eoElKK/tclTluCPdV2+L3bupYoCoanV
	2EBLrYc2N5dRkudsxaRUaclDAC24Bd/g=
X-Gm-Gg: ATEYQzz14nSzWUOYqI6QB6py2ms1bJ4G0CXRD65IFmZok28FN4y8FSuKnvGqP89BtOv
	3KjB89aLeR4CXFNTvWXm4pjw5grKTjnQfv3cta/XtYQfpjtRjMLP37rRSHSToEAm8sxKzekOZcM
	u8AzFc0TRpy03kakroGqDT52LkcpcSluZfkT6K5gw1k5Ft6GAFu8SpCbolmbBKmf96MB5QOzYiE
	+YxoBLo2+HM7SUjlscZXFNX2DgS46xEi/974KMH+2FkOpPiJsn8aRL1OjVDUwFLijt+E50E9mL+
	x5beZ3yGxcMfoGQH5eXo1dvNjMs8i2VFnuoIfLtANSmC+7PlWvDqe8+aQE1C+LDQpdgd5G3jGZ+
	D9vZwmK4=
X-Received: by 2002:a05:600c:1d1d:b0:486:ffa3:592 with SMTP id
 5b1f17b1804b1-48716071b2amr19574505e9.24.1774390352884; Tue, 24 Mar 2026
 15:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324215938.81733-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260324215938.81733-1-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 23:11:56 +0100
X-Gm-Features: AQROBzBAmFbbGF16ImVkG8VQg-TQJjnlGdZD3Gh5O9maD_lJp3_nS9Tz0XHT5I0
Message-ID: <CAP01T77acGZnCQTW08aG8ZgUNhswTJQsTgiHQ3-ZQ1TDXQ+wrg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix variable length stack write over
 spilled pointers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 22:59, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Scrub slots if variable-offset stack write goes over spilled pointers.
> Otherwise is_spilled_reg() may == true && spilled_ptr.type == NOT_INIT
> and valid program is rejected by check_stack_read_fixed_off()
> with obscure "invalid size of register fill" message.
>
> Fixes: 01f810ace9ed ("bpf: Allow variable-offset stack access")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
> v1->v2: factored out into helper
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  kernel/bpf/verifier.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 70a100dd4d0c..11207e63c94e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5251,6 +5251,18 @@ static void check_fastcall_stack_contract(struct bpf_verifier_env *env,
>         }
>  }
>
> +static void scrub_special_slot(struct bpf_func_state *state, int spi)
> +{
> +       int i;
> +
> +       /* regular write of data into stack destroys any spilled ptr */
> +       state->stack[spi].spilled_ptr.type = NOT_INIT;

nit: strictly speaking we don't need to keep this, right? It's only
checked when slot is STACK_SPILL.

> [...]
