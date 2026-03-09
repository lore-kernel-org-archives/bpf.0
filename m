Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED30413236
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086329; cv=none; b=hZLjdM1Pq7Tvyf4a0EhYd/Lppwle1lmY2hvIkaodbTNjO0scNx63ek77mWhW+XpnKZlzBTojHwizppCXfkeFa7F1ViaUhgdhiGcpDw88lQbJVrSQyOUscZjPVsMF9wkXtGWRMkzCgHNNgkqYdoxIb0dq10g7ySqxUXdT4p3J8sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086329; c=relaxed/simple;
	bh=yICs/+K8m+N7WoS/BGyIG9Js4f4mj9M5NgeglcRAmpU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+d6F663alQESTq4Fs5J0//QpCsjyrnXIdcBvJlv9p40kBAArcyzOadbLmpS6GBYpCWxwcgVowUTREK30d0TZU2hAl446tsI2tW64yNPykqvClBFDX0P1D5o/linTb033fR4ZJXHmAoZ5wNJtOx9xMZjeHFEdcGdW1PFXBTVSWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZvjY5AtZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvjY5AtZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDN3QZTwtHI1nXbBYUfifxQJOF92bURlNcvoBrY0SIg=;
	b=ZvjY5AtZYTC2HvB0DALztkEQXSG5M0UtVrkyP4Sx87zM2Eh7z8LgyKsvr6mN21wv/LUexE
	v2Ff+G2B8JDPgGL6IzsFSxIiFzxG8wFNSCBBks8ZkKu5N3ScMgG2F2+FUh8wx662oNnHgF
	33l6fbk0DQyYJi0CTRJf4elg9moH9ko=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-RLHJmjM6Md2HxbmT1vZTGw-1; Mon,
 09 Mar 2026 15:58:45 -0400
X-MC-Unique: RLHJmjM6Md2HxbmT1vZTGw-1
X-Mimecast-MFC-AGG-ID: RLHJmjM6Md2HxbmT1vZTGw_1773086324
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B2361956048;
	Mon,  9 Mar 2026 19:58:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A138430001A2;
	Mon,  9 Mar 2026 19:58:39 +0000 (UTC)
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
Subject: [PATCH v4 12/18] rtla: Enforce exact match for time unit suffixes
Date: Mon,  9 Mar 2026 16:46:25 -0300
Message-ID: <20260309195040.1019085-13-wander@redhat.com>
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

The parse_ns_duration() function currently uses prefix matching for
detecting time units. This approach is problematic as it silently
accepts malformed strings such as "100nsx" or "100us_invalid" by
ignoring the trailing characters, leading to potential configuration
errors.

Introduce a match_time_unit() helper that checks the suffix matches
exactly and is followed by either end-of-string or a ':' delimiter.
The ':' is needed because parse_ns_duration() is also called from
get_long_ns_after_colon() when parsing SCHED_DEADLINE priority
specifications in the format "d:runtime:period" (e.g., "d:10ms:100ms").

A plain strcmp() would reject valid deadline strings because the suffix
"ms" is followed by ":100ms", not end-of-string. Similarly,
strncmp_static() would fail because ARRAY_SIZE() includes the NUL
terminator, making it equivalent to strcmp() for this comparison.

The match_time_unit() helper solves both problems: it rejects malformed
input like "100msx" while correctly handling the colon-delimited
deadline format.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 486d96e8290fb..c3ed9089e7260 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -200,6 +200,21 @@ long parse_seconds_duration(char *val)
 	return t;
 }
 
+/*
+ * match_time_unit - check if str starts with unit followed by end-of-string or ':'
+ *
+ * This allows the time unit parser to work both in standalone duration strings
+ * like "100ms" and in colon-delimited SCHED_DEADLINE specifications like
+ * "d:10ms:100ms", while still rejecting malformed input like "100msx".
+ */
+static bool match_time_unit(const char *str, const char *unit)
+{
+	size_t len = strlen(unit);
+
+	return strncmp(str, unit, len) == 0 &&
+	       (str[len] == '\0' || str[len] == ':');
+}
+
 /*
  * parse_ns_duration - parse duration with ns/us/ms/s converting it to nanoseconds
  */
@@ -211,15 +226,15 @@ long parse_ns_duration(char *val)
 	t = strtol(val, &end, 10);
 
 	if (end) {
-		if (!strncmp(end, "ns", 2)) {
+		if (match_time_unit(end, "ns")) {
 			return t;
-		} else if (!strncmp(end, "us", 2)) {
+		} else if (match_time_unit(end, "us")) {
 			t *= 1000;
 			return t;
-		} else if (!strncmp(end, "ms", 2)) {
+		} else if (match_time_unit(end, "ms")) {
 			t *= 1000 * 1000;
 			return t;
-		} else if (!strncmp(end, "s", 1)) {
+		} else if (match_time_unit(end, "s")) {
 			t *= 1000 * 1000 * 1000;
 			return t;
 		}
-- 
2.53.0

