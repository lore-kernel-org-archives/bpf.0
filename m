Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5174C77A1
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930707; cv=none; b=ZasgDIglYGWVzpKc1dwQaa06nD5FCvYZp7coEI4wbRjiE70Q9b6oGkZoXRJFj09NkA5YW4UprNk1jUKaPgEA0JN2w+G/bwpNwna8NmDjgEDY8taHopyG/KEQjfg1bC0ggy6iPPyxcR63FTU0SbUKgjEdgyRIk109exc002u7gKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930707; c=relaxed/simple;
	bh=287ARGAE9A75z0G4bnE9KIYbh8xH/bLPfBLL+TRLG7Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=TYY7egpj4mx/sd+9KjBmhv4qSBtwul9U7FLt4XxMUISR3rXOyKiz3Utd2xHApBFhExpw4nfYB19+QpB0jpKRasQ8dUo5AkYs/WX//Bt4SBcsQfnFFzqeGOyGKJI+25cp1guPDygCwscWxZMN3rwDRHL8LFBVbQXJJ/ku+yV+Alg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+cxpjPR; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+cxpjPR"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso35878545e9.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780930692; x=1781535492; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab4yfHy/KguVgETEgNEQJ2cO76fZNaiFeDbsyBlwtm0=;
        b=n+cxpjPRJp7OflRHMtzUQ4lE/xsHKuCZ/Mcn126Ahy1poqRZUpgYdzytElHSDcWI6m
         +xthIFVszApR6mrjCTug+W15YH5JMOsdKRhnQ2u+8UeSVobvL9QxipoVwfDFVXuQrRK+
         9dc2/Nh50Gn9th5HHBKPH69WWlfo7X2b81gvZ7F7kyUfFukYIglRYHkqpS2VSZY6Wcin
         xKAQg9EOB9EbE76cYiIZgvBYt5Ndp4jBJ+0LTSGBoHhqgRAVvDL/v1xzT5saz7MYva7C
         aQ2YzH25idQqI3iVxJyy4dPgQXCPqUbbTPSDP3ynZgwPs6w8wncerua2xrBXohmKz4bB
         O7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930692; x=1781535492;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ab4yfHy/KguVgETEgNEQJ2cO76fZNaiFeDbsyBlwtm0=;
        b=CNgCv8ioG5UCIGJvB405/wsNCloG9F84/FPlXxAlVaMwRCaRlZog1bu6x6qEuyJBQb
         z+lEvyI5TbhIavCtXi4CnhhpwAKl1cMqfQThwdV4dy0xWl6fN1xZrfU0OAWWm3rShGBM
         /L48Z1sXq8v6ZbXwjFjjkAkdWlemrEZ7FSbg97Eek7IgG5oTU2JyNGlz2SMsUYauw2nA
         qrKHVUHkmJDNyAujBrpan+Dxd0HiYBj+yKZcx5YpEB7GMWYYQ3zu0IzWYnUk2Po7+fbw
         b2WUVi/0ct7Dmuii/jZiUqXsGEJFacq6ok1ZUgTpmTOV7sln8EQ817bYUkymkkIPm9Oh
         +wfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rAtea356mQsA2H7L5NW2Rf7f7y9dfm/uMjm7sDx+mIy8yK28p76I6e1Dp19icyi0MoLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeumUl0CLM+CneCz1EjAOEdCz2ktOQqKNrUXyk5SN9AM4U2SVS
	TFLArNdUL4rTnqPPkLaWSEBklsllR76kkDyptrYz1qK12ImPhxZJuQp3
X-Gm-Gg: Acq92OEPE6VaAsHYbWzk4ih8bMNH+84/oNPc3wp8GaumPpa8yyuHP0HrTJAotzbOr8v
	rsocfY0/XCuVRZmZUM0VirfHl7I6eAH4IHGvsKbCdu2Oheqb7EJABeqLWNnCOPCtjk0VbRCrYiN
	CnllrK0GFBI0wfgc4kj3qTqSfmp+O1O3hUUygASjamznRnnVBWPVstm6Z0QFUmKajKGRE6GzWpk
	klxdoXhWz3Fh6bnesgrOayaVXG3piIcyZyxTouRwfkCWQVFhCu/t2FQqMknrGc3HhUYF14ZKjI6
	q0X5Nlv57w+Eri3V5L4ibq52iIvie+Hae6EEBK9umA06K9gEHoYisV0TEQWptxkFLnXpz7k2EMg
	jA1GEGtOlwF608euJN566sjGRcMV/z5zuzPZbfleld1dHEOziBDwT4Wsa66qabnhed5orXMFV6S
	yfRFgugo/h93AyJxPPKK4DjkPHssXzrM5fX9V50MyyJUVd5kEddOggYaRQeOOnx1ytO/zzNLJpR
	aZVWEjYhqhzzmr6FonfkQ1uYO8Myl+ghqD3CxgAX7nQsM9ftBY5yJ9iHpog0QRig4SbsRGFSTW8
X-Received: by 2002:a05:600c:a00b:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-490c2d2a9a1mr205805285e9.16.1780930691857;
        Mon, 08 Jun 2026 07:58:11 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm386316635e9.7.2026.06.08.07.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 16:58:11 +0200
Message-Id: <DJ3R8OV0HWJZ.J1V1KQAHA9O9@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>,
 "Justin Suess" <utilityemal77@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 0/5] Fix kptr dtor deadlock
X-Mailer: aerc 0.21.0
References: <20260608144841.1732406-1-memxor@gmail.com>
In-Reply-To: <20260608144841.1732406-1-memxor@gmail.com>

On Mon Jun 8, 2026 at 4:48 PM CEST, Kumar Kartikeya Dwivedi wrote:
> Referenced kptr destruction can run from tracing/NMI contexts through
> bpf_obj_drop() and map value update/delete paths, reaching NMI-unsafe
> special field teardown and deadlocks. Justin reported the issue and
> iterated on fixes in [0]-[2], and also confirmed the bpf_obj_drop()
> reproducer in [3].
>
> This series rejects unsafe obj drops from non-iterator tracing programs,
> limits map value recycle to NMI-safe field cancellation, and adds
> focused selftests for the obj_drop(), NMI delete, and recycle teardown
> cases.
>
> See patches for details.
>
>   [0]: https://lore.kernel.org/bpf/20260505150851.3090688-1-utilityemal77=
@gmail.com
>   [1]: https://lore.kernel.org/bpf/20260507175453.1140400-1-utilityemal77=
@gmail.com
>   [2]: https://lore.kernel.org/bpf/20260519011450.1144935-1-utilityemal77=
@gmail.com
>   [3]: https://lore.kernel.org/bpf/agyG3eQwgmoJwmj2@suesslenovo
>

Justin,
If you have other reproducers that can be crafted as selftests we can exerc=
ise
along with the ones I added (esp. for the task NMI deadlock), it would be g=
reat
to include them.

Thanks

> Justin Suess (2):
>   bpf: Reject bpf_obj_drop() from tracing progs
>   bpf: Cancel special fields on map value recycle
>
> Kumar Kartikeya Dwivedi (3):
>   bpf: Treat non-iterator tracing progs as tracing
>   selftests/bpf: Exercise unsafe obj drops from tracing progs
>   selftests/bpf: Exercise kptr map update lifetime
>
>  include/linux/bpf.h                           | 30 +++++++
>  kernel/bpf/arraymap.c                         |  8 +-
>  kernel/bpf/hashtab.c                          | 32 ++++---
>  kernel/bpf/syscall.c                          | 27 ++++++
>  kernel/bpf/verifier.c                         | 51 +++++++----
>  .../selftests/bpf/prog_tests/htab_update.c    |  4 +-
>  .../selftests/bpf/prog_tests/map_kptr.c       | 66 ++++++++++++--
>  .../selftests/bpf/prog_tests/task_kfunc.c     | 42 ++++++++-
>  .../testing/selftests/bpf/progs/htab_update.c |  4 +-
>  tools/testing/selftests/bpf/progs/map_kptr.c  | 89 ++++++++++++++++++-
>  .../selftests/bpf/progs/task_kfunc_failure.c  | 43 +++++++++
>  .../selftests/bpf/progs/task_kfunc_success.c  | 13 ++-
>  12 files changed, 352 insertions(+), 57 deletions(-)
>
>
> base-commit: 50dff00615522f3ec03449680ca23beb4cfc549c

