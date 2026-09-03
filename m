Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6B4BB5DE
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446690; cv=none; b=Da7wSmKG32xPTPjD8b8g2YzY2/YUhk9zBbGh1SUYDAYr0tOOpbEHzTGlr2H4mnJx4mhvLLPrXD8S6zGL4v+b4HhUVHJ4gP9eyl3WbUaiHJVTRN4RPRcBPRvQD8PeeqVpXuLlXNA9ZKVVkf3wqKP4+ysurTFb+IFItKEir7kIUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446690; c=relaxed/simple;
	bh=JwlqSoOAk3nqv7HbVgJ72bOQTmutxW5KYmqt5YDGl5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9G8sZR+KPAFSOBRNRqJLhBsSQ2iQ1xZt3R16DYfnZJERtTpLI5+a5v/GtfHoat/F486I5G0t2yk+WuIZKIHNkdlFwCDT2Z7R56jly6UqeqBeGo5RkeGoy6xY5k9hTtllaUtRk6MyVVsQkrZ9MURnxyKywQo8bqVDUa9+ny5Kms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gu0M4GmG; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu0M4GmG"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-49cd3d0f150so7474935e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446686; x=1789051486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kry2Di9k97Ra3R0ny85TX9Hc1QxceNJua7bGBzkXDkg=;
        b=gu0M4GmGXzZyFXVbWAPbQLQ3WlAoyZ7z8MfA7FGsgqIWkTrtnr+qbPOtplHKC9AE7N
         F7ceEIrE7KHptpmOayU1ymBbFiPQf8lablxVR+qHu1fxOi7VzeUeKOwaew0SzExhayYq
         O2EE+VxteIizbQFzpugwMLgNdYscWSnbBod7rAnYOvD2QImMROPjX+1PnDo+k05q728l
         55tKYy7EQiYqKVe/u3TifNrnk2ALS5+Aow3adCR5ZmcLWP6xsHv+7hadhLXIaWCaxqCa
         uYvdO2WlBP+618oheW+Qqyd+F1X+ePeh3T56fmnHuvZLqqDAxcVP4oI48YYNv2PGYhlB
         9Djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446686; x=1789051486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kry2Di9k97Ra3R0ny85TX9Hc1QxceNJua7bGBzkXDkg=;
        b=mIWZCwG4qqjM0UYOz/bgjAwFkgfUzQUFG3pLu1/zdwtiQ3xaOuxRCTulO1yDe7QKBD
         FktBRD0vXuBegY2ME2hfjjdCJYnqMKRCZlFaiXhRDYc3b+5qRapNhSoSwWiu9AIjWW7D
         4rN6ZG99uO/1uBJgv3CZhLGOpSKTsgjPfnhscn2qJqoCcnX9RRU0a6KEaipYramLM6MR
         7sUq3DizhRNpTfHCwhbA/8rM9voU+mHiNX578sIjxjU0ijj5vmLGf/AdQHJ43P2cKU1/
         20VJQUzJAZDczbV02SUdUQ0SDRsmH5oZ0AH8kWTpZW2b1IjJ02Fwb5jwqFOXClWWs6G6
         KLFg==
X-Gm-Message-State: AFuF++nP5P+k0sX5nUvByV6d6TerqL/lPGDBM2uTppkoXyTYSkBRQ1oO
	gV4qzHEiaVFzX0kN41sVU1PyoxiqBEzeUsSNvF3wUoYtikt3dVgvXtelSmrvdWIX
X-Gm-Gg: AYBFou3jSIL1Zu1mtI0Z3+Oqvh6lqRGZU6Q1bkCzfcyn+hdFuQITV+g9gicXQ5DNreC
	hvBRepb48OQlj38kbIz+/TpVg7hLSU2KrO/JehSVd4D21+u82aqtMyKw684i5svdpLu5CR5oXqK
	ExnUmrNVf3higqq767OXJoPKArjyz2K72n1BOkY++xJcLhSU/ozF2gJ+d9qZWSBMGgSmFV6+4mX
	ukO0RPCBSHgK+nAJRPUkw/A5vXCMx2Lz2zvrLK1Nb9ul+teQ0iSiKWjcS9vKqlDJ2czic3tnfvL
	TFb9e8bYeyWkx25dyHm2k53esXPlF8RXkd860aoi4pRqt8u3QkBMKt4lwWWMBiBABE8c6YSB4qE
	izn6OxoqE6mipPB5fu3jXnxtKnTXCc7qfpHmi0TuqmoU2OnH29xfkDhZB8BuXdTcjpxSfhBq0d7
	ICfaj9hPKh8SwPgKJOUsGcajoLvhhpJ2h94xOWmXg4CRS5wPFX0pe/smV/ghqKgy1Kq+Ax6yvXL
	yEZ6lkii3y0rdO4CyClRFpM7RTlXlVTpAHrAPBwM/s1BfcMfLK0rwCHjprE44x+VaacxTxumIn4
	x0IsLSyEIfjZU9d6hCxAMj7va2w=
X-Received: by 2002:a05:6000:2609:b0:484:3a11:c431 with SMTP id ffacd0b85a97d-48488dee692mr26373125f8f.5.1788446685953;
        Thu, 03 Sep 2026 07:44:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e800cfsm13812770f8f.12.2026.09.03.07.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:44:45 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 06/10] selftests/bpf: Reject resilient unlock in rbtree callback
Date: Thu,  3 Sep 2026 16:44:24 +0200
Message-ID: <20260903144433.1716731-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144433.1716731-1-memxor@gmail.com>
References: <20260903144433.1716731-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2482; i=memxor@gmail.com; h=from:subject; bh=JwlqSoOAk3nqv7HbVgJ72bOQTmutxW5KYmqt5YDGl5c=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtm88Q1FdNmPKoSY/wuvLfReFfvGqYOW7ntWVPaChnkO DMu8SZ1lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJ8howMl1Ijf1m+DAxceOS3 00/z1bvEnxly7d519fSzQxtD+NeJyzL8Fe++z1L68EfZtVyFOzH28ksWOuxnmn1u3YxOrx36u9K eMwIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a load-only verifier regression for a resilient lock operation in an
rbtree comparison callback. The program holds the rbtree's regular spin
lock and a separate resilient lock, then releases the resilient lock from
the callback. This isolates the missing kfunc policy check without running
a concurrent tree mutation.

Release the resilient lock before the regular lock on the outer
fall-through. The broken verifier therefore accepts the balanced program,
while the fixed verifier rejects the resilient unlock specifically while
verifying the callback.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/rbtree_fail.c | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index 555379952dcc..803419a47c62 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -16,6 +16,7 @@ struct node_data {
 private(A) struct bpf_spin_lock glock;
 private(A) struct bpf_rb_root groot __contains(node_data, node);
 private(A) struct bpf_rb_root groot2 __contains(node_data, node);
+private(B) struct bpf_res_spin_lock res_glock;
 
 static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 {
@@ -265,6 +266,12 @@ static bool less__bad_fn_call_first_unlock_after(struct bpf_rb_node *a, const st
 	return node_a->key < node_b->key;
 }
 
+static bool less__bad_res_spin_unlock(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	bpf_res_spin_unlock(&res_glock);
+	return false;
+}
+
 static __always_inline
 long add_with_cb(bool (cb)(struct bpf_rb_node *a, const struct bpf_rb_node *b))
 {
@@ -301,4 +308,26 @@ long rbtree_api_add_bad_cb_bad_fn_call_first_unlock_after(void *ctx)
 	return add_with_cb(less__bad_fn_call_first_unlock_after);
 }
 
+SEC("?tc")
+__failure __msg("can't res_spin_{lock,unlock} in rbtree cb")
+long rbtree_api_add_bad_cb_res_spin_unlock(void *ctx)
+{
+	struct node_data *n;
+
+	n = bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	bpf_spin_lock(&glock);
+	if (bpf_res_spin_lock(&res_glock)) {
+		bpf_spin_unlock(&glock);
+		bpf_obj_drop(n);
+		return 1;
+	}
+	bpf_rbtree_add(&groot, &n->node, less__bad_res_spin_unlock);
+	bpf_res_spin_unlock(&res_glock);
+	bpf_spin_unlock(&glock);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

