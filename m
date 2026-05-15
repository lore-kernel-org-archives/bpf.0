Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E003E9C3C
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778882945; cv=pass; b=t2E2c6UMqILTX4kj/II3qVlulplO+6c2BgFUk2+x+IhDlgXneW9u79U3zT+VjuK6/14WfJKmP9zluO2V7Bb/kk+n2VMaIPT2SQFCMFrhAD7qwO82cvDUd0+By2lzQ2h2ziqioex2IVqWRZcMiWcHakK/nE9J+t5jkTxRUOuRqvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778882945; c=relaxed/simple;
	bh=YVwB9DoQtNZEjnYZQW3oUv008ilx2B127G+xZaTScgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAybyArPN6buYnlPpg/5ouPcOBtxPaIIAVCJgL8Cc3tK497HjCACqQUq1ssky/pQGlSwbKi2yubMXP1NgSFkXyphyU3IIkWzdYmCpTbLLKPbL3ce1um35d4TPIav29MvNlhagCFQ7gpOw6z2rwAgzsGNzttWTwUWQDNp4QMCPDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OySwgNAG; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OySwgNAG"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7b9f54d3deso223896a12.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 15:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778882943; cv=none;
        d=google.com; s=arc-20240605;
        b=QxYsJ5VEQlBP5/VUEAuxcpyjmi83pJHQttgfw3RvKRxDfkxn/CJLfFnCLW8NdtwItu
         Qr3JK0jsUW3geaXXetZ6zBcROhmpBtO/AEnJQHJ7jL94vzIJ7ILd4KS0MZEqc1nTelZr
         xxFo+Sfl76u9+xDbGYZLrjHjcq65wUyCwQTvEy+VK8AO5WR2+j32YwGTd5hkpFzuPVaI
         mCZAtmFVqq0pqcFBY4qWK08GQVkDC3bq/kqkmcymxAUa4z/QTKj0Q6iktIRG7ZJEr+Mf
         SUpBMUy97Ja1mptNdYLGUTeRxSq2q9rz5iv2D4k+mbjF9qSyMKQSPiT/shrzkUEwMD+/
         dKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bV/SnkCZ7V87DqdZrvi78Zo7YiHPOqPV1+82oecwMko=;
        fh=tuR/1y15E2vlhK/7VR2B6icjRuDGR6RX24D7F+7ZLIw=;
        b=Wqj/ocIKCxQU5RlbE6rQ3c0xrSaU01zEuSRMZ5C1Of1C4Wz3iOZXaN9S2UBDWKFPDv
         Qq19QDUc54L40hQKv/hfo78AyOt+aDgw0R2Wg2hnryIc9wgtuRSVB0a3utsJLfUs/oE0
         SH2VQjmsk+9dXGHXuxMB++iLT4aPO/ET/5cFbi6LTG4mtEZR7GeytJ81lc2cSENHUk5e
         XuPSikAs9e67zUmVbhvTRIkfRmqogYwuHX6ibmhmr0b6oIUyvzqXsWJh+35OTHi2hmBG
         FWXgbK54SpDFDR4KXOxZicccFs1syaw9VAa1DyYhHIpzgGuTcBhN1Pu4wumdViRZuxQB
         fLRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778882943; x=1779487743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bV/SnkCZ7V87DqdZrvi78Zo7YiHPOqPV1+82oecwMko=;
        b=OySwgNAGMYVmSHzSaxHtZU+XAaPvculmq4OOhWt81IR8Egus8DRqOklChU9V5byRyQ
         BtTn4/1vPx7SeYC3d1688kHmsIDuH3tM+3VRygPUh2/s9S9Ub3DbVD+5omXYFRsLwd4v
         GRhw9Qb7Mr3gLH0VBQYD6rnhh83pVMzCyw0njUTZ+YcizV2p23Ey3xcacsT4vdHenUh0
         QK9pNdu/4NVjvizrC415ZQOZXBhD/H1mjnu9MpOxrdlnH3wEFvXpJvKVD9pMYJFLvf1G
         HwsR1jYfiBTQYDm9NDfsFF3l/mGstc56IoEbHeTzSfuXTB8y+pAKg39t5quAcx9G851W
         5RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778882943; x=1779487743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bV/SnkCZ7V87DqdZrvi78Zo7YiHPOqPV1+82oecwMko=;
        b=itwk4IM/8C+M5X7/WOS7En2WvGAULk4ehogLlvC9LBLDU1sMjwKIMa9RGQUmHI9Ck0
         k88cOYzvVd25mxCTlmbXeaLwMBVdROvtJJXmYMN+Ccj3a/dCdyKqXS+sPxhV5rjVpJ96
         hsKb8OBxfiMz2ECMEJ3asQOLsiIrmV0CL2a9vCUhTxKIVdMMFfQ5PmTTsF5CRW9RyG0v
         4oDoOwu7TFW0KAZbfwozzXsF+O2aH+KUlcmTR33WVtzOEls2Cnb+G2wnoQTsmpj65Fnd
         I6WjBH1DZuy2fw3wTWa5nPbuoBsWuQKkVoxi8X8tRun1Zy8ZTcmuUVIbDtnN/nvq6sSP
         OhPw==
X-Forwarded-Encrypted: i=1; AFNElJ8ldAlIbYNQEqv9a/JbJlTmZ2qryfQV4WnMX0zXvUpIUQE94ZNdcMte/OedGz2O+grjgXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+tb+TUCDPruKQhowAErKB5wfRhWaUhuCwzA5XboDcEa1z19W
	Hhx6IK5F6fUWZHVnXFdz2F9ftvxrdTe7D25bkFSJtGucLe1W6b3gVE8/3Yvi2vy0PoSyhYPfilb
	0ekmYwF8l073HiZnS7UN9i861tgXC4Z0=
X-Gm-Gg: Acq92OHdTgU7+LN1XZxCG7CdRjWXP12En4wVJolun//cjBzwjBm7DQonGtoZZvQ265K
	LXRBydbdsHJKGWBfH/G/4G1Lvn9jxhIYwZtNK0mHNMW5qf8P6/OqeXGg4T81X7KzIFDalbVD52N
	jVsAnFg4h0bXGxKhyxcz0gaCBdJmPqjXFWUhMKKRUDCvNsWXc7R9c8/fZfb4bpgxVRMtiQKhHKE
	cRLImqPSZgST+yoM7Vfy6VNprKnqKS6/+obfjWB+mkYsSwcCGcSHN8OIjlG6j+/gVY1BKXEwCYc
	bB3AoMMoRXFkCZdJ+s7aju36ZESLD3Qk0Q==
X-Received: by 2002:a05:6a21:338e:b0:398:af16:f19f with SMTP id
 adf61e73a8af0-3b22ed7d835mr6239943637.44.1778882943216; Fri, 15 May 2026
 15:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89d34016-cf82-4beb-989c-e4fc2e3cd29e@gmail.com> <20260515044759.2863546-1-cmllamas@google.com>
In-Reply-To: <20260515044759.2863546-1-cmllamas@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 May 2026 15:08:47 -0700
X-Gm-Features: AVHnY4Kg0GKoReDES6mOBOVQp0NTr_iIyW-bqPt8LkC5lrnNDV7MsFgOEaf1u0E
Message-ID: <CAEf4BzZMoWdgYFGXwT9kkZ1TKbe9ZB=XKJCuKy0+2uqzSMDMUw@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: fix UAF in strset__add_str()
To: Carlos Llamas <cmllamas@google.com>
Cc: mykyta.yatsenko5@gmail.com, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Mykyta Yatsenko <yatsenko@meta.com>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 9:48=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> strset_add_str_mem() might reallocate the strset data buffer in order to
> accommodate the provided string 's'. However, if 's' points to a string
> already present in the buffer, it becomes dangling after the realloc.
> This leads to a use-after-free when attempting to memcpy() the string
> into the new buffer.
>
> One scenario that triggers this problematic path is when resolve_btfids
> attempts to patch kfunc prototypes using existing BTF parameter names:
>
>  | resolve_btfids: function bpf_list_push_back_impl already exists in BTF
>  | Segmentation fault (core dumped)
>
> Compiling resolve_btfids with fsanitize=3Daddress generates a detailed
> report of the UAF:
>
>  | =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  | ERROR: AddressSanitizer: heap-use-after-free on address 0x7f4c4a500bd4
>  | =3D=3D1507892=3D=3DERROR: AddressSanitizer: heap-use-after-free on add=
ress 0x7f4c4a500bd4 at pc 0x55d25155a2a8 bp 0x7ffcef879060 sp 0x7ffcef87881=
8
>  | READ of size 5 at 0x7f4c4a500bd4 thread T0
>  |     #0 0x55d25155a2a7 in memcpy (tools/bpf/resolve_btfids/resolve_btfi=
ds+0xcf2a7)
>  |     #1 0x55d2515d708e in strset__add_str tools/lib/bpf/strset.c:162:2
>  |     #2 0x55d2515c730b in btf__add_str tools/lib/bpf/btf.c:2109:8
>  |     #3 0x55d2515c9020 in btf__add_func_param tools/lib/bpf/btf.c:3108:=
14
>  |     #4 0x55d25159f0b5 in process_kfunc_with_implicit_args tools/bpf/re=
solve_btfids/main.c:1196:9
>  |     #5 0x55d25159e004 in btf2btf tools/bpf/resolve_btfids/main.c:1229:=
9
>  |     #6 0x55d25159cee7 in main tools/bpf/resolve_btfids/main.c:1535:6
>  |     #7 0x7f4c78e29f76 in __libc_start_call_main csu/../sysdeps/nptl/li=
bc_start_call_main.h:58:16
>  |     #8 0x7f4c78e2a026 in __libc_start_main csu/../csu/libc-start.c:360=
:3
>  |     #9 0x55d2514bb860 in _start (tools/bpf/resolve_btfids/resolve_btfi=
ds+0x30860)
>  |
>  | 0x7f4c4a500bd4 is located 13268 bytes inside of 2829000-byte region [0=
x7f4c4a4fd800,0x7f4c4a7b02c8)
>  | freed by thread T0 here:
>  |     #0 0x55d25155b700 in realloc (tools/bpf/resolve_btfids/resolve_btf=
ids+0xd0700)
>  |     #1 0x55d2515c426c in libbpf_reallocarray tools/lib/bpf/./libbpf_in=
ternal.h:220:9
>  |     #2 0x55d2515c426c in libbpf_add_mem tools/lib/bpf/btf.c:224:13
>  |
>  | previously allocated by thread T0 here:
>  |     #0 0x55d25155b2e3 in malloc (tools/bpf/resolve_btfids/resolve_btfi=
ds+0xd02e3)
>  |     #1 0x55d2515d6e7d in strset__new tools/lib/bpf/strset.c:58:20
>
> While resolve_btfids could be refactored to avoid this call path, let's
> instead fix this issue at the source in strset__add_str() and avoid
> similar scenarios. Let's simply check whether 's' is already within the
> strset data buffer boundaries, and skip appending it at the end of the
> buffer again.
>
> While already here, also fix strset__find_str() which suffers from the
> same problem by factoring out the common operations into a new helper
> function strset__offset() as suggested by Mykyta.
>
> Fixes: 90d76d3ececc ("libbpf: Extract internal set-of-strings datastructu=
re APIs")
> Suggested-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
> v2:
>   Implemented the fix in strset__offset() helper as suggested by Mykyta.
>   Added support to handle "substrings" of existing ones.
>   Used 90d76d3ececc as Fixes tag as suggested by Sashiko.
>
> v1:
>   https://lore.kernel.org/all/20260513232055.1681859-1-cmllamas@google.co=
m/
>
>  tools/lib/bpf/strset.c | 70 ++++++++++++++++++++++++++----------------
>  1 file changed, 43 insertions(+), 27 deletions(-)
>
> diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
> index 2464bcbd04e0..e50da238914d 100644
> --- a/tools/lib/bpf/strset.c
> +++ b/tools/lib/bpf/strset.c
> @@ -107,25 +107,53 @@ static void *strset_add_str_mem(struct strset *set,=
 size_t add_sz)
>                               set->strs_data_len, set->strs_data_max_len,=
 add_sz);
>  }
>
> -/* Find string offset that corresponds to a given string *s*.
> - * Returns:
> - *   - >0 offset into string data, if string is found;
> - *   - -ENOENT, if string is not in the string data;
> - *   - <0, on any other error.
> +/* Returns the offset of the string in set, and populates *grow* with th=
e
> + * length which set needs to grow by to include *s*.
>   */
> -int strset__find_str(struct strset *set, const char *s)
> +static long strset__offset(struct strset *set, const char *s, long *grow=
)

tbh, it seems like

>  {
> -       long old_off, new_off, len;
> +       const char *strs =3D strset__data(set);
> +       long len;
>         void *p;
>
> -       /* see strset__add_str() for why we do this */
> +       /* Check whether 's' is already within the buffer */
> +       if (strs && s >=3D strs && s < strs + set->strs_data_len) {
> +               *grow =3D 0;
> +               return s - strs;
> +       }
> +
> +       /* Hashmap keys are always offsets within set->strs_data, so to e=
ven
> +        * look up some string from the "outside", we need to first appen=
d it
> +        * at the end, so that it can be addressed with an offset. Luckil=
y,
> +        * until set->strs_data_len is incremented, that string is just a=
 piece
> +        * of garbage for the rest of the code, so no harm, no foul. On t=
he
> +        * other hand, if the string is unique, it's already appended and
> +        * ready to be used, only a simple set->strs_data_len increment a=
way.
> +        */
>         len =3D strlen(s) + 1;
>         p =3D strset_add_str_mem(set, len);
>         if (!p)
>                 return -ENOMEM;
>
> -       new_off =3D set->strs_data_len;
>         memcpy(p, s, len);
> +       *grow =3D len;
> +
> +       return set->strs_data_len;
> +}
> +
> +/* Find string offset that corresponds to a given string *s*.
> + * Returns:
> + *   - >0 offset into string data, if string is found;
> + *   - -ENOENT, if string is not in the string data;
> + *   - <0, on any other error.
> + */
> +int strset__find_str(struct strset *set, const char *s)
> +{
> +       long old_off, new_off, grow;
> +
> +       new_off =3D strset__offset(set, s, &grow);
> +       if (new_off < 0)
> +               return new_off;
>

I'm not a fan of bypassing strs_hash, tbh... see below

>         if (hashmap__find(set->strs_hash, new_off, &old_off))
>                 return old_off;
> @@ -141,25 +169,12 @@ int strset__find_str(struct strset *set, const char=
 *s)
>   */
>  int strset__add_str(struct strset *set, const char *s)
>  {
> -       long old_off, new_off, len;
> -       void *p;
> +       long old_off, new_off, grow;
>         int err;
>
> -       /* Hashmap keys are always offsets within set->strs_data, so to e=
ven
> -        * look up some string from the "outside", we need to first appen=
d it
> -        * at the end, so that it can be addressed with an offset. Luckil=
y,
> -        * until set->strs_data_len is incremented, that string is just a=
 piece
> -        * of garbage for the rest of the code, so no harm, no foul. On t=
he
> -        * other hand, if the string is unique, it's already appended and
> -        * ready to be used, only a simple set->strs_data_len increment a=
way.
> -        */
> -       len =3D strlen(s) + 1;
> -       p =3D strset_add_str_mem(set, len);
> -       if (!p)
> -               return -ENOMEM;
> -
> -       new_off =3D set->strs_data_len;
> -       memcpy(p, s, len);
> +       new_off =3D strset__offset(set, s, &grow);
> +       if (new_off < 0)
> +               return new_off;

I agree that this is a usability problem, but I'd handle it by
recalculating s pointer to correct one if it happens to be coming from
invalidated strs_data. Something along the lines of:

const char *old_data =3D set->strs_data;
size_t old_data_len =3D set->strs_data_len;

p =3D strset_add_str_mem(...);
if (!p)
    return -ENOMEM;

if (p !=3D old_data && s >=3D old_data && s < old_data + old_data_len)
    s =3D p + (s - old_data);


At this point s will be correct even if it was invalidated.

pw-bot: cr


>
>         /* Now attempt to add the string, but only if the string with the=
 same
>          * contents doesn't exist already (HASHMAP_ADD strategy). If such
> @@ -172,6 +187,7 @@ int strset__add_str(struct strset *set, const char *s=
)
>         if (err)
>                 return err;
>
> -       set->strs_data_len +=3D len; /* new unique string, adjust data le=
ngth */
> +       set->strs_data_len +=3D grow; /* new unique string, adjust data l=
ength */
> +
>         return new_off;
>  }
> --
> 2.54.0.563.g4f69b47b94-goog
>
