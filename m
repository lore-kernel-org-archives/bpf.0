Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06B1B78F3
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189476; cv=pass; b=FulRXkODQHttj4SeWemf/0up8FcSkMwl320q1EkH4whSQR/2rSYjKtiMHKEvnSBrQ5e4/mLWLPKFu+PvgFjE8GkPVGfO5ZPosnkuXfq+SnAxj824u+0WrQ0X/1UdOf8ooSYYjDfjyrBPei0GSHQDzGyoLCHGUoFI3bEA2anXdis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189476; c=relaxed/simple;
	bh=//l0nEjTNRiO6ok8x5R3UO9HJXdIVnzS4jZFSqDgDdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTaVUDXCZS6XHMprCz3A10wXSWyke5dLBsFfTERGXIIhicUB6QtKpe6bAoKetW+lmaosB3EIPXsLULEgkMA3VYCOlHdp8ulEgpNgbSKJU7yVJ2yN2VlJ3aPUF4JGnIaeV48Iq0TU20frN1jaoKnO909BOTFVOgZsznq0w9fcqvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKTZUymO; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKTZUymO"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb5810d39so1569205f8f.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 09:31:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769189474; cv=none;
        d=google.com; s=arc-20240605;
        b=D0uivqaxAyP45TE1idyFlrqw6mncv7VG9ZoSkcuDJq3QcIm2Rok8U3pfaSvVHvgSJi
         iky++eA1plX9bi6Lty05XAW+qxKv/QWHfjCIgbv4bCGgBGrA1HrXviwnO5Tb8g8JI18F
         4lHWS+AaEiXRfqQnpF5U3hf9S5GB2KiefLarkKQbBjhTJ1zXk4Yt8wukcu+MNwh8EV0g
         bmLQUFI2FFHZ8iDenMoxjv2MBgE4Pje8nYAbIT4L5ZcBs+it6g+pVWP8qb1Nt21cd00f
         VslJs1gER3oCTV0ZijAO4oI0Xo/dYtnxNZzEXj/LIlnYvhhrUKpdMmOdaW2sXtTUsLgO
         dGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=//l0nEjTNRiO6ok8x5R3UO9HJXdIVnzS4jZFSqDgDdg=;
        fh=DG6kTPG9/6L7r8czFaa0oHi1L1x9ncD1HCEhBGT4YnI=;
        b=CwZbYOZHdGV/PKeD3kAEOIDSQk4Bi0b8GyUx2jD+enVNJDg9z2ldd1mf6xTsr3bZ0A
         H50o/dwbYl8/gDWveEzvym7+vKHCdtpRS5XsWIhSybwnijANelSJQj982h/kLUhsEYHn
         lP8aVise8T5PZRCN3A9m8aqY30HLmK9ze5cFUlMLX2qwsTKSutQCbD/izIS4TRm33XTx
         f+cVOqBIZZGGMnj/+DQZ/R373QI6heMvnzk1gTN+aGuNL6nUyGv/+QssYgg+B8xVh2kN
         Ji9uv2rAI0W2S0mOWFHufiukXl4q6AJiy680Efh9dFv9gjdCxtKhYDY62f3wajKcIPEs
         hVlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769189474; x=1769794274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//l0nEjTNRiO6ok8x5R3UO9HJXdIVnzS4jZFSqDgDdg=;
        b=DKTZUymOi/0GfjM3jV9TPxvcTGLXrMh+Hs89MEtzQVUAxpR2HlhJv4CaYJbZtK40PE
         7yYC9GY1c69HAi4IqsLyAthUOQgSiiGRjvU4cA2iquAIy6WMYfyDW8gyZEcm1oGCSd9+
         2mjllmfB/gJQ+4Gw25drZt/Xv1f9NRL4fLGO2KT125Tp4qZGb8A30KP90cWaZH/7fxgJ
         Izhf3GJMLQKpSlFIs1FxSVPK968qFJRkLKX0vRM2Saf+qUk3CqYKzfQ0oUvMdGgxzR1l
         1RmLEoGaxru/E9HACSF/nneQEi/0K1G4zvzDoFUkREOWCNG96ej0ScYupDiB77ZvaDr2
         3VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769189474; x=1769794274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=//l0nEjTNRiO6ok8x5R3UO9HJXdIVnzS4jZFSqDgDdg=;
        b=mKSAPfjrG26x3VuhkO0W2oHUrmkXCy88Y9Z+lBOB+XC2qj192ZHhmGqG+Vvt1dCUyu
         FtF2rgy5vAyQXlaLmVMTLoyPg3YQ2zStpQtcnVySj/OvMzsHYiEp4nKAp0buSEuy+YrM
         fNBaPPKNHMGHtyBcPpXP2fwXq2Xx+ihwTu2An3DksZEnHMa5cssNmlr0Ty//H5ld0XV1
         CHptsKMJ7Vtj93BjSYeAIv4k4FlId+AFYeWj/5SRvLpCoagoaUQs3wYURBgnQifhrsqb
         9ADir2VpjmABj9T/KWyYXVF2pHCt3RKYv+4VHAEf2iLCXGOYBsnY+3LBVmljSaw5n3pM
         RlWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK0PpXJ57bCLimzK+34aUtapIvXVSyLEOpsqxkWuVSIYfTNoe6ZYL1mxG1P6TfohXkFR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzyNA5s/YbGENofVnbH9AnLBk2TcjFmITqVEAzVd6Y5Vz3W7+
	kkC6hKHoD/86HSewvQL15qhZ0D4Ptxe+wDAlgioGAP53nwALPl+ri7zxA4dIapqX/X9wGPOJzXn
	upOq5T+HacK00TlRgqF7bS74eXWs0ZjE=
X-Gm-Gg: AZuq6aJDcpK0RVG8BiSOLIA7FtM5MTMYdrRGJfiamGeH3vp9mwz7JzNKudVcGRpju0A
	OVaXoY6KgbI/mMmiWKIsYW+xkSSGCVfAdaAKgoaQN6mOYUDUCw+fLTyq9fzRd8tQq7PLRQ0X3U0
	5qis9tgZL0ZvYHVkt16o2SjZOFjhYRAvykQ53zJt2lhKhj1f2Sa8LUfg0M2OzmnM6UUz6tWLCaE
	I7X6b3wWIwoiZMEpC0TwGiROc3Xyyd7TMXVYUillRW98MaQ/URZR7pp7hbkrF1G1hpG2jRI4+kl
	jLRQyhRUJMPUn8g6P4Nx6wu+iKkuS8z5ZBW0FZgn53JLAtaaZeO1V0nRqG2ip/atoh/sViNe
X-Received: by 2002:a05:6000:2dc4:b0:429:b751:7935 with SMTP id
 ffacd0b85a97d-435b16280damr6748411f8f.56.1769189473665; Fri, 23 Jan 2026
 09:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz> <20260123-sheaves-for-all-v4-14-041323d506f7@suse.cz>
In-Reply-To: <20260123-sheaves-for-all-v4-14-041323d506f7@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 09:31:01 -0800
X-Gm-Features: AZwV_QgSD9SUVQI9Y0Yihip1NN5Dune2qBBleSwBNI5G1-MsD4RlJ98R8TtLbTY
Message-ID: <CAADnVQJi09vC6Y-jb8mCRfj-OrECvSTMQ_XL2OE8W-B4zPwGSw@mail.gmail.com>
Subject: Re: [PATCH v4 14/22] slab: remove defer_deactivate_slab()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>, bpf <bpf@vger.kernel.org>, 
	kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:53=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> There are no more cpu slabs so we don't need their deferred
> deactivation. The function is now only used from places where we
> allocate a new slab but then can't spin on node list_lock to put it on
> the partial list. Instead of the deferred action we can free it directly
> via __free_slab(), we just need to tell it to use _nolock() freeing of
> the underlying pages and take care of the accounting.
>
> Since free_frozen_pages_nolock() variant does not yet exist for code
> outside of the page allocator, create it as a trivial wrapper for
> __free_frozen_pages(..., FPI_TRYLOCK).
>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Hao Li <hao.li@linux.dev>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Alexei Starovoitov <ast@kernel.org>
