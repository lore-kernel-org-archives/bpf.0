Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421714;
	b=QwGDAnqzVS7DDPn9nMZRiy4BkJZZj0cwb/xA5PKsnLBE9/G5vJ/1z0tvLUmchzO6/CqC
	 YHpAUl9ma54OnAGwucx7xZSFjPQEc4ys0lFvf2Ho5v3RIM6sUDpruIYgXvA/h2z9dQ5v7
	 8lpK4ILnkeFxb3uIDcv5V/nkT6VAtRgY2xlDMvkrhpyaQn62M1Yau/wBrxle4An0mXUu2
	 pfxjfJIBP1ePQvoS8Dtd3Zj/WUMQuaf+AoQkfGXodHKbjUybfsI4BgybI1itg7xHztyHk
	 fbClv+cTOwsTEMrAiThAiyUoT3hRWEvwQmS2nxrm0loaXyt9Q/+GoSI6FgR841d7ZJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421714;
	h=Received:Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sHbDMT8ENqvz9QG0gvkdlOdXMu+42GPiSj0ilWUBxPM=;
	b=NpTQrVH2H6Spl/EwVTbS2H642PP4IAq0OWPoYbEnMizE27TWI2Q5ZxKkEDzAY4bMZF7/
	 pFbFKujeU6PaFRRLFc0F0/e4/QOLLclWHISqb2VVTNDxS8ROHk70MkAFqZ7K5DTt5pI9y
	 C+P1443gCPkNNK45gdbny/aKCPHOlXW2Ycsl4yKKl8z5IQcIpj0quEjxRYeE06f+6GRV4
	 ak61279uh94Yl5IzZgBNznB7c9EM9tNAhG3DyrcoxSnWUG6Z3/Kt+SuEvyw/Q/JwrhBQ8
	 U8pNbGsc9xyu2W5dM2mL3HuHskqSTkhQMzOXhBPf6vbrlugI4VhUXp5q+5Ht1+18qHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxWpwoA3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F8606EFF3;
	Mon, 19 Oct 2026 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxWpwoA3
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A4E6513F3;
	Mon, 19 Oct 2026 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421714; cv=none; b=hmttmFiDlnJ+dbtNegyYoTJlWQeX4e8PWfjb3xikXu0s1eT44fK53GPU6ZlP35n9WIVDPqlEfUdsGtp6nnTVZgO2TPfXKyBMBuunuVbn5f4YJWCpAXKtXr347amxjaDxNca5CaEv9vT03tBfSoveGZkRc0UVDGbem6FrN7MjIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421714; c=relaxed/simple;
	bh=nIlMfvMaBe0ZMQwkcMYX6GTwHnQbjtaTSb4Mg+QQCFM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jcikb1Hzx/9f99IX7wRq116S/isIbQfL1qo7iEtF5VgtblxJ48+FHC/BuZCNzeKejqvmW3CanbXcb0ik1P38Y1TKZYIRpqs22KO3DzXQsSdTGPibLe6LbSpCIV3L0ZOyIwqAmJUk0HoY8+sNzZiBDcVzUNzzl4rfnCU1BqJC2XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxWpwoA3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2A91F000C6;
	Mon, 19 Oct 2026 14:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421712;
	bh=sHbDMT8ENqvz9QG0gvkdlOdXMu+42GPiSj0ilWUBxPM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VxWpwoA3SbJ4icQi+dVMsoA6vtJc3SyHGAxdIrWHixM+jK0AqTICTayUAQBiM5YK+
	 iPW3i93adtXrPlu5BIJ15z3YYcfwE3DXXSSk3tEjNEZ7JMOQHTsBvMO7CKP9/Xcgt/
	 6py5EGRUjgEt+8BTrMBt3/ppOalh0o86KiPCpbyCZTXB03Pbic5fdMXGVi5b9KN7GS
	 rygA9v55/F4Kv5G6jj4ZRXqS1OwcMkdGt0Z+xQdrN1eeRlgAQC6KHyv12d1EhIqLb1
	 XjAg3wkkPFgOjrgSWK2Rz2YwoSMuJi9IOmRIZkZN7ZxSpSuM1mc1U+dEP+96gWAdGv
	 F290DQui7g2ow==
Subject:
 Re: [PATCH net-next v6 4/5] selftests/net: Add a shared BPF skeleton rule
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
Date: Mon, 19 Oct 2026 14:55:10 +0000
Message-ID: <179242171055.3135.2655547147698612346@kernel.org>
In-Reply-To: <20261018-xdp-v5-send-20261008-v6-4-7336e1282ca3@gmail.com>
References: <20261018-xdp-v5-send-20261008-v6-4-7336e1282ca3@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Under LLVM=1, the host bpftool bootstrap rule in
  tools/testing/selftests/net/bpf.mk probes one compiler and builds with…
- [Low] The patch makes two changes outside its subject.

--

selftests/net: Add a shared BPF skeleton rule

This commit adds a shared %.skel.h rule to selftests/net/bpf.mk. When
BPFTOOL is not supplied, it also builds a host bootstrap bpftool. The
BPF compiler now takes KHDR_INCLUDES instead of the source-tree
usr/include, and the libbpf sub-make gets an absolute srctree.

> diff --git a/tools/testing/selftests/net/bpf.mk b/tools/testing/selftests/net/bpf.mk
> index a4f6755dd8941..016e32960280a 100644
> --- a/tools/testing/selftests/net/bpf.mk
> +++ b/tools/testing/selftests/net/bpf.mk
> @@ -6,8 +6,8 @@ BUILD_DIR := $(SCRATCH_DIR)/build
>  BPFDIR := $(top_srcdir)/tools/lib/bpf
>  APIDIR := $(top_srcdir)/tools/include/uapi
>  
> +CCINCLUDE += $(KHDR_INCLUDES)
>  CCINCLUDE += -I$(selfdir)/bpf
> -CCINCLUDE += -I$(top_srcdir)/usr/include/
>  CCINCLUDE += -I$(SCRATCH_DIR)/include
>  
>  BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
> @@ -46,8 +46,37 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
>  	   $(APIDIR)/linux/bpf.h					       \
>  	   | $(BUILD_DIR)/libbpf
>  	$(call msg,MAKE,,$@)
> -	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
> +	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) srctree=$(abspath $(top_srcdir)) \
> +		    OUTPUT=$(BUILD_DIR)/libbpf/ \
>  		    EXTRA_CFLAGS='-g -O0'				       \
>  		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers

[Severity: Low]
This isn't a bug, but the patch also changes two existing parts of
bpf.mk. CCINCLUDE now uses $(KHDR_INCLUDES) in place of
-I$(top_srcdir)/usr/include/, and the libbpf sub-make now gets an
absolute srctree.

Both changes fix behaviour that dates back to commit 3f584c211d8c
("selftests: net: extract BPF building logic from the Makefile").

The commit message does describe both changes. Would it be worth moving
them into their own patch, or adding a Fixes: tag, so they can be picked
up separately from the new skeleton rule?

>  
>  EXTRA_CLEAN += $(SCRATCH_DIR)
> +
> +# Build a host bpftool only when a test needs a generated skeleton.
> +HOSTCC ?= gcc
> +HOSTLD ?= ld
> +BPFTOOL_BUILD := $(BUILD_DIR)/bpftool

[ ... ]

> +$(BPFTOOL_BUILD)/bootstrap/bpftool: \
> +	$(wildcard $(top_srcdir)/tools/bpf/bpftool/*.[ch]) \
> +	$(top_srcdir)/tools/bpf/bpftool/Makefile \
> +	$(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)
> +	$(call msg,MAKE,,$@)
> +	$(Q)mkdir -p $(BPFTOOL_BUILD)
> +	$(Q)$(MAKE) $(submake_extras) -C $(top_srcdir)/tools/bpf/bpftool \
> +		OUTPUT=$(BPFTOOL_BUILD)/ srctree=$(abspath $(top_srcdir)) \
> +		ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)" bootstrap

[Severity: Medium]
Can this bootstrap build fail with LLVM=1?

bpf.mk sets HOSTCC to gcc and HOSTLD to ld whatever LLVM=, LLVM_PREFIX
and LLVM_SUFFIX are, and it only hands them to the bpftool sub-make as
CC and LD. HOSTCC itself is never passed or exported, so inside the
sub-make tools/scripts/Makefile.include sets it from LLVM:

  $(call allow-override,HOSTCC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
  $(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
  $(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))

bpftool then compiles the bootstrap objects and the bootstrap libbpf with
that HOSTCC, which is clang:

tools/bpf/bpftool/Makefile:
	$(QUIET_CC)$(HOSTCC) $(HOST_CFLAGS) -c -MMD $< -o $@
	...
		ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
		CFLAGS="$(LIBBPF_BOOTSTRAP_CFLAGS)" EXTRA_CFLAGS= $@ install_headers

The CC_NO_CLANG probe in Makefile.include, however, runs against $(CC).
That is the gcc forced on the command line, so the probe adds the
GCC-only warning:

  ifeq ($(CC_NO_CLANG), 1)
  EXTRA_WARNINGS += -Wstrict-aliasing=3

bpftool copies EXTRA_WARNINGS into CFLAGS, HOST_CFLAGS and
LIBBPF_BOOTSTRAP_CFLAGS, and tools/lib/bpf/Makefile adds -Werror. Clang
would then stop with:

  error: unknown warning option '-Wstrict-aliasing=3' [-Werror,-Wunknown-warning-option]

Commit 093b75ef5995 ("tools: Suppress request for warning options not
existent in clang") added the CC_NO_CLANG guard to avoid exactly this
error.

On a clang-only host the result is the same, because a missing gcc
leaves CC_NO_CLANG at 1. The libelf-zstd feature probe would also run
with gcc, not with the clang that does the linking.

The following command should hit this once "selftests/net: Move the XDP
feature test to drivers/net/hw" makes xdp_features depend on
xdp_features.skel.h:

  make LLVM=1 -C tools/testing/selftests TARGETS=drivers/net/hw

selftests/bpf and selftests/hid include tools/scripts/Makefile.include,
so their HOSTCC follows LLVM=. Could bpf.mk set its HOSTCC/HOSTLD
defaults the same way, or pass HOSTCC, HOSTLD and HOSTAR to the bpftool
sub-make as well as CC and LD?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018-xdp-v5-send-20261008-v6-0-7336e1282ca3%40gmail.com
