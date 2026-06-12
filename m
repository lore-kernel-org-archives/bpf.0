Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8F381AF9
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245965; cv=pass; b=TNbwiwGmZFsWo/i25+h5TTO5A8SqbNMXCckxQy+HkWsSQxFG6QmzccRxg4Z+aN5oWuV68LxOqLAY69BYr7yvWTxv1CQcWRvDcH4i2tqTfEk3fPtkwgTcm88NWgmaiXdamBiOu+68PNuM2rV+KFxnfg92lKhZkvuAHx2YzA33biI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245965; c=relaxed/simple;
	bh=E70qoRUfGKWHoRfDr/vGHx+xj9G4daC6qsXk61KaDnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exK+MKDyn6iMVGvp3QcVHJPm1lj374k199ZiW+taB+WMWjwcxT39kXZ8qxD7y2l1N14tpmWOiniwgEBmjGr1xqXFssOpGIfj3OT56e23BARHzGhPaDYGZvbWxfNSw6WPtUwotehy0GBUnstvqj4lXlObuHzmtlCNSVC7Fbi35xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8aetRYR; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8aetRYR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so6818785e9.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 23:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781245962; cv=none;
        d=google.com; s=arc-20240605;
        b=KCcBtTZWtj+GjNDr0tmB98EcP8hQfCvL+Mdzu3nxHOtyo4M8xrASxpw6YXOm3rxmy1
         yH7SsLoYfcyfDjN5Y3jSL+O7Gjf+EwSDpllCFGbWRz/Sn9y20lPzteZkyjUbxQEk9PLp
         VEu3NZJN64A9niCmzhekGbm/eWmWWtxH2L/eq9XSRGC8SNiMa6mE29bpoCs41zi6sW3b
         kr+T7H2KL/WsV4ysjtMI+HM1JsuGXDIIohtp7JvlAIXDE4mC9AXPZxhpgOSKULzDWHCZ
         KOlU6kkCvkvhvzEo65UH8vPf0xiOjpvWCfpBLzruLx2h6DAsAqvJ2Y2vJVnlfF1BKBRk
         J5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1CO6Doo//w2RGkJIhLZDU9oQk9kpI1zOxu1zlLLy3gI=;
        fh=Un3aoqM0HkpUA8U8Sefs+lNTl6GsjR9V6W7nEiKMWjM=;
        b=KUN+9oUdbLk7FpoZxi3qHUF/Q6GxdYinlN6QmicD8XJxMjo32QKe5UY8/IkQYnRAdO
         raEh1AI65k3/cukMLlJ4/7k9kvA7e44xpAh2QBqEdVC/dee0ojcKn5JDzIyvNwMUhIdi
         lrbzfc2UyQKAPyww03OedLERE6AMJv4mN71XW+/+kerdkBAFOWXNajNH4tmmLSQ9pZQk
         K5u7viqBYRZKhb3lpcXX1hoRn/Og/AvJ7/kZrOgZ8gjo6zPojBG/nmwbnX3Ue3pmezs2
         QQ2EvkF1+GPNOHizJG+k0NZndkqvcoY+/GHym+veX3LqKmQl1CL7MVUy5sLFPmeQi90M
         WT0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781245962; x=1781850762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CO6Doo//w2RGkJIhLZDU9oQk9kpI1zOxu1zlLLy3gI=;
        b=e8aetRYRQwZmtknKmu4v4+nYP6KiEPcT3u7uPP2jMrifEHDi3ShhupYI/IxSHv3shr
         1dJkXYHifLJPIe21NAXm1R+kVzAxqgCJt0wtRJBMbTmvOpt0RL9xEvmIr7zIVgfQT9HR
         aLU9mFOllcrO2VBIYWEjVfKzuWOqhvPdDN88rgXJRtr3NHe5iGKxtYsKTcxv1c2+YO7H
         aLdwPJuT9S7OtJJbNPfGODmU4R9CwTWtHs8tlbpVVBIsiA1UWsm1ek0OHuVzOJ8fjpqc
         +8ieKRcj0mjWWVUtk3CVH98yJ7jyFOOjRuopbtOR5qqD82x+EC0O0JU23Z+oMc6TjcYb
         pR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245962; x=1781850762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1CO6Doo//w2RGkJIhLZDU9oQk9kpI1zOxu1zlLLy3gI=;
        b=TouCetn88e+uFDFEtezFEXHemsxA2fv+Y5LGgM5p2LU+x5oTukh6r0pmsLzg9lBbv3
         Wxedj/pHYYCOAeluxOFYwQRV1l9Hkyx8mAYtc8vRSQthEJ3dpbDewJSVN8+IBZiF7Hm5
         /WbJqHuUvaxVY/WAhw+H94Hmo+uqqosMTkic4UckC7wlYFerTTtd73gQ0AE7HKt67ZPv
         eI3drZ7dotoGYA6Pe74owmd7ndp3UtBarosivgybO4ymzuejG8jgD7xl3INeVWgkmS9f
         O1FuTWRP1Jg+1dTwIyIWpwa5acz0e8/x45EprdMll1TId4Ze0yjo63U2vxWbPnWOsKDh
         ifNQ==
X-Gm-Message-State: AOJu0YxLx496LRusmF8qIKumRABgGh1B/jwvG0vznOHrRcgeyfsHJhCh
	dkM16j8yUOChxxT8D1QMKXLEE2mZl8z7hw7oZT4a5wJvSJ+NdvQ55+w1ozxHbCoX6HrJddqwCFq
	NYj89sA8E/0jQyiEor4Dag7+oAqPQay0=
X-Gm-Gg: Acq92OFXH7Cv4JFBwyaTovXqURiFYHMa3QxlUUC0ijMjlDNPE2qcbC4xvvK37hZVJzB
	6gJDgHg+jRmLPUmUry6cDxeQpKYY0+Grkkpic3WaG3ikTrZh3+zXcj4oJtkTkZ/kA6k2e+7qx3y
	r+h1db33TdyN6+nxZQBRmjsNIZQ09VAo3bJ4mMRTA2tB7zmt1q2UkDdxM0VpTFet+SuJfAxEzen
	9VnJgMOFqANtBTTC8mmGOT19T2Abmw/aLY8yojxRjE0AJ/FE2VS6YqxQ/ZM74ij0nC3BWa9S0Qq
	WyRv
X-Received: by 2002:a05:600c:3b90:b0:490:b629:286c with SMTP id
 5b1f17b1804b1-490ec4c4d5dmr13864405e9.12.1781245961963; Thu, 11 Jun 2026
 23:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611160749.391279-1-jt26wzz@gmail.com> <6e70a018efc87ba1334617b2e6c75ca003e7b1345affe15f1b605634a4ebd183@mail.kernel.org>
In-Reply-To: <6e70a018efc87ba1334617b2e6c75ca003e7b1345affe15f1b605634a4ebd183@mail.kernel.org>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Fri, 12 Jun 2026 14:32:30 +0800
X-Gm-Features: AVVi8CezUJQ5dJo2tCsl4YwT6OFMv_yZWKbGu9cEm2eLDv1JPD0X-poujETqbbQ
Message-ID: <CALgi0XntTQpXBPG-znFGohvSMHDmMf93kqz9K6k2dN2rPE_ABA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar
 pruning selftest
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, menglong8.dong@gmail.com, eddyz87@gmail.com, 
	shung-hsi.yu@suse.com, stable@vger.kernel.org, mykolal@fb.com, 
	tamird@kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for taking a look.

I used `r0 +=3D 1` only to shift the helper success value from 0 to
1, so this test is not masked by the verifier's not-equal-zero
refinement. In this reproducer, `r0 +=3D 1` does not enter the internal
BPF_ADD_CONST linked-scalar path.

The helper returns an integer with `R0 id=3D0`, `r0 +=3D 1` keeps
`R0 id=3D0`, and the `r0`/`r7` scalar-id relation is established later
by the `r7 =3D r0` move on the failure path.

The success path skips that move and keeps `r7` independent. The test
is intended to cover pruning between those two different state shapes,
not ADD_CONST delta propagation.

Separately, I don't think the Fixes tag suggested by the bot is
appropriate. I do not have evidence that b0388bafa494 introduced this
issue. I can reproduce the issue on v5.10.258, v5.15.209, v6.1.91 and
v6.6.142. The upstream change that fixes this state shape is the later
linked-scalar precision tracking change:

  4bf79f9be434
  ("bpf: Track equal scalars history on per-instruction level")

More background is in the v2 thread:

  https://lore.kernel.org/r/20260607170959.823755-1-jt26wzz@gmail.com/

BR,
Zhenzhong

On Fri, Jun 12, 2026 at 12:58=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > selftests/bpf: add helper retval linked scalar pruning selftest
> >
> >     Add a verifier runtime test for a branch pattern where a helper ret=
urn
> >     value and a related scalar stay live across the same control-flow
> >     sequence. Rust/Aya-generated eBPF can naturally produce this shape =
when
> >     a match on a helper status keeps data derived before the helper cal=
l
> >     live across the same branches. Such code commonly uses the helper r=
eturn
> >     value in r0, where 0 means success, producing an r0 =3D=3D 0 / r0 !=
=3D 0
> >     branch shape.
> >
> >     The test preserves that branch shape but shifts the success value t=
o 1
> >     before branching. Using r0 =3D=3D 1 / r0 !=3D 1 avoids depending on=
 the
> >     verifier's not-equal-zero refinement, so the test exercises linked
> >     scalar precision and pruning behavior directly instead of being mas=
ked
> >     by zero-specific range refinement.
> >
> >     On affected kernels the verifier can explore an impossible path whe=
re
> >     r0 and r7 are linked by scalar ID, keep the wrong branch, and make =
the
> >     test return 1. With linked scalar precision tracked per instruction=
,
> >     state pruning keeps the real success path, and the test returns 0.
> >
> >     Suggested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> >     Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
>
> This adds a regression test for a verifier state-pruning issue with
> scalars linked by scalar ID, but there is no Fixes: tag.
>
> The test structure (success path keeps r7 independent with id=3D0, failur=
e
> path links r7 to r0) matches the "registers with id=3D0 in cached state v=
s
> linked in current state" pruning scenario that was addressed by changing
> check_scalar_ids() and regsafe() to treat rold->id =3D=3D 0 as independen=
t.
>
> Should this carry:
>
>   Fixes: b0388bafa494 ("bpf: Relax scalar id equivalence for state prunin=
g")
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/273612=
18656
