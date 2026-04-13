Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203C2F363E
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120192; cv=pass; b=iZeWBaPnxLr8t9iRffOTQwKzdR73LP2UHPvMLZotj/IY5agtpGI4kZaiIC1vXGkMSbB6XZUb5A1QU4qHkIhuM96O+J6UJne3kCvG14IYvDnP2ofz+UUY2qz9G1SQWj/E38OjhZkE937wk0rPdXUYRP3BMEwxbb5R0yv6AjmkXis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120192; c=relaxed/simple;
	bh=7Vh/xRThuMxkq39SLCUw7mHkaLAoHrCFsNQaCE/BRVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irsdkNNpJkPt3rDY/X/fhdWf4T+eAkRIUbN5en4WDDRB9DjjqVihKDVXvL2h0cKVWTpqzIoBciaS3AsGjeGvkiSjymWIz/mQ8aVJBiYbVga5j5fhgCfGzla4qUEbHwx0mNgh8APYCVKOH1+PnKiYk8ceXRQH1IVZkfSESwsfBrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+ARTsX7; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+ARTsX7"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d72875729so1202174f8f.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776120189; cv=none;
        d=google.com; s=arc-20240605;
        b=ft2hhI31XTzedpUD+lD4Gxp40nEnDmqxcVeZFFe9fILxf1wTASJS2giO1HsLvA6Od5
         dLvwGeypgi27T3mWPBl8Pd8NQckiz38V5H5eWvk4nlgwT32TSPwL4VS7s+XlI7mZWW1U
         X+Vc4pAToL41voyyFpVn4aykRjmxwuGb3zo4rrl1hxEHmmj6PXIB6rsBrQqRJF+m0qAY
         n7JoRt5oOY5es/V5zcmnhoQdT78vDznweAr6qT5tO3kxIOuw0McQrTzHsPfAQSQXzuIl
         QiVVFOz/2yfwGUH5G6ndXzel3ibbtZhT2vyGmYKDsXeqnWzLRNTzpqYXy61bSmEjSQkY
         axzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tOjMhTLFWRpxMk1L8rCU6CCZDCbacWAit8SD8lXuyos=;
        fh=gOsrNFwNKu9DozX1Jd/mlmCgaWkGmde7k+khY9odpAo=;
        b=QUjQAssrAAwzpJYQN4aZuBzyHNzs4lINdnF0Rj+8ishjt7ni5P1BhLTZrSbKUkO3Rn
         RlY/va6hoN9NYvPdXOL+aHg9Ltz+X5SkcYXFm+uLbAXe9wLSEFOYmpzrESqUe9I/iMTG
         NpRgV/+XXV+PiwHOqr90FRk2Cg+rE5jqvINtoEQnIKJXvfcTsMhsqka9ECO9/Xxp0BrC
         LI8uhhVTaQhtAb5GsXnJDG+R5suEaRa7dOoLYujqdrJnAynjisvMeyUnDUX2dhYwPhon
         qdMYM17KP+EJeH+RNbgOZZdmWMgoiCoyNi4aGsdY0JieujChpTKCb+oTvCLj5VpmAPIe
         zp6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776120189; x=1776724989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOjMhTLFWRpxMk1L8rCU6CCZDCbacWAit8SD8lXuyos=;
        b=E+ARTsX7VWHdU5ESX9Fzu8RWMfvI7JN2GddYubAlKXNi9oYpzS5ZT4k9GHaPJeA4gQ
         XoggfOZ3/qvxjpqiXLASjmwO/ZZiy+iaUKcFw1X9b42ymLV7CjaQ+o9MPBg07nl99TUT
         9h2zF49227abwN/47Xl4Zj45SxPgsNZdhNGkYAK6eHSQkyPRnKfPYWfQTFOdVAS8RsAt
         mKJezqNnPRVB2nX2sfmsR5Yh7mKeckkziZdM5Qwasmazy18cP6UGZ602UnFZWFcFAQ/d
         RgKzpYLvPoFKhs82VrQcF8g0E8Q84VBVbiHglaomoIF+wiT5IdgTTbR3RQHiJ0Gl70Oz
         9kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776120189; x=1776724989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tOjMhTLFWRpxMk1L8rCU6CCZDCbacWAit8SD8lXuyos=;
        b=mraEZo9aY9Brj1iFTaLIMoy/pkuhNT6gscH8nTc5gksXdImMFJd3Z7qwykxzLb4Et0
         Hi4JA1ofkZaiPr5jBgSRew+TqWjh4xeAyFUBo7q6Y19fIyQ6Ww/0SsY1ZV4bxp3cHwgo
         PS2H8KYxzUcpNbgAlG5FXlhD1MseWjmEHk3IQYRSTbZXrU4JA7AiWXPdRr8kyifFKzSo
         votJLfVjuH1SpHVtMJiRJfuA+goUfdjpHUD+Y1NjmemTlmzPX+gEnpJPerE8nGHNTYED
         RpREMQo+imTbd1YronDPHSZ0Tx9QzRN2U4K5sC52L3NVMa8HLoBvIe11sX5Q8aCqeN8g
         m9xA==
X-Gm-Message-State: AOJu0Yzyh8dEt7OTH0xW0ZzFZjr9zArDnGR1c1CiQKbGCNLkPtDVWx+O
	wdSzfH3nlaozbc4bV+gmAmPGSmu7BH6BRSHVIH75Zr9Px21OS93qCTD/1BEkoaXCKFReHb+E35a
	YZKvDfRwCv/4EVh3VFL2r9EsEMJMhLVE=
X-Gm-Gg: AeBDies1bCoXwzK9UeTlGr/a0xJ06aoPyqEtFowRP16JMLfao1QfPdkPTUV2AeyfkD6
	UK2CkPyhsrJC1910cwYZ9piuKVc/G4wCgLNYaTtu0BVF85REriyoZYPYgp8J0wK0VMZThCD8NmK
	9BRrMTclIHT+P4LXr1u8BTpUvxmNR7L0D0tFf5pnvq9uWOIY4NVQZW3aEPA/iP/AxIUbrIaH4Z6
	aoCFtYifit7WQqUpyniKANJ4gmdm4+X9DKvMdsJzXSIy8PqdCvLkjfSKxQ07h5yArYdUN7/smy4
	uKzr9DSpkxhYHTB/Lyk0YHS2DOJQPBWfe2JhbXiNl77RJoCCmZvNIlTdVb4vuCKpYxoAt31adv9
	tK385KQVN3HwjnZ9WYeY32JOCi8joc5R7Sbi+
X-Received: by 2002:adf:f7d0:0:b0:43d:6a20:117c with SMTP id
 ffacd0b85a97d-43d6a2011abmr10535405f8f.17.1776120189241; Mon, 13 Apr 2026
 15:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-stacklive-fixes-v2-0-ff91c4f8d273@gmail.com> <20260413-stacklive-fixes-v2-1-ff91c4f8d273@gmail.com>
In-Reply-To: <20260413-stacklive-fixes-v2-1-ff91c4f8d273@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Apr 2026 15:42:56 -0700
X-Gm-Features: AQROBzCnSA9eU81UVeEOzfkyr689bwwLMG2JjFr9jZA3_qmgC97ui96Z_m0nDfc
Message-ID: <CAADnVQLfiX0B1Lg4-n8qFNztmM5BJNkWCYeE3RAT2qxtifuO0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: fix arg tracking for
 imprecise/multi-offset BPF_ST/STX
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 2:58=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> BPF_STX through ARG_IMPRECISE dst should be recognized as a local
> spill and join at_stack with the written value. For example,
> consider the following situation:
>
>    // r1 =3D ARG_IMPRECISE{mask=3DBIT(0)|BIT(1)}
>    *(u64 *)(r1 + 0) =3D r8
>
> Here the analysis should produce an equivalent of
>
>   at_stack[*] =3D join(old, r8)
>
> BPF_ST through multi-offset or imprecise dst should join at_stack with
> none instead of overwriting the slots. For example, consider the
> following situation:
>
>    // r1 =3D ARG_IMPRECISE{mask=3DBIT(0)|BIT(1)}
>    *(u64 *)(r1 + 0) =3D 0
>
> Here the analysis should produce an equivalent of
>
>   at_stack[*r1] =3D join(old, none).
>
> Move the definition of the clear_overlapping_stack_slots() in order to
> have __arg_track_join() visible. Remove the OFF_IMPRECISE constant to
> avoid having two ways to express imprecise offset. Only
> 'offset-imprecise {frame=3DN, cnt=3D0}' remains.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/liveness.c | 110 ++++++++++++++++++++++++++++----------------=
------
>  1 file changed, 61 insertions(+), 49 deletions(-)
>
> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 1fb4c511db5a..23d19147f123 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -574,7 +574,7 @@ static int print_instances(struct bpf_verifier_env *e=
nv)
>   *
>   *   precise {frame=3DN, off=3DV}      -- known absolute frame index and=
 byte offset
>   *        |
> - *   offset-imprecise {frame=3DN, off=3DOFF_IMPRECISE}
> + *   offset-imprecise {frame=3DN, cnt=3D0}
>   *        |                        -- known frame identity, unknown offs=
et
>   *   fully-imprecise {frame=3DARG_IMPRECISE, mask=3Dbitmask}
>   *                                 -- unknown frame identity; .mask is a
> @@ -607,8 +607,6 @@ enum arg_track_state {
>         ARG_IMPRECISE   =3D -3,   /* lost identity; .mask is arg bitmask =
*/
>  };
>
> -#define OFF_IMPRECISE  S16_MIN /* arg identity known but offset unknown =
*/
> -
>  /* Track callee stack slots fp-8 through fp-512 (64 slots of 8 bytes eac=
h) */
>  #define MAX_ARG_SPILL_SLOTS 64
>
> @@ -622,28 +620,6 @@ static bool arg_is_fp(const struct arg_track *at)
>         return at->frame >=3D 0 || at->frame =3D=3D ARG_IMPRECISE;
>  }
>
> -/*
> - * Clear all tracked callee stack slots overlapping the byte range
> - * [off, off+sz-1] where off is a negative FP-relative offset.
> - */
> -static void clear_overlapping_stack_slots(struct arg_track *at_stack, s1=
6 off, u32 sz)
> -{
> -       struct arg_track none =3D { .frame =3D ARG_NONE };
> -
> -       if (off =3D=3D OFF_IMPRECISE) {
> -               for (int i =3D 0; i < MAX_ARG_SPILL_SLOTS; i++)
> -                       at_stack[i] =3D none;
> -               return;
> -       }
> -       for (int i =3D 0; i < MAX_ARG_SPILL_SLOTS; i++) {
> -               int slot_start =3D -((i + 1) * 8);
> -               int slot_end =3D slot_start + 8;
> -
> -               if (slot_start < off + (int)sz && slot_end > off)
> -                       at_stack[i] =3D none;
> -       }
> -}
> -
>  static void verbose_arg_track(struct bpf_verifier_env *env, struct arg_t=
rack *at)
>  {
>         int i;
> @@ -863,16 +839,15 @@ static void arg_track_alu64(struct arg_track *dst, =
const struct arg_track *src)
>         *dst =3D arg_join_imprecise(*dst, *src);
>  }
>
> -static s16 arg_add(s16 off, s64 delta)
> +static bool arg_add(s16 off, s64 delta, s16 *out)
>  {
>         s64 res;
>
> -       if (off =3D=3D OFF_IMPRECISE)
> -               return OFF_IMPRECISE;
>         res =3D (s64)off + delta;
> -       if (res < S16_MIN + 1 || res > S16_MAX)
> -               return OFF_IMPRECISE;
> -       return res;
> +       if (res < S16_MIN || res > S16_MAX)
> +               return true;
> +       *out =3D res;
> +       return false;

Nice. It's almost check_add_overflow().
May be something like:
  s16 d =3D delta;
  if (d !=3D delta)
    return true;
  return check_add_overflow(off, d, out);

I'm curious whether asm will be better.
