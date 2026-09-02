Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB00F3AB460
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331978; cv=none; b=duPoswPok2XL4N+zJiZkt1JF4vBzJg7H/oqw0iRZZjv59pVhtywCQHR3/q8ayaxbeBLe1Mdu5hv04q5UP9l2d06b1vo731/KtBx11qOTla4MFrcyqi4NxpiDCNlbcMcKJAI9BuigV6YebVa5FdTRNiBa6xHNj5P/Cuz54LcT3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331978; c=relaxed/simple;
	bh=CvwpVFn+it/JXqJOYDgCL57j56cIqsobVNBARi7pnmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CSmyikVrTsuo/bRJ+ezCJmdoCR08OaGtZCdh+KKSADVlfa0YuA3W1Ed41MtBEJHZhATQyxHdUxukCXjGEQ0IlV67AjRz011Fm66a1X2EgwpFJJSwsKr37yUpcYDBl6V4cnXziDQUFW9a8eeJqVMgStLWXdFC3iVfoXsQiaxXao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 866B260405; Wed, 02 Sep 2026 08:52:40 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH bpf] selftests/bpf: Add tests to assert that netfilter progs cannot write to skb
Date: Wed,  2 Sep 2026 08:52:26 +0200
Message-ID: <20260902065226.25201-1-fw@strlen.de>
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

Assert that bpf netfilter program type exposes readonly access to the
skb, either via direct packet access or via dynptr API.

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
 .../bpf/progs/verifier_netfilter_ctx.c        | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
index e2cbc5bda65e..7e304331409f 100644
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
+int with_invalid_data_write_test4(struct bpf_nf_ctx *ctx)
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
+__description("netfilter test prog with bpf dynptr_slice_write + write")
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

