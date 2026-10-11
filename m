Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D45396B70;
	Sun, 11 Oct 2026 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791717436; cv=none; b=S/lXRiKcWAPnHQbq4wOKy+W5Cd9awmKC/6K7pHKQrkvCdFHcWldD9s5j1UMuxUTuB81K4r7tDefBR42VnqpNsIuioquHoHU6yGDz7SjFRlTMOsrdh83sczLHPdIhE/ZFQJIlSZs00hBDkqkJwEtRhbPsN9m4pxz5q/Egol1jDeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791717436; c=relaxed/simple;
	bh=xOT8e+/wZ6hkbXpE8gyNLrEk3DhcuEhunP2sLNyWwBM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xmx6UipfHpgSHSlOqobHwlI9yC12Alxr8hXU4lH5F1BxeaGiVlAFVcbn3ZYd18NMHzadlzAcq31vAjgwRcbtEEs7M/rad6MpiXTDhg8zxAa5/mYf4V96rhPvPbgqN5F6cS5+1rQXE2VdpddsI+JaXycWYQpzuqPKtxaVaHmVp2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLYh9BUS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLYh9BUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3C11F0089C;
	Sun, 11 Oct 2026 11:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791717431;
	bh=h11RPGp5NoKWzMWlUjiOKhzhckBM9u4zFGz7SS6llOM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OLYh9BUSagYC0feDSeW5NBIgNZmb1kOPINfFkOn1WV/Z6SXxrIyzefjV2r8wFQh//
	 garR9q1S5VBBBd+swxakz1j5qXRmcv0A64H5nzYYDZRYieo42zFyvbxBNeDEbbZsAX
	 BET4OGP7f0Tbg0djfOSlsHorb4dG3kbyT1gyVCEW3U6t53yBaEjCj+yI/O3fwZnEhr
	 PK64qccwmS0X/mFPD9XWible7+PnwV7YJBGMad/MtIA2Q+03sWFWF5UeWsULyRmc1o
	 RFSLFOAoTmL/IWuZTpczCgXv529bVBZz8brnUFC5bxhEyDOBnX7AEil92nExtM2vd0
	 u7pNHzediPJnQ==
Subject:
 Re: [PATCH net-next v5 4/5] selftests/net: Add a shared BPF skeleton rule
From: netdev-bot+sashiko@kernel.org
To: bochaolucky@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 andrew+netdev@lunn.ch, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 alexis.lothore@bootlin.com, lorenzo@kernel.org, tiozhang@didiglobal.com,
 willemdebruijn.kernel@gmail.com, petrm@nvidia.com
Date: Sun, 11 Oct 2026 11:17:09 +0000
Message-ID: <179171742929.434549.12792294483701473721@kernel.org>
In-Reply-To: <20261010-xdp-v5-send-20261008-v5-4-de687cb67c40@gmail.com>
References: <20261010-xdp-v5-send-20261008-v5-4-de687cb67c40@gmail.com>
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

- [Medium] The new bootstrap bpftool rule in
  tools/testing/selftests/net/bpf.mk…
- [Low] The new host bpftool bootstrap rule in
  tools/testing/selftests/net/bpf.mk (lines 70-71) clears only ARCH and…

--

selftests/net: Add a shared BPF skeleton rule

This commit adds a shared %.skel.h rule to tools/testing/selftests/net/bpf.mk.
If BPFTOOL is not supplied, the rule builds a host bpftool bootstrap. The
skeleton is written to a temporary file and renamed into place only on
success.

> diff --git a/tools/testing/selftests/net/bpf.mk b/tools/testing/selftests/net/bpf.mk
> index a4f6755dd8941..2ded0f65dafa9 100644
> --- a/tools/testing/selftests/net/bpf.mk
> +++ b/tools/testing/selftests/net/bpf.mk
> @@ -51,3 +51,28 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \

[ ... ]

> +$(BPFTOOL_BUILD)/bootstrap/bpftool: \
> +	$(wildcard $(top_srcdir)/tools/bpf/bpftool/*.[ch]) \
> +	$(top_srcdir)/tools/bpf/bpftool/Makefile \
> +	$(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)
> +	$(call msg,MAKE,,$@)
> +	$(Q)mkdir -p $(BPFTOOL_BUILD)
> +	$(Q)$(MAKE) $(submake_extras) -C $(top_srcdir)/tools/bpf/bpftool \
> +		OUTPUT=$(BPFTOOL_BUILD)/ ARCH= CROSS_COMPILE= bootstrap

[Severity: Medium]
Does this sub-make work when srctree is inherited from the top-level kernel
Makefile?

For an in-tree build, the top-level Makefile exports a relative srctree:

Makefile:
    export srctree := $(if $(KBUILD_EXTMOD),$(abs_srctree),$(srcroot))

That value is "." in-tree, or ".." for O= set to a source subdirectory. The
kselftest and kselftest-% targets recurse into tools/testing/selftests with
it still set. Nothing along the way resets it.

The bpftool Makefile only computes the source root when srctree is empty:

tools/bpf/bpftool/Makefile:
    ifeq ($(srctree),)
    srctree := $(patsubst %/,%,$(dir $(CURDIR)))
    ...
    include $(srctree)/tools/build/Makefile.feature

With srctree=".", that include resolves relative to tools/bpf/bpftool. The
file does not exist there, so make stops with a fatal error before the
skeleton is generated.

libbpf has an explicit workaround for this case in tools/lib/bpf/Makefile:

    # This will work when bpf is built in tools env. where srctree
    # isn't set and when invoked from selftests build, where srctree
    # is a ".".

bpftool has no equivalent.

A later commit in this series, "selftests/net: Move the XDP feature test to
drivers/net/hw", makes xdp_features depend on xdp_features.skel.h. After
that, would "make kselftest-all TARGETS=drivers/net/hw" from an in-tree
kernel build fail here?

Direct "make -C tools/testing/selftests" invocations leave srctree unset and
are not affected.

Would passing srctree=$(abspath $(top_srcdir)), or an empty srctree=, to
this sub-make avoid the problem?

[Severity: Low]
Should this also force the host toolchain with CC and LD, the way the other
host bpftool rules in the tree do?

tools/testing/selftests/bpf/Makefile:
    ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)"

hid/Makefile and sched_ext/Makefile use the same pattern.

A target CC can reach this sub-make in two ways:

  - The top-level Makefile exports CC for
    "make ARCH=... CROSS_COMPILE=... kselftest-*".
  - The user passes CC on the command line.

tools/scripts/Makefile.include keeps that CC through allow-override.
tools/build/Makefile.feature then runs the bpftool feature probes with
CC="$(CC)", which is the cross compiler.

The libelf-zstd probe result decides the host link line:

tools/bpf/bpftool/Makefile:
    ifeq ($(feature-libelf-zstd),1)
    LIBS += -lzstd
    LIBS_BOOTSTRAP += -lzstd
    ...
    $(QUIET_LINK)$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) $(BOOTSTRAP_OBJS) $(LIBS_BOOTSTRAP) -o $@

Suppose the target sysroot has libelf and libzstd, but the host has no
libzstd development files. Would the bootstrap link then fail with "cannot
find -lzstd" and break skeleton generation?

If CC="$(HOSTCC)" LD="$(HOSTLD)" is added, HOSTCC and HOSTLD may also need
defaults in bpf.mk, because lib.mk does not define them.

> +
> +$(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o $(BPFTOOL_DEP)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010-xdp-v5-send-20261008-v5-0-de687cb67c40%40gmail.com
