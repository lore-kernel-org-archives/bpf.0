Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEC239FCB4
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270491; cv=pass; b=KkYyMWjKNDVE6wEPJZJ031YKpSJYZqjfQ2eclQTDCnkhHmyQaEHqPguP28BGWufNLS3s47RnolLvpK0xIQcvQV3J5WOpqBmNJuL3+lQRnsTZcFRGanSs3eqRDePVvTlK+yzi+5e32b0omr1Gg1z141Iz0KYMhnwBt/1Fbtj9ZN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270491; c=relaxed/simple;
	bh=cvUnf1QvCWiOix864FWsER/QNfQ5oSFc+edt/4YQvgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssgiaectf7YHJbItFrTVeTbZGssdwp1qYpeAhUPPy5x5sZqG6ij/6rhVjTvNQ6EmrzDWG9czjI7qE0THyOCFJy3GInzkUqH2d27o9WS3anQ7VijcUg9ozj6xOjuPdHkgUm7/trXBtb4zI1ybxsU7JNcHA9GmIlNSMCSQeNhDYt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnyKrLfR; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnyKrLfR"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439aa2f8ebaso230782f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:08:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773270488; cv=none;
        d=google.com; s=arc-20240605;
        b=XKaodhGhVLVoLKNn1zQig47DpRUEvLwAj7biIP6t78MJUhe6zjP3RHj5QpNAjo15Qh
         BjqF8oZc3x/98GbitiLI6okejGqEXgDsObXhqLWXIHb//q/Ye/SLwCg9A0uEBDDP5JVo
         4NOE07WJAZvka66+rMH+VSWH3UYStIDepWUDNWoup5ZsFyfp0sTgyndpTFOtomkhKxx2
         o2ftfKk10IJya0yRdo2Z4AsTktCPCwSLywNV3gak35svLEgP4rp78uwCERmPKrKSEnFR
         0+TDqotXTE865dnJEh6At/Y0+RtAtlCgRnxdCqM4tOrGS8qhJHOqTiiHL2aMUBveoLaO
         mW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JJz/XOKGAV6ZwO0rvw25DGMH/MPcBHcGIy9w3exJ31U=;
        fh=GU/f4FCB+BeY70ffrfNtdPhUF70weCpjyG1nD/9YqG8=;
        b=WuZhFOX6lCZR1FRHCZS5Sh2yeq97NdSXyKGLPzic7c/tKEpMACQS7hnmqiUeVO/5z6
         St1G7X1yBztQ9ijq33m8YW/hnO4j0mOEQF+1Dy6bkeITKtWEIirZpf6UC9x6LgMJ2jYr
         A7TOWW+1y8JyVtziHLjFJ9kB4t6i1AxNqpfKLV845scG4ADoAnAoTpblc5NomuXCzwDC
         iiUWuENayIjX7kWXC/1VXKfwIsH5jAuH75c8IQ4Av+PqBjdEDmVjJaXxIfkALrFOwFYN
         vLOAt5zt5q3TBpENjC6Juzhf+87K0yHXjrbosw3+shaSJyE8GWI1rXR8n4BaIT81TeBk
         1yTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773270488; x=1773875288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JJz/XOKGAV6ZwO0rvw25DGMH/MPcBHcGIy9w3exJ31U=;
        b=YnyKrLfRFcqMZC3VlPIW95VMGwx6d5MxaMnRgG3JAtqi3keN2i3es83cpWuUIA+jpO
         dlJylru2J2P2GR1GlWcZOUVTcl1T8wrtxsiN24bxTtlXTPiphJ0+Agf09dv7EEDzrOCw
         PXONURnrObp7BjKwAt7sh2g7lRpS7zKMAZXVB8uSkBAs+P/a+BTMTRSIJmdHtAR1S7gj
         Zjk/Lrb6Im724WB+mDRC/JKYceFgwjfqoA2yimGYYkF5I/9WyLJIb6t7N821STrFAS4t
         /2ixvNdkToSt2cJdMq6vE+0eU/rS9+ryrIw9E54Lm4pvRaZmcbbJojSGvFeS6joWJsvZ
         /zuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773270488; x=1773875288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJz/XOKGAV6ZwO0rvw25DGMH/MPcBHcGIy9w3exJ31U=;
        b=vm3r2o/DsqOe2mH29ZIPZY6xodkTWqtEoH+5/i9W70/Mjo3u8gdtj63M4Pb43GcHr3
         GXV7rGGhB4joeeWMOeZDQSuIKctxT3NINxM7ENMykhVXySACZ0cd2EHOJIpwXY36XU4/
         lPP0rAbmOwXb8waedb6XkX3z7SQwWJP/AQalIYFOce52PZ16bEstj3mYlESZ5hI3KkKa
         MBXFOCuuygUfXZjweYat9LeuxJ+BOkMhV0t4snRDI0MFqNFxH7cIHaO8m5mqc11N06Xp
         8SmAnFzYi8z4oIXjEvmoP7kRGTV5SWINH3jGz2m3R7RrcsSbTcE4gjlcIGZKMp+USTOD
         psBw==
X-Forwarded-Encrypted: i=1; AJvYcCXWur3mS5G5l24aA+rpDCRc0xUOptNue44OiTfRbWE5+l/Cs82+uLJGq0plnkHuXvg6IV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XBFk5z4/1wM4m6KdV1xbcUm+inRGBq8H+z2sx9D+sf4+xcCd
	Kpv4/x64ljXhQQnbJuhePEN25oVbC/k0gYdM8HnuscxQPY66EzwCCicoWICgNNousXeurNlEC86
	5tLp6re8b9r5RRtXewigiyYcLxGYJbCU=
X-Gm-Gg: ATEYQzylY97xqaAbJJb8avZpc7d63e1pc999pmuXbPflN9tjfFfdxuKFEclwBbaA8g0
	M+1AweLAeK7c2F+I8k8FdCne/N8O5DFJLvlo2pGqcv0cSP8bRwSDZQSwPxd/wTEQWTyXy5XW2b3
	CSHj4h49AN6/WhafbZFuV1Z6sflwiJcwGgMGAruXzTbuBOSrUKS27Y/NYkPkj1tXTXPKHNLUW5w
	NAUHsMGLbdG51wAlMgaIsVyUG6Fok5CrEX7iOBgiNhwr9Z6TD/F302oCVHR1gqmwdvmOzIXLRo2
	EFwGJTL+pPB8NxmCuGsvMzVEcNUe/1iuYxZeHRpTHkMA+rW+/SuVFE/M+7PnWdlO+chNa04=
X-Received: by 2002:a05:6000:288a:b0:439:a95b:3c43 with SMTP id
 ffacd0b85a97d-439f81c7702mr8339767f8f.21.1773270487903; Wed, 11 Mar 2026
 16:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com> <26aec9bced7c1d13ca1d7bbe344485c2bdd7b85bcf4489cef17293f6e278528f@mail.kernel.org>
In-Reply-To: <26aec9bced7c1d13ca1d7bbe344485c2bdd7b85bcf4489cef17293f6e278528f@mail.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 12 Mar 2026 00:07:31 +0100
X-Gm-Features: AaiRm51yazeit5EjeuzeE47DLxFFozWXuprR2gt8QjkxefM5NsbrsCKNnkFMiq4
Message-ID: <CAP01T77gknuNiiVKny-cThb6b-dFxGPmPKx1eMryLoN2AkHo8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Verifier support for sleepable raw
 tracepoint programs
To: bot+bpf-ci@kernel.org
Cc: mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, yatsenko@meta.com, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 19:53, <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -25435,6 +25441,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
> >               case BPF_MODIFY_RETURN:
> >               case BPF_TRACE_ITER:
> >               case BPF_TRACE_FSESSION:
> > +             case BPF_TRACE_RAW_TP:
> >                       return true;
> >               default:
> >                       return false;
> > @@ -25464,7 +25471,7 @@ struct bpf_attach_target_info tgt_info = {};
> >       }
> >
> >       if (prog->sleepable && !can_be_sleepable(prog)) {
> > -             verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
> > +             verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, struct_ops, and raw_tp programs can be sleepable\n");
>
> The updated error message adds raw_tp but still omits fsession,
> which is listed in can_be_sleepable() just above. Should this
> read "fentry/fexit/fmod_ret/fsession, lsm, iter, uprobe,
> struct_ops, and raw_tp"?
>

We can ignore AI for now, Leon has a change for this.

> >               return -EINVAL;
> >       }
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22968403755
