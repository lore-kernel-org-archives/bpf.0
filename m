Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811B576ED4
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097657; cv=none; b=cUZAD6AVnTCxV6u2LwP00znEwBemUAJjq8/4qvCNMl4qmxCq3Mx5a3aw0PsvF+UnnhoB3BPOzSK+g75slxhCIlwdC2GsqH+YNDWmbyXxhIfjmkyM2JfGOXTQDS8/UTRvgYI5LdKJqCWZPHPFbO/Gb8RGqgunJU3ubeAQme2spcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097657; c=relaxed/simple;
	bh=K1kPVhalzK2p/Oi/++MfwlZAsChdgNM2Rym6IJuVlIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYhlFsa+CGG7UIAZvLAhQJBbIOUEe6xNK+4/a6ghapJVNyunvArjz7SG+8F0c/of4BnAwewFaXlxKO8zGChre5atU3+xjrN6GlQ/bMucJZXOyowrBRAsQ02nRc+wJIjkGjcNFNM0CmN2qRO63y9XRG/tpFaafdux3VauMzWR95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Ckanra5P; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Ckanra5P"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccdaea75so59546a91.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097650; x=1790702450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqY05vLt4ODQV/QJgRg1j8e1nKXlf81O3e+mqZS/iH0=;
        b=Ckanra5PxxbZxie5E8MY2JKit7FD/FM8Fx/J+pbBUx4pd+Xpt2mlCPXZsUU6ghTyGm
         O1UHFHV7drCk3PVZ2CjTukoohLiC6ThARPSY713tuA7U0tdW2+zns+XTD0baf2HBqy8D
         jXuMTj4PCtpTAnlUwVD0k7rHb2cBiVRVKGxUKRCsf1Mi6b8kMz8q4xlFD7K+RYWzAaNY
         ZTBVuf3y0EnHNIN0spQsASeFn4tfXWgjdEzkuOdS/RAS+2A+ayBYXTh4mszZeZDBV8k2
         wWOHPHCcQ/vx0Jq5SlFT5o4jxK2Bq29fR0flpDLvHBmZNETlqTwjj4m4UyRJ9ru3XYV/
         egtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097650; x=1790702450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iqY05vLt4ODQV/QJgRg1j8e1nKXlf81O3e+mqZS/iH0=;
        b=rIaVLZgI+hpt0BI89RVavuu0nch+VjOmLooP2WKR7GK9NGCWmalemsKYwWQAgcc2I6
         sPiv/rd4ehaMZjGgs3szlp4Wze7eIzdFeDdpcfxMgLv7MP6BF91qDagou1AIT6t30fRI
         PI98sDtTCUYWJv3pHJuBLfa8P0TOw6NByROseFc296owRWUIKIfp13KbwwuhM0JsKFtF
         rQwejGFJMgCSl62Y/HjeX36pkQmP2EYzqo79C1k5GBrHTN22fqlBL7TIYbvqg6x4pbDS
         P13UoEQdI0pSbFXBmcAZ8ETm/bl6uyC9AEGrhtwUNtvUKKwG+j4WdMyft3dAb1NKA7AM
         BDgA==
X-Gm-Message-State: AFuF++kxZrabM/xZLJAlpI6jd1U+qG2ge6P3rkFvUGS7LPG+NXeiPpb2
	zNSqcN7Czb8fZE+hl9g4mHNUtQChKU7G3Y+eU7b1dVKa+PIABNkuzJgeHS124VCFoi7srhMjQZq
	8HoLLSjI=
X-Gm-Gg: AYBFou2LBMfITwZT+NwXCrIJT1/VS+TEcz7NzmoTxXyT3vGOZcPysE2IctSBRRP1eUY
	RfhyXkmZFTzeAikG3Cn2cQfZ12zfU+cK4YaZiFepSegL0fP/MKTJ8SH9ivdHfzQwbVfR18y7kUA
	g8bDLdbAck0YbkmOdXi7ErBeBjj2FoXXlhmJJAD68t+QnB4sTf849Y7yaI/Eo1huZDnSco9yjoq
	yfUAT8CQXKHlLIRc7G+aC/w9i3klt1Ul/5E6tzNIyVBm8/WVqO9Q7uXjDzeToqXAnc3uORycygc
	J1L6BAcUKjvh6jfSHyZFyGtXu95sXjvcBysUD/R2mic3N60CppBu6el3JhcbNt5I92wX+KCD060
	Z4AqPy+oHk116CMpa6CKPp9oSMFJR3vRSpHZA2fZoLXswgiDDd7eFX6hz6DRtj1NgheOuI6fH1e
	wCFOHLQbDiR465VnWJx4rx6c6t3T6Xkl0zOlS6SVYv45O8G8kZg2WrqkESwoLZb8IX/PuonQeie
	g93g3YsLQM2yUyLe58Ud1em7GjNlRc4gSG/OI78gw==
X-Received: by 2002:a17:90b:2f48:b0:39e:4c7e:bc4 with SMTP id 98e67ed59e1d1-3a07e4d8773mr89611a91.18.1790097649947;
        Tue, 22 Sep 2026 10:20:49 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:49 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 11/11] selftests/bpf: Test dynptr slice invalidation on skb clobber
Date: Tue, 22 Sep 2026 17:20:28 +0000
Message-ID: <20260922172028.6269-12-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that ensure that dynptr slices backed by skb memory
are invalidated on any operation that potentially moves/frees
the backing skb memory. Also test that only skb-backed dynptrs
may invalidate pointers into skbs.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 183 ++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 1cd61d72c..0f030f397 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -13,6 +13,9 @@
 
 char _license[] SEC("license") = "GPL";
 
+extern int bpf_dynptr_memset(const struct bpf_dynptr *p, __u64 offset, __u64 size,
+			     __u8 val) __ksym __weak;
+
 struct test_info {
 	int x;
 	struct bpf_dynptr ptr;
@@ -1274,6 +1277,186 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+/*
+ * A kfunc that may clobber packet pointers must invalidate skb data slices.
+ */
+SEC("?tc")
+__failure __msg("invalid mem access")
+int skb_invalid_data_slice_after_dynptr_memset(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+	char buffer[sizeof(*hdr)] = {};
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice_rdwr(&ptr, 0, buffer, sizeof(buffer));
+	if (!hdr)
+		return SK_DROP;
+
+	bpf_dynptr_memset(&ptr, 0, 0, 0);
+
+	/* this should fail */
+	val = hdr->h_proto;
+
+	return SK_PASS;
+}
+
+/*
+ * A dynptr kfunc that may clobber packet pointers must not invalidate packet
+ * pointers when called with a non-skb dynptr.
+ */
+SEC("?tc")
+__success
+int pkt_ptr_valid_after_dynptr_memset_on_mem(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	int *p = (void *)(long)skb->data;
+
+	if ((void *)(p + 1) > (void *)(long)skb->data_end)
+		return SK_DROP;
+
+	if (bpf_dynptr_from_mem(&val, sizeof(val), 0, &ptr))
+		return SK_DROP;
+
+	bpf_dynptr_memset(&ptr, 0, 0, 0);
+
+	return *p ? SK_PASS : SK_DROP;
+}
+
+__noinline
+int skb_dynptr_memset(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr))
+		return 0;
+
+	return bpf_dynptr_memset(&ptr, 0, 0, 0);
+}
+
+/*
+ * A global subprog that may clobber packet pointers must invalidate packet
+ * pointers held by its caller.
+ */
+SEC("?tc")
+__failure __msg("invalid mem access")
+int skb_invalid_pkt_ptr_after_dynptr_memset_global(struct __sk_buff *skb)
+{
+	int *p = (void *)(long)skb->data;
+
+	if ((void *)(p + 1) > (void *)(long)skb->data_end)
+		return SK_DROP;
+
+	skb_dynptr_memset(skb);
+
+	/* this should fail */
+	val = *p;
+
+	return SK_PASS;
+}
+
+__noinline
+int skb_dynptr_memset_global_arg(struct __sk_buff *skb,
+				 struct bpf_dynptr *ptr)
+{
+	int *p = (void *)(long)skb->data;
+
+	if ((void *)(p + 1) > (void *)(long)skb->data_end)
+		return SK_DROP;
+
+	bpf_dynptr_memset(ptr, 0, sizeof(*p), 0);
+
+	/* this should fail */
+	val = *p;
+
+	return SK_PASS;
+}
+
+/*
+ * A global subprog must conservatively treat a dynptr argument as possibly
+ * skb-backed when checking whether a kfunc invalidates packet pointers.
+ */
+SEC("?tc")
+__failure __msg("invalid mem access")
+int skb_invalid_pkt_ptr_after_dynptr_memset_global_arg(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr))
+		return SK_DROP;
+
+	return skb_dynptr_memset_global_arg(skb, &ptr);
+}
+
+__noinline
+int skb_dynptr_write_global_arg(struct bpf_dynptr *ptr)
+{
+	int write_data = 0;
+
+	return bpf_dynptr_write(ptr, 0, &write_data, sizeof(write_data), 0);
+}
+
+/*
+ * A global subprog that calls bpf_dynptr_write() on a dynptr argument must
+ * invalidate packet pointers held by its caller.
+ */
+SEC("?tc")
+__failure __msg("invalid mem access")
+int skb_invalid_pkt_ptr_after_dynptr_write_global_arg(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	int *p = (void *)(long)skb->data;
+
+	if ((void *)(p + 1) > (void *)(long)skb->data_end)
+		return SK_DROP;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr))
+		return SK_DROP;
+
+	skb_dynptr_write_global_arg(&ptr);
+
+	/* this should fail */
+	val = *p;
+
+	return SK_PASS;
+}
+
+__noinline
+int skb_dynptr_write_global_arg_with_pkt_ptr(struct __sk_buff *skb,
+					    struct bpf_dynptr *ptr)
+{
+	int write_data = 0;
+	int *p = (void *)(long)skb->data;
+
+	if ((void *)(p + 1) > (void *)(long)skb->data_end)
+		return SK_DROP;
+
+	bpf_dynptr_write(ptr, 0, &write_data, sizeof(write_data), 0);
+
+	/* this should fail */
+	val = *p;
+
+	return SK_PASS;
+}
+
+/*
+ * A global subprog must conservatively treat a dynptr argument as possibly
+ * skb-backed when checking whether bpf_dynptr_write() invalidates packet
+ * pointers in the callee.
+ */
+SEC("?tc")
+__failure __msg("invalid mem access")
+int skb_invalid_pkt_ptr_after_dynptr_write_global_arg_in_subprog(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr))
+		return SK_DROP;
+
+	return skb_dynptr_write_global_arg_with_pkt_ptr(skb, &ptr);
+}
+
 /* Read-only skb data slice is invalidated on write to skb metadata */
 SEC("?tc")
 __failure __msg("invalid mem access 'scalar'")
-- 
2.54.0

