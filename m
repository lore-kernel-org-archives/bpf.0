Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84C36A8D2
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771269479; cv=none; b=ncojGol929GE14zpPKwikTKYKJXYFE69ym+xEpvnZcqF1QhoNtYzs47bgobGwavIkLQOVXJEJRtykEi1x8/NxghGXuAyaVNrjRiyCIopq0z7t5zbNPoAdpL/QZFHKBQ5DAz/7SdUWv0CeHaVAPE9ERdMqYO9SR2yPz5PIhswszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771269479; c=relaxed/simple;
	bh=8S4cMZd4isVfPVJJx2O03SJisc+XHnxLC6cvO+h38yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yt+ORV/dukk+bpPOAFOfDNtOY1dmnZD+8ptThgpRAuO+5RC0fP7sNoPLtHsvbOjY2wQjPod6kOeT4K6SYJNtva5fGEjTOlsUMCd68n4FlukObZS2/HYMZSlYYWiaCVRnWh+C3xwVBRIRXE6Z/d0ehMXzQKgxN+B9X2AMJ6LCOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FcDrFgKI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcDrFgKI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771269477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tZfq+YDHhopBp51hI3ce16ZfmgWlzFrSWLRtHdsXm28=;
	b=FcDrFgKIRxPxvyriQVRaI+4MKw5IzaM7gs9z0lIC6PlYfnSkezYWPGypdYyrlH75qIi6KA
	SO3XhMpr4X5XbTLvr/ToWqbLUmqptCw5s+mCOYDLMT8tVAp0MTH76mZFTK6Uk6Zoo7TYMA
	oO/xm9//3Ebt6M8s/Td9l19xDcA827I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-VpBFPegvPQep5UXockU2UQ-1; Mon,
 16 Feb 2026 14:17:54 -0500
X-MC-Unique: VpBFPegvPQep5UXockU2UQ-1
X-Mimecast-MFC-AGG-ID: VpBFPegvPQep5UXockU2UQ_1771269472
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FCF21800473;
	Mon, 16 Feb 2026 19:17:52 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.65.177])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B49B51955F43;
	Mon, 16 Feb 2026 19:17:48 +0000 (UTC)
From: Gregory Bell <grbell@redhat.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	Gregory Bell <grbell@redhat.com>
Subject: [PATCH bpf-next 1/2] selftests/bpf: fix flaky build_id test
Date: Mon, 16 Feb 2026 14:17:23 -0500
Message-ID: <885ba23ec2bb641329efdd179a12bca14818384a.1771267122.git.grbell@redhat.com>
In-Reply-To: <cover.1771267122.git.grbell@redhat.com>
References: <cover.1771267122.git.grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The build_id selftest occasionally fails because MADV_PAGEOUT
does not guarantee the immediate eviction of the page. The test
assumes eviction happens and proceeds without verifying
that the page was actually reclaimed, leading to false test
failures.

Fix the test by retrying the page-out sequence until eviction
is successful, instead of relying on a single MADV_PAGEOUT attempt.

Signed-off-by: Gregory Bell <grbell@redhat.com>
---
 tools/testing/selftests/bpf/uprobe_multi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
index dd38dc68f635..ba0a9dcc7b1a 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -100,6 +100,9 @@ int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
 	int page_sz = sysconf(_SC_PAGESIZE);
 	void *addr;
 
+	unsigned char vec[1];
+    int poll = 0;
+
 	/* page-align build ID start */
 	addr = (void *)((uintptr_t)&build_id_start & ~(page_sz - 1));
 
@@ -108,9 +111,19 @@ int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
 	 * do MADV_POPULATE_READ, and then MADV_PAGEOUT, if necessary
 	 */
 	madvise(addr, page_sz, MADV_POPULATE_READ);
-	if (!build_id_resident)
-		madvise(addr, page_sz, MADV_PAGEOUT);
-
+	if (!build_id_resident){
+        do {
+			madvise(addr, page_sz, MADV_PAGEOUT);
+			/* check if page has been evicted */
+            mincore(addr, page_sz, vec);
+            if (!(vec[0] & 1))
+                break;	
+			/* if page is still resident re-attempt MADV_POPULATE_READ/MADV_PAGEOUT */
+			madvise(addr, page_sz, MADV_POPULATE_READ);
+			poll++;
+            usleep(100);
+		}while (poll < 500);
+	}
 	(void)uprobe();
 
 	return 0;
-- 
2.52.0

