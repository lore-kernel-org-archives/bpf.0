Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA772622
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442949; cv=pass; b=Ofm2yraJGHsSsQPzLNCmSbFvp0VXmNpfBiGcXzCBDJXXVj2hf8VWUU5UvqltY/6v2Jc/VqsVjp3i2bs+BEULUegfv98JpL5M7Z9HhMx72aKjkUkipNTk4obmwROL/xaB2UFY0IJZcwU8W/gg++P2azm1JS+43l2pGl6SraKua9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442949; c=relaxed/simple;
	bh=HLeBPk6pMgiNzzhAqFm5ZWXDSxQ7YS65CAeJGbEDH9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3LVi6K4CvQIeCHvNNHjYqJLQNFVgPYrX8sfKBHtQzHcmsxZqO7HDMHqLr6btVf+VtUIVKzU+s6ZPmLnvALG3KuUh/LYcWy+AMSXDReM6bLmpSQ/dTq16lRzgbkJ7Fg2xyZumeUYTEmk+eJY1Bo1GsEZGCZuWsEmjSnHTB6+Tko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Umc7/NEu; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umc7/NEu"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso547663f8f.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 09:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776442946; cv=none;
        d=google.com; s=arc-20240605;
        b=dVirocDLRDOfyEZGEWIzmtaE8ghWdRBI0jErVMsa5+23VOGbAI1LZ1GS7rbFcjemzb
         bkmABIpCpmP0Mb2Yn082z4A8MOe6ZXS+mNIhdH62IRg0RR6Q7N6GaIuur2fwYJKoud8O
         SVLQbSw2kSFhyydp4mbRHxA7paHWJU3ulNuGZlREU306CBtnfhS/fzSaCdJOaxt1MjMx
         JN7JG2atQCdb5H+UXadulZ9NSlLQgiP8Nmgi3Z/3EH9iUpRkaWyl7xhNnQBNcs9RdgV4
         vSfK5G1CcziREbian+C0b+rWCpl+f5i9GgWATpB5f8DMtF664EJyOWShMgBGunLbkJXx
         Z7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HLeBPk6pMgiNzzhAqFm5ZWXDSxQ7YS65CAeJGbEDH9w=;
        fh=biVxOfAQ8y53MvSfca8y15aWHNNleTL0sZ4Yh4c+Sg4=;
        b=NQj3aIDJg46/K6X2VGSQpYFymJ+7eTY/UxD2FKErJ6r8HCXUM37A+COXXQglboMXnG
         WQkT+osozlcsIfHUc7NzQcOnuMI/UbyNS4O82FKjMbg7Cpn1jnh6rSVGpFODDWqJFZqV
         4lv7hv7qmvoO3NbXBV8bFhWp9TqqyN5QKJR9ySVvTPiPxWWkRiQ0Z0uojThv6/Wc5k8i
         SPMwkS7Y2jGG2iiX02EoQ7TYAsv9Lb4/TJffcdMCKmGzkCcG7cenjRwkc02uBfzR1u3V
         zXG8sEDJ0hg4C+UPhkqlt9/ZYqs8NSk9g+t7CnpNICV5HFN5HN0i2ETB5qwN1qdNNba+
         GNZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776442946; x=1777047746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HLeBPk6pMgiNzzhAqFm5ZWXDSxQ7YS65CAeJGbEDH9w=;
        b=Umc7/NEuQwm5wmoB26q/DlZr7VmFY1XHsKxszNXUm8ZNP7XsUqifoW3g0xVrzbhNJz
         etlik7ouO9Eyb6kgjR3kZ7Et4xn1fx0ohHPI/Hz3Gr3//GKpr/6cZitMvLHnobkt+Mlk
         nrbl62YiqB5aRYdN7eNnAo7Fk1GV50NmGZSBjIdvBi8roBzBvtnXFu6CxtlA8KEq8dRm
         ulYAV7AYrN0esEpe7euvGkKR1mH8RpSe+k3lv2glNQlUAXFaQOnG7W/W4/aMWh7K3Qn5
         MPz/P5jxxkWVoK9JEejp9S+5Mui7ib127kGKpclfpaxIen3cAx0f4t8HIG2vC1b1/jfZ
         bEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776442946; x=1777047746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLeBPk6pMgiNzzhAqFm5ZWXDSxQ7YS65CAeJGbEDH9w=;
        b=eUGZBay8jqrnr3ctMyVzVWicUBLvXSNp3T6h3QF05xoCQqCSPNiy0wewWQWOzGlCBe
         J6CwcwBg1KoeZKA50zX656gNtorVg/FAf4oDmBz9MMp/MEALCsLLYHckxo4e1sKPvbq8
         Pq3UaxcziuQ2dhO4SDiEJFDjtr27eXTZgJoMvX8ZuWbyOgYC+NF4acD4ouJDqn6lt7MD
         H0siCmJ0swUJw/MBPUGU2aGlNSCx0W+bYI4uvmTgZUbiaxD0vNnjm+rhpmGmXsnYUitp
         2ZqxaxrkhnOy0GKvRfqCkmjOJkKZvUYPfhFFNWq9y7epB9HvKVKtsoSLmJKJ5E4W1gTd
         Fjdg==
X-Gm-Message-State: AOJu0Yzpcco9FoM9SXIIafF+VwQ7O2Q4YvgU7VCEl39ExHGA1Vbbeml6
	xY4icqUC7c6LyjhCnQDrb8Ml8L00ifdARNbzFHajME/+ZS5P6Eqa3/HUrR0gIqFmysoY+dzF0Yr
	JgsInPad8gr3Xu0MfvyeRVh7jQPRCMmQ=
X-Gm-Gg: AeBDievFNyUKaXBWjsCT1e2a3oCDCEKeRgFIflyewlkO1nAup+xslLFphNfSkpUVToO
	wx9BsCxFnw+Ly8+g+tht22bMKIpq+Hio/Km4IOhGhEt0OD88Js2eJfrs6C/BVlkbacJsSQkH30A
	rHXS51HOJq4rBVS2YpIS7aDtB1xTL/uvrg8lYKFTcmbDEWOtpgBbfZ3oAND2Qx+APuLIwgJgRls
	gCnKjqy9pMDLPLtpdhdw2QdTK4utHVQ5FfXM1cb/B4aDnlotZ4lJuw36zsV1s8NCR+3kB7J7uAE
	iM8phJqgcufsHVsK4fVSNmDNXxleLvHeoiLDgR59riopeBth7h9nnllMfnEPTEPJx6+UM03KkO1
	SK1Uhvd4laz1CLruBV0sKouwWtpoAXGK/Ir0TlIOUSAAFzo/SVxDN0rRvLkqpxQ==
X-Received: by 2002:a05:6000:2387:b0:43c:f447:f9cc with SMTP id
 ffacd0b85a97d-43fe3e1e15fmr5466608f8f.46.1776442946008; Fri, 17 Apr 2026
 09:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412174546.18684-1-emil@etsalapatis.com> <20260412174546.18684-5-emil@etsalapatis.com>
 <CAP01T75e3XeJ_wmET8Ht-0h6EtAw6TJkTD48ggwOcsrADr22+Q@mail.gmail.com> <DHVK4J4P2XO7.3SXVTFDJ27CVQ@etsalapatis.com>
In-Reply-To: <DHVK4J4P2XO7.3SXVTFDJ27CVQ@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 17 Apr 2026 17:21:49 +0100
X-Gm-Features: AQROBzCf5irm61WKblyIUaLTPi_BenZKOhOKaQXgc_BE9A4wHfaYuqWwva295Bk
Message-ID: <CAP01T77P96yW4Fpfw2PDEvbZ1yGMMyrSEa3+k_NnN7X6tS6EsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/9] selftests/bpf: Move READ_ONCE/WRITE_ONCE
 macros to bpf_experimental.h
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Apr 2026 at 17:06, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> On Sun Apr 12, 2026 at 3:33 PM EDT, Kumar Kartikeya Dwivedi wrote:
> > On Sun, 12 Apr 2026 at 19:45, Emil Tsalapatis <emil@etsalapatis.com> wrote:
> >>
> >> The WRITE_ONCE macro is identically defined both in bpf_atomic.h
> >> and in bpf_arena_common.h. Deduplicate the definitions by moving
> >> the macro to the commonly used bpf_experimental.h header. Also
> >> move the READ_ONCE macro to the same file for uniformity.
> >>
> >
> > The right header for these is bpf_atomic.h, not bpf_experimental.h. We
> > want volatile loads to be shipped with bpf_atomic.h and all other
> > atomic primitives.
> > https://lore.kernel.org/bpf/CAP01T754eOs2DCjMmkK=CppEwfk5EX84tc70ZqS0_OxTfgxE=w@mail.gmail.com
>
> bpf_experimental.h is included in bpf_atomic.h, so there's no possible
> breakage there. A bunch of arena-related code like bpf_arena_list.h
> also uses WRITE_ONCE but doesn't include bpf_atomic.h, so we'd have to
> manually add an extra headers for no reason. Even if we do that,
> bpf_atomic.h includes vmlinux.h and so any header like bpf_arena_list.h
> I mentioned that requires WRITE_ONCE won't be importable by userspace.
>
> Besides, WRITE_ONCE/READ_ONCE are ultimately compiler shorthands even if
> they are used most heavily in atomics and don't stick out in
> bpf_experimental.h.
>

It's a sad situation indeed. It just feels odd not to provide the
equivalent of relaxed loads in the header encapsulating all atomic
access primitives.
bpf_experimental.h is a kitchen sink header for everything we need to
include that doesn't get its own definition somewhere.
I think trying to be consistent and deliberating on having topical
headers for a library you want to export is a good exercise to have
right now, while we're at it.

It might be cleaner in the end to just place ifndef around all of the
macro definitions in bpf_atomic.h. That's probably good hygiene too,
since I presume the naming is universal and programs themselves may
have their own versions, etc.

Maybe others have better opinions. I would have suggested namespacing
everything with arena_, but then they work on non-arena just as well,
so that doesn't make too much sense.


>
> >
> >> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> >> Acked-by: Song Liu <song@kernel.org>
> >> ---
> >> [...]
>
