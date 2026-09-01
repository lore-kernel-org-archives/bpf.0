Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12042442B21
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788279715; cv=pass; b=Mw9dY0vyI01z+6IqZejGLaN4TbguQKGI4n4dacqNARe/BDzLLwnw3pBYSwc5P0qb2teHcF/L9iaxnmUyfwqX7fXScGvHkX+CrcX8LFRsOb158QloA04X+WBBcPRnob31Eu15+OYCsQWiBB8PMJiwNIafuPcqMS7jU5xAhDkBh9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788279715; c=relaxed/simple;
	bh=XaQNv+zeiJrzX099tm/uHlZffljZGddV8oC3XmKyvAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/9oYiYKeDtmJffn0xlU7bzyaIsdoW9LAoLaFph4yUShIucGuKusuxAkYtQG7KNvqBJl/YXThb3bJOoDNPi04ayV5FirLKjOJb2cfzDaY4doZnQGrvCIxqiIOHH7TL9oqmj1pAl+EQKPoiNk4mL4yzXb+fE73mYHiVA9pBrH2JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k21i5FNl; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k21i5FNl"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8588583a7c3so1434187b3.2
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 09:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788279713; cv=none;
        d=google.com; s=arc-20260327;
        b=mTJmyHxxvoO2LxHZ05mDI81PsQ808zYmeGvZuZdkJXh2iKbOUgJa28SFCmCklF4MqI
         ++dFFT85Tby98kiNXS/faL6/1VqtfQ+SOlebUvgF10Zb7BDOneS7p7XiW1tPMdcNmCzJ
         LX4sZi+yUi9V9+mv4RSPddpMkFWoUnwkLm8tK9EtSMDqSL7aWPRHoykGcMd4A75z6bDD
         wJLCk/ABXUeZ7N+l5wyo64ZW3tmZGyiCrteuYI46lGeQyUgxhNbLA1RAGKCnZrT9MHao
         XPcjQXh6r8/NvKsQuF5yXqVUiBbeHJjn16tWpuHqAZFmevRTTKbvXSvLov3IFao21lA4
         J51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CMrkNezfQFKtjzJQ7zkFirRWnc0CozVPGs7Jr4asQQQ=;
        fh=SuN8QxB1YbaaMKKgMNiHd/VxsshlkLA6jUxTaYDvHWo=;
        b=NQ2J5F5yvZwQkiXPPyZ8JCDQO9QEXtCKyERzjcB/oZH2zmNBswv5olMiZ4vgZNth58
         3Q+p4tmjG2zmN2dRKitbYraQB9dVD/Oyw1atrf69JUyWLJUUH63ozS3+ZncVd4op6qQ/
         XJCyzLCHaFi79NTi7dT8pMFhCsntd7aiN2fi6Q5av3c19Ov9I8cUeJ6NihGde5GrsJHW
         ypzzjqa1i9LCfHIv/P9d6MkA1GwfBe9+sR6i0tOmbEK/XfWU1X918kskuvHhCf7/JJlH
         xWo4LGFf5rZZ7QAHqCykP+bS6DNzGjY55lQwFv15GLaxwgCSmo0+vluussFNcr9rxAdn
         Zp7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788279713; x=1788884513; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMrkNezfQFKtjzJQ7zkFirRWnc0CozVPGs7Jr4asQQQ=;
        b=k21i5FNlEhoGDVkLOyvHRzBE4f6ZmvmRj8S/6SAFQqEcadCZ87Nxl8NvH8YokkGolY
         RszOmMKfezisImzr1q4llW4FcTBzWUZl7X776XQy2NqW3Z/dc5AVc9/S58C6z7ztAlzU
         tEM0uOZVuwWH/K22X0H0M4z3fApZZRVPEgFL7iVPNfR1EMbg5yQqKOPNpSWM50OcfBv0
         pz9DYnbRmB9dT01fMuTvxJRPZPxZIGpvzbyMKPn4/v/8Yyk53MwKpfiMDnp78dizTTSM
         I82YRK8q4bj5/GbStSXKehzVTJozHjDhX8aWJVpNKWXr32iCjJjYqmXJif0Ftt/Kwiwt
         Izmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788279713; x=1788884513;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CMrkNezfQFKtjzJQ7zkFirRWnc0CozVPGs7Jr4asQQQ=;
        b=im9GCrgeWUYINdEt/cW93qm/9cWK84sYS6PW94gMbWITwm9Kjk/JbtMzkOVEiG59tT
         iKLWaxzZgKuRmZWVsIwHu51MzFm+vfYTFfBCZT3AZhn/Mt+2NXLnQRJc1fZSWcMYwXb+
         pG3hW3P+l2CrNr5VNjyvM97aOiGsBJ1aEY8b+rS3Zu0O2LWXai1S53KBjHt4Q+FAZ7cw
         BynlEABNrHeW4oD5y1jfeC+LZeyOzU3oxS7SWPY+hc4WuS0zO/LZt1r5rW2TKA4fy1yB
         Zq90YL0CVozPJsfxaLbiOIeRzNddmlTKaRKGzMNZf//lrCV6hSEGg/o0/BS5I6JHRoq6
         /7VQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOpmSeFylPZhGlFjrfr020JxUuiqXbMItjV7cLFRu/KZy0UH5hdin7BlelHnQn/acArwY=@vger.kernel.org
X-Gm-Message-State: AFuF++mju/1eg89dE2QkEbSWUsT+tH0nTDcYKUvIUnHqfhB1HpzU4mwF
	opdEWgAoaq01GQMCXQdTjBBoNgcZxMAI7ngYREi0kt4/8uU62+vC3v2vfwkPvsC7qjyJ2L2ZizP
	Ty5WOfCT01KMmNbobEyzpSkw56xbOO8o=
X-Gm-Gg: AYBFou1Ib2EZP2TO6t3xk6Ohlx1twsnP9rccyORJRy3Te/r/rDZ/Gp/qREqimKxJXTZ
	AAbyZlyjZd77VfirI1ocNMrhde9knhA+iYJjzHEGSbGv84ju4zkUeeeFYz+eBgvg1TPI9Q2yRGu
	f1eCQ9ltfqOjqnVSrN0w9ajSes5oTLyf4yn+bDU28lcSpSVHMXvlgPPZLZyBFQSGNG6A/fdcNku
	tJFn8AE5q4cRjRlY36tRtzGhhZoNaPqRiM1j6ct4WZDTI7fg51NWvoYhDOsCrGeIV0LAHiQsinw
	/zj27rMOmYDUVgBcTecIrXfKbG/ng3Mt6U0U9iLPZ8Rj6WSmt4IOJogYUtTB7KeKeT2t2bHcp9k
	C9Lb9mdJXHOdDvg1kibBP60yB4VG4pOYe4Dgc4bkyAfagLYefX0c6RfxsWU1i8HVFlgFaUKKUZM
	51hZnbo06q12ga
X-Received: by 2002:a05:690c:93:b0:862:65f4:c8bb with SMTP id
 00721157ae682-86265f4cb64mr82578667b3.3.1788279712705; Tue, 01 Sep 2026
 09:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831223314.89787-2-sidchintamaneni@gmail.com>
 <882f92965fedba779d677b2b8600682bb0ea33673121e42b81a430d3a3636745@mail.kernel.org>
 <apbaAHkjpsgJMtk0@mail.gmail.com>
In-Reply-To: <apbaAHkjpsgJMtk0@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Tue, 1 Sep 2026 09:21:41 -0700
X-Gm-Features: AcwNN1W-j5oY5lWHGZveC9gS7mWumZDGskNnR48mSAc14KwVjsaXdl_ahowoq44
Message-ID: <CAE5sdEhNJirY68P4EzGNfhWDw67-zCz9SJN1z9Mb7g1Bu7YgfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test terminal gotox instructions
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, puranjay@kernel.org, rlmenge@gmail.com, 
	hargar@microsoft.com, apais@microsoft.com, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sept 2026 at 06:47, Anton Protopopov <a.s.protopopov@gmail.com> wrote:
>
> On 26/08/31 11:26PM, bot+bpf-ci@kernel.org wrote:
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> > > index 5b18c9a27717b..89067ab7baaa4 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> > > @@ -47,6 +47,67 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_src_reg,      BPF_REG_1, 0, 0, __fa
> > >  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_off, BPF_REG_0, 1, 0, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
> > >  DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __failure __msg("BPF_JA|BPF_X uses reserved fields"))
> > >
> > > +SEC("socket")
> > > +__success __retval(0)
> > > +__naked void jump_table_terminal_gotox(void)
> > > +{
> > > +   asm volatile ("                                         \
> > > +   .pushsection .jumptables,\"\",@progbits;                \
> > > +jt0_%=:                                                    \
> > > +   .quad ret0_%= - socket;                                 \
> > > +   .size jt0_%=, 8;                                        \
> > > +   .global jt0_%=;                                         \
> > > +   .popsection;                                            \
> > > +                                                           \
> > > +   r0 = jt0_%= ll;                                         \
> > > +   r0 = *(u64 *)(r0 + 0);                                  \
> > > +   goto end_%=;                                            \
> > > +ret0_%=:                                                   \
> > > +   r0 = 0;                                                 \
> > > +   exit;                                                   \
> > > +end_%=:                                                    \
> > > +   .8byte %[gotox_r0];                                     \
> > > +"  :
> > > +   : __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,
> > > +                                       BPF_REG_0, 0, 0, 0))
> > > +   : __clobber_all);
> > > +}
> > > +
> > > +static __naked __noinline __used
> > > +void terminal_gotox_subprog(void)
> > > +{
> > > +   asm volatile ("                                         \
> > > +   .pushsection .jumptables,\"\",@progbits;                \
> > > +jt0_%=:                                                    \
> > > +   .quad ret0_%= - .text;                                  \
> > > +   .size jt0_%=, 8;                                        \
> > > +   .global jt0_%=;                                         \
> > > +   .popsection;                                            \
> > > +                                                           \
> > > +   r0 = jt0_%= ll;                                         \
> > > +   r0 = *(u64 *)(r0 + 0);                                  \
> > > +   goto end_%=;                                            \
> > > +ret0_%=:                                                   \
> > > +   r0 = 0;                                                 \
> > > +   exit;                                                   \
> > > +end_%=:                                                    \
> > > +   .8byte %[gotox_r0];                                     \
> > > +"  :
> > > +   : __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X,
> > > +                                       BPF_REG_0, 0, 0, 0))
> > > +   : __clobber_all);
> > > +}
> >
> > This isn't a bug, but terminal_gotox_subprog() differs from
> > jump_table_terminal_gotox() above only in the jump-table base symbol
> > (- .text vs - socket). The file elsewhere factors similar shapes into
> > macros (DEFINE_SIMPLE_JUMP_TABLE_PROG, DEFINE_INVALID_SIZE_PROG,
> > DEFINE_JUMP_TABLE_USE_REG). Would a small macro parameterised on the
> > base read better here?
> >
> > Also, since libbpf appends the only called subprogram last, this
> > subprogram's gotox ends up as the final instruction of the whole loaded
> > program. Would adding a further subprogram after it give coverage of the
> > fall-through-into-the-next-subprog case that the relaxed check in
> > check_subprogs() guards?
>
> If you add a macro as robot suggested, then the
> jump_table_terminal_gotox_subprog() below can call two subprogs
> (same, with different names).
>
> Otherwise, looks good to me!
>

Yes, makesense. I will respin it!

<SNIP>
