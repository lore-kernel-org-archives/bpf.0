Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38AE184540
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040430; cv=pass; b=B51xlIlegF13BMHUCzngOp7HAdACfOW6QcgXsnFMul8pSPk5g/AR7OwSuOQEMfxoc1pS85WoYu5NRzjE48GeRI4hgcjxL0mNwQxDPuNCvIyeO37SbaNCjiJO1bHjc+Gs/ar5VqnbAq7f8PHfKlybHELgEa5DeVnOKWfIKz9Kb/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040430; c=relaxed/simple;
	bh=YDS2dEo5JUXKvqLS3U1b6s+W+s7l5ZragsnMIxIcL7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9cFnF8PoVA0HrhupU8Dp6mEsua8s0ii6SejEPFyqcCzyY7RUsamoyfie6g/oL7Tl66IuBuM6gTk/auU+6D70gvjV9QslZCnvly4ECswALKyAAnLUtg3k049O6kq58RuiE2Jo59FuTpC1330b7mxikmCqHdN9ThkjJ6TY5HWBN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwPZTS1t; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwPZTS1t"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c613a0ca52dso169166a12.3
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 16:07:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769040427; cv=none;
        d=google.com; s=arc-20240605;
        b=EaRgq8z2gI1BAXmBS6L3uvyAzjUZqYfnMTFpu+mDalJNbmQqu29mBot2FkCEPu40oD
         2fw7fbNSi9hqkxHWlLU7GbKdOzo7QXNZ/FOFnq55FIA2mjM0grm5rTNvfygv4QhaCYOE
         9Zm5J/NNOeUq+ItZxWC3AG+PULuAht1aTx1jQRc+sEQtigalc89VgVmi6ciA4J65o0ii
         ++yMhoX5LPutgkWl8MGbWqQIpvJwXONqxDiixOuFHx+oN9PZNJ3hj25JIivkHetOf6ZM
         7nB/xO0yTMnLAT21eFY0MyNr6DxVJyZOu1e+sRS/vCjTS+wE+VqOW0kwGwrkxfXf3y05
         K7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kpehpzYUeYxQtOW064pL5zljYpeDlxfX3uOqdqYW3MQ=;
        fh=f6lC+UUgEhi9dpOzTQIFiekPPuS/pi30jE/e84Sg1I0=;
        b=KxZ0kBeqmIwHHcW2kqWEXYRnd9mSRSvfuEZeL8Y4EPUNc82hJbbnYtr4BQKZfWYlns
         LqaWS0w2vHz3bq9pov1XG74LX8LLcMgJ/97JDGJpb8nHmqyfdZK7qCQdi2KkFeWMnT4r
         eKF4IxGubkJbisGG3XaZy8LmYGlSMsL21ei4OAu2dPmjxKYvZ+rzornByr3kr/CO3YPi
         MXV1fEL99sjuJbG7fIr6/wXVls29JpK4vtA/72kv+qbNLxoYg+BMReJe/U0tvLs7IZZq
         Hc2XkChznCKBs4wyT+JTIce0umeFNCnabyfbZuplRCah5NVOyzV6njiEj0HwbUACMxRC
         xaEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769040427; x=1769645227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpehpzYUeYxQtOW064pL5zljYpeDlxfX3uOqdqYW3MQ=;
        b=fwPZTS1tybOQkAiB0vhUDeanxbxIMfuZGdqzW1tTunfabB9nq9Lo5YbDv0eahhSla6
         2Hfir8ql8n95v6qKqKq/HrKwqkrwBtKnFcYQIu9OVMKsx0o9QGdykkv+OM69SyNnd+J/
         +nnOw4gdyP0gOTYQ9hBMOvqTKYPKdJRFoEXsIX2d28HkeyHJg/CmeoqaijcCTjKg4HWv
         DuBqGNu5bj3t5YZ+kFaJPUToR3e6kP/VTyvmkSorUnhzXcROsLZQgTrO8669WmAgYWcq
         aH2swOvyUUiweODSDxVrJ8EH2jqPr1jvjEMS4xffoIUyXeO7epf4ca8zli/lbctyU1Sx
         hMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040427; x=1769645227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpehpzYUeYxQtOW064pL5zljYpeDlxfX3uOqdqYW3MQ=;
        b=hCZxD/zAT8tIQ8MlS/VGDdP3siSkdr12wpdIJp2p/6DLg/ONBbzokNrNkBRHCE1bMg
         Ws4xtzsYdc7lX8nyrTJBKrJyZIgoWcLfwSLWwfE+bE2OsvtAUT0NIK2R6dGy5GTscmLr
         HRxPoyjqeS5iegh+datxZtdO7pMSSAt9tZQ+mAcgIG/4yfB7aEVnlBNTwKXAifg/VJVT
         CA8BUteKiFwOi2U2ligVMkGTBAc7UeBxKPX7xqfr5cGJJa4ZJ/FHpEKocrqiRNAB/h3z
         vLBNpwxWBLpPaDV5fmi53ay9f5ahw5dL+1sWMWFsDYCc+UIbBPh9RiMiwm+1OAEtfmL+
         vBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Ea8YgdrICxwXAZPNlhO+b8bGj7eaG1+uZxviJaAep2B4o0ZkRO8h0iAtLQ4wT1YwdLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOV67G4wNxAsXO3DQOCAWJWyX8FIDDMuSJ6tSbkc5TLAlfDBE8
	Btph7f9JXyaUOJFBzucAcmm4C7PZe/XoW54gjZPWGkm4Ily/RQiKDV15NK60Kiv/Pg0grxsnjOa
	adAXaXTlrNrmWRgAHenzZX/gdqtGLYX4=
X-Gm-Gg: AZuq6aJnuK1UEHydgq/oZmq9NUtdUnJmfEjhbqjFDXuIDa6Q95akLlhBvEzWMxZJ3gz
	t2nnU75DBtKnDbssTftLh997+l58e48NKD3TngBj14W2N65o5ZcJFTuZeFZcDsLrmlwoCd5Qut8
	d8RapehHfSjj4vkxcbpk+I020ek1KYE7B2JMe/kpKYq8zsCoJyCNhQoLBqZkofN8J7Vry/+nMle
	ShRd5shv5AshOkdotn2huI+TjCk/69J2UDDoeqAVixNRm4/GRbMcH2n2HW7t5vVxECwqKiEahUL
	k+VspaUrkW0YDj9O0p8=
X-Received: by 2002:a17:90b:1f91:b0:341:b5a2:3e7b with SMTP id
 98e67ed59e1d1-35272edae77mr15190946a91.4.1769040427195; Wed, 21 Jan 2026
 16:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115112246.221082-1-dongml2@chinatelecom.cn> <20260115112246.221082-8-dongml2@chinatelecom.cn>
In-Reply-To: <20260115112246.221082-8-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Jan 2026 16:06:55 -0800
X-Gm-Features: AZwV_QhSGxLIIP5f5im61MFlVXddfZPY1u3-4m3Mb5vdt2iGWTCVRB0Cnsxp4Lo
Message-ID: <CAEf4BzYop1GT1v7qxNQi44dsEebjwnLp-sHDp-HPzVrj69WzTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 07/12] bpf,x86: add fsession support for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 3:24=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Add BPF_TRACE_FSESSION supporting to x86_64, including:
>
> 1. clear the return value in the stack before fentry to make the fentry
>    of the fsession can only get 0 with bpf_get_func_ret().
>
> 2. clear all the session cookies' value in the stack.
>
> 2. store the index of the cookie to ctx[-1] before the calling to fsessio=
n
>
> 3. store the "is_return" flag to ctx[-1] before the calling to fexit of
>    the fsession.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> v10:
> - use "|" for func_meta instead of "+"
> - pass the "func_meta_off" to invoke_bpf() explicitly, instead of
>   computing it with "stack_size + 8"
> - pass the "cookie_off" to invoke_bpf() instead of computing the current
>   cookie index with "func_meta"
>
> v5:
> - add the variable "func_meta"
> - define cookie_off in a new line
>
> v4:
> - some adjustment to the 1st patch, such as we get the fsession prog from
>   fentry and fexit hlist
> - remove the supporting of skipping fexit with fentry return non-zero
>
> v2:
> - add session cookie support
> - add the session stuff after return value, instead of before nr_args
> ---
>  arch/x86/net/bpf_jit_comp.c | 52 ++++++++++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2f31331955b5..16720f2be16c 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3094,13 +3094,19 @@ static int emit_cond_near_jump(u8 **pprog, void *=
func, void *ip, u8 jmp_cond)
>
>  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
>                       struct bpf_tramp_links *tl, int stack_size,
> -                     int run_ctx_off, bool save_ret,
> -                     void *image, void *rw_image)
> +                     int run_ctx_off, int func_meta_off, bool save_ret,
> +                     void *image, void *rw_image, u64 func_meta,
> +                     int cookie_off)
>  {
> -       int i;
> +       int i, cur_cookie =3D (cookie_off - stack_size) / 8;

not sure why you went with passing cookie_off and then calculating,
effectively, cookie count out of that?... why not pass cookie count
directly then? it's minor, but just seems like a weird choice here,
tbh



>         u8 *prog =3D *pprog;
>
>         for (i =3D 0; i < tl->nr_links; i++) {
> +               if (tl->links[i]->link.prog->call_session_cookie) {
> +                       emit_store_stack_imm64(&prog, BPF_REG_0, -func_me=
ta_off,
> +                                              func_meta | (cur_cookie <<=
 BPF_TRAMP_SHIFT_COOKIE));
> +                       cur_cookie--;
> +               }
>                 if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
>                                     run_ctx_off, save_ret, image, rw_imag=
e))
>                         return -EINVAL;

[...]
