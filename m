Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F1E3F8254
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196603; cv=pass; b=FjaMc8owplsavC9e0qwP55ZVQTQ6+JG/Z4YdJw8uGXa0ptaPPcRgEoZIPxO6bYycFZKn1ncvzvFVLhHjWSkWp/INmBuU5SbvzTwhPITtFGBc6iEHuC5GuVPQlxSOF7xBDzwdM8Y6G3wyDsCjZNfEXZ1ReORZoTclKOxyRKk3bSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196603; c=relaxed/simple;
	bh=5uvg8pe4nZ8RF02AoqWbh1gjRAwqZcJ5blfYo0wFqgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERI+1ChkSHO2SO7/HKAM3+jnpRjjdhuVUUfpSbtzIlLmwBUNGTxSXKoxPwAwHGD6w85NlTJaqnbUnt3BbAJ4VdXaP17Ho7hS0bUHKmkP2PHZxVA482mtYb4f8TGBcNo0/a7KaSgmyyb4ZW21M1XlbOa/lH4zUjAiqzKxQ82q6+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0Ux+iTU; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0Ux+iTU"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84874b52eabso4411086b3a.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785196602; cv=none;
        d=google.com; s=arc-20260327;
        b=gJxvhtHU/zNIw6okDdVn+u5xsBVyDCIYJ+a2FvdRim3RyXOdb1EJLLIwA3WO1fxDcp
         3hbaKX5pnaR6so31m0m6NC6e29gFc8z0sk3qN2cZyePRSbPlZitve2MzEc0CzQYj9ITI
         3yUDeq3nNaIhbOeXxE6sXOugXKCeXGzdGS2W7UvCoiBGUR7vgIehb0FiX2k+/PV/lSrx
         VJbU/PcdLw3/mGguj5SFxk9mNGT8tNt5hNzu/tUCgJNNN/ikjDJDqKQYwD1HhUb6XPgn
         wxuu9rEn8Vhrg7x6OCY8QOzBqdyNTvDErmaUqzA3z0AV16nLomz3QoBJmIapstcGJz//
         1YXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z/J9rFngCKaRtBGwyz8UtE60KdxEfgQ7W+Ia/jtScFo=;
        fh=7eoyOfXUpehVHh0e6FcQCsD9SMN+Vtenv0RH2SBGXXs=;
        b=ewOC9ednf8TZtS221zVXe1A5Y7OpSK4Df89XtSQHxfxCTcJtsZhCO9ApfWoXhv5sBY
         FY2N+Ht1ecIPh18iIMq7VUI2PXmvF0N7siHMgwYvs4zqyHklGmmmPTgx5wkYN/NC8MaF
         Mcz1obO0Ve2A4H0rSAPJDgBwrKrpaSExFRGqVvdVDlz787lSrKYwkdIycNqfnfyy8c6v
         l8dJCevGoqhRjrPBFAHEZRqIKjMUYwM5cVG/5N8ivhpmmGGK6x/WwgV+6TZcvhvhMI8u
         ALGDMs3JMzk4nViOcerMmI7RTBmhBaalatHY9m//GM5v3EvxfXVCc4n+TtUWSfmEIpYo
         SmsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785196602; x=1785801402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z/J9rFngCKaRtBGwyz8UtE60KdxEfgQ7W+Ia/jtScFo=;
        b=c0Ux+iTU3tDTluCzwUKPvNCrkXF1Lba/rQb8Y3yGlTQMNtgIr6yek1u1JN/tf//T6u
         p26FRp4RuJYH1pX/MYgSGZNWll6A10WjfZGfv5+RYoKS8u440HoByN/g4f4TQfgrNMzh
         Uk8VqSv2O3QpxnBH4zeBVprCr0LxUJJnFpjGLDxHkhcPcJwajPJ1m65U8pHurVQl6PRY
         4oXOWQbihjWrHl1vwxrglpIBHR52m58/oPGO2Im/GbSkMRHViFFVuswDWziGGEbIObZi
         P9/D1qyNI/D8GEP0rM4x0CPE9WYcq3EsxQgYJcQIL/qF/Id5RtOWsLy3lbsNydZLJl94
         TMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785196602; x=1785801402;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/J9rFngCKaRtBGwyz8UtE60KdxEfgQ7W+Ia/jtScFo=;
        b=VgFJ53wyf8LZwkb6nkm99nwMzl1Lzcwtz8Mp0VNTL7891IlO/xSpAXWCQAMsLhRn7e
         Tr+BmCWcyqBu+CmzTAStRAJ5WQRLD72cGe6oo0U9Tokf3f48mnm5zyNkEYFaKcTv+8YE
         bxnLvjXDgBYSkc+PXI4vqOKqSk24nyII0q17N58ZYiQID6c0VAbvSzPDMnGmqneBvMLM
         M6TM7uJAWIpLZqPY1IUFjVoz44SEqEIenizyaYv5Lb/RiNkIGkbAXfXa1TEjpL9xFoAk
         NETcTzRdQiPL3/44eARTRNyIb9gYI/3IVS6OdgcWd+eaSkVmePUiQmCZrCeH91q5etHC
         r+pg==
X-Gm-Message-State: AOJu0YyKafB4KVhssIEi/HQnWbdIFs6ZXmpcaL2oggM2cc9BqH2DHIE4
	vO7Hj3R5vjLrZnpj5HKNMC9XjvN4KqVg51mqQ1Vcq6uX8I3sGPZyeEEAufxunGJBp/EKZc9hFkJ
	CKOp7JdO1Wfft/PC1hCYLcXyvxcOyLq8=
X-Gm-Gg: AR+sD10u0ZKESZb8Z5D4GgyiNvflNxm9RY90bAJhvV/QAn77wWw1P58ZOAO9ITx7xxS
	GWmRRovr/jrjxNb/tv+Cmy+V7fqlast6ydPzNzEMEhC2ZTGsVkhmumYqmHTQndFGou9qi/gHgoh
	dQ2JDI8qpxDQCAp9aCDU7VmeyUnjgRRM5N15FhXO1pG00a5PHd8ue6kFfV+LHJQSnQboJj4xzpf
	B3J11k6jCkMLPP9xX3wYD5Z7TMKaEawcIVSHu5AcgSkPVoOg/Frk00M6bPJ6vyVLKAUcVO4EsLQ
	UDiiGr31FxTEoNBmWBjAWRwHub7bdpg7JoWbsziQ3rF891dmSTdv9W1Evw==
X-Received: by 2002:a05:6a00:cc4:b0:84e:2bb:2d3e with SMTP id
 d2e1a72fcca58-84e931b5777mr48894b3a.9.1785196601779; Mon, 27 Jul 2026
 16:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722132424.450230-1-puranjay@kernel.org> <20260722132424.450230-4-puranjay@kernel.org>
In-Reply-To: <20260722132424.450230-4-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 16:56:20 -0700
X-Gm-Features: AUfX_mz31S8T-eLHK9lTmLTI7hfLEPNrEcogGFJSOMMnKdoCg2x45SyuwI1fL2s
Message-ID: <CAEf4BzYHjSfoF77+pVk8_GL_y_3HuiB_gf_Ea-5mnUx0==uhOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Inline bpf_iter_num_destroy() kfunc
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 6:24=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> bpf_iter_num_destroy() only zeroes the on-stack iterator state, which is
> a single 8-byte store. Open-code it in the verifier to drop the call
> emitted at the end of every bpf_for() loop.
>
> Inline it in bpf_fixup_kfunc_call() by replacing the call with a store of
> zero to the iterator, matching the kfunc which clears both s->cur and
> s->end. R1 holds the pointer to the on-stack bpf_iter_num.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/verifier.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>

as I mentioned before, I don't think we should do anything in destroy,
remove function call for inlining case and simplify
bpf_iter_num_destroy()?


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6fb8fdd5d5b21..dec6bcba53a22 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19835,6 +19835,20 @@ static int inline_bpf_iter_num_next(struct bpf_i=
nsn *insn_buf)
>         return i;
>  }
>
> +/*
> + * Inline bpf_iter_num_destroy(). R1 holds the pointer to the iterator. =
Keep in sync with
> + * the kfunc in kernel/bpf/bpf_iter.c.
> + */
> +static int inline_bpf_iter_num_destroy(struct bpf_insn *insn_buf)
> +{
> +       int i =3D 0;
> +
> +       /* s->cur =3D s->end =3D 0; */
> +       insn_buf[i++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
> +
> +       return i;
> +}
> +
>  int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *=
insn,
>                      struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>  {
> @@ -19968,6 +19982,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>                 *cnt =3D inline_bpf_iter_num_new(insn_buf);
>         } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_iter_nu=
m_next]) {
>                 *cnt =3D inline_bpf_iter_num_next(insn_buf);
> +       } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_iter_nu=
m_destroy]) {
> +               *cnt =3D inline_bpf_iter_num_destroy(insn_buf);
>         }
>
>         if (env->insn_aux_data[insn_idx].arg_prog) {
> --
> 2.53.0-Meta
>
