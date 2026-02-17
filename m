Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517C929B8E8
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354695; cv=pass; b=fN1c9wziJ5Tcw2Omb4wD8m3ALWsJp3c93iPhz3V8yY+PPz2ounOF5fwffadDkH9PBE0ZynBgBnQgkPVoHZ9btB6q9GYFpZrmKUoVu8GNhH3WoYQR4k4cY7Y1WqSgnNfbugQhKk27E2ApUHvWQG466cR1uwfP2FJxUc3v7LcYAuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354695; c=relaxed/simple;
	bh=M5Ys+PO3/tJZ8/pE+ALfDEHv+EVJMT4UwYxEyrQUYA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxB13MPRoS5kJsaB7CmkiGcbIOCSUYVj6MSR2zSY1RlEOpM+q3ej8qgsb7rHvVt272NaC/z9erOvfMeq35EyRUWT9lBk9TjfIVN5uzyalyoAxkk9wlIgoFcXSgOuTxjZlD34GVSpt7Wtoa/ZmRS2swQTfE0+UB6Kx9jmmpvehJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPb5J4Pu; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPb5J4Pu"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4362197d174so3042983f8f.3
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 10:58:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771354693; cv=none;
        d=google.com; s=arc-20240605;
        b=HobK2HfQhwRy8+KzTlhQ5mhnec9nptlFwzpw0qeDGWttMAQMdPgmEQpu0QwphwZUd2
         doNCriTrt6tOJoMCVCX6uJjCau8LwbLK7XQkWLrvduSEudED8q0pD1lFrEa+1i0psWIM
         hq8DfgmltlrEtYcjfMgm2jXwhFZrfH9lRA+yiJFVAQaeQw6ZMXy0FYM7HcOeP2wkMKBE
         J8wrjPuIrM4yFMBlKuoDWv5qBvD0xWcL/JUoFLrl9QqRIgq3NpCZOhhKzFvjGwj/pydc
         oZwko7WDkDdK6ju2ogTfBw2sIExZ40J1dE+yd8THUjmKaW3a8MLYwwEyI6eJKi30t+Md
         5vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uHkmiz5Su/OEfdd8CZ6a29UKN8Fnr0S/oBpsWCKhn+U=;
        fh=extpnKZ1pg1ygBwBVETna2nBc+9ThSvzGGNpUDi6fKI=;
        b=PJEYLLE+lr1BjogBR+ZLvnURAgUgqh731+NzeCTqg9+LJjTHbaJN4BF+m8ZkQ5UwMM
         6WBE/t3eLXUpjjxukS284lu0/fayovYnLSLUlerGZIfCE8KO9fd6mZx224iZpggmPXzp
         u8jobyBz2Ml9ukpzRHjihB/xAsY3bj1wAawr+RgJTFvtO8zJwVTFx+O8GqJrhAZRDchh
         FCf9JNcWOolvTtDrX0DuzqQwTgDL7XgPdIcDuGeCfvDWjltNhWhaEYMidMMB2/CozKUn
         EXZO/di+HMOXKhzf3Ja3TS0SRv7HuZ+NBUU7yizbv2ZT9qTTK/nX2jDhWkFUQYvEhNqH
         eT/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771354693; x=1771959493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHkmiz5Su/OEfdd8CZ6a29UKN8Fnr0S/oBpsWCKhn+U=;
        b=PPb5J4PuXhLEioIrsMIYd6sxRNJIsjouOilUDodX016CbD5BIVOR8a/enVQ1fxLY0C
         IkS5YeGIcPDW0C06Yb19SoytFLzUXBHQe5P234yynnoqEp2ZjGj1BBMaHRvQp3IrbtTp
         6M/Axq0uEbkBojbkOK8k0okQgyhB5/UQsMCHFPK2EHJpZS/YmPsEGaKGV2bzHR3kNKHl
         SU6yhTBIpiDQeqxxfILYwVAvjLmlGMbrKLJgJUqjIyR7L+/jd5VDrXPmSYu/4ERBDYlm
         /7NZK+SOaYPhZBT/p2zS+ED+sdmVeNAcl/XhPfSArzwmsIUjrWdEKyTPMTK6mdo8HzeB
         j6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771354693; x=1771959493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHkmiz5Su/OEfdd8CZ6a29UKN8Fnr0S/oBpsWCKhn+U=;
        b=aDfZ9Q2y2O3ktywNUEiTW4COfltf8dw7FdN5jJk2pv0iyxQYbSdQwaAd4isnnsC3jR
         6ItKWfuXJEOmQ/8wU4Ac4aHRFSbzRbhHqCVSaGtG5H8jfXJ0L3zlU5kSjqt3/xor8/yP
         nlI1mHlA+tlcipKrTK80X1Im8AFRgl7HgK1Q1aeDy6kXuX2mSMavWCCTibM6CqrspXZa
         Mk+tQbw4cprc8vSsxWBwiPL33B5S8q+QGuGZ14v7ylhZqWI2ISndlIoj+dSVCu8ueHXx
         CK92B0mPbs9RmMYz7wvwRtTXzKQk4n4b74Af6XUglq4ux+YJLH/XCmaeeSOvxTvqpV8c
         3zeQ==
X-Gm-Message-State: AOJu0YzRWasN23mvqA32nQHoHaV/onDuRaHgcBWUME6wsqCwHozjQgYt
	aDiHzVAtfqYgHU0lHtUD4cb8JEr51sK2utyj7XZD0lSJyxmrUfol91tDavfca73B+nsSu0e+KN6
	3psjLV9vUuJHX39DtSJC2HKD/pacx06g=
X-Gm-Gg: AZuq6aI7ZjWXNcwxVGjyVr49qMAGCwcTAd8HbOCQ0avw0PtKldEEkCcALLQdqo1ZiGl
	E6PixbjufsanCALOGAwPtNE7dgBZC3Isvcqov6NawvGRWYwR+lrShNLcoSNEfp3A1DnH7Y/Veww
	TLJBzLBUPggJAYS2FYz2kC2nPbr7YctJzNyAqB0rQVap3jrEy1/zv0bSlBIm+PFi6heKNcXczTg
	KpvEA8tFpGJ9yXOtaKRMfIOJa2s+BXXfj9KPMbeex+CK2d3p3xAMkaugDCCdPHNEuhXTZDPqQoU
	kWpKBelStzh9Z5HYnRQDRDYsR6FInl+mgs9nGAYYBDZ06CtYcjvTTFu+heZywqT1nLcsRDtaoso
	Jk3lb
X-Received: by 2002:a05:6000:1863:b0:437:893f:3361 with SMTP id
 ffacd0b85a97d-437978cd4c3mr26515828f8f.20.1771354692216; Tue, 17 Feb 2026
 10:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771316309.git.paul.chaignon@gmail.com> <5299e75f8807c7c49ec048e821f25a6dfef2c6cc.1771316309.git.paul.chaignon@gmail.com>
In-Reply-To: <5299e75f8807c7c49ec048e821f25a6dfef2c6cc.1771316309.git.paul.chaignon@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Feb 2026 10:58:01 -0800
X-Gm-Features: AaiRm503-7WL70NCEcadG_6MJOimcR6ozh3PZ0SJxce8xaagwN7aAHPVCk-GUzE
Message-ID: <CAADnVQ+yXOJejFAPHyezd8u-8SizSHUN5kU5HAj=KDrfbj2Zdg@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] bpf: Improve bounds when tnum has a single
 possible value
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 1:01=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> We're hitting an invariant violation in Cilium that sometimes leads to
> BPF programs being rejected and Cilium failing to start [1]. The
> following extract from verifier logs shows what's happening:
>
>   from 201 to 236: R1=3D0 R6=3Dctx() R7=3D1 R9=3Dscalar(smin=3Dumin=3Dsmi=
n32=3Dumin32=3D3584,smax=3Dumax=3Dsmax32=3Dumax32=3D3840,var_off=3D(0xe00; =
0x100)) R10=3Dfp0
>   236: R1=3D0 R6=3Dctx() R7=3D1 R9=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=
=3D3584,smax=3Dumax=3Dsmax32=3Dumax32=3D3840,var_off=3D(0xe00; 0x100)) R10=
=3Dfp0
>   ; if (magic =3D=3D MARK_MAGIC_HOST || magic =3D=3D MARK_MAGIC_OVERLAY |=
| magic =3D=3D MARK_MAGIC_ENCRYPT) @ bpf_host.c:1337
>   236: (16) if w9 =3D=3D 0xe00 goto pc+45   ; R9=3Dscalar(smin=3Dumin=3Ds=
min32=3Dumin32=3D3585,smax=3Dumax=3Dsmax32=3Dumax32=3D3840,var_off=3D(0xe00=
; 0x100))
>   237: (16) if w9 =3D=3D 0xf00 goto pc+1
>   verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds viola=
tion u64=3D[0xe01, 0xe00] s64=3D[0xe01, 0xe00] u32=3D[0xe01, 0xe00] s32=3D[=
0xe01, 0xe00] var_off=3D(0xe00, 0x0)
>
> We reach instruction 236 with two possible values for R9, 0xe00 and
> 0xf00. This is perfectly reflected in the tnum, but of course the ranges
> are less accurate and cover [0xe00; 0xf00]. Taking the fallthrough path
> at instruction 236 allows the verifier to reduce the range to
> [0xe01; 0xf00]. The tnum is however not updated.
>
> With these ranges, at instruction 237, the verifier is not able to
> deduce that R9 is always equal to 0xf00. Hence the fallthrough pass is
> explored first, the verifier refines the bounds using the assumption
> that R9 !=3D 0xf00, and ends up with an invariant violation.
>
> This pattern of impossible branch + bounds refinement is common to all
> invariant violations seen so far. The long-term solution is likely to
> rely on the refinement + invariant violation check to detect dead
> branches, as started by Eduard. To fix the current issue, we need
> something with less refactoring that we can backport.
>
> This patch uses the tnum_step helper introduced in the previous patch to
> detect the above situation. In particular, three cases are now detected
> in the bounds refinement:
>
> 1. The u64 range and the tnum only overlap in umin.
>    u64:  ---[xxxxxx]-----
>    tnum: --xx----------x-
>
> 2. The u64 range and the tnum only overlap in the maximum value
>    represented by the tnum, called tmax.
>    u64:  ---[xxxxxx]-----
>    tnum: xx-----x--------
>
> 3. The u64 range and the tnum only overlap
>    u64:  ---[xxxxxx]-----
>    tnum: xx----x-------x-
>
> To detect these three cases, we call tnum_step(tnum, umin), which
> returns the largest member of the tnum greater than umin, called
> tnum_next here. We're in case (1) if umin uis part of the tnum and
> tnum_next is greater than umax. We're in case (2) if umin is not part of
> the tnum and tnum_next is equal to tmax. Finally, we're in case (3) if
> tnum_next is inferior or equal to umax AND calling tnum_step a second
> time gives us a value past umax.
>
> This change implements these three cases. With it, the above bytecode
> looks as follows:
>
>   0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
>   1: (47) r0 |=3D 3584                    ; R0=3Dscalar(smin=3D0x80000000=
00000e00,umin=3Dumin32=3D3584,smin32=3D0x80000e00,var_off=3D(0xe00; 0xfffff=
ffffffff1ff))
>   2: (57) r0 &=3D 3840                    ; R0=3Dscalar(smin=3Dumin=3Dsmi=
n32=3Dumin32=3D3584,smax=3Dumax=3Dsmax32=3Dumax32=3D3840,var_off=3D(0xe00; =
0x100))
>   3: (15) if r0 =3D=3D 0xe00 goto pc+2      ; R0=3D3840
>   4: (15) if r0 =3D=3D 0xf00 goto pc+1
>   4: R0=3D3840
>   6: (95) exit
>
> In addition to the new selftests, this change was also verified with
> Agni [3]. For the record, the raw SMT is available at [4]. The property
> it verifies is that: If a concrete value x is contained in all input
> abstract values, after __update_reg_bounds, it will continue to be
> contained in all output abstract values.
>
> Link: https://github.com/cilium/cilium/issues/44216 [1]
> Link: https://pchaigno.github.io/test-verifier-complexity.html [2]
> Link: https://github.com/bpfverif/agni [3]
> Link: https://pastebin.com/raw/9BJAi6Rw [4]
> Co-developed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail=
.com>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  kernel/bpf/verifier.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index dbaafb64d3bd..c4478c874616 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2379,6 +2379,8 @@ static void __update_reg32_bounds(struct bpf_reg_st=
ate *reg)
>
>  static void __update_reg64_bounds(struct bpf_reg_state *reg)
>  {
> +       u64 tnum_next;
> +
>         /* min signed is max(sign bit) | min(other bits) */
>         reg->smin_value =3D max_t(s64, reg->smin_value,
>                                 reg->var_off.value | (reg->var_off.mask &=
 S64_MIN));
> @@ -2388,6 +2390,20 @@ static void __update_reg64_bounds(struct bpf_reg_s=
tate *reg)
>         reg->umin_value =3D max(reg->umin_value, reg->var_off.value);
>         reg->umax_value =3D min(reg->umax_value,
>                               reg->var_off.value | reg->var_off.mask);
> +
> +       /* Check if u64 and tnum overlap in a single value */
> +       tnum_next =3D tnum_step(reg->var_off, reg->umin_value);
> +       if ((reg->umin_value & ~reg->var_off.mask) =3D=3D reg->var_off.va=
lue) {
> +               /* The only overlap is umin */
> +               if (tnum_next > reg->umax_value)
> +                       ___mark_reg_known(reg, reg->umin_value);
> +       } else if (tnum_next =3D=3D (reg->var_off.value | reg->var_off.ma=
sk)) {
> +               /* The only overlap is tmax */
> +               ___mark_reg_known(reg, tnum_next);
> +       } else if (tnum_next <=3D reg->umax_value &&
> +                  tnum_step(reg->var_off, tnum_next) > reg->umax_value) =
{
> +               ___mark_reg_known(reg, tnum_next);
> +       }
>  }

Looks like it's causing a big regression in one of sched_ext progs:
scx_cosmos-5c590c8858df35e1_out_bpf.bpf.o cosmos_select_cpu success +542.86=
 %

Please investigate. It needs to be understood.
