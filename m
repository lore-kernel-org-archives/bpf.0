Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25FA3368A0
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440501; cv=none; b=pL/sJgrSadrIiuBRZOGrtTHhjPWEoFCTpStIsFpxLXfx7bk6MVIsnLCyp5fx1X9TO/dDbo9yxrBPICkS+2FQqqtlVaBNZCl1iKYjM/T5EsssqEBAK3seGMi6qZXZgM7l/YL8wBfqjSsoPa31zUfnbHiXyjT7BFernxLR2h98BII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440501; c=relaxed/simple;
	bh=s5DB/I0mfyUQ45ksCNJcluKPUF3IQYIiJO+AZZy7Ajs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyUBDFsP6gKBGxEgP+xlZQ5/fHkI3xVZ/3Uu2ckf7RX5F5hCePh3YqLBFNeim4FP4/t/Fq77LmKddZeG3rdW7jU6C8wJqpbeoydd1kYwCR3QdQNDE2Zlm0TNWQc8ySsNLr7VDA7IL+xdyoXsiPWYFlWAf/TAw3LHgp9RI14ZkUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hsx0SlpP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hsx0SlpP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776440499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozvQ55aYYwLpDlUISqr0DF+ACpbB6F3Zt4Driw0l/cA=;
	b=Hsx0SlpPf00t17JQofd9LXKwg3Bo2PzqXmxBIr+y47tbgJwn2ynuOfgHdOt1vICJTd+2aV
	GCKZ2IUopgBy3FPE5XE0lppCCLtvuC0V8p6a0abwoOJKwR7VenTHlonlBqzv2PXZHwbYrM
	45iStA/X+bunwvHgklJlFdPsMe5dUnw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-7jfcO6j5PhSugCX4UDFYNg-1; Fri,
 17 Apr 2026 11:41:34 -0400
X-MC-Unique: 7jfcO6j5PhSugCX4UDFYNg-1
X-Mimecast-MFC-AGG-ID: 7jfcO6j5PhSugCX4UDFYNg_1776440492
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A09F19560A3;
	Fri, 17 Apr 2026 15:41:32 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.88.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44C2D195608E;
	Fri, 17 Apr 2026 15:41:29 +0000 (UTC)
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
Subject: [PATCH v2 1/2] selftests/bpf: Use local type for flow_offload_tuple_rhash in xdp_flowtable
Date: Fri, 17 Apr 2026 11:41:21 -0400
Message-ID: <20260417154122.2558890-2-grbell@redhat.com>
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

Define flow_offload_tuple_rhash___local and use it in place of the
forward-declared kernel type for the bpf_xdp_flow_lookup kfunc return
type and tuplehash variable. This is consistent with how
bpf_flowtable_opts___local is already handled in the same file and
avoids relying on a forward declaration of the struct.

Fixes: eeb23b54e447 ("selftests/bpf: fix compilation failure when CONFIG_NF_FLOW_TABLE=m")
Signed-off-by: Gregory Bell <grbell@redhat.com>
---
 tools/testing/selftests/bpf/progs/xdp_flowtable.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_flowtable.c b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
index 7fdc7b23ee74..e67daa02749d 100644
--- a/tools/testing/selftests/bpf/progs/xdp_flowtable.c
+++ b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
@@ -15,7 +15,10 @@ struct bpf_flowtable_opts___local {
 	s32 error;
 };
 
-struct flow_offload_tuple_rhash *
+struct flow_offload_tuple_rhash___local {
+};
+
+struct flow_offload_tuple_rhash___local *
 bpf_xdp_flow_lookup(struct xdp_md *, struct bpf_fib_lookup *,
 		    struct bpf_flowtable_opts___local *, u32) __ksym;
 
@@ -67,7 +70,7 @@ int xdp_flowtable_do_lookup(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
 	struct bpf_flowtable_opts___local opts = {};
-	struct flow_offload_tuple_rhash *tuplehash;
+	struct flow_offload_tuple_rhash___local *tuplehash;
 	struct bpf_fib_lookup tuple = {
 		.ifindex = ctx->ingress_ifindex,
 	};
-- 
2.52.0

