Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8D72E7162;
	Fri, 25 Sep 2026 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790378150; cv=none; b=m1HcEtSn8qOfXfPE59d7cgr475mp/CNKWmwAPvCIDPUK2u7GAUYuPl43/A3H+EZ2OFfL29S7qPYdJ7nzVWOuxFyZaBk1QBPtevEFufze6WUil/vWB7uSeW/2LDAL7IDeTzZWdHinmp0QNuUXVPLMIycqfcaj1tF6EE67ItULOaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790378150; c=relaxed/simple;
	bh=KquwAGHO+zSLWLr3HTM1BmIeVLvPkiwh9EIZhNiQ3i4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APGOrsGx6oviSZXPfOh48V/+7JWGQ/yqsqTaXtkLI0ozKURVP5iWch4GLpQMhKAvUzsXzDsr21q2HCK4B8Fc/hqBo7JmOIrwC2Yps8upSOfwBcQ4HhjQwlRQNEfC3sMITC1cQMb4R47R+PxYCxctRlunZgv0YMJZJVThuMma7WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlFqGGq7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlFqGGq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A3E1F000FF;
	Fri, 25 Sep 2026 23:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790378149;
	bh=6DAv7sPPu4pqCf1l4gAuUa9B/VGDpmBTcCUgCNkqiLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GlFqGGq7Bc2Tty8PAnVeo31MsFc49GyOYxXw7P8a2fiUO69ywX/XCUE1BpZTgpQUa
	 ZIhrOk7KJtKhWW2ICJguWvL/EP3bzld1RQGeJPub6Ew3mHcaglipr6mKJfDcXMvLlx
	 WVbUeMF+wIXOvp0N+WGBdkahc+csgjBWV7t1SWttBpr29bVQGxsiwsvvhLnt4fK+OO
	 pbdLLGzaeMY49lHwHJPvg9n3AFjLMA3B3ndRQpzZpvsCcgB2vpyJXn9vzZ6NDkz0sw
	 8FEsNGzlzZAUofZS5LUCCBEn54Y6GjKt0Cgawfj9mir8UC0kRB8RsRequ7jc9h3u4i
	 lE1OrrUlIhATg==
Date: Fri, 25 Sep 2026 16:15:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bochao Cao via B4 Relay <devnull+bochaolucky.gmail.com@kernel.org>
Cc: bochaolucky@gmail.com, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan
 <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Tiezhu Yang <tiozhang@didiglobal.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] selftests/net: Move XDP feature test to
 driver framework
Message-ID: <20260925161547.1b57b653@kernel.org>
In-Reply-To: <20260921-xdp-features-v4-send-v4-2-a0d4ec392cb7@gmail.com>
References: <20260921-xdp-features-v4-send-v4-0-a0d4ec392cb7@gmail.com>
	<20260921-xdp-features-v4-send-v4-2-a0d4ec392cb7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 14:00:05 +0800 Bochao Cao via B4 Relay wrote:
> +BPFTOOL ?= bpftool
> +
> +CFLAGS += -I$(OUTPUT) -I$(SCRATCH_DIR)/include
> +CFLAGS += -I$(top_srcdir)/tools/include
> +CFLAGS += -I$(top_srcdir)/tools/arch/$(SRCARCH)/include
> +CFLAGS += -I$(top_srcdir)/tools/include/uapi
> +CFLAGS += -I../../../net/lib

Can we stick the generic BPF stuff into ../../../net/bpf.mk
instead of directly in here? I think the includes should already be
fine? (please note that net/ selftests assume `make headers_install`
was run before building the tests! IIRC bpf selftests were trying
to avoid that but we have weaker rules, so some of the includes
may not really be necessary)

> +$(OUTPUT)/xdp_features.skel.h: $(OUTPUT)/xdp_features.bpf.o
> +	$(call msg,GEN-SKEL,,$@)
> +	$(Q)$(BPFTOOL) gen skeleton $< name xdp_features > $@

It should be possible to create a generic rule to build all %.skel.h ?

> +$(OUTPUT)/xdp_features: xdp_features.c xdp_features.h \
> +			   $(OUTPUT)/xdp_features.skel.h $(BPFOBJ)
> +	$(call msg,BINARY,,$@)
> +	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) \
> +		$(LDLIBS) -lelf -lz -lpthread -o $@
> +
> +EXTRA_CLEAN += $(OUTPUT)/xdp_features.skel.h
