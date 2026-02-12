Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC181D5174
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 02:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770863987; cv=pass; b=jYkp3jKVRtPsnCioKTBcbtyAUv49cuW+oqM0hDM/UFW1KdrRmalSVjlPlTVwCIoL9fEfN1Dkx+rmk360fTSg+xSLK6q+STrt/u0BGUkWWinh9yQOxvkXd6ejgTkIuLWpYXrQkJOrCC5jDPm9MV8MyK2UbSf/JMLOW3tFiMbV1FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770863987; c=relaxed/simple;
	bh=L9nQ6KFyrMJsBYf0Xt81j2WmiRRz84jQLrksqh524lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRNBEGZWUTRI7NUuywuw0/tEy4HMVFiWYus3b0R4KezZlmPJEjwql2M3tJgjfTYATNI6OHY5CljkJiwNQehunoZ8Wq0Kec3HDHpkoGjc/YlfzMVqQqpPMOsvjitarUQZ+KwvZrWgGflGKJo2PyCAdfbbC4SRkh1tPEKPDoc9Gr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYMbVh6Z; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYMbVh6Z"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4359a16a400so2499425f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 18:39:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770863984; cv=none;
        d=google.com; s=arc-20240605;
        b=ECw3YLvyqfRZPRdBRRYpQN1NR24I760GlOdjQT5I+beR13oku0t8IBM5lTAfubOd0V
         ZVqpC85RtvfGSeAarKIYynu8wlgzTXv2+b1f9doPF6PmxYWWgSVnJNWPrH+LxcVYgt+d
         euf/J0gtFvMpEBRvrIWBeUUEMY+SDL3XGsLJjSmzAxdDmqEGLANYIN+9+x9+WQBqTSEk
         wINBqVdqgnnVbOyeR86mWhqIEjTHOq7nN0lBtLBvmaa7Q91zCqGO7lCoLxndxfj8MbdZ
         /SGkYUL7mc26+xqjqPW/ST88layKTwYTq+LNhjgLwsmh7tgZ5rE26F6u2dua9u+8D3Rz
         9DgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1WoGtuGJmKiFMGhgAtUY5QSYtESGvxLQL1C7tkVYgcY=;
        fh=NRDbKYkd+znES8Te3kmUq9gQhZqkNTD89sjfuCiKM7A=;
        b=GH/+VwgLWQ7vTIfu+XHbeT+sBI6WontLqvAKr9aG2ZVD0lF6xKOE7T2aGPcFGUfAgf
         sJo/0EPDyhyr2rOU01moXtK+NMfactcPxn8fuRtD2sj/HfQI5cwbFOltWa1Hn2q5l9Jf
         87uiNQyPpPF49W2k4eFF7iwcds4Pm93Q/z68k5MOnQm4x4EnfUjO6AP5vX6J+hrNI1Mu
         krqdJOIL6bcUc7A8edOcDZpnBsWGe3/jS6YQUO6DroMWQaBiMohFsvH4KzLysq6Cayhf
         cb8OgZpYLcKKjO96HbfTbN3YklwMFbAURA2vm09U0Z6z29seifRhRnGgJypn8MRmqEyx
         k52g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770863984; x=1771468784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WoGtuGJmKiFMGhgAtUY5QSYtESGvxLQL1C7tkVYgcY=;
        b=MYMbVh6ZvT17aEdH/8FNszbf1/tRrNJHR0U3bxlusrKPxGO9YBBsQR8s9L1GsXktSA
         63HWj34yrAzhLOs8sFN16EGR7vr8q0o/235y//WWywxnuGbwuBmnWqF2R162BAqi4rjc
         uOrFUwHYHmmS0auSuIg/1hmoaECIOPhqZNtenfdRmZg8D07EV/9gT+bUHZGeILMfQV1P
         RxmgNSAhA/aIhXewJw1nToaF7oStdlv2QGyy7vH9jCwPXWQaAlT40t/Ht42mH41RVCge
         th9m5czwXDgqz6pw/ewmhD7HkYAQhzottK7fYv5bU8rXWl6Lsq9WencnWRsapqiy3WU5
         b58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770863984; x=1771468784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1WoGtuGJmKiFMGhgAtUY5QSYtESGvxLQL1C7tkVYgcY=;
        b=lSZTWZZPuFC7PgPff8fxb2oqLyPvgs4M8qv3kGjQzFg+SlJohaftDEMJLeac0VMGXg
         NYBdA2NHof/3xguPMeoCCyV2ikn2zsCpkswmZB9j5tla721jBoWwCIFsXixoe7bybKqc
         zXEtqJQwnncu9Rhu1L+/0b0lC4McsuCHsUND4a6Azc53QsoKp9T5jcfdNLLH35hVR5w0
         ORS9qoFX8c8AaZAfrbwvNWGydT1+0vPhP5aWir0IdTPszhqhQUM+x+1+i7akKboC3NQ4
         IwZYZK6PvXuqP48fctODGawNJycKJGfWYSzvPEKJ2jwoAv0jL52aAws66GDWr7X9U02W
         j0TA==
X-Forwarded-Encrypted: i=1; AJvYcCXX0iXzd5meqqHXoHmvvndpbmasNbvjlUmG9Ibrio3oB5KcVnYBHEPPkUxLCb1mQCbmQpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+MhQZC5THstrf0gjYxsJFwZFJbw8kWQEw4AfsKpXM0tUuNVD
	fxYovwPC5I34ofPVWq8H/+aXkkHCTEHWy2k3wGfi5+qi8dgAkHw8dZpyI9nb3YIvDgvVc0j7Prf
	TJxqU1xCNlHrMyW4i5yuRBQIZuDQHBeY=
X-Gm-Gg: AZuq6aLcBIkyZJOsh4FH1aUZeYYOACKOOQf894iTW+OsUF3xewyj/x2Py8h8TfsY6Ks
	sFLdTD9VdnvdN2irriQZy3JiyOmZKqqGV1POcTq1EAvmSI3WTXZnJAX48Rkt2gM+OoszQUHiacK
	ECoZWWikkIglmuyvBVseT+9CjRwXosOExIicsFx72o6BDGlL2RYtlKapLrN8X1b5kUCxFU/sNAk
	IeSB1djZKLlXrziWpf+6zAD7Bw0BjAHjrkDVoyICR+kpAxNzZTkPaKtXyWkfk9eJ/ohrr/+pqsQ
	XF/c70GdZEkgqN7g6QgRJsfNZPEA3FqRr96HGRDpzn3nM0TvpTjbmsitWilKiohKFk/SZk0jCge
	T+MNiUM1iHsomzbwRS93vxjl/FQ==
X-Received: by 2002:a5d:45c8:0:b0:435:bbd7:18d8 with SMTP id
 ffacd0b85a97d-4378f113982mr638092f8f.17.1770863984211; Wed, 11 Feb 2026
 18:39:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev> <20260212011356.3266753-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260212011356.3266753-2-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 18:39:33 -0800
X-Gm-Features: AZwV_QitZfzYbLn8McmT9o4-McA4V0mbafiVkKh6OCuEjHo5I53TO1AvRoH5Jkw
Message-ID: <CAADnVQJLWTCoUFTP9Ox3ErhcJuQBEAcnpa_Tv-3n8jL9vj2dKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 01/14] selftests/bpf: Pass through build flags
 to bpftool and resolve_btfids
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	=?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 5:14=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> EXTRA_* and SAN_* build flags were not correctly propagated to bpftool
> and resolve_btids when building selftests/bpf. This led to various
> build errors on attempt to build with SAN_CFLAGS=3D"-fsanitize=3Daddress"=
,
> for example.
>
> Fix the makefiles to address this:
>   - Pass SAN_CFLAGS/SAN_LDFLAGS to bpftool and resolve_btfids build
>   - Propagate EXTRA_LDFLAGS to resolve_btfids link command
>   - Use pkg-config to detect zlib and zstd for resolve_btfids, similar
>     libelf handling
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/bpf/resolve_btfids/Makefile    | 7 +++++--
>  tools/testing/selftests/bpf/Makefile | 9 +++++----
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids=
/Makefile
> index 1733a6e93a07..ef083602b73a 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -65,6 +65,9 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC=
)/Makefile) | $(LIBBPF_OU
>  LIBELF_FLAGS :=3D $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>  LIBELF_LIBS  :=3D $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null ||=
 echo -lelf)
>
> +ZLIB_LIBS  :=3D $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || ech=
o -lz)
> +ZSTD_LIBS  :=3D $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || =
echo -lzstd)

The first two patches look serious enough and justify going to bpf tree.
The rest can probably go via bpf as well, since we're early
in the merge window.
Would be great to have some Acks first though.

Why add zstd here? It's not used by resolve_btfid. Why add it?
