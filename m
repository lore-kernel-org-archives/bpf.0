Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497038BF7A
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220689; cv=pass; b=KPWVdIISmekF6Lf1Yk8f9xiYoWIED1fQewCWPrxHJbRjuAvjKDR0Lx2guTQZyU2E3F16qSkVbKE8SRjjZJNHBpundfOElnvait3ma669YVzWHBJcjq5TITXs2dXFmdUJXrJOFN5ptV7NHhUWK8Ob7uf8d1nwtw3iiKcBuVJhQUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220689; c=relaxed/simple;
	bh=MkQ41IfwJ0nvjPn4fveYrRfBVnbitV8rEVwRZYxgI1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRcga3TfpG7UhztNjTOHZx9UhTi3xCkibTRzE3SUn309KQkzdww0s6GtlGcV36siMyVhqIMkJFjEeeJ2RB313Ky027i4hDZI/E/61/klyTq8lFZVgsuOjumaTFVcZ7aDfMkv9jTVzGHi3W7z58UFTpEcZzSbZXZFo55zRkBblvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6VfRVpF; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6VfRVpF"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7cb343d343fso34948697b3.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 12:58:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779220687; cv=none;
        d=google.com; s=arc-20240605;
        b=RsvfKMilWNoSkqWxBWfgByX2va7wGw+Bjy3d4878LKsC0N/myRb1Rz2/RD2qRVh1sq
         B5CDGt/8+sYrPb8dO80fj6w5F3pmxdD8N15gVEDHjV+FiP2ikQCV0QlbpTYoX0ainj/B
         2u45W+RnDATyyYRbS3RNnBkcJs+cts3DNMjGMudmatt1DQfpWI7yLW7YSQ1FCeUaXQlQ
         mQ/7nIzDdLYTaOYTlmqUUs70NPfqRiA+a877uvD/FAwnAM0EhgPePF6GNKL9Wkwko6Us
         qySMmAmEyMymVbIifwmjIwRgbYZfvU3eIsxPdLcRnvdLYyuQFoHQlNnM7b8vFxB4l73k
         2mdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OkKi7olYT0UMvP1V+ApFdiGBxqqlUbmJyXbpHlsr2iM=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=hnNjUPKpp8kSHbnwycIoGRTJ4QJY6kaY/09IUcZU2kNXSx9vFxNz/X+eqg3qj5qjel
         E6O3/+X/et3NhoVlnFmpQOktDdYkI5xldT6LvlwWpD7hoPsRGGo4UzjCxcGaSHbKDZv5
         ioUWyFafaUzNxgmMcpaTvknkV8FjQ3sd9K8cpxns5qEB7eU2Tsa+zkJv0oNbMfoiXYNa
         HPAn1xl3cVuR+aI4ojUjtqqcS6NJkVkoo0WirP5Pamqtu2gv/k3G1RSmTTNhKJsvbgrs
         BdC9epdZa01hNIGlueNh9p7EjQUyLxQ2mAkO8A+x2N3TCEnqJcoiIhzeDbtXX+eNGfED
         IkpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779220687; x=1779825487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkKi7olYT0UMvP1V+ApFdiGBxqqlUbmJyXbpHlsr2iM=;
        b=B6VfRVpFUYinCptrnqWZJnO2xjg3Ry/d1/Bqzp0kU4pn3BZ8bwSZJkiEAeIKLPpDeL
         aAQ2X7DqIhR16UKHXqc5CdjdBm49pmV32cIPtqea5h+qdOxEwv23Vb5FlEhbWobKIsVL
         m+hLQG4u6vWEbGvVPh6KVSrTPUsxDgU0XqlyIZC+zMjuLafuOM3H9dw+qJJRwLMQ3HLm
         rYLn8pjayykDt3LYhbCoTN1f8e+NAyXOyUePyxEtu8voWyuDwgLxakVpYRhfl6TFmsuO
         d1mLkXvpvAxspsuACbrui+p8esB5S2rXVAdVAswfcYGf78u/PXZqGYc8NoO8Zn58Zqnx
         wYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779220687; x=1779825487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OkKi7olYT0UMvP1V+ApFdiGBxqqlUbmJyXbpHlsr2iM=;
        b=md/22pgkcCEpqpHCbkUzrwSoRXr8+zt428cmG5Nf4+9thJQHZfHGOfvt4v/5Lvk5TM
         mc8E+oduMKwXh+mYD1MoJFxNh1ylD8qULiHyoeKvUj3Ug9YIuJYYyNVeYD4QPdFwA979
         LWs4Xm/7+Ii6VHUkV91sXAQobJg9bgvWkAFoGpewk5GDjiXNMxev7HHHSw4QcVBYCLmb
         T90H9/rbcVl5p/JQrREHsHWnXjUeHF2qIVifaa4uFXyE3yPcXxhWKOV+LIw32rD0Qn/K
         OehQQZDgIkmlDZzSONj8jkdtUUGgEJLhLZqBlXfnwIe66B6HkOIL4Sg+kvTnNVjhCbcR
         F56w==
X-Gm-Message-State: AOJu0YzNYwyvcOO7biByB4wpa9JvEy5a5mjVnzKhszXoVxGdXUUN11vb
	QM5PrBB8d4uKA1rLPzcBc1TZTmWmxPhAPZIEZjRBN/cIt049FLWlufmN2V8nJ5nM4HCVMLw9Suf
	X932NfyQJzpfc0bqTM735R6AIWniqrS8=
X-Gm-Gg: Acq92OEqF1TOanFMwikzX/0Bc/mZ+pwjgcfaT2CXqUSQDf04XQQ5dFBUnnrpuQ5Qkap
	Yna7Wzj826ruwnYl2YsJUyveivbY67+mga97tT3RGBPMrFVWO5jBji9nxp8WYxipgDfKHT7pFGa
	wTJ9OdKkpqE6WyIMEkpEXPAjIb38x+zSOLZaNxl1Z+XqOPExdsmrMfifdkYD96b2b9G+sEqtKRP
	yL0rJVSl8Mi1KIGG8ddwlNL6A5AZ+DxOXTnFSdm1IFmW2MQoBY0ikQvWpbbFrpZgjMV3nMcGA24
	MSouKRR9CwKLDXQKTGHe/2tOGLM0JuI=
X-Received: by 2002:a05:690c:e3ce:b0:7bd:8cc5:6bdb with SMTP id
 00721157ae682-7c95c6edd6emr231497557b3.35.1779220686647; Tue, 19 May 2026
 12:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519181314.2731658-8-ameryhung@gmail.com> <20260519185519.A746A1F000E9@smtp.kernel.org>
In-Reply-To: <20260519185519.A746A1F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 19 May 2026 12:57:53 -0700
X-Gm-Features: AVHnY4JmK8v0DHREJQ1CnU9JGl1GTlGh1s6crkftapNbTQuHiwMwEo1ZwnKJJHM
Message-ID: <CAMB2axOdxq241ZGHGqeT2OPNtW5r8bkMu9egdso5W2OBbRsexg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 07/14] bpf: Unify referenced object tracking
 in verifier
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:55=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Unused legacy fields `ref_obj_id` and `id` remain in `struct bpf_=
call_arg_meta`.
> --
>
> commit ff3476feb916076d44d843f726cd0727a0a067bc
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Unify referenced object tracking in verifier
>
> This commit unifies referenced object tracking in the verifier by introdu=
cing
> struct ref_obj_desc to consolidate the id and ref_obj_id fields. It updat=
es
> kfuncs and helpers to use this shared structure, replacing open-coded upd=
ates
> with shared helper functions.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index edebeb3ad3635..bc7f8725cc698 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -231,9 +231,28 @@ static void bpf_map_key_store(struct bpf_insn_aux_=
data *aux, u64 state)
> >                            (poisoned ? BPF_MAP_KEY_POISON : 0ULL);
> >  }
> >
> > +static void update_ref_obj(struct ref_obj_desc *ref_obj, struct bpf_re=
g_state *reg)
> > +{
>
> [ ... ]
>
> >  struct bpf_call_arg_meta {
> >       struct bpf_map_desc map;
> >       struct bpf_dynptr_desc dynptr;
> > +     struct ref_obj_desc ref_obj;
> >       bool raw_mode;
> >       bool pkt_access;
> >       u8 release_regno;
>
> [Severity: Low]
> Since this patch consolidates id and ref_obj_id into the new ref_obj fiel=
d,
> should the legacy ref_obj_id and id fields be removed from struct
> bpf_call_arg_meta as well?
>
> Looking at the rest of struct bpf_call_arg_meta, it appears these old fie=
lds
> were successfully removed from struct bpf_kfunc_call_arg_meta but were le=
ft
> behind here.
>

Right. bpf_call_arg_meta::id should be removed as part of this patch.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519181314.27=
31658-1-ameryhung@gmail.com?part=3D7
