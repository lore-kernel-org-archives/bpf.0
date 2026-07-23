Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B25647D47A
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831757; cv=pass; b=ffmSu1oX1dH5QmEGhR8GQYS/r4hYOduRACXdEPWMKc5YX0hOsJ7+D5wmBkKkIRu1rgwRiPe0oDvw0ZYAeDI/V3oRp8Sh3iIZS0I954XmbofRcnda55es4Lv9MgtV21K7Tj788keLh2DCmD0OBbIVJAXb8ELoIQQ0gOqcI+0lK/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831757; c=relaxed/simple;
	bh=Bb7c7PXG5uy5wbFp3hNDteby9VEORJNPu3ecqOZWNzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeZNGJRUQS5rmnXtAb5wuTsHgHkxhHltcnEv3b8FQV2lFho29dtyBUYMXNGtywvgoqLRwAp46VOpnNzbu1S1CafkRgsfRwbntbulILBiopBXQGFG6P5FlXl35jqTN+ZFkZsWfWRQ49Kl6vSd8ifwT+MJ7qMukQMVPOpc/7IbMIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXF94YuQ; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXF94YuQ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81ed2a00f12so8884797b3.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 11:35:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784831752; cv=none;
        d=google.com; s=arc-20260327;
        b=Rqf2iHiE4n+j2T+vlHmOD0jlcHPBw6ba0vcKv94a1VXLy15d9jILQ6848+TF82WNos
         X1FY73F+pAogD/9JmvBLDHwn1MYoKbC+5OD1X0y2peH7XOjfRLHHGmHH722KMVkTgt3A
         4vz8KF6/SR28zSsLbPAmJyDm3ciPcFbDR6SmpNgl4r+TDCfABhb2okDguO76SeTQGA6s
         P4ocl+0jFJno90lGEis9BLQiqSmTR3HwxBt/Xoat1klTIFqqAfMZW7KqDpCee6vCA+vX
         bFMW5m4XQq7d5ms8lCPqjXhXQMgL4Asd3I4mKYWTBGuDfj23+Yr46b9rNZjJkDaoEXIM
         exSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6JK020c9+x/NFTScqlE+I6Rm38dLPHigKvNY3L5rM1E=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=XVzcVXZ5mJPfqIjB0CzV1bhXuz/fEFxjVrPMLnb6PfpA+to2BGmJVSmXYoWGLiI/mq
         cCCpJgzYqo1LGNEItc2tvg/lWU6vWKDrYnO8T9ENCYtckmZZSuqX3UwihfXlzipiT502
         xgo3ZarA14XMwcqz6vaA0XM+XtU4vKHJ1Gdlfx+kHgAGO2+awGThB3B3JHS2orpYPv4O
         WyUtuPmuCGvpWDBU4lX7+Vb1ruCl/x7l+/E/ZM230bqMILMKFWMUHfdh2KfgGDEohvNe
         SkzI5KlGNPwLhHMpQ6BqB0suKUISK+2t9RFKjxA1L5/J4GYh25FiZyiRJe/GUedXS8SI
         iWyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784831752; x=1785436552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6JK020c9+x/NFTScqlE+I6Rm38dLPHigKvNY3L5rM1E=;
        b=bXF94YuQsdjgrdTx3FI0Awb4RWohSmG1hLM+FG+BjVpbnk6h7lp9z5eRTixLim50Q8
         WpUX8t4jsPYC0UD5HtYdHHdpm7cNKAGu1AIwOKCdZwlgCVes/xLk7uBOgPcHooMtu8Jx
         Lfz3Vb4v+qZ0eYmzWwUSJw1mwrOdqj4AKw0JPYRio/OGrveYRXg4NBteaXI6X2BtYyBl
         lK4fHGiQtebwnSseXJ60Yof0V756XEusdj8RcGljqtcZtLsYySl4d+uk+OLOG55G4/Ex
         Q1ve6EFpn2zhbKi6TlQOVl/FQtD9c1NNYF97pMl3nz3XWkat5nAeTVtW7S0yA051INRx
         Ot7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784831752; x=1785436552;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6JK020c9+x/NFTScqlE+I6Rm38dLPHigKvNY3L5rM1E=;
        b=h4hktjGCewuLQBBcoLeAfT4JKlCg2XoDFCSXG2Q/TwKh0PSnxmjtxKn/XuyEdSisiD
         5fBSFcMiw84vN/BxLUARv47Rml9m0bfQCpb4xj19RSwJgbalxXExg4EFfs/pma0LvzHB
         qj8ol3KO5Sp3UG14j9gk8AA5QKS3bi20cxZoNbvUA3tEPIE03sXoweErjSYtESE2EAEZ
         yb0hHOcTMHWIddWBA5R/6wwfipU3yCWLmgjbogO49QpSZOZ6CWp0rrT5dmZgXZ8eMh5t
         8CDI7zk3j0yExaiIRn1gYJfL6DzIzcIX/IUi+soZNx9ob4E+OVzUimz0Lp+u4Z5qufC7
         qMbg==
X-Gm-Message-State: AOJu0Yw2lXfumo8Z2Bu2kiwhSGHKxTVnxE0BilwHHngvaLgy7qszcl3G
	3YHoAMtyC8QMZd7quqiX/NYkPLmID4LXUJneDSoD4e8JE5SAdKqX4FCp3oQ4CzQDllY+yFWq6zY
	iHpAPjxM4Doj16INJ2juk3yRvByYKiQbSeg==
X-Gm-Gg: AR+sD13HizgxywwTLmwo7INDhOhU4xPWR/J6RSn36IHJ3OBPUlWgOai9oGGFoZPvwQc
	5RzK700BHVHktmI2WAgxW89a4scNaM0jwg4euyZkZqyqbGAOV+JpCTWooGOtfrq5fMomwy8q2wK
	d3GjdZ0vXg3Aww3SnkDB+f6vHAV6urOfkg+CmNko/POAS5AAOXHGYfDXxy8QJfLLtKHXOjQ9a+P
	9hbDaO2ytuQ0D/DEEuvhtyl8jddwwzozkTXHtWfubMM4CuIsIPHKkbjI9RKGQ==
X-Received: by 2002:a05:690c:3605:b0:81f:3dab:372f with SMTP id
 00721157ae682-81f4c14de4bmr14619757b3.12.1784831751774; Thu, 23 Jul 2026
 11:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723050806.1158442-1-ameryhung@gmail.com> <20260723050806.1158442-7-ameryhung@gmail.com>
 <20260723054216.001381F000E9@smtp.kernel.org>
In-Reply-To: <20260723054216.001381F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Jul 2026 11:35:41 -0700
X-Gm-Features: AUfX_mwhGndatDVJ6IZ8uPGDvTg9e0G_B0Tmqr7S6GuhZPfuaMemIq8vAAhXwHY
Message-ID: <CAMB2axN92ZMmEPOAiKAp_C9u1NdWVsNxM+=_D9L+PW6Szxed=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 06/18] selftests/bpf: Add tests for helper and
 kfunc mem+size arguments
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:42=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The selftest `mapofmaps_value_as_kfunc_mem_buf` uses an out-of=
-bounds buffer size (8 instead of 4), and both tests lack explicit `__msg(.=
..)` assertions. This causes the test to pass (fail verification) for the w=
rong reason, rendering it ineffective as a regression guard.
> --
>
> --- Patch [6]: [PATCH bpf-next v1 06/18] selftests/bpf: Add tests for hel=
per and kfunc mem+size arguments ---
> commit 967fe45d86aee49807b5742ffece3f858b20a4fd
> Author: Amery Hung <ameryhung@gmail.com>
>
> selftests/bpf: Add tests for helper and kfunc mem+size arguments
>
> Make sure the return of map-of-maps lookup cannot be passed to nullable
> memory buffer argument for helper and kfunc.
>
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c =
b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
> > new file mode 100644
> > index 0000000000000..78a9ad22b10df
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
> [ ... ]
> > +/* An un-narrowed map-of-maps value must be rejected as a __nullable k=
func mem buffer */
> > +SEC("?tc")
> > +__failure
> > +int mapofmaps_value_as_kfunc_mem_buf(struct __sk_buff *skb)
> > +{
> > +     struct bpf_dynptr dptr;
> > +     __u32 key =3D 0;
> > +     void *inner;
> > +     char *p;
> > +
> > +     inner =3D bpf_map_lookup_elem(&outer_map, &key);
> > +     /* intentionally NOT NULL-checked: reg stays PTR_TO_MAP_VALUE_OR_=
NULL */
> > +
> > +     bpf_dynptr_from_skb(skb, 0, &dptr);
> > +     /* pass the un-narrowed map-of-maps value as the scratch buffer *=
/
> > +     p =3D bpf_dynptr_slice(&dptr, 0, inner, 8);
>
> [Severity: Medium]
> Does using a size of 8 here exceed the outer map's value size of 4?
>
> If the intended type check is missing, the verifier will still reject the
> program due to a bounds check failure (size 8 > 4). Since the test uses
> __failure without __msg(...), this unrelated bounds-check failure satisfi=
es
> the test expectation and causes it to pass for the wrong reason.

Ack. Will fix and add failure msg.

>
> > +     if (p)
> > +             return p[0];
> > +     return 0;
> > +}
> > +
> > +/* An un-narrowed map-of-maps value must be rejected as a PTR_MAYBE_NU=
LL helper mem buffer */
> > +SEC("?tc")
> > +__failure
>
> [Severity: Medium]
> Similar to the above, would it be better to include a __msg(...) assertio=
n
> here?
>
> Without an explicit message check, this test could pass due to unrelated
> verifier errors.
>
> > +int mapofmaps_value_as_helper_mem_buf(struct __sk_buff *skb)
> > +{
> > +     __u32 key =3D 0;
> > +     void *inner;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.11=
58442-1-ameryhung@gmail.com?part=3D6
