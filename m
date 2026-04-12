Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D835F5E0
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776005998; cv=pass; b=b6Ei4Sgtw8TLUNb0rnR9ZSm0BEQ5wBtYonsDa68fParnULwlrwdfYjGP3JyV4K33I4kGWbo6TEBOAoxAtjzbiSJAew0PNLnzA8ulE6jq8UB9c3xEuOWsWredT5zP0yqVvDWNC/BrB9Y12dixTpQ/OdlQF5gASsflLgyXAUiFJJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776005998; c=relaxed/simple;
	bh=3fG16c8My7Dymjx6w9Pih4ZdMHvJsl8cOl5/g3HZutk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X77QS5cbCTAc2xz0drNBCvwjIFLCE+8xmsXqKKUN62v2nuOwxphl4WrhL6Tx/jKRbaNjgbmDfi7e3nyh+OVFmzJicyeRioqimlkY+Eyqo2bjou+cYt42GZb3v6TlsAQttqXECbXC0Huiq/EHQU+x5Qjz67YMHB2/m2n1e9x40Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvXitrmc; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvXitrmc"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d77f6092eso94941f8f.2
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 07:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776005996; cv=none;
        d=google.com; s=arc-20240605;
        b=hEoOepAMUmBksoWO8FMOxrD/Zx2GRceoMrqcIfPvpzXZJn5Gewnkt5ZlKCA8nSPS6e
         tok/DfGwDxU63sgetQTvF9PULisG5rHs6JGxXXEn9c3T2wwZItPQb/m6c+VKvIcY7dPz
         k3s//RE/6BTA+IngLXj7kJhMV5+xGTRwZ8DFWhdlDUcgqJn7XyEFilUZ5NRIRp3yLsZm
         SXGpbDsANwXw1b4R3JscAULn/hcWKN41lgxYWTVGGLj+KwRuWKTQcnXdymNuxmCJZolz
         Sw4tOcSkuj86pG4gwMqk+BdqGn5tOs7gg7xiv0CJ7WHLIG3kiiO0s4OfpN80I5uBXJPe
         ugTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+qdP+eXUnijvswTbMlj6E5dBXKbAoSWHh7GBFW93IYM=;
        fh=ZjZnlGJ4j6GsPbdN9KU7cNTEhuDuKixuJSySPsKlUQw=;
        b=VpktMQ5p5Pn0M31JlFjOAPEARkiYUnab0Hi4MD0yG3XZtn1powkN58cEm33pyBVm7b
         WDQ2JzaAISyRPyxSpRitCKvkgGwHm6YlGYU+kK04AEwCMwLRKWoaYyByv5i585PxZ9Ja
         BzlBUnkveo9heQ6vM57KKdSNQ1/sAKFY7mgVDCjNB91IOueMXzoO7T9sVHKDPqxjYNSX
         Ji38pzslYfpABI7uCqYrK0U8c6qhNv4f4Bt6CEolaJP1EcEoOi0DmRD7URi4TnKXQ9//
         GwDDohUXDWRDrcNQxCJ+P08Sh0I7zNofmHCPtjTnSrRO68cMS/9L+O7eL3Y9Mv+BurEg
         dTZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776005996; x=1776610796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qdP+eXUnijvswTbMlj6E5dBXKbAoSWHh7GBFW93IYM=;
        b=EvXitrmcwFoe56zk2EPwwF/3nX3paYhW3pJsgl2zLh62Sob2eb9QovKj/XmnmBTKWd
         uhLeglM6u+AjkcBimAPsUfSjiuDo2hWSw2+WGKCQvVhELhtG0paPUL00Z8S4nJfyIvt8
         n4wyH0o4EDXBLrMaE91FBrS8fib0R3XqQSARzlAAR7nlmrx+XYxz4nXHb7Fo74/FoZJ0
         0SLLRccLYfvMQEbwsnlKFj91/qPSYws2DmRSMJ/zGJWnkGcbxAkmZR5d6ZtHmFHpaJFH
         98iHGobxsH0jdgygHT7U9ThS56XQxclWlm5bn/dQXLr/Z8CIRBe1S2Of12UbWq+Jfv2d
         gQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776005996; x=1776610796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+qdP+eXUnijvswTbMlj6E5dBXKbAoSWHh7GBFW93IYM=;
        b=NPb/lgG3C5OsR5JALhZvdd0eLZjVyiUlREtTPDjQpOqhJu0hxzhzGzIcgpxGAxl29S
         EBYBPlhtIM0H2uMU8eo6bU8Tn2e+4xiNlboPEjZtJmlCXtIXQH5O7TefR5x1b4tCzjD+
         TsKVAzRtXnBu1RB8Fv3X12Y1ueGf+2+uG14a4GvSyarq18RQnMpm1nJeYi2k8zLHZ25W
         aKEdCFzoFOFPSlbXDzVfQmv311D7PuECNq0IyXui8VG9ElR0iD5KAdArlISsp8bKjtm3
         06m4obirvmUmE/ttIfBqT66iHfEPmmJKgI+XjDsjR1ElQdKtWfWhDdaNUl2XxxS2VE0I
         5lgQ==
X-Gm-Message-State: AOJu0YwtO3+5tdLkaSAL/Og4cCnX5P0r9jt994JRtVsnCQas9e8XLejX
	doptTXZGXTBVpci6JvLgBQF8ZdsjMxFXPFY0OlXKPLubsWoiwKn6LCKHaRHrIDfis1Vyb5buxW1
	t4d8ZDyNDs9oOgyhfyDoGxQ7fXBiA5Hs=
X-Gm-Gg: AeBDieuDQ7dpQBWFmx883l0lsSQb6NQ5911a+lDuZwHuooSnqz7yPamrPPP8hyUd4Xh
	3GZEGPJnS+OvWBmAX7OxG3+d1+tq7+oMRg4axZq7XBAk1J47+B2nveprCOJWadNA6k++teWRJ8K
	iZfwwRz7/+eDnSD9Titfi8AuXJI+tgsd39cKyJx3OlgOegPIB3f156vSliOXvKeYnfFQnfGha0v
	FBQQFR9r7E5v3QDWAvh7euMPvOaUUQIJu3WGMCLe6eMZ2sjcaytESZL66E6T5jFxIj8mbSKG/d+
	raU41f/pcPM4yzYFJVDtf219er+4I6pqQsIpjzuLbkShb4Bx99U7hIvaCtsOtaezuxQNFHkTKxy
	kJPiAALoablnQSDs8ySWxIMho95tc9czzlVai
X-Received: by 2002:a05:6000:268a:b0:43d:7403:4b60 with SMTP id
 ffacd0b85a97d-43d74034c72mr3586727f8f.3.1776005995889; Sun, 12 Apr 2026
 07:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412140715.30423-5-alexei.starovoitov@gmail.com> <ceb9ec96d5e0353e930f0b529e90a886d0c09b419c81b1cdcf7a8a1edddce57c@mail.kernel.org>
In-Reply-To: <ceb9ec96d5e0353e930f0b529e90a886d0c09b419c81b1cdcf7a8a1edddce57c@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 07:59:44 -0700
X-Gm-Features: AQROBzCNWObVj4HWCtDsYicO58jjdDK59sLqpFLjVbqc6fz95ILkk0oGg420NxY
Message-ID: <CAADnVQJMb833MnZR=jb=vX2OaBWAzzenDXAJU5rWGz1w4Rg4jw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/6] bpf: Move state equivalence logic to states.c
To: bot+bpf-ci@kernel.org
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 7:44=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > new file mode 100644
> > index 000000000000..3a4a7f6d861e
> > --- /dev/null
> > +++ b/kernel/bpf/states.c
> > @@ -0,0 +1,1552 @@
>
> [ ... ]
>
> > +     return 0;
> > +}
> > +
> > +/* Find id in idset and increment its count, or add new entry */
> > +
> > +static bool regs_exact(const struct bpf_reg_state *rold,
> > +                    const struct bpf_reg_state *rcur,
> > +                    struct bpf_idmap *idmap)
> > +{
>
> This comment appears to have been separated from its function during
> the move. In the parent commit, it sits directly above idset_cnt_inc()
> in verifier.c:
>
>     /* Find id in idset and increment its count, or add new entry */
>     static void idset_cnt_inc(struct bpf_idset *idset, u32 id)
>
> idset_cnt_inc() stayed in verifier.c (now without its comment), while
> the comment ended up here before the unrelated regs_exact(). Should
> this stale comment be removed?

Ohh. Will fix.
