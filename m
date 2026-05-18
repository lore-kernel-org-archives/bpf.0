Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314A421EE7
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125812; cv=pass; b=kFe+XN052sYWtLrS4HSjLGj6/YXZIgAKk0y2cmKcrhSle51+PtcVAWpJYKPDvEn8BC//L/Ih+OPnu9L+D/sfH4hrxXRNAVp2lJ5vEoCldEUNSELQ3mpKMIi7upqL44Sx6CJkRRwlaATGNoY5beoTKjin/PukFIi7+kR5eIzUT8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125812; c=relaxed/simple;
	bh=F0QRiKvh6/IJVm90iS66Dzu5yCKPhW7N/73MUDGYmYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBAYSF5Ex2VQ6dT7KjC9AErfc0KSoaxRsgOVxTYSuqqoo8UKxW19+c/mgsQBcbOHa2TPw4iIuHTMM4Frwkqcp76HD7coNeQaNixdvlV3Rt9tmJdc+78iMfvebiZQI+p1zVkcaBVi7OmfqFKlg5XyvaVDDQbCoo34ePtavQL41cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwVTIqDR; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwVTIqDR"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba4a1a0325so16799525ad.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 10:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779125810; cv=none;
        d=google.com; s=arc-20240605;
        b=MqzkrN8HiiozWyDwf662pKKewOAg6iiSGlGmH4mVWixWhPgAJh810UEHneTYh+x/ed
         5lCGaUco33qrYFy05MhAoNtaXzWjjSZLFsVVOg6DmPH+xKrmPaDgKVb/j+v5e/kyqfYw
         GeY8YPUCkOEHizKLUwxjWRlb2QglvVnAmFTJ2jkcoH+VZJRSJ6dlQZE7wX54yEWFIG0q
         lmOQbTvSk9+fGuRuRb5cqci/Nxm4qJExu39huwuOHCXB5YktJDKZrDU3exHTzVLj0wa2
         U5ZUSamX1wx+Q15Qyld3gqiYnkCh/mTGJyvX/CUyD7B4NpAQks3iZSlLaE5tsWUSlg22
         FXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ogOsE5mbkWhjDM+7pDO5YKUZ5c9a6qpJFfBvCqB+fs=;
        fh=SGU+729RCQtzQXeab4ciWB3JVsPo6+4VNx11ZGEksbc=;
        b=OxDTzvvzxU4WBgKAjwdFSWZftM+hjXTuh566cWlGhCHAj5/uEsIwVwTEHaKr4izI4S
         5fE43zIuwCLoLMYqKAnbrvsG8FcG5tRJfL+iEERms1FuIW2qX998HcIotsc8zTW5vwcf
         LfdfN44+Pfs3dHmPxd85AXQ/DR3+/i4e+5b4HVeSA6xWvjjsF6b7tOwHxf3hi3+Yn0+f
         nem+XSrNQodYyrL3F6PwZUo8d91hUH+UX1Nt2Dm0zwbJMctCP39XMaaKobHqmxxluCnJ
         87TGPx8ET9Qj/wmVwXZGcXgufG9AMlePuhheGNYtLTN3ehP0mxfiMol+M7JKH67G+HCm
         IDmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779125810; x=1779730610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ogOsE5mbkWhjDM+7pDO5YKUZ5c9a6qpJFfBvCqB+fs=;
        b=GwVTIqDRpa4YYThruMZmO26LVT7tWhXDH26wKpljlSV2asnVJyp5p19a3gZY4emaqE
         Gxh+JXLuqf6oPmalXyD0oK2lSox6EDh2MuQbrOPGWE51BnmUEhii8AoFelZ3hy0YPIpn
         1+vL+G+BIvR5F3/AzYkB41WJtO4X7uTIDj0VXp/ZXF1W0HO0peukIy8xA+rIM+d/UV58
         pxPlaupvxgpgwAa3TIQWztJxh1ZGVw6+qaXOUMn4q2OYSQfu7SxV/Wfc19ZDdgHhBY2w
         NiI/EExFb8H0aXKhKjFrFlbNEXyvbS9pLVE/pPXs+RaLlLdyRvpKWz7P1pSW4bxNPT80
         gObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125810; x=1779730610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ogOsE5mbkWhjDM+7pDO5YKUZ5c9a6qpJFfBvCqB+fs=;
        b=L4Z4pA78vZjn6fxIxzPrp0HI3SujgazM3FDt998pOLXZ2W+dp9FjgCXate5+bLDcUY
         6eom5DTNo7j1ZKCDxYS2xMP9RAp9Yhn+3opb3Q+1zv7MJT++NzSQaZDjImK7ACPzX3wJ
         aG9AAR4eaC8k5XZJKz8HKv5R4uEXkKB0QnD1K3aMQYkfhGgyyBOOWQEG5cOLLW/IZic0
         LnS64RxyfY2CI0+h52e6j1e1BCH4ylSl76FHJlJPSX8vX6Q4N3Des3eERvwXyu83rtbp
         eILdU6yRC9ZzzV39mjbWWIHiyeWTklkPIDnIJ7acGjA4BwO8Sub+c7CgYys9wQYPKq1M
         9phw==
X-Forwarded-Encrypted: i=1; AFNElJ8Yt7iALWV2tK26JL0/Izh2TRROcdVNrNLInpcYi83u58eCQzxHOKBv8uEAnE+H6OFcBdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF0eogrOxeNqUwiJcWcYdZ3fIQ9D1SoerAgxbV2dPUj6xB+20t
	SdE32UiKnduBLLqoXlKxakHhRkxKQALbRw2o0geV+Oa44swgV4f6FvclhM8CqBBmLutZ7i+nFl4
	8E3HEUrtqj0B73jMJCeyKdrFnG+MfZN0=
X-Gm-Gg: Acq92OHUUAjyfxXwih6XaRZSqgpaU177XPspjkKBqPqoG1v1bShoNebX4AaILDfoK8R
	Qx3HjY/yRxVlM7Zi17twg+/5bDaJalAIpnoWwHu5S987tcN+RIRZr9vw6bzNlwUcbWOaaoEZ1t1
	sQ20RioqwSyJUeG/Hv0OFoFmKxAHXSqYUnf/JzSNmlXPdW+PiGomm4d8kCJA+95gDuwUzn1hIqu
	M471GwntKOLgEE5YtNxNEf/ikZ2hMqzTPU5+o6nSCYxkmFdYDbvNGw0jmS6YmGjUure+mCSq8I2
	HsrqmAI8bDPoCWQCxyCI2X+sRkL90R1u8A==
X-Received: by 2002:a17:902:7892:b0:2ba:6518:a6d4 with SMTP id
 d9443c01a7336-2bd7e87d577mr127239675ad.20.1779125809639; Mon, 18 May 2026
 10:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzZMoWdgYFGXwT9kkZ1TKbe9ZB=XKJCuKy0+2uqzSMDMUw@mail.gmail.com>
 <20260518050550.2600101-1-cmllamas@google.com>
In-Reply-To: <20260518050550.2600101-1-cmllamas@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 May 2026 10:36:34 -0700
X-Gm-Features: AVHnY4LToikzCQMrJ93TTYkmxlV-WodERyy6Z0f6K3NM-st8ig4gBIyrTPKbL2Q
Message-ID: <CAEf4BzbM7G8nVqtrW+fs5J9Hm4cqszA9CTETBCHLP7T8GPMs3Q@mail.gmail.com>
Subject: Re: [PATCH v3] libbpf: fix UAF in strset__add_str()
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

On Sun, May 17, 2026 at 10:05=E2=80=AFPM Carlos Llamas <cmllamas@google.com=
> wrote:
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
> v3:
>   Switch to 's' reconstruction approach suggested by Andrii.
>   Adjusted names and commit log accordingly.
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
>  tools/lib/bpf/strset.c | 58 +++++++++++++++++++++++++++---------------
>  1 file changed, 37 insertions(+), 21 deletions(-)
>
> diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
> index 2464bcbd04e0..d229961ff2fc 100644
> --- a/tools/lib/bpf/strset.c
> +++ b/tools/lib/bpf/strset.c
> @@ -107,6 +107,37 @@ static void *strset_add_str_mem(struct strset *set, =
size_t add_sz)
>                               set->strs_data_len, set->strs_data_max_len,=
 add_sz);
>  }
>
> +static long strset_str_append(struct strset *set, const char *s)
> +{
> +       const char *old_data =3D strset__data(set);

sashiko suggests to use uintptr_t for this detection to avoid
undefined behavior, let's do that then)?

but other than that and a nit below, looks good, thanks!

pw-bot: cr

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
> +       if (old_data && old_data !=3D strset__data(set) &&
> +           s >=3D old_data && s < old_data + set->strs_data_len)
> +               s =3D strset__data(set) + (s - old_data);

nit: strset__data() is more of an "external api", note how we access
strs_data_len directly through field. So let's use s->strs_data access
consistently.

> +
> +       memcpy(p, s, len);
> +
> +       return len;
> +}
> +
>  /* Find string offset that corresponds to a given string *s*.
>   * Returns:
>   *   - >0 offset into string data, if string is found;
> @@ -116,16 +147,12 @@ static void *strset_add_str_mem(struct strset *set,=
 size_t add_sz)
>  int strset__find_str(struct strset *set, const char *s)
>  {
>         long old_off, new_off, len;
> -       void *p;
>
> -       /* see strset__add_str() for why we do this */
> -       len =3D strlen(s) + 1;
> -       p =3D strset_add_str_mem(set, len);
> -       if (!p)
> -               return -ENOMEM;
> +       len =3D strset_str_append(set, s);
> +       if (len < 0)
> +               return len;
>
>         new_off =3D set->strs_data_len;
> -       memcpy(p, s, len);
>
>         if (hashmap__find(set->strs_hash, new_off, &old_off))
>                 return old_off;
> @@ -142,24 +169,13 @@ int strset__find_str(struct strset *set, const char=
 *s)
>  int strset__add_str(struct strset *set, const char *s)
>  {
>         long old_off, new_off, len;
> -       void *p;
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
> +       len =3D strset_str_append(set, s);
> +       if (len < 0)
> +               return len;
>
>         new_off =3D set->strs_data_len;
> -       memcpy(p, s, len);
>
>         /* Now attempt to add the string, but only if the string with the=
 same
>          * contents doesn't exist already (HASHMAP_ADD strategy). If such
> --
> 2.54.0.563.g4f69b47b94-goog
>
