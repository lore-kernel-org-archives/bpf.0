Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BFC3451AA
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785708628; cv=pass; b=VuAZq0/q9bQWmt48P9AuKeOaiYz9PhlgQyoqv4qQxUFEZyJEht4xGWJmCpNIqguVqDvV/wL//xF1bc34PqrL0hDyDjdqxaExsC3ZCs64mwKKoj7K2Bf22xHwim+gsOolFWkbsdyCYVq/95DVKAfoZ91msEQQAZyPAgn66rwElfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785708628; c=relaxed/simple;
	bh=eRFtgMKw1bXZ8HlsKfgvbOPiqlVoMRsIBxoFY7IYE2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ru/GctDeowAV1a8kfESgQh5e00CsuJOtmqISa+Sq1RiqBMtdyQoqtic8f4g7AmhaSl5t86uuG4255DDV2pH3Kc0eEC57DGNuJdoQLImrOV61RvksJg3eKjjjp9XjrodThOQyFSaaSEC6sOPVHxm/SIE8Kx1b1pF9j3mvrnM9MD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm67dw9O; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm67dw9O"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8143daf89c7so25271967b3.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 15:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785708626; cv=none;
        d=google.com; s=arc-20260327;
        b=L5/Yk9M6NbujvnPqJRQPDe/Y4zvpR4rcJP0QgWhZjtM5F0ZM/Aw2JXl7GjNSt07/1w
         k83TKmklhvCgOJCzdDFilb+4LjQLIFmRlcMLmdVTgmr/nB8z1MK4SxfthFol8nPA3XuQ
         Y4X5yJntMhOrL3F43n9aPARDIxvb6MzKL+KxD2U0CKtvuCghemnaaq197R0qAJpXDBFM
         b52KjhClz4gZcMyUDkDKgAXZGwP/nuMVfib89EzUSCaAfNuXagiW+n62DeDQ5TAS1OIu
         6zr/+EMcaV08N3wifSSguEMQ1Cb48Ey5ZrsGX5N7Gq4LXt7BiFm0OtdjOFhqAO3cRYeT
         w3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HMbJsCNToR/i0i6p/qewgiU8kiE/Udu1Ph+qBECWycA=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=h75JF11I3n2Jx3++rtAydVFhMLHardv2l9C5JiQO8Sn5E1Bm417e12LWDcjw3qRWAQ
         QkB9ILYQPphwXPstj+6lbKUjpUclYq8luw+aL0tPMk/msyzluuDUAW3aClBlhOY/5jgs
         OMDQRudhUMqk7jsCsEgoqHoR2c8+dSRpNnR0DxPmssekHPzNoTNV/H0A3IYGjarWFjjN
         kB2/fZXBM5iVwF6YpKGkZBMErJf91sgE4Tsj7wD5RTsc/7XUK89xQuBsGWAKp6SYmPPQ
         LBIlurNOYdWjWhK7mezVwzeM0CD+TKZJlBwY4VcsiG5x4wjQR7F6Wt1dbPTHm83D7Zjo
         cXcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785708626; x=1786313426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HMbJsCNToR/i0i6p/qewgiU8kiE/Udu1Ph+qBECWycA=;
        b=Fm67dw9OL35WfLAG7hUeuetlQYifeFekL/gbCd62AIKuVZzyaMBkq0CgoaVhjLVYKq
         3iuJB5+SnInVIIjlnNqH5vNHK6q2k/knghhUKnDFh9/bFtkXaX/7pGoI5sG7exGRfJ6G
         AgBZP+VCwWZytx4S6Y9F0Tm7mgTT2inU0nmueAPSApIAnkZJGogbLB6v+yc5S+Rp7ySJ
         U6Zfcj8VaC13F32yqZktJEAV3GINczTezN+WvN6mUBL+CZY06hSRFSKTxQ8Ut3zFkmQU
         HYpsGAoWws0Fl0ktPYg8seuMidBcA0QQBy19PbHyF9Bqapq0/3zfgP3K9Nlhk1YFdWog
         2YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785708626; x=1786313426;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HMbJsCNToR/i0i6p/qewgiU8kiE/Udu1Ph+qBECWycA=;
        b=GrE62AGUEix3/0oD2kEUV76hDHKCsUQuT9CNd26NJUZineqUB7fcYV/mNxnkHS4rwp
         9ysKT2nEQmM/YzDKsIEhXJoamiCCHoXotx8eevV9NsLnww+/n+GOjO7Ucq69dHQTzv5c
         lQcqtpIQ2OvQW/g4CjCE1Odum/+9Bdc2914oIlbJl9VFETL7z2SjSrp5zyBiyBIPRpnx
         +qe0pHS2wN1XRWubgdW1DDuivpIMNsih7pqMsZMdU4TRMSGxGetZ4cExOlLKqxwnMgN1
         qbB9VtQqPzhCvblzw6Qp9DmsytUCDNFVWi90BzfcpB0wHS5SeS1QKpetyYaC4Mlp2OSu
         eUYQ==
X-Gm-Message-State: AOJu0YzlXLsXuaS9n7SLxOtTe7DfzDknXO6FXlDjjMYUfhxtf7e61LWO
	CAOGtZoVeLkCyqTWK+DqAzW3NhmeUBxMtKCAnO6WrEdi087HwH+L/k1ud5wDXHHTqhaRmOdTque
	HpIWZCnfoznk1kwkBmu6NLtIISjqMONexQ7eH
X-Gm-Gg: AR+sD11n14MaWAdxMi6crcucpvejeliBX952mDqICqm5zvekXqcRHnSbGUxWhAXI4vU
	NACTt2OFGrMyEs+0xU5jo7ljhOTOVvmfG9R0mBEpwusgw+mhnbzw+30fxdkzamzE+IH0aOQAg9J
	qex/bfzaVGXCdB9heoZIZonBlrTwPHr8prcwmxX3T9YcL5kXffz4djd1+U/y/E9P/UUgMhyywnH
	ETlxYhumuVzvSKIuIyT73i3jznxXf5qV7yzdAZFFKQvBB7C8BS+NnCmeI/yvhpGvHz7JH0Cf4lf
	SgCcjDiusEa4dzGd2SWkFb1Gh6AkM2KGdxJ5o2GwuLua
X-Received: by 2002:a05:690c:2789:b0:81f:653a:fb41 with SMTP id
 00721157ae682-81fd4a21645mr111501377b3.10.1785708625995; Sun, 02 Aug 2026
 15:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801074633.1595644-1-ameryhung@gmail.com> <20260801074633.1595644-9-ameryhung@gmail.com>
 <20260801081721.132401F00AC4@smtp.kernel.org>
In-Reply-To: <20260801081721.132401F00AC4@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 2 Aug 2026 15:10:13 -0700
X-Gm-Features: AUfX_mzVImaE8JC5A3oWIPJkUofdwX7NRxxR6LIPEWhmJ9KnoyJHqX6SEXaktl4
Message-ID: <CAMB2axNktmWPs80p9Xw72Rr-Mexdbd6O5HfMXhgByVwscNW6sA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 08/18] bpf: Check fixed-size mem args of
 helpers and kfuncs the same way
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 1:17=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Kfuncs taking uninitialized memory arguments via the `__uninit` =
annotation are falsely rejected when passed uninitialized stack slots.
>
> Pre-existing issues:
> - [Critical] The verifier fails to check if the size argument for `KF_ARG=
_PTR_TO_MEM_SIZE` kfuncs is a scalar, allowing BPF programs to pass kernel =
pointers as size arguments, leading to an out-of-bounds access.
> --
>
> --- Patch [8]: [PATCH bpf-next v3 08/18] bpf: Check fixed-size mem args o=
f helpers and kfuncs the same way ---
> commit bcee13ba62b78a9328164e2486f3c31a7fddb8a0
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Check fixed-size mem args of helpers and kfuncs the same way
>
> Fixed-size memory arguments went through two paths: helpers called
> check_helper_mem_access() directly, while kfuncs and global subprogs
> used check_mem_reg(). Route the helper MEM_FIXED_SIZE case through
> check_mem_reg() too so all three share the same check.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f61771e2a8b27..9e0c7f0a15c15 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -12379,7 +12385,7 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_call_arg_me
> >                                       ref_tname, PTR_ERR(resolve_ret));
> >                               return -EINVAL;
> >                       }
> > -                     ret =3D check_mem_reg(env, reg, argno, type_size,=
 meta);
> > +                     ret =3D check_mem_reg(env, reg, argno, type_size,=
 BPF_READ | BPF_WRITE, meta);
>
> [Severity: High]
> Does this change break BPF programs that pass uninitialized stack slots t=
o
> kfuncs using the __uninit annotation?
>
> Because check_mem_reg() is now unconditionally called with
> BPF_READ | BPF_WRITE here, it seems to mandate initialization for __unini=
t
> kfunc arguments as well, which should only require BPF_WRITE.

First of all, this is not a change introduced by this patch. kfunc
already calls check_helper_mem_access() with BPF_READ and then
BPF_WRITE.

This is also not an issue unless a a new unpreviledged kfunc that
takes __uninit arg is introduced. There are two kinds of existing
kfuncs with __uninit arg: bpf_dynptr_from_xxx() and
scx_bpf_cid_topo(). The former, while being unpreviledged kfuncs,
checks their __uninit dynptr argument through process_dynptr_func(),
which directly calls check_mem_access() to simulate byte-by-byte
write. The later is a previledged kfunc, which means
check_stack_range_initialized() will see env->allow_uninit_stack =3D
true and allow reading uninit stack slot on BPF_READ and then mark the
stack slot as STACK_MISC on BPF_WRITE.


>
> >                       if (ret < 0)
> >                               return ret;
> >                       break;
> >               case KF_ARG_PTR_TO_MEM_SIZE:
> >               {
> >                       struct bpf_reg_state *buff_reg =3D reg;
> >                       const struct btf_param *buff_arg =3D &args[i];
> >                       struct bpf_reg_state *size_reg =3D get_func_arg_r=
eg(caller, regs, i + 1);
> >                       const struct btf_param *size_arg =3D &args[i + 1]=
;
> >                       argno_t next_argno =3D argno_from_arg(i + 2);
> >
> >                       if (!bpf_register_is_null(buff_reg) || !is_kfunc_=
arg_nullable(meta->btf, buff_arg)) {
> >                               ret =3D check_mem_size_reg(env, buff_reg,=
 size_reg, argno, next_argno,
> >                                                        BPF_READ | BPF_W=
RITE, true, meta);
> >                               if (ret < 0) {
> [ ... ]
> >                       }
> >
> >                       /* Skip next '__sz' or '__szk' argument */
> >                       i++;
> >                       break;
>
> [Severity: Critical]
> This isn't a bug introduced by this patch, but does the verifier fail to
> enforce that the size argument is a scalar for KF_ARG_PTR_TO_MEM_SIZE?

Not a pre-existing bug. Currently get_kfunc_ptr_arg_type() does
mandate the register passed to __sz or __szk args to be scalar.

>
> The loop uses i++ to skip the next iteration, which completely bypasses t=
he
> btf_type_is_scalar validation for the size argument. check_mem_size_reg()
> also assumes the register is a SCALAR_VALUE without verifying it.
>
> If a BPF program passes a pointer register (like PTR_TO_STACK with a zero
> offset) as the size argument, reg_umax evaluates to 0, which passes the
> verifier's size checks. At runtime, the full kernel pointer address could=
 be
> used as the size, potentially allowing an out-of-bounds memory access.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801074633.15=
95644-1-ameryhung@gmail.com?part=3D8
