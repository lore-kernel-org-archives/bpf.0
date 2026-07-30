Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76915476042
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453466; cv=pass; b=Iyzq3DVtyyUjkgLEgt0oouMPqCXYD+sxYMC3AoNoTHiRdTXnKQ0sH7sucPzXVOwyExvZUBxBuc6tgLRpd16YlT4eA2V2eRQENKgWNF95TP3xwuZZiBhAtIsJR7god0unSsEojbwWpRZb5K6ykRdo7gPg1pvmgEzvUcf5HRjgMK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453466; c=relaxed/simple;
	bh=uH7ghrXluYE2TY6jBIOVAseYWUaqLO51qwkHccqB7P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIQ/hhU+7o9vlm6vVJy9zqWW0oVYHoMfLkW4NbsAJXXRFejSa3YSOJoW8ymkySPzt2uFReSlXRT6axUSA6BjPRZ3ciRzKAEPj2ZTpz0ECU2rxqO62/b2EacOporI3WXjpGB2lm6zeHUDH67Ekkk7UQV+KUFlb0iVwO1wy1NWGB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXFkkdpd; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXFkkdpd"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8484f229529so378656b3a.2
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 16:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785453462; cv=none;
        d=google.com; s=arc-20260327;
        b=gxUfNSr2FO9zjgrZ9MoKncefWRSz/1RDo4XgdjLy+t61W0IpPeI7mukRIxqV2jS/Lk
         2jgz65yHgMOP2wIB0NWShVIYk3NZdKSPGWeXOj1tO/oSLeA84cVTrEcfoIc8MKkcsail
         fSixvQDfowz7Qg8oWpBxWWlGzFr/isPZzy9uFiHzenmR9V5e+KlIROgFhAEcQWim6Z7k
         YUmA8Y+5h/5DRGwWF/jvbkiLWi9Q3a2HRARvyXSS1jCx0VdFYBoYftXcyTzjyEHYAWnC
         ed8J3aPZ9yBv02Mn9tTaXlG+Tm7sFnB7c9aYgLBZGl1HtX72/2EFy/fFWNJQODTShOQX
         dsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HN7zDDQbvlDZjNwY0qPH1mYkjJsN1iMdoFqR902Gxck=;
        fh=TrNSs3/0oK4GYMUnj5VWuOR7cPgFcoBpEuE9R4IfYYI=;
        b=HvejAuzIGZUaGn2Y8s4tiu0jTVyS77anGjVdUR1IFOiEayqJRMTAlcGGJQ3y8Q2qLq
         kqFUaJVjv9KaRvJnL4nupMG9u4PvEbm8o5NG4EFkLNrCiy/c9sR4ay+wRW6JohUZ5zCh
         2h5TvgX6DZwaj+a8HoctJ2Z+VhHOcQ7YWWOq0BSWjHxvmvBsBj3SVIGb+KOgqjmoKAXs
         t9LScuKASxR8iFbONIf8pLCFXKRh44lKXtXJm8Ga6tLlga4XgI+OhwwTbw4FURHqiCQF
         GsqrL0828bnZCrIioDHRB7k5u07L2ZJB3JOxNr87RHGL07dvnt6cfdoAk9kdv08wNks2
         JwfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785453461; x=1786058261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HN7zDDQbvlDZjNwY0qPH1mYkjJsN1iMdoFqR902Gxck=;
        b=TXFkkdpdH+5ySWventRqqUJX5UCGui/4ksmJJCbk7xBUZYmRuudCo7Esqe1uDyCa9T
         jwKFtBFVzyZ335WeWVxyr6ddShW6HYZr74/HnHDQRju0J8WPBdxJJ245IIiv2TTV0dFx
         IfzC2bA3jenJSvZ/pX0b0Tfr1sak7kkHDJ9f1QZFNHkem72f9O10HZ11a2EdmxXTULE3
         n6QFYCyOMtWmoUS+klxWmu02hiO7Zr7Lhp4fgQr/HGupH+IZRe04aHl5kKIS7NcQTk5L
         D5vp6iSmUIyT7TkMekhWBGrvHg2dXD39rjSond/4MIkK6GFm9zFDsqNopSlDGnpI/LdF
         oeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785453461; x=1786058261;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HN7zDDQbvlDZjNwY0qPH1mYkjJsN1iMdoFqR902Gxck=;
        b=H8uxA8yjdU5+uJLEuEwROlSN+HyRsGOEX/UTbLdRJEcgufAt9GDAfGaFvDQWf9Jq9m
         oC29+Q4IA084qPU+k3zpGO/YenF8hPs8nKcI/iDPSEO7t8ym5QalWOiVUU6T6jLEmpYI
         JANnopaW6O28CnFfQMAMOrV182dAR8eS3442DIG2nFhQRECcNohZvm4BLnacamPkOreF
         0mHCttvg1ma5HJHb4HoeX2oPZv8gLRmaGZPqmzc/HHMuwgi2POmCPW/JDlILDbqy9Ly4
         Y8VgQvQBb7qxA18vEAEWH/PfGsw/IokNNC09c6whe73H0seRCDsOcNgLA8gP7OdGz67Y
         RX9g==
X-Gm-Message-State: AOJu0YxKr2UOgr6FQofW8uuTCxeVEdkjFUbCbW97aFIa5Onouth98JDH
	8rgEgmA/GYuUR0d/30eDMM4fvd9ZIywjyEC21PAjWFZtl0E27v1+C5ikCYU+V69roT+4VYCMwTA
	PdiPCHf8TYWQzzhfUsuOD5Oq1zHFSt0Q=
X-Gm-Gg: AR+sD10qdQ58Jlt8F7l8FeCXBCprGVVaHAUYDeF2cmc2D8LK21p3o/EO6PtW4Y4FOVK
	Mps9OdISUZuXFhrrL0e8OpVKRDS9aVidVCFffLHmkRd0aFYLX1XI6O2Mfi0EXUWzSpqVKzpyV8d
	NCLnBTjMO1vDFGlrUM9qMGCqe1VqJ2u0678RyIEk/OWxtaleJfRzTV0Mpjt/38Zjq9IOK6OftOb
	XXW/9IUWvCsSu+jkSWBOPCReMEDr3Jc7lmDRB2pG/L90+FvSUIvtssw7i+pXyXbw3XXVGO9vYIQ
	MRCCpureJJtSNoHMql9nbddWkKnWgfip/5/xDdwKHV32/pxvSuDpNknv0q7m3jAtLBu8A4XWtxR
	1ue0qrEGMaLc/ordryZlVmeIMWbvb73OTO1vOEnQKQw==
X-Received: by 2002:a05:6a00:b8a:b0:845:d285:3b6e with SMTP id
 d2e1a72fcca58-84ebc424114mr3604060b3a.58.1785453461591; Thu, 30 Jul 2026
 16:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728145727.45153-1-leon.hwang@linux.dev> <20260728145727.45153-2-leon.hwang@linux.dev>
In-Reply-To: <20260728145727.45153-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 16:17:26 -0700
X-Gm-Features: AUfX_mymg7vnw0zG7lfwWFkM5C6NQ6YmwTk13yZtxM7GCJ5dcRiiAY94zhjDPU8
Message-ID: <CAEf4BzaDhyPm4ERJi_0BTW3jLaqVfYybLKDWg6Pub2=8Ca7P3A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/6] bpf: Optimize string scan kfuncs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Rong Tao <rongtao@cestc.cn>, 
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>, Viktor Malik <vmalik@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 7:58=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Use aligned nofault word loads for the strchr, strrchr, and strlen
> kfunc families. Align once, hoist the full-word boundary, and use
> word-at-a-time masks to skip irrelevant words or locate the first
> matching or NUL byte.
>
> Factor the common unaligned-byte, aligned-word, and byte-fallback
> plumbing into an expansion macro. Keep algorithm-specific actions expande=
d
> at each call site.
>
> Allow the shared finder to match both ASCII case variants so the
> case-insensitive substring kfuncs can use the same word-at-a-time scan.
>
> If a word load faults, retry from the same address byte-at-a-time. Keep
> the byte path under KMSAN to avoid reading uninitialized storage beyond
> the terminator, and preserve the existing limits and error semantics.
>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/helpers.c | 180 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 141 insertions(+), 39 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 88b38db47de9..36075c683166 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -30,6 +30,8 @@
>  #include <linux/irq_work.h>
>  #include <linux/buildid.h>
>
> +#include <asm/word-at-a-time.h>
> +
>  #include "../../lib/kstrtox.h"
>
>  /* If kernel subsystem is allowing eBPF programs to call this function,
> @@ -3727,6 +3729,95 @@ __bpf_kfunc void __bpf_trap(void)
>   * __get_kernel_nofault instead of plain dereference to make them safe.
>   */
>
> +/* Abstract the common unaligned-byte, aligned-word, and byte-fallback s=
can. */
> +#define bpf_str_for_each_word(s, limit, pos, word, byte, byte_label,   \
> +                             byte_action, word_action, err_label)      \
> +do {                                                                   \
> +       __label__ byte_label;                                           \
> +       size_t __word_end;                                              \
> +                                                                       \
> +       if (IS_ENABLED(CONFIG_KMSAN))                                   \
> +               goto byte_label;                                        \
> +                                                                       \
> +       for (; (pos) < (limit) &&                                       \
> +              !IS_ALIGNED((unsigned long)((s) + (pos)), sizeof(word)); \
> +            (pos)++) {                                                 \
> +               __get_kernel_nofault(&(byte), (s) + (pos),              \
> +                                    unsigned char, err_label);         \
> +               byte_action;                                            \
> +       }                                                               \
> +                                                                       \
> +       __word_end =3D (pos) + round_down((limit) - (pos), sizeof(word));=
 \
> +       for (; (pos) < __word_end; (pos) +=3D sizeof(word)) {            =
 \
> +               __get_kernel_nofault(&(word), (s) + (pos),              \
> +                                    unsigned long, byte_label);        \
> +               word_action;                                            \
> +       }                                                               \
> +                                                                       \
> +byte_label:                                                            \
> +       for (; (pos) < (limit); (pos)++) {                              \
> +               __get_kernel_nofault(&(byte), (s) + (pos),              \
> +                                    unsigned char, err_label);         \
> +               byte_action;                                            \
> +       }                                                               \
> +} while (0)
> +
> +static __always_inline int bpf_str_find(const char *s, size_t limit, uns=
igned char c,
> +                                       bool ignore_case, bool nul_is_mat=
ch)
> +{
> +       const struct word_at_a_time constants =3D WORD_AT_A_TIME_CONSTANT=
S;
> +       const unsigned char match_c =3D ignore_case ? tolower(c) : c;
> +       const unsigned char alt_c =3D ignore_case && islower(match_c) ?
> +                                   toupper(match_c) : match_c;
> +       const unsigned long repeated_c =3D REPEAT_BYTE(match_c);
> +       const unsigned long repeated_alt =3D REPEAT_BYTE(alt_c);
> +       unsigned long word, zero_data, char_data, alt_data;
> +       unsigned long zero_at, char_at, alt_at;
> +       const bool has_alt =3D alt_c !=3D match_c;
> +       unsigned char sc;
> +       size_t pos =3D 0;
> +
> +       bpf_str_for_each_word(s, limit, pos, word, sc, byte_at_a_time, ({
> +               if (sc =3D=3D match_c || (has_alt && sc =3D=3D alt_c))
> +                       return pos;
> +               if (sc =3D=3D '\0')
> +                       return nul_is_match ? pos : -ENOENT;
> +       }), ({
> +               zero_at =3D has_zero(word, &zero_data, &constants);
> +               char_at =3D has_zero(word ^ repeated_c, &char_data, &cons=
tants);
> +               alt_at =3D has_alt ? has_zero(word ^ repeated_alt, &alt_d=
ata, &constants) : 0;
> +               if (!zero_at && !char_at && !alt_at)
> +                       continue;
> +
> +               if (zero_at) {
> +                       zero_data =3D prep_zero_mask(word, zero_data, &co=
nstants);
> +                       zero_at =3D find_zero(create_zero_mask(zero_data)=
);
> +               } else {
> +                       zero_at =3D sizeof(word);
> +               }
> +               if (char_at) {
> +                       char_data =3D prep_zero_mask(word ^ repeated_c, c=
har_data, &constants);
> +                       char_at =3D find_zero(create_zero_mask(char_data)=
);
> +               } else {
> +                       char_at =3D sizeof(word);
> +               }
> +               if (alt_at) {
> +                       alt_data =3D prep_zero_mask(word ^ repeated_alt, =
alt_data, &constants);
> +                       alt_at =3D find_zero(create_zero_mask(alt_data));
> +                       char_at =3D min(char_at, alt_at);
> +               }
> +
> +               if (char_at <=3D zero_at)
> +                       return pos + char_at;
> +               return nul_is_match ? pos + zero_at : -ENOENT;
> +       }), err_out);

looking at the above code, I'd say it's just not worth it. Too much
code and complexity, IMO. For the absolute majority of BPF programs
this small speed up won't matter, while for those BPF programs where
doing tons of bpf_strstr-like operations is the essence of those
programs and has a huge impact on the performance, they can basically
implement and maintain this complexity in their own code base.

> +
> +       return pos =3D=3D XATTR_SIZE_MAX ? -E2BIG : -ENOENT;
> +
> +err_out:
> +       return -EFAULT;
> +}
> +

[...]
