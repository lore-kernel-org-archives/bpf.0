Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDBB413223
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086300; cv=none; b=RhgJT+rVLQx+WQcnLWt6IFUvSgw0irT4qtCCq7MTgQS10TKp42iLG7F7Qjc+62E8+QNuUrsBUB+s78WgBUOoxrPp+KKDXWDEN1vGxN72MKMsy+/d8OXLjFdWRLjsstz2XSm4TCydTaTm7C9NhCHvNhUHKdqJu8LO9G9JjMkoK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086300; c=relaxed/simple;
	bh=D55xnz6iCNzlcAtNIUtflhHmWwWcCl5kxYEfp9qFz3Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVe4ND7vLiZ3TFLaFXIKEoRrVZ5cnNoeIzBK93g10anJ49Vcn5f0uHP3VITLGaWo0YxdCZnn1DsTbtAf1Z+DmPPa7D6H2cRYwM6VlgeasbVopX1LM+e4TlD9yP6g2DU314YJ6kEuxt26QA/Dy1hNiY2Ib/CS4XdrfTxztRXpTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNmUfEgn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNmUfEgn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6SVQf1w7udqyBNohV7iJ/lPQGOtr/0Atb6cfqiNh6HY=;
	b=DNmUfEgnKCrsUmZu4Yd9yx2ZqGh1d+hmC9pNCrV268cBSQ0GlIOKBeoF1DaMJkEhKSmBcA
	YETkqhXypeUY4VqbS1YgCOeTlVMtBaOrORJCTL8zX2YnhVPZXdqeQTWidhnQNIy+dVd6Mk
	+Ub2WkODUD+Omh0sCyxLhg8oliYl7ms=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-0Tiuk0-mP-6CB8mc-3Jq8w-1; Mon,
 09 Mar 2026 15:58:12 -0400
X-MC-Unique: 0Tiuk0-mP-6CB8mc-3Jq8w-1
X-Mimecast-MFC-AGG-ID: 0Tiuk0-mP-6CB8mc-3Jq8w_1773086289
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C8951955F39;
	Mon,  9 Mar 2026 19:58:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8144830002D2;
	Mon,  9 Mar 2026 19:58:04 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v4 10/18] rtla: Add str_has_prefix() helper function
Date: Mon,  9 Mar 2026 16:46:23 -0300
Message-ID: <20260309195040.1019085-11-wander@redhat.com>
In-Reply-To: <20260309195040.1019085-1-wander@redhat.com>
References: <20260309195040.1019085-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add a str_has_prefix() helper function that tests whether a string
starts with a given prefix. This function provides a cleaner interface
for prefix matching compared to using strncmp() with strlen() directly.

The function returns a boolean value indicating whether the string
starts with the specified prefix. This helper will be used in
subsequent changes to simplify prefix matching code throughout rtla.

Also add the missing string.h include which is needed for the strlen()
and strncmp() functions used by str_has_prefix() and the existing
strncmp_static() macro.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/utils.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 3bca53ee48db6..165d6d0a0c6ab 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <stdint.h>
+#include <string.h>
 #include <time.h>
 #include <sched.h>
 #include <stdbool.h>
@@ -24,6 +25,18 @@
 /* Compare string with static string, length determined at compile time */
 #define strncmp_static(s1, s2) strncmp(s1, s2, ARRAY_SIZE(s2))
 
+/**
+ * str_has_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * Returns: true if @str starts with @prefix, false otherwise
+ */
+static inline bool str_has_prefix(const char *str, const char *prefix)
+{
+	return strncmp(str, prefix, strlen(prefix)) == 0;
+}
+
 #define container_of(ptr, type, member)({			\
 	const typeof(((type *)0)->member) *__mptr = (ptr);	\
 	(type *)((char *)__mptr - offsetof(type, member)) ; })
-- 
2.53.0

