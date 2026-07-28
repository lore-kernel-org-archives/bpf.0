Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B07470E90
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265923; cv=pass; b=N6BIDtX24tx5r+34SjUE9/oglT42tH71FaM7vOKxjCJlqsDeG68frJtKZTPxuvBQmGHmWY+s10v3WeMvO4AIowyAuTxDcrQvxD7goZS9pa8kxKKVsUSGYHjtTu+H2BvbGFy+6HCvG0Gco/LUVStq26YxyK79DZrim068BE3oUWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265923; c=relaxed/simple;
	bh=lG1ndCCfyCoajDZAfA0SUUCljcSKCHW7tFmz5Hog55g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtP7Is9BfCMCjuNxqpPuGxPQpxz8ZWd/sVAjTQqLEz7dnWxkx+Lfx+YVCaPE9ZavyYEkNbewmQvT86PddKOHf7FXgQ/rB03n5IpdQ8bg7lee6jabexmi7tmMQOKLQidscn3H9NaC/BtpNmkHmJJwucKOqPLQeJksr4ct1Y1E4Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyY00hzd; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyY00hzd"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7ff05e5d009so2859617b3.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 12:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785265920; cv=none;
        d=google.com; s=arc-20260327;
        b=G/9vSQB3orbxYBcY0T1aB0CwY6MihfhKWfITSL+TV8lUd18Y7e+UEUa06MQw09Uigf
         /tnKpyqxxbFJU+dj/rtgW2cl3BQGBuK95tHPjk0tLCFwhewDLBv9L4DbEhsFe1K8PwbG
         x4NLJk4RzvdI3Ly3FHmPR5tFaN3kx4PrJQ53l44P+D6mH309/0eg+i3lBDkFBN2niJxg
         IAZz1CuHTQxAYlbC+Lp5ssgoQvxMnzRNrtS3ZLU87plnIbpZNChvOP60Z5OkCroeVnj1
         ZkzOxSPm3BjBmO1F+44RrnhWUxTnNaQO6eJtTE50II8NhLt7AJFcSAo6ZH6JxMKoY2XD
         Bcog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IdNR59WezmY/S1vU44tZFsNl6tV/0+tV3u+2b0KC1qg=;
        fh=6Z4J3xNs+qgwS2aK097++l2x6CIWkNCmJIKZe8W3oU4=;
        b=nWowxXyAcP6YLsuYKye+ABDC8RDinDDvbQET22j63ystHkK88NkmBvgSmLgoRMh1M1
         8A3/OuALpWvuXicYfnQl0LkJES2Qi7S3ObPIJ2++d1LKrSAkKF8JSka9/Mln06mLmN2o
         txEAdbAoGBM0ZFxYCEpiFLm4cuvq7Npee9TZIbHNaTXEzWV4oN41ULbwI1HaVnt1Dry6
         GWkuJR7FhbGOGm55m8WGV8DmjunxOjmA7CuHh+vWHqnWGcG3VXDj1CwH1V4UfdKGfq4f
         GYAl56CYFSAZRcwSzYteSecs6swxfChJst4lWW0daBnBUKR/s8KignKUpUYD2EjEOIXI
         scEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785265920; x=1785870720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IdNR59WezmY/S1vU44tZFsNl6tV/0+tV3u+2b0KC1qg=;
        b=OyY00hzd7igN2J/hLeA3FWWArhpNKZjUj0C03RmsHWw58Ecl5DBPwJ/BqOJCTgHqxM
         wVvU0CPa6eHBkg+0Hf/b3buF1ynH/c0v7jhf2svrR7voUJhMWnW1O9m9Anp2Rqz/Bo/T
         BCsvYBRSe+IXaAs/0sHb3h+leIwcvsst3ndTXg9gEcAZeZKi3Y1P4g191gXPvTZQlwz0
         XSbXvvxycxkep6njhF/7MuHT746inGXhqOc4Wq8WwwotzaGFLgYCWRH9kW/noU43jppR
         DDpqmBvu7TchVZGKRNNMapYGyMHtCbfjvxE7n4pyCxNX7Z3c13bp0GlIHknVYogVFqZD
         FOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785265920; x=1785870720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IdNR59WezmY/S1vU44tZFsNl6tV/0+tV3u+2b0KC1qg=;
        b=Pc6NhMqxCyooeMo6MPstdiSOtvAm/1L5//Q2Wg3DM6AShyb9RHRTPM8hKSRaCphrGy
         ibq5BvsNQRQME6QXMKeLnNuurH7mNKeWrqR6TiMOu/cmL9boT5nv/cOgYys2tumOpl1q
         DSgijMCLKcMBbaxHFs6wWYvp9MQ+vAOeCUNkMGiMYs2FD/CYBdxae/BvSK9Aj0uUsf7s
         wzi714TRBaqAYHAjk4YwA+oXzHnLaFMi97jrXbTmJ8ARULoLbFWqGofpmxq6+1nfqOuc
         zZJeSihAkY2I67ucshNvnHoQNi5fVONirN700+gibVVbu2fqjwtEitHkuNvfhBPmLsFm
         yNVg==
X-Gm-Message-State: AOJu0Yzw/qkVsyXRY3X0d/dKx71hpkZWalakj6EbZ3ihtEfRznbjU30q
	36jNFJTOGQOFY76d6GzTUYKrncsc91F3wmkO5SUbHm6Uv20SkfX1lSYRsRRCj9lYLH/pkyutrR+
	6QYz+azFSEYrRt155M4kZrYoYHU2P1dE=
X-Gm-Gg: AR+sD11ent31u9IKaTB4rhg6wLqKvbvnsHENGMCSW/LMUpYWALxiORGMRNrqiuJ5SsL
	Ihiin7LkKdBn8uQL+Mju1ELDMRCcE/IZODg8bwTfRV5582DIYdzVLivZ2Clxx9Iowwb80cqw5Xj
	15saKLPpNX3UFlhw8l4P5eSbcVq4PnNZ2/tIoaUjRvmt+UnfvtalnoQT6bWkwXOwjv3FGf5fpGU
	ssy8UGS9vj6qfFMRX7c91HduomrDdO9v+wzoWd0zPRkZXqTTGduh9sXxIYCLw==
X-Received: by 2002:a05:690c:7308:b0:81f:653a:dc25 with SMTP id
 00721157ae682-81f9932eaa3mr15654827b3.49.1785265920592; Tue, 28 Jul 2026
 12:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724190813.1458271-1-ameryhung@gmail.com> <20260724190813.1458271-9-ameryhung@gmail.com>
 <e792057b4f2f8a64aab844ff391c381924933546.camel@gmail.com>
In-Reply-To: <e792057b4f2f8a64aab844ff391c381924933546.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 28 Jul 2026 12:11:48 -0700
X-Gm-Features: AUfX_my9Ee88pJOojM6SZHsEoBHNtzMiGCrK3vHTtUns5HpTJ_7k7SgZ1PpGPzI
Message-ID: <CAMB2axP2E8ArguRHJg40foHoMctOedruLnB+VFKpEbyJzVqLxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/18] bpf: Express ARG_CONST_SIZE_OR_ZERO as
 ARG_CONST_SIZE | SCALAR_MAYBE_ZERO
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:
> > Add SCALAR_MAYBE_ZERO as an alias of PTR_MAYBE_NULL for scalar size
> > arguments, and define ARG_CONST_SIZE_OR_ZERO as ARG_CONST_SIZE |
> > SCALAR_MAYBE_ZERO instead of a distinct base type. This lets
> > check_func_arg() handle both with a single ARG_CONST_SIZE case, and the
> > redundant compatible_reg_types[] entry is dropped.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  include/linux/bpf.h   |  4 +++-
> >  kernel/bpf/verifier.c | 12 ++----------
> >  2 files changed, 5 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index e066f44a9c05..1d537ec557ec 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -748,6 +748,7 @@ extern const struct bpf_map_ops bpf_map_offload_ops=
;
> >  enum bpf_type_flag {
> >       /* PTR may be NULL. */
> >       PTR_MAYBE_NULL          =3D BIT(0 + BPF_BASE_TYPE_BITS),
> > +     SCALAR_MAYBE_ZERO       =3D PTR_MAYBE_NULL,
>
> I'd suggest to avoid adding aliases, this might be error-prone moving
> forward. Is this change crucial for the entire kfunc/helper merge?
> Does not seem to win much on it's own.

Ack. I will drop it.

>
> ...
