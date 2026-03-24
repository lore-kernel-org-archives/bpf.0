Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83ED2F6562
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390785; cv=pass; b=pt9WElaBxi7gQtQxbeN2WBjj9snPVb4sTQ6jcraJtc1mHHwpzJAcMHphZ4evm7Ooc85KNoGz13ELRBpIrQnsiUrancGRp6VB1bDLzOX6bbKIsDHdSeY49+JD7C3zKWFqOkmVVnlo0yumbVb6nmsCKmcInN8d9zgI2S1LOZMpdRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390785; c=relaxed/simple;
	bh=veM1ymWPhtEmSbY4Zjq6QntM1sHrlQ9lfC6Zm7lu5MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsJBVmVT6T0wkbZ3lqEWd2F3W7GRje+UxbKpWkNCs6QHOezmIFyFQM+uAXfdhPPDpUsNZLaB/zs9GkcWrJlaQ3+AWVd8dcs6x5FCJVWrG3Gw9ywhxAXUE9NbPArngaR4CYKiUwkZITuEcE0FfzzLOptbr7ugAZIu1gVSJjvMVZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qF2sqH14; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF2sqH14"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso16746605e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:19:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774390782; cv=none;
        d=google.com; s=arc-20240605;
        b=Yg6zIGdGhuJT6g2/u3BZGCBzLGE2cqT/cZKrLnytwmmFcXmaS+8HurNnFOTUaoMk2Z
         miHbB7UyqneIr3VVBYjwLTonrXcNr9NXP3eTDX+E/aw0TX9b8rKBTWn4zH3cKi8mq2HF
         qTN6Shmg+xhS8NI6DVeQAZWC6dxwNm4lt6kSdDGDQaJx7/d31glvxTzdJe9P8wdrZe+T
         gXoFW+92wh5qqmBYDHQdI0F4IUWXZxsXoq5JSktCPPvbxp4S4vFupkvI/d9EOjsKQDpN
         D5D61vDsBBpIcoTMqoVXvag7vYocFnTOdiBcjyB9b9S3YEM/wsWG/EDSjNh7P16txhbU
         +/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FVzq/RhPitJuMi2K/farNGJtrfkEGCcGosNZKlqlrAk=;
        fh=3xyFF8M+0ySOZk8/10nH9si664iM5BxT+sz2aTXMBIs=;
        b=PZQybgZZjCtb3YOW9TVvxibQCj2Ph1JqDUNZ6otDoXSzoSPPqqRpHZnvuJF+BueZW/
         m6Qxjj2R12xCw/0YII1oyDUhMeGk30/6fIh8m25ZVrgL5yEn8x7iMPZtCohpRf5FXcCt
         J4rxYC/k8ZUn0dlFOhaSKquJWcCbsKryIBLdhxa9nRHRbazxXImYAyuyAAEmjnR9jNsi
         WsBAbA6JIFM1n48IuHbEKlqwGZuAWssBjLmISbJ23JzICSvJpPEiWgozM0Kd33BqGy4L
         wXmr6Lg/T+5JLSZaqY9dIhHRp9qOFsdTYIf8A0T/Myo4vmJ4cyhNK4MTC98zwabdcIYm
         kaUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774390782; x=1774995582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVzq/RhPitJuMi2K/farNGJtrfkEGCcGosNZKlqlrAk=;
        b=qF2sqH14nTNw3oPRkTAuBt6N21vN0iBvwBp8c9kYlov+6hqo4/j1hBkUK26qTblHVy
         6wx310074zNzgcuH0L4gnuqPpEV0bq4KH8Zb/5YHvSpkwbHzD1sWh6NDfKIAW2BoUvSO
         REtnL2d+HzvZpo43KiqkoBAhO1HMDqRRe05kWMamDrda3p84EMym7KLJ8ZU7B3IZLGWs
         metBITaIKWYFGurEN+8pm2fF3cziwYDKMwhb+QbpHjWH5n6dF4I4+pjS5RQy7l9+LFyW
         UdrmtPJhDKJ8i68HDHqsOaggw1mXrLPEXmOKpJ7T35XSFHYaIA/AmKS/ZdYuWvLaWO1V
         jPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774390782; x=1774995582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVzq/RhPitJuMi2K/farNGJtrfkEGCcGosNZKlqlrAk=;
        b=CfKOrcVcBOIravANwuzaGAkRcKAddx0Vf11zAQH5uEMfZ6VV399+O8nEBbnCsvY7Hh
         pvuKP9z4N7d22QKM6j+VXhG5lBbmNvvizo8Z5KQQ+bvx4/g+GhrBHz5np/+X4bbX3aqo
         G4xBP3LVgNNw2cmv6OIWEMOEPNTZRrPyNTBdC/Tey39+WYNIhTIpZKGsWzX+PkBkcbIX
         vcde+dizOypX3AWwcS5CLXDeXR9K096hyjdLVuTdFWQNkV3py0OJrJ9R2CjIZl3ug7qd
         9VG4E/t4n11nmYL1klCV6yqZWNDrhJE3shtO/bEqV3pSk2loB3TZUXyaSGfag8Kr+GQt
         Vb2A==
X-Gm-Message-State: AOJu0Yxwr/EfNblHT6N7XutoQ7WF9cQkXPyuoeZNg2eHvJcdLifq6S63
	rdjRV6U9Jahyc5ClpBDWalbuG6UJD0dYUzcz0UyknnjvTzj3Nm0K6ugA5++n5LW8hZNXDEM0z9f
	NJBG2bK10oDxRU22Vf1fQm6fxUFtbrOU=
X-Gm-Gg: ATEYQzwfLY3KheyPCHS1lqUpH+ed/tZxDxIP8jREEuHxPvNSq4RA99vWbz3pOTqN09M
	+h1uuXQcRCZmorkGltvjZSm+5DreEfylISFx9NiWImvogGygs7jBSix6UK6UpgTXmuISq0AI59V
	EPNCgSurDA3DjWUUf1SO4wT768WqxlcdK3qUyEEFpMBKLyobERjCl1RuzUd2PpFBkzQPGGd5kyq
	nMIAuGT/G7bFZ43YdHyqL6/a9tJ1VtsmrFSp3Rxn74xezmo82SpjqD3zxGqZmGcvWguIC+riULs
	8GtHoowOqit68T60Ew/4RoO/i6S2+8VfTLsoFy0PRdpFD2Zh/pc78RRl9pLjZRPVsVWU8dykNX5
	TfDsv2xSfXqSNGuW1V0IakcV2xA==
X-Received: by 2002:a05:600c:19ca:b0:480:3ad0:93c0 with SMTP id
 5b1f17b1804b1-4871607682emr21122235e9.23.1774390781946; Tue, 24 Mar 2026
 15:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324215938.81733-1-alexei.starovoitov@gmail.com> <CAP01T77acGZnCQTW08aG8ZgUNhswTJQsTgiHQ3-ZQ1TDXQ+wrg@mail.gmail.com>
In-Reply-To: <CAP01T77acGZnCQTW08aG8ZgUNhswTJQsTgiHQ3-ZQ1TDXQ+wrg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 15:19:30 -0700
X-Gm-Features: AQROBzD6QB0K1Dqwa5GyPLdLlYuM_mJuBBVWtbkVO7IS9yV1xdd1_Gyi3aG2QH0
Message-ID: <CAADnVQLpkKzHbFsTzthwr6RJgut5PSqhXMju7MyRrhjVC6B=rg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix variable length stack write over
 spilled pointers
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 3:12=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 24 Mar 2026 at 22:59, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Scrub slots if variable-offset stack write goes over spilled pointers.
> > Otherwise is_spilled_reg() may =3D=3D true && spilled_ptr.type =3D=3D N=
OT_INIT
> > and valid program is rejected by check_stack_read_fixed_off()
> > with obscure "invalid size of register fill" message.
> >
> > Fixes: 01f810ace9ed ("bpf: Allow variable-offset stack access")
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> > v1->v2: factored out into helper
> > ---
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> >  kernel/bpf/verifier.c | 28 ++++++++++++++++++++--------
> >  1 file changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 70a100dd4d0c..11207e63c94e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5251,6 +5251,18 @@ static void check_fastcall_stack_contract(struct=
 bpf_verifier_env *env,
> >         }
> >  }
> >
> > +static void scrub_special_slot(struct bpf_func_state *state, int spi)
> > +{
> > +       int i;
> > +
> > +       /* regular write of data into stack destroys any spilled ptr */
> > +       state->stack[spi].spilled_ptr.type =3D NOT_INIT;
>
> nit: strictly speaking we don't need to keep this, right? It's only
> checked when slot is STACK_SPILL.

You mean to keep whatever leftover spilled_ptr state in there?
I don't think it's a good idea.
If we didn't have " =3D NOT_INIT" and had this bug with leftover STACK_SPIL=
L
then check_stack_read_fixed_off() would have copied junk from spilled_ptr.
