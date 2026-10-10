Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207F3F3262;
	Sat, 10 Oct 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791627782; cv=none; b=JaN/nWvxqvwVf+sIIYGBmY8VheWcBDmiLd4suyF7PzOR8HkHGFrLKwCVNgT7NhOi63uetUDv1oOqLSezla1+LZzLpsR3i/MVJrceciNJpGZ/j/9EnLLt2m55jFG4cVuCz2K2zMHpkT0idWbyQ20XeWsKoxBRUnXfBzimajam8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791627782; c=relaxed/simple;
	bh=7hfEC9oaAq+7aoWna5BvdDByxSvjrO8XgJy2N33PkDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Be5/vHBFVyNm2igTLbmLcNrBAd9bm4a+elob6J30y47Z4tzP3dGlu81csTLfwn1QrXJ6QIBWHGBjLljK4oichST4r8PLQesfuIL9HTYRqpjK9mU7YkgDPQL9ADZxytMQPUEmrqgdm/eApNvpFUs12MBSKvS2kDFK4MbV/JJnaRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve8ZWB1b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve8ZWB1b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31E81C2BCFF;
	Sat, 10 Oct 2026 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791627782;
	bh=7hfEC9oaAq+7aoWna5BvdDByxSvjrO8XgJy2N33PkDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ve8ZWB1bvK4gCHmiLLA0ZSNIzi/DUaNOOZtNt7JzZf492tuZHyNkDUQs0vG31ygu7
	 XzKJYUZelutSGN8RNSpa2R8P1puG3D28ljdQEWQpuaxFSrSvS84CPumM+2bLGhCYeK
	 OyI5vVatXJ928BpmbTL0SOiCe/Q9YxBmWzl7CaZGjwtTtZAFtl6Qp9m3RWthpdjPJ/
	 x+6219Ran5yXBQiw7h01axt57MnzrubXDL5hbh9Pi5X921pPx5JEtUG5SDkhzxCZo3
	 NHc7/Wt8Bn3ZriJeIuwUx82FGIKVz8VMsIl38pejlS9r2S8sMK2+mEoIuMssEhSzCM
	 DMgftYazQESGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE10CA9EC7;
	Sat, 10 Oct 2026 10:23:02 +0000 (UTC)
From: Bochao Cao via B4 Relay <devnull+bochaolucky.gmail.com@kernel.org>
Date: Sat, 10 Oct 2026 18:22:48 +0800
Subject: [PATCH net-next v5 4/5] selftests/net: Add a shared BPF skeleton
 rule
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-xdp-v5-send-20261008-v5-4-de687cb67c40@gmail.com>
References: <20261010-xdp-v5-send-20261008-v5-0-de687cb67c40@gmail.com>
In-Reply-To: <20261010-xdp-v5-send-20261008-v5-0-de687cb67c40@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791627780; l=1820;
 i=bochaolucky@gmail.com; s=default; h=from:subject:message-id;
 bh=eipfzjTKrG/cSjQ4DLusR7Ju6IxV+23WYHtr5ArWkFc=;
 b=hGNOtzAJoRautGuG7BoOuUZCNeoZfkBYKv60IQbIsjZHPZPvAcQIlOBRd+Qs3gTC+dTQjDHK3
 elSyxSeHIi7B3bTyB80bUltw3+BKLRqric4dDvGbZdrJKaBjs3SHW7u
X-Developer-Key: i=bochaolucky@gmail.com; a=ed25519;
 pk=ZYp7O2eXSIrJ9YmKrl0iHDoulPYSG+1lzICsicAvld0=
X-Endpoint-Received: by B4 Relay for bochaolucky@gmail.com/default with
 auth_id=1042
X-Original-From: Bochao Cao <bochaolucky@gmail.com>
Reply-To: bochaolucky@gmail.com

From: Bochao Cao <bochaolucky@gmail.com>

Add %.skel.h to net/bpf.mk. Build a host bpftool bootstrap when BPFTOOL is
not supplied.

Write the skeleton to a temporary file and rename it on success, so a
failed command does not leave a partial header.

Signed-off-by: Bochao Cao <bochaolucky@gmail.com>
---
 tools/testing/selftests/net/bpf.mk | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/net/bpf.mk b/tools/testing/selftests/net/bpf.mk
index a4f6755dd8941..2ded0f65dafa9 100644
--- a/tools/testing/selftests/net/bpf.mk
+++ b/tools/testing/selftests/net/bpf.mk
@@ -49,5 +49,30 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
 		    EXTRA_CFLAGS='-g -O0'				       \
 		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
 
 EXTRA_CLEAN += $(SCRATCH_DIR)
+
+# Build a host bpftool only when a test needs a generated skeleton.
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
+		OUTPUT=$(BPFTOOL_BUILD)/ ARCH= CROSS_COMPILE= bootstrap
+
+$(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o $(BPFTOOL_DEP)
+	$(call msg,GEN-SKEL,,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name $(notdir $*) > $@.tmp
+	$(Q)mv $@.tmp $@
+
+EXTRA_CLEAN += $(wildcard $(OUTPUT)/*.skel.h $(OUTPUT)/*.skel.h.tmp)

-- 
Git-155)


