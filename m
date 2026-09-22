Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD730EACD
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790056186; cv=pass; b=MpzYeIouhjgwfZgbECjwFZ4Nhil8ImDXh+CpL5zyr8r44qm7Am4B3cyc6cLf17Pxv+Z7W/RjDrc6l/2nuYF0u1k5aQiDEeejblVUvys9/SD0fwbxOHRz2UUt884hSljNszSzm04UIvGKllGtGcY6cNbS2LnWoRaf+TLLcWXPEJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790056186; c=relaxed/simple;
	bh=IaiBMhZiUx180hfzBlwurDk/2OaLS6t9ll9ildR+i7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hB40FZRXZZ4dqZlcx+9qXAMriFdXHjUGklU3y3xjqmKqlu8dQgKRQAzCVYkBZUEYZWaBGC+5FYzIYARLEa/XukJ8d8aDod/4oRlYpIYPrhrbBhA0uWOnnfuGcdNxEyyP0F+CcGUgp831MWuESG9GOJkpcIvH9iRkq3rKHxhvVWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWtDYcLC; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWtDYcLC"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c2c08ff3f8so2569735b6e.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 22:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790056183; cv=none;
        d=google.com; s=arc-20260327;
        b=IsCohdD5AbE30wdir+tnZQfrV6xnEaywtl5U2kyWmUC/v0vyHnvFshz3JG43EfVUKr
         XYNpUS0QwQcxL6T2JP1s9sQ2zWXOTql80DlVJ+6lt0j83wB3J8RGna/qmJugTgepYcNG
         WpWX7stveDxOVzJWK6tTNeWPlz7UjquXuKz/OeFHaj5z1bkWERKi/rM59Y9b9m8v2KGc
         3WJcJo5S2Sp4Wvslu4cs3SxRu16dvXmSYxyyxV8RQoDjOLaMRV3+TlF1n26ZcFQSo5fO
         L9Uhe4g7sVRgSjd2R5M3NP3svCdKYHaRJTIJ4a3dR5kDYUVLc8slUo1i3wZdlTpTD02Y
         57cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DPxPXWoz+HQZCMKgPFUzkLpcsujYcZZJRRnxahFNCJA=;
        fh=Vr4NkisCPZNNWUg5bYTtWHCzuHr8KfWRuJTfhM/1ceE=;
        b=IsfYkZ1Tt1zE+KgKjSvSX60ptZX1ZCmDEpwVpAGSTl7yxpW0dsSEt6Bcw4m0xodTYT
         fjORQTK6C7Zqmz4lKXMlyhtwqqjTTy0wYU39vYWdzTFk/tczNuIo5RWeoZOUz0peIxxU
         DLT0Pgn9w5mYKm+WLg9wWYmz2FX2Fx4VWgDY4kKEAz0r+1oiy4xZHEanHWEMliulFe5H
         Gy1NLG5SwITMy8eD2yAo2iC1vi917fLw/0zzDroaOvVhGyTYGdnWj6FPa6Pkd+ad38Iy
         HHJx1CU6c4PNRX4nd5VWQjlLqEDHsQWptnmfDgCuXQKETmva+zvYLOp6/r8pG5gcAcQz
         uRXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790056183; x=1790660983; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPxPXWoz+HQZCMKgPFUzkLpcsujYcZZJRRnxahFNCJA=;
        b=hWtDYcLCiA0hFsOwAxPW+sj2VcZYiwFaK91IBI2QgBUDZIYgzb9oGbpSwLGLdvbXH5
         ylViM86n33S/mBiXwnQiiKIafiowFWdnwQGvNdxCzYReHQZe/kYWRFjme9RsRbxOsBLh
         3ri+6jatKzqMme4qK0x8Cloe8T9TIAFoX1jPFUbQs3g3iBreSYmMbPGBK3faKIwcIQ9i
         jOT6ooGauQ8WK4v0v7Y73ResKKYbog5lZ/KCmKMoRMl85GvSMOnHp7boYuCh3fOi5woy
         +aUAn94CZQ3S6D7ZZ437hjw5et/I1nYxTOXK4/MSII8UheCyimqPcIBc599WL1itekz+
         TreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790056183; x=1790660983;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DPxPXWoz+HQZCMKgPFUzkLpcsujYcZZJRRnxahFNCJA=;
        b=XI9N4NLtrYr8GTvS14ukwbzZaQRH6VHzAFKMvZ+Ot3h/EeB9v/BwQApA6Y8pdV3B9H
         e+rxNpNuslbITUAjyT8mSJfoopaCsnrDdcG5eLq8EW2HZo8rfhv8+sANSggy7q4OLgyZ
         aqY8AgRJjjUSICv75RE/03dCoZ4OvtW8Q6xTgBO3Grh491aKAuEHAU7Opei74bkEPnAc
         +dwGGQ59VpUS4R1b5PzwvQopm/sJ84E5sM2A+4XcZxmCQ9bQn/uJM8QKszpOf32COx96
         G9I4ARrnogS2L2+aloQmVopPUYI+XLHgq2j99U8DhZPTLkAk85AyGYuJ7mblosZEbgBw
         H8hA==
X-Forwarded-Encrypted: i=1; AKwUvBydD1La7Pt5LqQX4PbKO+ncSPSkJ0SWk/0GrKWvsH30tIJGXKbKNspjcFwYLejApRx0zbs=@vger.kernel.org
X-Gm-Message-State: AFuF++k3P1Vk4FYMuxbjA2GI3qV1U6jl+0nuImiRHE7fg6QzdkPpCk/b
	sAY7wIj/jJQWehAQx/BTiE+RcvOXMUOZIEdEHJtz+saWQIdAbQNQ31faM/Ex9lb0LrioGGezhFK
	BfDbvFh/WznwFolGq21Y4goHbB78LcQDdaSGiXSw=
X-Gm-Gg: AYBFou2QcblvAuEFNmNbfICI2zS05H0BXD98xBTRCQIeZZVTMxOGgVoGBR3QTlqgaCq
	eEPa8/3ntoe6mEoxRGEBo3HG7vSmXV0XXQaJLRoZY6rGcWWSooSWJc2b1gGb3YTpQCrtzifmi6b
	jQg4KABttqrZ+8FIeOB5wsMN0X2Q3yogcICrtARttNZJ+8As/JkZv03ZtsOmuowCvWj8F+ilHb1
	7hAj/UPAPvxx2dEaLi/cfPZ18UJRmSMyHMu/KUvIa+/w2EAVTP32FtCUCjU8MlPoh6ot/s+exmp
	zLQQC3Fx2y5X1zVORS0VVvzcs97JcCSEzkPU+rFNM95XGzf6cyEl5oFxVhMHwxwBZRlMFMGyGjp
	Ej9DgkCIHug==
X-Received: by 2002:a05:6808:4f21:b0:4b9:a829:f012 with SMTP id
 5614622812f47-4d4657acac9mr1212151b6e.30.1790056183526; Mon, 21 Sep 2026
 22:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921154650.130677-1-suchitkarunakaran@gmail.com>
 <DLL5PFJLT64M.1W82K71YXNT3A@gmail.com> <CAO9wTFjK+oRT-maca6A1UDBrgYTGB0Zr48UiLm2Ees835POOFg@mail.gmail.com>
 <DLL8564LZU8N.16W933Z547TYI@gmail.com>
In-Reply-To: <DLL8564LZU8N.16W933Z547TYI@gmail.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Tue, 22 Sep 2026 11:19:31 +0530
X-Gm-Features: AcwNN1W6xOYvi9sFyoWMbEvyWviGH90dvlmITiywUV51uj567TW5Vdt-iXrGmWI
Message-ID: <CAO9wTFjNX18eynH7EJGjzMeE+yXx9XesLSW9gJCYXTSqNJMavQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: add diagnostics for rejected memory and map accesses
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, john.fastabend@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sept 2026 at 00:30, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon Sep 21, 2026 at 5:38 PM UTC, Suchit Karunakaran wrote:
> > On Mon, 21 Sept 2026 at 22:35, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Sep 21, 2026 at 09:16 PM Suchit Karunakaran <suchitkarunakaran@gmail.com> wrote:
> > > >                                       verbose(env, "sign extending loads from arena are not supported yet\n");
> > > > +                                     bpf_diag_policy(
> > > > +                                             env, i + delta, "sign-extending arena load",
> > > > +                                             "the current JIT does not support this load instruction for arena memory",
> > > > +                                             "Use a kernel and architecture with JIT support for this arena load.");
> > >
> > > Did you read what AI generated for you?
> > > "Use a kernel and architecture with JIT support for this arena load."
> > > ?!?!
> > >
> > > Please apply human filter to every single line of "your" patches.
> > >
> > > pw-bot: cr
> >
> > Hi Alexei. I'm sorry for the oversight. I somehow misinterpreted it as
> > "Use a kernel and architecture with JIT that supports this arena
> > load." Is the following diagnostic message fine? If yes I'll correct
> > it in v2.
> > bpf_diag_policy(env, i + delta,
> > "sign-extending arena load", "the current JIT backend doesn't
> > implement sign-extending loads from arena memory",
> >  "Use a kernel and architecture where the BPF JIT supports
> > sign-extending loads from arena memory.");
>
> No. That is still wrong. Put yourself in user's shoes.
> How would you react to this message?
>

Hi Alexei, thanks for the review. After some research, I found that
the sign extending load instruction was introduced in BPF ISA V4.
Given that, would the following diagnostic message be more helpful for
users?
bpf_diag_policy(env, i + delta,
"sign-extending load from arena memory",
"the current JIT backend doesn't implement sign-extending loads from
arena memory",
"Recompile the BPF program with Clang's -mcpu=v3 to avoid generating
sign-extending load instructions.");
