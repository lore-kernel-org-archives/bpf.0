Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA693F1660
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787339339; cv=pass; b=utDCODT98oYEHbomvQ2OHEYDlGfHVptNMdDyal73Qiki6qsy7/VUTzJYBiLAHSv+S2mRuT4kaR6dh+gZlywutQeqhLBDexC/X7SXm+FqN/uUk3CWEm683EyzC/a8LdQY0qujuMqXNNbQ01ANr/x1dbXCiJhHipUeA7Se9l4+avE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787339339; c=relaxed/simple;
	bh=iqv2rkJF8eSzGCjN9ZXtqbShiu2zFTrqQsYmZRNDJl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgcdsKLI/l0mCWACwiaEggHkPwE8urQ6RY728tCA/Qwxyg8qRXsa64a9hJG14n2hAQWMMeKQsSE+zcTIBcaaSCZQU7v4t7jkB4c9+Ej6fonelgyYE/y9huO/hUDyaIWQCKILKIcUZyh34fx70yDzwEVyF50U5GMjRNlYc8vyZWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cW651f8B; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW651f8B"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc11a30a259so1389279a12.3
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 12:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787339336; cv=none;
        d=google.com; s=arc-20260327;
        b=pykuL2x0xmwxEd9r5RTa75claJYwb7hk0Iq1jdGIQmdpEwvJ++ftE2jTyeW4ngf1MF
         sv+yRyYp7IpzkGEeWYqctwZhddDHAJXA3yG1ttRWMVYW/0zXvUu6UI6Qonu4hwi5AFVC
         DI5RVvreuhp4UCY6NIN9dmBup7J/VDGUDEeBAlZrfV26yEI6/yqXOiTKHYgnO5zbPtCu
         /e7y1EDLDwti8wHt5qDoZV/tZVRVxMo3IbUdGPj4LjZTwAjDmGk97ydjIBqPkSavH4HU
         rzH0by9QiobtBLg4fD5ZA3uWnz5neStwZhTNORvU9Rs+lAACMwZz8NpvGhGdlZs/EChy
         fwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tFrE9qrzuWwtgawXVfC6qxWAZeTb87tpM0ZAlXruRzQ=;
        fh=VJPKWSlp+GT4iSADmMecTChluT+5BH5Z5F2D/ipqe7Y=;
        b=Ee59mIa19/O8ncAJzoDW2xgOYzBjuDgpsw0R0Nq/VDpI5OcllNvMJnTBmwVf4SCCR7
         LWD8kTk/oxtlKy5yIVDs9j5tGDjUtv3MzBElsE8xe9OLewKeBNE57S7oMhHdJ1h9LGLp
         2vdVI1t0zkNL3D8dqW3CI8FakpyG3JR+3o5Ap/2po/VKSe/odwuNh9EI7JeplSQStNO4
         /5iO0vdlPfyijxfZB8fCAaHCypJFVWmCNYh5jzyiiNwwPw5eTuplI7RsPzRpMGfQnIVq
         yG4ukTGrr1gUzQm1+1Dyfybs6PJisYRgbR5lnn5uIWgM0rKdxgBmLAkN1BYAnHqElVkx
         RpMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787339336; x=1787944136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tFrE9qrzuWwtgawXVfC6qxWAZeTb87tpM0ZAlXruRzQ=;
        b=cW651f8B7/9RLJCxZmD8WxlQmXdV6BfjOAzhm4eZMwnK/KVfxWjIWGl9nldjHtaor/
         +S86oTD+kinZKtCA991B+jJeoMI+3yeplefABTOsoNmPfy02T2t2mTZzfk+Fdyn6rGKl
         2bZztdX+L7R6PW1xIiZ9WzGY+m1h6AZwVtUP/qTdIDUX3YdXunlalqtR1c7VBC9i/F2D
         d8gDrAnMUAIw2GJIf8XvxqjNuQdRtL7ocVHWwVqiKCZ+V4j9D7TzvST48bOe8X4ZVBNf
         pIrIcIQINyQKV9oe5npV3zpxYp7DVq76V0D3B756wXxtHgS/O3hWMBNazy29//m1zOcg
         GGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787339336; x=1787944136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tFrE9qrzuWwtgawXVfC6qxWAZeTb87tpM0ZAlXruRzQ=;
        b=q+uCfp6dL2rMAFe6YH1DdoBgojvgTmEpNJjkyUQlxwsS945RcBGGsfhhaeHv6/5kDV
         7zALPs0R9x8FJSv1q18g1WsHRmrmi44puIFOdhSx7IlsMXnpnEIt11+1znAcapzekzuG
         JNZVnWWUaTeI1yPIXtP5ZlhPJWSgCAcK0nILgxDUv5JUuv1dPY9QqU+9Yu7X7Im9EJ6d
         RuuBFneCMUq46DfZEMw58KRAiHYDO2AjiiX/gxuNUkOmVRDrA3g4+cw1gX1sqPvrDrix
         hXpnuZ5PJsL/G7QkVuq7vVQRtCpBmiDsYYK0o5ctwKJOgAYpslqLfux7cduN+/QDdqq6
         vkRQ==
X-Forwarded-Encrypted: i=1; AHgh+Roxzmu53g67iPa++nB6bvvYfEQkqCLLizHgF/PSBepQmoEoeAjqoEWCjFFsnEmtQ0CJ2yk=@vger.kernel.org
X-Gm-Message-State: AFuF++mqa0IvonWzWfq3iiwA/CH2adxkFAsbKAuWj6J8pPhg31DooYQf
	X8hO8pElIXS6Uu5BeEcRmU6WPTHBDxyvhwG+oqkI7/NxDZLoEtIRlBEOTlevG6ZteB0+VZkGnJr
	xCkKRlbXbBsLuN8hn2JYScmGMpePqqFo=
X-Gm-Gg: AR+sD13gyJstaTtmAVte6aAZQIdBuxvXEIhRcGs4oTXpKJVlDkv1NEPohb/0Ja7YXbX
	Pl51+ZXUA1/11X0mRo/ZLkwDE2TK8hnxGzFU+TASex9X8BjrdO108jSumjKz6fUJaDxT8xiadmF
	QJb0qDQS5gVyqD/aTxMuA8+Dn3clQMGE+CB8PyJUL9ZS4tp/nHymuTg1QEZg7guakcfpg9IgQQj
	2WaFbRWtp8gs0pw+SkTSFeNPt3uyydRfkf0KOKt8zSCJNWrbDwS09SkblEBnT5WdmoVXwayxzmX
	xYjoGZwuj5JzyKLOx7uI/CN6dYkUyh5LG5IU3SkDNsjnK+Q5HBj8cNHyvFRh7U+gHTNzkhTRALS
	U3kA9ikeMqx+IKFDjkg+UlzDmpw==
X-Received: by 2002:a05:6a20:e211:b0:3b4:605c:2163 with SMTP id
 adf61e73a8af0-3cd4b9aaa10mr1486582637.4.1787339336508; Fri, 21 Aug 2026
 12:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820-bpf-kcsan-obj-memcpy-v2-1-672517a3145f@proton.me>
In-Reply-To: <20260820-bpf-kcsan-obj-memcpy-v2-1-672517a3145f@proton.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 12:08:43 -0700
X-Gm-Features: AcwNN1U8JQwQeOg02UWDQrf3RUfCpXl1ktS5uwpIILx0Au9h_YT4Mf6QjtUUDgA
Message-ID: <CAEf4BzYf+LBqAncYEJNLz8bhSU2HWvnOMzrRyMcr_uczd2MP_g@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Annotate bpf_obj_memcpy with data_race
To: quanyeyang@proton.me
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+44044637ef892e79ca2b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 4:11=E2=80=AFAM quanyeyang via B4 Relay
<devnull+quanyeyang.proton.me@kernel.org> wrote:
>
> From: quanyeyang <quanyeyang@proton.me>
>
> syzbot reported KCSAN write-write races when two tasks concurrently
> update the same map value. Both accesses reach the ordinary memcpy()
> paths in bpf_obj_memcpy() through copy_map_value().
>
> Unlocked in-place updates of published map values are intentionally not
> serialized and may produce torn values. Callers requiring consistency
> must provide synchronization appropriate for the map type.
> bpf_long_memcpy() already annotates the same behavior for long-aligned
> copies.
>
> Annotate the ordinary memcpy() sites in bpf_obj_memcpy() with
> data_race(), matching bpf_long_memcpy(). This documents the existing
> concurrency semantics and suppresses KCSAN reports for these intentional
> races without changing synchronization or map update behavior.
>
> Reported-by: syzbot+44044637ef892e79ca2b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D44044637ef892e79ca2b
> Signed-off-by: quanyeyang <quanyeyang@proton.me>
> ---
> The annotations remain in the common bpf_obj_memcpy() helper, matching
> bpf_long_memcpy(). This keeps the existing copy helper interfaces
> unchanged. A narrower annotation would require propagating the
> concurrency context through copy_map_value() or introducing separate
> copy helpers.
>
> The following checkpatch warnings are expected:
>
> - DATA_RACE is reported for the three annotations because checkpatch
>   only recognizes an immediately adjacent comment. Their shared
>   rationale is documented above bpf_obj_memcpy().
> - MISSING_FIXES_TAG is reported because the commit references syzkaller.
>   No Fixes tag is included because this documents long-standing
>   intentional lockless semantics rather than a regression introduced
>   by a particular commit.
> ---
> Changes in v2:
> - Drop the BPF_F_LOCK recommendation because it is unavailable for
>   per-CPU maps.
> - Scope the concurrency description to unlocked in-place updates of
>   published map values.
> - Fold the redundant commit message paragraphs.
> - Link to v1:
>   https://patch.msgid.link/20260820-bpf-kcsan-obj-memcpy-v1-1-372c5946226=
8@proton.me
>
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: Andrii Nakryiko <andrii@kernel.org>
> To: Eduard Zingerman <eddyz87@gmail.com>
> To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> To: Martin KaFai Lau <martin.lau@linux.dev>
> To: Song Liu <song@kernel.org>
> To: Yonghong Song <yonghong.song@linux.dev>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Emil Tsalapatis <emil@etsalapatis.com>
> To: John Fastabend <john.fastabend@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/bpf.h | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528445..10d1186ef3b4 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -560,7 +560,14 @@ static inline void bpf_long_memcpy(void *dst, const =
void *src, u32 size)
>                 data_race(*ldst++ =3D *lsrc++);
>  }
>
> -/* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could =
be one of each. */
> +/*
> + * Copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could
> + * be one of each.
> + *
> + * When this helper performs an unlocked in-place update of a published
> + * map value, the ordinary byte copies may intentionally race with
> + * concurrent updates and the resulting value may be torn.
> + */

kind of "obviously", so might as well keep original comment as is, IMO

>  static inline void bpf_obj_memcpy(struct btf_record *rec,
>                                   void *dst, void *src, u32 size,
>                                   bool long_memcpy)
> @@ -572,7 +579,7 @@ static inline void bpf_obj_memcpy(struct btf_record *=
rec,
>                 if (long_memcpy)
>                         bpf_long_memcpy(dst, src, round_up(size, 8));
>                 else
> -                       memcpy(dst, src, size);
> +                       data_race(memcpy(dst, src, size));
>                 return;
>         }
>
> @@ -580,10 +587,10 @@ static inline void bpf_obj_memcpy(struct btf_record=
 *rec,
>                 u32 next_off =3D rec->fields[i].offset;
>                 u32 sz =3D next_off - curr_off;
>
> -               memcpy(dst + curr_off, src + curr_off, sz);
> +               data_race(memcpy(dst + curr_off, src + curr_off, sz));
>                 curr_off +=3D rec->fields[i].size + sz;
>         }
> -       memcpy(dst + curr_off, src + curr_off, size - curr_off);
> +       data_race(memcpy(dst + curr_off, src + curr_off, size - curr_off)=
);
>  }
>

The change looks good, but Signed-off-by requires real and properly
cased full name, please update and resend the patch

pw-bot: cr

>  static inline void copy_map_value(struct bpf_map *map, void *dst, void *=
src)
>
> ---
> base-commit: bd5f485f3f026225b86573e559af0b7254ef4184
> change-id: 20260819-bpf-kcsan-obj-memcpy-67042b1fce7d
>
> Best regards,
> --
> quanyeyang <quanyeyang@proton.me>
>
>
