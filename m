Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5CD10A26;
	Sat, 17 Oct 2026 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206368; cv=none; b=Y8Xc+a9NjvbNe/hmpujp+BnS6KG04kQkOtv7/++CG/4vHKIEi8NSyJQ7VlfvygapTxCzp/VKNBs0WQd428FK2zi0rk2LVGLpPbgKxsDhd1W2C/6sX7b3//MKwkW/W2nkuHtXKZW3IDZKyNKMZSlS9v5ncbKct4h7OeF+Ul8Gm30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206368; c=relaxed/simple;
	bh=hNEBPtH9DsYtS1QLvKGBmlXocPMl8ez5R6AIIKVGAKU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UUMGFQLgqTSraNInOqJns+9rLOu/Gv0Y6CIKYzT4/sbEf/qnflpnIqI1y1B8ZuCptwbTP94SmPT3JeMbbKzrZrYCalRkR88Cfr3AsQmhSDxU1gTDJsGYfR+fF1PnaYD5eO+ykSVRtZ5ow160JR3dnDn/lZrA3fYekT8GO9L5RS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eenhnnWx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eenhnnWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E8E1F000C4;
	Sat, 17 Oct 2026 03:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206367;
	bh=BTtCptD0pvGP1BY0ygYsRtsJTGomV4GR/bbVNX4XPj4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eenhnnWx+N7+/shknbv8DmZpYb60ZZD5T3T6vabhov+kg/VSXArEoZibDS30z//Yf
	 8CqjvTC5lCWcRuP2ILVPdHpO5uaaf/kiLKchEloAXpecHXOL6TXzWFDKxc/U29CDfv
	 OPwdgD4Cgy5BEQLsHPt7pU7CKjNagoo9+IC6sIiqMVFnDAmLpRU/63V5F0M2NpUe/7
	 PeZtW3A+d8yRaESud7ChdLNxRHT81rrjY9a0MiDUIAAaCEYlRkTL8aH8g6R2wANv78
	 USYCeCXR+iyY+Q+Per6Cfb7nlnLYgFwAakLNRKPagyx600mH+A7bU1fWICzg1BrRmz
	 TFJa5hdwRwDgA==
Subject: Re: [PATCH v3 net-next 06/15] selftests: xsk: move the AF_XDP test
 suite to selftests/net
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Sat, 17 Oct 2026 03:06:06 +0000
Message-ID: <179220636618.434549.11404278084536397224@kernel.org>
In-Reply-To: <20261014184539.774708-7-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-7-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Undisclosed relicensing.
- [Low] In tools/testing/selftests/net/lib/Makefile, the xskxceiver
  binary is only removed by `make clean` when bpftool happens to work at…

--

selftests: xsk: move the AF_XDP test suite to selftests/net

This commit moves the xskxceiver engine, the xsk userspace library, the
test definitions and the XDP program from selftests/bpf to
selftests/net/lib/xsk. It also moves test_xsk.sh and xsk_prereqs.sh to
selftests/net, and net/lib now builds xskxceiver only when a working
bpftool is found. The two ethtool ring helpers move from
bpf/network_helpers.c into xsk.c.

> diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
> index ff83603397d06..c26088da04892 100644
> --- a/tools/testing/selftests/net/lib/Makefile
> +++ b/tools/testing/selftests/net/lib/Makefile
> @@ -5,6 +5,15 @@ CFLAGS += -I../../../../../usr/include/ $(KHDR_INCLUDES)
>  # Additional include paths needed by kselftest.h
>  CFLAGS += -I../../
>  
> +# xskxceiver needs a working bpftool to generate its skeleton
> +BPFTOOL ?= bpftool
> +HAS_BPFTOOL := $(shell $(BPFTOOL) version >/dev/null 2>&1 && echo y)
> +ifeq ($(HAS_BPFTOOL),y)
> +COND_GEN_FILES += xskxceiver
> +else
> +$(warning excluding xskxceiver, bpftool not installed or not working)
> +endif
> +

[ ... ]

> @@ -13,6 +22,7 @@ TEST_FILES := \
>  
>  TEST_GEN_FILES := \
>  	$(patsubst %.c,%.o,$(wildcard *.bpf.c)) \
> +	$(COND_GEN_FILES) \
>  	csum \
>  	gro \
>  	xdp_helper \
> @@ -23,3 +33,28 @@ TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)

[ ... ]

> +$(OUTPUT)/xskxceiver: $(XSK_SOURCES) $(XSK_HEADERS) $(XSK_SKEL) $(BPFOBJ)
> +	$(call msg,CC,,$@)
> +	$(Q)$(CC) -I$(top_srcdir)/tools/include $(CFLAGS) -I$(OUTPUT) \
> +		-I$(SCRATCH_DIR)/include \
> +		$(XSK_SOURCES) $(BPFOBJ) $(LDLIBS) $(XSK_LDLIBS) -o $@
> +
> +EXTRA_CLEAN += $(XSK_BPF_OBJ) $(XSK_SKEL)

[Severity: Low]
Will make clean leave lib/xskxceiver behind if bpftool can't be used
when clean runs?

HAS_BPFTOOL is evaluated when the Makefile is parsed. xskxceiver only
ends up in TEST_GEN_FILES if "$(BPFTOOL) version" succeeds during that
same make invocation.

The clean target in lib.mk removes:

	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)

Here EXTRA_CLEAN only lists the .bpf.o and the skeleton.

Say the binary was built with a working bpftool, and make clean later
runs where bpftool doesn't work. That can happen with a different PATH,
a BPFTOOL= override, or a cross environment. The intermediates get
removed, but $(OUTPUT)/xskxceiver stays.

test_xsk.sh only checks:

	if [ ! -x "./${XSKOBJ}" ]; then

So it would run the stale binary instead of skipping.

Would it work to add $(OUTPUT)/xskxceiver to EXTRA_CLEAN
unconditionally? The same Makefile logic is still there at the end of
the series.

> diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/net/lib/xsk/xsk.c
> similarity index 95%
> rename from tools/testing/selftests/bpf/xsk.c
> rename to tools/testing/selftests/net/lib/xsk/xsk.c
> index 25d568abf0f20..6bd32caf5d085 100644
> --- a/tools/testing/selftests/bpf/xsk.c
> +++ b/tools/testing/selftests/net/lib/xsk/xsk.c

[ ... ]

> @@ -779,3 +778,51 @@ void xsk_socket__delete(struct xsk_socket *xsk)
>  		close(xsk->fd);
>  	free(xsk);
>  }
> +
> +int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
> +{

[Severity: Medium]
Does this move change the licence of these helpers?

get_hw_ring_size() and set_hw_ring_size() come from
tools/testing/selftests/bpf/network_helpers.c, which has:

	// SPDX-License-Identifier: GPL-2.0-only

xsk.c starts with:

	// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)

Tushar Vyavahare added both helpers in commits 90a695c3d31e1c and
bee3a7b0762422 under GPL-2.0-only. After the move they are unchanged,
but they now sit in a file that offers its contents under LGPL-2.1 or
BSD-2-Clause, with no per-function licence note.

The commit message only says "Move the two ethtool ring helpers from
network_helpers into xsk.c". It doesn't mention the licence change, and
there is no Ack from the original author. This is still true at the end
of the series.

Could the helpers go into one of the GPL-2.0 files in the same
directory instead, such as test_xsk.c or xskxceiver.c? If they need to
stay in xsk.c, could the relicensing be stated explicitly, with an Ack
from the copyright holder?

> +	struct ifreq ifr = {0};
> +	int sockfd, err;

[ ... ]

> +int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
> +{

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
