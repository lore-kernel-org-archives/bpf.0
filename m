Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4633F58C
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483405; cv=pass; b=jnSmm3NbFqRVMnlMPhb39cW4tRyI049GmbYw3Z08wdv9PhzUFeo+fuQmBVimj7Enod7qT0d4BH0PaP5kMDnZkDq5Fw3bhhJgdA1SB/Gd/X2dSgqnZLG3kpIA9Gve+QgM0WBxhzT7lkTjFIvnd/CAZuJCl0TJ0Gy/Yrv7Kf4HZLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483405; c=relaxed/simple;
	bh=+DaFe3acEyvsnXLHTTBlPUbn+poR7NiO4GxbJ/fe2sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+UXU4AFGfzYNRipcp+rSDctvNGjZFeuoLsGjloQD7lbSv3tTQxS1wMu9aaNXxXJNAV4gBAb3w3lPCsXxZQ/+qQPC3BM/QbNX5G+yZO3X0K6E6y68MMIblS9vmBnvt+Pdre/uJIuAJvDaFwMVV7IwBrRUvNsoxj7nIf63bgOJgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0Myvpyf; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0Myvpyf"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-908239232adso2290106d6.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786483403; cv=none;
        d=google.com; s=arc-20260327;
        b=q0A0LQULY0yBYM8DSEWrsZdj33oEkuAsOExD24xwFCoxNgBrloz2Kg2EOpV1nBbYyc
         wtj+STU0vAfNlC3tLcexT4iVEWAzfFARkhsBAjJo71idQ5H4OjQB6cErk0rhqrToXV2W
         463E3znbUHzR+sGVq+pMP4SuMOBHmo2MDJQC57M9ID87zMbAAygqU1SUZEX1CtFIGBWG
         8iE9x/qXbWZKEDs9YYtldzFkf7P1JqGDAPBChN1cLsC+NwhR+eOuL2Ul7o+n9IjHxkCI
         kJtdZZEK31IC05f/pVIGZqW6rRw2Utfi9Jcyg1LdnlnFWoP3PmLk9R18FrYUx8/T66BP
         W5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G8HxaVmVnNL6LRiIFdcS+0cqqeZC0XRxj429YzrYQOg=;
        fh=Kc0N8wO8yn34GdMV46WA/wi32ZkWqLa4Nsmcf0P8Uag=;
        b=dcGCc5LgQzWQgYTVgWAluH/a+d4cx+D0DA5225acqCZRg1YhtV2xwEWY7qa1w7Wzgc
         ZQxFczzvVh3+8PWcsqAOkjgPgIXynM545SN2H9mJ99qhJo/NwNIq28FjkXTa7+hj4oEN
         uriKGDCsWBqWRC9viafPSG8f+rUdkYMY9/3qukl27oKbenwk8OntLwlWIEwDwOXgJw0r
         EO4nHGTLk0g5hs8OFRrLpUph6POB//h/ZBWVEDX9f9mDCkvJU5X3YGaIPNVXXTPDAGTr
         rJcEbGXKgsU1VqVFxTZ/DZQde9R2c6zl+IgfVU1UyiDco9JwYYNT18CTC7Yziz05pYJ4
         4zkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786483403; x=1787088203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G8HxaVmVnNL6LRiIFdcS+0cqqeZC0XRxj429YzrYQOg=;
        b=P0Myvpyf1rvGAD93/eWIm6836mrx6dn7EPfmEPsDAt0ttZaVEYjzswBPxA2qiMXHlW
         2j4SdkbA2Lz8JPztB0RDheCN/9zVgGBspKxlte4pMJo4RAQTWsoRVDW6VJz1glWFNtv4
         nlrzV2hDa75DJ6AJbF8sUsyawbZVjC6wsItiHqcUcClVeRCRUDc3E3go2YBkpu2pqN2L
         uKFHk3laZa5jD6/w5YXx+quDp0qZpTBh2zxARoK30Zo+VEDgzUIGOoFMXNQql093IWxc
         ksLg38efT21VNzLUGQl+x+biy9tgzMv1sux+X6WWkPMt/yQOzaRbQZPo+6tNrKEsZszF
         kv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786483403; x=1787088203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8HxaVmVnNL6LRiIFdcS+0cqqeZC0XRxj429YzrYQOg=;
        b=SZLn5a6SH1GwDMzJA9wJJtRZsatfIOvW9+q0hvfFUL/xJlY3VP5dvIacPDJM9oA5xp
         ZlHPPf5PHJBpD0YKilQpuxX9qcOacJb1AT+56SzYc9cMg5f3i88CB2ufpLaukFcLBa70
         KrCT/khVPdGzYAyTzbmcRltNyyqFUbaRuesJophrP3oCguDfBNNlxSmkQMysr/8Lc8km
         jRejEIR8OZBoJ1qWoScLqXBs0wxRzqwvze9bVr4yUqD6s1PwVXwR4xdnyP+lfK7fGK3z
         86BOjkbNNRnoMTiIV3qBa5HqAPHDegCCxNI5okwaO6C2nyfCzPGnyWQAt9XtfUo6Niwz
         F66A==
X-Forwarded-Encrypted: i=1; AHgh+RrntfbGxPxbxI9K0gh8E/peyEFvdrbiCc+E8PB419b0ofYk1CkMTiKUiugVou8Rj9WrzCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf+c8YwvMYTqPv17G+7OGX6ablIWs0G+el5eO0DQ9PkZA4bZvE
	24w08EnEV2R1PS5d1IjDtpIGZ3qQV5JFRDvAVGsh8OVGWCgnTbZQk5DS4jzvOgq/a4GTx0V2WJA
	R7EKd5E0/72AyVH4JSPSOBqVpG7zplvE=
X-Gm-Gg: AR+sD10THKfq4dMm1RbjRXpDpIDKky1YsomHTniO9g2VKevjKrlmv9ms/E3l4tgp75b
	HMAP1c91AJtFxg+aaUSdAlnSJUQKz5brAYQCek4s3cg2MEEuGv+yySPNi+rKlD8K/ENXBaxBzOd
	WIZgEKRIr9ewhJ09UYI+LK66NxRED4lXAk2RsSn+5iFCUGHz/5atADM0eqLwH7qsNhoIsCFQ44q
	fnyFk65H0tGjXCGjG4JkmQ7Z5dUAQdV/k+01nkNsPGiTwu73iyQCkloMgcbp7l5L/FgsvLRY7SV
	cDRLpbSXUyK15Zn7DuxqocZEmc2u3j0XgyWEOWy8msXXeXVieEOmhYUT0Qpeaj/7UxtIzu5AYTM
	=
X-Received: by 2002:ad4:5c42:0:b0:8fd:b96d:195b with SMTP id
 6a1803df08f44-90a6bcd6e75mr35525906d6.15.1786483402588; Tue, 11 Aug 2026
 14:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803021643.2189641-1-dwindsor@gmail.com> <a68933c3-39d6-414e-b869-bb3fd1a6b4ba@linux.dev>
 <CAEXv5_iKZnDvitaURzcAJDdHHB6H-YwP5MApMeCR64KqXQVRSQ@mail.gmail.com> <CAEf4BzbyevsZYb_xH_yRmKGv=MDdEmobc-vWwW2KwPjU2Qp-Xw@mail.gmail.com>
In-Reply-To: <CAEf4BzbyevsZYb_xH_yRmKGv=MDdEmobc-vWwW2KwPjU2Qp-Xw@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 11 Aug 2026 17:23:10 -0400
X-Gm-Features: AUfX_mxW4zfW_e5WmkeZ1AVnpWr_1zrtqbi2a6vDfG-5v2bUeclXbrP9o29dgEw
Message-ID: <CAEXv5_jvj+XsrP4uHCKEQ1GHQHzXmCRF_65Z_577N-iDKQED1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add BPF_F_SEALED flag to seal BPF links at creation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Liam Wisehart <liamwisehart@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 6:30=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> I had to skim the articles to recall that it was me proposing
> something like this :)
>

I wasn't actually there, but read about it on lwn. Happy to add your
Suggested-By if that makes sense here.

> Anyways, as Kumar mentioned, a) link has to be crated as sealed before
> FD is exposed, it's straightforward, and b) I do think that it would
> be too easy to have syzbots of the world to accidentally or not create
> tons of sealed links, so I'd require CAP_SYS_ADMIN for this, which I
> assume won't be a problem for intended use cases?
>

CAP_SYS_ADMIN makes sense.

> But also, yeah, I wonder what Christian and other BPF LSM users think
> about this.
>

I'll send v2 with the above changes.

The overall intent here is to follow up with another series for map
sealing.  Currently, we're passing BPF_F_SEALED as a flag for
BPF_LINK_CREATE, but I wonder if we should decompose BPF_F_SEALED into
eg BPF_F_LINK_SEALED and BPF_F_MAPS_SEALED?

Link sealing is useful on its own, though, for preserving bpf-lsm
programs around even after all user fd's have been closed.
