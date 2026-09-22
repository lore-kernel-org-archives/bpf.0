Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990B3F074A
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 04:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052119; cv=pass; b=bqFeDuQRd6LO4vXO1F4WF8oPz7q3SL/g6sKV37tKEGKLNTCaVtX9aCZIGfY02b5AH+Ys7EXrj83AsjLN8uBJKqBYmEL+4fGZqfp3MGGOfWGlarB4Iu+m+gkjIH2n1l7N/Hek5HEJZBTEY/zeJR3KBrOT4v6cg3B/0GeGxaKC4Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052119; c=relaxed/simple;
	bh=5c25rEpnWwjQq0kdbCWbDLkdxQo6pekDJrSKx37Wl5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uC0ihbRIWk2xm4XSxlux+LHFE+XmvMeM8LSvPeCUQOwmcYkdSXA7bDGLzqany6iYhoBn2Y/KItwJlS+TdDvZJ09H36daGvy44WSBrU/u9EYhSULE9H90zHsYJtyBLzq4zxmhzf+3JTToXfNtqKlVNz0PAH6Nc6WnnVVb2XruJz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVT3bM4c; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVT3bM4c"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d440939f0so28846337b3.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790052117; cv=none;
        d=google.com; s=arc-20260327;
        b=kAj72QVvuHDZ6xyBib6NvuNYlIfVejBkgM2KkGXN7u6PylOYOEtTKfNXR68RSpZBNr
         N8tb1ikEMVOgMTnkr3UOM/OC8nKhNINpyu01pkcfcgj8lDnyPEoo+JbF82DnuxV5mgBh
         JFr2BzxK8QzGEeH3DzTYVylCpY/9aaiqwpNYfhu5YWWR4Y+k9E9x+HZ5PKbCohCc7xXY
         HUO5IFLvJuoEq80N3+nOby8TxP6Ajk+PnPQmVkdeobGRHmexTDwBYC2XMJ80T8Bq2N7U
         VId4z0bLTTJUT6R5Z1eceS5zAtIjgsnyEXq0U2jHX59IYs5p2jUp8psg1nTbOqQ5YwW2
         kggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5c25rEpnWwjQq0kdbCWbDLkdxQo6pekDJrSKx37Wl5k=;
        fh=7IOEaUKe3d8WA9R+ehTOieCULzsVuGHhj52+LOgwhJI=;
        b=ezzkUy2UUUlTSjnzOiUVhgE/GhFNw4NVAVbYX15ZYQnds+T/ZbkkefAb4JIdqaa2qH
         8UmQFLXkdG1CrvJ0ygHs35ka8xZqDzC/iAtXhMkxJL9Uml/i8qYVJG8Z75E8ZxI63f+E
         3kf2yMkqIFkBBh/xU24a9SRGi/1CzTTdF28t7a73STxybxMzil8YAbjomestErMYQ56L
         IeXXR0kWDsy9Z2mbV0mN3QBYpf5Nct1EQKgUj4ZirZLd+2sQs+lUY5I3s/+ZRVR89Rja
         3Lj0PJdYrpNEz5EHyUCh/UPRz8NskcYVAic9yFygLuG9Vdas9r9n6O8e4SVbTn3BYigR
         D05A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790052117; x=1790656917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5c25rEpnWwjQq0kdbCWbDLkdxQo6pekDJrSKx37Wl5k=;
        b=XVT3bM4cyq4/9vQHKU6vekdxjffmr+y4AI/uWOTOeFyvpzHUzo01RLZ6NjxDLJjhYm
         CQaPl9xDDSev/7tprplYRPy11yQBBX7p0ppXEfOeFZGoSJsNX5JtWFeycrgxy8kPD2Ax
         sL60BPdMyxA+WtI6yerw73vWTEdepBzWm+Wz5fX6du8nnablfdwWNGWLq8EINx6LmkNQ
         gZOHhVLDslkXWZVlyJZ6qqbbLbPUNy6343vUssy9C5zEhUigyE8hAphpWhGD21oBGyZ6
         vCN2ps78/nLkX0mP7mInfjQleCtQ5MEmkSqSykXaZZO0a0qEAbH0mx4psz4S98NirB85
         mLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790052117; x=1790656917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5c25rEpnWwjQq0kdbCWbDLkdxQo6pekDJrSKx37Wl5k=;
        b=ZDiWn1IA7XdxWNYbkcsX4TmwdH9zv6PFcid1L2OCULD7Wf7BaNnJ23CAN4hTUQH5a+
         oap7K+q+z3u4kLawhVRzkX01RkpYP1Ut9Hr2IZy68Gy+qT8w4U16yVhmwR+moRcie2/B
         554OCkSLH3oXNJNZ7uBkPzxobqF5yxHvyOFmR6WbsqW1otjWhduewsA86hPEu353oub8
         fAq8AJfURyjatP0aRMCAR/Z5aTjeNtTL5pPWdALb/TObZOhz1Afh/Y5RqnAfpvzXbW5n
         CSQgHrxuih+08IDmK/T8agviAnqQuO3zMpuvjMxmLiHMzP3D2M+kpkNRsi49i7MwZV7E
         zTzA==
X-Forwarded-Encrypted: i=1; AKwUvBzM/H1Iy2PkRwy4cmEdhhDMxvrzL4wDK23MwfHaFeE4oQZwdHB1L1R9zWxZGGlSnEb51t4=@vger.kernel.org
X-Gm-Message-State: AFuF++lsA9oE8SewpYeqnYDpYE68ciHiJokSGEJ5KrHttWJ/JKGJ0LRW
	iQD3a0OOpL9DhjEDWUdgL4y1vVy/XH00J0L8xwaAwZ/2vRbXw4PrGYSeBT5+njAry5sQY+++FaD
	E5ovQ+D2Ic/ISjpmuHuEIG9Y94bHX5Ko=
X-Gm-Gg: AYBFou2ITfAXbixCq85bxTa/Ojn35H0YF3AyMgY9ithfqnvlQs2GyJhvORby45J0O1e
	/+40IrN4faso1huiVZU2J7SOAI0rOET8rWOh5nb2VvKyeoPYQIr/yrtznbEQB4cTUJdtKEySffw
	Xv3dDJcztHB5g/Ewmkh/6uJHQt9yFItx9F7QYRhr92j+4zSdzqFhKkwUDSP8D3T6Fwbqr4Aie2h
	Gt4cdXl0qbwn3e9256GEw7NPh0Gm+/BxBsU5PIm4DDF+QL7uwpY3FdfUPzk1EM95c4L16kuGzIL
	oEtCz+9zqCGD+/sT8xf28QDwk1Tf/YrqS4A6DQ/JVgQnnTMflpKSPjfCyew4LYv2N0ReAbZxWe3
	AnGJFVcxgz6yqydnOqYnS7aAGmWsny4MiSC1vq76uayW6
X-Received: by 2002:a05:690e:b4b:b0:672:a4a6:298c with SMTP id
 956f58d0204a3-672a4a62b60mr3004078d50.6.1790052116810; Mon, 21 Sep 2026
 21:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919-ksyms-tune-v1-0-d85c97da1a32@gmail.com> <202609211605.9F15E5B1@keescook>
In-Reply-To: <202609211605.9F15E5B1@keescook>
From: jim.cromie@gmail.com
Date: Mon, 21 Sep 2026 22:41:30 -0600
X-Gm-Features: AcwNN1Utyycyg5fZYcTu3CM11pNZpX7emt-G0eshr0PTJzFXqlmzavs0XJTRWL8
Message-ID: <CAJfuBxyYYpk44BEV3vig2Aeo3yn1mNDL9wVA+G4y1z8BP4aeRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] kallsyms: Accelerate symbol name lookups by ~19x
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	david.laight.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 5:07=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sat, Sep 19, 2026 at 09:58:54PM -0600, Jim Cromie wrote:
> > Memory footprint: +573 KiB .rodata for kallsyms_names_offsets (191k
> > symbols * 3 bytes on x86_64 defconfig), minus ~2 KiB from dropping
> > kallsyms_markers[].
>
> The speed-up is impressive, but I have to say 500KB is not exactly
> trivial. It's not _huge_, but it's not small. Is the rate of symbol
> lookups in the kernel high enough to justify this loss of memory?
>

IIUC the use is quite lumpy.
so a dynamic allocation could solve all the problems.
1- 32 bit table, since 24 bit fiddling is silly on table thats freed soon.
2- can do David Laights stride-2 thing almost for free
3 - 0 bytes rodata
4 - no conflict with Lorenzo's patchset - no touches to scripts/kallsyms.c

It could be batch-loaded and freed, w fallback to existing slow search.
or left around till OOM
I will play with this.


> --
> Kees Cook
