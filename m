Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13489370AFB
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663051; cv=pass; b=unS7G6gUEeoNLhr0GmkNHg8/ffFLCSakq6YmDxpo7F4CawhwYs2sP3zBGot1hn1Dl+mhwZXUYmu0prAy/JW3m4dkQgw4bn37ak9VNtBwSabAvffH41rENK7K3vabJFRpglSr1BG7gh2HshfiMavHqUnZXqFxHybw67Wth2Ijhqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663051; c=relaxed/simple;
	bh=kIubguAQSDgw2AnUTnOlALbwEwbyMs5+HMA//ZuZ9iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJ2cOAFYenQaAd0xbxE0lBmZHE1/X2rD4Jjx8XX/hIfzjzMCeF82xiGWbGj/Box/f5eUBEjH+CCm9THETLBmA0+bREi/VbTyxkGmkDD6kO8nAO9q6jT2TvcVNqzi2EszIEGIgNLcIrwTA7qgkmZWTElWOjfzoO4wVULb8a3O/hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmV+hb8K; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmV+hb8K"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c12614b81c9so2112273066b.3
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 12:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784663047; cv=none;
        d=google.com; s=arc-20260327;
        b=QYg2fJv91IjqIZpH4xoAPAmnjo8Hynt+Bl35IoBOgl/hPRxfNJfab/e/l6vWsqDDa/
         HkozrsURAbbSpl67yiH6cNcFmXOlFZhcqEzPgVlXWgh8iNJENlKINHQdENSHom3iFhFf
         kYVq96rhanTZdC4Q3Tp9s5xwhipylgi82rIzUTKwvOex0X9aLLOPxFKmEPPYYBNS8am/
         hpxETqh3iFbHJOMNz7dpUQ/lPoWVmS598puMGwEi12BfhDZ07yoXd18QLihlcAtWDRLk
         xOzYE2Q7DqcTmHkXcz4Qx+Qr6l61Pz+SoUUpelv/ZRrJRBjGYhs39Gx6LjhOd8V/65vf
         AGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IkY7/xBgEHYioSp3TmlKCifGguVh3qDEL8r4no2V/24=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=Tu8wnc+/NFuZmgi5qaPYCyDuggHxNF10t98e7l05scKcKUzjW3T3T/1htgJujd8v/c
         QinmwNZfLS3Er0xUe/aGziO/p5muiMW6GJL32fku4LhmyiEGWq2BL1bMyQg0W1Fx0w02
         mHP5Rifv4YluK+zIeNFZfAj/R0J/MPGKdNDpYFQv9q8F/+JsnLJJrNY2fpQy2d4CMJs+
         sEDQzLTdc9639BzJYCblwS/R9u/xjCZ4KX5g7fEbt8dnuDop5hSYJa4SHRgjfX0CqJNl
         T/WRHcysl6liSl2W27DdCusaE+PB5tE7NVilOqZiSsF4PVFqQOCP48Ce69DDpijOl1kT
         M4Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784663047; x=1785267847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IkY7/xBgEHYioSp3TmlKCifGguVh3qDEL8r4no2V/24=;
        b=hmV+hb8KIuG6ilO0xmLXu1uq4UTJWnbiEvpaWDxm16WVX5sIpqs1E1ADsG2efgx/SE
         abH1wB+06vi5PR6YH+6hzE3S9MfibD0CRyyKuUVJi7Wmqh+SnUBgFRMB5RicX2pCRwJx
         rI+SaX+pcc7hj+nkAg4IjNg7XsP3cCGsf9wuRrV+xTW2l+ARv3m9RP7BtdQltvHDTblB
         K53hgqpGSkIIv/3xNlCyPCJ9y5FTjATfyuhAVz71phhC0AtbpIBWwpC57PmMbI6oAp33
         g84vqnBXJRzkfaLy6nWbh71XKNK9PeLyKExpcd37kgeNlKG15o2CVOsJ2J+Q6zvwXAer
         e//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784663047; x=1785267847;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IkY7/xBgEHYioSp3TmlKCifGguVh3qDEL8r4no2V/24=;
        b=NIj8nyMsx89XM54BPGK/Vy157pbe9ruNAhA85wnck3zKlPaL1RocHhI6nPaladbgVX
         kQ3atcmETf3nOGOJJ1kG7SssWotL4bN7s4ESnmeREZK9g7mMYyeertPd8ML1AQE0s1WD
         /tZp52QQn2YeMR1ni+J1YUEKPfqf7LhzBfzRHhbCCN77kZYL+CRp10VzQIRGzZ6knCKu
         OzXYJcm2VPMVxd3JQuoEaeonWH4tv6onxfOyWrzVazmhJu8tnoy08j+uT3qvKz13W6Je
         cOu55VgLRH+bHxPxZBXrxdCTMmp1eBTgkSnaB0F5YvSWFzz9Ceu+NLgO63JtIINjeEjU
         zj8A==
X-Gm-Message-State: AOJu0YwcgZR3F58V9aNZzGbD4OEIPanBI0j3Ck4lMimDM88qnI6T/Eav
	vXRXjtbQIUFH6U9SzwhG7WrlOlLcC6DX/XnSrq51gcgxMgwQMkvJt+qg21zI+6AR4cVsoZyw2YP
	s7E0uqPfuSthnEEcbxKwNRRlaPD3oLxGPj7LkD50=
X-Gm-Gg: AR+sD11qM+YaqX/GO22tQmPwr0z8QbmnXi+YfBAS4a5i0XrfOS5nncxvzUWs1eoqzBG
	gsrj+f3aAMknLKae7jLXOy4cNMEjhCzrUTmaSfwcgljDgrqj4tbhqannoUMPxQwzeQPW+1bprwI
	PI3O51lw3EF6myLIxRDVYMSF+hWwybEN8HgdoygGHjcVMO5gmconSadZKyr3LBTQpJrm+LS5B7v
	mN4NM5AtozMmS3o/lgcINq2vl1H+mDmJKtd+CI6LdCeEvZ1TxU4fGQZVFISqJxrWWJN3BzHBxuo
	XyT60r5uY4SQHp/0vA==
X-Received: by 2002:a17:907:9803:b0:c16:6a91:38ca with SMTP id
 a640c23a62f3a-c16b483e17cmr958014866b.50.1784663047135; Tue, 21 Jul 2026
 12:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721174909.8044-1-nickolay.lysenko@gmail.com>
 <20260721174909.8044-2-nickolay.lysenko@gmail.com> <20260721175745.228B91F000E9@smtp.kernel.org>
In-Reply-To: <20260721175745.228B91F000E9@smtp.kernel.org>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Tue, 21 Jul 2026 12:43:55 -0700
X-Gm-Features: AUfX_mx158iEIjFEJNV1RK8eG6qPWR-SWVxiEe-hb_LIPy2AM2g6J5BFVriJT9M
Message-ID: <CAMtxOX1wD5G8va8yDdevbd759=zGByVO4oNSeb8nyQcEF4wimw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/3] selftests/bpf: extract BPF skeleton
 generation into a helper script
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 10:57=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The newly extracted `gen_bpf_skel.sh` script is not listed as a p=
rerequisite for the skeleton header targets.
> --

addressed in v2:
https://lore.kernel.org/bpf/20260721194111.334795-1-nickolay.lysenko@gmail.=
com/T/#u

>
> --- Patch [1]: [RFC PATCH bpf-next 1/3] selftests/bpf: extract BPF skelet=
on generation into a helper script ---
> commit 4513e1c5bea1eb3326128c6ae08f7e1f230247fb
> Author: Mykola Lysenko <nickolay.lysenko@gmail.com>
>
> selftests/bpf: extract BPF skeleton generation into a helper script
>
> This commit extracts the duplicate skeleton generation pipeline from the
> Makefile into a standalone shell script. This simplifies the rules by
> replacing them with calls to gen_bpf_skel.sh using different flags.
>
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index b642ee489ea64..e3a27403cd481 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> [ ... ]
> > @@ -631,81 +631,38 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:  =
                       \
> >                                         $$($$<-$2-CFLAGS),$(TRUNNER_BIN=
ARY))
> >
> >  $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
> [ ... ]
> > +     $(Q)BPFTOOL=3D$$(BPFTOOL) ./gen_bpf_skel.sh --tag '$(TRUNNER_BINA=
RY)'     \
>
> [Severity: Low]
> Should gen_bpf_skel.sh be added as a prerequisite for $(TRUNNER_BPF_SKELS=
)
> and the other skeleton targets?
>
> Without the script in the dependencies list, modifying the script itself
> won't trigger a rebuild of the existing .skel.h and .lskel.h files.
> This could lead to stale builds during development if the script's logic
> is updated.
>
> > +             --name $$(notdir $$(<:.bpf.o=3D)) --infix linked         =
         \
> > +             --skel $$@ --subskel $$(@:.skel.h=3D.subskel.h) $$< $(if =
$(PERMISSIVE),|| { \
> > +             $$(RM) $$@ $$(@:.skel.h=3D.subskel.h);                   =
         \
> > +             printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; =
})
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721174909.80=
44-1-nickolay.lysenko@gmail.com?part=3D1
