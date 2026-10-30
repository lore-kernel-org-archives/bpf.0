Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357434;
	b=LzHf4Wd/wbrRMlyfx7cmGsi/U305+1V9bKyKMyjl/5ZjqEmKJoVMJ5N3PWCTsdE5IUKg
	 ZqXrRJSXJrDsa5btf7gQyQ5yHWX0eLTiXjU7LDXKXY79zMp3uxfip7uA7UTCwW/gM+mCw
	 xN3wKq1Jo77abUGyRWGpvwIx91U6DBvAyxGl+/rYK2ymPq0/XUeI5h/JiJF5T/yeAF9xf
	 BccfQM5Gg0++jGajr1ph60vhBZQ1q7ainVt1kMRrg3ZnHu1rscRh5mwheIk7F9wOfKFJy
	 iDU8Tyj8FYU+DPU/KvvNHCpXnWE5QHtHYeP0NmSBtdIvBN1cTqBL2NbWtNIE0wfso0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=g0au4KAwJy7gDntm9ACSIbu1AVWLccO3DOOW3yQIu4U=;
	b=SomHJulpySNIsT45oiGV5uZBxjJ6PIz2MP6kZpjP2W3xw0njs3GUD0fU1PsufWuV4oos
	 rLMuSEy7fK1r0lwaQSxVJ48ad1apB+Ij9kpEquE0rfeE5/drQ5Y+ei0ud8oBs3DWFnl2W
	 0whtMqnJtj9o0Zqibn9EGsCBulx8wgP4g0qapR+sNxUfi+o6zQ7NmNrL6E7egx4v2zcOm
	 9EOk1WkuiFo3nNyex9wx4qiWBSZ8HgsGwS+wjjMNXgwTty7vAAP1IOBeY+y4k2n3qrAM+
	 SJoZggZDYi5Tsfd0ISOlEvCmERT+EHGTWZZPRpg3MhccAnT2dt34Kz2yMm8Fo/Xhd7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JSL6kraP;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9D60A260F
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 10:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAF9D60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JSL6kraP
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a215e64962so5101745e9.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357432; x=1793962232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g0au4KAwJy7gDntm9ACSIbu1AVWLccO3DOOW3yQIu4U=;
        b=JSL6kraPQoNbAstuFUdvWTXqmZZ+xa75wRJtPV1Gz5K7GsINqbZeswFsCxiHYYAhod
         /Cc8aha6l0uTGMB7NjDehd84ShM0pzrw+osWJAh7hAUPJ2Bw71kJ7UMUrHeGwMRwcXh/
         K/t6WiGV/S/ixpuRv1USx8md2lccGM6nv4uduJiX7ej2p2pqshXgtqJD3uUFXyb1LF7V
         D+roI+qBhKKI3eiqAbkBDrmJweN9/+IlQ+cX0V6/KmVk9GEi6jrlJ7eMb70qHAtEdMrc
         rcgO3rsbaEIjBjdnbP/Z4/Pw83WecY3IpSKcvw2H+RBj1qT1WdwHDsP+9DVDdfuAiQ8C
         zVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357432; x=1793962232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g0au4KAwJy7gDntm9ACSIbu1AVWLccO3DOOW3yQIu4U=;
        b=RKWCLfwZvUCAsPaAoOH79PJqy+PefZaryKRSgA5+NKFZt2lmMNVsHxM2b/XsdaAFZg
         tNTnwuUsH2x736MoffSJCCjSbkAKELCR6VdNjsbTC1OmYwlsijQaq66SpafRBGLX27ON
         KmnwrJPUeChqKf+wz2lELSBdpyfQbuuNtMtVFHI+PsxX3AyW9j3hDdVObLC6j+doHgWx
         ZUkdtMxhLgA+e+6sQOunDz2+QAbZYSd7+/5z2TtwxIFaI0pViiKf7em6G0lO8/TTQzrJ
         H4g+s7OjDm0fYIAp2suhWi5yXUVppNlaG5vUTX1BhcB65p1GS1qOeqekl/BF8eHwNuVH
         jGfg==
X-Forwarded-Encrypted: i=1; AKwUvBzfpvrXHZysMOG1uv9jQtokv1UUBD7dAlbvetJlv1Ozs73nIlXvvuatTSvUTIipr8vyPWc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVbbloEepqWuhMRf9Tch1l/IqaOI/mwDGp5A9eS+fPyXgvjSQ/
	bUsAUmRwtKw6z5zhXP/u2nvXsWtvGC7RyP/2jFaBKLAEwY5Qz6IdsOAT
X-Gm-Gg: AYBFou2YTUpJAAii1bzk0vPWV5Z6oMQqXRWHnJpTr6KAS4T8rXoucfr9FAcNomzAteE
	VTTBB4+59NfUnJlEKw8B3IdHSA/rgRETeOPXHprDQ8NG+C5zXShm4rEk5U3E1VlNVs1rPA3DJTH
	UzyXSdBKFxPFVWv8TtX5aPQ2Wf3XEOmjcQHC/4LvOE+I0lJwGbDR1XFw9NHu643wlzyqbAHGocn
	rtb0VODWu6vqQHegz+0YX9ZXAwnqS8vjQfiwtDu41C3yNl4m8NI3mpp/6ugN/C66FKbUyyPZSh1
	l2UVQqeLcxbLRr+TGJTLMj6K8VyLs3MXl6O1Z0/KRyNrM7Dmtj0pm7UJek76h7ydh0KYTfK+p+Q
	JGpui5ouu2QPF9IJKk+02L2x73pVox+NE3kEg8j406gmokJwrymCzItAboID8ly1VlYPV/TQQHQ
	0UMYl/fwO0bTakIhQ9lhqdhLAOP8vINwIxwNmsnCiJjRhBxnIlI99zojZDkZgcaeyLiZo48mJMB
	U1YcXQ2/Yjf7Gcv0K2hYSD1/h+VbQSkLMtg2JMZAnvLTPuxQomWKvkhoFADuk+2/Pql25SMZ2BR
	Zx0=
X-Received: by 2002:a05:600c:8708:b0:4a6:42cc:bf7b with SMTP id 5b1f17b1804b1-4ac150b2176mr43501375e9.3.1793357432164;
        Fri, 30 Oct 2026 03:50:32 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896fesm143894065e9.10.2026.10.30.03.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:50:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 30 Oct 2026 11:50:29 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: Re: [PATCH bpf-next 1/8] bpf: Add __srcptr kfunc argument suffix
Message-ID: <auR2dWsi_K3ut-mK@krava>
References: <20261029212551.56964-1-jolsa@kernel.org>
 <20261029212551.56964-2-jolsa@kernel.org>
 <CAEf4BzbUQpQcdpCJ0o2g0YkaR_Lwe9EOXdj8Fth0UUpAs-LR6w@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbUQpQcdpCJ0o2g0YkaR_Lwe9EOXdj8Fth0UUpAs-LR6w@mail.gmail.com>

On Thu, Oct 29, 2026 at 02:49:22PM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 29, 2026 at 2:26 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Generic sized pointer arguments are treated as writable memory. This
> > prevents kfuncs that only read from a source buffer from accepting
> > read-only BPF memory, such as const data.
> >
> > Adding __srcptr to mark pointers the kfunc only reads.
> 
> why can't we infer read-only from constness of a pointer? what's the
> advantage of __srcptr (which, honestly, says absolutely nothing,
> "__readonly" or "__ro" would probably make more sense if we have to go
> with suffix)

the reason was that current pointer arguments are marked as MEM_WRITE,
so passing readonly pointer to bpf_copy_to_user caused verifier error

but I think we can use const, did not think of that.. will change

thanks,
jirka


> 
> >
> > The get_kfunc_arg_type change sets the initial memory access mode
> > and the resolve_func_arg_type preserves the suffix’s access mode
> > when it converts a BTF pointer classification into a memory argument.
> >
> > Assisted-by: Codex:GPT-6
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  Documentation/bpf/kfuncs.rst | 24 ++++++++++++++++++++++++
> >  kernel/bpf/verifier.c        | 20 +++++++++++++++++---
> >  2 files changed, 41 insertions(+), 3 deletions(-)
> >
> 
> [...]
