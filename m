Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2230F481252
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876209; cv=pass; b=W24G+8r6m0hGPN4ic0hpevycAAslgTIKO3nLZVpvRmbQfnjr9K4fONGTJI59KBLfrdAG/nkZlJmsLCd3+YElzgphIVhtNARG6OX9WdPM/8cZZSBSxE4E85pzQ6zy1kfbmAESyTVdOC92iHdYm2Zp00K0zy1wIBwp55ETCyphHmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876209; c=relaxed/simple;
	bh=BRgrRn1zPowjhwOLiaZSOQPLt15cU3xIhb+EGJfhcQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebGDup4BV5Hf/gItsQP0OlINtmvRq2OA9peQ0P/P9VR35AG3ikAwlK0c1fkxLK/4rms7NDAT4gaSEUg5mdfy2WMCkw+pujMEt56mIzzpZX0Bzbg2LZ7fMHSKrbC48s31PCVNLAXgkLPnYiJ80kMHWk3/i6kRVyWqihkpap6pGG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e03dwv1l; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e03dwv1l"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1f7666a90bso48750366b.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 13:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785876205; cv=none;
        d=google.com; s=arc-20260327;
        b=BNZJeq/QrbttHuKhhu16KZIfVkq+P25gos0XqNjENNVJMp+UT0yRQjaXsmRzWHKpQU
         cBaBEr1rCw/uZzpI5+9yTAZvAKB8bDTY6X3kohKtJ3R2v6tY/fh3qm2zFUPJ/c2OQ4mb
         xFHvVzqYXHZgeCnIMWuiy3Vb6vJjOZ1U29VxnjJqAG9fO2Bk4N7sTzBPjRfS9ZYWxRal
         x0CFR21iIkWkqHtE0zVJ82QjWkm+IvRb5xrhBXdANDAAK9E5iC0zGMkTsy0XwSDPcCTM
         JxvVyr8okFXqYq893wvkjQq6Br374HWb9ck8DsN77Nys+1yqo7t9f5T5shk6OvbiPsLc
         grHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cxavE2HhwRG9KnyTUo+TV6fM8Yj2zo1+iL7/LTIuN3k=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=ZdrvWz3vlmKAGEQ2DFqzVrfPho3K1anQ4oJKmCqDv6JHJYL10dmly/u+4nYK/zg+QM
         kQ+AXOfI7qBR1WVDd+z5e7VwMcibZyAKw0PxbLiZsBHOobdseJQ4ingKkshR3McPdQwT
         qisxnJLHgmQLGNpVZVJid2Rdwhqxlv4gx3r1upw/fyvYJ+rIoXH4KoYpp70FKniDZ/Y9
         WvMnKoV4w2SDp6ry3cS5WVTQbRnG9HpXAaJfqGp6DfJUwUMGw2I1iDickkLSzaTwPZdB
         A7mckiKtemt9Dg9jJYNEK/TeUe4J1xHXgHwRLasFZCKS+2at9YeWhbgTDkBDS31sXSW9
         rSmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785876205; x=1786481005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cxavE2HhwRG9KnyTUo+TV6fM8Yj2zo1+iL7/LTIuN3k=;
        b=e03dwv1ltKZIxN1GmhbejG1qeFBKFSlgrwyiSdepLDXt89j07mulLFVFP7At1y5eXO
         HLhmiA3r8hzwKAGMuGsWgO3sB7+caYZNzhydbTRYYaI6+p454MZcltwihtNFm5PSp/hu
         HSeISZg2aoBUbwbv+bdEndNlLXqBTFl19w4/IkU8jM7gkFF66Zc5KT+vwLB0xiLOLvCb
         Zyu09q1G6j+IQzCnkeJBZPjwjj6wJ5y7EmlWf+8S6GOFOLHvxeU98+1VWNaOQCWNSp1s
         ZNyUCyQ5msBLN+3rqpI6u0U5vuIu5onCt7YdLPIT7Clt1PndWtsjuJtCWDniqd+lpu6e
         Mqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876205; x=1786481005;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cxavE2HhwRG9KnyTUo+TV6fM8Yj2zo1+iL7/LTIuN3k=;
        b=oBkHICSGrtGHebHzXIKgYNT4Imep5twDHtKXG06A1Ou8bnGvDUQ5PU/qRLLgf1+nVU
         f5BRw9v8RAhUtai1yXjwxT1RYcDQQ4sGKk3ddaoAPp+P4CGJ9kiOyQ1FKN74P4VGFF3I
         paceplimQ8JwvnlyeW2njuYHeestXHKjhv5ZzOiff31sCGb+Gt7Fx62Ufjwwi1ykJg1R
         7ZHw88okLFB+v4Qiiw2aiutOPoZ4Op/MCSr/KqFBU/fXcMK5xdRCTvXatl0F1zJoqcds
         bKJQSPrzglUVpjtT0xI4Ffsxo7AWL/Pk2xZrwLu2nXv4sC6sFBqIeTmN0lpOwNSVylIA
         +Rqw==
X-Gm-Message-State: AOJu0YxPWyw5r2T7+oSP8zwd4D/2rRXHEgD2/QMyqPVEw1FSZi81iUL7
	1Z61P9mXiBmbGx5CD+6yvZBnCw1296XtICWWnFZrEBOg7i1EBH+bP4yDvKWi7TAWRxoBah0Ju29
	U1SQ4mh30q5WJXqjjWu9l3AxMNACukzy5QCc7J4DQnQ==
X-Gm-Gg: AR+sD10zKkY36P7T3BRV/NbMLIXXmo+1DXlBynEdh8h2ssyIBTasGM7r6gefffSdOpP
	Wz3kLJn7+JFChxxJjHUv93Mh5zHLi+DIvER0vXhPsRxNS0HL0tYj6aB70wE4art7ITOc/2UD1p8
	OEOgRdfjmIqZiw4A2+H91HJXEQs4WEakpKbalTpQNmFSJQUnC0ch76i68xPeugFPme6f6b1KVYt
	O3PZ0f0H1+rZBJ4/GoTfA1aGNxTVh6M8Z4U8zn5drdKW++ZBOKCoFZa9JltiOHGLRD0C7XY8Fcc
	1rZzFakZldKrDVymXCqNXaPQKQxddiUXY1hOmO/srq/XvS1xfkHD3d7a2KHcdR2vaCY1ycPSn4A
	Svo04ceT2Ng5htw==
X-Received: by 2002:a17:907:c14:b0:c16:831c:427d with SMTP id
 a640c23a62f3a-c2039c4af80mr75671666b.21.1785876205109; Tue, 04 Aug 2026
 13:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724042600.175440-1-nickolay.lysenko@gmail.com>
 <20260724042600.175440-4-nickolay.lysenko@gmail.com> <20260724043556.BEB5A1F000E9@smtp.kernel.org>
In-Reply-To: <20260724043556.BEB5A1F000E9@smtp.kernel.org>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Tue, 4 Aug 2026 13:43:13 -0700
X-Gm-Features: AUfX_mzjJZj_ihZ8k57XSsgXGRn0MQWZhAkomNBddo_NaicC8B0PWbUw5MsZ3e0
Message-ID: <CAMtxOX1rW=piosQaHrbv_fTLGHf3QSgMEWnsSE0hO8FJFDf1_w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v4 3/3] selftests/bpf: build each test runner
 instance in its own sub-make
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Correct - the message was stale (the derivation was dropped in v4 per
review); wording fixed in v5, no code change needed:
https://lore.kernel.org/bpf/20260804170156.1709916-1-nickolay.lysenko@gmail=
.com/

On Thu, Jul 23, 2026 at 9:35=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The commit message claims that light-skeleton demand lists are=
 derived dynamically, but the implementation retains hardcoded lists.
> --
>
> --- Patch [3]: [RFC PATCH bpf-next v4 3/3] selftests/bpf: build each test=
 runner instance in its own sub-make ---
> commit a1ebeec9064cd1ef457a1d6c67e818e26521e31b
> Author: Mykola Lysenko <nickolay.lysenko@gmail.com>
>
> selftests/bpf: build each test runner instance in its own sub-make
>
> This commit replaces the double-expansion test runner logic with a
> Makefile.runner script invoked per test runner instance. It aims to simpl=
ify
> the build system and fixes a latent parallel-build race condition.
>
> >     standalone binaries and the kselftest lib.mk contract - and delegat=
es to
> >     the runner through explicit per-instance rules. Light-skeleton dema=
nd
> >     lists are derived from the tests' own '#include "*.lskel.h"' lines;=
 the
> >     bench object list is derived from $(wildcard benchs/bench_*.c).
>
> [Severity: Medium]
> The commit message mentions that the light-skeleton demand lists are deri=
ved
> dynamically, but the implementation in Makefile.runner retains the hardco=
ded
> lists.
>
> Was the dynamic derivation logic dropped from this patch, or does the com=
mit
> message need to be updated to match the code?
>
> For reference, Makefile.runner still hardcodes the lists here:
>
> > diff --git a/tools/testing/selftests/bpf/Makefile.runner b/tools/testin=
g/selftests/bpf/Makefile.runner
> > new file mode 100644
> > index 0000000000000..ced44aad7eded
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/Makefile.runner
> [ ... ]
> > +LSKELS :=3D fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.=
c        \
> > +     core_kern.c core_kern_overflow.c test_ringbuf.c                 \
> > +     test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
> > +     test_ringbuf_overwrite.c
> > +
> > +LSKELS_SIGNED :=3D fentry_test.c fexit_test.c atomics.c
> > +
> > +# Generate both light skeleton and libbpf skeleton for these
> > +LSKELS_EXTRA :=3D test_ksyms_module.c test_ksyms_weak.c kfunc_call_tes=
t.c \
> > +     kfunc_call_test_subprog.c
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724042600.17=
5440-1-nickolay.lysenko@gmail.com?part=3D3
