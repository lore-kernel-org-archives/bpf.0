Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438332FD1AA
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234970; cv=none; b=P3/I1fCVPa8RKrlonnxL9MA3YCNfhwX0fiPWBFu3epH2gtkg/nMRXy2xQ7dh4ioucug0jVcjfxmuUBi+J50O7gTRU7XExvdHh2VpgHr5S0W6NxLotslkzBEfcZl+eQJBAywW0Cby04LKnLXwZz3FTJtnKvnQpKTSOajT3lKwAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234970; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3GqgHlVDsOI44E0xyJcc+Vb68QWR9+I3wYlFBEqyzhegUkLdRdHudPBcHfyfiOgiagfLrp7qHqgseRQEI9HMuUWfRQoyzlUB7IzZSIYCWKkrumLPs90RzxfsuOlUPSYpot0ruAJgbMGP8AhNS2DwJGjnb6J91wXG0PCeVRe/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5fff18d44fbso3416792137.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 06:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234968; x=1773839768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=IR8g56YTPnSdg2ysgW3f06xCldgjG59hV2JPbBsG5xYdUVfbe5n0oWE4KGVhNlLZvX
         dLK6KGmRWwfRHzBWGmEkDb0mVV6PAFDJP1u70E3V/kbreRjFx5AzSAXLSpKOvfkov7ZI
         33GIOUvcX1Y6vvQO0QjhRMx52REat90FO+fEHXdI393QlZqKu/hd0hkNkwhUVQyk5xfm
         dRFN0UGh5R1x34f2SjI5olXnGhWBBec3FXSWkFFLQDCNm3IA45E2t6Zcm2JX1GVOwUIz
         rEO7wxVLvnLThdfSSwyFxjmb/4ZSHmJBVxQooVhAAhjUm1Li8ruAJKjiHadnAlPV847+
         CmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEgEPknlji+W5+E8NWugFWRrXDh1Cfh1s8NVf/vi9tHbtwpbZK/Jl897r0WNHat2fjzHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtl5CkKcQn/R94cMj3r82S2cPSvQ80UE9qtwJdc9tVmQEb/7Hx
	zbJQoxRwr3UJoazcRMrJwRhtHjMZqOnM+LU04JqYQr5eIJhI9nJ0oRIJXLdJo0lp5fQ=
X-Gm-Gg: ATEYQzzE9FOp6NIrt/CKrKQJoHmIUPX3zUWSXMBH5rPfqND7vKzREvS6f5gaA8pch1N
	S4fpv5eKSa1A5RhZZ5Wsyq8unqj0zJxmef2vG0UBtgdnT43hqf3DZEg68EVB6JqDd0rjkVWgKN/
	6k8s6w6mWZ4M66qB7yFEHwwlWRWZRItNXdPHfy5fg3qI4mPc/IiQ2IhG3K8jHbleMVIaCP2l5Lw
	jEW2xwsQ4dxkdi7sHYBgILoL6jEHBF+bv1XYj+ZGpuRzKsHNUf4orTpEYAK5DnO51fb3FnNLgSw
	qWF644lPxQV1H7D/fSPY7sVfSQHb6tUNaWAggHR71kotPuyZb2/0Z3lqrZyRbM2jBTXSDMlbLKl
	/XT8l2QJYU3OKyGuIzqQzBeYe78KOBlViciREsPzrP0kriKRiWK02jda3uu/t18xWLy86YqtFQV
	RBqOZWO5rjm1+dEN7zp8CRaSuPoDw9ijDar82oYNa72VVftazpAAH8f2oCTc6JnLh1
X-Received: by 2002:a05:6102:3f52:b0:5ff:c510:b7cf with SMTP id ada2fe7eead31-601defb9800mr1063893137.29.1773234968152;
        Wed, 11 Mar 2026 06:16:08 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-601de89c65bsm714247137.7.2026.03.11.06.16.07
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56b18f05f49so2419020e0c.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXokRdZSM4gsj0r+U40heXwX/iR7owkAolIzvYIo1WUyTD8O+fSpYqLNXGWW7bhdGxQTOQ=@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
