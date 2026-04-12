Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0BF49620
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959146; cv=pass; b=EYYXGdUQSqCW1XpP6eXyhlIDDwA29TzegK4fbLLhIeGZaOJvLpWKqdTE46bwYnq068HDYwcWFBXDVi9KVLfttj2gOls93nlrWR0p4zxVaRIbE7NW2bCMQhDkKJDJYftcJGHD/F11E0BBt6wcBUjewb0XSCCf9ta3Vpylt7l9oWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959146; c=relaxed/simple;
	bh=0ue6J1En37gTfYvvUUVkmcYngBWOaAHeom4Twus/31w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukgvzi7ZutrerF0XGMMxZP9EAiWeva4Bx9brT6VHQD90dKGk4Etbt/Wx9kVbSzICNZ2KC4v2RZev6n3OPltEAJp0A//QheKqHzOnHU0xjPzhFDcTHmWLO9/OTLioU6iMdcq2WAgmPjAB33xLiBrFdzUZ9WH6H8YOk/wzLfMIMr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd/WuXzJ; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd/WuXzJ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cf73bbfbdso1958394f8f.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 18:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775959143; cv=none;
        d=google.com; s=arc-20240605;
        b=TsN34k+Hh7gfoXTC1mrL+hHVFQWdtZ3B9Y6/orqYLCMA/dju99CXkJTqy/vx3HKEGP
         QHtOeR0jIskzbOxKgamxX8xmF2QQuwg3+C8ect9b1Z+mO6g0JElozvQc8QYIzJtwFfnG
         DFW/YXoR49aR4Rjwyy247iZMh2ps+dwjpiA55wARXSrJcPntxIY16RPJzOihHCzwExgo
         vKSV09HXAmWNTStmKesC250yD3lXtkSH448gDMxbWhAlO5xpAn5pYRZBdmI16A396FlJ
         cII/NDeq/y0AVG5rQKZ1VdczxoIzDYEFWb9FjgRnFtbXmA1BECpYjn4Xdj6nYVAi8uO0
         W6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y5TmGjVnhRlPsCMSqRqbu7eR/+WVRBPqppgtAjY2n4s=;
        fh=hfRje2veXRgnK/5UbF368BTRuTdPC/oA5JvW+CkXkIA=;
        b=ZfkxLMVJpH8spb25I1dJPB1N/d4BLX3onqMKZ09QWVZPGyhxMX9ZQdGqgBNNwilF0z
         ho9jQ5YVK1qx+BumQNlI+33WkIsvdG4dvPI/3zESfEPxBwdF+5jMfDuEqh4hQ2X1EFki
         U7ph79hn9XB0wmvJrmPrBRBq0fSg/nZJZJ8AIxmZSu+6MjG4ufiO0XeopmnBY/F+9fpz
         PyFBiRKogbgYx4Dr22waebd0Vigbl3SaXZN1Ebhne8AG/YOy8admMRmPAASRwcCgb+m2
         +csrBrWlVnyc/i6qKW+N9x998QTchiVS7qQM1XpY34DcpH8W+hPihEWF5HwiKzpN3+pD
         dhdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775959143; x=1776563943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5TmGjVnhRlPsCMSqRqbu7eR/+WVRBPqppgtAjY2n4s=;
        b=jd/WuXzJRyb7/HxGbrHV9zNwT1jQgguTfDXPPFpQEsw5MM52gTWTIARJQfTHusjUs9
         7D3uvi1bEJB7j5SKiRsEmm1rkfEFvgMdeSFsEci/oQK5DxKytrZDyofIa1MxilkXN4k1
         xRqQWK35IT06yECEE4R43ufoKCkWwVCbdwP6orx6mmVx3+mtC9fjTicCTvks145Msn+A
         yyM2mySZMdamOI0owW81g+1GELxQKgZZMvn13wwxvfstCffGI7ik4954xcHhGvym0si5
         NwkJ+sBnMmcDDB6C841AE6p1EhbzA/Oo4mxedCaDgxTo32mepqdvRRx13a9Acv+d399y
         LwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959143; x=1776563943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y5TmGjVnhRlPsCMSqRqbu7eR/+WVRBPqppgtAjY2n4s=;
        b=nWJojtZDLX5rfdm3fFQeKWkU71aolPbcGfy+ywt9IP28VG0erwh7gJA9t7T6CZTRbs
         YU91plBql9jJjgVmT8uK0NPDYJuGI7sAWeNCHNwRXEwSAL/34RDCETioTCNB8LZEvjdi
         T/N/XVGYyMM9Tbu+YsvEoGxtlVpQkbqOgf/JmOYztewCEO9LxMjwWzS71NPjB777x6Fa
         eQSy+dZM7aepf3i3RA3xOBZxbUWyELtZJmfRR0cLaRtFYjjLBQE/gMQ1HhHLLpAMLFX1
         TEUEXbpp8BTpzBCu/M7T82Ov9d/yExUmnLqaYNK+hH92Oi0PUTguCs86mXm8CJEil5VB
         beaA==
X-Gm-Message-State: AOJu0Ywp8Q5Y59UItM/Nua7WJgWQ52TkCPlWyzaXT4D79spuiCKIZXxO
	g9CbkEe4w30ykiIvOH9Bd9DkEMcsqmJE/h+oArnM+L65a6t9AX4KA+L3HV2YIPeZLRG7ADIbOSB
	Y7c0TSjqWBr9o/95pQhqlzmCGaBPF7RA=
X-Gm-Gg: AeBDievtaSysRWVCrWFDhA8yR46HhDT/a+G/+bOtwSvM0NBHeMTZpxSGpL47gHKXtoN
	Xhd5T4vKutU6ER9HmDYoLy9iFqEcqOYSOfdfJ5NkhtM+ALPt2HIPZ5nWUtRUanD3VIo30+988IH
	Uw5sQcfkqcqO66v5fP9KubRZ2mE0Xd3IuVF49O5oQylTL8x7eg+L8sGb96BgalglmzNzLbX2OiR
	49rtSb9VZRA65lJU8UYBGqj3a2RTJBIc7N5hjIkYp701L+wedsYLqxV8G4a+dOCT/9XCXyPEP0Q
	o0d0/4dFL7utJJFjd36CRD62g37HiDaKQkB2MDOl4BwrrDvligs/F4M1jiVSHzvgbosAfhsG1P9
	cXznzwA1aibfPRoN5xpYqEgyz6g==
X-Received: by 2002:a05:6000:2f83:b0:43c:f66e:f31 with SMTP id
 ffacd0b85a97d-43d642ab985mr12278570f8f.27.1775959142720; Sat, 11 Apr 2026
 18:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412011857.3387-1-emil@etsalapatis.com> <20260412011857.3387-2-emil@etsalapatis.com>
In-Reply-To: <20260412011857.3387-2-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 11 Apr 2026 18:58:51 -0700
X-Gm-Features: AQROBzDv47KqcD9Nrr3MugG9OawLhntfjc76q8xDT4liXq1TBAtWWf6mS5dyQv4
Message-ID: <CAADnVQK_Ze+WZAJvyT0Dn3v8QgLWcjD6sS9b2ZqKYW0i1y2VZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on
 arena pointer addition
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 6:19=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> The compiler sometimes stores the result of a PTR_TO_ARENA and  SCALAR
> operation into the scalar register rather than the pointer register.
> Handle this case by upgrading the destination scalar register to
> PTR_TO_ARENA, matching the existing handling when the destination is
> already PTR_TO_ARENA.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> Acked-by: Song Liu <song@kernel.org>
> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the v=
erifier.")
> ---
>  kernel/bpf/verifier.c | 73 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 59 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9c1135d373e2..1aa60199fa2e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16640,6 +16640,59 @@ static int adjust_scalar_min_max_vals(struct bpf=
_verifier_env *env,
>         return 0;
>  }
>
> +/* At least one source instruction register is a PTR_TO_ARENA. */
> +static int adjust_ptr_to_arena_vals(struct bpf_verifier_env *env,
> +               struct bpf_insn *insn, struct bpf_reg_state *dst_reg,
> +               struct bpf_reg_state *src_reg)
> +{
> +       struct bpf_insn_aux_data *aux =3D cur_aux(env);
> +       u8 opcode =3D BPF_OP(insn->code);
> +
> +       /*
> +        * If it's an instruction with an imm operand, we know it's valid
> +        * because we checked in the caller if the destination is
> +        * an arena.
> +        */
> +       if (!src_reg)
> +               goto valid;
> +
> +       /* Ensure both operands is either PTR_TO_ARENA or SCALAR_VALUE. *=
/
> +
> +       if (dst_reg->type !=3D PTR_TO_ARENA && dst_reg->type !=3D SCALAR_=
VALUE)
> +               goto error;
> +
> +       if (src_reg->type !=3D PTR_TO_ARENA && src_reg->type !=3D SCALAR_=
VALUE)
> +               goto error;
> +
> +       /* If dst_reg wasn't a PTR_TO_ARENA, it is now. */
> +       if (dst_reg->type !=3D PTR_TO_ARENA)
> +               *dst_reg =3D *src_reg;
> +
> +valid:
> +       dst_reg->subreg_def =3D env->insn_idx + 1;
> +
> +       if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
> +               /*
> +                * 32-bit operations zero upper bits automatically.
> +                * 64-bit operations need to be converted to 32.
> +                */
> +               aux->needs_zext =3D true;
> +
> +       /* Any arithmetic operations are allowed on arena pointers */
> +       return 0;
> +
> +error:
> +       verbose(env, "R%d %s R%d: Invalid operation between "
> +                       "bpf_reg_state types %s and %s\n",
> +               insn->dst_reg,
> +               bpf_alu_string[opcode >> 4],
> +               insn->src_reg,
> +               reg_type_str(env, dst_reg->type),
> +               reg_type_str(env, src_reg->type));

You went the wrong direction here.
The current verifier allows arena +=3D ptr.
So be it.
The resulting arena pointer is still safe.
It's probably meaningless, but the verifier shouldn't judge.
It's job to prevent crashes and not logical errors.
So revert to previous code and drop !=3D scalar check
and fix the actual error, since two reg_type_str() are wrong.

pw-bot: cr
