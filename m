Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FB9326938
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665257; cv=pass; b=uO+V1g+K171PV/DJJnFCVbnOmXayMp9RoqziPh20f2JCTMnvFnrh8qSblMWUhUtt2EqC9fmqZkbTL8L17ABfNNQCEAQDrVXAbP8L3F5TvrVaTbRbW79a2TMV20c3qLSl5269QpPZsB1d9imUvMtmizALKcb24ufCk6+7/2qWRbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665257; c=relaxed/simple;
	bh=D+DJ5XwPgx47oZfXhJlPVNn63RztcRSxYBF21Le011U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDUIEV3w9Dy3SbK6iBy46RbByoqyktxabfw+xCcaG2taiPtLh+cZd2Pti/ZanZEks/AMNTg0JE798E6Hr29UHWACYZbeV+XyuLX/dlAuf1xhAjyDh+b30vQm7BPuCqq5A3szv11F8sjGMbw5kz+0mgIVE6C/hF7Evp3Ms06JxkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebZz+MEq; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebZz+MEq"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso53646135e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 09:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775665255; cv=none;
        d=google.com; s=arc-20240605;
        b=AxY2ochhqbtEQdagKm+sEECZPwTuuXunGjeoqZC0H6MZUcTKAHaiL/fYDp3aYTUUPa
         12rdJxtI4z9ORZa8urTUDxyZAFcLg3sOX3OgMnF5gRrE7IUrX0vM8OYUXFmEEx13dTjP
         uthFzMGnecB/yP+HBpgACWtnQ1q8pOPEZ0vcEJUMKepTKqQtr92mM0tVRmNMV8O3StTa
         TvYNFQcH/6gb6KwSavVFtcz43XliUPTMeX9Vh98nIpD+JWVwbc0ptI5uSfIJlKdvLE8x
         nzoTcTMS0oxk45En4QBClKthT8cbOXz9hYOmO0I7mN2eRIQ/ujjIWH9AjQYPx3R0EpWH
         /u4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZqJ20qZBqD3AF5g9BpxcrsDEk5Pj8myEQH5vjVcW+JE=;
        fh=CY4ub6tm4dU9Q9M/cvte17bmSVJcYAt67JYy2EieC4I=;
        b=U4BNK6KwQpLLrAbkQDCZIl+K+yjhe/4lzC6dhYY17Cs6G+QNoDqfwrQSBJnW8JQ+0J
         eWjdbXuBQCop5Im7v+eqeAty+ANiL0l8o0gclOZd5fgi7wupiuAw4V/rImtYd0/oVpTm
         GnPXFEGdv4AzjbQ1+f8g4bsJwo8QCPlPw0j1EDYvCeMArcFHsjFNt9vffRUJSY4tC06D
         utHXOPkmwxbzO1dhMXmkPpgKvZAB4+9L53rYFJVoGLIANkqE+0cMjqB+0EXucJ+I44/s
         LygWAtfBvMmEbEpT7pHG4kXAuhOjVqZjiMSaaNPzwKyTsPLYp+TI85ElZQEUH78sxWFb
         DMcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775665255; x=1776270055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqJ20qZBqD3AF5g9BpxcrsDEk5Pj8myEQH5vjVcW+JE=;
        b=ebZz+MEqPW6pwUmPPPwNeFexf8MwEiynK4fMOjOK8gUXE/37YmcSgYYCR2DA+78FD4
         b4RAGZnWIIbO0ddIl8BHzPNTLKbXwDK/HEdPz29z+QCqAYqhLe3n7MTfM2SUuT6nmudX
         Ulj/o8cW16PKITZnAiQqr94wcBlR/2i1C5NwlwLBfC1tFoT5BT8BM+HoR4uHuCAFnCRY
         pJ7W28tCgUNV/eYl4mGgY3Cvjeq+Au4ug8p0CSzlUnRsjzLvXfwv3dpjWeK6WJem5IS7
         1EwLWCFr7DhiJrpsjOuZHZEyEQtrojtzvAVDeSD8onG4jwfCHdyDyyySHqBjd9cXTsGI
         uwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775665255; x=1776270055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqJ20qZBqD3AF5g9BpxcrsDEk5Pj8myEQH5vjVcW+JE=;
        b=mRG4JpH1yMoYPQ9N81V3CFGLiBaS+QZE8yUABuOqBd4/X/kQALvTByzzJF4n2vThIj
         EKcuWkiH5+uIOODYSXh7fV1aHZVGj962cM5JNGOYhCG9hqKRc8Mf7Swqs6mOYRuTkK76
         yUXSVbj4jiYxi6A9QNSNvoDBEUIlYsT981rsjCJtwKe0dpGMD9om9oA2YyV6LwOIZ/d6
         NAUJOy5CYNHhZ3u+WTzlnszM/4shO/SCsB6oz5TPhdqSAIqsg3OBeB7CG8rSyj8sMjy9
         T1BBu3W46Met4dgHIv9wV2CUOoAO72TpSQ63CnAFpU+ebhYY9hYWZ/S2JM9AXRc2qNc7
         TKtA==
X-Gm-Message-State: AOJu0YyPOfEv9RkvdkZyYepFIL7jx/jm/Hg/Rm8A0XM6no4wKQedhVVs
	H8mwk9V1v9sXZjjd80gMom+ZLRba+ldamFC27UCWzPaqexpkeQjrxSK+f2s4FJxC6WsKyqQI8f3
	jkDNEIwaBHkXb7hKrLgpCNe1MPCztxdw=
X-Gm-Gg: AeBDietXT/3CjtzL9m/IinYHYD6QJHuy0StW3y1O7iOXdlV5QtvweFukeNQenE3ZcBa
	qLVScbiXMm2P/zY4HjjP7qo1e7tsPpx0r1P9icR0h889s8bp8rovgvhUtQXeps3jKxwWR4ME0wt
	v5+QMEYtpGPoYrMmG+O8sds4GfpFln/OOHvNuF3Jto+f5GHIrcJUDPrErbQcYe0mdpIihdG5k/5
	i7iHJpqsdyWsvw80NyB9a31m+6dDBxe/qXRO4BeNpU3PJLrwpO5XtRL+KZW+Ea2GV0sai6ANRdc
	UObzIW1y5zL3ZITBeIzyxqllD2ZXYDEMG/AvXeSh/z2yHS1Wqvn7VQGHhqm8xI7jlw0F63U6YAK
	xRI8RmqIt0UO8lwmynTJnkw9GRXq0vQtDKx5V
X-Received: by 2002:a05:600c:c056:b0:485:40fd:8390 with SMTP id
 5b1f17b1804b1-488998ef198mr208602935e9.26.1775665254326; Wed, 08 Apr 2026
 09:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408153712.523124-1-daniel@iogearbox.net> <20260408153712.523124-2-daniel@iogearbox.net>
In-Reply-To: <20260408153712.523124-2-daniel@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Apr 2026 09:20:43 -0700
X-Gm-Features: AQROBzAfYBtFmprLqIrk6-mOTNR5ScgwXjvA1d0Esbk0J2mj4TUUtbyrupZb3to
Message-ID: <CAADnVQ+tLKiH2a_1mOFZ7aZ3jN+9_vLxOxxPqqBc8QEYUwCgVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Fix ld_{abs,ind} failure path analysis
 in subprogs
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	STAR Labs SG <info@starlabs.sg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 8:37=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> Usage of ld_{abs,ind} instructions got extended into subprogs some time
> ago via commit 09b28d76eac4 ("bpf: Add abnormal return checks."). These
> are only allowed in subprograms when the latter are BTF annotated and
> have scalar return types.
>
> The code generator in bpf_gen_ld_abs() has an abnormal exit path (r0=3D0 =
+
> exit) from legacy cBPF times. While the enforcement is on scalar return
> types, the verifier must also simulate the path of abnormal exit if the
> packet data load via ld_{abs,ind} failed.
>
> This is currently not the case. Fix it by having the verifier simulate
> both success and failure paths, and extend it in similar ways as we do
> for tail calls. The success path (r0=3Dunknown, continue to next insn) is
> pushed onto stack for later validation and the r0=3D0 and return to the
> caller is done on the fall-through side.
>
> Fixes: 09b28d76eac4 ("bpf: Add abnormal return checks.")
> Reported-by: STAR Labs SG <info@starlabs.sg>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index db009d509ade..46f55ea6684e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18357,6 +18357,22 @@ static int check_ld_abs(struct bpf_verifier_env =
*env, struct bpf_insn *insn)
>         mark_reg_unknown(env, regs, BPF_REG_0);
>         /* ld_abs load up to 32-bit skb data. */
>         regs[BPF_REG_0].subreg_def =3D env->insn_idx + 1;
> +       /*
> +        * See bpf_gen_ld_abs() which emits a hidden BPF_EXIT with r0=3D0
> +        * which must be explored by the verifier when in a subprog.
> +        */
> +       if (env->cur_state->curframe) {
> +               struct bpf_verifier_state *branch;
> +
> +               branch =3D push_stack(env, env->insn_idx + 1, env->insn_i=
dx, false);
> +               if (IS_ERR(branch))
> +                       return PTR_ERR(branch);
> +               mark_reg_known_zero(env, regs, BPF_REG_0);
> +               err =3D prepare_func_exit(env, &env->insn_idx);
> +               if (err)
> +                       return err;
> +               env->insn_idx--;

similar code in check_helper_call() for tail_call
also does mark_reg_scratched() and clear_all_pkt_pointers()
which are missing here.

Pls refactor that part into a helper and call it here.

pw-bot: cr
