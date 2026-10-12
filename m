Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0941316199;
	Mon, 12 Oct 2026 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795025; cv=none; b=hP/wXYYdDOK8P28jwH7tmHqXcGSO3Xq9zPdWMcnWYVXqIEYw4aLUUUfUbV4QN8eFPOmDW9QcDrwcVKWlETfsve0DvwW5kgvPW0OC51UqbacW6K7Q+xxt4ClLJlIcIkpTo/i00QBuTr7CUGO6QAzl491HaFZt8YlpYGYgN8qzFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795025; c=relaxed/simple;
	bh=t+/fVTxhscWGpTxYw+Nm6A1b+sjWSDNHFptuQaf543Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JWBs0TxxL0Lsih4rfZVpkF0GbuzokIIJEtU4IljLPIi+vLW5jDanpaNzluRKANTd2UNJjqZ8X2uedc8XszkWrbreK6swD4G6opVnJlzAw0q3XQIsLITIKNNkLjGD8hTl0dtOr/8QJh+QGK7MrXCocSwem+OnHKdNdNJOJKViWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqlmPuH1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqlmPuH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAE21F0089B;
	Mon, 12 Oct 2026 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795023;
	bh=+2Ff2iVLHAxKLnNnMT7YLQ4bO4ahNSKwJpILx3p59z8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZqlmPuH16UHcdwsd+PL42NM0642kVMdQ3mh60D0pUNRZveGYemJjwR2+FvpyUEn3t
	 +NGcq7r9ALUlVpK/BoAYzBBnJKMFzFvIBg8zRiVthSmxJrhfPuUXt6N9bNSDV91uOL
	 u9vzMqhTdLPYa7iwgZAHaLc0UUaD3Xqn+9OgcCLNjHxrxW7TKO4Xtw+fiQOvaJexcJ
	 Q4ROAb8zlrXNg6y77ZWLvckz/Wzyug9lEw6laHWG79VDmbZ9GFRAJ8D4azoj+S5RqI
	 Su992Guwul89o72i4GUnNGC9byCwDaoVcrVJRlxelAHFfXY4iWR0GRLD8FdfRam02S
	 UHhd8Jr3dXqEA==
Subject: Re: [PATCH v2 net-next 05/14] selftests: xsk: move the AF_XDP test
 suite to selftests/net
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Mon, 12 Oct 2026 08:50:22 +0000
Message-ID: <179179502238.434549.31345561848721080@kernel.org>
In-Reply-To: <20261008114909.734364-6-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-6-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In this commit, net/lib/Makefile deliberately leaves
  xskxceiver out of TEST_GEN_FILES when `bpftool version` fails, and…
- [Low] In this commit, net/lib/Makefile links xskxceiver with `$(CC)
  $(CFLAGS) ... $(XSK_SOURCES) $(BPFOBJ) $(LDLIBS) $(XSK_LDLIBS) -o $@`.
- [Low] xskxceiver needs the tools headers: tools/include/linux/kernel.h
  for min_t() (the only min_t definition under tools/include, line 46),…

--

selftests: xsk: move the AF_XDP test suite to selftests/net

This patch moves the xskxceiver engine, the AF_XDP userspace library, the
test definitions and the XDP program from selftests/bpf to
selftests/net/lib/xsk. It also moves test_xsk.sh and xsk_prereqs.sh to
selftests/net. net/lib builds xskxceiver only when a working bpftool is
found, and the ethtool ring helpers move from network_helpers into xsk.c.

> diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
> index ff83603397d06..a542757e29576 100644
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

[Severity: Medium]
When bpftool is missing, the build leaves out xskxceiver. But
selftests/net/Makefile still adds test_xsk.sh to TEST_PROGS
unconditionally. What happens when test_xsk.sh runs and lib/xskxceiver
does not exist?

Neither test_xsk.sh nor xsk_prereqs.sh checks that the binary exists.
exec_xskxceiver() in xsk_prereqs.sh just runs it:

	./${XSKOBJ} -i ${VETH0} -i ${VETH1} ${ARGS}
	retval=$?

Here bash returns 127. test_status() does not print anything for that
value, but the value is still added to statusList for both runs. The
summary loop in test_xsk.sh then does:

	if [ ${statusList[$i]} -ne 0 ]; then
	        test_status ${statusList[$i]} ${nameList[$i]}
		failures=1
	fi
	...
	exit 1

Would kselftest then report a failure instead of $ksft_skip for a binary
that the build skipped on purpose?

A later patch in the series, "selftests: xsk: run one test case per
xskxceiver invocation", adds this check to test_xsk.sh:

	if [ ! -x "./${XSKOBJ}" ]; then
		echo "xskxceiver was not built; skipping"
		exit $ksft_skip
	fi

Could that check move into this patch, so the commits in between do not
report a false failure?

[ ... ]

> @@ -23,3 +33,27 @@ TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
>  include ../../lib.mk
>
>  include ../bpf.mk
> +
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

[Severity: Low]
Is -lpthread missing from the xskxceiver link?

XSK_LDLIBS adds only libelf and -lz. lib.mk never sets LDLIBS, so
nothing here pulls in libpthread.

test_xsk.c is linked into xskxceiver, and __testapp_validate_traffic()
calls pthread_barrier_init(), pthread_create() and pthread_join().

The old rule in selftests/bpf/Makefile got these symbols from:

	LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread

On glibc older than 2.34 the pthread symbols live in a separate
libpthread. Would this link fail there with undefined references?

The later patch "selftests: xsk: run the RX and TX endpoints in separate
processes" removes the pthreads and the barrier. So this only affects the
commits in between, which matters for bisection. Could -lpthread be
added here until that patch lands?

> +
> +$(XSK_BPF_OBJ): $(XSK_DIR)/xsk_xdp_progs.bpf.c $(XSK_DIR)/xsk_xdp_common.h $(BPFOBJ)

[ ... ]

> +$(OUTPUT)/xskxceiver: $(XSK_SOURCES) $(XSK_HEADERS) $(XSK_SKEL) $(BPFOBJ)
> +	$(call msg,CC,,$@)
> +	$(Q)$(CC) $(CFLAGS) -I$(top_srcdir)/tools/include -I$(OUTPUT) \
> +		-I$(SCRATCH_DIR)/include \
> +		$(XSK_SOURCES) $(BPFOBJ) $(LDLIBS) $(XSK_LDLIBS) -o $@

[Severity: Low]
Can <linux/kernel.h> in xskxceiver.c resolve to the uapi header instead
of tools/include/linux/kernel.h?

-I$(top_srcdir)/tools/include comes after $(CFLAGS), and CFLAGS starts
with:

	CFLAGS += -I../../../../../usr/include/ $(KHDR_INCLUDES)

In the default in-tree build, KHDR_INCLUDES is an -isystem for the same
<srctree>/usr/include directory. The compiler drops the duplicate -I, so
tools/include wins.

For an O= or KBUILD_OUTPUT build, tools/testing/selftests/Makefile sets:

	KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include

In that case the two directories differ. If <srctree>/usr/include also
exists, for example from an earlier in-tree make headers, then
-I<srctree>/usr/include stays first in the search order.

The new include in xskxceiver.c:

	#include <linux/kernel.h>

would then pick up the exported uapi kernel.h, which has no min_t(). That
breaks the build of parse_command_line():

	memcpy(ifobj->ifname, optarg,
	       min_t(size_t, MAX_INTERFACE_NAME_CHARS, strlen(optarg)));

linux/types.h would also resolve to the uapi copy, which has no u32/u64
typedefs.

This ordering is still the same at the end of the series. Should
tools/include come before the source tree uapi directory?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008114909.734364-1-maciej.fijalkowski%40intel.com
