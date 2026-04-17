Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665BA314A86
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440507; cv=none; b=jkwtm5iq6qK+43UZJOHG2E4dcfXs+eNdBKCJwuvxntVWjmdKTORb/zS90kp17pg4+lsd9O46bgqFXPlqZvzdevLzQdgnm07KYoasOdflsjqhcIWfCvCMvQN8mYMDBKoELVt12Qu5aOco4ITZZZiV6CGGhWfk6hzhzgwW12rX5+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440507; c=relaxed/simple;
	bh=zIYIIpTeoXCpDtCwoT64z4VBlg+URn3YV8z0pY1m7cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuBoAKpj4HF5ZbvPMNMKiSxgB2nHk1GjmDvY08g0S2sWb0ExwusO+gd38lekVslTueyKfWOZ80fvWVChFGdjuNmOVRKHiVfQ2Rw/fgy+Ct0NxsjzX8sYIQuOCmVIJ6s8hEIpjLETW70jL6/j6TGwq2Bb1Ae+EbQCkTl1XS/uFvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c/Bt73De; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/Bt73De"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776440505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A32/d6wXLdDNQpHxCglidnJbCAc/4+6L+SM3juc18eA=;
	b=c/Bt73De1bDlEVKZrF0u3sJc93SzDHa3NpPO9OdGSAVJdgHxrFVoJyG5XlZGlVXwhtDjko
	m3AFk59HICTet/fMrJ8fbUfabIILvSVsevniMeodwKxUsGY8Hv9qxQUiwqLLj++VkAX/wY
	mQRcmNs+lJp4Z0ejmEMbBghEaWJSBkY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-1EI3d4IyMw2N-ieG8Zuvxg-1; Fri,
 17 Apr 2026 11:41:42 -0400
X-MC-Unique: 1EI3d4IyMw2N-ieG8Zuvxg-1
X-Mimecast-MFC-AGG-ID: 1EI3d4IyMw2N-ieG8Zuvxg_1776440498
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDEE919560AA;
	Fri, 17 Apr 2026 15:41:37 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.88.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 998E419560AB;
	Fri, 17 Apr 2026 15:41:35 +0000 (UTC)
From: Gregory Bell <grbell@redhat.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	alan.maguire@oracle.com,
	Gregory Bell <grbell@redhat.com>
Subject: [PATCH v2 2/2] selftests/bpf: Use local type for bpf_fou_encap in test_tunnel_kern
Date: Fri, 17 Apr 2026 11:41:22 -0400
Message-ID: <20260417154122.2558890-3-grbell@redhat.com>
In-Reply-To: <20260417154122.2558890-1-grbell@redhat.com>
References: <20260417154122.2558890-1-grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Replace the forward-declared struct bpf_fou_encap with the existing
bpf_fou_encap___local type in the bpf_skb_set_fou_encap and
bpf_skb_get_fou_encap declarations. This removes the need for
the forward declaration and the explicit casts at each call.

Fixes: d17f9b370df6 ("selftests/bpf: Fix compilation failure when CONFIG_NET_FOU!=y")
Signed-off-by: Gregory Bell <grbell@redhat.com>
---
 .../testing/selftests/bpf/progs/test_tunnel_kern.c  | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 32127f1cd687..30f1de458669 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -6,6 +6,7 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
+#define BPF_NO_KFUNC_PROTOTYPES
 #include "vmlinux.h"
 #include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
@@ -36,12 +37,10 @@ enum bpf_fou_encap_type___local {
 	FOU_BPF_ENCAP_GUE___local,
 };
 
-struct bpf_fou_encap;
-
 int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
-			  struct bpf_fou_encap *encap, int type) __ksym;
+			  struct bpf_fou_encap___local *encap, int type) __ksym;
 int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
-			  struct bpf_fou_encap *encap) __ksym;
+			  struct bpf_fou_encap___local *encap) __ksym;
 struct xfrm_state *
 bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts,
 		       u32 opts__sz) __ksym;
@@ -781,7 +780,7 @@ int ipip_gue_set_tunnel(struct __sk_buff *skb)
 	encap.sport = 0;
 	encap.dport = bpf_htons(5555);
 
-	ret = bpf_skb_set_fou_encap(skb, (struct bpf_fou_encap *)&encap,
+	ret = bpf_skb_set_fou_encap(skb, &encap,
 				    bpf_core_enum_value(enum bpf_fou_encap_type___local,
 							FOU_BPF_ENCAP_GUE___local));
 	if (ret < 0) {
@@ -820,7 +819,7 @@ int ipip_fou_set_tunnel(struct __sk_buff *skb)
 	encap.sport = 0;
 	encap.dport = bpf_htons(5555);
 
-	ret = bpf_skb_set_fou_encap(skb, (struct bpf_fou_encap *)&encap,
+	ret = bpf_skb_set_fou_encap(skb, &encap,
 				    FOU_BPF_ENCAP_FOU___local);
 	if (ret < 0) {
 		log_err(ret);
@@ -843,7 +842,7 @@ int ipip_encap_get_tunnel(struct __sk_buff *skb)
 		return TC_ACT_SHOT;
 	}
 
-	ret = bpf_skb_get_fou_encap(skb, (struct bpf_fou_encap *)&encap);
+	ret = bpf_skb_get_fou_encap(skb, &encap);
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
-- 
2.52.0

