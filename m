Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8639B483
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775506438; cv=pass; b=KaKV3rv7dAMMb4XyqXeIdxbuT4+8I6TosA8Whv2a1GbB5Qlzy7tnR39WhHvRidwNQ5dTH68C59TwYsIP/LvOz/D0HvrZi0h+PEYyH2LtBU7gZ2HAr1Go3GCQ7g6u5XV9hgUIh49Q4WFS0nZWY5tq33k07qjaPq6TXvsskC2WeIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775506438; c=relaxed/simple;
	bh=CGgR+FVD5lDs8xv13oN6MactwOqh3eG3f1nO3sZKX8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FtNGpcMe4YgzxMu7BKxIYCWqr4++7uyXNYI08tklU4rjzONWtLI/YIWphlsRH7mG4/Ye8bNsOzUDTjpA5GnIJiaJ+o4cQ2ncoydmxQ9HM7BTLWYuHpo+HVJa3/2Ys8BWdiZ7rNSWR+eem7uAfLkb4NPWfTvajG9SaGxYSbLqUk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz1F+CtF; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz1F+CtF"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48374014a77so57014505e9.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 13:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775506435; cv=none;
        d=google.com; s=arc-20240605;
        b=e04KIAWAS56Xim5CQkzOiTq8hSj5YfBkbuVG5XN5MFKxMte48hI6+BjGmXgIDZfZ1t
         OQYqSGIp2vHqGXUzOEe1VNRxmusFIe2l+SuYeYcoiLixnpE6xm65rUNQtkcqNRh0VzQn
         uiS/SSq1/XgTvzxDMocpnRu8j+4oqFBze1Mqvn3VSKDvd0b1mQi6TDpsT+sb0joW1nVn
         YVWA+NFfX4sybo8tkKpGboZJ0fJW9mzusyHdVlOafvhZxhnI1HmVMnhA6psGQCyWZfNB
         OZ0QDcYtnfRCPq6KOqHC+OES3LjYEXWynPE690IPYyyhIXSu2HT+eZMHGuNLCt0rsOoK
         905g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xXHEgF3EZiGGXRUO1lRHE/BRMXRolPTrHfUhOROvqA0=;
        fh=lBu8Z3tEILZHa+uyVLczvcu/TKJDiHAp0NNAlgXJaag=;
        b=ApwcmN5jYSjxEjP4J1V2Uxy6s/1X0GAh7iBBzmUs8jWftnK+0HaHXqmx2N0EKqHchB
         qJX5nc5+tdJRbdCtIF1QhGmU3b0AjrG9ePw8nVE7TXYW53NsIS1g5y+lncHeX52u3d76
         7jWmRLZXHkZtQ0H75HiVaA+fMAKbfg3GZxP8UWToXU+WgyzWvpfQkQJ50onsEjU7AZBI
         pblTVMiGErI7bUmbYVE89XTRdf89XpVBUAfX6bDlc8PC9+xfiilwBTcln4zriUUhOjys
         SGXyp0kbbwkdkFySTNRvNtfXWnBZUoPvFPBt/SBxQE05NPDVBvwHz7RTr0MFMJJWMS4k
         D++A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775506435; x=1776111235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXHEgF3EZiGGXRUO1lRHE/BRMXRolPTrHfUhOROvqA0=;
        b=Oz1F+CtFnynkVFBOUhH6jqsmMjKhdYRAnvlPM2vn3XAGeEvao1myHDXTKHuBYkMqRH
         O7qYK0zje4x00NY+g/O+KBU6pxKYxwBcPohrEbWhlzqQA2tz2GztsK0TtxDC+qzTAXKc
         U1ZT7212SJoBcG6zFzcm9PiHXMmKTZ2OSXA0oJxBUFJ+l61Z1Hc+2CYXKvKTKAfOc6v3
         OfjCqaRqBhHMSKgGIFmnM9BB8GtNV7f5gpok+Owz+fWT/Z+oVBze5wZsyS+eKewJitaS
         fQMQ7f++7G7QYcF1cW0a2PwXMAx3l1tUr4eGqLFcTHBAgE1E9fwqYJRhpqNQ+r5Keuiq
         bxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775506435; x=1776111235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xXHEgF3EZiGGXRUO1lRHE/BRMXRolPTrHfUhOROvqA0=;
        b=gG3mMPT97+VG4raHb4CO1R0Sg9emYrmorGXNz5w7tv+CNErorvyusNUamTSfJj9DMb
         ccgCoGg8lqE7MLJCGP2hLaYPriFm74UVPlSxpS5OL1Vpm0qCYveczosKVkeZCuduX29/
         wGwMzvrFlvCPlTMmAIc4WeKaUclBb1VlNNVBzvZqnq7MR/R20gzzwXuJxrFvyeTEVpua
         W8CinQIY+SwHdsm12sDvSVpu/0CPOXVjY4z11Ni7c68vxoajvm1Gj0zsWcmNOrRyCqzr
         mp7n7hfqpDavPX9TtjkGorUqQZqC4mfGjlR4oLuuXCueop8EhwMlfPQXxYRr2/r0gKvH
         xQgg==
X-Forwarded-Encrypted: i=1; AJvYcCVHyoAS9899iklPObIRIwgwEBYWtyCOt4tzuFT2kBp+jBY5KXaxdZ5n+CcAlyGCSqOUXAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvj/IRkE4ov6TicDRdpQ+GVvft+whFIB2KQ1EAOmKS999ZGn4T
	j40lkywtRd6vlLzqwKBawgyxYmSSO1/Q7qq1lu5wg7s0CsrgWkI5Ipet5mQ8OFKXt9CiWMcSIXy
	FHS9hy6F9xXzVSpsp91Na01SLq0NHe0w=
X-Gm-Gg: AeBDievZrzxYY6663k//EnFgLQeEyHddKryysM0V7p70C6Myt9x6LhU5f0O12+ViWn5
	PVV7ZiHYIq69s3cwSHsCCIBxnYpZwmCb2nh0qJwUYk4Wx3BuO5sfQyWvLWpsIJrC8I32vWaHnoR
	BSIModCLtlIITPWTkGfRPFHWh6Jm/DZAIA6ArMpxoIw5HM3OUViQRsGrD+6dezLwxeDkXYnwMhW
	udRGTlleI3xkG81fN4umFZf358znyft4UXzMnCDhULifGEMwXmzKMpBAkotjIfhmjuHrxIEbtK2
	O0eke3BUj6qKrOexlwkydTNGaugBmDtdtRvMWJ8xCf8XWSRvGhrdZY1jzQjdbXv2bEvPqGK1
X-Received: by 2002:a05:600c:2d8c:b0:488:a2ac:a34a with SMTP id
 5b1f17b1804b1-488a2aca4ecmr82371215e9.10.1775506434593; Mon, 06 Apr 2026
 13:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403033828.18529-1-tpluszz77@gmail.com> <20260403033828.18529-3-tpluszz77@gmail.com>
 <CAMB2axM92J40zq2VejrMYMs-6vPcPEBkJ8WCuh_9ymT0ozhyUA@mail.gmail.com>
In-Reply-To: <CAMB2axM92J40zq2VejrMYMs-6vPcPEBkJ8WCuh_9ymT0ozhyUA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 6 Apr 2026 22:13:17 +0200
X-Gm-Features: AQROBzCzROIYQnj1epFw7SQt0B32LfRC9614uD9sZqptejP-uEUmzjsqTP_4Fzo
Message-ID: <CAP01T76uzZvbk7h4TAKC1t0Ls11CoGtj=TvhQ4ur=iprLvWFyA@mail.gmail.com>
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: add test for nullable
 PTR_TO_BUF access
To: Amery Hung <ameryhung@gmail.com>
Cc: Qi Tang <tpluszz77@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Apr 2026 at 08:16, Amery Hung <ameryhung@gmail.com> wrote:
>
> On Thu, Apr 2, 2026 at 8:39=E2=80=AFPM Qi Tang <tpluszz77@gmail.com> wrot=
e:
> >
> > Add iter_buf_null_fail with two tests and a test runner:
> >   - iter_buf_null_deref: verifier must reject direct dereference of
> >     ctx->key (PTR_TO_BUF | PTR_MAYBE_NULL) without a null check
> >   - iter_buf_null_check_ok: verifier must accept dereference after
> >     an explicit null check
> >
> > Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> > ---
> >  .../bpf/prog_tests/iter_buf_null_fail.c       |  9 ++++
> >  .../selftests/bpf/progs/iter_buf_null_fail.c  | 51 +++++++++++++++++++
> >  2 files changed, 60 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/iter_buf_nul=
l_fail.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/iter_buf_null_fai=
l.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/iter_buf_null_fail.=
c b/tools/testing/selftests/bpf/prog_tests/iter_buf_null_fail.c
> > new file mode 100644
> > index 000000000000..ea97787b870d
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/iter_buf_null_fail.c
> > @@ -0,0 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +#include "iter_buf_null_fail.skel.h"
> > +
> > +void test_iter_buf_null_fail(void)
> > +{
> > +       RUN_TESTS(iter_buf_null_fail);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/iter_buf_null_fail.c b/t=
ools/testing/selftests/bpf/progs/iter_buf_null_fail.c
> > new file mode 100644
> > index 000000000000..963a4cfc33f3
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/iter_buf_null_fail.c
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2026 Qi Tang */
> > +
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_HASH);
> > +       __uint(max_entries, 1);
> > +       __type(key, __u32);
> > +       __type(value, __u64);
> > +} hashmap SEC(".maps");
> > +
>
> hashmap is not used and can be removed.
>
> > +/*
> > + * Verify that the verifier rejects direct access to nullable PTR_TO_B=
UF
> > + * (ctx->key) without a null check.  On the iterator stop callback,
> > + * ctx->key is NULL, so unconditional access would be a NULL deref.
> > + */
> > +SEC("iter/bpf_map_elem")
> > +__failure __msg("invalid mem access")
> > +int iter_buf_null_deref(struct bpf_iter__bpf_map_elem *ctx)
> > +{
> > +       /* ctx->key is PTR_TO_BUF | PTR_MAYBE_NULL | MEM_RDONLY.
> > +        * Direct access without null check must be rejected.
> > +        */
>
> nit: consider kernel-style comment instead of netdev
>
> > +       volatile __u32 v =3D *(__u32 *)ctx->key;
> > +
> > +       (void)v;
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Verify that access after a null check is still accepted.
> > + */
>
> nit: maybe just one line /* ... */ ?
>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>

Qi, only the fix was applied, the test still needs to be resent.
Please respin the selftest alone and send it against bpf-next.
Thanks.
