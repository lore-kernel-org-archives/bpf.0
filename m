Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913F39448F
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418735; cv=none; b=mGk3V0RVR1bAmcj0OLcS7urORZBeGUxWqmL/bjOiR8J0oWfo5St++Lv0A3aJxWQpIdeflvBoNk+OF6FER+0G7XE1AEYxQI6nlfS3O4EdcHOQN4zl0+jEmQAv1h7hrlj0XdZVIuTa116NPXFy7Qx21CMkjCcHHALdKEUPv7Zf7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418735; c=relaxed/simple;
	bh=XcfM1DVvLvFxpOsq0i/tu3/FApva69qT+Qi//sccKIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PB6Vv4xVP86FxH8RFJcacDTg/1eqwPkvbmJ/EcYoqGxsF8QFSp9j3URejfXhLXd5ftyc9AyI3fP6tcDWJH4/dVSfLaF5L6uZ9R+IpqYV1zDjMflMlYy+Y60gu0f2Q7KNFWnmLurNG0y65/eJzv44mJC/fILaFajP6yyQ3XJaajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A6AD5601F5; Thu, 03 Sep 2026 08:58:51 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <bpf@vger.kernel.org>
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 bpf] selftests/bpf: Add tests to assert that netfilter progs cannot write to skb
Date: Thu,  3 Sep 2026 08:58:45 +0200
Message-ID: <20260903065845.22762-1-fw@strlen.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The netfilter framework is allergic to ip header changing after
validation done by ip/ipv6 stack.

Assert that bpf netfilter programs do not allow skb write access.

Following additional tests are expected to be rejected by verifier:

1. alter skb->len.
2. alter skb->data.
3. prog calls bpf_dynptr_slice_rdwr.
4. alter location returned by dynptr API.

Add following test case for bpf runtime:
- alter skb data via bpf_dynptr_write()

Test checks via __retval() that bpf_dynptr_write() returned nonzero value.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: follow LLM review: rename functions and clarify commit message.

 .../bpf/progs/verifier_netfilter_ctx.c        | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
index e2cbc5bda65e..b5d7f567d0d4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
@@ -113,4 +113,82 @@ int with_valid_ctx_access_test6(struct bpf_nf_ctx *ctx)
 	return th->dest == bpf_htons(22) ? NF_ACCEPT : NF_DROP;
 }
 
+SEC("netfilter")
+__description("netfilter test prog with skb write access")
+__failure __msg("only read is supported")
+int skb_len_write(struct bpf_nf_ctx *ctx)
+{
+	ctx->skb->len = 1;
+	return 1;
+}
+
+SEC("netfilter")
+__description("netfilter test prog with skb data write access")
+__failure __msg("cannot write into rdonly_untrusted_mem")
+int skb_data_write(struct bpf_nf_ctx *ctx)
+{
+	ctx->skb->data[0] = 0;
+	return 1;
+}
+
+SEC("netfilter")
+__description("netfilter test prog with bpf_dynptr_write")
+__success __failure_unpriv
+__retval(0)
+int with_dynptr_write(struct bpf_nf_ctx *ctx)
+{
+	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
+	struct bpf_dynptr ptr;
+	u8 buffer[1] = {};
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr))
+		return 1;
+
+	if (bpf_dynptr_write(&ptr, 0, buffer, sizeof(buffer), 0))
+		return 0; /* must always fail */
+
+	return 1;
+}
+
+SEC("netfilter")
+__description("netfilter test prog with bpf_dynptr_slice_rdwr")
+__failure __msg("the prog does not allow writes to packet data")
+int with_dynptr_rdwr(struct bpf_nf_ctx *ctx)
+{
+	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
+	u8 buffer_iph[20] = {};
+	struct bpf_dynptr ptr;
+	struct iphdr *iph;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr))
+		return 1;
+
+	iph = bpf_dynptr_slice_rdwr(&ptr, 0, buffer_iph, sizeof(buffer_iph));
+	if (!iph)
+		return 0;
+
+	return 1;
+}
+
+SEC("netfilter")
+__description("netfilter test prog with bpf_dynptr_slice + write")
+__failure __msg("cannot write into rdonly_mem")
+int with_dynptr_store(struct bpf_nf_ctx *ctx)
+{
+	struct __sk_buff *skb = (struct __sk_buff *)ctx->skb;
+	u8 buffer_iph[20] = {};
+	struct bpf_dynptr ptr;
+	struct iphdr *iph;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr))
+		return 1;
+
+	iph = bpf_dynptr_slice(&ptr, 0, buffer_iph, sizeof(buffer_iph));
+	if (!iph)
+		return 0;
+	iph->protocol = 42;
+
+	return 1;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

