Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9835E948
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530381; cv=pass; b=hQ6oIJVPaZI6g6Riwl0v7Hdtqm2YHOsS8c949LVxnsEWe8YGWj2AahcFQ0KhzyjwuIN84mBzWHrP0zBuVD7ydffRZYW/UzXmyt2YfukuuTEoCsQARl7WiLUYohyW4CfEuGdY4o7vSsLS2qu3+uU+ziLlMHChcqxuvF2ydafP8Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530381; c=relaxed/simple;
	bh=uEKPPLQfM4icf+qUY66iMp8/4n891RiLDCoONieODKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqMZuUfGkU1TwwMEt1bpv9+iYri2DgyvxU9s3Wa54PQ/csf9gYxxlc0V9TecaMAxs0B+Pc/Mvo2bSSlF4npkmOGvi58WmK3ok4/CMPy/nzmlyGeLol0+RF0iJMLCz25yvaaA0Ci6QQnKQVGRk8tXH8jfM5jUrgH1P2YK03QsCCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRYFcd1h; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRYFcd1h"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8422c327755so36742b3a.2
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 16:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530380; cv=none;
        d=google.com; s=arc-20240605;
        b=VjqLQOziC1c3+Uu94m+EbGqnTNhQuUYCjgTZCMtPnrnegpMahAKMI03VEM1OpQuFg8
         t9OQoLDKF/ZBywCGcs3rdL1GCCXS4y3Iy9YAUF6uy54XO9PKQxIyE5EW8iuynX8HucvO
         kU7ISVbK2qPS1CSUefDJr2MmdbXrQjjHLoslovJksaPH3To9+HBxpdHIBHwV17++16gF
         jnBkfGy5Jm1rhc0VXr6N+fRYn5dkA9Q/iVqCdm4i0t8JRlmB2OYpuaeYGJdvqIuc+hqd
         6a8Iz1rszhY+kpelgbFPJrDPP9PyFVFapgY+XErllGs0ythblO4DdtHHJibbGQZKCLeQ
         Qxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wWifozZk3TtNmr926sSEkL+CQRYN/IPWUzdtFc43uDE=;
        fh=usJCVylM19em8Tdfm6BmarcJxODUgrRLhn6blJwRCqs=;
        b=FnM3AxKsun6pabQwY+H26u6IXIBK4OC2j3VO4s6xCjAuIDou4senNdOACYJvWyTUJg
         TJHXEkqiv5jyyYN0xpAmwfGQYPLjVD8dsp062WIMf2WTDDR9eQY77OFwFVtSuaHoeLyY
         mf6I2+t2mhGvo5+P4fpmVEaO/yQUCZo5rB3zmkcY4bPqtYzoIgkC4F18hUZRV9FTRl1v
         fb5HIRFRLTdPsTrbBXARF7Ldg53mDanm1+eG2enYYq0yBmLm1hrMWcUzJmrWuUC930J/
         bDnCzthov6TSd/SGDcODetJyPLP+OOsh8Q8dUkk4ho99f29Ly/hnMm4LQRXAXhVmJYk+
         Id8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530380; x=1781135180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWifozZk3TtNmr926sSEkL+CQRYN/IPWUzdtFc43uDE=;
        b=eRYFcd1htJzEiRyD7fjsZrDzr/JGlJmnXbZcDtTpUr65ZDJ2MekLqOIvno4UCedaw2
         H6385mJALOhKThbvUqy2qsG7Y2z9NABzo34xdQnTwC2HvTccmzqmV76n06imZjyuoduQ
         U7cit+x3jRgRlX9lpY9M8jgpZ9jegDhY0Z9xBSgD2RehfELYmAQJyR0gHEJJi2g9yLWd
         AkTmFFbLfCt52KHRVkS8BMg4uZDs2Vuixb7OThe51V5Y5cfMqSy1zwQdEbmr9aUxz/O7
         GuiygGImmsVK/Y057BPP1QReKhj4mEcQeCWmXAR6e4n9Onwjp7YO7OI9/qfdMR5Sy04/
         pMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530380; x=1781135180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wWifozZk3TtNmr926sSEkL+CQRYN/IPWUzdtFc43uDE=;
        b=IgwQyU3b/MyPHW4YNaQd2WVIfGIqgnJxiL6kVKCYYL19Vd3+gk1vtXtorfR3Hl/btG
         FsjZR70aRKDD+7LFM7rKi1Kjv5aTUZCt6VdKPLzhPtmMQYRqo3B6VD5OVUCELAFGFecl
         hDKOLVqjyr+dLVBdioimBeNSPnmxFGuxLjoPmFzsmeowgcHHXKAwlB2+w7z5vurf7VZf
         zDvJLOU04YSgTEYlwtjwqsc0a8umLMO9pYiN3kyi+4XE1FFuBTLF8MVY7HUuPrBUYPN9
         BccrEHwosEkM52W36YrCxey7Lz8Ymv5djxfIoOC3B60QVa6iPumCO6uPJeeaqrSnj7e6
         294g==
X-Forwarded-Encrypted: i=1; AFNElJ+MwmG2uyRFHBAdTm0SYOvqMVsDFF2n9zC1H8qQY4Ura4dsl5fuPRKvojh5t9eryQr7LDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+6PYNqmbpg5+D5t8dllUOWktXPiYQbpD+MUnf1s67O9I7kaQ
	qtfHqMifibeRo0qwRITI48fR6oSs6SRdxJY/1Vwxk0KZtH689RXKEv4NBg4GHlzNf1aWfHBZN/X
	fzptlUNek4QqTqvANeK2Y4TNdXbsuKo8=
X-Gm-Gg: Acq92OFld8IFEwrprX9P8++OGWB8TdGWdHnsmGYq8qomsvVE9aUjO2MjvoouvDUBiw5
	yFWWZfdY5kWgLevyshegRRbYcJFJATAa4FJaWiC2YbGVSfeuhlZHKxVR9c3OfymVeL7kIX6bKfp
	KL1+unQt0hlCz0IZdBFKZKI4jwae0o/JRGTfo+9j29x63C/fO69NK9mNxBaTmCdM1zBCp/kWZb4
	UCOTEs4QPvtYK9m2BUGVN0qoA8+dQv9tsUr1pncD+v4YtjmBlIjyPfCX67j0yxxM03LwZWT6+5U
	M+7CXoOvKbgzuzIhv8UGSqjUxnZx0I7UIfxurJBNYYo9rVIIVj29pA4hwBCA5vQehA+lv10O4GQ
	=
X-Received: by 2002:a05:6a00:2d94:b0:836:3f6a:3e7a with SMTP id
 d2e1a72fcca58-84284ed934emr5074401b3a.26.1780530379860; Wed, 03 Jun 2026
 16:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601221805.821394-1-ihor.solodrai@linux.dev> <20260601221805.821394-7-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-7-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 16:45:52 -0700
X-Gm-Features: AVHnY4II1XspEqXUzLfqoHxyDZsyGuE1IrfFO2Nd3EGWuxYDmRs2Cj2n_EVwCTU
Message-ID: <CAEf4BzaLzX3mXvQzxv+gbmZOh84XvYofLjMSWFYghNjS-ohEZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 06/14] resolve_btfids: Discover kfuncs from
 BTF ID sets
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 3:19=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> collect_kfuncs() currently uses bpf_kfunc decl tags to identify the
> list of kfuncs. The decl tags are generated by pahole, which makes
> current implementation implicitly rely on those tags being generated.
>
> The authoritative source, used by the the BPF verifier for kfunc
> registration, of functions being BPF kfuncs are
> BTF_KFUNCS_START()/END() declarations. These are BTF_ID_SET8 under the
> hood. Currently resolve_btfids reads kfunc flags from these sets, and
> populates them with BTF IDs.
>
> Implement kfunc discovery from BTF_ID_SET8 symbols in resolve_btfids,
> removing the dependency on pahole's emmission of decl tags.
>
> Walk BTF_ID_KIND_SET8 sets, and use the address-to-symbol index to
> look up set entry's BTF_ID symbol name (before .BTF_ids is patched),
> recording the paired flags directly. This makes find_kfunc_flags()
> helper unnecessary, so it's removed.
>
> Kernel functions can appear in more than one set, which is legitimate,
> since kfunc sets are prog-type dependent in the kernel. So for btf2btf
> processing deduplicate kfuncs by BTF ID, accumulate (OR) the flags,
> and warn on flags mismatch to catch inconsistent declarations.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/resolve_btfids/main.c | 122 ++++++++++++++------------------
>  1 file changed, 55 insertions(+), 67 deletions(-)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index 43512af13148..d35a7b2460e8 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -970,6 +970,23 @@ static int push_kfunc(struct btf2btf_context *ctx, s=
truct kfunc *kfunc)
>         struct kfunc *arr =3D ctx->kfuncs;
>         u32 cap =3D ctx->max_kfuncs;
>
> +       /*
> +        * A kfunc can be listed in multiple BTF ID sets.
> +        * In this case, dedup by btf_id and accumulate kfunc flags.
> +        */
> +       for (u32 i =3D 0; i < ctx->nr_kfuncs; i++) {
> +               if (ctx->kfuncs[i].btf_id !=3D kfunc->btf_id)
> +                       continue;
> +

with hundreds of kfuncs, this O(N^2) approach is going to be a bit
slow, should we use rb tree for lookups?

> +               if (ctx->kfuncs[i].flags !=3D kfunc->flags) {
> +                       pr_err("WARN: resolve_btfids: inconsistent flags =
for kfunc %s: 0x%x !=3D 0x%x\n",
> +                              kfunc->name, ctx->kfuncs[i].flags, kfunc->=
flags);
> +                       warnings++;
> +               }
> +               ctx->kfuncs[i].flags |=3D kfunc->flags;
> +               return 0;
> +       }
> +
>         if (ctx->nr_kfuncs + 1 > cap) {
>                 cap =3D max(cap + 256, cap * 2);
>                 arr =3D realloc(arr, sizeof(struct kfunc) * cap);

[...]
