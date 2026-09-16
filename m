Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C4534E74D
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789590473; cv=pass; b=dXteLUBNS0LpT8FEPQXF7z7dSV4gd9076Fo0ULqMGdCeRRsuCcsLTlVrZ2q06ZZweRgFNVD+5zBgnfiJq28Y9ZR2OGU04hDTeDLIdPJTtJSmzC+57TOgzrDq4W987pwnzWDpjVJXliWoJBNkztJe31dS/w95SKegj2+ALdlt7Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789590473; c=relaxed/simple;
	bh=x/clYlgRoT8ecZ4amI6EDyZi9nLyjRFn3tcFw7m/2nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovlm42wzt644iLfxLJCfFZi3zYKvFRDdIgePkJfgYQrYrx44VGb8gxj+o0cKubK6fofsOVcA0GrdUCMeitqZhRjxmSNptforR46Pv30Oh5xcuAB4N5BRky/jeapmAvQAVPHxJCBGoMT408Uqy6JMRh9aKA5Qlaus6+f1OK0+NXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTTaLGq3; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTTaLGq3"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a36887bso76229b6e.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 13:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789590459; cv=none;
        d=google.com; s=arc-20260327;
        b=VinjWJJI+tqvM6tMELWrcxhrn5w9fq8fk0gvmQU6Yyx5nNDUFP0od/zSI+C/xWSs8Y
         7WFc/qxcXUCk4ZYXcIFi7NI17ksGcAo8QFxoXK3WUZ5tk42HBhR8OY8FS2Ku17SHFSvM
         jBohZ5Dk9sPJ/VpbOr5ps6LE96H0Ky9tgLIlL2uqhy6ZUlU/+P6+In1/zLDGDMn2edSw
         FP/64jjhghAr9ZYBjLMzvEOGnhNjM+nTnFt2Cj4a7sRE+Zsw0wbQzlNPIrvRNrETETOR
         I9CQIZx7F24P9TplaNlehRuzFEa7D7LVK8M7HIySv8YX3uERYhlDQyn+bhrQsn5gFLMA
         XzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=09wB9sSxe8eFMzNJbisPWq1Xnpzz8b7VvaT/+EjUr4c=;
        fh=7K2qWJ3mUiPSelnihIFryY3l1DriTibHaNVcRL5iMOk=;
        b=iRuca+LQPFWF5dBbNb0XMFlzJ9Nfu+kk9KvJiS6cXZzhLZLTLnM6tvRhrW3Vl6GI+v
         tNLvohYwmHKR1QMz5vADEX9k6/ylSNA6rTHH8ydRFQm2hM/gYqRPYpw3yPibIZjnF7d/
         7kC29/nOzG//AoTH7Ll8NWFxvPoCvgHnUt5nzSaA5jbJmdoTaYoUAAKHKcrhJnHJy9ae
         Xxplci27V4rtYoitQUXSnlLQvztvkhdM42mvbHlEemIVhwdaWj5Uwv/MA0iZsNImecy8
         W8ibaUsuFNArSGQjSrb18CXEjOFNPL212L7XwUf1xQxE+I5s1SYZPCw1EG7943zs33iR
         pGZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789590459; x=1790195259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=09wB9sSxe8eFMzNJbisPWq1Xnpzz8b7VvaT/+EjUr4c=;
        b=NTTaLGq3KZ9AKKP72Z5aXDugX4J3uyD0qkNNkizozIpFmEK5qBQhCKdYkHDyWJeYXw
         0RaqGpp9SuRcr2zKnTSSP1WGXmOQ16+76HYLEWKDVgbfYSeXoVoNT+zWKyGyrV1rogOv
         bnNDYf5zB6gWsv/9Ygob1evvFmUnTPvte0YKMOePRjz11JOgBY9V3i5TqkRAM8MquN9s
         g8wX3W4yQgd6jDIQiwSbeontWj3brP3e09tHTUrO/QfLI00xu1KVOidmmENXRV0vcPMe
         BpgHQsBOpli6tqFyLqX8HD78n6LsSty0m+tt7tH9gyX7diACHow1olCP2phqS0xy8D7a
         gB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789590459; x=1790195259;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=09wB9sSxe8eFMzNJbisPWq1Xnpzz8b7VvaT/+EjUr4c=;
        b=O/rH15L4wxW73rj1uUCX16Y45kTWJ1wcVNtrpzj884f1oNw+j26+NO5rPNM24k7kvN
         yaDa7KNTaziq6n3L6SALMNM4N0/Gc/95eqyILWEmrOqxg72VmsmWrN1Y3OWFt1sjamrU
         3NqZJAfWVFXPqwY9DsR2Dj0rqNe/KL1IxchKXtTR9OdWj+KNbfD6xo9jm98vmTK5evLL
         WNL1yPnuzywYbqFVxAfCB0r0m1csiCmh9n4lSgXKLA95RuaXQ0M21LSN9bWwzccFfrJt
         TPLPLWNGdY9DJfaBao545iFtB4/V5mHqa2oXJLXgPxorL2w5vVLux51tV66Aik1tXvVH
         Pogg==
X-Gm-Message-State: AFuF++nNAGR34Pj2C201Di71wFcK5Ym7bZfI4gOy3QsGnc4gzX74WR+H
	IK7hz5c5UWW9/d9JQbpU03T8TZQE3zEw4zVjPncXBXU+do0cFne9f8eE45B7fUtQqwL5Ai8VnG6
	7togKFCoLU1UwBlBZU8kMKIe90+GSWkw=
X-Gm-Gg: AYBFou31vl7pM2pxQosTHahM0T5IL2i5GRzrqOd2HbztV/qd1kDsjn+8huzg5naOcfc
	6LE4OcwwZg0ZhyotornIQYM5XQj+Cpkj17cS7c0L3D0264XfTYg4apmzljK0rNnswUl8WaWiEVF
	L4jXFwgIgsr7umFeIhz87ogScoDo9szKu8AqDcXiklczfbHhhWYLSyt8oAe0qLJTx6Sz2bXBAys
	Qsz5aj3qmYCF1UyL1oUnsWSLDZ3YbGx5NL0t6oipsBsCjql1tbREeWwN/p3uplKTfr4Nc0kO3Ru
	aRk94fwZhN7QWmg2EsRumKKsXoB5p+Q3o2BWWqyvtji5Z874+j4oIOPeJ8UX4kEL5A==
X-Received: by 2002:a05:6808:3510:b0:4c2:d7e8:cf67 with SMTP id
 5614622812f47-4ca4c17f638mr4786157b6e.24.1789590459010; Wed, 16 Sep 2026
 13:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916192805.3991983-1-memxor@gmail.com> <20260916192805.3991983-3-memxor@gmail.com>
 <CAMB2axNg4Gb-h4s+hJK7K0gYkdm+4RhKJ6Fdrp-=veuujE6fEg@mail.gmail.com>
In-Reply-To: <CAMB2axNg4Gb-h4s+hJK7K0gYkdm+4RhKJ6Fdrp-=veuujE6fEg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 16 Sep 2026 13:27:28 -0700
X-Gm-Features: AcwNN1Ukdkb_HnUUS0xtMZk6T60BIod_Vsx4pf6SHcJMf2e5wro7hJ1H4ZxCZe0
Message-ID: <CAMB2axM5sm1rQoyb=NEXTgzBh2m_CBZ0LG28oZTR5exE1pBV7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Fix generic __uninit kfunc output buffers
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:52=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 s=
lot, u32 prev_slot,
> >                           struct bpf_call_arg_meta *meta,
> >                           int insn_idx)
> > @@ -9176,15 +9190,16 @@ static int check_func_arg(struct bpf_verifier_e=
nv *env, u32 arg, u32 slot, u32 p
> >                 enum bpf_access_type access_type;
> >                 bool known_memory;
> >
> > +               if (meta->btf && (arg_type & MEM_UNINIT))
> > +                       meta->arg_raw_mem.regno =3D slot + 1;
> > +
>
> Nit: Ideally check_raw_mode_ok should take slot instead of or with
> regno and we don't need it here, but it is getting larger than what
> the fix needs to be. I can do it as part of other func check
> refactoring if you want to keep it as is.
>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>

Actually after reading patch 4, I think we should either just drop
check_raw_mode_ok() all together or keep it and fully populate mask
there. This reduces the divergence in helper/kfunc handling.
