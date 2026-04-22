Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE23932DE
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880709; cv=pass; b=eBvuRYU5I8EMLgJ9cmiYyYHzd23z2mYituQFCYA3TPlb7liubJIClrU06Yzt3rQC0bstQjYEmdMLGckGr0khqd5oTl8LgP3Wpxo4Cj6imcKm3v2l1pyuZ80exAuUg338RegmCOBFnYfSLRrmV28NRqXegaNwRQFePfivuAV3nug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880709; c=relaxed/simple;
	bh=OYQgQqODq9ZjVC8hKx0WQTSmQrHConNkS6DT2EpblXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jafJpGyJwAT2zvhUaI/cmPPsaDmCf8OQ9txIB+PuO14xUefYL3jup41jwqWTXgXc7ApjxYdpBVBYU8BbCtEgLA80vdj2j1UMdgvbBht9p3d+MrgoLkQ6UT0/UWO96QclRAQ2SSV81kVBeJoXdF19/+SYc4isLMVSb0e7x+eQHdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1LOVY1K; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1LOVY1K"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43d03db7f87so3949456f8f.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 10:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776880706; cv=none;
        d=google.com; s=arc-20240605;
        b=eWmbfDuN3FcNrZtcPVOiH6R/UefRTd8+FRdldQRNOWXygOj4O6Ij7xJGGzbxgubDWb
         65x0W+IDyc0y9+aT5/zeg/jUV9S8aO33IEONtDWOqB0UabcTJEv4ogjSfJugk9zEsklC
         GmPQDfrbdgw7c3KSEcO4QUH1qEpq9oIbPeiOaCfs9sPoRBMgd7QQFN3sx2eDdzgcxNFK
         x7W6QJcf/OSGamu+INWEM0aBREiD9/9krAPVaH8LMjKtuCvx0A+HGYSBLQHvWrQ7/RND
         4g8Lj125e6YzesfbPi3UBFRcSY8zWogXja7lVD4+jbMceKbqnph7tVUsi0SCuevyLUqy
         nmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K2cukNYCunc0oM+1Oiy3CCAUbasTyrukPMMX99jlUiU=;
        fh=/ep/JySUr1SqKqc2m1l9hUG9Vlk5v+/7/N33HtWaMuE=;
        b=E0m312G44f3I8/8qWy2HPJrXxV3Cz8pQZm2EA3yeM0D9iOg0jzWiRrWlTpsAAWaVrt
         I0n2qvRyMrg1gXEV/kW9mC1yZiUgtvhmuSXzRyngh1ayd6013/BgCocBb6qcqJeq3Z1R
         qNndNo67EQ87iNkc2/8aCdJn8iT7lhx5Q/h1U0EwVTgw9z+4ADw2v3WbktwsndkFrFFB
         78STWhgw/ClV6MsUCfp9aOhZdbIZNhlRTN/ax/WGtyFRpd6TRgP7ykcaFI8C5h4Ry5K4
         fHGP9PNPL8uEdILdFXo0XoTxzmb9dQSDTql/KhJLLUq6/ULxqcBLgM8/uTVdRWLgWp5g
         Q2LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776880706; x=1777485506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2cukNYCunc0oM+1Oiy3CCAUbasTyrukPMMX99jlUiU=;
        b=F1LOVY1KQ7sfk7ULuuaCwZCqu1FvFST3Vb10jIuhBJDrBrg2nb2lVXlJDjZf56G3nx
         tRay6JlI4gZO95AdmG7byGrimN4pPcxk/9WAZojM2xDUQ8pzep3mzQU6LsVFJr5pAMe0
         IUEwFUNPjUYiYk+ZnjDqFZRQHYuDBMxfcJZVy+FPNYth+dgaTGejRSqzLyGcVYw5wXKc
         +UahaxAdVv2Ss8qdw6XCXDowjzTOTsKSPjPVshKm65dbpeg/U4WB19tKOy7Ra7j/4NSg
         efI/uGjDir6N8yTwtQM68/HRDdJ8DKVTaGniFGy/7kgtGB1aul/mh7urdmRO5IqN9afu
         zsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776880706; x=1777485506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2cukNYCunc0oM+1Oiy3CCAUbasTyrukPMMX99jlUiU=;
        b=gTM6wZHjR3/E9LHo70M4cX6NGKKBdR2VY5PJImYw99yeKCjbSRaYsNJLWSfC41SZKq
         tb0O3JWw/GeQjn9nIqAWIcXK97G5YixEdZXvafXMXFHLfzfmo8K/+SkIQqCXq9fSkXpb
         ktA6bNDBbyNrbK8H/nAZBiQvyVx4ph4V2Tb4ko3TuOadoilG43hUaVEZtGz6P/GFpChz
         X4YTVDBSHBTmjq6/oDvtyzymEWRxWq3mkMyd0mRt7ruzKBp8/G70i0+QHRBE5ZNwi4ln
         WxXoJ/SozHQliE4rrh3rgT5aHDNFYJeQihskTpt7Q5DVNrr19/pc1M34/XxAQtpk4aEq
         /sBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+h6vrx7QyaSmiuOau9earz2ybHRtR4lQ4VvD7UyCJqnTwgSxtZzUXnk6upzc+d0htopvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwObBXP42nlflhXJm+QZumlqdjO4ufjwwvLYKRTO71ys5FNEwd/
	J9qyUz5PX8SCpEf61bhIjW5tjWU1zIpuvDhb+DBmbB2NuHh1h8N6v4uqMbZ2Ufzt99BREAiEeFF
	/L2uyLlNnMQ95kyWlVaBWvEHc22Zsh2o=
X-Gm-Gg: AeBDieuLbTDrm+kj+jJk0ElHdBsQXS+C2F3NGU5xUjZO8jv8CSQR4pzS2nkodUI//0w
	3xynscdSklI2Wjt8NyF068qCZRksKBWyiMR2ZowzS44wJYMWzQMMOY39/bm34iA6bmKGaELmCGI
	mkLT3hqajtnFOcJba4rAwMWLzIUFAKLr3EUiRKr7TvnxR8g4lv3z5LzokttykuauDevA5VX/meL
	ax1UejLcaFw1q4E9cWZA6jnOwTBfkzzHdx8NpUeNVd9J8FE8gXs7KifmLVx7pXJWrX2AucQU3/c
	FBqGp8m3ZZasUQZ0TCbzoQuVIPWClExV0mJ8TujK+xwQZcUfCx5bfsxtnTbnrT6p2a87jgEMNBs
	EXiPAI4wa0c/u5d/fhfgtqgjbodDQ230c6Yomd7CP6PeSL4mu61SSUs5i
X-Received: by 2002:a05:6000:1ac9:b0:43d:2f94:3b40 with SMTP id
 ffacd0b85a97d-43fe3db343dmr36198150f8f.6.1776880705652; Wed, 22 Apr 2026
 10:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422-sleepable_tracepoints-v12-2-744bf0e3b311@meta.com>
 <e93b3ecc3e3406ac70466f8083544d896295f6fbb3f07c8e5a059fa25f8f19b2@mail.kernel.org>
 <5e93b4e4-12db-454f-b900-68ebad02ba5b@gmail.com> <CAADnVQLBk8oARVE9vZoM8Cabtov3RVr3Ezp3tG3NahoU5=6ktQ@mail.gmail.com>
In-Reply-To: <CAADnVQLBk8oARVE9vZoM8Cabtov3RVr3Ezp3tG3NahoU5=6ktQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 22 Apr 2026 19:57:48 +0200
X-Gm-Features: AQROBzCub2eGDzVIRpOskA2gqPvpGschvkwe9SAKqxg3cnyk4oyBi-JKudOW2jI
Message-ID: <CAP01T76Ck1u5Cj-H81ipWvMXy=O=MzZk14cMZzTOL4YK=38EeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 2/6] bpf: Add bpf_prog_run_array_sleepable()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bot+bpf-ci@kernel.org, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Apr 2026 at 19:00, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Apr 22, 2026 at 9:36=E2=80=AFAM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > >> +
> > >> +            if (prog->sleepable) {
> > >> +                    guard(rcu)();
> > >> +                    ret &=3D run_prog(prog, ctx);
> > >> +            } else {
> > >> +                    ret &=3D run_prog(prog, ctx);
> > >> +            }
> > >
> >
> > Yep, this one should be inverted.
>
> Ohh and CI was green. Looks like there is a gap in test coverage.
> I thought you added a test that does something like bpf_copy_from_user.
> We should have seen the splat with config_debug_atomic_sleep.
> What happened?

CI will likely be green even with splat, since it may not be
registered as test failure?
