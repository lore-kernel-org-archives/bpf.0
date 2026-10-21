Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792619712;
	b=C2Wnh2Aq8t8qlMIflwhVAqQcExwNW7GAEp4rKM4+r1Vjaoaah9cQF4XIGAQPwShGzwjX
	 xJph2rmmKlmusmGJ+uitIHblfhmw+9KfgY6MuDCpl6HcO6MxNyKfgFGcd0itZby7Uvx5k
	 eHgn/qTgsYRooX5kuutg0fKKB1mVU2MCHv60KvxPOkVxfzBq8i5mzUrHAPKvzNUCzntDv
	 5hLKQcGcRkTQpX2HG8+JNwWifOr/hlFa1iaRxC0ClmOtM2i/W52lXKIFAJeEZAixe9JvT
	 AJbGcOkiNOyWRUXlMUR6ea1V0Dd5hyMkrrTaVUkFcGh+rdoEGkl6l04OMQiiqyFBVPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792619712;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nvVTH1Es7T77G63IC0TSBaGlf+EIxLYCrQxGzH7CDvs=;
	b=GTOdvPMsTyR9DgbLgRE5aVYmB/HqPocIQLMi5HR+5xY1VywNLkCe8NhFPGkmvWzrvEYc
	 Yep7ShfADWH4wXMFyf/s2kHRMbxBeHfp0weVhmL5oL3esqSXdeajwYh/nKcdxTBmhXzIO
	 r3GsxqrByJF2sR4kq+T47Q1O3knVLiQqDDQVTUJTBQccK0eROFRElcVjVSrWz4MjD9yU/
	 qmKwWYid8uQu1UKZlYwi1BVKgjMtPoWsNG1hQIYaP+JW/DPe+/bsc5fBIh2USwjLbI3tw
	 eNkgnceTedjTtkaMNM0W00nrcy9yi+SB0mjORU5GMd3Wmte9OdqJrxlG+zy3hQVrJLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ioZ6Jebn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FDB606A319;
	Wed, 21 Oct 2026 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ioZ6Jebn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA731F000C1;
	Wed, 21 Oct 2026 21:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792619711;
	bh=nvVTH1Es7T77G63IC0TSBaGlf+EIxLYCrQxGzH7CDvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ioZ6JebnKO6f8kDym91x683UBKX3jQbhC6QbpgpukkZx+TpqIKnS3nK+p0cjCcmWG
	 OIFm5DoAqsMDHbD2VqZ/zz9RzkERc5VklHOHORC7TCeGEdi1q6f/vxRpJtGjHWg49R
	 mbW54Q+V0cropVL9ei8p9vJsgFxX7ZI8ZKM619O9wHgvq2mxg3sxDnId2jqBAD6yfL
	 rGjZ3JJ2kw4MoLvcn6UF38jxKpYGq+MZOqqKg569HLKuLKA7lgJup4lFOquwxmXYPa
	 bQahoBXEyZ5jV+9HEh3qAbLMZ6cBUEJ97JN9myZxMKdnUUffYaSzbDsDI6aexwftkM
	 1qckj1jVOMNaA==
Date: Wed, 21 Oct 2026 14:55:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org
Subject: Re: [PATCH v4 net-next 06/15] selftests: xsk: move the AF_XDP test
 suite to selftests/net
Message-ID: <20261021145510.6ab6b982@kernel.org>
In-Reply-To: <20261016174338.787135-7-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
	<20261016174338.787135-7-maciej.fijalkowski@intel.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 19:43:29 +0200 Maciej Fijalkowski wrote:
> Move the xskxceiver engine, the AF_XDP userspace library, the test
> definitions and the XDP program to net/lib/xsk, and test_xsk.sh with
> its prerequisites script to selftests/net. A later patch drives the
> same engine against real NICs from drivers/net/hw, and net/lib is where
> both suites take shared helpers from.
> 
> net/lib builds xskxceiver with its XDP program and skeleton, using the
> bpftool in PATH, and skips it with a warning when bpftool is missing or
> does not run; test_xsk.sh then skips too. xskxceiver links -lpthread,
> which glibc older than 2.34 needs for the threads of test_xsk.c.
> 
> Like the rest of net/lib, xskxceiver builds against the installed uapi
> headers, so include linux/kernel.h for min_t() directly rather than via
> the tools copy of linux/netlink.h. tools/include goes ahead of CFLAGS,
> so that O= builds take linux/kernel.h and linux/types.h from it rather
> than from a source tree usr/include.

To be clear the expectation is that user runs

 make headers

first, so installed != system headers. There's no requirement 
that selftests build without running make headers first.

> Move the ethtool ring helper from network_helpers into xsk.c and
> point the kselftest.h include of test_xsk.h at the net/lib include
> path. The XDP program moves unchanged; its Ethernet header bound check
> compares pointers of distinct types, so net/lib builds it with
> -Wno-compare-distinct-pointer-types, as the bpf selftests do.
> xdp_hw_metadata and the xdp_metadata test keep using xsk.c and xsk.h
> from their new location. Update the AF_XDP entry in MAINTAINERS.
> 

> +# AF_XDP test engine used by net/test_xsk.sh.
> +XSK_DIR := xsk
> +XSK_BPF_OBJ := $(OUTPUT)/xsk_xdp_progs.bpf.o
> +XSK_SKEL := $(OUTPUT)/xsk_xdp_progs.skel.h
> +XSK_SOURCES := $(addprefix $(XSK_DIR)/,xskxceiver.c xsk.c test_xsk.c) \
> +	$(top_srcdir)/tools/lib/find_bit.c
> +XSK_HEADERS := $(wildcard $(XSK_DIR)/*.h)
> +
> +PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
> +XSK_LDLIBS := $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf) -lz
> +XSK_LDLIBS += -lpthread
> +
> +$(XSK_BPF_OBJ): $(XSK_DIR)/xsk_xdp_progs.bpf.c $(XSK_DIR)/xsk_xdp_common.h $(BPFOBJ)
> +	$(call msg,BPF_PROG,,$@)
> +	$(Q)$(CLANG) -O2 -g --target=bpf $(CCINCLUDE) $(CLANG_SYS_INCLUDES) \
> +		-Wno-compare-distinct-pointer-types -c $< -o $@
> +
> +$(OUTPUT)/xskxceiver: $(XSK_SOURCES) $(XSK_HEADERS) $(XSK_SKEL) $(BPFOBJ)
> +	$(call msg,CC,,$@)
> +	$(Q)$(CC) -I$(top_srcdir)/tools/include $(CFLAGS) -I$(OUTPUT) \
> +		-I$(SCRATCH_DIR)/include \
> +		$(XSK_SOURCES) $(BPFOBJ) $(LDLIBS) $(XSK_LDLIBS) -o $@

Why do we need all these extra rules to build the xsk stuff?
bpf.mk should build all %.bpf.c into objects
You seem to do similar thing for skel.
We shouldn't need 20 lines of Makefile for each test.
We are not using any bleeding edge toolchain features here

> +EXTRA_CLEAN += $(XSK_BPF_OBJ) $(XSK_SKEL)

This should also somehow be covered by wildcards not obj by obj.
