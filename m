Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46ED3431E9
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 04:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768971144; cv=pass; b=G9ldOMgoBlnnt0l6OA8JtzgCyW27voYxG6OW0l6MkMT4b4v02d6KAzHNoiWEKx9/iyphTdfKTsRMEts1uvQJgsSfF35CFyW6KDjshMDJJ76EaIkK0+oJSmfcKYJpEloZvPxZicxo181xcXluhGEFDRRyc5OuPhBk2zodVJ1ul3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768971144; c=relaxed/simple;
	bh=Vp2V9CT6P57w7nalJTB675BNlqpEGZ51RV+qGikr5hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwIx8WXISnoDab2L2oSbejPxaQIPfI88fQtaC4+DGkdglY3fEi6qBqPo9KWZ9dWMrOkFSalBKFvZ6PJiA8ak7XB4XUdP298Fe6Ho2j55rAaNx8UpYHUNuClSRP6B2+qhnsaOUYXLLQ1fBzWYIKMdBU9h1y0wpjHn0qSWdFl76aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lvdvysrq; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lvdvysrq"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4359019da8cso1266553f8f.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 20:52:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768971141; cv=none;
        d=google.com; s=arc-20240605;
        b=ScWaFzJ1HiOHNEC0+iNSq4lH/gkitY7Hv2MwKzS0ZA7bDmiB+Jryj2Mehx+G5BtfXO
         4qIc8wF/n4etuTTnB+/lETXnJlUfx4WpwP6Pbb8Y+x8+qsU7UvSYoIkYkOJ55u0knFkQ
         5RzLZFmiwWgfSvQDDxsOVPDA0MXV0IJEPufAtrmacZTiXc9yQGiPxhbGTZK5VYoLAKxH
         plhPJdsnktH8LbPGJhlBIi8z3tcnc2Wx3WXNGvHFzMZOyZotW/ONMhnGpC1B1JJxSlnK
         gHa7NWw2enLjRo4osXGaFtBT6IsK+GfeOpj2CQMv772iaMm8s+hY3ovEBm9SGjpRINzR
         wPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vp2V9CT6P57w7nalJTB675BNlqpEGZ51RV+qGikr5hM=;
        fh=pDSgWFpw6QldTRiLrG9TNV1uZA0EjKtZWI7rf0/XHK0=;
        b=iuzyg99DsTv6Lp2jlXmEviKwJl0cRRhQyfVupWZAwL7Zt/Wzhro8p4oODWOj09DX78
         JxUd2XJ2Ikyk8WAlUMZ1k72Ctm09sEJiX2PwKKrmVPI5z5ogAipK6V0A3fnrWqxfSRTy
         WjObhKIvpO68m5q4H89zzgirCJa/XYg9N3+6fErCK1dT7eC1lYKyPLAR3pMUNU/7W145
         hZmWClVvk9vDOt8aj7xkZb7fojJJi0u1xxxcd0hAqSI7W3rcB87/gEHfn0yDXOc9QOcS
         AMgypR4MzL3sMBioWjgngK2onkTZUgwTknOhvfsYE2QNuWznu3txU77yBEWsjIlJTnfm
         K8Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768971141; x=1769575941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vp2V9CT6P57w7nalJTB675BNlqpEGZ51RV+qGikr5hM=;
        b=Lvdvysrqfvc3qVvdg8Oo841eLyeMdgDTv3w5b9QaBEySVN7C+l/MoGOqYUms0R7OyP
         UDgt1WP++pTpiIXIY632B3oObmVNOQ1qWjClL1OBAAJ5+KUeRuPtaohZwyRKWCpmAnCe
         sO8y27Ras79izNNSNPXNUNY17flT446u1GuUrgtMA2zXmjXzpuKp5l1jeh7dkpSOfkW9
         1XrN8iPa2v2gPQTmRakdQ3OGEyFjRdT++BOCg7EXnfYjs55/pnBoVKssguaP3QmV4Igu
         oau6n83AU/rxRpFlZ1PC1JjLQot0LJ8ljQ7M0IdhSgjYdmX1it1YxhZKjE9bn9tvQ63j
         ZxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768971141; x=1769575941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vp2V9CT6P57w7nalJTB675BNlqpEGZ51RV+qGikr5hM=;
        b=oJMXZt6Ch5kWoK/olFUFnKQUrw/2PYed8xEJjKOFTGLkfJjy8aH++8nFmUInpaTHq9
         IyGXO4Hd9nOVnL1+K+p9Bl9rxJVIGwOT7C50KEimsHsaXV0XuXTjierRmtw2w2NoQFxM
         FK5gs33hq72/74IC72CDJ8FXc1hYDqBGI9E0z3EIs+4xVjnUvsPmXr6WTlzJvckYtKP6
         v7apLrZMyi27bflYhghaJNKco77PaesgP9TneQ3MSntm0lHgO95z28rT+CxMTWYdcloJ
         j2eOZTfMXWfFyQ8Daxq/hl1OhcUSxtS80qxT4At3ddQrEXxaKvzubQYtCEqSqCOP2ixe
         f81g==
X-Forwarded-Encrypted: i=1; AJvYcCVNDnL8W7FxPn1cG8J8vlbQaBIyqiG91bM2ivA0OsiGa7p3sQ8jUVfdMp5EuDj+VlvlM6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ueavfAJV4gE2eyU1NyQuCxedtve/2BcNjNBYXzqnUOUxMPGK
	Aja39lug2KkDbFQxCnRDsqcvZu7mxEDpC8vO3jEEOMh6Par4PTxpSkH9vTn96U9Np1nyi3b5d6f
	UBPcsDtChdqro96w4GINkopD9MLdUjDA=
X-Gm-Gg: AZuq6aLIZEcgiMsjlSPs6MD4m5RCB/g6G4ZxC7n2WTDsbMqUQCsXGqMIGC/XRxG6kw8
	1JNZTne3qxgAKh5LzwMPw/utRzaLYjs26VUi4TdEBAqDPS+DTFEX+oO9vzncINm3P/IffGGfXIK
	7sspDUac7csd2Fvsbb3pNdGgQ1fZvoZwKqpW4kHlCz8qcISPO9Fcm+eQjYjPEiD+a62iq1hGcVw
	B28LqDIpAJrrNgxsgeOgAv6Nv9DHFzaZpOWRuFU9mDsmN1MNtAiWHwLKcA+1wydSJoGNOUNmPXc
	pTk6qzp31u4m5+B1xvlvOhIxQKkZbk/OAcS/dAYdop/3WNGzvKUYB3b8PInTPIbDbixYoUbdoyx
	2m50Z+6MTrJ5Rxg==
X-Received: by 2002:a05:6000:1448:b0:430:f5ed:83e3 with SMTP id
 ffacd0b85a97d-4356a03318amr22937222f8f.6.1768971141129; Tue, 20 Jan 2026
 20:52:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120182034.3647092-1-gary@kernel.org> <b53ee085-d9d2-4365-a5bc-d61e2bce97f8@linux.dev>
 <DFTNNQLGB1CS.2HDOGB99S9ACP@garyguo.net> <ea83b91a-796c-4329-bcf5-2c49efa897fc@t-8ch.de>
 <5364d5ec-f30c-40d6-9a99-c251fec3868c@linux.dev> <DFTTLB4I89PR.26SQVXWNG9U7@garyguo.net>
 <1897b382-41b7-4d63-815d-ac63f38485ee@linux.dev>
In-Reply-To: <1897b382-41b7-4d63-815d-ac63f38485ee@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 20:52:09 -0800
X-Gm-Features: AZwV_QhLo9KrubYhKVyARQea8KdqfPOlGFzXveCulREQq6-goKooyABKjrik-Ek
Message-ID: <CAADnVQKLtnfbaJCbbe=JY+85kBKfiUv9hjW+bumO_Y_YovuFow@mail.gmail.com>
Subject: Re: [PATCH] scripts/gen-btf.sh: fix shebang for NixOS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 8:50=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
>
>
> On 1/20/26 3:54 PM, Gary Guo wrote:
> >> [...]
> >>
> >> So it's trivial to put $(CONFIG_SHELL) in front of it. But then it
> >> must be migrated to #!/bin/sh, right?
> >
> > Documentation/kbuild/makefiles.rst says:
> >
> > Make rules may invoke scripts to build the kernel. The rules shall
> > always provide the appropriate interpreter to execute the script. They
> > shall not rely on the execute bits being set, and shall not invoke the
> > script directly. For the convenience of manual script invocation, such
> > as invoking ./scripts/checkpatch.pl, it is recommended to set execute
> > bits on the scripts nonetheless.
> >
> > Kbuild provides variables $(CONFIG_SHELL), $(AWK), $(PERL),
> > and $(PYTHON3) to refer to interpreters for the respective
> > scripts.
> >
> > So I suppose it would need to migate to POSIX shell...
>
> That's my blunder then.
>
> I'll send a patch tomorrow to make gen-btf.sh runnable with /bin/sh

Isn't the current patch enough?
-#!/bin/bash
+#!/usr/bin/env bash

I don't think all kernel build scripts are pure 'sh'.
