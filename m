Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CDB3D810B
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368755; cv=none; b=Prm1X/uHEQcrZ5ggUoSICiPEnoboNnwHRMKHqlDU8JTCgRz5Hie0Izq9BiUmDoy2ySJeU4zSRHbdSKwbAAyBgesN5JPRqkY1SexaQOAGmIu8hW1WsNHeeu6S1m5u8QaU1JAB4JXuUp8HS03GWiwMAYoRgFoavzXfTyDK2Ewsfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368755; c=relaxed/simple;
	bh=WZ0dv++aH+AeLwkvbNXxLqu7wJ3mA6GpS63WG1N27Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl+aS1049hao6P5yM75ahAJS1U4rAC5Qyhwzotoks0JGNnJ3iNq8SWteYJ8/TG4qRoXusZuhQFzqdqHyaziK3vWeirk81jFDhAPiVFg5DLwYtoNi59QP3GjeJBH3XODnLBnhyz4I1Grn16DcFIJoRXYf81U8VS54tXLi7/w8SzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b886fc047d5so2003038066b.3
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 02:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368753; x=1777973553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=TsY8IyNrsaiQw8Zp3LfQX2OxXE8fDIVU37v5vBVxhgTo6ARE4D/8O7eQ5kIA1+m721
         Uabshiq171q7on3vzxmNkDyH9e0yAHM957OvrS5nAViEI+Yw5W/AkPBAAU90U3DJEhJD
         EwOBCRRdSYQC91hArrhK1HJp9qQemmvqxz4zFvb/EUXeWBm7vL9QrpVQ2LYCILGDMEH3
         ztNPQqBHSQ4KHL6IzNUgwVYLvp4/dKRQACkwMrpdkGkjhsLCRwwMuCAATnkDs2ryo5kA
         waEOwAlUQGR5jZlMTh0xMtZhRgeRy5fcDJQbOfb/51axRtfN89kksdsn9kkzTEVHwtMC
         mByQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nTVB0Czhlm1WwBH5QAsKt9W3QXeU6fMT5CQP4RlB/aWh97Zo3UC1g3Xr/GK+o82avhQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvfXfQnH1u6u7/DHm+iQ8AyJUyMc2eGrJwr4SGGREgYVzAyzQd
	33XXjhujhrkd9+DlNq5/9F6xebRq3j3/NiT6xHOwFwmyLTSYdTXkJ0CiSbaVqgjJHTw=
X-Gm-Gg: AeBDieulX70csRgLrms3DXRz8MtYcxZWz7Ge7E7vUiYipQxkI60m6x0IKW3fc9aSo6P
	svVzhdlZODAJqOcUrBiJBvpGliXCyKuWQlVdXREdsJGhtdAZiAFkxUAUemeeUKIwruhLb9F92kT
	geZLVSe+7vtwKgt+8hV9xx2GZd5S8R7zO790VVJAxLMtMhBxOl5dK9gpuVDvimzZPhlKEbeTNKb
	cvQJ1QYAOeoFNj3GP8xD5hte1gi/+5vb8uVvvUmJrIqhp2fmh0XbYEF8/81YjBlTKEHbUo3cazo
	2Al4AaquysAVy+3iR3fC7hF3jhJW4vP+Iq9QZo3LYFfYnejxxNiTcl0K7lL0FThqF+iUR+tXhUT
	sHQyWuY0s9F1Kb9Rzb/fLd2IJG8FeJyrPQi4UAY+IT7CteiNeQKypyDc1lFsFc/mWmXcd5rg5p6
	B1ZO34C3uSxvrkJjm+U1U9cABdtzNnnioMONvoBs5kNXgvr+MGgpzGqTMGfP8FcWcL6PWt5lA=
X-Received: by 2002:a17:907:25cd:b0:ba3:3091:e56c with SMTP id a640c23a62f3a-bb8026bd2f6mr130043666b.14.1777368752821;
        Tue, 28 Apr 2026 02:32:32 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80b2adf6esm74850766b.38.2026.04.28.02.32.32
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:32:32 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so19507499a12.2
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 02:32:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/0FTX9/riONCKCrmuvwFOE2++1b9Lbe9P4fnM6/1AbD6oaP6CnDBLudMLMlvsWD9DZW7Q=@vger.kernel.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
