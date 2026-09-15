Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD5932A3C9
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490598; cv=pass; b=m97eX6ylBfLhUSWH89Hf0/Hn+SkqWMwriGXbQ6Bj62bFaifQadzsIya1ItGQc6SoDWLr1O9NmSebaH5s/RlgGoO7QXhLzwhWx2qjf/lQv5y974Znpg7P9n8HrvZVkF1/Hl8F0fqOJTnqkUiDPpiA3coCVd8g0vvBzY5zMfB19po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490598; c=relaxed/simple;
	bh=2daMHGPZFbua1M+EmfMIOA5jDAlIINC3HwUsdyGjB3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUtUaU6bxGyfymPBd+CEd5c0t1HXx8+9ijodaKE1CF3q6X5OCWcuotqgYa1Y3dQKri6rZ8NjSsX3TPdHifB3zmS3s9EsW/aFteWsu9q34F9FLsrCtc3XjV7eWM6bAgX9qu3p1n2ieWbRkhXYz8hA0TcGWvyvSl2SZyplXHFiNiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrHUtkB8; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrHUtkB8"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so2543678a12.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 09:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789490593; cv=none;
        d=google.com; s=arc-20260327;
        b=WBx4yLVb10vPAXC2i/gkDWdjKrgjL2I+R41keMPHRh3F5sSzcGfTBwnZpPKo/eSeRP
         acyb1JbgGikLk9KpagriMYpKK3jJAkPxJ87N1+5QjqctRrEpnuq+W1WDOrvClg6IGoUW
         CeGX+1de1U1JeY2BWU4q+y198ampoanf5oB3avlFyMVi7K6JPRgrGHJo4qC+MxLeH+rm
         aHor9nOgeNL3PYDxIq2SIxb8faKdjIINfI0yisexFCB72svPLU7gkhJlN6lmKbidxukB
         uUqmdpfBRhGl0RqpX8T4FQaOX8b8u8EDFt1TshdDucj79WtPnGqycvnEb+kW96SY934g
         Yc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qo9OlRHM5ZHiIu6h+NSN34Q+IP3REf8sftIwu13W7NA=;
        fh=P2LUUh5iIFUu1bvNQh/kkATWR/zwXcjHGRoYhxuKb/s=;
        b=MxJSqJYtgBMdzeCiGInSdEmBJfu+3xE58LX9CyonTwRZyPCNe/jepIS11AzCJOPkk3
         5SjPQWbb+XmPDkF3ZCwO0C78+Iyrfpf0YfAjjAyIQfTP3QcdP7T9BgNT76mNS/M4bN3O
         NfXQWrfoFdk1fe71Ug2rRJKQbvM+VConrLZlHoaHtDjdTR4zCcJEE7Xj8wIK9aTLlD46
         JjowdzkRIxU1FpC0z7GAZmC61uUZxe7Nb9YMyZB6x0MYh7HI2lSdyDTguzCzhwaxt4R1
         +umoAoXidjQhEd0aOOYFaK/WoGDDCjvTa6AExZxKB/tsZ3hvfcwXDJudsl33a4SpsB+n
         C7VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789490593; x=1790095393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qo9OlRHM5ZHiIu6h+NSN34Q+IP3REf8sftIwu13W7NA=;
        b=mrHUtkB8SjpwbKNw4RpgZQ4tmzaP+MYK8xW35KpwwFSnPe1GyAfwN8+VI9xP/gpiEr
         PnuPvF80ZjUAxYClClz42mQRZ1Lfxq8CdOUYFbA1LK48PvxliY/bJh1dpODri1Xkdtyh
         FbTRJHPUURyCgI+l157J1G4ioTpQ3vtrPzPxshHrVtAIg7wIpqZCjAlEs9MU1kqKkbrN
         ap1FkmkSXRJwag9as9A+4CJoT3UwCGFEuxJJO8+tRuRwtAK6Pz+4lvAkeNywjQYcqEME
         hrZkvQTpGExbvjBdGCyJF3YIyqSjYEfHgT3vKxmpec65oDdKsLQDkomMqHTkDjKljoYF
         dFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789490593; x=1790095393;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qo9OlRHM5ZHiIu6h+NSN34Q+IP3REf8sftIwu13W7NA=;
        b=vwm5h8ZkirbUjm4dnEul5iyUiet/+Pg75SMpSfekxa9fPQG5sfzwrWhyRpQyen7x/P
         ZdEkMVyZo9/qShOsTeYEZcRsvoft6nEMsmJlm8yUXhbv5lN7dyBRk7dSy2e9apPEm2rn
         vvVeP/5ZZO8m6Gx8vgTQp61+0czivIF9oQKaOHz8yomi+uZ/fXOAUoonyfE0f1jd/8mj
         STTuAtsqt7IlWF/5vA68Xffiyp0r4wJAoqSMkPxTJe4azqqZGhKxlki6JhGfkuIA0iSw
         XnB8gLdxhGfxx2niwaAdbGJDK44V8POTlDIaEVzOo4cRdAnqi0Pqez1wTykuocf3kqOe
         /4AA==
X-Forwarded-Encrypted: i=1; AKwUvBwhVqvQHRqOjF8sdZjXKKMx6Bq1SPesqupgFVbNyhq5uOgBVdDQQBHGyga3ERe/ZQC5DRo=@vger.kernel.org
X-Gm-Message-State: AFuF++mfIOC/LeBeTrY/hDkm8Nv+WGs5NdzVEfv31COSO5IcPTWe7qgX
	VJ3B706Wo4eqVvkM4t/Xt6QdTcrdKMNuMThVno/8ZM0WrtqLLeIiuw20gXxreuUW91I9phjQgjB
	UGWgTlCgY5q7V+4hWy5uVm/Gx/Qh3ANc=
X-Gm-Gg: AYBFou0gESgt0zdsnzmwenQVtwTM9gi3Ns76da0aD+e/1ryhM8UXwYbMT47UrYea2L9
	EEi5dw/w3EBdvBkvDzordR2IMi+gnGaLUvC79gH7c8gq0WMMKGQGQLqZTQrBrsed3E041J4dbfu
	D3q/Zf9XA61z4sTQEEiyl0GydVwBk6qko8ITju+UYgoRUFnED9mnLwdUglLBqHKRXmK4rGD6+1u
	Cf1RqD6NUZZ/NqiPfppb1A3NEx8/HmUk1gyC9xj0M2rrl9/Jyd5BcVe3AIpHLwjqixNmfb7xNE/
	axlovn7cN7BoGqLBH9KIPM3m7T8+dSxD2HrXsJBcGqS5aO7fC/pUdE1YMBZJ7iLfLVlhLMw0NPU
	dmbmRPVvsl4RG7EHtXaYpdH53Hp+rIBV8iuEdYUv5eOcQZKjF+oYbvIiALOVqV7P6h6NMC/Wge7
	GrDWmAsZdShHKnQvnhkmfxQHXXHbeoFnY=
X-Received: by 2002:a05:6a21:790e:b0:3dd:5831:ef5c with SMTP id
 adf61e73a8af0-3dd5831fd3emr1349355637.17.1789490593411; Tue, 15 Sep 2026
 09:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915145054.164857-1-madhav.khoslaa@gmail.com> <58262a1911ba8265b8745e4a2f9e592ddfa74c814b4359a83fcf449ea32904fd@mail.kernel.org>
In-Reply-To: <58262a1911ba8265b8745e4a2f9e592ddfa74c814b4359a83fcf449ea32904fd@mail.kernel.org>
From: Madhav Khosla <madhav.khoslaa@gmail.com>
Date: Tue, 15 Sep 2026 22:13:01 +0530
X-Gm-Features: AcwNN1WnxW8WBoI-ohv1f9X3fbdYZegC5MNEvJtdfGbXXR7Ewvk9ZhVogj12N2s
Message-ID: <CAHFb0oBSaP90J=oF85grEBGB8VmE=_89W5_xBznpSP=nQzQK_w@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix csum_partial() dropping trailing
 byte on odd length
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	sdf@fomichev.me, alexis.lothore@bootlin.com, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Note: Resending as plain text
1. checkpatch --strict doesn't flag it, and it's not actually an
   outlier in the tree; bpftool_helpers.c, cap_helpers.c, disasm.c,
   btf_helpers.c, netlink_helpers.c, jit_disasm_helpers.c,
   trace_helpers.c, uprobe_multi.c and bench.c all do the same thing.
   I'll leave it as is.
2. A second pointer would result in the same code either way, the cast just
   moves from inside the loop to the declaration. I see no reason to
   carry two pointers into the same buffer for that.
   And for __builtin_memcpy(), it's because this header doesn't pull
   in <string.h>, and I didn't want to add that just for a 1-byte copy.
   It's also what a bunch of the progs/ files already do, so it's not
exactly out of place here either.

Madhav


On Tue, Sep 15, 2026 at 9:26=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/test=
ing/selftests/bpf/network_helpers.h
> > index 75133119c04a3..f6d28a2de7888 100644
> > --- a/tools/testing/selftests/bpf/network_helpers.h
> > +++ b/tools/testing/selftests/bpf/network_helpers.h
> > @@ -129,12 +129,22 @@ static __u16 csum_fold(__u32 csum)
> >
> >  static __wsum csum_partial(const void *buf, int len, __wsum sum)
> >  {
> > -     __u16 *p =3D (__u16 *)buf;
> > +     const __u8 *p =3D buf;
> >       int num_u16 =3D len >> 1;
> >       int i;
> >
> >       for (i =3D 0; i < num_u16; i++)
> > -             sum +=3D p[i];
> > +             sum +=3D ((const __u16 *)p)[i];
> > +
> > +     /* RFC 1071: an odd-length buffer's trailing byte is paired with
> > +      * a zero pad byte to form the final 16-bit word.
> > +      */
>
> A subsystem pattern flags this as potentially concerning: the BPF
> comment-style guide states that multi-line comments under
> tools/testing/selftests/bpf/ must have the opening '/*' on its own line,
> with the comment text starting on the next line:
>
>         /*
>          * RFC 1071: an odd-length buffer's trailing byte is paired with
>          * a zero pad byte to form the final 16-bit word.
>          */
>
> The comment text itself is accurate and matches RFC 1071. Is the current
> style acceptable given that the surrounding file has no other inline
> multi-line comments in this format?
>
> > +     if (len & 1) {
> > +             __u16 tail =3D 0;
> > +
> > +             __builtin_memcpy(&tail, p + len - 1, 1);
> > +             sum +=3D tail;
> > +     }
> >
> >       return sum;
> >  }
>
> This isn't a bug, but would keeping a separate '__u16 *' pointer
> alongside the byte pointer let the loop body stay as it was, rather than
> casting inside the subscript? Also, is there a reason for using
> '__builtin_memcpy()' here instead of plain 'memcpy()' like the rest of
> the selftests tree?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/349860=
38731
