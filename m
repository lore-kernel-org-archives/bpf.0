Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0572D738F
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 02:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097440; cv=pass; b=d4mG1Yf043tBtsxbiyZpNbLlogA4mbxoDBZ3wixj170CwASSBQ/wEkxw8EIlUUk1UN73XiLiRIk+t7SkKuWO3TckChp5CwCxKkA2i1BP3wyNJGk2OMdiVVwiv7IpqGSJbXdM4IYLokOkXOEAisPU8kjTiIuEFfuG4EHtgMt9VEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097440; c=relaxed/simple;
	bh=E3aq4MIVImagcCUpa8436TXWFR4wLQ2P2TDB9Mbl4wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqeuMi5jA+FWz43ruMQLVgHGigRr8/cD2NC5BGJ55R7S6TLLfe2e/R6a+2tLgwSbbBw8b9RKuxT/dUq3gL8eNVQ8XFQNXeDP+u96CtoOdcgDknGlcOWnBsCnfFymfwxdn14oL9nz1vVuDCs/kLYXXlObcOGRG3+re0SRzi9N8s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rTvj5m/B; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTvj5m/B"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79ea87af213so23625647b3.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 19:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775097438; cv=none;
        d=google.com; s=arc-20240605;
        b=LjB7xApnuQ5qAcuN3NpjlhUmPvxlHAQacH2c7pimV2W+rKvXsrAvjucdS/y46dTeUh
         wh39KrcoP2UjyQ7lg2vykF7VHlyiuELDr0lphW1W+wHJ/w7fVWffPZr7uhHtCXQhvCuL
         91q5OytAYaN2n38AKm17NJHsodvSn485BD5vnD/1xiX1lyEARuRzPKnPQUuWHBrBpEVM
         UTCcFBiYfAn7Ss4DslsyJaIjIuiJmK/7jdhNfI0VFE2UBkcfcmAWGL30Onaauc72Fc5o
         C0chDlLHYx2LIcuFEhRRxD16bBO9u4mjBAeIDEyVxVbT4rilDIsjzVA/3TG7pw1TM19P
         Nb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qw7/+XgL7PQ477JBnRJZulwsXjBg/Kr6yDssBa0ri9s=;
        fh=TZrgQJMM7lKIP4b1ILlKoebHT6uUxf/8PZOvkykdOEQ=;
        b=hZXX3w0cmhqZthhjF1UAmHE1jt+OCTTvp77Azxw6Q33pBDGTyv+UY1IGBdesamXX9G
         6IQTeIIGlsUKvBG52lbWniwQw1X8Jzoxjd+kwGxcZd8fMYux451oDQUPEMisfhWZgrsR
         7urBRgMEFtywITn9LzC4aw6VSYXxogqtWxvUeWy5nspk5ISEE2Iy2N0/1WMPg4vUoSVl
         calpcULf70ID5KCZK/vxPzkN/Jba8pXrDZ/WQM+Tej+vZr2xHAYMZ7TT4yisJDpIzLoc
         sj9soK3XAeIGubT3w0FLlpfMddu+he3W7KlKbViCPl3u1HvyPxKIaUim+fG3fZerwFuC
         E3GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775097438; x=1775702238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw7/+XgL7PQ477JBnRJZulwsXjBg/Kr6yDssBa0ri9s=;
        b=rTvj5m/BajIr99uBd9XFljsXix7bjbBB6glq9bxe6lKeDUlpxnSip+N/yAHx/IE7L4
         Q7Ts4hUaCJQ3qsJrVIBJG2AutdgPMKxUsvqK3opJPvuFYvhCFWwlqEaf+11lQBbZDw5g
         hD7iF/V9pq1snoEppAmYFbGWswr27wE3DjKhh5Tx9IGaVnTO1jHaG47OXQM+g9EohUu0
         nn6D1+LS8ZM3TEUh02ESEHvWlmTZKlBpOhJaFm/jsXz2DDCNwoFNsNImNab6hB7WjrYo
         mKUOzA9OOrubNt60tOW0ngg+ia8D7PUsBdVwFGRxGrb5uFKqzDqKtrNNNYXIhwm3qxXx
         7tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775097438; x=1775702238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qw7/+XgL7PQ477JBnRJZulwsXjBg/Kr6yDssBa0ri9s=;
        b=VxlrWs1er79yLwNMZUmw/GKT67g6uncagku4kWcmB3ek+3soNctbEZVtx1fGW+o+e0
         SraDwzPo8LhApjnOe2Qy3AQtDHvQQDnqUAw5gqV6yhqDouXClpLf2SxYgdyMxs9XawVI
         ptRzMdPotcE0Am7M9wwcpeuEfkfOMREmgISoiaZbUjsV2S5U4lhcBXzPvbfdYEPLkwhA
         I6Vo5TYZacpdYyuLcE2JBPaG3ArbfZXVc6qD554MLrv4G9xK4PYCMUgKq/z28ibOYcE8
         8xM2j+GmBfUoxdM6MOzZ4IPO9FJaectOA3Wl5Fy1WtgDoIIkrpBMdIkU+JWbTX5+vlDj
         D3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpGKa0MfqvGIbaHdaVcgVuLEZlo57YHQdEeF5QrKzLy9lJp6yg9eFKX2FfNOkDlRuKqhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8dUpzDvnOhu6m1p5atRBwpyNaApg8fY6nwR1v4/Y5tNvW8Yym
	u1b+BuLVAa88SUnlVhwmjDE2NaHenqTZJJszfBScOONnPdD6j+9OMtbBPtXUvjb/QNQ3yr0/baD
	6H8Is3KkJhrbLteO8J73xLzdCzH0Riqw=
X-Gm-Gg: AeBDieuYcj6f7oXZQvecKADcoMr1Q2CzJweEoGXtWMvLy0J7/zqrRaAOADpPnlV5SQp
	bIUa5FY3R3hLxbX2n1TJsiw9dcCdf4qe7RBa3uu9W175J+bAvBtnW1E/9WrvZ0T+KwqJylLRxRr
	nxXCS8FN9a8d5iIVQuBcgwkNDlNUt7ei/e9b3a+WR0z1lRyvUu4f9ZpD4SRWHaLxjjFNEKbvXMi
	zmdXG04aLkliTZtJ5ab043geBEerDi/C98fcEVdnl33H3PNxKT8E5laKm3dQRtXbgD3T46WWLSP
	ATNP7t7wdLJn3Wo81bfaRXSsfrj8ZHCQXFnIdEsffddW4mRCRxQAkkMlYfE=
X-Received: by 2002:a05:690c:87:b0:794:c2fc:73b1 with SMTP id
 00721157ae682-7a3bb916453mr5671407b3.2.1775097438132; Wed, 01 Apr 2026
 19:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401161529.681755-1-a.s.protopopov@gmail.com>
 <20260401161529.681755-2-a.s.protopopov@gmail.com> <823cfd94-a35d-4f99-afa3-238fb1e9862d@gmail.com>
In-Reply-To: <823cfd94-a35d-4f99-afa3-238fb1e9862d@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 2 Apr 2026 10:37:08 +0800
X-Gm-Features: AQROBzCJHnH29qb2JQ8-NllTp5V_PM-9hiPCW-u56_I0DnByztAvKaTXz4GljAs
Message-ID: <CABFUUZFZf5nUoQr7v-fp5k+Ef+q-XtzxVcsbYMfS-zsk2zdRbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Do not ignore offsets for loads from insn_arrays
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiyong Yang <ksur673@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 6:47=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 4/1/26 5:15 PM, Anton Protopopov wrote:
> > When a pointer to PTR_TO_INSN is dereferenced it is possible to
> > specify an offset inside the load instruction. This is a bug,
> > because while the verifier ignores the field, JITs are not.
> > So, patch the verifier to not ignore this field.
> >
> > Reported-by: Jiyong Yang <ksur673@gmail.com>
> > Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >   kernel/bpf/verifier.c | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8c1cf2eb6cbb..f1b1c8e9dc26 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -212,6 +212,8 @@ static int ref_set_non_owning(struct bpf_verifier_e=
nv *env,
> >   static bool is_trusted_reg(const struct bpf_reg_state *reg);
> >   static inline bool in_sleepable_context(struct bpf_verifier_env *env)=
;
> >   static const char *non_sleepable_context_description(struct bpf_verif=
ier_env *env);
> > +static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct=
 bpf_reg_state *src_reg);
> > +static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct b=
pf_reg_state *src_reg);
> >
> >   static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
> >   {
> > @@ -7735,6 +7737,20 @@ static bool get_func_retval_range(struct bpf_pro=
g *prog,
> >       return false;
> >   }
> >
> > +static inline void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s6=
4 val)
>
> Why does it need to be manually inlined?
> Other than that the change looks good, the implementation of the
> add_scalar_to_reg() is similar to a piece of code in sync_linked_regs().
Agreed.

nit: maybe this helper could be called from sync_linked_regs() too?
>
> > +{
> > +     struct bpf_reg_state fake_reg;
> > +
> > +     fake_reg.type =3D SCALAR_VALUE;
> > +     __mark_reg_known(&fake_reg, val);
> > +
> > +     scalar32_min_max_add(dst_reg, &fake_reg);
> > +     scalar_min_max_add(dst_reg, &fake_reg);
> > +     dst_reg->var_off =3D tnum_add(dst_reg->var_off, fake_reg.var_off)=
;
> > +
> > +     reg_bounds_sync(dst_reg);
> > +}

> > +
> >   /* check whether memory at (regno + off) is accessible for t =3D (rea=
d | write)
> >    * if t=3D=3Dwrite, value_regno is a register which value is stored i=
nto memory
> >    * if t=3D=3Dread, value_regno is a register which will receive the v=
alue from memory
> > @@ -7816,6 +7832,7 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32 regn
> >                                       return -EACCES;
> >                               }
> >                               copy_register_state(&regs[value_regno], r=
eg);
> > +                             add_scalar_to_reg(&regs[value_regno], off=
);
> >                               regs[value_regno].type =3D PTR_TO_INSN;
> >                       } else {
> >                               mark_reg_unknown(env, regs, value_regno);
>
>
