Received: from mail-pz2-f18.google.com (mail-pz2-f18.google.com [74.125.228.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FE3C7E19
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535329; cv=none; b=ljwZ+iHw6P+3sZW2x1dyOX+Z+allhjtnn+afhSPs/BgcI9jcG5c/OkrvkEvtY6vTCfMZb/157GoXWpjLz6W416m5QQ+4jA2PdyRRV6Dcbif2bIXEuHZXIK3Ue0omJdCmAJL9tQemtL/mK+ih5usTMUZiRG1Qn/sozYMR5gjk29o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535329; c=relaxed/simple;
	bh=K1kPVhalzK2p/Oi/++MfwlZAsChdgNM2Rym6IJuVlIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0nsUJzYLcAdgw9O6OQUzJvTxBOiyWvNQLIcx1WhsFEuiXJzf0uX3z+8l8Rr5vgHGzJ4hrlFHK54bUaEXX7qS1+c3MMVyWjPnqJ8TqYxjZf3tMcLpvfICKUTfqqbkj6VfKjuBxWMWxhm16S7ckbm06jTPbfTAU8MP2m0NI8zPS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=s7BOZvaa; arc=none smtp.client-ip=74.125.228.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="s7BOZvaa"
Received: by mail-pz2-f18.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso436155a12.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535327; x=1790140127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqY05vLt4ODQV/QJgRg1j8e1nKXlf81O3e+mqZS/iH0=;
        b=s7BOZvaaWPgRgzIxpJJKvLJ9ptNlb0HDNMJimeba6DKvpNTCeOlypD+6Zpy9K0kJTq
         /lnq2hve3Eg6oJjFOKO/eQMV3pXIViXY5uyYou5jLVwBGtwz+RPk3sscJeIpSqhxSXG4
         b+WD1n4VOvrXXrVAOoR+oVhdmnJHcscjPjG8AMhChwSRPzQUijKyKBO53IsekUSSSfHv
         ndXnPms3xK97sui4lHfY7DZdPtF1oHrS9NyjubLtHObf71JEuAfN5oiOiU35Pt2sytek
         XpnXBPTTuBtfRFX3mGBE6RhMzm+97p20FbwMjhWZHLSU18g8Opg1c42AIY0LmgT8JBXj
         QK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535327; x=1790140127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iqY05vLt4ODQV/QJgRg1j8e1nKXlf81O3e+mqZS/iH0=;
        b=qN7Mhkuxi+EqLKqUHrD/TTaR5Moe6gwuENnhATBsEdSE66+wKMf7GzhqEIUPYgSul7
         MAJoTQiUHKLLNj/11gfa7marIsZgie0rjAuY9Vhb4CGjinpzaTDAOYGwhWh6oqBGTT31
         EhqJdbfTB9fw0Sp/zY9hQyAe3Nf5TLPHaM56ut0NzCDkzIZ8zkSc3N65YJt09FZN1Y9P
         hmrlq9AzQothKNcNbP72TUK54/QAhZCjGzRz5Y/3ohd4MTmuC99orJ19PYW/L3joMWKT
         f+YCanZP6TFMRF6Iedd6Hctto7BAcqFbLQ2DUih0z+hjXxTEBs5qFFjFI9l4IGZvPbSl
         fwIg==
X-Gm-Message-State: AFuF++k+2lgq3Mix8XFho1zIlSl8IvynxU2XQtLtAgHW0UWBqq0dI+MY
	cHa3c5MbsW8ZG41JRDbmVPVFjHoigkHgAj3Yu+dSzN3aF3uOc3mqEZ/saNmMgx1HwXkzsjsRWqu
	/48SQrGs=
X-Gm-Gg: AYBFou0/jiaNWfLrHhq8Eev7lg4uZ+R4n8QuKfrGPgeboWeOp8WEVfAGmy9Y/42NJ4s
	J3HnKZgsOk5y+wIYLeTrjPc+oSRqHVsr+AzBoQx1ZDXxUynJzCu8CAqzJS+g9VEWaVzBImGvFO+
	1bfBp9ef48/euQVKJNkR2opfLBNFdVbMVicnDgjNYkSpyj8KBh/O/SC+TtYzYR1Av2x5yKNFLxo
	jeqpBksOxfpxHHJsSYkTZnk/L6TLRaNsmVGOhm9QkDpztuTQXdjmdfLejZz0zy6748nKJwUHiWl
	ZZtXu4refRhKAuxJek6Q8OeiAOsR337UXkF/vxC/23WmEFht1M3El2gjun1PMjRs8OTmuE+P55n
	8UEtrHmg30tqj+DLWblequ8OsVI+7k3ti008bkxjPpmEMHyaVZ6Jrj/P28VEtMXbNyubusF5mrx
	JvEdY6ZSYLto6gXvbcLiJo5oJlSM4mOkQtfjJLvkiqZET+nQmHyve29ZDHk5xQSUqAqRPhT6AbO
	mcplq0QTuJPMn3dtHZeAGB+V2VGiZcjN9igow==
X-Received: by 2002:a17:90b:5386:b0:39b:3510:49e7 with SMTP id 98e67ed59e1d1-39e1df52290mr3493225a91.0.1789535327077;
        Tue, 15 Sep 2026 22:08:47 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:46 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 11/11] selftests/bpf: Test dynptr slice invalidation on skb clobber
Date: Wed, 16 Sep 2026 05:08:29 +0000
Message-ID: <20260916050830.8774-12-emil@etsalapatis.com>
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

