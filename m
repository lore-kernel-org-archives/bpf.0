Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61592436BDE
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357039; cv=none; b=V7aJlUiG+3Au3sEtkOvCUxbg3wDPEobfFZJkikPydryImIwcGTzDqQjWnvKAi92UOo9NfB5wbaO5J3BRrwk/K7/xdBo0C86pCPMpzxS8/0UBiTAlRIgF2vhn3ujTXqevNjGohqdjqS/e66pHM5/qFDQm5oXxdTxk2Uq6E1W7glQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357039; c=relaxed/simple;
	bh=kEBJEY/PJInPUYHCrM/CWDu6omOsOAQaEbY6MfxYMmY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DMFtP93oafrQxU2BKRU/8Kk3Hvbvqrbdt7qoVNEDkTBAn/YGWzgfyR35UngRTiUl941yaP/KAvAoZ2jdJs0nekkgb1paj95zhIu/gJ44ywxF0+43I4Q5327OdhxOEwDDwT3Fhtx1guLZkCc1QYyjX44F1boydutriU0dhi15L4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=v3YxPL9W; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="v3YxPL9W"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8453427d3f4so2996103b3a.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783357034; x=1783961834; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8ge3ixhQ7bc+RtCQGTIiLP+joKUlT/9A4CFAqvurEA=;
        b=v3YxPL9WHWjJW95U6yFeSiFzz7kiBYOP1tVAhFJhF/+uHEcNvLvrJvbEZIOTXmCUFr
         PCgBTE8fiGxhTPyzA9BAakl7H7XFR1/+cS52ncH8z5fiPI7tYrvG1LgVCihVfxg44Olo
         9mLXwdcFsBvUjZkgKHMCQAPoSPAx/1Qv8jPfQOzG3gLEcZQ9LCaaten6lEoD6oeuUSMU
         Z2fpgCtgba82kGWa+GFCA9Oo/KupuPHqYwiBUp8m82YCe3AxWKnyxBF9twZPP2IwnEWE
         q6uf5mi6cfPLUHSvYEJJ7aEg4BGX4JUAxr5DQbtxmW4kAypBjVSb483JGYGrnA+DPSmq
         a+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357034; x=1783961834;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8ge3ixhQ7bc+RtCQGTIiLP+joKUlT/9A4CFAqvurEA=;
        b=N1L7zl1cB5okAmgzyCUGRCr82Do70q9VF3Rj2zVmkvW2RFOpQYz06JDmRzsirBBiAm
         +fzQRJVmDV+p0pDE0HHzO1SrinOLpcq5iFIaqidv/OMabKzrDZEycG1GW3C3GFrLWdg5
         bzU3JarHUg3h8f6fgNkIIrtYDYFwz/KU5Dpd4tFu4D+xpi+YaIw3foj71MEW3Owaprkb
         KO55iUNADQjmT363+ZIH0L1CKZ5rXzQVarC2BcKDeOTswOtgI8vRDe6i3PMbFrXDibem
         GcT6bRrskPEJYsKbRVFiTGOx/wJO8QmcN1gMV56WHdeSInI3OLygK0vl0KdtUm/7Cq0v
         s/fg==
X-Forwarded-Encrypted: i=1; AHgh+RqjG438ldJmH+IvZexwI6dZSPr1rWsHK+S0X0kB2c4J8g8ZguXWevwB7Co0Cc1EmtG8h3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvA+8ZnzTBbRDhnyHrRgPLHubbF8YAiNkJ5g0rHyUPkfGRRcWZ
	a8N5AMEMjgGRV9YOsKApBzvnC3iYbETgIL1yz4lG36gloE9RyJtjRdVzzGnohKMgT7k=
X-Gm-Gg: AfdE7ckREr55qCszJ/uRj3GbDH0APH6UGaQyQeh/NjiLErlzbCPEgY6hOtCi1ym/XH9
	wqxQ4+xwtEk7rQl31coTA3DkRnlLDdgOmCSzQvoHc1ZGBooCJfNRdQ36TJFNMgDbUj2EFEJbFZf
	dvtjZMSTWe8HiOc0P5euFF5hpG21z0BTyM3tiYk3eOfk8jIB3wE4LiJuLjDy3dv9db1kVqM9NYq
	1UV3UykX5hI61u1ttVj9KrrYfJOBRXnekYYvIMfESNCGUM/T2NomHW+SROIueZZrQfq3BRVRnKB
	aO9J1WJmopJdYEUR4eYS795RcP7+/XYcvuzCAgDxeMZXio/uZbczmwAVDkHS6dTPkBANqN27qin
	npXDmyEmxiO+sUp6HLHmhVaCkhpZXExXtJYygZdd1OXFi8pnV29a6dwt31H5nf/W0mv66R58vIk
	AH5KnyhpHL9AdloFuR1gsaq2ypUoTRxkIw6Shlmy+BTQ==
X-Received: by 2002:a05:6a00:80b:b0:845:259f:8925 with SMTP id d2e1a72fcca58-84826be28aamr1426446b3a.6.1783357033742;
        Mon, 06 Jul 2026 09:57:13 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e91b0a2c4sm6115711a12.19.2026.07.06.09.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 09:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 12:57:12 -0400
Message-Id: <DJRNB2GQ7RAX.T3F4PHNFMI49@etsalapatis.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Puranjay Mohan"
 <puranjay@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject out-of-range arena free
 addresses
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706-f01-31-arena-free-bpf-next-v1-0-3ad6e7384285@mails.tsinghua.edu.cn> <20260706-f01-31-arena-free-bpf-next-v1-1-3ad6e7384285@mails.tsinghua.edu.cn>
In-Reply-To: <20260706-f01-31-arena-free-bpf-next-v1-1-3ad6e7384285@mails.tsinghua.edu.cn>

On Mon Jul 6, 2026 at 11:52 AM EDT, Nuoqi Gui wrote:
> bpf_arena_free_pages() accepts scalar arena addresses. The free path
> masks the low 32 bits, computes the full user address, and clips only
> against arena->user_vm_end before inserting the range into the arena
> free range tree.
>
> A scalar address below arena->user_vm_start can therefore produce an
> out-of-domain page offset. A later allocation can consume that offset
> from the free range tree and return an address outside the arena range.
>
> Reject frees whose computed full address is below the arena start before
> clipping the end of the range.
>
> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

This is the exact same patch that Yiyang Chen sent about a week ago.

pw-bot: cr

> ---
>  kernel/bpf/arena.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 80b7b8a69446..97a5d8d21295 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -853,6 +853,8 @@ static void arena_free_pages(struct bpf_arena *arena,=
 long uaddr, long page_cnt,
>  	uaddr &=3D PAGE_MASK;
>  	kaddr =3D bpf_arena_get_kern_vm_start(arena) + uaddr;
>  	full_uaddr =3D clear_lo32(arena->user_vm_start) + uaddr;
> +	if (full_uaddr < arena->user_vm_start)
> +		return;
>  	uaddr_end =3D min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SH=
IFT));
>  	if (full_uaddr >=3D uaddr_end)
>  		return;

