Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84F390CB4
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268017; cv=pass; b=FsciYROT8fJvOo+Mwn5PNCosdMRbs4baldQk7PNlew7mgBMTWxXEo+59ro2bAIliLy6fnNArAxxkupNNkeaHTCoXbl6J4EKDoMaMWUPNuDg2TjKdMkIpAf4uuSp70JD18k3iXVrcVDgJKHdQVOD9b7IhpoK2DLT+pWxB3WTT1AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268017; c=relaxed/simple;
	bh=r8jTi1Csxc7R0q0iu4I1AKO4pE2K1C13bkXgSq4z/Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wk/xD9U9mVF+zebQm7sXDcU+33t3hq9AXiytwFYmf1uZeitO1Xvg8jHPdbGzC2i1w1Ubu1omgFLKofOUe7dbG6QFxBs/csWxwPUihzhStnENuoWZe8QqKHXXIAsQJ86uMky8TrtFwQHaSdfHfyL2ZZ1KqNS6GQlk1p7TvPsy9ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAeE6Qas; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAeE6Qas"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48534e9076fso2881115e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 15:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773268014; cv=none;
        d=google.com; s=arc-20240605;
        b=EW3lsliTlCrKDFGQ3i8ysuYxXr2fxXGhq/TWw2mq8GjtEIUqO3RHuOjOeGHnIliAVv
         jlPK6Kl8lfM1hgPvSED0u5O+69sz1SkFMFU3k8ZkeOOpDIpgqXqTP0COFzphhwgdnUtj
         inqtJ/fIMeCiYHTTdcUwMFv3y0Y6RszlBxO0P61oVKCKoP1mVGNRD6xgfgBzRTcj11pW
         QZVZg6X291w7ojpwwWhsZnn9jBK6Nd8o8MFYZNtFLAiMRexdxF+WgDu4o7McEwhu11dD
         3qwTa53j+lUJqEAWcSCf1R0/3IpSS0R4BrzQwZgn8F2ww6okccgfqN/TMXMbsl9TWfAn
         /cxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=22t/Dvy/x6Uq+dtSCro/4b+TaKfnHX5FGmjqe92Ip0Q=;
        fh=8/eGpY56OCAcNRT79TToKWibOS8+tBpWsO7zhc/eZQ4=;
        b=GigxEgjRKbhK63mS7g9NzYp+Yd7Px3XkBrL2caohOybxJLWY4MekURKBd15C5f1guT
         T+tQNCu5bujir9DIZsdTXKWUwIbTpNNysniN0bvHX4cmaXlMuYfnbThZ2JdOrQkEzA7h
         /T5lE0VpTdcP82sFsMIyYXa3mdMYBlbUL45QZGnDw4Y8oJ+3w++hFv8IHaFUVQB453Xl
         qYlfP+yJPoWsHODI3HGBvC1G7AQOqNBLuIGrC0r3GFkgFAeLdfFCDQFivvrVyfw8OwC5
         hSrmO+KS2hIrfrnukwm4tlRWGov545sMm0EW5MADoIR6ii+0THXvlTseY7Wbnt45qg59
         JsKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773268014; x=1773872814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22t/Dvy/x6Uq+dtSCro/4b+TaKfnHX5FGmjqe92Ip0Q=;
        b=hAeE6QasMwmuLTHE5Xg04bjE3V7BkdjHL4LUN0xoUUrLfTAN6BnDVyxlrsVfx3lBn9
         Mr5Dwi4ymL2LO1LZmUDfiGyT5cgxcklDdsseiv+itOciC2bDOv5WJTYQZBmKkyAQigpS
         IfssUP5cOqPvDSB52qLl+VrnFI9Wau8qIomAX+lTabm0FZ5UsKkxZnC9h6oyaBENlTIQ
         eveqDqSWlTKx16YZBR/QewmQ1VMXMOH7frDFZWX5OdRLyXmFakQ6h35k3hOYG9jSW6cY
         UQMtPRTn5hTI6m28cICP0wTs+EXhdUM5t9ftFmYRYgzCYFA5WQKt3ztcIbQgyAgivWdm
         kChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773268014; x=1773872814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=22t/Dvy/x6Uq+dtSCro/4b+TaKfnHX5FGmjqe92Ip0Q=;
        b=Fgs2QWrOpMExfOCc7D3+ywxsTgDyYqeNf4cjqwmaFHdHpY858jJ7A7wr5TNsBUyG9+
         aoosFo9Tibq0aWBwsrZXihhDf0DmkGKMwQVKNE/0KZ+f3gJtluTfYrHZvdJhIn9InIOz
         15JdCDbPphhNDJ1DUaDRMnaMtfB1DQ+qjDIpcogSnJEEF87+03V52gmxVYb0TI/uRl9b
         WOh4OZyUADFJtlBo5atn4NvYRnsLgkEjkZIXwDaIhNeKeN0XvGiw3wdmog90CbbyZ2zQ
         aIJscznyakqKfQedROXoQaPuW0ewGxIppwCgNqucphQYFdsEXr1wBEHdinzq5opC1Vhk
         5bnQ==
X-Gm-Message-State: AOJu0YxOwTqaQTuezCUh56VCfGwghZekdXkH+iuUvhDvwvkxwkMBN+8w
	HRG64UGK1mmsaXokXeSWWMQhjUqtTl4pEe9BMrXzAF7us2yxCj921k3VTeWjeKzq3mgT9Q7DSos
	YK+bHCSKdzfQ2ne2ZiUU6cbyl6J4/S3I=
X-Gm-Gg: ATEYQzzRWa8BXHS2M9uBgdvQs00nqhKwjQlFamdrAHEoqa8YiPb8XwSAu/1ef8BmjrH
	cJn/sENb0pq9Usa8DMwcM/YhAsoDdaQ7MQ+HR4mDPw2nrWc0l/NT1bwcDvtCTn2TxYyfMYOrvVQ
	BZFbXWc5r6xwfgzGlSGQoJpQ+QZstAwBq+4iZPcNSVIXNWssA7e8StjriOhwL6tdFAqGWeOxjDm
	S9bpaTOeZBMIppQuwMQQgwky4UHmihf5SoyH6mu4rfvHCowbZJBgvAJG3/IFm44SPVapPzVg+cH
	ezFya+rrFVPyvmEG3s7dX0GM4rBMjvtzJziQ3loO27rANl44A7kdtHssVGMRizGdMBL59IkyfHS
	Aka07vZHP+4usEoaByND+WHLTkg==
X-Received: by 2002:a05:600c:8b13:b0:485:3c8f:e4c5 with SMTP id
 5b1f17b1804b1-4854b100f1emr75351175e9.17.1773268014330; Wed, 11 Mar 2026
 15:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-6-ameryhung@gmail.com>
In-Reply-To: <20260307064439.3247440-6-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Mar 2026 15:26:43 -0700
X-Gm-Features: AaiRm50uM1nDQ6hNKBviIGUZSODpYpE_TfMdI9RiPggFO3AjukNsZ_VG5AnuJl4
Message-ID: <CAADnVQKkXKyqqW5zFC+N2NaU+7wD1XouqF9T=ReNivCKDWcFiQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 05/11] bpf: Preserve reg->id of pointer
 objects after null-check
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Preserve reg->id of pointer objects after null-checking the register so
> that children objects derived from it can still refer to it in the new
> object relationship tracking mechanism introduced in a later patch. This
> change incurs a slight increase in the number of states in one selftest
> bpf object, rbtree_search.bpf.o. For Meta bpf objects, the increase of
> states is also negligible.
>
> Selftest BPF objects with insns_diff > 0
>
> Insns (A)  Insns (B)  Insns  (DIFF)  States (A)  States (B)  States (DIFF=
)
> ---------  ---------  -------------  ----------  ----------  ------------=
-
>      7309       7814  +505 (+6.91%)         394         413   +19 (+4.82%=
)
>
> Meta BPF objects with insns_diff > 0
>
> Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIF=
F)
> ---------  ---------  --------------  ----------  ----------  -----------=
--
>        52         57     +5 (+9.62%)           5           6   +1 (+20.00=
%)
>        52         57     +5 (+9.62%)           5           6   +1 (+20.00=
%)
>       676        679     +3 (+0.44%)          54          54    +0 (+0.00=
%)
>       289        292     +3 (+1.04%)          20          20    +0 (+0.00=
%)
>        78         82     +4 (+5.13%)           8           8    +0 (+0.00=
%)
>       252        320   +68 (+26.98%)          21          27   +6 (+28.57=
%)
>       252        320   +68 (+26.98%)          21          27   +6 (+28.57=
%)
>       119        126     +7 (+5.88%)           6           7   +1 (+16.67=
%)
>      1119       1128     +9 (+0.80%)          95          96    +1 (+1.05=
%)
>      1128       1137     +9 (+0.80%)          95          96    +1 (+1.05=
%)
>      4380       4465    +85 (+1.94%)         114         118    +4 (+3.51=
%)
>      3093       3170    +77 (+2.49%)          83          88    +5 (+6.02=
%)
>     30181      31224  +1043 (+3.46%)         832         863   +31 (+3.73=
%)
>    237608     237619    +11 (+0.00%)       11670       11671    +1 (+0.01=
%)
>     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02=
%)
>    237387     237407    +20 (+0.01%)       11651       11652    +1 (+0.01=
%)
>     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02=
%)
>      8103       8108     +5 (+0.06%)         459         459    +0 (+0.00=
%)
>      8076       8079     +3 (+0.04%)         457         457    +0 (+0.00=
%)
>      8177       8197    +20 (+0.24%)         459         460    +1 (+0.22=
%)
>      8083       8086     +3 (+0.04%)         458         458    +0 (+0.00=
%)
>    237608     237619    +11 (+0.00%)       11670       11671    +1 (+0.01=
%)
>     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02=
%)
>    237387     237407    +20 (+0.01%)       11651       11652    +1 (+0.01=
%)
>     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02=
%)
>      8103       8108     +5 (+0.06%)         459         459    +0 (+0.00=
%)
>      8076       8079     +3 (+0.04%)         457         457    +0 (+0.00=
%)
>      8177       8197    +20 (+0.24%)         459         460    +1 (+0.22=
%)
>      8083       8086     +3 (+0.04%)         458         458    +0 (+0.00=
%)

The table is missing names.
State columns can be dropped instead.

> Looking into rbtree_search, the reason for such increase is that the
> verifier has to explore the main loop shown below for one more iteration
> until state pruning decides the current state is safe.
>
> long rbtree_search(void *ctx)
> {
>         ...
>         bpf_spin_lock(&glock0);
>         rb_n =3D bpf_rbtree_root(&groot0);
>         while (can_loop) {
>                 if (!rb_n) {
>                         bpf_spin_unlock(&glock0);
>                         return __LINE__;
>                 }
>
>                 n =3D rb_entry(rb_n, struct node_data, r0);
>                 if (lookup_key =3D=3D n->key0)
>                         break;
>                 if (nr_gc < NR_NODES)
>                         gc_ns[nr_gc++] =3D rb_n;
>                 if (lookup_key < n->key0)
>                         rb_n =3D bpf_rbtree_left(&groot0, rb_n);
>                 else
>                         rb_n =3D bpf_rbtree_right(&groot0, rb_n);
>         }
>         ...
> }
>
> Below is what the verifier sees at the start of each iteration
> (65: may_goto) after preserving id of rb_n. Without id of rb_n, the
> verifier stops exploring the loop at iter 16.
>
>            rb_n  gc_ns[15]
> iter 15    257   257
>
> iter 16    290   257    rb_n: idmap add 257->290
>                         gc_ns[15]: check 257 !=3D 290 --> state not equal
>
> iter 17    325   257    rb_n: idmap add 290->325
>                         gc_ns[15]: idmap add 257->257 --> state safe

I'm not following. The verifier processes above as a bounded loop.
All 16 (NR_NODES) iterations.

Why presence of id on 'rb_n' makes a difference?
It will still process 16 loops.

Which insn is safe vs not in the above ?
One after gc_ns[nr_gc++] =3D rb_n ?
