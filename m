Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C99386435
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682242; cv=pass; b=MZTE2O+N6D90aVpGlKwXxoxPbNTPyob4gbXWoCzkIhc4ZIgQWVqhEAw4JA/CH2S0HZWqrb1Ml9k7XwpGmrxyCFVLVIO8Ed2a8uX3vzGo7Qb9ehD8UZJRJF6YqHm+7Gy2E8mMfa+3IIQrCq/y45Mmx1JYAHYOijyM+bealJPhygY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682242; c=relaxed/simple;
	bh=B/ePAnDi7gjX0wObDwCkcVlhRTzzZqaKwRsAtFuwlh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODBQCJDS57MNP/UcUi0FUkGBldIwg0DRE8phlAEyRUaSGQlzHilQgIOufhbGkcDeN9fflAlT2tRmpUbbmtfJdgd+gbaSCbCOBHTiVoKp0p70KmQ2VgHnzl0JWysHJGU0PHT6yL6P6zfBcAD2F2xIKpnLdnJTXYFr52jK9QPC+XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2bCJw07; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2bCJw07"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7dfceeaf168so22072277b3.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 10:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682236; cv=none;
        d=google.com; s=arc-20240605;
        b=W7UGuJDDTjuoBjga7Y0MrHMqC/QVhiasVBe8nNEYmN2/95v51k4vM2p066j9H5/X2h
         ZWo5nvC17Cz6kbDtjOPABAsGeWO6RelIrpKemQqNTqyIb6yhPnuZBz7uSZGcIF6S0ayo
         jbmQyvFbcVL/K3i28a+sKwc3x+CufeVUTJlBN9tFUExGv4fHev5KM7DMl8+84vnrUSOr
         5E8ctXjAFk0k3ib9KeIha2/UVGpRkO8vHw0TcDhMA7lbiQjGLwd0dt6iDUEZdChUrSPs
         TtDVkI9RKbDHijscdnpi7u1o2nTtJZ5k2++8Yx9IbILDW7mrvGsABtAJzKGR44y0B+72
         9tjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cmSM1b2FxFpkiErqZSBNSk3eQpOEWiURszgQnptqPlc=;
        fh=CZ4n1hqezEQESwTIcAe3ZnvP0JJM+gSHd402CgXnpgU=;
        b=IYVgDWSD4elQxAYfkjwuxTeac0uWeimEQWF2zbbvDvHLJieMam2/kcbqfcBIXkczkT
         4mAsQ9LMywYdpmKksZT5vahrOOJBkkmPDH2YG+mKEQL1Ax5mS6briThIcS6DyWg70fB0
         GuhgHVTpCTZIBAn+p2pDxkgMg+uc/5f1r56O0n6ka1PiS+WqOHCJUGDLmLN9zK3qtGqk
         UYj1uFaUzcKeLio4zCwo6Pimv/8LmAd6EDMND49FYTT74rnhujpTiFDEBG4EgGLsnFRA
         WdWsHWrUU5+HunxDd/9otNvUShOJRy1Q84EblFRm7a0OEmEip4itOxVoUTyxPlBLa19m
         KdzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780682236; x=1781287036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmSM1b2FxFpkiErqZSBNSk3eQpOEWiURszgQnptqPlc=;
        b=O2bCJw07DLfQWvmBGuR3QGWI1JZRQqwYA99ti0db9Z7XaHTLhsT6CWZbxHliSrwZpm
         P+OBVP15CWWtekRTymKVuWeexM7Wo3upElF122SII+PEDuiwmfN7JmsBFe4FTJgYYoEw
         zb0L/uSx1EQTIEJc8elgj9BYNy5pkcS04wJ+y/vwCZ9Ce4pSmZH2x2f2qndyxxpNQKzM
         seJMQEV2NNlXoaKVVSPA9XL21xl8Y9VzfdWuf9Gz3tYXO0csZSOarqxm45dWSIvDt1A5
         7DCWGZ1Fxx+bG13JtfFd9ommDt1xSFIFM14wXzWcxJqSTGP4PEoTT/Mb/a4dPZ7wljUT
         32vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682236; x=1781287036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cmSM1b2FxFpkiErqZSBNSk3eQpOEWiURszgQnptqPlc=;
        b=cAJTLcb1c7ehHC1RDEHrjXN1Yi7oZipevq6OE1mBnHwLtVw2Rem1Ux5ZcxROb2cGlw
         nkgpABKiUskjiV+E3KgJPpX8iLsEWcGPw2QfG2nc1CDQfNTFij7F4ub6fO3fgBA2Mgn9
         rKgA6BBhh1cqMHX9oyr3GMbH4y3BvxN8gPZPl9OKueASA2vGmYkA1go3qfuk/HmgxWrf
         YtJQmf8g09jZXyG0ITB018WNcBMqP8kUM5J5AHqnfMYDxZkJ+8M8sBa/FWqU8ZivKcde
         zw5zcBeEMVadA9z630RL3ijzoY9OAEcXEChJhKyVC5FvLHtaEc8nB8+nId3ym0xohMNU
         XbWg==
X-Forwarded-Encrypted: i=1; AFNElJ+YUcmY9MdHf2TAWpEY4831aRo1fnpVRd3b7F6jIyxMEPvQAikKEZ96ctHToN9H0GFg6cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBMQbkavVtKtIL8LycHCRmLZsH1VGqKLL4zhT8nHidKqx7CP/w
	34yGuLdj13rZ5XKQtwoGLzaJanz9+uwxhIft571UEf4j9rzhbWKz0ef1Vpkgk1RgLpVpuIHilZU
	dWbeAQJ0UK7lUMcCsEyxHvkmlaRT165s=
X-Gm-Gg: Acq92OE4FlLLeGBSN9QJRZDlnuoOJcczLFqOa6yiz+AENbjEOeQwC+nkdGTk2rpKgaL
	lWuHrVaaIaqR6frOh1tZl6evAfJ2RaWf5wthLO6DkSqNkhod9xk9VO8q1ypbwumnSHdTKYa6lNf
	A0W92j/uJCzZcQci5UZ5x7fuFPQwKxEeWG2+JSKFtOaXHGCjjsOHa+N3kFU+fYwBqrubR+JsGcK
	d9ajcm+YKtz/89xniOa2PvKnnQeWlnYVAnJI9SCXLbBcpSJD9LeSdODKKSWwfWypihcqGmHlXVz
	0Qs0nyZ4w3JG0ZhG5bhW44sIrvoJzEE88A==
X-Received: by 2002:a05:690c:6a11:b0:7d1:c256:b5c2 with SMTP id
 00721157ae682-7ed11288b78mr49193467b3.33.1780682236167; Fri, 05 Jun 2026
 10:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604220904.1032145-3-ameryhung@gmail.com> <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
 <b4302a13ccae77b304a09b47c58565c8ff1970c2.camel@gmail.com> <CAMB2axPLpxk8fh-Qp2sGwtsZBCE42DLo+h8pB+ObffLifP9aZg@mail.gmail.com>
In-Reply-To: <CAMB2axPLpxk8fh-Qp2sGwtsZBCE42DLo+h8pB+ObffLifP9aZg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 10:57:05 -0700
X-Gm-Features: AVHnY4Iiyh1DufQo6AdcLUGItcW4SgUvYf0y6EkKBe7FclLb_9ezORLnhygaKT8
Message-ID: <CAMB2axOOG3ptDkWvTDpGut+EmDeroe3GPR3obb-Br_Dg1aGmgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 4:27=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Thu, Jun 4, 2026 at 4:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Thu, 2026-06-04 at 22:59 +0000, bot+bpf-ci@kernel.org wrote:
> > > > commit 89f2be9817e074d02702d22068104fb9fd9aa103
> > > > Author: Amery Hung <ameryhung@gmail.com>
> > > > Date:   Thu Jun 4 15:09:03 2026 -0700
> > > >
> > > >     bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
> > > >
> > > >     refsafe() compared each reference's id and type but not its par=
ent_id,
> > > >     so two states whose PTR references differ only in the parent ob=
ject they
> > > >     were derived from could be wrongly treated as equivalent and pr=
uned. Fix
> > > >     it by checking parent_id too.
> > > >
> > > >     Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > >
> > > This looks like a bug fix for parent_id tracking support. Should this
> > > include:
> > >
> > >   Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking an=
d fix dynptr UAF bug")
> > >
> > > When commit 308c7a0ae885 added parent_id tracking, it updated several
> > > safety-checking functions to compare parent_id but missed adding the
> > > parent_id check in refsafe() for the REF_TYPE_PTR case. This caused s=
tates
> > > with different parent objects to be incorrectly treated as equivalent
> > > during state pruning.
> > >
> > > > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > > > index 5945956a7573..06d9ae24f006 100644
> > > > --- a/kernel/bpf/states.c
> > > > +++ b/kernel/bpf/states.c
> > > > @@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *=
old, struct bpf_verifier_state *c
> > > >                     return false;
> > > >             switch (old->refs[i].type) {
> > > >             case REF_TYPE_PTR:
> > > > +                   if (!check_ids(old->refs[i].parent_id, cur->ref=
s[i].parent_id, idmap))
> > > > +                           return false;
> > > > +                   break;
> > > >             case REF_TYPE_IRQ:
> > > >                     break;
> > > >             case REF_TYPE_LOCK:
> > >
> > > This adds an extra check_ids() call for parent_id. Could this make it
> > > easier to trigger the WARN_ON_ONCE() in check_ids() via BPF_ID_MAP_SI=
ZE
> > > exhaustion?
> >
> > I think the bot has the point here. Let's switch to reallocating idmap
> > or failing check_ids() if there are to many ids (probably an
> > unrealistic scenario).
>
> Make sense. I will switch to failing check_ids() first since it is
> unlikely for sane programs.
>

Actually, looking at it a bit more. I think I would hold on changing
check_ids().

This patch should not increase idmap usage. parent_id refers to id and
therefore check_ids(parent_id) will reuse an existing slot.

The id_map is indeed more likely to be triggered since there is also
an intermediate reference for reference dynptr introduce during the
refactor, but that should still be very unlikely under normal usage.
check_ids() also already fails in this scenario by returning false. So
overall, I am not sure if we need to change it.

WDYT?
