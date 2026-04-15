Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615BE29D288
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776283246; cv=none; b=Gd+YjE9kOQ7JPN5QnEsaWQ6d3Xur1ymDcC4K7nNi0rTXFb0n6wLbRT8gU04h3K7FjGI4epVZGtXNFm2UFu1yod09rZgY42ZrLXiFwCytuINxjdYmNhx2O4szk8ud8XlwCdQxs864Ovrmx3ejkLGJYWH37JhPGv5+9UOvrOiO4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776283246; c=relaxed/simple;
	bh=VingE3z2/JrbcWRMIUQafD2hvAWqVw1ne/xNOQlvf2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAP/kAJiS4GoR/yrSItSDz2gRfOx9cY1sO2T/G98p9W1HpdpDbrLgyBKv7U/mCHCbRhMSkEh+T+4u/RmRbifcMOs3NLNyo98Y7mhYVehcAQDtcznZk3U0WXZOOwHQ4Hbi00ihbkcZ1dAiLO5Ha2U+H2mZUksRBf7EwP39zIQRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCDRBX8z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCDRBX8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776283244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvX26OMbKxfDvkOdNzH/J3ynx06A90edix2CwvcDeis=;
	b=KCDRBX8zVsJSaOVxoOdER5BPOl+8V2fE+Sx2B76JJpluYVI1wVkwv6nEPKTw4liA1Isc3r
	evQXCp5NT8o6qSC8Gn2EnmxKIj+xzdVUXjszf3uYNfpqA/iCGFP/UT9F4Ip98T3Pq1gnae
	+UALp7Y4L9IE2ojG105cHMsx8sv8XUo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-QNOZjMsTPFeIVq-6tDiHSw-1; Wed,
 15 Apr 2026 16:00:38 -0400
X-MC-Unique: QNOZjMsTPFeIVq-6tDiHSw-1
X-Mimecast-MFC-AGG-ID: QNOZjMsTPFeIVq-6tDiHSw_1776283235
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C1651955DE3;
	Wed, 15 Apr 2026 20:00:35 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.88.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 525C51800446;
	Wed, 15 Apr 2026 20:00:31 +0000 (UTC)
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
Subject: [PATCH bpf-next 1/2] selftests/bpf: Use local type for flow_offload_tuple_rhash in xdp_flowtable
Date: Wed, 15 Apr 2026 16:00:13 -0400
Message-ID: <f6f80e1f34489ef0f3c47601e9d752da0d0259e5.1776280396.git.grbell@redhat.com>
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

Define flow_offload_tuple_rhash___local and use it in place of the
forward-declared kernel type for the bpf_xdp_flow_lookup kfunc return
type and tuplehash variable. This is consistent with how
bpf_flowtable_opts___local is already handled in the same file and
avoids relying on a forward declaration of the struct.

Fixes: eeb23b5 ("selftests/bpf: fix compilation failure when CONFIG_NF_FLOW_TABLE=m")
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

