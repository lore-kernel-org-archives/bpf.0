Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB822D838E
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130177; cv=none; b=EZfyHUA0kKsHUd2pbJsh4ZyWgtZmEaL5uH46SyaItAQ0ecDXZTj9boJJbRwWtS9c/iaPxkfmo7a2SDQuKpTTpHT1Bz7p4F73Afze/b9Sa7uow321qEbErjh04HNNCzL0q961CTtp3f6a1dRmf+mEmYPZndvTvaP99nC8NS8es6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130177; c=relaxed/simple;
	bh=MC6vPKbNlgjaWmED6rvvCIpirl9l+mwWzP22ZBRnHDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGOpdt5DvTvotWt9+FW6da2gC5QBY5j1BUz2W8ZHl+4CxbTlkC7GTwC4ZS+26+dRKVyJ5WdDTyw06Nc5Y2v+seL7VLEUS2IIuyAVSOluXTeQVbWl/ZrElrqsH8Dz1856JCQKAclkp71ejUzVZsVQHvwJfS1rw5y9l6uOQ0zTjGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEhXw50X; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEhXw50X"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so12241525e9.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779130174; x=1779734974; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ycA5svcD7G5NV7SE5711YCA0d1sVSC7pnvewKsFkowE=;
        b=XEhXw50Xyc3Rki5kYlWBU7rmTT4TI2bDI6CqPShGSC332Hfvh7s3K+TNtuUHeTZnVm
         HxG+lsi6eMY1OEpYvlcc2a6x+ZpBoY/Nde+T0IjGZQWFyr3ESiOcok1NgpeRa1lWpbm/
         AII+57ZpE+POzYPCSMTeXA1mEKuXjVNYWBntLtsOU2Ho3GC5iZUfpnIiDo39PPJWFC4x
         FMRn71I7OqJ23+ACVwW6nQQQ8TZzr+tQh0Ps52rN+zUEMtvqfl9257YydpCAZ0N7c8kn
         tjb9B3UCKfRqblK7TQ944RafQplsFamBR3BZLspa3wNnYznJO1Rt0lCJGyqoEA5l0kcn
         wvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779130174; x=1779734974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycA5svcD7G5NV7SE5711YCA0d1sVSC7pnvewKsFkowE=;
        b=JVE+5s/XwxAWr94qYQoPPDkKt0CLs14nWPqEfU71ufWMyXDn6UpsM8qhGaRCZiAuJh
         U2HyDQinZ0NAmD6j9mtO5Vui5fmXqStDZTY6nqQHCN2H56ADq5ZEYUmt0a8hMl/mggCd
         ugSFvekWhidAqn9a6qhfIuSsoUcKHNKM8pRtNpCgkgs6nLDVD4FimEZJUh+9e8UkF3Ap
         xi6ap2/uUfxidkkOK/p1zyAxquTvTaZU+IH2dXmmMAy9jXuQe3N5kVt8mACsFKPkUJkH
         nbLZIivCCSYKNFKvR2+JgShaQcvTwiI6Jz/8eh4XEPKYO8+dH4XWchoCi91Zh80/lVYf
         kzAQ==
X-Gm-Message-State: AOJu0YwtsMfd20mU9b4pmJ3oeGwdMOjm8vzINJOONcSTnPnFXUFmjV3A
	ONovjyzDoSJo2WER3KcY4rNL/P4nMGudJUfMk0UQH4W+sMMAHKAqnnodqVMNFNij
X-Gm-Gg: Acq92OHEV16NjRLnzxNpaetchqGAacOlSL/qOljyjz9oIr/5c7Lgz5ny4PustZVMg4U
	MGDGOcSaQrJkD8WCajy9Se7XA3JWb+KCXSqTfUNZBrm9vMbAKlzsc9X+rKuKAXN8TmVzscczOaj
	7pwmlulCz3sExynShmryYqVPipoJSFBid7mk0xqTwDa8YiOcqZ2z83PGf48tiGEEAoap8iowUob
	3vYRUFUZkimmn54+5QDnwk3jsrD21Sg/+qHJJkL1NcQsJcdOZh5KPconJDkmsGBHUaQvmia9Z/1
	/F+eQFZDGs4MEGxSk4oLivNuvmmnk4yRme5BRYA8yezCoXZzwe73W0hP6KFdT4J6crxSjc65ONW
	4P/o9VGtfbTSkOwT7Spp4BlW0C6ZT2mRHo6srOU90OsKiIg9BIMfypStwJuSo/LUJPN67jE4hEI
	mOkAm0ZzlPEcc+o+VPXnYphuICQNe/12x9T+O/JzhpEQ2odSWk/Z4K17ZFvlhRARrgoEz+5hNu6
	m52FagCflTa3umYQWln8mr54MrS2TvslIu41Z2CniJhA9smm5vzaqrB5J/W5tkjvvvk9nGI5b6t
	1oQRa7s6QQxrF+I8moTFGYn45SyZzAQXRmASaeZBGdWMQPzbSky2
X-Received: by 2002:a05:600c:4fd4:b0:48a:581c:ead with SMTP id 5b1f17b1804b1-48fe60ed7b7mr225620585e9.10.1779130173722;
        Mon, 18 May 2026 11:49:33 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0002302090c50a60b9.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:230:2090:c50a:60b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c744sm88940555e9.3.2026.05.18.11.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:49:33 -0700 (PDT)
Date: Mon, 18 May 2026 20:49:31 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Override EXTRA_LDFLAGS for
 static builds
Message-ID: <agtfO9lHdKdP92Mo@mail.gmail.com>
References: <714556da329c812988010ffe53173d9152570a78.1778669303.git.paul.chaignon@gmail.com>
 <20260514042304.EF3ECC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514042304.EF3ECC2BCB7@smtp.kernel.org>

On Thu, May 14, 2026 at 04:23:04AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The suggested workaround `EXTRA_LDFLAGS=-static` in README.rst breaks the bpftool build or silently disables LLVM support.
> --
> 
> commit dcbd0d5d7a0eb4a9300ad0890d83b7e4cdfd3aeb
> Author: Paul Chaignon <paul.chaignon@gmail.com>
> 
> selftests/bpf: Override EXTRA_LDFLAGS for static builds
> 
> This commit updates the README.rst for BPF selftests to include
> EXTRA_LDFLAGS=-static when recommending how to statically link,
> in order to fix shared library loading errors with libLLVM.so
> when running vmtest.sh.
> 
> > diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
> > index 776fbe3cb8f9b..37164322a1023 100644
> > --- a/tools/testing/selftests/bpf/README.rst
> > +++ b/tools/testing/selftests/bpf/README.rst
> > @@ -77,7 +77,7 @@ In case of linker errors when running selftests, try using static linking:
> >  
> >  .. code-block:: console
> >  
> > -  $ LDLIBS=-static PKG_CONFIG='pkg-config --static' vmtest.sh
> > +  $ LDLIBS=-static EXTRA_LDFLAGS=-static PKG_CONFIG='pkg-config --static' vmtest.sh
> 
> Can adding EXTRA_LDFLAGS=-static break the bpftool build or silently disable
> LLVM support?
> 
> In the bpftool Makefile, LLVM's --system-libs and -lstdc++ are only appended
> to LIBS if llvm-config --shared-mode outputs 'static'. However, the
> feature-llvm test in tools/build/feature/Makefile unconditionally includes
> --system-libs and uses g++, which automatically includes -lstdc++.
> 
> If a system has static LLVM libraries but llvm-config --shared-mode is set
> to 'shared' (common on many distros), the feature-llvm test statically links
> successfully, but bpftool's Makefile will attempt to build with LLVM support
> using gcc -static while omitting --system-libs and -lstdc++. This can cause
> the build to fail with undefined references.

I'm not sure I'm following this, but I have static LLVM libraries with
llvm-config --shared-mode set to "shared" and everything seems to build
fine.

> 
> Additionally, if static LLVM libraries are entirely absent, the feature test
> fails, causing bpftool to silently build without LLVM support.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/714556da329c812988010ffe53173d9152570a78.1778669303.git.paul.chaignon@gmail.com?part=1
