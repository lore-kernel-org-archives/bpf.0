Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75529D288
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776283255; cv=none; b=bXTGtW5gGa37g51k7dHqTWpATKbiyMpXKjJ/7+jAtzrQBH68ylHO/Bo76kQUyuXEoDrhUwKJL6feaLtzHZlibmxPAcVei7+v1Fyiu65g8G/d1YX2O90RCGsi+rtNtDKlVVr0ilgATz1/8fJXryGof5GDwvVfHXIZGJpXjE425O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776283255; c=relaxed/simple;
	bh=5Si8SFkPlQbj4ZK/Nv7vKd6bP9Wbmf0ulJ+tfMLqY+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6o6gnTDvViH6eHIZKcvtSon3U6KdcqXZ7QbfC6Pne2Id3YFGnbgUML3M0V6I0Qam5TcSyY9RClZQRam5pz5CiBqGLxBBUmnguOMvyfADxBuCseMkgYsZOAllHNFTwDl5DiA+bDPr6X1SXHj4nGfOeW+sqjp+eqyvAqO7Bbzikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ef26ViPs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ef26ViPs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776283253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrx/maKRkin5kg0qAPTHBpet2FFANooNBkjHVIfFRwc=;
	b=Ef26ViPseq8hYVOGvQtEhFaCk7EL7x0RlN1DeDlRwKgGTNI5BKSAi2miqmX4YsBPCEqZTb
	dAM8ttgw3DkrMMXz5i3lhq3dLc7b04lce1WK7NHZoMqwvX8Dd9cEIVx0IVo5X1o0CqPPQb
	8DcZzZ5FK7QB91odnU0imAXQ3Uu8iBA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-ePna1xj0NpCInMiWySBo9w-1; Wed,
 15 Apr 2026 16:00:49 -0400
X-MC-Unique: ePna1xj0NpCInMiWySBo9w-1
X-Mimecast-MFC-AGG-ID: ePna1xj0NpCInMiWySBo9w_1776283241
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BEAC1956048;
	Wed, 15 Apr 2026 20:00:41 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.88.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 493B61800446;
	Wed, 15 Apr 2026 20:00:37 +0000 (UTC)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Use local type for bpf_fou_encap in test_tunnel_kern
Date: Wed, 15 Apr 2026 16:00:14 -0400
Message-ID: <4cc7a73bd36f3611150cbc3a45cf9732a2dc8f6d.1776280396.git.grbell@redhat.com>
In-Reply-To: <cover.1776280396.git.grbell@redhat.com>
References: <cover.1776280396.git.grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Replace the forward-declared struct bpf_fou_encap with the existing
bpf_fou_encap___local type in the bpf_skb_set_fou_encap and
bpf_skb_get_fou_encap declarations. This removes the need for
the forward declaration and the explicit casts at each call.

Fixes: d17f9b3 ("selftests/bpf: Fix compilation failure when CONFIG_NET_FOU!=y")
Signed-off-by: Gregory Bell <grbell@redhat.com>
---
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 32127f1cd687..80ed5e8f2b06 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -36,12 +36,10 @@ enum bpf_fou_encap_type___local {
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
@@ -781,7 +779,7 @@ int ipip_gue_set_tunnel(struct __sk_buff *skb)
 	encap.sport = 0;
 	encap.dport = bpf_htons(5555);
 
-	ret = bpf_skb_set_fou_encap(skb, (struct bpf_fou_encap *)&encap,
+	ret = bpf_skb_set_fou_encap(skb, &encap,
 				    bpf_core_enum_value(enum bpf_fou_encap_type___local,
 							FOU_BPF_ENCAP_GUE___local));
 	if (ret < 0) {
@@ -820,7 +818,7 @@ int ipip_fou_set_tunnel(struct __sk_buff *skb)
 	encap.sport = 0;
 	encap.dport = bpf_htons(5555);
 
-	ret = bpf_skb_set_fou_encap(skb, (struct bpf_fou_encap *)&encap,
+	ret = bpf_skb_set_fou_encap(skb, &encap,
 				    FOU_BPF_ENCAP_FOU___local);
 	if (ret < 0) {
 		log_err(ret);
@@ -843,7 +841,7 @@ int ipip_encap_get_tunnel(struct __sk_buff *skb)
 		return TC_ACT_SHOT;
 	}
 
-	ret = bpf_skb_get_fou_encap(skb, (struct bpf_fou_encap *)&encap);
+	ret = bpf_skb_get_fou_encap(skb, &encap);
 	if (ret < 0) {
 		log_err(ret);
 		return TC_ACT_SHOT;
-- 
2.52.0

