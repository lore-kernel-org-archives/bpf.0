Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849D5221D1
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984919; cv=pass; b=PkTbiBUvOfKSpHOTpCwjh7CqhUeC9AR7+Tjs9VuSuUxQOS4MY1MCx8R56Q1mBAY6ejutFNVG4nlb5DvJ7EjUgQJvMubGzAcjFen6n7wnaPYBFLTwLEEbxLxL1ztP2pbxy5g0Do+Lm7pTGxD6b1cX9Wz6yVtxxnZrY0PuQZ1hcAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984919; c=relaxed/simple;
	bh=c+OeZfZTEmBgmzH9jxn8NINSZZs8YxUgl6FS0a+r7uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILbkI1bvCJbBjZqhjk5hrVgnl3tWJFFKNhasub13woxt3pAP7QCyTidvNs9Uzs8+xceAltm57MF1rFRMdAQwsAhWJDLPWJ7v5+XckEgLVuxKYFFxNvZ/XT0c1BEPlu1Xc6qbc8PpAW5XNavjzgBcGlmJuIzX7ZjcHTd9uxE209k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfBYYo0g; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfBYYo0g"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c315869241fso149642466b.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791984912; cv=none;
        d=google.com; s=arc-20260327;
        b=DmM90g5CqtVIsZVUuP30IE6mJ3IGjFPzcfiw03BuOnUsovwkDoeZ8bZAyz1vvxlXK0
         kZIVRbzj78M6ibYNBjE+3mgO74LexCHNU5aQ6Oej8I7B96FXwVh9zmomV9mnMK7f9twC
         ylkxElQc6XnpCqMQV8A/pFLZemmLkiLP2SgbymeWDsUDVl/QUH3cf/rdvRCkXSLnKzj3
         fSEGZWgm7fwvC44IuVpJOSza6ze3NgLhlk8C/AqW8pMZnnEbjNUZBhdjRT1nsoAKX1HD
         LbA774fSDCrPaS0BnzY0JOh773H81tv8MD7hm+caS+ytNaPIcT4zSG1BdzI2b4RumUb0
         6MTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c+OeZfZTEmBgmzH9jxn8NINSZZs8YxUgl6FS0a+r7uA=;
        fh=95CG2C1X0gnimgVTomCIDhGafqxVcnpdJ18YF1ciD8M=;
        b=lPoUHNs1Gc9KNWU2GjWFYSLPncKy/BEBQSGb3LQErQrQ5nGjgFkENwMFjD1I4+7FMt
         N17Pk0C0NkQtshG2rySVlytQ6agmJf+XVoN2EyPikPAq9lBT2L+3jk4Xr3qUfLPeydyL
         saLX9+TL1NFchMNVgBjNh+/VIBcbBo1f7b7iSz496YaqnJ5WOYAu9kcWhuuXa0hBB4k7
         REpPHkhB+06gD5vd4RCkTNSSVudgEOon7X6sXiGf/Daqw87E53ZhuIKbO/SSmOxWFCDi
         Y7UMgVUtg22/qfdKcoEXNzwuonD02loL09RlZYDHWgkBFEoJFkEQ91yLvzHupYplpJKx
         Zzvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791984912; x=1792589712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c+OeZfZTEmBgmzH9jxn8NINSZZs8YxUgl6FS0a+r7uA=;
        b=YfBYYo0gcrtmptHvXM7LHBKqMkEj2he/6KqUH6xViYtP3atxakwKfp7jEgjP+NK9Rt
         bEtPICk5MTFO8OZ6mUue8lqIF1DO0yBvAEHqnk204unJIwbAcd+D5bF0wWyhl4UGEtRS
         K5dEdmm6Ad/0tH8xfxZ/lWtoIWSq4c6UEwMgYoxefkOleiJ7WitLp4YZ1nRuvtZF5m4n
         oRrmdtuDsQ71lukzsq+NXrWx2+046KL8WSSkkpRsnGtW/dWxkKZIjrhZv0LjKoN4FkaZ
         rCrZP8NKpeuvEU3m7UzLYbEEmyEv9guiJK7YYzDEWjzYo8pTDW5AoR+swEnQcp/eISLe
         Jn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791984912; x=1792589712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+OeZfZTEmBgmzH9jxn8NINSZZs8YxUgl6FS0a+r7uA=;
        b=lMlcdh+oTTKUGFNmDIsUA1O/xT8s+zJCTKTnUSHxoQf78Dat9q8oQ7M/I5c18jZDVx
         XrfRXoh16n1XYsgMuxjVDJ3xIsPpma9UtvYvzNH8XN/q9cgjbpA5LND8iSH0F/1C4O2v
         fZfFma+dU/o2CZRGywxW/unHGnYmZ+yv8Zg2LTsDjzOlivNxgAdEvI01JB8OLILmktLh
         NbU2k8bSJ0B64TqqyLjxQmPD95ZBtb27v9a8ucHxbz6YVBMqVi93J9nT//AM1ySkKooo
         fhzmG3P/hCU08lLg35PG8NtgVMmAOadoP2s8PQtJTGKk5YvsS5KVW7jDkNm1kTRSAuUQ
         uQgw==
X-Gm-Message-State: AFq9FYIG7nJ/za7qWoMPpvLKkbhI36U3m15yN2JGyjnkrjb5C32zEdks
	sVB2ty+w8da4i0uslBtj8CJL8KZqvGNitS5Kico7sUsiMGjBdLYjrbXCbvhzdq3EOZZaTHLOw5H
	nNZ72MWuiesmwXrwCLCbeVRJhK30+naM=
X-Gm-Gg: AYBFou2tiPOv5xR/AwVLiSR7EsqrnkQO7WDv977Kocxm23RVRtP6Za1677FyNp5sc9p
	j5Gs77NL1ct1BzoYWi81Ru0eWcQ8KC5Sf8tjZYcuUNwGwNEp1JVUvvTv4LEAxQlYM7HPZlZdy6S
	Ba3YYJlrP4c7Kvlr/iLYPRvoo5DR4O73BuXq6c0fI2xeaYjoxuLFOc3fnWdiiez+L77r5RuUQv7
	rPhtVvAKltrYI6FFA5dHL5+Z5fZRzQ0uxz5yxiatAQduJHP6c4XdnOkpSYxTLS7/SrEnDovC86L
	39YA0jPkJ1Vhyd3ih4BVCjwAhVbtY0M3KM1vF+BZNeav+MYibTxlg4lmXpIleXtsWVWbNDg=
X-Received: by 2002:a17:907:3f25:b0:c31:82aa:dd4c with SMTP id
 a640c23a62f3a-c31a9d15f06mr1479598566b.24.1791984912292; Wed, 14 Oct 2026
 06:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014125017.1426212-4-puranjay@kernel.org> <355b273a4b679e2549bdb7356695d9f31ced9419697a7b94ae472b49a453e1f3@mail.kernel.org>
In-Reply-To: <355b273a4b679e2549bdb7356695d9f31ced9419697a7b94ae472b49a453e1f3@mail.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 14 Oct 2026 14:34:59 +0100
X-Gm-Features: AclHuK-zJWbg3a890-Dw7MFZtKGfx7ZIZdNLpk1ciBNLjBPkIaN_cTU3YOuDbV0
Message-ID: <CANk7y0j0D4W4M4EimMFeGxLV+d97gNGVZLfs66qTT3y6EB+O4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] sched_ext: Use fetching atomics for cmask
 instead of a cmpxchg loop
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, martin.lau@kernel.org, mason@kernel.org, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 2:23=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > sched_ext: Use fetching atomics for cmask instead of a cmpxchg loop
>
> TL;DR: Commit message only: the riscv-without-Zacas claim looks impossibl=
e
> since arena needs Zacas, and "all four helpers" needing new JIT support h=
olds
> only for LLVM >=3D 20.

LLVM >=3D 20 is expected now.
