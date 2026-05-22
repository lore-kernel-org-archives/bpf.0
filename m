Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03032357CF4
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474975; cv=pass; b=TWUHlg3r1qE7sg3DVUKUjZpnKE+JWGrSnxD311ocCu8gEr7JSsgi+dEyv+6ReWNpOTJD6OTMMj7eNji4INzs/taKsR/1sUvHI9r6ISOVxZyJZhhuwTan5Jz+d4rk6zhjnXX8RF8iZd+DRN6Z79voaugziHQeGZUaShm1wwAi9OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474975; c=relaxed/simple;
	bh=fzH1J04ldqf4K8SXJQHcDLKABFWaiwDdDhIZnkwLx2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEtWrxzg6YJJ1GGw/KdQFdHAzwo7WpzWlqZN7ZhwiM48rOdD39dm89tq5schcdB+he+czNiSe7U/wHETAl9gqwAvQ8dBFRr5TqjSCTn47hd41Jo+Yu7fKQeNm+9TfYWhFMiVyIvfr0+hMGSRce/msHbq7K2yf1s9WDkl9MpZ3rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qpigDfcS; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpigDfcS"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c796163fac5so6385794a12.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 11:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779474973; cv=none;
        d=google.com; s=arc-20240605;
        b=Gc9hSXAtPRsrengfYFL3Dwp93xty1hsa3N7AHANweAMxwC0uBqcHwtRfidHipot1Ds
         iMmhshQDoAfS47mPWPqw9ADL3y1pwI+SF4aR8mQKXO0RA4PXHMz1fXm2nEDbN2VlCPrE
         1YaGE/XfG6RN1cPbRNN4KpEM/eBNlftmqX5N9idMrDsUBUVkMFBHUbWo9DU7N8kzLJEs
         wKlLH3LJyl+xOBBkaGbr325yqbblwbvgfo/5gDIkt1G+q5QIP12JVlblJ3YREh1vazQw
         NZzkVdhYqzsCs2d5Z/e8GX9PzKHy+Q3RUwJFiEtaE+/fG5iYDdSOG4bBPN82v1sfCn7r
         kfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mli6lapcTBe3woCKrxD/RvBcxQ+AVxfJ+HebBTph08w=;
        fh=4FK9IgpwgowAU5KUGScV7U7SOkBne+CxHSC5rdTP/Sk=;
        b=Rg1U1mKJ+Y1tsJ7UscZMfCDHkcC4NUVTu+7wSF7qCR5rpwo79DZnBgWvVv9P0FUyr4
         BJvMSbvaARgpUXZr/TwXekuco8YNF0QclHLC9CzpzF+LHMIIMGqX0JOGWGYi3uKr2txb
         RSFH6zlioNPm0cyqZxXIHc36wz5TCNK9FkdXCsQ0WmmfKSsBhEx7qmnIhE2NtswjISJ6
         0Xd6FvHmw4dR2bvKbF9chGv8MzYV60CD1WB8FnNkpBfrLTxE148Mp5mcIeXOZViV/W4p
         sG3Y4dGCR9Ih+1Z6/WsH9CwMDZIDWdnpoSVIRPKbbDiOIdgxNOyv5KkqiqjMMIZWvE6n
         +X+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474973; x=1780079773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mli6lapcTBe3woCKrxD/RvBcxQ+AVxfJ+HebBTph08w=;
        b=qpigDfcSR4XsyWhq55dkigD7xaKgHC6DUxICA8kWvXlOdYdYcL2YkaecQwHTCgPx4z
         uzY2fKW+RWPfj0Y0QK6nOhvVfUumiS7E3wRRKJ4EccRfazvnVJO+J1rMiYvK20+AhFQE
         QUF6hWITMkSlhlRyqTVjixb/P/oUNl9AI+FHNS9MkjBgO4z3Q1dL3bOxQNgjaEozoU1Y
         nTZc7yjTNgSplpg3UJYz+Kybw+5yoRYks5Bht0pjoSrlbZVUKlROisne+dDm8Rt0DTuo
         FZ4uWVkkJyBxGzW/dIYqKAiwZ8CYMSL3xRzI6WLxLmkpcamdOhAGZdEAO3jKRxdAIBe5
         A5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474973; x=1780079773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mli6lapcTBe3woCKrxD/RvBcxQ+AVxfJ+HebBTph08w=;
        b=JI5dzjHtwVaVSh51NwC90S8Cd2g2/ZNMH5MFMZd4CaCLrg+yj4keqvaT5ryOn2F66C
         fKOF2F5WLKoE8SSbe/Acb5TlPcIjQ51YAfBMlATXU1mXOORg+KwOHO8R4vVbsjy5XByS
         X8IKqttjbb39HdkCp66PYJhrUW+YP+Qk9NDutymzsOV8Y89B6tt2zNIJOuZJoeYV9hWm
         jwFixxvN330YPUZpPT946dH4xwlpTN4BCWycBfhVIEqlnGJrYJO3KxDzBv7UrNoFdqGY
         BUQjBJX2e22jXshQmT33E+X+al2YcQscyUDllCrz0X0Tv7+W1jIVVMVVhJS4mRdGFYmh
         A1jA==
X-Forwarded-Encrypted: i=1; AFNElJ8CR8yfEg+Usk5KQEhy/OB2zlOAcyHvXTbTOjWt1BkoXNh0tUcdaFIpYrlActM4He92eGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7DdKU0YUgSoGBbR9rkCH6OEW8o+AK6WEGex1DnXQuOGjNIsk
	vMJW+h7WEOHMOuN/Tyrorf2bKo9UbvoLegExsAcXhxDeEsWDtVypyz9MyFhfP7JTNZmmD9IQ6Ap
	AIHpjcrEN2THoelhgm1yRgf41T7OE2EU=
X-Gm-Gg: Acq92OHvoZfpZmn9LkZuU6V5HZJqV1fJAbwCSeenixU8MB9+2rTxSYHp17MH1UZNx7C
	K/yr73mEWwuaUVQlTSJfeiZUiRQI9CIKFS6l6x17E6Gu0x2uYYln/TPSIQZJ5SBwXBhOiDNT8tu
	rZvrslY3NaRpS3Vd2mJ8cfhGsrN0M2w9S+n8t5/ouoSIyrmWG3zkceqNir/DKErLq8J9nProGD/
	CbK5VAKti/TzmOppJAguR/UF/Nvrc20w3GU8h6RM2T6rPZlTjGXeFFl3JlD05O9alN+dNScdw+2
	3T4fPGD3MSEzR7IeswH8Y6w=
X-Received: by 2002:a05:6a20:9396:b0:39b:e6af:2d8 with SMTP id
 adf61e73a8af0-3b328cba260mr5340061637.4.1779474973017; Fri, 22 May 2026
 11:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzZMoWdgYFGXwT9kkZ1TKbe9ZB=XKJCuKy0+2uqzSMDMUw@mail.gmail.com>
 <20260518050550.2600101-1-cmllamas@google.com> <CAEf4BzbM7G8nVqtrW+fs5J9Hm4cqszA9CTETBCHLP7T8GPMs3Q@mail.gmail.com>
In-Reply-To: <CAEf4BzbM7G8nVqtrW+fs5J9Hm4cqszA9CTETBCHLP7T8GPMs3Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:35:58 -0700
X-Gm-Features: AVHnY4InGPJjEN2sRS5KjdNXngvVxT7pWkze0EA8-LHK7libjX_WoefO_xjnX3k
Message-ID: <CAEf4BzbX6DSD5Erd2wb2wE+=MFTfqgvVrpkysqrCKT0W7-n29g@mail.gmail.com>
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

On Mon, May 18, 2026 at 10:36=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, May 17, 2026 at 10:05=E2=80=AFPM Carlos Llamas <cmllamas@google.c=
om> wrote:
> >
> > strset_add_str_mem() might reallocate the strset data buffer in order t=
o
> > accommodate the provided string 's'. However, if 's' points to a string
> > already present in the buffer, it becomes dangling after the realloc.
> > This leads to a use-after-free when attempting to memcpy() the string
> > into the new buffer.
> >
> > One scenario that triggers this problematic path is when resolve_btfids
> > attempts to patch kfunc prototypes using existing BTF parameter names:
> >
> >  | resolve_btfids: function bpf_list_push_back_impl already exists in B=
TF
> >  | Segmentation fault (core dumped)
> >
> > Compiling resolve_btfids with fsanitize=3Daddress generates a detailed
> > report of the UAF:
> >
> >  | =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  | ERROR: AddressSanitizer: heap-use-after-free on address 0x7f4c4a500b=
d4
> >  | =3D=3D1507892=3D=3DERROR: AddressSanitizer: heap-use-after-free on a=
ddress 0x7f4c4a500bd4 at pc 0x55d25155a2a8 bp 0x7ffcef879060 sp 0x7ffcef878=
818
> >  | READ of size 5 at 0x7f4c4a500bd4 thread T0
> >  |     #0 0x55d25155a2a7 in memcpy (tools/bpf/resolve_btfids/resolve_bt=
fids+0xcf2a7)
> >  |     #1 0x55d2515d708e in strset__add_str tools/lib/bpf/strset.c:162:=
2
> >  |     #2 0x55d2515c730b in btf__add_str tools/lib/bpf/btf.c:2109:8
> >  |     #3 0x55d2515c9020 in btf__add_func_param tools/lib/bpf/btf.c:310=
8:14
> >  |     #4 0x55d25159f0b5 in process_kfunc_with_implicit_args tools/bpf/=
resolve_btfids/main.c:1196:9
> >  |     #5 0x55d25159e004 in btf2btf tools/bpf/resolve_btfids/main.c:122=
9:9
> >  |     #6 0x55d25159cee7 in main tools/bpf/resolve_btfids/main.c:1535:6
> >  |     #7 0x7f4c78e29f76 in __libc_start_call_main csu/../sysdeps/nptl/=
libc_start_call_main.h:58:16
> >  |     #8 0x7f4c78e2a026 in __libc_start_main csu/../csu/libc-start.c:3=
60:3
> >  |     #9 0x55d2514bb860 in _start (tools/bpf/resolve_btfids/resolve_bt=
fids+0x30860)
> >  |
> >  | 0x7f4c4a500bd4 is located 13268 bytes inside of 2829000-byte region =
[0x7f4c4a4fd800,0x7f4c4a7b02c8)
> >  | freed by thread T0 here:
> >  |     #0 0x55d25155b700 in realloc (tools/bpf/resolve_btfids/resolve_b=
tfids+0xd0700)
> >  |     #1 0x55d2515c426c in libbpf_reallocarray tools/lib/bpf/./libbpf_=
internal.h:220:9
> >  |     #2 0x55d2515c426c in libbpf_add_mem tools/lib/bpf/btf.c:224:13
> >  |
> >  | previously allocated by thread T0 here:
> >  |     #0 0x55d25155b2e3 in malloc (tools/bpf/resolve_btfids/resolve_bt=
fids+0xd02e3)
> >  |     #1 0x55d2515d6e7d in strset__new tools/lib/bpf/strset.c:58:20
> >
> > While resolve_btfids could be refactored to avoid this call path, let's
> > instead fix this issue at the source in strset__add_str() and avoid
> > similar scenarios.
> >
> > Let's check if set->strs_data was reallocated and whether 's' points to
> > an internal string within the old strset buffer. In such case, 's' is
> > reconstructed to point to the new buffer.
> >
> > While already here, also fix strset__find_str() which suffers from the
> > same problem by factoring out the common operations into a new helper
> > function strset_str_append().
> >
> > Fixes: 90d76d3ececc ("libbpf: Extract internal set-of-strings datastruc=
ture APIs")
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Suggested-by: Mykyta Yatsenko <yatsenko@meta.com>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> > v3:
> >   Switch to 's' reconstruction approach suggested by Andrii.
> >   Adjusted names and commit log accordingly.
> >
> > v2:
> >   Implemented the fix in strset__offset() helper as suggested by Mykyta=
.
> >   Added support to handle "substrings" of existing ones.
> >   Used 90d76d3ececc as Fixes tag as suggested by Sashiko.
> >   https://lore.kernel.org/all/20260515044759.2863546-1-cmllamas@google.=
com/
> >
> > v1:
> >   https://lore.kernel.org/all/20260513232055.1681859-1-cmllamas@google.=
com/
> >  tools/lib/bpf/strset.c | 58 +++++++++++++++++++++++++++---------------
> >  1 file changed, 37 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
> > index 2464bcbd04e0..d229961ff2fc 100644
> > --- a/tools/lib/bpf/strset.c
> > +++ b/tools/lib/bpf/strset.c
> > @@ -107,6 +107,37 @@ static void *strset_add_str_mem(struct strset *set=
, size_t add_sz)
> >                               set->strs_data_len, set->strs_data_max_le=
n, add_sz);
> >  }
> >
> > +static long strset_str_append(struct strset *set, const char *s)
> > +{
> > +       const char *old_data =3D strset__data(set);
>
> sashiko suggests to use uintptr_t for this detection to avoid
> undefined behavior, let's do that then)?
>
> but other than that and a nit below, looks good, thanks!
>
> pw-bot: cr

Ping. Carlos, are you planning to send a follow up?

>
> > +       long len =3D strlen(s) + 1;
> > +       void *p;
> > +
> > +       /* Hashmap keys are always offsets within set->strs_data, so to=
 even
> > +        * look up some string from the "outside", we need to first app=
end it
> > +        * at the end, so that it can be addressed with an offset. Luck=
ily,
> > +        * until set->strs_data_len is incremented, that string is just=
 a piece
> > +        * of garbage for the rest of the code, so no harm, no foul. On=
 the
> > +        * other hand, if the string is unique, it's already appended a=
nd
> > +        * ready to be used, only a simple set->strs_data_len increment=
 away.
> > +        */
> > +       p =3D strset_add_str_mem(set, len);
> > +       if (!p)
> > +               return -ENOMEM;
> > +
> > +       /* The set->strs_data might have reallocated and if 's' pointed
> > +        * to an internal string within the old buffer, then it became
> > +        * dangling and needs to be reconstructed before the copy.
> > +        */
> > +       if (old_data && old_data !=3D strset__data(set) &&
> > +           s >=3D old_data && s < old_data + set->strs_data_len)
> > +               s =3D strset__data(set) + (s - old_data);
>
> nit: strset__data() is more of an "external api", note how we access
> strs_data_len directly through field. So let's use s->strs_data access
> consistently.
>
> > +
> > +       memcpy(p, s, len);
> > +
> > +       return len;
> > +}
> > +
> >  /* Find string offset that corresponds to a given string *s*.
> >   * Returns:
> >   *   - >0 offset into string data, if string is found;
> > @@ -116,16 +147,12 @@ static void *strset_add_str_mem(struct strset *se=
t, size_t add_sz)
> >  int strset__find_str(struct strset *set, const char *s)
> >  {
> >         long old_off, new_off, len;
> > -       void *p;
> >
> > -       /* see strset__add_str() for why we do this */
> > -       len =3D strlen(s) + 1;
> > -       p =3D strset_add_str_mem(set, len);
> > -       if (!p)
> > -               return -ENOMEM;
> > +       len =3D strset_str_append(set, s);
> > +       if (len < 0)
> > +               return len;
> >
> >         new_off =3D set->strs_data_len;
> > -       memcpy(p, s, len);
> >
> >         if (hashmap__find(set->strs_hash, new_off, &old_off))
> >                 return old_off;
> > @@ -142,24 +169,13 @@ int strset__find_str(struct strset *set, const ch=
ar *s)
> >  int strset__add_str(struct strset *set, const char *s)
> >  {
> >         long old_off, new_off, len;
> > -       void *p;
> >         int err;
> >
> > -       /* Hashmap keys are always offsets within set->strs_data, so to=
 even
> > -        * look up some string from the "outside", we need to first app=
end it
> > -        * at the end, so that it can be addressed with an offset. Luck=
ily,
> > -        * until set->strs_data_len is incremented, that string is just=
 a piece
> > -        * of garbage for the rest of the code, so no harm, no foul. On=
 the
> > -        * other hand, if the string is unique, it's already appended a=
nd
> > -        * ready to be used, only a simple set->strs_data_len increment=
 away.
> > -        */
> > -       len =3D strlen(s) + 1;
> > -       p =3D strset_add_str_mem(set, len);
> > -       if (!p)
> > -               return -ENOMEM;
> > +       len =3D strset_str_append(set, s);
> > +       if (len < 0)
> > +               return len;
> >
> >         new_off =3D set->strs_data_len;
> > -       memcpy(p, s, len);
> >
> >         /* Now attempt to add the string, but only if the string with t=
he same
> >          * contents doesn't exist already (HASHMAP_ADD strategy). If su=
ch
> > --
> > 2.54.0.563.g4f69b47b94-goog
> >
