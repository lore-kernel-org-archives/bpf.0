Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0925C818
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720235; cv=none; b=nrh3aLciL1Dc6dj3WMIZbQeio2pg2yFaOfjQIz7qrxO4rT/Ssox906w3GiptHNhP3jWUE/OYlk9q05lqOa0MbOHd6pD7iRCFGq+WoSV4JIEMjO5QvpMLcnoWvugbBSLMLah2konabI9OdgZiLcQ89dXExLg2+qlvfbnRbDZ6rqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720235; c=relaxed/simple;
	bh=wT65fJgWgHtQWTJFDFoMVfcmeTe2UBqWRp7dgaZs8Iw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBBU7zV5Ydi4ycUQREJm7V+8mcsaHgoQ33eCYihZmIr7rs/ZO3QUhN7PUygjGGDTgM9gce0LSYid9ezCJJzZbUOVmQ9D2ma1a007d+NLxERhv2mKqwU68G1nEKfzP9OaAOdyWmEsPupFRT7tADaRbmGwtq3eKgeIbelJ61GvwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBil9bfg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBil9bfg"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3811074a8c5so1246713a91.1
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 14:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783720233; x=1784325033; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xvcl9feyIjfIY7ZgBrz4qoj0VATxg12ZzvEDUGDEy5s=;
        b=lBil9bfgMmQycl/JYPZltwFjA8tQ63jL3d4ThZsUlvIURhYpgw2UhdTHi8JwFCZfHD
         S3xDrsYTrC7Zc3lIn3XFPsv27o5czFpDN/viP+T5YkpLmL4O9whN9CPyyZoyM0TEhgFK
         Ot7TSqyJZ7s04UULqcKmqVRfv1F1VCOxOh692ErNXfKYYlYsC3nCVXff0PeGAMxKehFV
         FVgHCr2vK7iSYQDkFWXo4zjZO397/j/gBRHHSFYIdJZVdHo4LOznRkgeqBiYIWxZl5RS
         sN/ZJSIsSZ3q6qA4DglO7Koki0x/Y+U4Y9tV6KuOjtNJ8mjNeGSZQz+vcEuGZHlW2aIA
         68lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783720233; x=1784325033;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xvcl9feyIjfIY7ZgBrz4qoj0VATxg12ZzvEDUGDEy5s=;
        b=nYOsSIXPTRPNzEFwEinxgtrhoBVl7kVmV1bIyCoh1CzUYj1+d6vUA9hCu+dUhIgwQS
         4rFstHCzjD74uouDkJ5F+duc4IozdCklEsFAkSEGljQJ51HtrVa95b2cnVm4GInqJpk/
         t8ZZgXYZFFgAcZlAObBwL//edq29fX3wi0FQwiaPT12ttv9dJQueaZm2hhEXlh9vjbEX
         ceY29/3uO1CF2rry/40iG4/bckZZfPijPxy6fO+QYOj+5Zu4xNa1LydtzCMa2mKeKyDo
         R2GLRAjontm+oOYAausemEbBHujMExYgFa2kl2dVWUMYF5y9jnm/YuDAMzaPzmRGXnvW
         vPhw==
X-Gm-Message-State: AOJu0YxjMkjgfXJo4+yCJpxggLXfXdHg64yjz/I/C+7bT+MIj+ad+1HD
	JF+bT1tEDjl+iyEW9vNndzabZSj4s9RcvjKm6asyrRpfnqL89YYYb//m
X-Gm-Gg: AfdE7cnVWdTHrr/75EmIM8NmvRCeu0zwdUhHKqZzXHEDbv12NzTI+kEFODgb35ONLds
	TJ5OfDnYc1KuFRS00qOeYWrAphP9n+CQaL5Rc6WdH4xe6deWgknR1cosE7BCq7lp1a2q+4gUCfX
	tO6wB1Dp8bGZqKJl04tmjdXlhUv8DzOjWEcYbqUS+xy2TP5ms6ZGxyzIRpXIfDLX7+mx/EeIvIx
	Gnq0deppnwLEIGxEHr1Eu2X30z3Utu/+QbR3u6x6aNbKLCmwP+3Iq2AE5/d82UC36UpU97LHt06
	qxOMUHXs7GM0bUO4+oET6SibBFVXWLhvMOHWFobuSsXsARx48Gi+JYvGMccvTZnjwbr3/3fUwLg
	/J9j/6glzMXzVMc7CQzZV00b4ouYKcYfMmuBiaUhB/5YCc2T6yRlE4DtAkfnWKGGylaqeyCt410
	qSwONVdERqwjgvC61oOHsURABsS18U7ebG0M6icgK/NMsy3C0d4Z2hzlqHfjuC8lLQpgntUw==
X-Received: by 2002:a17:90b:5247:b0:387:e0db:bc24 with SMTP id 98e67ed59e1d1-38dc77c5839mr612260a91.36.1783720233566;
        Fri, 10 Jul 2026 14:50:33 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f4c5:3e8e:8ddd:d3f0? ([2620:10d:c090:500::3:1728])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm47983420eec.0.2026.07.10.14.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:50:33 -0700 (PDT)
Message-ID: <cbee8f83f6e11ac58afa366317d52e64473b2736.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: veristat: Minimize map size
 during verification
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Emil Tsalapatis
	 <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 memxor@gmail.com, 	daniel@iogearbox.net
Date: Fri, 10 Jul 2026 14:50:31 -0700
In-Reply-To: <CAEf4Bzarum7QXKT+BuvBa9kSrjMX=BzknWFKQBQuROKOWFeuZQ@mail.gmail.com>
References: <20260708193239.5063-1-emil@etsalapatis.com>
	 <CAEf4Bzarum7QXKT+BuvBa9kSrjMX=BzknWFKQBQuROKOWFeuZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-10 at 14:44 -0700, Andrii Nakryiko wrote:

[...]

> > @@ -1248,6 +1248,29 @@ static void fixup_obj_maps(struct bpf_object *ob=
j)
> >
> >                 /* fix up map size, if necessary */
> >                 switch (bpf_map__type(map)) {
> > +               /*
> > +                * if the verifier doesn't use max_entries
> > +                * then set to 1 to avoid -ENOMEM
> > +                */
> > +               case BPF_MAP_TYPE_HASH:
>
>
> I'm wondering if we should add ARRAY here as that one is actually with
> high likelihood will be large, though there are some corner cases
> where size might matter (e.g., existing code omits error checking
> knowing that verifier will prove it can never fail; resizing to 1
> might pessimize such check, probably, if index is larger than 1). Can
> you actually try the latter scenario with some small program, I'm
> curious how the verifier will behave?

For array maps there are several complications: first is the constant
maps handling and second is null check elision. The latter is somewhat
nasty, see check_helper_call():

         case RET_PTR_TO_MAP_VALUE:
                 ...
                 if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
                     can_elide_value_nullness(meta.map.ptr) && <-------- tr=
ue for array maps
                     meta.const_map_key >=3D 0 &&
                     meta.const_map_key < meta.map.ptr->max_entries) <-- ch=
ecks max_entries
                         ret_flag &=3D ~PTR_MAYBE_NULL;

[...]
