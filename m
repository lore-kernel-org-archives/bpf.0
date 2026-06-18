Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106637AA65
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785952; cv=none; b=HWkbA02sOSji/VIMgCAEtpsSepHz6mEu43OeOOm81UAdnKOm+BAY87FRSm9BEvbMKlTNiSQ7L4fj7JwAYF/D4ZcArcoyy0Po8SEDqUKhiPjIzr6jRKq+eRDBsEwcqUAN3JDPE3doJ4Vzw60h9OYt76Kraysdzid644/eEgdHTa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785952; c=relaxed/simple;
	bh=gZdkqF0OerCSAV0j1QpiwzO4IBQfxaAKNYwglO9AMco=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkQGJl+l/+SDKgN+XRhH0nKKIDmHF0xEjCkDFHPu0nCajlktP8ZJO3/y6nNXNv1I5Zc9ngEfrwxXeOKvBkbP/mnwYF3Lz+9sLz+36C/+MPEseVBFtdIvVszZU23yO4CpwzXZzC/dkZ3oR0ygrCvMvMdK3xUjz9/x7JynEBjYIZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azKr+AwJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azKr+AwJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4905529b933so7921605e9.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 05:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781785950; x=1782390750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPc0OU9sjfyGQ7c3buNYbzdqaEGIx1/7pa99xR6SsZs=;
        b=azKr+AwJlJPkxCEPNFm2sPWMpVx2+NpxkHMzk7Rz25vfvdQWJ/0asZ+wXQzdRwIQkz
         S205UWFJnsImjFfl1303bdck1anIfw9CxGF3BtG+d627sGdQDF2Mh2y9LsHQXe9bPVjb
         GyIWkbslZTWOsgESO+uvn2jamx9QoqQYnjQPrsxE5z0h+1rpcT1Dg3jB9Y90z1oamZyC
         UzfYVpvY23UVww1Xf7HrkYiwC3g4ArU8Z/F1393CfXrjoFsOBw4ZBVdXWsJm8mX00+Bm
         SrW9QAZUDqdjDS7seXpPc8G5xxuMg3HK/0uKV5dnaT1DXtRN7rIMWxCRqR/EP+3chabs
         gdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781785950; x=1782390750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPc0OU9sjfyGQ7c3buNYbzdqaEGIx1/7pa99xR6SsZs=;
        b=UXRUKnep4qrWxCpNurmTMiX6Dy/jOj/n3TSD+w1iX63auYLkAIHm4T5/7MMWZ5bgBp
         eY6vZZ9ABtvFFn7+pU3wBxXfnYDXyCcsYXrNnMfBOdEd9ajTLINI8vMyEM4ngz/76jRB
         3VNXbzIDtTCn4Hu245lZgXRVhKZOUZ+h/j85RPEPF4C/VaLthOpVMPRne5COspAfSuTj
         Y9uJGlvOzKdF4QOjnkAB5spUrDAc0qfxuXJogsSSp8e96U9IbLKuBTe31+IJb6N5YvZg
         R9CryuDajftAdRHEmEgQOqR7YrKzD576d9m5MRW5LihCni0G93m64xJT0/PPXy7B4B20
         ZA/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/P/N1yQX1MT6J5LSqUySa2k+bgMZmlbVdp4flWdowCAj9kFH/3TacdTIBWmgky/NFiOoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG1qmEkC1VsGxU8Vc3pLRLiSs2a7b27sRxrX9qmlFKzP7vX99P
	nwyj8NtC5RlYQ94gCDFfCSB10q1XvfI2QnOenIgOy1apO4j5ZFT5jKnvbuky4Q==
X-Gm-Gg: AfdE7cnOl3gSMm+kDTpZuIJQwKrdFKhZ+CKJaxvjl5jdduQlGiOUMbeQJ3XVLAIf0Xl
	qGuaOo19hjz51/J7pwZt4PUmM5NBRUBfve6mRNhSyz3GcF+W5VEUuJCWnrlDOW1J+3NtwneBPzR
	+J4LyO2Bx80aNcsnI2eRTr1WVO8S5pjhK2t0IJPutn1veWF6b9ntSUnRhjoHI9ADLChRyJLiAsB
	y3jmBPng9RzqBB/CcyIAyMME+V8hHRMkblBwTHtWxXLtbWPF0x0Ql4wQog4ZmnATPYHtnPxD7Nd
	Q4lj4bKDE13+MhrCuyoNM18UpCobkqUING91c3wzSSrlyirMWP2iAmhWH0Lo90wb9LlapaPXMNJ
	LgxdHw/3Aw8YG0PcTJq3NYT6OhZMsGr5gcGLkZUsTG1oYdp/g9lvd1OJWdFw/m+w1JGvshwEDea
	g+
X-Received: by 2002:a05:600c:1c16:b0:490:469c:556b with SMTP id 5b1f17b1804b1-492333bf79amr154902955e9.12.1781785949811;
        Thu, 18 Jun 2026 05:32:29 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa47da9sm292626405e9.5.2026.06.18.05.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:32:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 18 Jun 2026 14:32:28 +0200
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 0/4] Modernize resolve_btfids selftest
Message-ID: <ajPlXOE9gyoO3oi1@krava>
References: <20260617210619.1562858-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617210619.1562858-1-ihor.solodrai@linux.dev>

On Wed, Jun 17, 2026 at 02:06:15PM -0700, Ihor Solodrai wrote:
> This series updates resolve_btfids selftests to use latest selftest
> helpers API and add kfunc set testing.
> 
> This series was split from a bigger series [1].  It's general selftest
> improvements that don't have to be entangled with resolve_btfids
> development, and makes the main series a bit smaller.
> 
> [1] https://lore.kernel.org/bpf/20260601221805.821394-1-ihor.solodrai@linux.dev/
> 
> Changes compared to original 4 patches:
>   * various nits from Jiri, Andrii and Emil
>   * in patch #3 (that adds gcc pragma) definitions are moved such that
>     .local BTF_ID_* containers are grouped together and we have a
>     single pragma scope

left one comment, otherwise lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> ---
> 
> Ihor Solodrai (4):
>   tools/bpf: Sync btf_ids.h to tools
>   selftests/bpf: Modernize resolve_btfids test scaffolding
>   selftests/bpf: Fix resolve_btfids test reads of BTF ID sets in PIE
>     builds
>   selftests/bpf: Add kfunc set test to resolve_btfids
> 
>  tools/include/linux/btf_ids.h                 |  78 +++++++++-
>  .../selftests/bpf/prog_tests/resolve_btfids.c | 140 ++++++++++++------
>  tools/testing/selftests/bpf/progs/btf_data.c  |  10 ++
>  3 files changed, 177 insertions(+), 51 deletions(-)
> 
> -- 
> 2.54.0
> 
