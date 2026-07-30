Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83704384CEF
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448225; cv=pass; b=Ltp7OGxpsOSA+BL7/Gf7INZPd+UNEugfp+4TKIxGcG+XRPQEph/m7xtZzD/20VSAVcHOVL7X6M2UwJ9w5eEELZ/kXbUfDxxuAJHQWahdxnV/Uwa2DpyE91W2JVVN9J+TfsJIeher2UnjcismrHu15E79EiW0vqfK19nJVAzeQKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448225; c=relaxed/simple;
	bh=GVUeQSewnox8tIQyO1IlaKXpRTVyYPMIi6BTBlld21s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2o+Syn7emQ7xu19dROB0BFVrpXoSfUBiQmGgeiwac2sA3kDioXzP7WjXYSG5tvgqUYiVAtxFzB+f/GM02BeAWd1LnkE/uGdu+/n0AB+PCZvflvf0gj0atzElTgWctDKQT0sEBqKAEvSB4CGx9sTP4I6cnilpTCYsF+6TNe/5KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDx9S3cL; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDx9S3cL"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84eb992a881so337195b3a.2
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 14:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785448224; cv=none;
        d=google.com; s=arc-20260327;
        b=FKpBo5rkfIIa2qblDhixc2nxSF7qMyX7M1JVKmzqk0kN5vLdOd+iDEXZ68FWSrJYoO
         zFdeZWMJPtDgg+RUKzEdUwWcQ2pm47uxXYqfYdwqhXfFEQOoU1f771KGBs7gYYai8etF
         FsepRwOigu+2347RjD2j04AMi9tZ9nVZasYXz6+wH0Q4zvaTS7u9ufPZzgSSqCR7NHnH
         H1lz52VsbQ+VucXDAmVdkrE1vUca475yop5lTrY6znWYrI1bAzqOcKss6MSVB/JHDzBP
         JerjD2pe0ptfcGkoO4y36JIfsX3hKja+Rb1W0eHXZX2aOqF4EBcwPyBIJ1G7WQ3A1FxV
         e1Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AYZ6cDo2/Xw0n3c07G/a0+b56c6Olk6Jr8XGU33EEks=;
        fh=7eoyOfXUpehVHh0e6FcQCsD9SMN+Vtenv0RH2SBGXXs=;
        b=ZuztmDEZrni3p688/sfjPAV8LIWe2cLLsnIN14tTzQMCrshDCzAEmAu3lpqSwUU3sL
         Xx5a7ASrAW8mCLm1iCcoFKc7PG2t6BltSfKyzmeyxihIvgqLom71qHg289znxfacZeKl
         DQnnUR2gWobgQRHEOqbAbs4A00bDPjCspStxadPJoSFsnmEsCrg2kutagtVFvr+KO2EG
         VG9Azux8n/ZkgnyyhvjpTL8M99phADlr6LUC7CWMXQUsC/KvsYOQ0dxW79XHozGnpets
         c0hCe8YZRQcR/cjKrjWgUyVEmcA/LvH14V9WDK+Hpvssma/dHt4tZYKmJ/UauFtsUfHC
         65uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785448224; x=1786053024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AYZ6cDo2/Xw0n3c07G/a0+b56c6Olk6Jr8XGU33EEks=;
        b=jDx9S3cLAu03JDzMCG9bBm+bR/GMxTVDOKHQkxSWtY4ZUZFClcQOroqnSdpLEjhMr/
         jUjNucl12326zJARXItJgJ+HXE3hFEKpSC/gI9L0kPy1SAt0AY+I7KahR8HIuCmadt6c
         HqWs1ILiKeosJqrRXwDIwOJQ51CsgXeuGttYcGITdhYUQfyQWF5ncEdFYjIraW2EqbXs
         gno+QLLxgCLbpCk7LZ6Uc1OF2iukEcV6XS5d/6WHEm6P+gdnkHS03rHT7UdqpCM5RpI8
         Htq65WaYARUMCjRmbZz6hn0Ly2Q13RtcKhm7D7QuZXhD4XYgs+izYftVpfFst0Uc+PzQ
         CYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785448224; x=1786053024;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYZ6cDo2/Xw0n3c07G/a0+b56c6Olk6Jr8XGU33EEks=;
        b=UGZW+zoZ0HbAIqm5MQzz1WhKNFlrpjNcoNWahE7/2Dv6d/O5QJyKFJv5VOg+r+asUO
         TAa3Bc3t5ItCMwh/KzYpQQnOExRNBsEVOBvPZwvFOPfXjFAY189QjOyzzdXJoOSQ6jjU
         AZREbwF+tmXfdX/boFcRVcDgIHSqb/DEo4r2kly19stnUehbcwLZrNtDYhyfeKqIAUm2
         QzUUjBYbU2sewZbqtfdinT7PR5MV157UPKDTcdiuo4z+UP51LWdPbTQZ/AqFRQO1owu7
         l2aCtTDKhONDeOSx9Vb7svvmp+lIXieiI7on5uARi/C2ljr0+YgVhyB5Ecvut9qfWBXL
         1QUQ==
X-Gm-Message-State: AOJu0YztQYrFcDeWmSKlRBOvis/vpwxVSOFC9KObO1weYd8xOumRg4bj
	cjb1YaV/7AHU3lVjRQ0Qrace2fLdOjSeM/K1jH5z1znBsVONIt317IBF+CNL6JiY5yMhrjHUfMx
	BMNyXldnrdQpLw4gk/G91knkE9lq9FSc=
X-Gm-Gg: AR+sD10tWhOW4f7m1HRZ52ThsSt9i3krqq+C4hjAPyGgAwyTNV/C78pz9D08Qnj1Gcr
	Ue2k/yFeIT3T81Ft6QtMSKnXzUNMJuSt/h/F2d4HPbS/q9KXgSWFvdR8ivqrvVKQ17ZhKStU9RE
	tKUdIA+jlnY2JeXtgQSj9DqUbMZxqHH7pZF/8ZPbsIb+shCvzwlmfY9h3wtPb1wLweamz7TeZ9p
	pz2P2GLrd/aRdz2PZL5/jDFutPiOEg0XRgr2Qn7r+9gim+eFiVbEXvGBh1jPJl37j6tw0GuwCJu
	kg7EKE60v5IoFQhuhXu5qHZULr1IBr5WtDs3+Uj7x1gU9ppsfRUXOZHhpwO9j37EJX9A9QxUzbE
	ocHWkItt5bdcUFy3WLV7XtIyTfmuThkXa2zmW7No5Rw==
X-Received: by 2002:a05:6a00:891:b0:848:8445:6956 with SMTP id
 d2e1a72fcca58-84ebc22ae43mr3881081b3a.18.1785448223746; Thu, 30 Jul 2026
 14:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729203633.213973-1-puranjay@kernel.org> <20260729203633.213973-4-puranjay@kernel.org>
In-Reply-To: <20260729203633.213973-4-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 14:50:04 -0700
X-Gm-Features: AUfX_mwi0nIilnDvtJ45ZZXLc0FVhCkiH6I8WUX-f5aTXeEuWVTHXXsZ0RInc00
Message-ID: <CAEf4BzZtDQjL90ZTpL7fZSbmY33-oU8tsmw0bOb-9EjkcCAd0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/6] bpf: Inline bpf_iter_num_next() kfunc
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 1:37=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> bpf_iter_num_next() is called on every iteration of a bpf_for() loop and
> is the hot path of the numeric open-coded iterator. It only advances the
> on-stack iterator state and returns a pointer to it, so open-coding it in
> the verifier removes a function call from each loop iteration.
>
> Inline it in bpf_fixup_kfunc_call() by replacing the call with an
> equivalent instruction sequence. R1 holds the pointer to the on-stack
> bpf_iter_num; the returned pointer to s->cur is R1 itself since s->cur is
> the first member.
>
> s->cur and s->end are int, so the kfunc's s->cur + 1 >=3D s->end test is =
a
> signed 32-bit comparison of (s->cur + 1) against s->end, with s->cur + 1
> computed as a 32-bit int. Sign-extending both sides of a comparison of
> two int values does not change its result, so the inlined code uses a
> 32-bit compare and needs no sign extension.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7400515ae1296..3a3d096f3966e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19810,6 +19810,34 @@ static int inline_bpf_iter_num_new(struct bpf_in=
sn *insn_buf)
>         return i;
>  }
>
> +/*
> + * Inline bpf_iter_num_next(). R1 holds the pointer to the iterator. Kee=
p in sync with the
> + * kfunc in kernel/bpf/bpf_iter.c.
> + */
> +static int inline_bpf_iter_num_next(struct bpf_insn *insn_buf)
> +{
> +       int i =3D 0;
> +
> +       /*
> +        * s->cur and s->end are int, so the kfunc's s->cur + 1 >=3D s->e=
nd check is a signed 32-bit
> +        * comparison of (s->cur + 1) against s->end and needs no sign ex=
tension.
> +        */

let's keep all the explanations in C code implementation, and here
just have brief C code we are implementing using BPF instructions


> +       insn_buf[i++] =3D BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0);
> +       insn_buf[i++] =3D BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1);
> +       insn_buf[i++] =3D BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 4);
> +       /* if ((s32)(s->cur + 1) >=3D (s32)s->end) goto done; */
> +       insn_buf[i++] =3D BPF_JMP32_REG(BPF_JSGE, BPF_REG_0, BPF_REG_2, 3=
);
> +       /* s->cur++; return &s->cur; */
> +       insn_buf[i++] =3D BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0);
> +       insn_buf[i++] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
> +       insn_buf[i++] =3D BPF_JMP_A(2);
> +       /* done: s->cur =3D s->end =3D 0; return NULL; */
> +       insn_buf[i++] =3D BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
> +       insn_buf[i++] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> +
> +       return i;
> +}
> +
>  int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *=
insn,
>                      struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>  {
> @@ -19941,6 +19969,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>                 *cnt =3D 6;
>         } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_iter_nu=
m_new]) {
>                 *cnt =3D inline_bpf_iter_num_new(insn_buf);
> +       } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_iter_nu=
m_next]) {
> +               *cnt =3D inline_bpf_iter_num_next(insn_buf);
>         }
>
>         if (env->insn_aux_data[insn_idx].arg_prog) {
> --
> 2.53.0-Meta
>
