Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE618DB01
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772558374; cv=pass; b=TPDzkndUAsVvXdEQTF6LgCBkFONRWL6oYTP0XlsaCaAG+i+o3BAXicATYkwW3aP68bAD2jllxy9Dauk/bTIlZzw9Xba/lPHqbHVrPEp99A8pEdklcZ473g0hWKox1uLyiXbXdXikMIMzqcPSXp9jG9sjZRijwSXZrwFk8zZMWXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772558374; c=relaxed/simple;
	bh=JX0D7ao9LL28h16X6vB2z6PAyJyRhBjZGE0WWOIA93w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADbdBZjXNRhx7fF7zEU1kFApxlsC0G0COrSTiME3XC49xfe7awBAzKUORNHvNagTvlMgpt5QN1IZrrrivJuBMedhfOuufqgew2VencjRSEfES/4Ov3BX9WftYECyvODN1YcSbbSTSs+XOafokgtUuhFa5bQrY9kz4x8UWj0c/EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY+wILiX; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY+wILiX"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439aa2f8ebaso1992727f8f.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 09:19:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772558371; cv=none;
        d=google.com; s=arc-20240605;
        b=G0xDJJguBG5s1a2+2bfQrNsM2uCVlucflwLMc7OmB7CDFwFakwP7tcBJOhSutZ/FTu
         ZSsbtIyCQV4mvhhWK0L0nkSNSs8RAxBiZ9P8VkkqIhE59hx7RcBjtsEHBGm6w9bbuE5w
         kOiHG8rBPtIAnUtUH0v9YLseZfzAkwCzst5gOYMXDCSbNr1m6CKxycF42vIBg/zHqabe
         4izK3OiG8KX1cV7j9C4avhI10zUY1dk+OYdbIj9YqjBar3GNqr+cRTDyEYx3J0N66QEf
         qJkQuAEuxbNzS2JdqGM3ljKq6ekze41soHeM0U2ZbB/nS9/86Z56/Xo+uNHJjC7lp0ij
         YHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4lG3IZPwbMVPm9SM64fXZ+1KlCJGNP1Tyih1mnoT5bc=;
        fh=iMzrOB6qCEvQuf+WB4cfNypUTdfIZ6ZaJy8QTZEOyIQ=;
        b=A7X7xYA1GicFBM+gfImlG/yTL6TxJ3mv3HLgFOUG5qdLcCkgCICPVKtiRZxIUw5k/V
         yN6Mq5ODyIytaUkGGeEDEyMztgp/oIYBHisaQ2mwOpNghEiXg5/bPgdYyOEXjU8ZVz38
         wk9xFk5cVbCBdfgBQVNXST0bAOdyNj8M5SR8hS69aeAdmgucVlexItjaJWGLohaK/ITP
         NSEZpmahWvlyoDCwuj/INdYjeDQqwA94B2i3ARNP6cbnfzXY4fQHzPPVjXhhuJpz2Jg8
         W5t+dC2lu3LqTN1EOpY5Szh2anBExdk0oukdnLdfJXB2GYmNVSbRpwlA5LGU2iB8Bxzp
         CeAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772558371; x=1773163171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lG3IZPwbMVPm9SM64fXZ+1KlCJGNP1Tyih1mnoT5bc=;
        b=CY+wILiXDznFZwN1WTaV6IXXPjE7acK1A9smsSiQCmKm5g/AM4k8eVhQiFmippW9hO
         ks+/zNUcrIblvZSJ+zSSHkbAEoXH/72pQKhCN1lKRaLFcUBkG6sEDKNCTKji6KdBhaRO
         Fuhgd+RuxsiVw0M0PuVFfzPcrQgzNn3J//2G+NbO7o+mYG/EP/h6yKcoSQHK336HZVPN
         ZYZ0ZLNkQSx9pdX7/ywwsnYHaNfvxXJ9M5HF0IDUn8+6yD8vPnlcNS+Wl0IzJl1NX7Gs
         sbzS8r/pILGUJNdPZtJe+Fpw57aiJ1V2R4IgD+nuO/gtuZ1Yb+VZsY2Mr87LPJnOPdxE
         jdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772558371; x=1773163171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4lG3IZPwbMVPm9SM64fXZ+1KlCJGNP1Tyih1mnoT5bc=;
        b=SWvN5nOqTS2F6u15IRNwsQJdNw0KKmepLkBI3QdjYCfTCD9ECcSIS3jFIyvDTWsAf/
         EJDY8tNTn1ShcOqjI/6cy/dRSdL6Ya3obUP0T2B2xiadjdUtJSGTjaDC5H/svfQK4V1l
         +SaytPV+pKy2f7YO5zK3jAB/BtUWR1fkc5GOga9YUiLuFMjvMKdZsz1K49CuIhjGAf1W
         qbS67xdP9X0iSvZqK50qhdp1DRUab9svvhCKV6Yl2fq6t10g2cJyLV/n2rve0dA0D44Y
         c0CQArvUFKCiw5FdRB+1mUki3Ss/kIS2LCtQ0zpxzkVy0Y58So541gJrvay/dAGAxGbU
         AdbA==
X-Gm-Message-State: AOJu0Yy6+2+tkQ32OYB+1r8d0uoqUNdU912wflpJu59E3x8CW9l0T/FZ
	fHWAfXBsNk5/3KrpnSuhMg6vnYOd1goU1OoGVFSbA590eiWnuHTsoTKl0ecfojRGESFom4YwMSx
	+8JUfkA6l4jeaS/Z5Ad62l9VutWZbGgA=
X-Gm-Gg: ATEYQzxtBAc8naWdBxDeMJQE4T5RPidTaoxaqKAih0oDO3h1CzqEqALxEdCnyIAza0B
	oyZY38lFdGFM8GmWO8yc5w6N+6iOKHEgltC/EIQBC+LwD/1GqpDjKaQH/r0paCbcKrfWux+9DWk
	ZC1K/gLPVVFWF2D/A0vb9AhRyoovpKhlg6Kh4QyIrgiPJUlrmAwJE1rX6WqcAZtYo2p041ArKSV
	j/6r7dswkaJfQYXz3EEH/+dwhUqsjansOfSzf/6CTfL2PMBRgCgUUVvt735FyebAklVUaXBs0l7
	9o7ads/H3O0biVjKgOJeLEQgbWQ6bHmwbZaNXlVIXS/x2wk1Phh9sKQC2iJN2gAkDuJbWi1atzj
	8Seq+Ji3AAHssbF0EEuuMnSh4JQ==
X-Received: by 2002:a05:6000:2510:b0:439:8a13:2c65 with SMTP id
 ffacd0b85a97d-4399de27c06mr27623605f8f.37.1772558370676; Tue, 03 Mar 2026
 09:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302102726.1126019-1-xukuohai@huaweicloud.com> <20260302102726.1126019-4-xukuohai@huaweicloud.com>
In-Reply-To: <20260302102726.1126019-4-xukuohai@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Mar 2026 09:19:19 -0800
X-Gm-Features: AaiRm539mPHub3uCS2S3noHSaRKoMrdKE-keShol4azTs2yNuhNZuM_iwYbvnNE
Message-ID: <CAADnVQLoWzz8ioVg3MFjn08fBLfNq6HdvqLtqXV0zUb=SR_HGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/5] bpf: Add helper to detect indirect jump targets
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	Anton Protopopov <a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 2:02=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Introduce helper bpf_insn_is_indirect_target to determine whether a BPF
> instruction is an indirect jump target. This helper will be used by
> follow-up patches to decide where to emit indirect landing pad instructio=
ns.
>
> Add a new flag to struct bpf_insn_aux_data to mark instructions that are
> indirect jump targets. The BPF verifier sets this flag, and the helper
> checks it to determine whether an instruction is an indirect jump target.
>
> Also add a new field to struct bpf_insn_aux_data to track the instruction
> final index in the bpf prog, as the instructions may be rewritten by
> constant blinding in the JIT stage. This field is used as a binary search
> key to find the corresponding insn_aux_data for a given instruction.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/bpf.h          |  2 ++
>  include/linux/bpf_verifier.h | 10 ++++++----
>  kernel/bpf/core.c            | 38 +++++++++++++++++++++++++++++++++---
>  kernel/bpf/verifier.c        | 13 +++++++++++-
>  4 files changed, 55 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 05b34a6355b0..90760e250865 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1541,6 +1541,8 @@ bool bpf_has_frame_pointer(unsigned long ip);
>  int bpf_jit_charge_modmem(u32 size);
>  void bpf_jit_uncharge_modmem(u32 size);
>  bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
> +bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, con=
st struct bpf_prog *prog,
> +                                int insn_idx);
>  #else
>  static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
>                                            struct bpf_trampoline *tr,
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c1e30096ea7b..f8f70e5414f0 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -577,16 +577,18 @@ struct bpf_insn_aux_data {
>
>         /* below fields are initialized once */
>         unsigned int orig_idx; /* original instruction index */
> -       bool jmp_point;
> -       bool prune_point;
> +       unsigned int final_idx; /* final instruction index */
> +       u32 jmp_point:1;
> +       u32 prune_point:1;
>         /* ensure we check state equivalence and save state checkpoint an=
d
>          * this instruction, regardless of any heuristics
>          */
> -       bool force_checkpoint;
> +       u32 force_checkpoint:1;
>         /* true if instruction is a call to a helper function that
>          * accepts callback function as a parameter.
>          */
> -       bool calls_callback;
> +       u32 calls_callback:1;
> +       u32 indirect_target:1; /* if it is an indirect jump target */
>         /*
>          * CFG strongly connected component this instruction belongs to,
>          * zero if it is a singleton SCC.
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 7702c232c62e..9a760cf43d68 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1486,13 +1486,41 @@ static void adjust_insn_arrays(struct bpf_prog *p=
rog, u32 off, u32 len)
>  #endif
>  }
>
> +static int bpf_insn_aux_cmp_by_insn_idx(const void *a, const void *b)
> +{
> +       int insn_idx =3D *(int *)a;
> +       int final_idx =3D ((const struct bpf_insn_aux_data *)b)->final_id=
x;
> +
> +       return insn_idx - final_idx;
> +}
> +
> +bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, con=
st struct bpf_prog *prog,
> +                                int insn_idx)
> +{
> +       struct bpf_insn_aux_data *insn_aux;
> +       int func_idx, subprog_start, subprog_end;
> +
> +       if (!env)
> +               return false;
> +
> +       func_idx =3D prog->aux->func_idx;
> +       subprog_start =3D env->subprog_info[func_idx].start;
> +       subprog_end =3D env->subprog_info[func_idx + 1].start;
> +
> +       insn_aux =3D bsearch(&insn_idx, &env->insn_aux_data[subprog_start=
],
> +                          subprog_end - subprog_start,
> +                          sizeof(struct bpf_insn_aux_data), bpf_insn_aux=
_cmp_by_insn_idx);
> +
> +       return insn_aux && insn_aux->indirect_target;
> +}
> +
>  struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, s=
truct bpf_prog *prog)
>  {
>         struct bpf_insn insn_buff[16], aux[2];
>         struct bpf_prog *clone, *tmp;
> -       int insn_delta, insn_cnt;
> +       int insn_delta, insn_cnt, subprog_start;
>         struct bpf_insn *insn;
> -       int i, rewritten;
> +       int i, j, rewritten;
>
>         if (!prog->blinding_requested || prog->blinded)
>                 return prog;
> @@ -1503,8 +1531,10 @@ struct bpf_prog *bpf_jit_blind_constants(struct bp=
f_verifier_env *env, struct bp
>
>         insn_cnt =3D clone->len;
>         insn =3D clone->insnsi;
> +       subprog_start =3D env->subprog_info[prog->aux->func_idx].start;
>
> -       for (i =3D 0; i < insn_cnt; i++, insn++) {
> +       for (i =3D 0, j =3D 0; i < insn_cnt; i++, j++, insn++) {
> +               env->insn_aux_data[subprog_start + j].final_idx =3D i;
>                 if (bpf_pseudo_func(insn)) {
>                         /* ld_imm64 with an address of bpf subprog is not
>                          * a user controlled constant. Don't randomize it=
,
> @@ -1512,6 +1542,8 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf=
_verifier_env *env, struct bp
>                          */
>                         insn++;
>                         i++;
> +                       j++;
> +                       env->insn_aux_data[subprog_start + j].final_idx =
=3D i;

You're adding final_idx because bpf_jit_blind_constants()
doesn't call adjust_insn_aux_data() ?

imo that's an ugly workaround. Just call adjust_insn_aux_data().

And in the future please mention such design decisions in the commit log,
so that reviewers don't need to reverse engineer your thought process.

pw-bot: cr
