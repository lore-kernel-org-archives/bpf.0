Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6F410D39
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 19:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086244; cv=none; b=RrJnv261XRAZoVTEqerUSvDXeX3jWyu8JTvLI4OhXOfla0f+qgN0+Jm+sx0xqj4PFOfQ7ZcPATMraXPtfK5U3BvV7sIvEL3MfUxp+uUiWPSKqwhvvwYOvmq7UvoQp3RuHjAn/v+SQBb6snmxWrIp/RiVfNbKsgDCpmlpegdaUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086244; c=relaxed/simple;
	bh=btxZKa/ZF+FWQ1F9StO/KQu0/ANaWv/d8okUmro8HBo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdEB7eWq1BZ59cCcvOxkkz+GXwNtIh+QwETtFy3iMZu2Lexh32c5GDp8glAjlph1TBVXz+WHEw5VpggDK7CSKi2z834ceh7t7w9c2ypTSDdKML9Y9OqNBGdCUvpvMxYbHiRD4KNz0u3B2UJEprzAXE5uNvPQH111bvEzLpnXYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SW7JdSth; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SW7JdSth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKqkD0BRcCdfj2et6xwtVPHO1K/uJzDn0VKBiZVdBto=;
	b=SW7JdSthR8Heis/Qq5e5t/aAJaLMJ1BoI+oPv86zuLsMykyGAzqlIEOKFQfbOGeNMNxC4e
	9H9jmki0e/LmJQR3UzTauT/+RdWCyXMDj7MM4MLTbjIkEpI28QozWOTo1pB4VXWpxcx+iZ
	Q3f3vIPoWb/jI31kEZECdKWmk/nPC8s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-rbHQ1U5wNWqOgdFOfCAIiA-1; Mon,
 09 Mar 2026 15:57:18 -0400
X-MC-Unique: rbHQ1U5wNWqOgdFOfCAIiA-1
X-Mimecast-MFC-AGG-ID: rbHQ1U5wNWqOgdFOfCAIiA_1773086235
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D9F81956055;
	Mon,  9 Mar 2026 19:57:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B015B3002D0D;
	Mon,  9 Mar 2026 19:57:10 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v4 07/18] rtla: Add strscpy() and replace strncpy() calls
Date: Mon,  9 Mar 2026 16:46:20 -0300
Message-ID: <20260309195040.1019085-8-wander@redhat.com>
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

Introduce a userspace strscpy() implementation that matches the Linux
kernel's strscpy() semantics. The function is built on top of glibc's
strlcpy() and provides guaranteed NUL-termination along with proper
truncation detection through its return value.

The previous strncpy() calls had potential issues: strncpy() does not
guarantee NUL-termination when the source string length equals or
exceeds the destination buffer size. This required defensive patterns
like pre-zeroing buffers or manually setting the last byte to NUL.
The new strscpy() function always NUL-terminates the destination buffer
unless the size is zero, and returns -E2BIG on truncation, making error
handling cleaner and more consistent with kernel code.

Note that unlike the kernel's strscpy(), this implementation uses
strlcpy() internally, which reads the entire source string to determine
its length. The kernel avoids this to prevent potential DoS attacks from
extremely long untrusted strings. This is harmless for a userspace CLI
tool like rtla where input sources are bounded and trusted.

Replace all strncpy() calls in rtla with strscpy(), using sizeof() for
buffer sizes instead of magic constants to ensure the sizes stay in
sync with the actual buffer declarations. Also remove a now-redundant
memset() call that was previously needed to work around strncpy()
behavior.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/timerlat_aa.c |  6 ++---
 tools/tracing/rtla/src/utils.c       | 34 ++++++++++++++++++++++++++--
 tools/tracing/rtla/src/utils.h       |  1 +
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 31e66ea2b144c..30ef56d644f9c 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -455,9 +455,9 @@ static int timerlat_aa_thread_handler(struct trace_seq *s, struct tep_record *re
 		taa_data->thread_blocking_duration = duration;
 
 		if (comm)
-			strncpy(taa_data->run_thread_comm, comm, MAX_COMM);
+			strscpy(taa_data->run_thread_comm, comm, sizeof(taa_data->run_thread_comm));
 		else
-			sprintf(taa_data->run_thread_comm, "<...>");
+			strscpy(taa_data->run_thread_comm, "<...>", sizeof(taa_data->run_thread_comm));
 
 	} else {
 		taa_data->thread_thread_sum += duration;
@@ -519,7 +519,7 @@ static int timerlat_aa_sched_switch_handler(struct trace_seq *s, struct tep_reco
 	tep_get_field_val(s, event, "next_pid", record, &taa_data->current_pid, 1);
 	comm = tep_get_field_raw(s, event, "next_comm", record, &val, 1);
 
-	strncpy(taa_data->current_comm, comm, MAX_COMM);
+	strscpy(taa_data->current_comm, comm, sizeof(taa_data->current_comm));
 
 	/*
 	 * If this was a kworker, clean the last kworkers that ran.
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index b5a6007b108d2..e98288e55db15 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -722,8 +722,7 @@ static const int find_mount(const char *fs, char *mp, int sizeof_mp)
 	if (!found)
 		return 0;
 
-	memset(mp, 0, sizeof_mp);
-	strncpy(mp, mount_point, sizeof_mp - 1);
+	strscpy(mp, mount_point, sizeof_mp);
 
 	debug_msg("Fs %s found at %s\n", fs, mp);
 	return 1;
@@ -1036,6 +1035,37 @@ int strtoi(const char *s, int *res)
 	return 0;
 }
 
+/**
+ * strscpy - Copy a C-string into a sized buffer
+ * @dst: Where to copy the string to
+ * @src: Where to copy the string from
+ * @count: Size of destination buffer
+ *
+ * Copy the source string @src, or as much of it as fits, into the destination
+ * @dst buffer. The destination @dst buffer is always NUL-terminated, unless
+ * it's zero-sized.
+ *
+ * This is a userspace implementation matching the kernel's strscpy() semantics,
+ * built on top of glibc's strlcpy().
+ *
+ * Returns the number of characters copied (not including the trailing NUL)
+ * or -E2BIG if @count is 0 or the copy was truncated.
+ */
+ssize_t strscpy(char *dst, const char *src, size_t count)
+{
+	size_t len;
+
+	if (count == 0)
+		return -E2BIG;
+
+	len = strlcpy(dst, src, count);
+
+	if (len >= count)
+		return -E2BIG;
+
+	return (ssize_t) len;
+}
+
 static inline void fatal_alloc(void)
 {
 	fatal("Error allocating memory\n");
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 11458676f607d..3bca53ee48db6 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -97,6 +97,7 @@ static inline int have_libcpupower_support(void) { return 0; }
 #endif /* HAVE_LIBCPUPOWER_SUPPORT */
 int auto_house_keeping(cpu_set_t *monitored_cpus);
 __attribute__((__warn_unused_result__)) int strtoi(const char *s, int *res);
+ssize_t strscpy(char *dst, const char *src, size_t count);
 
 #define ns_to_usf(x) (((double)x/1000))
 #define ns_to_per(total, part) ((part * 100) / (double)total)
-- 
2.53.0

