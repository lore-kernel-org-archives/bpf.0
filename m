Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693953AEF35
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791398; cv=pass; b=iMY6nOplo8PbbKhFpjvjKb5YNEXFAuxPDEwu56qWMVvKbqUilwlMknDcwwEoyQuW6owzxqqEzMNPDHAaheQjbFQRwf5SsvhRL/kWy0ff2xtwAnZV45aZODeCpWrjt6XfrjLWXlj5QCS+7b27wcigR3c8HRIK0C9Rdp53PvoYlNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791398; c=relaxed/simple;
	bh=GnyiwNnusHkZANyFs0hYxcokbVAXMt7R3A4orSUAYCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vucjo2OfFJ6Makz3AKhRDFud0yBwUBzWTt6XPHsarlFklO5ojUc760Sy34yJmCY2KBoBJJc/ibNNAkBXf3pxYZPK0pP4eKbw3SXl63HRfnsOr8kpnxfp4DtUj1pd5eptGaMHL0ibf6b7yGIBnkQqW18k9ZOSLQkKiO1XMgTIpto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfdZCrVD; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfdZCrVD"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1c52d920b8so442126766b.2
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 07:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788791394; cv=none;
        d=google.com; s=arc-20260327;
        b=fcWoM1+SN3TEELlfl6d4K+938KfxClbX2nZox7EB7qVI0Nz4fodKj5QMaRvOik5vdl
         r5hsLG/CF26ufb43qv+tgRV23CxCDyke8EcyXcQWKPN4UmxRBQNq20cw6QcEzepGXsrW
         6iCo/VT9NCrP5jvKQIOOL0/bIf2ZXobtJkZkYkms8Z2r1qgMfEJQ7lSqnm54pMu1j2+j
         AU5rTdUvR27W73nj9rGiEn48ph3sMiGd1C/o9ff4bKoPXQjFqO1WGTF5DTjnlAgr8rcr
         WThIdzgMFUKnW4yiUhOsCFHUxZpFgK5uPQG9JYZFotk6VY9ZcUk2UzMesAfZ3TLk4mnK
         W5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8qZMkf0jfpR8nCae8dl7Goo8CyHWdi8M7u3xND3CPYw=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=mS4dgvk3AY6JlIGxj8gLd6xuKxSh+vu8CWwjEQ535cUoabpQ1dpBTQ+/GZK4/b0S4U
         Akk1JAJGwDySO6gfoBmn+Ggy89X4cqBbxxU7w9Tjuw88NsQHwmoclnuSwb0CZ6FQx5Pm
         I15v0Q+iNyeHal0UipkyGy3/ju3FwbZ81T/DZkW089d9prESV6JbpNA4gBk6ohJxZcGq
         FTSPdv4OyIvfDV1+8Dk4ZOtKRvoOYfGH3/qA3Jvp3hNjzVYqWnb7132TPxtZsY3vq+DG
         vwGWnQfhEsyoME5AtJ1KeGbaxZsqToB7elvSZ82yrYWd3kB7oJXL86OnXXW6XLTRNJdH
         h+7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788791394; x=1789396194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8qZMkf0jfpR8nCae8dl7Goo8CyHWdi8M7u3xND3CPYw=;
        b=BfdZCrVDi6S2qux1sW8+a75uE8NwJ8wGbPhNxa5eY9TsAohxYBM7f3tAhHeYI7jmuZ
         GXVq5hzaBYb9tfo0j1ed4iFpbkdBVXajpUeQlwK6GIGzDRmSAQOvaZ4vFOn/sa2hzD/Y
         kki1aMnYOpugYPxBlwVWxt1tkvWm8Egsbl6zxi9dSVOiOMaOEv8CRgzadxiQXYSzPVYB
         9tfMLoL8Ii2pUqybE1sTapDYrmpdzwEICjjM9NAr+uk3rngRD7FAOuIbqsFc/GEjM323
         C3WLoY+MDk20QZdw8AOcCYuQKsARXIbKzST0pVtUvZUn2rDcohXmLA9qfw8loRATPfeh
         fbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788791394; x=1789396194;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8qZMkf0jfpR8nCae8dl7Goo8CyHWdi8M7u3xND3CPYw=;
        b=Uf2QjHJanWzN0r1uzaAVCe5I4LD2bZfboFoVyjMiVFcUX4sFwYi5F9+SSbrEe+rxzn
         c0OHrx1FXvqEbmFw/t3R88nYnvWjCHRCsa/qU4Jz08awxJa4+2amLw89S4xPEjjbiG0G
         O3mrR9kATcZdUQRuLzyO6m7Oe0j1hWEFUbIYuDDEvvf+z2phVd/o0ZuKuDO1DMZT867l
         H/0OfjSM+Zf9jh2GGXFqh0kiGj2leIecemuHv+WRc7ASAsmX2IbsT5W021cshJ75g3aO
         woPvsKGQWMpNQ0anHu8vPHH3dy15yjhh3VqER9hrhh2IlgAQ+FWLRJCHY10UT+o9yU6M
         7CZg==
X-Gm-Message-State: AFuF++kvsrtQJ9DQ1kQvtu+jJjsEpr5JJ5z2CJ+v5mPt/So9hwi2BvcC
	oWcKVoJUDTSVgDKuerjKgJNRIQPD5p9eyYucW4tX3HAZ3kg4wJcpqsZuzCL+pMdEgURVkhzeEPN
	t7WSz4sSJoLhV3G5j5A6H68TgDTl/IHM=
X-Gm-Gg: AYBFou3z/Gq4QQ0Avkh6yQBfp+ksT3nYkGnPAIJx867vDRrbELGsW4/LPjniF/jJpis
	QJtuat320KFnyVojZZXlL8Byh0J/69ACjuI9BgbWoTxp195x3ofx9b5CVHyaNmxIwhC+3/Tbf8Q
	Mfcjo1w5v2fUDqwYARY2tjVUPTgfx+AngSomcBCm4Z8fD6tuqqYpej3pbqtItXb+vqJ3gUPQigv
	jCGSjBZzR4K8Lt0WjphDkRv2sPn3DiwY2OhLQOz7O8WEdQ+cCbCAjA//TfodxZ4eDAu1xeTHjWi
	h1Eztx1cghQKMt7hChP0YFsRcDwf9QRPrVhqhpTQFvIb4kHs2PuWAEHIUS3N
X-Received: by 2002:a17:907:3f0c:b0:c25:10a:4020 with SMTP id
 a640c23a62f3a-c260ca19c10mr922806766b.16.1788791394189; Mon, 07 Sep 2026
 07:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907134552.1772405-1-puranjay@kernel.org> <20260907134552.1772405-2-puranjay@kernel.org>
 <20260907140642.B02581F00A3A@smtp.kernel.org>
In-Reply-To: <20260907140642.B02581F00A3A@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 7 Sep 2026 15:29:38 +0100
X-Gm-Features: AcwNN1VweubETCOFNIB6vM400BaiT3fpYhkl79vbAZ8EO-1z6g0ay3X2vhr8_to
Message-ID: <CANk7y0j33fmyQyTvL37Tx6Ua_bGfT5n_=Smw44u_H7G6rMcr_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Add bpf_call_rcu() kfunc
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 3:06=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Calling `bpf_call_rcu` from NMI context causes a raw spinlock de=
adlock because `call_rcu()` is not NMI-safe.
> --
>
> commit 3385037afe11a72dffbb6db99b4174626596c231
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> bpf: Add bpf_call_rcu() kfunc
>
> This commit adds a new bpf_call_rcu kfunc that allows BPF programs to def=
er
> operations using RCU grace periods.
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> [ ... ]
> > +__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const=
_map,
> > +                          bpf_rcu_callback_t callback, struct bpf_prog=
_aux *aux)
> > +{
> [ ... ]
> > +     rhk->callback_fn =3D (bpf_callback_t)(void *)callback;
> > +     rhk->map =3D map;
> > +     rhk->prog =3D prog;
> > +     call_rcu(&rhk->rcu, bpf_rcu_run_callback);
>
> [Severity: High]
> Does this code risk a raw spinlock deadlock if called from an NMI context=
?
>
> Because bpf_call_rcu is exposed to tracing programs, it can be invoked fr=
om
> NMI contexts, such as when a tracing program is attached to a perf event.
> However, call_rcu acquires rcu_node raw spinlocks and is not NMI-safe. If
> the NMI interrupts a path that already holds the same rcu_node lock, the
> system will attempt to re-acquire the lock, resulting in a deadlock.
>
> Should the verifier restrict this kfunc from being called in NMI contexts=
,
> similar to how it uses btf_record_has_nmi_unsafe_fields for bpf_obj_drop?

This set is supposed to land after the rcu changes that allow call_rcu
to work from NMI have landed. Please see the cover letter for the link
to that patchset.
