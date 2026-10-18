Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8EE4CA270;
	Sun, 18 Oct 2026 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792332375; cv=none; b=FVBUsUPvIx2hy+fpPFCOAQ2MZ83HuX48JMSZHu5ZDwpe36Z6+9s/MB8w19Ti+oTdUHnHdmyJSSNjvia6rhVUIWbXoMvk76PULMS8DODfIcHeG0zx68pobqNYNt+SMWiFkIWMAGHQKLhuXSGYTs9jTLxsv9Wrm4jomm+kHgEsv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792332375; c=relaxed/simple;
	bh=JZYvmxnkCpooFEtzzdDLrx9d2xQ8IN58Bf+H63ir40Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EIpwuD2zcJXKgSUC735X3b0RirW9fYkj3rQ37DHzktHY6Pq/x1aHdqeMtDl7bTGGmi5L/kEiTYBA0lWvywygRo/vPKmwAOnFq8ncO2+TWOZeQCiiyxU3JoH3fATu3u75MCWcXXX2AphTS75N0KUy90vY3axGI408hlwxtfR0FbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwgGN80F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwgGN80F"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B889CC2BD05;
	Sun, 18 Oct 2026 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792332374;
	bh=JZYvmxnkCpooFEtzzdDLrx9d2xQ8IN58Bf+H63ir40Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fwgGN80FZKHUc+9NsH1RKCxTNjbFASEdx0cbVZlbpBHMupUoOHGGRSp/D8C7esMd/
	 22bLtxHXnfJH4FqNcsYKDJnpGUDbY4Nu1B2rz1ko68eiPiGosljpFNoJeeDLYJsw1B
	 rs0xc8vn6O2CtDF7buzneRhnWJwV1H9SJlahi3TPue5vVLOfZrOw3Xaxvz5RjtjyKz
	 BypmLBwKRqht/uqXQ3Sg4/i/qbfg4PR6oVLpDBMjOEsTvn8jm/IIk3D6CTu4MRRZfo
	 zHWqua55kfWRZDsPGXErvyGCdWu0Dcm4/ez/yS/SC/2jR0s7rAi2/tPzNUc/Q1i6iK
	 nN8zMSYp53qBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DA4CCF2C9;
	Sun, 18 Oct 2026 14:06:14 +0000 (UTC)
From: Bochao Cao via B4 Relay <devnull+bochaolucky.gmail.com@kernel.org>
Date: Sun, 18 Oct 2026 22:05:53 +0800
Subject: [PATCH net-next v6 4/5] selftests/net: Add a shared BPF skeleton
 rule
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-xdp-v5-send-20261008-v6-4-7336e1282ca3@gmail.com>
References: <20261018-xdp-v5-send-20261008-v6-0-7336e1282ca3@gmail.com>
In-Reply-To: <20261018-xdp-v5-send-20261008-v6-0-7336e1282ca3@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Tiezhu Yang <tiozhang@didiglobal.com>, Bochao Cao <bochaolucky@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Petr Machata <petrm@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792332371; l=2900;
 i=bochaolucky@gmail.com; s=default; h=from:subject:message-id;
 bh=IefQQaDfNjaCeCPmWb/HPENI7gRpsQZQYQxUbSrYy/c=;
 b=OQo0u1MsdV8geeXkxktAqiL4HcdM+yS5yAsMRSubDb9daycidauVNyhLta11DV0ma6s8s2JYE
 ArUgxx68GXzBFLO93Add82knAaR9UuyYaYDxpZPW/1O8/uem8khcwK4
X-Developer-Key: i=bochaolucky@gmail.com; a=ed25519;
 pk=ZYp7O2eXSIrJ9YmKrl0iHDoulPYSG+1lzICsicAvld0=
X-Endpoint-Received: by B4 Relay for bochaolucky@gmail.com/default with
 auth_id=1042
X-Original-From: Bochao Cao <bochaolucky@gmail.com>
Reply-To: bochaolucky@gmail.com

From: Bochao Cao <bochaolucky@gmail.com>

Add a shared skeleton rule and build host bpftool when BPFTOOL is not
supplied. Use host CC/LD and absolute source paths in submakes.

Pass KHDR_INCLUDES to the BPF compiler without overriding it with
source-tree headers. Generate the skeleton through a temporary file.

Tested normal and separate-output builds, inherited relative srctree,
and host bootstrap with unusable target CC/LD. A conflicting source
header no longer overrides the installed header.

Signed-off-by: Bochao Cao <bochaolucky@gmail.com>
---
 tools/testing/selftests/net/bpf.mk | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/bpf.mk b/tools/testing/selftests/net/bpf.mk
index a4f6755dd8941..016e32960280a 100644
--- a/tools/testing/selftests/net/bpf.mk
+++ b/tools/testing/selftests/net/bpf.mk
@@ -4,12 +4,12 @@ CLANG ?= clang
 SCRATCH_DIR := $(OUTPUT)/tools
 BUILD_DIR := $(SCRATCH_DIR)/build
 BPFDIR := $(top_srcdir)/tools/lib/bpf
 APIDIR := $(top_srcdir)/tools/include/uapi
 
+CCINCLUDE += $(KHDR_INCLUDES)
 CCINCLUDE += -I$(selfdir)/bpf
-CCINCLUDE += -I$(top_srcdir)/usr/include/
 CCINCLUDE += -I$(SCRATCH_DIR)/include
 
 BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
 
 MAKE_DIRS := $(BUILD_DIR)/libbpf
@@ -44,10 +44,39 @@ $(BPF_PROG_OBJS): $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
 
 $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	   $(APIDIR)/linux/bpf.h					       \
 	   | $(BUILD_DIR)/libbpf
 	$(call msg,MAKE,,$@)
-	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) srctree=$(abspath $(top_srcdir)) \
+		    OUTPUT=$(BUILD_DIR)/libbpf/ \
 		    EXTRA_CFLAGS='-g -O0'				       \
 		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
 
 EXTRA_CLEAN += $(SCRATCH_DIR)
+
+# Build a host bpftool only when a test needs a generated skeleton.
+HOSTCC ?= gcc
+HOSTLD ?= ld
+BPFTOOL_BUILD := $(BUILD_DIR)/bpftool
+ifeq ($(origin BPFTOOL),undefined)
+BPFTOOL := $(BPFTOOL_BUILD)/bootstrap/bpftool
+BPFTOOL_DEP := $(BPFTOOL)
+else
+BPFTOOL_DEP := $(shell command -v $(BPFTOOL))
+endif
+
+$(BPFTOOL_BUILD)/bootstrap/bpftool: \
+	$(wildcard $(top_srcdir)/tools/bpf/bpftool/*.[ch]) \
+	$(top_srcdir)/tools/bpf/bpftool/Makefile \
+	$(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)
+	$(call msg,MAKE,,$@)
+	$(Q)mkdir -p $(BPFTOOL_BUILD)
+	$(Q)$(MAKE) $(submake_extras) -C $(top_srcdir)/tools/bpf/bpftool \
+		OUTPUT=$(BPFTOOL_BUILD)/ srctree=$(abspath $(top_srcdir)) \
+		ARCH= CROSS_COMPILE= CC="$(HOSTCC)" LD="$(HOSTLD)" bootstrap
+
+$(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o $(BPFTOOL_DEP)
+	$(call msg,GEN-SKEL,,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name $(notdir $*) > $@.tmp
+	$(Q)mv $@.tmp $@
+
+EXTRA_CLEAN += $(wildcard $(OUTPUT)/*.skel.h $(OUTPUT)/*.skel.h.tmp)

-- 
Git-155)


