Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7230B51A
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774096668; cv=pass; b=ge2CG9zK8I/A62gMv6kgoQ5GOOgbnpht9DKrjTyrvSWpNdcTUbhWep3VO766/c5Bpnwd77skYyF8J1LL5ow+yQKGDtsOz/mqPCp233tMNJJK8LuwO1ivbeqXByIwNa09+iEM78tIcR9mbPwPUZo5I/0YQcqSWbHcsT5SJSghH2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774096668; c=relaxed/simple;
	bh=ldYXzSM0a4a6oZo8VSiYbhjlglQ/I/gBNkLRtQjLpAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxe0f+Y2CzqPApvPhWz57QJgoOyhA9ZbdqGGcmhkn4H0Qm7eME3R8mjIeoFc5qY/vjVSDdk83cUf0p032b5CAwH4PXDfEeAosb6am575GmJ3wIz5shh9786k0w1oJRalOuaVIQPWNHZxG17X2u340o9gEViGP+82HP1me32Z7cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6qWHIEc; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6qWHIEc"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a2ee65171so14243337b3.2
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 05:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774096666; cv=none;
        d=google.com; s=arc-20240605;
        b=PNpzmohWZUdh9NwFPFv1s5rMwQJa11ThOv3VbMeS/ge1mAt8Wp6mjIYKwPHcBnO2+e
         lk+1iHytiyergSbt2W9DtBfHMEIu619LD2lsYlTpSDzaV76A7afE+RoCxDhP3Xf0U7lR
         WHBTg96dlDQ5xwOem/9XzqRiwU2hlhAhPMadlVsxHk4vvfBeOJds0NBIThhleCWHLjcx
         V+p94FH2hh09jwiu9d+DueYv+R4SZ9zWqcCqJim7LH5eIWQlaIUt8FejEtqTKw1aw3tM
         exkgvKhVrApT4zqbvP61yoZGlASqX2AMrqC/Us8Mls1bcVR1GQUhdHOUmFC6VtDmVE83
         vQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dpFgoUOdRN5iYXgRsH3KmveUpjhuVCY3dYwmKgUMeiU=;
        fh=vIEityhx54bHkEtbC9HwFahNah0rhatAPpNbbI3JcsI=;
        b=c2JTMNkk8uObgegroCYCdYh25A+Am2qcshSzxxqjJTlUJeicrz+dBfWCNgNP1eKOfT
         fIm8cmWHLa5hM7aftQ7KFAJxmfeqZ1QngeXSAi2yl3YOCFMcttTIYqsgM+nUHyRX0O1w
         8kP6qQr9HCOAHi88H+r9Kp88E09tFEiQjshsXlrWI5VRIfK5At49/DwmWt4NIUX6RDQ6
         hQqBCIcGNcdyRtFgJozYANLy0IFMPGE2IxgYGhHyvKtto5BiILJzmPUHLq+IteYQXwdF
         QSFIpcg/25lGz4cJ3pXkfJVBS7QwMvmoI/NkMF01NNEVGPedwTP3FxDxH/q6k58r58bb
         n99g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774096666; x=1774701466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpFgoUOdRN5iYXgRsH3KmveUpjhuVCY3dYwmKgUMeiU=;
        b=P6qWHIEcB2q+BwKJTwQiy0R7Lrn0RPBuQPUfAfAbadxtRU+8LGn/B/ZLrMtwAc4Pki
         nnGiv9oRPepfCcxusE7aOWprFyDon/94dMJvG4rYiAG8+WBmUK+Bi1dw1N2B4k1bYxxq
         oZS4llV4730IsuHZZrVrS0ueCL49Ywv3XRRGYHQOSQ2DdNHXAkj5uN0HuUmYfk4s6O95
         lED8tss/lPyVR4jjFfBU8bpcy0QF18RqqBJ/nUi5ua5c7IEWDnIWE/fDUIxgcEHaFmt4
         vdu23Ivwd2XmS0HDQdJrPxhxJR5R3kq5Yw7tBmQ7xw4MPqx32eL0ge5CwvQ6mkIbgjEJ
         PMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774096666; x=1774701466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dpFgoUOdRN5iYXgRsH3KmveUpjhuVCY3dYwmKgUMeiU=;
        b=eafcZfFFrj0nLGboQS3GP/ieSKWBmgeuf6rnfEyX+xUnODoHt/NKkikdcrseGFq6f/
         utOUenlTmUjRE9/ozbFJPY6GCRrZhLsFEM+DgkJcpzmmWI9IFMiArBBLrrF1KIWE1i7D
         T7Eb9ZA5fqtWouAmNo8SPhinvWW+n4BXNQFrtUVbrWQxFjexHSDsWyhlIWMeKC6a81EF
         fpWhEzRSHx8Rm+llqS5jtiZ4mmwqmAhXAVXDoEr8VpClIT1+G2Hn/cR5ZAcSW1LaUPVw
         0QabC7CEaDRFEzlb8c4wA9PRwYG2It6DhfEuCff3D+0nu1+3Vu7pCl2VfBTYMY4fcpsz
         vpaA==
X-Forwarded-Encrypted: i=1; AJvYcCX6IbpoVHtBRoL1bVTyFvKx+Pijez/Df06KrrxkULIs7AFK37mw8aUMf9gPZIP2RxU86XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4intfceShZXIC5RdyOt/oyvjdzJMIX9sDpAdkst/kw0MoqnO3
	EWGBB05PQoxsrIYzNMO7sL2EGIdIbCPY+6i9EdJGXBKbc9nxxcxBZnlY9cGh7zeGnmyui8SmwZG
	q9bAj/86nCY13ssHkIWMwUkIYdUPZmTI=
X-Gm-Gg: ATEYQzypijR0AAp5bsQTvzML4YzJgyGfVqYnoE0Otc/dAAbER/7h5Iv16y+txTKOqrQ
	S2cAotf+dKcN4TO9OhIVkDa+lmGhLqDCmU8gJDCsz4bo09BmkI4mcmkDKTxFEeqPlmzoMxWP0kI
	0fHtdb8hhQv+Q8YI4YDj4Fbm+n/GxI0kH5P1vDGdqoXXF1sZiUhC5n1sZ3IX4wrOXcCEnUBp2rb
	JW2p9eV1k46M76tFQMehS9Yyw9lXNxXzpQxHKqjOPDMOOQEYxmN2ZgHm1nUQxptxX9BhGcHtN4Q
	qBh1Wfk=
X-Received: by 2002:a05:690c:c50f:b0:79a:67a0:adf1 with SMTP id
 00721157ae682-79a90c0fe7amr63690597b3.45.1774096666368; Sat, 21 Mar 2026
 05:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321024446.692008-1-irogers@google.com>
In-Reply-To: <20260321024446.692008-1-irogers@google.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sat, 21 Mar 2026 20:37:33 +0800
X-Gm-Features: AaiRm53HFbDIUrKe-Rb86baRpuN3IFWOmDLCJEUpczYt3PQeQaZg_ARK_0C0sVY
Message-ID: <CABFUUZHL=kzBKZTkrCADyxkMp3BHXMhMKAuBFqYvNpqST4v3fg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] libbpf: Fix strict aliasing violations in hashmap
To: Ian Rogers <irogers@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 10:45=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> The hashmap implementation contained strict aliasing violations.
> Specifically, the hashmap_cast_ptr(p) macro was casting pointers (such
> as void **) to long *, and these were subsequently dereferenced in
> functions like hashmap_insert(), hashmap_find(), and hashmap_delete().
>
> C's strict aliasing rules (C11 6.5/7) prohibit accessing an object
> through an lvalue of an incompatible type. Dereferencing a long * to
> write to a void * object is a violation, even if they share the same
> size, as they are not compatible types. This can lead to undefined
> behavior, especially with aggressive compiler optimizations.
>
> Fix this by:
> 1. Updating hashmap_insert(), hashmap_find(), and hashmap_delete() to
>    take void * for their output parameters (old_key, old_value, and
>    value).
> 2. Modifying the implementation to use memcpy() and memset() for
>    accessing these output parameters. Accessing an object as an array of
>    characters (as done by memcpy) is a permitted exception to the
>    strict aliasing rules.
> 3. Updating the hashmap_cast_ptr(p) macro to return void *, ensuring
>    compatibility with the new function signatures while preserving the
>    static assertion that ensures the pointed-to type matches the size of
>    a long.
>
> Input parameters (key and value) remain as long, as they involve value
> conversion rather than incompatible pointer dereferencing, which is safe
> under strict aliasing rules.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/bpf/hashmap.c | 21 +++++++++++----------
>  tools/lib/bpf/hashmap.h |  8 ++++----
>  2 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
> index 140ee4055676..ef50d262a126 100644
> --- a/tools/lib/bpf/hashmap.c
> +++ b/tools/lib/bpf/hashmap.c
> @@ -8,6 +8,7 @@
>  #include <stdint.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> +#include <string.h>
>  #include <errno.h>
>  #include <linux/err.h>
>  #include "hashmap.h"
> @@ -153,24 +154,24 @@ static bool hashmap_find_entry(const struct hashmap=
 *map,
>
>  int hashmap_insert(struct hashmap *map, long key, long value,
>                    enum hashmap_insert_strategy strategy,
> -                  long *old_key, long *old_value)
> +                  void *old_key, void *old_value)
Maybe we should be more cautious about changing the API definition.
It weakens the interface for no clear benefit.
>  {
>         struct hashmap_entry *entry;
>         size_t h;
>         int err;
>
>         if (old_key)
> -               *old_key =3D 0;
> +               memset(old_key, 0, sizeof(long));
>         if (old_value)
> -               *old_value =3D 0;
> +               memset(old_value, 0, sizeof(long));
Using memset() here and memcpy() below make sense for addressing
the strict alias issue, but I don't think that requires changing the API.
>
>         h =3D hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
>         if (strategy !=3D HASHMAP_APPEND &&
>             hashmap_find_entry(map, key, h, NULL, &entry)) {
>                 if (old_key)
> -                       *old_key =3D entry->key;
> +                       memcpy(old_key, &entry->key, sizeof(long));
>                 if (old_value)
> -                       *old_value =3D entry->value;
> +                       memcpy(old_value, &entry->value, sizeof(long));
>
>                 if (strategy =3D=3D HASHMAP_SET || strategy =3D=3D HASHMA=
P_UPDATE) {
>                         entry->key =3D key;
> @@ -203,7 +204,7 @@ int hashmap_insert(struct hashmap *map, long key, lon=
g value,
>         return 0;
>  }
>
> -bool hashmap_find(const struct hashmap *map, long key, long *value)
> +bool hashmap_find(const struct hashmap *map, long key, void *value)
>  {
>         struct hashmap_entry *entry;
>         size_t h;
> @@ -213,12 +214,12 @@ bool hashmap_find(const struct hashmap *map, long k=
ey, long *value)
>                 return false;
>
>         if (value)
> -               *value =3D entry->value;
> +               memcpy(value, &entry->value, sizeof(long));
>         return true;
>  }
>
>  bool hashmap_delete(struct hashmap *map, long key,
> -                   long *old_key, long *old_value)
> +                   void *old_key, void *old_value)
>  {
>         struct hashmap_entry **pprev, *entry;
>         size_t h;
> @@ -228,9 +229,9 @@ bool hashmap_delete(struct hashmap *map, long key,
>                 return false;
>
>         if (old_key)
> -               *old_key =3D entry->key;
> +               memcpy(old_key, &entry->key, sizeof(long));
>         if (old_value)
> -               *old_value =3D entry->value;
> +               memcpy(old_value, &entry->value, sizeof(long));
>
>         hashmap_del_entry(pprev, entry);
>         free(entry);
> diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
> index 0c4f155e8eb7..a888bf8c05de 100644
> --- a/tools/lib/bpf/hashmap.h
> +++ b/tools/lib/bpf/hashmap.h
> @@ -116,7 +116,7 @@ enum hashmap_insert_strategy {
>         _Static_assert((__builtin_constant_p((p)) ? (p) =3D=3D NULL : 0) =
||                 \
>                                 sizeof(*(p)) =3D=3D sizeof(long),        =
                   \
>                        #p " pointee should be a long-sized integer or a p=
ointer");      \
> -       (long *)(p);                                                     =
               \
> +       (void *)(p);                                                     =
               \
>  })
>
>  /*
> @@ -128,7 +128,7 @@ enum hashmap_insert_strategy {
>   */
>  int hashmap_insert(struct hashmap *map, long key, long value,
>                    enum hashmap_insert_strategy strategy,
> -                  long *old_key, long *old_value);
> +                  void *old_key, void *old_value);
>
>  #define hashmap__insert(map, key, value, strategy, old_key, old_value) \
>         hashmap_insert((map), (long)(key), (long)(value), (strategy),  \
> @@ -147,14 +147,14 @@ int hashmap_insert(struct hashmap *map, long key, l=
ong value,
>  #define hashmap__append(map, key, value) \
>         hashmap__insert((map), (key), (value), HASHMAP_APPEND, NULL, NULL=
)
>
> -bool hashmap_delete(struct hashmap *map, long key, long *old_key, long *=
old_value);
> +bool hashmap_delete(struct hashmap *map, long key, void *old_key, void *=
old_value);
>
>  #define hashmap__delete(map, key, old_key, old_value)                 \
>         hashmap_delete((map), (long)(key),                             \
>                        hashmap_cast_ptr(old_key),                      \
>                        hashmap_cast_ptr(old_value))
>
> -bool hashmap_find(const struct hashmap *map, long key, long *value);
> +bool hashmap_find(const struct hashmap *map, long key, void *value);
>
>  #define hashmap__find(map, key, value) \
>         hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
> --
> 2.53.0.959.g497ff81fa9-goog
>
>
