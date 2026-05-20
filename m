Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962023C1410
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316918; cv=pass; b=eud2k6/wj23J38MwdUR0M1TnGSwDeqKzPTwDEKqLgxTRYtUucGrhhS3inYds/MrP7HUDLyEpt5L/1HhGds2U2jK1Z0GFTSiDIl2aOpxbv0QPC/2AxYBQFCgiM8/yjgfbkRUO0gHmTkZSVMzMepDM43qlPLPuITfVCcLf0zqTmRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316918; c=relaxed/simple;
	bh=2SO7wAPy092XNI0gt9cmMbx4EgFNUew5054NqGV0czE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hbsr2VPUYXaqDGXqEaxuLegoegfvm1kGm+seWuEandTFkfPkvVwGmL/IVQnbdbwQprMHekxL3tKc+4eGqBso0QWUPjFdsKWj0QU76j3kDzlujYCGN1FJiLvZiRCU6lZavNSe8AQsTUL3KK+u9RcACYed8M0D2IgeTC7zYVdU7Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJq0K/Nr; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJq0K/Nr"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65890a6ca20so6170143d50.0
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 15:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779316912; cv=none;
        d=google.com; s=arc-20240605;
        b=M+wOVDbZ2kZb8WiKxLI6dbE8MIoMfXI4M/y947Slmb5qlDcwFZc5Kvf0IielamRpyP
         LHKibjZD3bcIy29NJmckqCmRS9uJJYUUy6Imt9f1w6VxfqgcqqyJohuFcn0Brp5RRIx5
         RU5zpoVNuSwHU8yEG7f9q5wdEKhEyKrNlSmJYqvVGwJUATa0Q/ts3I3vBym94CLTZw2M
         h2BxX4KQjhaEZWssVJXF0mvxDs2c42BDTZuGIFpzsqUaQOzGFrOqVcxbPdeRgRd0TVXK
         dYo0B1RerEy5Y6HPZBYKAb1H01O3EcCffc2ZylFJDBFkXQwT93fsuWr3XaIY7GQy+5nl
         z4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gnoVo4muIvLjwvzERo11njZlpoHh4lmweBpjS9I57wo=;
        fh=bCoLUvtAu1D3hCyKghQ3VLRStVvdR9Sgh3Xhk/87lZg=;
        b=g9YpfYD0g+sGWpj/m+1cMRxhR5ZKrBDAWUrJ7ICLktPQod4F3SHTyFQPiJuaSJxj7a
         FRVM/8UtOIUguCitg1iXkam5AP+zfdAb938T48XeXW011X6HhUxQiXzQCIXxERDgYy9K
         OrCmDcjvcztBZSBT1sMBvhWnX5MFxqdHLUkwcvVzFv0iu1WXzYaV3YTrbB349AkuP0e2
         x/Q66prNQw8kd4CdDtrsURHpgatenZqKoZV3DpxN8FXfz1xLuutvpKSelb5/XhLzskR6
         hQn+mfHwkRVJg5nB48f2VMgfrywqAhDukcwn8ZbDKvwvy13AMDi+p97QHSBV6iGSJZFH
         AiWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779316912; x=1779921712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnoVo4muIvLjwvzERo11njZlpoHh4lmweBpjS9I57wo=;
        b=NJq0K/Nr5B/fm0Baxmq1nv8qfAmaSUrHOFx9t+6k8MI4Gyz1XXaKIqln1xJ4XN8bvQ
         S3gh1uc3hMHG2tkMvFUbyMzZemm2h3xPpS1WjZGgtysJwCOUTP6F9vhD71hpkvxxEFY/
         CxM2L7bpDAzaZBqs1Iw3OfwbAzhnTkMAA3eYTTwGiAH0GU48OxD6AWk5W3EsMqJdtYlS
         7LIO7xcsVVaRWs950CZBOj038ZqQsz9ptkKRiNy812fN0coM9andKqj0vtEsh4VAEdDF
         EU7xi8Fh4kAgw7qMCAik5Tz93zujRbak5jutvI13fDBHh5Xbt8vqnU6sxxo76bCxCPQv
         UBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779316912; x=1779921712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gnoVo4muIvLjwvzERo11njZlpoHh4lmweBpjS9I57wo=;
        b=mVLdgxMHF2nzryGp9X8fQCx24IuVxRhZDyCipl9v8VoiriLvUEhb9CFJZCOnQInycs
         lX3zJUuUeHtchScZFRgcTd1mMMgqJ/XjJkQS5jtlyKONu69D0wBRaeCVzmzrhtL5Ytgc
         1JChHvaG2Eldg6ClJ+lWkkrp65qJ4w1jQAM9XyM26rQ4skuhdTG3dWOSjowP8bBX9Pcw
         4XGZQmyh1gtrOUsEsP2DL3jIn34pVSw4NUm2tQaMy1s9Tx1dOVTq9Qb9MzvQylJwdkHU
         62/ntfeHnorIXdx2uxaDuJoNqGJcLlaDLSd0Lp7PkkDwU1o+WPRVmPhGwWID4+/mJRix
         DudA==
X-Gm-Message-State: AOJu0YwPsT9InLdr6+1SZJrQ3XLoIbuM866BBKCaux5F+o7ZAQG7gIHL
	3AtLPm4vynLImcYwSEjhzixV2qAxvPE4kkdxItQ2o1MK/7zBC4ex+ouRePpxRdZwBDnpfJDqVk8
	D3u2BAVxOnkiPtfNlHYpN34OYliGT89Q=
X-Gm-Gg: Acq92OGqgbFaZGQwVXC1Dy75PW9Co6LWuRQTGD+xFzU+uPWvfpa8Mq0ocKmUj+Cts1h
	RObyJYy76aZAb6UPTBgA/CnNpBZWtnzGHqQlPgTi7KFUpGSSadMEeoX7H34ipNJ0qUr7IXKc+xh
	xVuUbI7Tp+z6lvB4ihViA2G44E68BLf7FSd1afxtGZzokynezyFcWhMVqDmjGxG+SbuLHjKfs/n
	5YfC1CKvOZ62qp5grx3Dlv+4HOzpY42QlHjoiQ5LQLDfHMnUNW5PpSFUN9f6C8nmMkxqlTsKETM
	VhYZ9xnk0S4/CwHxRdbutZ4=
X-Received: by 2002:a05:690e:1484:b0:65c:2a49:883c with SMTP id
 956f58d0204a3-65eae00c30fmr194013d50.29.1779316912142; Wed, 20 May 2026
 15:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519181314.2731658-1-ameryhung@gmail.com> <20260519181314.2731658-11-ameryhung@gmail.com>
 <fa15610bc8ffbd41d418bfe61b2e647d8fb51489.camel@gmail.com>
In-Reply-To: <fa15610bc8ffbd41d418bfe61b2e647d8fb51489.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 20 May 2026 15:41:40 -0700
X-Gm-Features: AVHnY4I75Se3WowJHwp0YgSuxktnuxZ288xbTSztc2A3NMZYBs80UVlG60empWw
Message-ID: <CAMB2axMn5UbHWD6He-dzcPJXogMAPb-80gvZp45g12VjwXFSHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 10/14] bpf: Fix dynptr ref counting to scan
 all call frames
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 12:59=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2026-05-19 at 11:13 -0700, Amery Hung wrote:
> > When checking whether a referenced dynptr can be overwritten,
> > destroy_if_dynptr_stack_slot only counted sibling dynptrs in the
> > current call frame. If a clone sharing the same virtual ref parent
> > existed in a different frame (e.g., passed to a subprog), it would
> > not be counted, causing the verifier to incorrectly reject the
> > overwrite with "cannot overwrite referenced dynptr".
> >
> > Fix by extracting the counting into dynptr_ref_cnt() which uses
> > bpf_for_each_reg_in_vstate_mask() to scan dynptr stack slots across
> > all call frames.
> >
> > Fixes: 017f5c4ef73c ("bpf: Allow overwriting referenced dynptr when ref=
cnt > 1")
> > Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c b/t=
ools/testing/selftests/bpf/progs/wakeup_source_fail.c
> > index b8bbb61d4d4e..d4d0f1610853 100644
> > --- a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
> > @@ -42,7 +42,7 @@ int wakeup_source_access_lock_fields(void *ctx)
> >  }
> >
> >  SEC("syscall")
> > -__failure __msg("type=3Dscalar expected=3Dfp")
> > +__failure __msg("release kfunc bpf_wakeup_sources_read_unlock expects =
referenced PTR_TO_BTF_ID passed to R1")
>
> Nit: this change seem unrelated.

Indeed. I fixed up this piece to the wrong patch. Should be patch 8.


>
> >  int wakeup_source_unlock_no_lock(void *ctx)
> >  {
> >       struct bpf_ws_lock *lock =3D (void *)0x1;
