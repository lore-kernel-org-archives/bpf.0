Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353002DC762
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022467; cv=pass; b=fX04dCci1aiqoGBvMyTvHoLt3uxdbvdzxyheg48iSzwuv0ZXVz3nhNTrOlrtDLiTvhS9rdk6qQkS+BlRfuIfZrAve45LtxulP+l/dH3kz/3ji2N8rlop3VqjJLpovJowF4XjIA1Dn51QgkfrQVKjXbZ/c/TqDJj9js3sZ+KVy/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022467; c=relaxed/simple;
	bh=OKwzI+gAAa4NWBnDFqfQmjjlSh7zOtAVbuy8SSbQrSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAuS587CHrFZUO4fCJgfB3quzYNUdNqn0AmF19OqYnUcN8u8AAUrIknWnLCYFzT52cayEiBJofNsSaDFiNU/7ueQ8auRk0UXQPCQ9brDphhhya3b6IseeOzVhz+3hy2whTjBfbppcs5tvvgMMKy3nRAKoK1eHpCKR2vTnqZtHCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfSwE1UZ; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfSwE1UZ"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso461374f8f.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 12:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776022464; cv=none;
        d=google.com; s=arc-20240605;
        b=MK46+CX+QmgZrFk8q/VrFvmYG4m3Sy4w/wd5GPi5D68KMKXKOMVj4wKcS2pTgwSdE+
         +94EyeEqn9E/C5sysKv8kj3qiFR5ekpd/TkguAEDUeNQ5nD1cmiFsEktM5sQ3kxGK5Sl
         bT/OhCFH42O5sPe/4ZlHyC7Zdypnvk9PAOQuFGdl0d7PnMkXtArAep81Dlsju7LnUKUV
         iINCc9ambyQLe+gZdm0AVLHgv+bC0TXb3hET2VcMOzjgC4UHZQIJONQKrNf63jKql8F+
         GZX7JHwFjaSWhXQI//UamYJ1pNaaiGoKnH4pU1V0z3pDITET77+HWHc/gwSzigYHwoBR
         qD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OKwzI+gAAa4NWBnDFqfQmjjlSh7zOtAVbuy8SSbQrSE=;
        fh=biVxOfAQ8y53MvSfca8y15aWHNNleTL0sZ4Yh4c+Sg4=;
        b=XF7P01W5fib3AopoVKMmkdvXAegeu4D4FES0wAM5zpg1Jj1qlULJKiv4NDrC3W8g5B
         3/tt37Q7fDUDSSVRZg1VHTxQBOUQ8jjonfHD3lixwYKhKOjpFRQkucYEqx8MH5hsXnTU
         5Y1Xa1GohrGip4yYnpzoH4tXYf70du/cwTBQ85Mc3dPOroQ4AHYn2LCAKIuFhMMhGp3Y
         GQzW9wbe6kVympDNpau6xbvQ0tQyJji8pe5eGMST7a8OJ7U0kzuyf+su+akT+A8e23J5
         FnkQTQkq5TC6A0QxG9g9OaEi84RF+BOnQv/wnzTjTGCxgNjOAtltJUIPe0IHY7OOU7Nf
         hSzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776022464; x=1776627264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OKwzI+gAAa4NWBnDFqfQmjjlSh7zOtAVbuy8SSbQrSE=;
        b=sfSwE1UZUctMvqQkF9jQIqtofAr/eWixSjuin3NV52B0XDKhYceimiLyaNkdFrcHSR
         ChkKVicTzJXPqAjZNZLeTcMbRvItOnjXQTedBy4P3y6/H6vGbhvg2iYarU4oJPFkEmnN
         RuumhnNg6TwBrY+8JC0mGERn5isGccJT1lNpxccbKMavuJ+G4msdo86ltypvNoSm5JAq
         gPSmedPfj2e9DQBhV6lgUkou0duooVLAyXNIudQ8FsIRUCbMYP9VVthVJp1z5iGpESlq
         3QQ7zjHfxnLXo1XxohoKDz4DKqBEV29Iwhi0BjHmzGQO74vLyd/0EUKsuFgZ4pWt4evP
         pYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776022464; x=1776627264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKwzI+gAAa4NWBnDFqfQmjjlSh7zOtAVbuy8SSbQrSE=;
        b=Mk+po1tZSmkHlXoFZBD5thVjEcQC+1D/NcE9m0vgiGbPfdHAPFAleHVutH48t1kfXd
         e7O0/hHfJhmbxDO7ePUkCMxezDwqlwM66UCTumweidBeGxtpvqUleXkEoRMHfGlTDtxt
         iaWatX1yeMFWnzr2BcNn+z4i61w2gCcxH+9cGL9wRAGFD7gG56WK35MFJUSSHwsheuCu
         ckRlOGoLxOGUP6UdKHxb9qL/IeovklapdOO76ZSfRvGYj8VifSj78/Y6xzzVYWUkr/bP
         vi/H/jfxvlw+IpsZxh8wuVFegHT4ih7Ih3LQk7i8uAli62yn9oAMauGQrkQkgao2jfH0
         xglA==
X-Gm-Message-State: AOJu0Ywe/dBvdm8GBGzPJGvKpXSVuKEa/P4mj8vebQkB81bMdRqoU3Gj
	fm7CgaFD9+zHznhnjAxDD7s30NTyPqUwJNkHiNfOjIHk6Y8SSjozbLePh+kvd5yGchuPdP1Atlk
	kurbshdpSHCMZPKPuFQGxNeHIFaF8iDU=
X-Gm-Gg: AeBDietbR0VrNiQ8bHuwe4X7WgLncut0+CXvo/tbKYZhgQ3Vfg6eV1rClX1e8zQOLTK
	//LqhULkLCHIRzMTK/feReJKrcUK3/Dp1gy5AFLrX8fon5aZSK1erMHnv2HIyDyG6n2Eqlzq0+o
	JkWvE+vNTCU5ipJn128mh5BWAhd3OEzJPDIRxRCdZ1B2vYVyoIiydYorGEbzaDRqucEEo+e1OzY
	hGqG2hnvHq4MPvuR4p9rsbUZdUPbKUqzYQtimr8PPRyshYkMkK5MuiGJObDYadUnTtlYuwSsFCo
	VTFNvLXsZVKFaGLioHLcmYqQFEhc8CkKD0YpdzEU90wO67qqEDOWfDHphSwR65/39E6HVT9XCZB
	IKgKczaVGTTkxJejY8J7jsEjEYO0mxnHlPmFnt3ZPzGo=
X-Received: by 2002:a05:6000:1847:b0:43b:4f0c:aefd with SMTP id
 ffacd0b85a97d-43d642b9e05mr14403316f8f.23.1776022463479; Sun, 12 Apr 2026
 12:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412174546.18684-1-emil@etsalapatis.com> <20260412174546.18684-5-emil@etsalapatis.com>
In-Reply-To: <20260412174546.18684-5-emil@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 12 Apr 2026 21:33:47 +0200
X-Gm-Features: AQROBzDw5DeA7xWLT3qUZ6L-MUATKt2MpMAms2Ihy8a8D0JKfFvvOkoylgePeL4
Message-ID: <CAP01T75e3XeJ_wmET8Ht-0h6EtAw6TJkTD48ggwOcsrADr22+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/9] selftests/bpf: Move READ_ONCE/WRITE_ONCE
 macros to bpf_experimental.h
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 Apr 2026 at 19:45, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> The WRITE_ONCE macro is identically defined both in bpf_atomic.h
> and in bpf_arena_common.h. Deduplicate the definitions by moving
> the macro to the commonly used bpf_experimental.h header. Also
> move the READ_ONCE macro to the same file for uniformity.
>

The right header for these is bpf_atomic.h, not bpf_experimental.h. We
want volatile loads to be shipped with bpf_atomic.h and all other
atomic primitives.
https://lore.kernel.org/bpf/CAP01T754eOs2DCjMmkK=CppEwfk5EX84tc70ZqS0_OxTfgxE=w@mail.gmail.com

> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
> [...]
