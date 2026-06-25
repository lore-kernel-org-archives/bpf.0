Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE93D88E5
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386452; cv=pass; b=OgPEmOxL7yh4oGcV8sBixHuRAaloHzYt2nBkCW7Z9ZFGEn4/2WwIsF4uJdfDj+Q3ViLwXTw9y0uXszD4x+KAWLQr9pJ7hQf7XrV9DpGOXq4lj1iAl2E66BYAv+afQEyImJpFgzJoeyONfJ+IWV073gEGcu0hQd9jkM0Lxt2thuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386452; c=relaxed/simple;
	bh=DBGRRLjKyXInFkVjuZiiItHB+vEqg1vprNXOqYiM1QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0+v6JkIwhRTvrUMiPUdjv75Vm9qq6Wmwo1DM3E6gvdUyydwaCU/h9bvonZVqHcMUx5rtbJoAs7laydy5Bv0ImlwgOPAT6BTm3QRXM/8Z1C9s/aqFrxAUu4P1PjyQah0ErU1IG02z1NGtv5865WUC7aqRbo0viyUZjK68bYCmz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tYrIdUVB; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tYrIdUVB"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664808a820bso1084009d50.0
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 04:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782386450; cv=none;
        d=google.com; s=arc-20260327;
        b=mLCmrCkhCDdFtEtJJSxzmOWzJQZ1XzgBTIv0ImBYZgEx94jEL6lbeeMF+Tq7Ep4YxT
         U0u4hL8zKTSzexK8oNyXcyjzRSi51wyvs/jduzSxpT1OJTpST3KFVsQXjSDuG5D7zlnZ
         hKwnHCE7xpEeXX2eQVmY1Ln3wFtX7SyXHBqsvJaQw/U960QMwA7s0mH956r4O1dYatmk
         Nsr44AlZ36h/OpcNh83+3YbBPjwMznJAlQWrzPGamUuutY6Ro/ens26tW36QsPMnuZad
         d5uFGqvYRLJs6sbWTR7DVaL0FpYopATVdX5oGNyT2s1QLhW2/ZU+dZYfRJL85PEkN83S
         Eqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3lf13cIJBwNAT6Ke7JgHfnNymgELoxPci9N8XDoYvcY=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=RFhBnG8sVh2XHd4bIbDky9MlA6zBUxlBZloXACzUqxVT6EP8GSJc+vX7gVs3oWlSel
         8WiI6d3UnEqV9pXrawgrXeO+4mVoTF8MKQr3eByHfy3XH7xamQKlt7OK/fZQjtrHNxuO
         +l515V6XwjUm7wMXh/AVKGDad7RUU63MP9eglRnESZIxVdOHPo9XrNl6GxBHH3Ja3D94
         t0aJDZqXs5tGTKkdRz20weeZu42/ReJ5ygsYu8zuoy4vEbTJFHbYXR7StL7nMG66RC9R
         UzOvCYpT/71CTeZXDPGz9yJbCJXGUXvOxtX+UTZYEwuOOYPHEDuUQ+VAI1417L8GWUXl
         JInQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782386450; x=1782991250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lf13cIJBwNAT6Ke7JgHfnNymgELoxPci9N8XDoYvcY=;
        b=tYrIdUVBcIh3ZrKy4po+W1HPr+kQAD0hpwhi0MnNNxPK+o9QR74a57zGXcXKTBCuVB
         iTfOCuXyiEYkHp7NkyX95UygdoC737mVmQ0Z2V3jWxHyVwcZlw3kMQr0jzIwQ8iftKkB
         t4nfWxMv66mPA93xgHq9I0IBvUJNQ57bMtprA4ILj86BpZdLZmvyUmj+giqFA7GLp5kD
         MCWIR1X7I3O/FK1f48vMe+uaMeZnvXj76P/gd1BiNYPBAO0dmbHKJEUsEDZKjWKlJ3ju
         mQ2vZTE4z2FhxnNSwaIYf0GUzA7stJmkKIi205mWJTnk430me/FX/zHv0RWn9JIcgNqv
         /RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386450; x=1782991250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3lf13cIJBwNAT6Ke7JgHfnNymgELoxPci9N8XDoYvcY=;
        b=gE2u7e9Q0ZAwLMmYGkq6NUWs7BMEsnfAHd3pju7EE7M+pUXHlGSPH9Qcg+n8SOG7Fk
         V5yJv4Xf4l3HU5KMUi7PIdRsXjQrCt8Og9ZueYsE36aoGtW1ccPB5NlfaUMZl+hVJjLf
         Jl+Fjq/8+OzBvhECZqyXbIps1UWqv5gk7yV9j0+jTCtZhnhx3vGeAJMDROUl+31jm3Yr
         GOyzS2/hlDmm7kFDI2O9/6N3nQscfhmLIjFKQLQMGLkisHCZTpbVe4bXZW1DwYU6EGtv
         FHKMuNlm0ENWrqdPvF/lFaf25QA94vZN1zVeJSvjXwCMoUK4xA6CiVbVQiujStIl5iq1
         cQkg==
X-Gm-Message-State: AOJu0YyeqMjl93Z7iufFfcQqWO1B3nwJBsNiN7JZpt8kli9Z70ycd9gh
	y61xFCF0qp5eJ0ESGOG/6XITsrSKqB7X4zri6IWRxjIfUlbZw+2RxvzcqjosGL9/f1cNGc4x8D6
	6TqBDDsvZodrlWVvQfbBDJ0opNt0Vic9OWTrqOPI2TzmY/2HEaBj0GN85Nxikre3T
X-Gm-Gg: AfdE7cl2M/+ivBRJwqVHuGvrEZ490wl0Y4K0EW28XGTrYGcng6C8gEL8wxU6yFepZck
	g2NFk4uZs0jU59OI7AYK3YETtNYLpC+IvC0SfecgPyZrVdu0ip2klpKsGNWQ+/goxiEsRuZPd+J
	XuJcemX+eVaT2LVAfyyb/K/HK1brqxoHQS2L37vbc+R6cuJfiMLoGWsNuAP68neTtejkGPj02As
	7sro6/xLcY6mONzB6rxJxPounD/EvaOQAr9SwF8uU+whf5z+RF/1sWAx4o+LGqo/5KhdsG19Y+1
	Hq5obzCII82O+aHQJEW75FiBEAo=
X-Received: by 2002:a05:690e:134b:b0:662:ca79:ceb6 with SMTP id
 956f58d0204a3-663556a32e2mr9336230d50.31.1782386449969; Thu, 25 Jun 2026
 04:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624-bpf-lskel-fixes-v2-1-e8ac5974a72c@google.com> <20260624183439.E32C91F000E9@smtp.kernel.org>
In-Reply-To: <20260624183439.E32C91F000E9@smtp.kernel.org>
From: Sid Nayyar <sidnayyar@google.com>
Date: Thu, 25 Jun 2026 12:20:38 +0100
X-Gm-Features: AVVi8Ce1SRY_WU6H7QOzLEn99skkGSFZNDX8JS4f4yjc032yPW_W0GtUXsqSmnY
Message-ID: <CA+OvW8ZN0ZcWy_cPO+Z5toPdNtm5x3HQx0JTAkD2YUKoGh1Acg@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: allow BPF_LOG_KERNEL from kernel space
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 7:34=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> > @@ -831,6 +840,11 @@ int bpf_log_attr_init(struct bpf_log_attr *log, u6=
4 log_buf, u32 log_size, u32 l
> >       char __user *ubuf_common =3D u64_to_user_ptr(common->log_buf);
> >       char __user *ubuf =3D u64_to_user_ptr(log_buf);
> >
> > +     if (common->log_level =3D=3D BPF_LOG_KERNEL && !uattr_common.is_k=
ernel)
> > +             return -EINVAL;
> > +     if (log_level =3D=3D BPF_LOG_KERNEL && !uattr.is_kernel)
> > +             return -EINVAL;
> > +
> >       if (!bpf_verifier_log_attr_valid(common->log_level, ubuf_common, =
common->log_size) ||
> >           !bpf_verifier_log_attr_valid(log_level, ubuf, log_size))
> >               return -EINVAL;
>
> [Severity: Medium]
> Does this code handle BPF_LOG_KERNEL correctly when it is specified via
> BPF_COMMON_ATTRS?
>
> Since BPF_LOG_KERNEL outputs directly to dmesg, the user buffer is 0,
> meaning ubuf and ubuf_common will be NULL.
>
> Slightly further down in bpf_log_attr_init(), the mismatch checks and
> inheritance logic rely on these buffers being non-NULL:
>
>     if (ubuf && ubuf_common && (ubuf !=3D ubuf_common || ...))
>         return -EINVAL;
>
>     ...
>
>     if (!ubuf && ubuf_common) {
>         log->ubuf =3D ubuf_common;
>         log->level =3D common->log_level;
>         ...
>     }
>
> If a caller passes BPF_LOG_KERNEL via common attributes
> (ubuf_common =3D=3D NULL), it seems the inheritance condition
> (!ubuf && ubuf_common) will be false, and the common logging level will
> be silently ignored.

BPF_LOG_KERNEL should only be passed by in-kernel loaders. Entry point
for in-kernel loaders is kern_sys_bpf() doesn't pass any common
attributes. Hence this situation should not occur.

> Additionally, if a caller specifies BPF_LOG_KERNEL alongside a standard
> common log level (ubuf =3D=3D NULL, ubuf_common !=3D NULL), the mismatch =
check
> is bypassed, and the specific BPF_LOG_KERNEL is silently overwritten by
> the common attributes instead of returning -EINVAL.

Again this situation should also be impossible due to the same
reasoning as before.

> Could the null-buffer checks be updated to properly support inheriting
> and validating BPF_LOG_KERNEL?

I think we should add commentary in bpf_log_attr_init() to clarify
these scenarios. Maybe rewriting some checks is also in order.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-bpf-lske=
l-fixes-v2-1-e8ac5974a72c@google.com?part=3D1

--
Regards,
Siddharth Nayyar
