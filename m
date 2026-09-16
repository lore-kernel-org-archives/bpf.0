Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF6B3C1D54
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535322; cv=none; b=ZbZp7NuqTt4Kfly6Zx9wLLj+SIMhjsO1MUKw8zM/nw4H4HudCsu0KY/IEDuxduDWyMfMvhsgbcdvvbBOZjW0qcRN6/h4T5p0h0vzUXAgMdi6P+fnjhzsRGxYN2zaq2FfzuObFPbym6WXUMvbVwsrH7J1y13nzoPsbM/qnZ46qJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535322; c=relaxed/simple;
	bh=RCAx16luTF02kZgEZ0D7CHSImQt7iTlNbzO7mxUy3ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fpuo8hUdrg8DTeF6zqeXmPZ7KzoVBj7lQYd2tcTePio1+N8/SIt4lmASkEhezTtlR683eVUEzRxhi5cUXAab9+DNJAfnUIdLC01hXrGSHdk928XsHEdwPwQrl2cUiWnC2YbWRkYLK7lts7mKB9ddR2+bhD7M+GWBwRUpss/qwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=OxPPh95V; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="OxPPh95V"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so536786a12.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535320; x=1790140120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8uvju0VQfszCfaJ5PHHj1YzIoy00iEV5n4pCl9kK1c=;
        b=OxPPh95VKbBNNDbkUKzIXhA9JRSi8dRCtRWokBGbz45AXCMNb0PQXGhqp2hnJW4J8u
         1HV6sa082mtOtRwFf12j8RscEr8vzpXIngCi0Hd2B5uyVQMXv2AFoDce6IbGX5q6ciIq
         LI/61bf/6M89bKum+lIxyCCatIhW0aOB2OtbPfgdZPVkWRzPpuM5f+fdoz16u54xJGl5
         JBTuLswOMYIP4LPm0YGxSuxOBdPhC2aXqSrZs+8VLTCrXEzEOT0/1War7PsselthR78H
         M6hq9h8pcKdbMwIvhcDtXv6fcrBxoE0FpNBRpA4cDev1MX+TA9D1dMIGgdggo/rEUbX2
         m+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535320; x=1790140120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w8uvju0VQfszCfaJ5PHHj1YzIoy00iEV5n4pCl9kK1c=;
        b=wOB5NaPeh5LiiEnHBwCTwCtvToYvOx1NY3wknnnD2FRFbyLOZ43LegBHWh/Xo3FtON
         XDdQ4Mx2gHMXsMPHT/3cCp0uesF0G7t5gyu1YLfm0qOl4xnPQo4Qmkvyv1fQOxZ/XAjk
         1rd5lq1aQwz10FL46ZORvKaRD5tfGx8+sA59xty2VgZIlCsZ88F6iya4W0HSQJ9QFhk/
         BEEu+ZLCUlYCjL45kfZMScSOAVYBfnYqXr3Ca2SjYIizTNgwIipwhtWUtgOeo0PSoF2B
         tylta1HWtidoSTrWhTwCI7PbMbEnT3aFYlLTlkambTlcfjz7K7l/RUaLZKN7M6MO4wqD
         EBcQ==
X-Gm-Message-State: AFuF++ljTvrZc0Rwy1t913V7gQlj8NVlubVI/n6wy0WLO1eKcLBCsjHU
	4fTY67mwRE4CzQH0kFrePC+XDTxuO+nuYX4WalB3I9Ivpizh+OhQfDSJv6gEzAt5NPzw597LMWS
	O1r7U
X-Gm-Gg: AYBFou1dwHmDjxIe9SZ22e2FxlPytsxie7l6dWOAhQbDHPiJJeWwIvPw7qtoBbgnDmm
	VouIFbVBHJgPLZaK3oCaF2/87xM/x/sgn8au1nEB2Gq7UZJmr8t0DVM9fC8JIFJZYUpXkYfQ8mX
	C/aezeTWP+qAmXrt1HMCat1Ohbsae0QQ1skyUl4nyK/WjN+PwbQQIFU7k1jCk/rIZ8zgup1zQhc
	/T9zdmctBeddy3I5URyheI34hDIVFvq9Km73eDwtd8Sc7pwI/T2mZdH/Lh/waOg/0w1rXL9ByLj
	UnU97OHqD/g0blRNhAhPVGpJ8YSI9/mJJrSNTcyF9t4r+yBwb3POdtAHFhGxwuCPokIbAsnPVUZ
	DlavqhGXAxSb1ewrc9K8/+rNCE7lut3tXIgfzTNUDUTdUSI+mhbc8nB06t1+683qz4YModqwbw4
	HmsSpGlqij3fNtrBE3wah/pqJiBnCZpU9RKjdO26cNSoRel73qOJCt0o1FL0a77+g4w7SKuWe/G
	8vdL1ZxvYmTfW+4Lu7XYZpdYs2P2BlteFIJeOD+8wMRdjrd
X-Received: by 2002:a17:90b:3a43:b0:39d:f5b1:e365 with SMTP id 98e67ed59e1d1-39e1e559b78mr3162444a91.25.1789535320402;
        Tue, 15 Sep 2026 22:08:40 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:40 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 06/11] selftests/bpf: Test rejection of pkt args to mutating subprogs
Date: Wed, 16 Sep 2026 05:08:24 +0000
Message-ID: <20260916050830.8774-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916050830.8774-1-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftests that ensures that PTR_TO_PACKET arguments can
only be passed to subprogs that will never adjust the underlying
packet memory, and are rejected otherwise.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/progs/verifier_global_ptr_args.c      | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index b277b1efb..10019af5e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -350,4 +350,57 @@ int anything_to_untrusted_mem(void *ctx)
 	return 0;
 }
 
+struct pkt_arg {
+	__u64 x;
+	__u8 pad[56];
+};
+
+__weak int subprog_pkt_ptr_no_change(struct pkt_arg *p)
+{
+	if (!p)
+		return 0;
+
+	return p->x;
+}
+
+SEC("?tc")
+__success
+int pkt_ptr_to_global_mem_arg_no_change(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct pkt_arg *p = data;
+
+	if ((void *)(p + 1) > data_end)
+		return 0;
+
+	return subprog_pkt_ptr_no_change(p);
+}
+
+__weak int subprog_pkt_ptr_changes_data(struct __sk_buff *skb __arg_ctx,
+					struct pkt_arg *p)
+{
+	if (!p)
+		return 0;
+
+	bpf_skb_pull_data(skb, 0);
+	return p->x;
+}
+
+SEC("?tc")
+__failure __log_level(2)
+__msg("R2 is a packet pointer, but func#{{[0-9]+}} may change packet data")
+__msg("Caller passes invalid args into func#{{[0-9]+}} ('subprog_pkt_ptr_changes_data')")
+int pkt_ptr_to_global_mem_arg_changes_data(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct pkt_arg *p = data;
+
+	if ((void *)(p + 1) > data_end)
+		return 0;
+
+	return subprog_pkt_ptr_changes_data(skb, p);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

