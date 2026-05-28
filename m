Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F634315F
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003891; cv=pass; b=VATxJ6CGVMVjP2FkskwsBuPrgzew3tFxtFDvj+lSixXZkEUQVjguWC4Hs7Y2BwjSX4GixE4cmykWymzn0eIRUFHNIiquLm598DXv4wCR6pOLn/8p68ellpw1JOYdOxOpO3TlAV8CY3tQW0LYDVJTN+HCL3ZqwHO52pKkw8KEE6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003891; c=relaxed/simple;
	bh=BouCpbErmx/D5gdUUiS4qRtSVzmo5rLtOV7sfs76P3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiEeF04U4VPF7CT4V8cLSTbtfnPfCsaGjgWDRr1aCK/35t14k32HCGQzND5jOTkNJmNqo1GfMeEEX0klcD4Ij8MHgeUTiOkhHQEhbJs18I6dMnyfJXQRJMBSaeouqp8yZEajKM2bsV/gG7U1C0tW8MEu3/6Lpa2o8LaRE5BZg8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZof4z8Z; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZof4z8Z"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso10410345b3a.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 14:31:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780003889; cv=none;
        d=google.com; s=arc-20240605;
        b=XBI/BzVsFK7Shr+tmCwCtt02VI2fRAivAB5NTOzbIJOxMr2Mpt0B7ujNrBxOEKaVOV
         tZHX0XBsRLYlcING/+ApcR20ySBIAfyHqgP65v2ltEuyXBqbCEZe29JMxFHO4p14zdzn
         NtzKYFluyKRDApeAU2NROgWaOH4rHx+bEE+EZq5Zs28mY2e/hvx9iLJCN1g0qmuEU72k
         RRlGPzCFCnDElggnSc32WmCsB3TKREEIbeWVXUBFmbedDbPUB0pUOuJnzL3SpoLx4zoo
         ME7WPFxyf7IBDnkNyM/SaKhh49lBn2Bam3ItAFavVxCHM5pdW3+YlL6Pbp6OI9r8jPWh
         7JYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LgANf8zW+eM7Aya9s7vWP6gTDd1WkHsKyeQI4vi2rC4=;
        fh=Td1gFA1clHr6maNZCKXg9S6SsD1XckfBdQ7bOe89SGA=;
        b=OpkviAoYr4wpNOgEg9Tnn7Y7VcwiCVy5k2f+QIVJN0ciVYVyJEr7Uwi9yZ34uzP0/B
         UyM6kTVUcPm6Df+xIwgXF8KA3VDUNr5z6vFtkSuLGt1MZc0uMzuepV1vpuR+g7rhk5LE
         4/tchu2F8My48JhHki1CrGgmrIXA6kjlukj7J2Svb8f2uQtqcY0fUO47yMGg5hGVj0i7
         jn5r4WjCdXBO8vAMvhqdk3kDWHjjrstCBROWVylWjgBH7gulhDHjdggpvdmrz0xnkTWy
         jetI2mtbsKfpTbWIWTKu6H1fCKClsTFSr9XpNWiTGlgcyYpCweFT/UQGXASRymycNchH
         cvsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780003889; x=1780608689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgANf8zW+eM7Aya9s7vWP6gTDd1WkHsKyeQI4vi2rC4=;
        b=VZof4z8Z2Sv7KtHDWIIW/YXI15ZWdRBwPQAcnCzOC3WqG3hTSLnqVQvmEgBhZnXelt
         ecI9WN6W/oBJEA2xmY/pibRxOmrSrRDhcHI4gwT+De8ZlWn2o0AnjYDF413YL8XRnYuf
         124PbQkQfvANRzWQbMQlenzwpTIBsRuC+SCLNrvWPZUwYYw98XQb8jhHSN1wTe/X60u+
         xg47/oHCM5+e5L58N7KFXskuIrgubkbsa+1s1DUWlLMFM2aWzeOA+f5VyDQGO6glThg9
         xlcpjdX4d++45WbZgyODiYRCVadSqZVCE8JwCmbdSP09sr0/0AWR6zkJe+dQnWQBtdtQ
         Inpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003889; x=1780608689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LgANf8zW+eM7Aya9s7vWP6gTDd1WkHsKyeQI4vi2rC4=;
        b=HdvWVHJF8ZfS4l8ibmGLPrPr08TSs/rSiZ9WBcm387/wNlXn/jQEJDP1MFWYeUE3Kx
         myfDefNX2DWXUGOnMWu3Y8W4Y2XR1ND/N6u5UqqFUikenM5t0vtOdjYFSwlmxhKZo+rG
         IFmxF2Cfrsbom3YMXPGMdmeGm2oTgaR8cjrggI7KtUegZziXjgrQv3gx/dlQPGVSW1xQ
         ELedE0sB3fekkscuS3CXDec+GF/5/cs0IL1Z2GJZW0+Qqmge7nBAXEGmAEbw/Gbb/X/a
         gLIQy36Q8nZVTNbuCI+c/0KEYOCUVr+Tmb4PrS75uxZWADT3X8pdkACEIN2/5nCA/QDO
         dbxA==
X-Forwarded-Encrypted: i=1; AFNElJ+EzVQ/pU6xNMCXskuNR1qebJMqLMZUdvl62MFV0gxl4eNMhrHiiO5G/6sB++aY72AQ/qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSYAvN4UmgBbWzWhGKXcIYhbBnQFzQuR9Sy2M52BkIfgMuu6nW
	9XLr2UYseXOeRE6m8ytzK9rabfbuXiXP+VQDw2HG4XDQ0OYH/t06SLKE+61NPbTquZ2pPF7Uzl7
	zRkvwGzQc3a0xEl+BDvwwMXMb0yt2H2A=
X-Gm-Gg: Acq92OGbvBUjpNuUywb1oYgnZe3R/z+Yr0znT1YJTiUSmmqKN1eyqGZCMy+y1ImZEn5
	GMMMPZcHFz5JLbw06j4JR6+d7CA0Bjf3aAxh7iFYcdiSqJvA1ntJMOvN8rk6pt40nUDOauO8O5t
	g300GLgd15xDUy5f/RSht6jBrnx73pQiTyByXvvKFyqjbPgZsI9gqR1EiqNLnuwVyZfieBYJ1CK
	UY97MfqD5aYwVd71si3wsfHxdEgSvO4oC0M3c+5RgO8y+8+/zdCuF8POYV9MPI8DE63EQ0FohUZ
	yGc/NPqNTelK0iCGZBfBej+IJovLAY4bKk3OU248pMK6
X-Received: by 2002:a05:6a00:2e03:b0:82f:2a78:6302 with SMTP id
 d2e1a72fcca58-8420cebe803mr640421b3a.26.1780003889124; Thu, 28 May 2026
 14:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzbM7G8nVqtrW+fs5J9Hm4cqszA9CTETBCHLP7T8GPMs3Q@mail.gmail.com>
 <20260523162722.2718940-1-cmllamas@google.com>
In-Reply-To: <20260523162722.2718940-1-cmllamas@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 28 May 2026 14:31:14 -0700
X-Gm-Features: AVHnY4L0oKhJzM7m98H1Fj3Skh4jLEd-l_M8iUVRdGyDezmBc27L6QbSy4LEu4I
Message-ID: <CAEf4BzZQ6_U5jRz-bsrSUsc=phze-cz8jEjLdD4t_89oiePEdw@mail.gmail.com>
Subject: Re: [PATCH v4] libbpf: fix UAF in strset__add_str()
To: Carlos Llamas <cmllamas@google.com>
Cc: mykyta.yatsenko5@gmail.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Mykyta Yatsenko <yatsenko@meta.com>, 
	"open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 9:27=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
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
> similar scenarios.
>
> Let's check if set->strs_data was reallocated and whether 's' points to
> an internal string within the old strset buffer. In such case, 's' is
> reconstructed to point to the new buffer.
>
> While already here, also fix strset__find_str() which suffers from the
> same problem by factoring out the common operations into a new helper
> function strset_str_append().
>
> Fixes: 90d76d3ececc ("libbpf: Extract internal set-of-strings datastructu=
re APIs")
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Suggested-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
> v4:
>   Store pointers as integers in advance before realloc to prevent UB.
>   Access set->strs_data directly, not through external API.
>
> v3:
>   Switch to 's' reconstruction approach suggested by Andrii.
>   Adjusted names and commit log accordingly.
>   https://lore.kernel.org/all/20260518050550.2600101-1-cmllamas@google.co=
m/
>
> v2:
>   Implemented the fix in strset__offset() helper as suggested by Mykyta.
>   Added support to handle "substrings" of existing ones.
>   Used 90d76d3ececc as Fixes tag as suggested by Sashiko.
>   https://lore.kernel.org/all/20260515044759.2863546-1-cmllamas@google.co=
m/
>
> v1:
>   https://lore.kernel.org/all/20260513232055.1681859-1-cmllamas@google.co=
m/
>
>  tools/lib/bpf/strset.c | 59 +++++++++++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 21 deletions(-)
>
> diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
> index 2464bcbd04e0..b9faca828f09 100644
> --- a/tools/lib/bpf/strset.c
> +++ b/tools/lib/bpf/strset.c
> @@ -107,6 +107,38 @@ static void *strset_add_str_mem(struct strset *set, =
size_t add_sz)
>                               set->strs_data_len, set->strs_data_max_len,=
 add_sz);
>  }
>
> +static long strset_str_append(struct strset *set, const char *s)
> +{
> +       uintptr_t old_data =3D (uintptr_t)set->strs_data;
> +       uintptr_t old_s =3D (uintptr_t)s;
> +       long len =3D strlen(s) + 1;
> +       void *p;
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
> +       p =3D strset_add_str_mem(set, len);
> +       if (!p)
> +               return -ENOMEM;
> +
> +       /* The set->strs_data might have reallocated and if 's' pointed
> +        * to an internal string within the old buffer, then it became
> +        * dangling and needs to be reconstructed before the copy.
> +        */
> +       if (old_data && old_data !=3D (uintptr_t)set->strs_data &&
> +           old_s >=3D old_data && old_s < old_data + set->strs_data_len)

we should use ols strs_data_len here, I fixed it up (and comment style
issues pointed out by AI) like so:

$ git diff
diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
index b9faca828f09..ace73c6b3d62 100644
--- a/tools/lib/bpf/strset.c
+++ b/tools/lib/bpf/strset.c
@@ -110,11 +110,13 @@ static void *strset_add_str_mem(struct strset
*set, size_t add_sz)
 static long strset_str_append(struct strset *set, const char *s)
 {
        uintptr_t old_data =3D (uintptr_t)set->strs_data;
+       size_t old_data_len =3D set->strs_data_len;
        uintptr_t old_s =3D (uintptr_t)s;
        long len =3D strlen(s) + 1;
        void *p;

-       /* Hashmap keys are always offsets within set->strs_data, so to eve=
n
+       /*
+        * Hashmap keys are always offsets within set->strs_data, so to eve=
n
         * look up some string from the "outside", we need to first append =
it
         * at the end, so that it can be addressed with an offset. Luckily,
         * until set->strs_data_len is incremented, that string is just a p=
iece
@@ -126,12 +128,13 @@ static long strset_str_append(struct strset
*set, const char *s)
        if (!p)
                return -ENOMEM;

-       /* The set->strs_data might have reallocated and if 's' pointed
+       /*
+        * The set->strs_data might have reallocated and if 's' pointed
         * to an internal string within the old buffer, then it became
         * dangling and needs to be reconstructed before the copy.
         */
        if (old_data && old_data !=3D (uintptr_t)set->strs_data &&
-           old_s >=3D old_data && old_s < old_data + set->strs_data_len)
+           old_s >=3D old_data && old_s < old_data + old_data_len)
                s =3D set->strs_data + (old_s - old_data);

        memcpy(p, s, len);


applied to bpf-next, thanks!

> +               s =3D set->strs_data + (old_s - old_data);
> +
> +       memcpy(p, s, len);
> +
> +       return len;
> +}
> +

[...]
