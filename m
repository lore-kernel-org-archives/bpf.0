Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06EC3A8E7
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3aBuSPV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704818607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nwZE6djCSMlJ+VRm2x3lAYqf79cV0k+KDTXbOaHEb1o=;
	b=E3aBuSPVYmWgpM6dneQKNMa0LkOrRnIh4+rkGGvptd2S0tZr/81/7Jb30YzcXHuO+Wkysg
	QL5Efg44btul9wvrUUdOvaPRDAZ6+4CAjgzC7cJdt9/jzH7HIYl5oMptHqoeaVsQqaTesd
	jPCa5i5Vtsnvo673lmpwb/ZiwaBccy8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-q87lt0BTMCS_eqIMFxCJwg-1; Tue,
 09 Jan 2024 11:43:22 -0500
X-MC-Unique: q87lt0BTMCS_eqIMFxCJwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEADA1C051A0;
	Tue,  9 Jan 2024 16:43:21 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.45.224.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0E22B2026D66;
	Tue,  9 Jan 2024 16:43:19 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	jolsa@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>
Subject: [PATCH bpf-next] selftests/bpf: fix potential premature unload in bpf_testmod
Date: Tue,  9 Jan 2024 17:43:17 +0100
Message-ID: <20240109164317.16371-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

It is possible for bpf_kfunc_call_test_release() to be called from
bpf_map_free_deferred() when bpf_testmod is already unloaded and
perf_test_stuct.cnt which it tries to decrease is no longer in memory.
This patch tries to fix the issue by waiting for all references to be
dropped in bpf_testmod_exit().

The issue can be triggered by running 'test_progs -t map_kptr' in 6.5,
but is obscured in 6.6 by d119357d07435 ("rcu-tasks: Treat only
synchronous grace periods urgently").

Fixes: 65eb006d85a2a ("bpf: Move kernel test kfuncs to bpf_testmod")
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 91907b321f913..63f0dbd016703 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2020 Facebook */
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/delay.h>
 #include <linux/error-injection.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -544,6 +545,9 @@ static int bpf_testmod_init(void)
 
 static void bpf_testmod_exit(void)
 {
+	while (refcount_read(&prog_test_struct.cnt) > 1)
+		msleep(20);
+
 	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 }
 
-- 
2.43.0

