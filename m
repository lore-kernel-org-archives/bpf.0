Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D770923ABB9
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266151; cv=pass; b=mLro8lrszSowi7oiZL6vIXRiteOoKWifEKu2jFZJYWq20rST/ExmrtmimjbddmnlfOsu3+BclkKkUO3NbkEbcU6Mq7pNjFSxVFJE8Oam2S5APwfcDWLqnsQMFL+D1USYt+tpFb0uQPKjmuLZhytSRtmWGmM87eZdk6KGrPidqkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266151; c=relaxed/simple;
	bh=MahSrqLDYZgcCSnQXbJvJA4ds9Jyo62y5vMoFtBVKTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNjTQUQq0aNCerXNjP0x8EnXhqAZh7ApHnKUAecqAbciHbi5AH/reOoS30tiVEbM58S/fJKkLyJLpr+riC2S+xXJGYSUyGGb+fVppQfeV0H/7nnhjOwqhEeL9IhHNSgErbcd66dEEyDMkpQCughjtIW5Q5oA3IseXAbJwsQpSic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/J0xjuJ; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/J0xjuJ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8299f1ca894so196685b3a.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 14:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773266149; cv=none;
        d=google.com; s=arc-20240605;
        b=fkUEs18IE2dXwhpcnQi+3Vwq7PaqHs/jNRzW2sRqlOcLri3TruhCUa4VqUjbv+Ome7
         EsMmbmFLGyaUBZHYuTmu5ICRrfcYu+nLXlhhWdfIXjpE1fXOqqMskXKqwQ0vvv8GWJnY
         hoWypdZTI07ElGJVQQaL4Biaag4IeyQlVVFPI+XCbV7RnYdL9iABpEOL5KoWsGGY/iVw
         q9n6ERUM4taAnPHOqdECGYK0X2WiWQcuFs5xYgpU0hS9Hk0JfSx2U5IQouWbnxyU4WPz
         gsFvveBnU0rwHfp3psy9P6X9nMO4iqOgDsN0SmEzngwWe1kjZyLjLRLx6Kmtf1HD/Zu3
         yvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PolrGNrN8v5vl9MZ7nmCqzTd9hT7eSXkSoKDfYU1uTo=;
        fh=HFezYODqB0dHS8ZckTal1iiWnuisbLhk4gui7Bi0T/g=;
        b=ajHMHM99vs84SuCcf0N3vLT1MoqVfyfVYX4oT9HSE/3QLToJyuKlcUtWe/K68RMylQ
         gFnBYDGtCHKLIXcs/Yb7j0p7rJmbFcjuwuSmsi50p99QpNE8dYe18xDw9dLSJJhvjUPm
         v74oxICQv5uY51aGZ0ha2ru05aQZE5UC9WnKCi9wTfH9+PbosK49SKlS5CAr0Bpv17/D
         vC/RwaGTSd5pIWgnPO0uSI+u7s44m2EliIdU9tZEbDwm/EpD0J/MFV8aDxXoJvxWU97E
         oIULqxWKiO3kmeRzArMWGrzVV700i3rQYUHYqIYg2oHNhsiJuSmYK28cmZUmJnkwuDjQ
         7Lgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773266149; x=1773870949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PolrGNrN8v5vl9MZ7nmCqzTd9hT7eSXkSoKDfYU1uTo=;
        b=f/J0xjuJL3fJZeNNADU7faRUYBuzDnciYfypIn/Q4qOPLppB9hIoMgql0K6OAKQaV3
         zgPY9+g6A86Jnb79Xdi+Nv6c0Px3HXc6eJwlJOQ+a2IW5HshZa8+g8bVyvsvsesoA7AX
         Btp5ZLp4NpymldtPLGUg3uaDOMXFIbGAsIPSnfXTA7EDsawDYgeSMW00M3OSMQrQuDms
         AxBbJjrKVumBUTedXtMcCErsETMFVzc6lmITFSKtCdDxMSaYafsgWgmAqy6sNkcpOtuy
         2Sxp/vE/vw7jVU8VzMdjHex3QTNmkPHeOpRKf6qhC7K44wJziOnVbJtaIufejAS0AbtQ
         Iu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773266149; x=1773870949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PolrGNrN8v5vl9MZ7nmCqzTd9hT7eSXkSoKDfYU1uTo=;
        b=PytyBM0M6NfpPjvDakD9PkMG8c7oCZB1WPmnZybNJ7lQFaS9WlAtVeNiuUviUZXKsx
         ueSHX0fFThV4GNUnI8DPvDfvlJJ+jkLdVDXre9SwpB5ZI/V2UM4pWakzTis8nYdObic8
         tqSTj/UsLo1h6dofmfJSK3EdoAKZ0KD1VgR5Exla2+0UYhnXJMu0kSj/GGpiMtTRW244
         lIp7AgmZ4+9L4kycnoyW0OMLLJoblerTF8lctwVKCQvjjgR7ZD4eqGyrc4NLQNxz51rN
         Mmy53rE74RLJcPzLZscyj7aX5xE+wcXsuVHB3lWDNk6nsAJSmDhn3eScXjX6njfewLfq
         uKMw==
X-Gm-Message-State: AOJu0YyqbVLjIsYciLGYpWoo4heNcWSD6Aft8dFOdbzG4zFieySkS+vo
	nN252XzNuO7LJ7J1wo25sEjBLlmc8y9JOeKVcMPC0usII1065M3b3+RvD5BKQTi6AZAhRiGluED
	TJZpqfNzNN4HECBbt8yQ4Z8/5Bq8X9R53HZhN
X-Gm-Gg: ATEYQzzEJ6TwFTz+/i0dj4Sjv6ZIwtYekc+3WXYplyInUKzBOEjy+vVtY617qioyrvg
	ubyhmMaqH/PaGWdITmVMc3edzUIBTH13X2uRhR6W0u5r4rq/zhqP2pADykKr6GDvqtvll1EWOiR
	Le/LECwb6YIlSDqjGAHANbm7xFXpvQPN5RRmfQ8YbmxMCY5muQnAuhgRREpXeT01KFc1FDQ8vmn
	wUrYs7IIyRzA5TRFP5RYI8VHW5VG3DPFOyKkVxWzz1FPHVcwTNrHNHjC2IzTICuWaUGLavCaU5x
	qzDsm78=
X-Received: by 2002:a05:6a00:2d28:b0:81e:c67a:1a79 with SMTP id
 d2e1a72fcca58-829f6ec4863mr3698583b3a.25.1773266149145; Wed, 11 Mar 2026
 14:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-6-ameryhung@gmail.com>
In-Reply-To: <20260307064439.3247440-6-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 14:55:35 -0700
X-Gm-Features: AaiRm52eCJzfPSFUWrlGtQvYkTOCEjIgp7Uc7ph63emkxA69h0KfqjvrrU11yjs
Message-ID: <CAEf4BzZACu7YVvFt__iR=rhMCoA2cpbD0wqswz31JXU+BD-RMA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 05/11] bpf: Preserve reg->id of pointer
 objects after null-check
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
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
>
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
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ea10dd611df2..8f9e28901bc4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17014,15 +17014,10 @@ static void mark_ptr_or_null_reg(struct bpf_fun=
c_state *state,
>
>                 mark_ptr_not_null_reg(reg);
>
> -               if (!reg_may_point_to_spin_lock(reg)) {
> -                       /* For not-NULL ptr, reg->ref_obj_id will be rese=
t
> -                        * in release_reference().
> -                        *
> -                        * reg->id is still used by spin_lock ptr. Other
> -                        * than spin_lock ptr type, reg->id can be reset.
> -                        */
> -                       reg->id =3D 0;
> -               }
> +               /*
> +                * reg->id is preserved for object relationship tracking
> +                * and spin_lock lock state tracking
> +                */

Acked-by: Andrii Nakryiko <andrii@kernel.org>

nice to have one less special case

>         }
>  }
>
> --
> 2.47.3
>
