Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0E31194C
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167267; cv=none; b=tSABNoo7Kc3M7wvkaJUb3Z5Y+LRcBmunHzSiouaZCMMNHDRSHuxx4pQ0yfzPqjCVHZegqr8SgswgBYGTuuRzPFsrZX3B/JJU9p8FHb1u4nVCSjchatfCBYGHVew11KXlTnD8Ov8iRP6EBgS7/FTSsFitADVZNbQAooxM/p5kfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167267; c=relaxed/simple;
	bh=9r5M4rIj4+hF+KtfQqrO2x8G++VULgRCMeD1ZgM3wHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koHqEks9e0wySdh8Eyvaabvp6Yegbu158cCav+FRMj256qGTuyCDgiZLLldWqG9PYhXZH7mRQsF4VAa4JVrZYO/MzzEGmkcAHPfKi/WB1vp1JUUApEOhMmcIxIhRhWkNTB7JZ4CJ5JjO9n7R0gm8N9/ynBM3r+QtsdDzy16QEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+tVJ5IC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+tVJ5IC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KV/Vux23DHgPSLGlb27mR1UC4IHDhvUez5agcR2b54Q=;
	b=i+tVJ5ICpeaKSDjNK6GUE3vI+UC5sedQRzSZp6D9ESne7V2vNTqbwPjA/XcAoRXK5yoCeg
	2H/jFro49VbnBk000eEPpQuKtoat17GGrHYvCSHgb1zPFd7VslWIsATcH6DLDGcoMmqc64
	jjZ/U1XV9LT3pMcq+yMNHpe7s/VLsOw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-Ia3uqnTqOHilvwHzV_fL7w-1; Mon,
 31 Aug 2026 05:07:37 -0400
X-MC-Unique: Ia3uqnTqOHilvwHzV_fL7w-1
X-Mimecast-MFC-AGG-ID: Ia3uqnTqOHilvwHzV_fL7w_1788167256
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77E6F1977536;
	Mon, 31 Aug 2026 09:07:36 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84EFD18005BB;
	Mon, 31 Aug 2026 09:07:33 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 10/20] tools/build: Add a feature test for bpftool-btf
Date: Mon, 31 Aug 2026 11:05:14 +0200
Message-ID: <20260831090524.106845-11-gmonaco@redhat.com>
In-Reply-To: <20260831090524.106845-1-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

RV can run bpf monitors and also build them, only the latter requires
the vmlinux.h from bpftool btf.

Add a feature so that RV can be built with BPF support without having to
build in-tree BPF monitors if not supported on the system.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/build/Makefile.feature | 1 +
 tools/build/feature/Makefile | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 99eb0ea09537..18e3a7ae893a 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -129,6 +129,7 @@ FEATURE_TESTS_EXTRA :=                  \
          libdebuginfod			\
          clang-bpf-co-re		\
          bpftool-skeletons		\
+         bpftool-btf			\
          libunwind			\
          libunwind-debug-frame		\
          $(foreach arch,$(LIBUNWIND_ARCHS),libunwind-$(arch) libunwind-debug-frame-$(arch))
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7d165018116a..2f01203dda5c 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -71,7 +71,8 @@ FILES=                                          \
          test-libpfm4.bin			\
          test-rust.bin				\
          test-libopenssl.bin			\
-         test-bpftool-skeletons.bin
+         test-bpftool-skeletons.bin		\
+         test-bpftool-btf.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -383,6 +384,10 @@ $(OUTPUT)test-bpftool-skeletons.bin:
 	{ $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons'; } \
 		> $(@:.bin=.make.output) 2>&1 && touch $@
 
+$(OUTPUT)test-bpftool-btf.bin:
+	$(SYSTEM_BPFTOOL) btf help \
+		> $(@:.bin=.make.output) 2>&1 && touch $@
+
 # Testing Rust is special: we don't compile anything, it's enough to check the
 # compiler presence. Compiling a test code for this purposes is problematic,
 # because Rust will emit a dependency file without any external references,
-- 
2.55.0

