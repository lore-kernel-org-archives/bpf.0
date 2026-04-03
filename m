Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD363D3D1F
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775247969; cv=pass; b=Qj0gZ3iiug8OZscLj8Qjeo/1AsXhkxiZaxlO4pnHJfO6Y/pRF4gCfUYsoYZDebeSt7wDGvPV2uOIkEkkDH4edm7DHlj7ecVnRrSTDQOvZbS7Ou9yFRIZIV58/Zmv/yAQW+bOWlGBTDQYMI8bfOOgRFiaTFzGGQSrMPnyvAbXMkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775247969; c=relaxed/simple;
	bh=W2GxyFfqeFK1bTj4ewMZeHp6pVveLFR7SfnOf570b0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tjz9snqiTk580ENdWjo8mixPiNKT7mut9vTA7EJTELsH35u0hmHoOFP2yKxt2CX6DRlFkgoApPkM8MKNbHm6M0r0igWTxmmmFF6Zjo5qopm1taGf91l+50PlFQ58uP5cCnYseJl9QLldzbStwwefn7RiNfZ/2J7E+5qRLJt4hDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTr23dff; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTr23dff"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-487012ce896so12339395e9.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 13:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775247967; cv=none;
        d=google.com; s=arc-20240605;
        b=X9gOwHqL3nKWmsO5Ipja+1aGCo0R/i6D6P76zwp7sB6MPSYIIo/LLN/k396RQ5QtGN
         PT1+4mMtYGWsGiK20c4tABNflyUwJkf1rDzCHODNga+LY6V14pxmoL0GdLaeIB4HbIf9
         daruaXmqYIjicOx6HbLSYyAvC3wjPL3BNV9cGw4bCzGiIOGFYwMz/4hvUUiRqp6wMIXX
         1pjgYq0Aq3Pjh+QSYKn2ta5RrG9r4oM2c94WOk9e3I2Qd8JDiWVjz29nUtOYPnYmlAt3
         6jTRnDm8frX1ijGUUzh4awN4OVhOCefwe+bSuKrIn5dr3ZnvGoC130Gz7Rfe6N5IR6MQ
         HUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pd4izFmvYMUm9D4Yts9HvyIDEGVgM1np9//icQ2Fftk=;
        fh=5K7LlmBDhJRYJ+zNVkHjN8Qzx0sx61+mt+UfNHVnWCo=;
        b=BnbfzuwPeA4GGMLpJXcA1xGUFWNwqp29tSbT/dETX569F4trW8TKOFYOr5W1VH3pPt
         TSQ7XHloFTl/DXxMxljQzlmu3Ab/NwCesiEIRPyNesH+GanRlpiqo3M5ARqAYYtl+FLh
         WpRRGwRQosK5o4dSIZ3X2Vsl77KMboLcakSmw9q84Kq1kppvCKxhCNBNsSah/v0gE8Gc
         xauuV9Uky5s8Nbn7Z3AbPGenUK5sSiF03Ag2sJsU3gqktlYGAVDjKsLAwG1SLdyFZaNo
         nJ9kOYdKf55S0jcLfCBW6vJTx1fTxDY1r/da73zG8ErcFCISRNt38zvIxMUT2EL/plW7
         7XIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775247967; x=1775852767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd4izFmvYMUm9D4Yts9HvyIDEGVgM1np9//icQ2Fftk=;
        b=iTr23dffl9NDD3l6RkpsmG5tok1AxveQUsEyYXnWr9iDU7GOUAYVUpsuuhxcGbwX/U
         ws4XYOXK0BjFBXhBzg/YmIKhbl7Q3q7IP2tVBCa/bGC3HfVT1ileiAaSnPbT8HW4dLI4
         Du2C4mHy1KM8dd8Y0PFUfmGOqfjwIeyJVurXwq2Rh69A5ZOr7Pp0aiMMX9gMCOcok3Q8
         0tTqlj0vwSMcjR8uRhI14dWFn8G1TamNhCxGPLcqp96KZaeSLjapLV8XCrMMyluaBiDN
         hubOau9kLovFcj/U/2FfDTvxYAy23wsSWoLsjITVY4OUgdkeCV9ejQ05zv7oriUJ51Bv
         Ie2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775247967; x=1775852767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pd4izFmvYMUm9D4Yts9HvyIDEGVgM1np9//icQ2Fftk=;
        b=PA7RZmVTYko1YqlDCTwJswnL7vpIHNELvYTb9tWByrw2CusmHWqms3LwdeNQVm4DHf
         QRRVgmJr1QOCRQP+rN1tw68dIIQBbDJ8b+N40Aviw7tyrcKnoi2oigC+4Wykr3OVEcrd
         k8rac1QL427rDUgJC+fdegAUfgwpDWL2IAevguDZeVQ1VRdvsdyAS1n7TX1BLgkncotj
         /6qmGSO3NswqnrT4UkmLgi2bngsWEWLGlxwhxJUmH8kfmd4IhHb9XSDP5myDL+m9+T0z
         yIL/VEDgOXNkHLErXqY619TxKrGijG9pC3OBtowGagzt6V7BU7ouiqf21L6iUHWoFJDu
         hXjQ==
X-Gm-Message-State: AOJu0YwQBQAIOCPcrUqs1/ijvqKca69zWd7Zn4nvaCzC3jWaVsOZWiJw
	FfJcaB6VC1NdBOfAjX1zSeRnZpXAvrAKJi/Ton25I/dTauznh4KZDwzLUkaxcEZUbsXnE0pknzs
	p+ljb9rhuwjsx80MldHhA71tdCd70LLQ=
X-Gm-Gg: ATEYQzxA4cs46Y/I+GiDTqn+7RMr3Jbut1Wn3vcjKRRlplUvSoPGQU8upYLuo+g9Aao
	U2/p6CLXyeiubveaNb26xYOFWaIQNYg07xhAtPU5DWOIUG2niEwMy9Ssa5JP/4OiYiy0Vma5uJR
	NptmIPywH8oFpfHRuTYDPqrL2FXUW6OpD904j11e9Yp1F6bapCmK0E+8iz8kgLPyNbo5sGqferT
	Bzl4zSWa3SmkJslrcsmrHSpi+iV2tiur7UuBdQcqxSpPFBCJlRSzhG0bJbdEtTj7dISLZ1S3BRr
	qVNNrJ/2mzRR5tJ43NZe6NzqJHzXJo8yiwNzd+BlMXOjqZIXtN/Hdd3sDHFRwCj2eNb81CIF3O+
	aBZ8sNBMASAo7Oxh7KnTz4iJTdg==
X-Received: by 2002:a05:600c:3b18:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-4889970dbc6mr59634425e9.10.1775247966577; Fri, 03 Apr 2026
 13:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403042720.18862-1-emil@etsalapatis.com> <20260403042720.18862-3-emil@etsalapatis.com>
In-Reply-To: <20260403042720.18862-3-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Apr 2026 13:25:55 -0700
X-Gm-Features: AQROBzD8m_Xst59hlHS6zRXcIcbSsaFZdJ0lkffFDHIvV2dRJv0j7GwPCS5vCoY
Message-ID: <CAADnVQLGfsEsMp=yhn6wk03AwXkWgGf3KF9UL6U0-SbuhtbzJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] selftests/bpf: Add test for scalar/arena
 pointer addition
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:27=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> From: Emil Tsalapatis <etsal@meta.com>
>
> Add a selftest that ensures scalar +=3D ptr_to_arena instructions
> are accepted by the verifier.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  .../selftests/bpf/progs/verifier_arena.c      | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/t=
esting/selftests/bpf/progs/verifier_arena.c
> index c4b8daac4388..450e8f1181cd 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -477,4 +477,33 @@ int arena_kfuncs_under_bpf_lock(void *ctx)
>
>         return 0;
>  }
> +/*
> + * Test that scalar +=3D PTR_TO_ARENA correctly upgrades the
> + * destination register to a PTR_TO_ARENA.
> + */
> +SEC("syscall")
> +__success __retval(0)
> +int scalar_add_arena_ptr(void *ctx)
> +{
> +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)

I think the #if can be removed, since the whole test is in asm?

> +       int __arena *result, *arena_ptr;
> +
> +       /* Needed for the verifier to link the arena to the subprog. */
> +       volatile char __arena *base =3D arena_base(&arena);
> +
> +       /* Passing base here to avoid optimizing it out during compilatio=
n. */
> +       asm volatile (
> +               "%[arena_ptr] =3D 8192;"
> +               "%[arena_ptr] =3D addr_space_cast(%[arena_ptr], 0x0, 0x1)=
;"
> +               "%[result] =3D 12;"
> +               "%[result] +=3D %[arena_ptr];"
> +               : [result] "=3Dr"(result),
> +                 [arena_ptr] "=3D&r"(arena_ptr)
> +               : "r"(base)
> +               :
> +       );
> +#endif
> +       return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.53.0
>
