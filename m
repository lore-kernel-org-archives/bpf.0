Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46BB86637
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035975; cv=none; b=EggWKHc176FExZoe4spz8DUufcIiOZLM3TUolmkoHY0+VybK9KTmleWTtbNgFj+SqBGu3y7+TJldVTk6OsGjPlAquFc4Asf1wSiaA/4it7U8Alen0kljS7JBGm/KJVJK/5LoLnCeqxjxuAicZ57Jcra1ecK2aLzttH4grkLov04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035975; c=relaxed/simple;
	bh=gFqBYv79Oe4VWuydL3wkXy7M4uX3TlLt/bVmuJvy/j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hjtt/mePcXpvI7QaZrm0YnAZAeIoxMhDD8OfGkcQIgB0ImshF3vrAxSKAEgkQMhgTL2TjoCZZ7p/nw0dniRozFIUPhvRJDI4f6zrVQpJxkmAiVqRuwc7ynnGWwMR428MhUMuu6HXBABsrSAct1mnueCXDltxuP1gO1HqMbkTclY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dl/fM/eL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dl/fM/eL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711035972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u/bDAxkRhGNaI63WaSFbPk3WuTeCpBeNP/DPNnUuVA=;
	b=dl/fM/eLBsW99JO4lU8aQEo4IjQ9EGQbZNxaiqBLJGG/SJzhPbvvZ9PKlhk+mQL13z7qxT
	XqN9hUL+XhIY/3wuB2OzSRY3TuFnNWYpece4a/Dto4MtFZ/q+kpsaz6AHB0PDfKVE8GH+a
	HmDIy34jFH/8uR2vwn3ijBxyntV7Z+4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-OQPe_Z9YO-C-H6_eT-BfMQ-1; Thu, 21 Mar 2024 11:46:09 -0400
X-MC-Unique: OQPe_Z9YO-C-H6_eT-BfMQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-568b393f5afso643095a12.1
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 08:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035968; x=1711640768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9u/bDAxkRhGNaI63WaSFbPk3WuTeCpBeNP/DPNnUuVA=;
        b=rEcqqEiftfeM2E0lbSzDEetNhNNYgSkhco6WPffcNalg5Vx99kfsvR9mHNx/NvW6s7
         f9EjN2XCx4MRu09jjW1HuiFWlSyWrMH5I9mHzArOfiWzwIsVFHpeWW0i23aWEXE1s+un
         go3tQuLlGbqVhkZpH0tsX2YZwO8G/2i9LCnW9TK5Gw3Zu7QEBa2EWaRpovOFuI+wasgF
         FAz4BKZ5/9ISRefb5UzzpAT5VOfIa4pwQxjNsmK6RMIjDvQWw/SPvT4DcyOehx/wXjdV
         Jzcuu/XvC8mUnGHAbDq7/2g9OJlEbDElFWxalV7UdWunv/NoutbxDUr7GhXnQGQ/6Z4i
         2dOg==
X-Forwarded-Encrypted: i=1; AJvYcCUVWRJENQmTtivowTfXXqHEt54wQENtYdmBYqeSI0RWoINFwrdlY2LOsb7z9/jF+fcTaAFa62Kl/e9ZfI9BSBm4bJ1h
X-Gm-Message-State: AOJu0YxFtnoIC/HTDrVIQXM5f4kiDwKeB3KlFhujDttQ4zEDPE7rqe75
	FAHNavqr2yNSqVL89hkmerzPRjL0K9YtgSziQIjJI7lhQuvm2BppkmOfnepZvguzXsCYlsKINQB
	Oy86ximfibuM6LvoM18PAhdj1omQvSlWiJHZTtQgh1jQRe1LngWqRXm74FeFpaZbGFswx7+8m5U
	H5f5v4qMHqQTrzZvKwLdWkjUl6
X-Received: by 2002:a50:d74f:0:b0:568:c4ca:987a with SMTP id i15-20020a50d74f000000b00568c4ca987amr1882705edj.13.1711035968301;
        Thu, 21 Mar 2024 08:46:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyoGZJ6qMf3KzVRErhXAnVH5+F4wxjV53GrawrpT4L1asy0FRr1gT8G4TR9rt+kUD4VoEMGruWjRF4VmAhHqY=
X-Received: by 2002:a50:d74f:0:b0:568:c4ca:987a with SMTP id
 i15-20020a50d74f000000b00568c4ca987amr1882679edj.13.1711035967938; Thu, 21
 Mar 2024 08:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
 <20240315-hid-bpf-sleepable-v4-6-5658f2540564@kernel.org> <89e76fa5834bd34ef94761bcbc987a1be245b261.camel@gmail.com>
In-Reply-To: <89e76fa5834bd34ef94761bcbc987a1be245b261.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 21 Mar 2024 16:45:56 +0100
Message-ID: <CAO-hwJKvK+QYig8jM2MsqB_WSCP7VQGt5NSWXJUZR2=_5+Y1RA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: add sleepable timer tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 1:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-03-15 at 15:29 +0100, Benjamin Tissoires wrote:
> > bpf_experimental.h and ../bpf_testmod/bpf_testmod_kfunc.h are both
> > including vmlinux.h, which is not compatible with including time.h
> > or bpf_tcp_helpers.h.
> >
> > So prevent vmlinux.h to be included, and override the few missing
> > types.
> >
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> [...]
>
> > @@ -6,6 +6,14 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include "bpf_tcp_helpers.h"
> >
> > +#define __VMLINUX_H__
> > +#define u32 __u32
> > +#define u64 __u64
> > +#include "bpf_experimental.h"
> > +struct prog_test_member1;
> > +#include "../bpf_testmod/bpf_testmod_kfunc.h"
> > +#undef __VMLINUX_H__
>
> Tbh, this looks very ugly.

heh :)

> Would it be possible to create a new tests file sleepable_timer.c
> and include bpf_experimental.h there, skipping time.h?

Sounds like an option, yeah :)

> It appears that for the new tests the only necessary definition from
> time.h is CLOCK_MONOTONIC.
>

Yeah, that #define should be the only one missing.

I'll try to come up with better tests in v5 :)

Cheers,
Benjamin

