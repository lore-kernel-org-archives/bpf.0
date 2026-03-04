Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF52338654B
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661515; cv=none; b=qQnq0Hgmyyo8f07Bk3qtW6rxHMuouKudw/r2wGV+566CCWDg/srHuee1tM6N3HapYxMNXhyE7GbbDyLPW2pGzKircXiYyggKPQxQrrbRtohRtVsg9LOXJqQiafR0v6gpL3PlkKsCB9oZPPw+Ogk5CyRgOmDLjBcQ4Hw6bw7JkmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661515; c=relaxed/simple;
	bh=Zk1Ht9wJzfv06ztY20x32LiGEhBHPyJrmt4+20gjP8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to6LoE1Lq8AaSkhL8q9vCUVYLQnGKlxnfngqomfaY+VrSfr9eXEcs9697zX4aq+5/681PHACSs5XqpSvytPLqDQ4i7Sq0xT0y8T5BdlZL5QYnp2PBXJ6bQtKgfh/g8VuyImDHj5SkOUejq7w8+siSXb/ftkmt2mtLZH2GTAgDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqtpVGQR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqtpVGQR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483bd7354efso97829615e9.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 13:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772661512; x=1773266312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xC03474//+Ghnqtvi4Xi4b/2FdOmZ5rvrQfRtrZtlgE=;
        b=IqtpVGQRqEBzsM8OrMmGzzdmxiUTB5nB28Zvm8ZvX4pc+S+d1mnuBaa2POBSC1z0RR
         inUQfAdOdyykPRLsLKyENFWcKDJ5S7p5vhByvfqGLYnUKv+gADY2TU5BI3OMyldWXpiW
         mRm6QsXLVSvu1DYw8NkphUjX3Lcrtb/3PDKuIPQJ1PVzQQ3NfvasTPZ0cGwsAayMEFjL
         jbO7Y1/zElzY/NmzkTWlAkiALDYZmbgbscqvGH4b6VazbDx6BYO3rJrKIqWF3glv99ln
         MVtuY6y0QHQBUC7MmTjPuoIYn5VOnKBAP7DD6uUJJB2lZN6ypTOYAhdUTa+w5u8LfTzO
         ogZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772661512; x=1773266312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xC03474//+Ghnqtvi4Xi4b/2FdOmZ5rvrQfRtrZtlgE=;
        b=oIGgpZ6zmUlTpB33EKql7IRmt0Q8Nf0FMf+Hq4LSNV75NkBePg+CKWePvFNz8NFacr
         +Vwnmc92lIbMR70nvIIGxGABmv8TPPeqqZiV5UffvhsedpnHdHocNOTpHDLh025z9sXE
         /e+jgD6Ye+VD9IKbWuUFAodpAnfqyq15FTYgpF9BvzHXGfYM/5qvQeBpGuyZUZ8vmcGT
         /0+05x73v6USlr4SZEjXz0ZSzHrzKQkoLMgy0TaH8NGfg2FcTiA46oV7od/vD1a+h/pN
         vDhGMdDCX3d3U4MQiMfxf8DPKVkNMqaDoZJk0I9VF2xKGUwKqW/if09vkLtnHkBQa8NY
         9wUA==
X-Forwarded-Encrypted: i=1; AJvYcCWLLONGEs/QhpzyNbBtp7nUlIJ7b1zBG8UXM2lPotRUTDm9c0EMk5JLIpwnwnc9mfc/CLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZoqW0F3C+qvUVXyDXI82AfywsThbVcDcY4bYbWCO9ojLqyuZ
	YQjzBjMtmZQZokPNku8/PIgW3NZ3XJgBaX4e4iMswQ+nRrw3f2HWJYbs
X-Gm-Gg: ATEYQzyO1sWkjcjaQblQFzYN4kfKRRmsnVqzFypLudBMCgrv6M0ICZrCFYGAYtyNaUh
	TZMaP2lzWfKB1SU9j+DM14DtqHfTNq9MuYVXlzzd/HkIhVBe8vRbZlTaY6W1/uT4o3yhJcf3AKQ
	nxZo9L1ySLv4sFIZ1rN78yrINrCB3KLUhQl2shTcawJquhypNkojsIRcK9IfdYz4CRoAMYbINoG
	oMNw1tOkIOkOImiQPbh7l1JekfHaV9/8TMqEdpFNYz01iCcuqPVX6od9XT7ZrDaZGsYp0WqybvM
	rPO5DkxCVoeJ12obthYFzP0HaJBX3Q9+Csdn1jrJ7kO75v7x1NDkFjkyuSlvKbncmPDdevQmj1u
	1Yb+zmbe3Ee5Kslt2kmiNDgNgm+0Z/NENO1URZwBpB7VfaVfO2iRQ7wSEtxc4tco4dWvXD0dOrz
	Aas9CRyJhYvOeOpfnEjdmV836gIYspe0CGg9KJAbiZnOX3AlRCdIaHFtiaePaSHTF4mYXHpcpV6
	dttAiceKeYPptTfA8qi/n75gDlv9A3LZYC1WkNhA4NNo3LAd4pkdsNFb7hHYxOuDYkgWY20lAjr
	+lOkZdVZBpYdVF2XwHUE
X-Received: by 2002:a05:600c:5308:b0:483:43da:6c87 with SMTP id 5b1f17b1804b1-485198b1738mr68058135e9.33.1772661511829;
        Wed, 04 Mar 2026 13:58:31 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e00a157f2ce043226e6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:a157:f2ce:432:26e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a8e2413sm24854315e9.10.2026.03.04.13.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:58:30 -0800 (PST)
Date: Wed, 4 Mar 2026 22:58:28 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Vitaly Chikunov <vt@altlinux.org>, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf v1] resolve_btfids: Drop -lzstd fallback if libzstd
 not found
Message-ID: <aairBDjxxzCbRZn1@mail.gmail.com>
References: <20260302231058.916946-1-ihor.solodrai@linux.dev>
 <aahqjs9v3PRmR6rV@mail.gmail.com>
 <073804ab-6180-4cd5-a0cc-7ab7680cdf5e@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <073804ab-6180-4cd5-a0cc-7ab7680cdf5e@linux.dev>

On Wed, Mar 04, 2026 at 11:24:54AM -0800, Ihor Solodrai wrote:
> On 3/4/26 9:23 AM, Paul Chaignon wrote:
> > On Mon, Mar 02, 2026 at 03:10:58PM -0800, Ihor Solodrai wrote:
> >> The "|| echo -lzstd" default makes zstd an unconditional link
> >> dependency of resolve_btfids. On systems where libzstd-dev is not
> >> installed and pkg-config fails, the linker fails:
> >>
> >>   ld: cannot find -lzstd: No such file or directory
> >>
> >> libzstd is a transitive dependency of libelf, so the -lzstd flag is
> >> strictly necessary only for static builds [1].
> >>
> >> Drop the -lzstd fallback to enable builds on systems without
> >> libzstd-dev installed.
> >>
> >> Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
> >> Reported-by: Vitaly Chikunov <vt@altlinux.org>
> >> Closes: https://lore.kernel.org/bpf/aaWqMcK-2AQw5dx8@altlinux.org/
> >> Fixes: 4021848a903e ("selftests/bpf: Pass through build flags to bpftool and resolve_btfids")
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  tools/bpf/resolve_btfids/Makefile | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> >> index ef083602b73a..5df897c881d3 100644
> >> --- a/tools/bpf/resolve_btfids/Makefile
> >> +++ b/tools/bpf/resolve_btfids/Makefile
> >> @@ -66,7 +66,7 @@ LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> >>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
> >>  
> >>  ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
> >> -ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
> >> +ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null)
> > 
> > This change is currently failing in CI with "undefined reference to
> > `ZSTD_xxx'" when trying to build resolve_btfids. I think this is
> 
> Hi Paul, thanks for taking a look.
> 
> I'm aware, I sent a v2 yesterday (with changed subject):
> https://lore.kernel.org/bpf/20260303193954.1879948-1-ihor.solodrai@linux.dev/

Ah, v1 was still marked as New in patchwork (probably due to changed
subject) so I missed it wasn't the latest :')

> 
> Your diagnosis is correct, the HOSTPKG_CONFIG wasn't set.
> I fixed that by adding a default in resolve_btfids/Makefile,
> but your diff makes sense too, I think we should apply both.
> 
> > happening because the selftests use static linking with
> > PKG_CONFIG='pkg-config --static' but then the same isn't done for
> > resolve_btfids, so "pkg-config libelf --libs" doesn't return -lzstd.
> > 
> > So maybe the solution is to define HOSTPKG_CONFIG when building
> > resolve_btfids, as in the following diff:
> > 
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 72a9ba41f95e..d5acbeba0383 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -409,6 +409,7 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids        \
> >                 CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
> >                 LIBBPF_INCLUDE=$(HOST_INCLUDE_DIR) \
> >                 EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' \
> > +               HOSTPKG_CONFIG=$(PKG_CONFIG) \
> >                 OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
> > 
> >  # Get Clang's default includes on this system, as opposed to those seen by
> > 
> >>  
> >>  HOSTCFLAGS_resolve_btfids += -g \
> >>            -I$(srctree)/tools/include \
> >> -- 
> >> 2.53.0
> >>
> >>
> 
