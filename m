Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA8241322A
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086384; cv=none; b=m3jRl3obxOk6tnnmqRjn0joaE17B8qxeK0b3owP4abi28AcE5sWN5uZiqoxiNMl/yKgAgp2Cz1vdQ05ice07l7JV3RdJ1nqxtUwbO1HwldgOtkkstLNrOAibkWP/9Cs1T8yVt3mK3nUsX5Dwjr2NVpSAprVe0W1zsWeS9j4yxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086384; c=relaxed/simple;
	bh=rtu1tt4i/a8XwxPQ4FXMd0h/cVVO2Cz/UDaEYz36bCA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcRXwgqS9sTnRXK2ViAb6+xTKgUavxCUR/psH8I/thPC9c2OSLbCYL5GC3gpF6SRKLlx/6MVtoYDSzpdd1kpvabEMhrSpEH/XNXX+PpQDbwT4GtPullSMm1gE6zLddRfvNPLyTIp/HWoCic/0EakkoPpCU+q+Z2hnnLE7UqysC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbKvezh0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbKvezh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0tExqBEcEj+gvlm5bezsauAff/U94N8v0OpOCuynP4=;
	b=VbKvezh0VWgPUGFylrvqT/p+yub4nj8x8c9d700grPtQSlIre8dHTlYq5eSvOETiNbTPDe
	J5YJPmCke6TzjOSeFec49tPvjg25JVpytTmZ2VsRs/wTwOMw2seLxqzj7bR38EJ6PnYTp9
	aTYnYc88YJP4rFaFTd4dRk3zY2RjeZg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-NS7Q77lfOQ6Eu90_ywBMyw-1; Mon,
 09 Mar 2026 15:59:38 -0400
X-MC-Unique: NS7Q77lfOQ6Eu90_ywBMyw-1
X-Mimecast-MFC-AGG-ID: NS7Q77lfOQ6Eu90_ywBMyw_1773086377
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09B1F1956066;
	Mon,  9 Mar 2026 19:59:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4032B30001A2;
	Mon,  9 Mar 2026 19:59:31 +0000 (UTC)
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
Subject: [PATCH v4 15/18] rtla/trace: Fix write loop in trace_event_save_hist()
Date: Mon,  9 Mar 2026 16:46:28 -0300
Message-ID: <20260309195040.1019085-16-wander@redhat.com>
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

The write loop in trace_event_save_hist() does not correctly handle
errors from the write() system call. If write() returns -1, this value
is added to the loop index, leading to an incorrect memory access on
the next iteration and potentially an infinite loop. The loop also
fails to handle EINTR.

Fix the write loop by introducing proper error handling. The return
value of write() is now stored in a ssize_t variable and checked for
errors. The loop retries the call if interrupted by a signal and breaks
on any other error after logging it with strerror().

Additionally, change the index variable type from int to size_t to
match the type used for buffer sizes and by strlen(), improving type
safety.

Fixes: 761916fd02c2 ("rtla/trace: Save event histogram output to a file")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/trace.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index ed7db5f4115ce..fed3362527b08 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -342,11 +342,11 @@ static void trace_event_disable_filter(struct trace_instance *instance,
 static void trace_event_save_hist(struct trace_instance *instance,
 				  struct trace_events *tevent)
 {
-	int index, out_fd;
+	size_t index, hist_len;
 	mode_t mode = 0644;
 	char path[MAX_PATH];
 	char *hist;
-	size_t hist_len;
+	int out_fd;
 
 	if (!tevent)
 		return;
@@ -378,7 +378,15 @@ static void trace_event_save_hist(struct trace_instance *instance,
 	index = 0;
 	hist_len = strlen(hist);
 	do {
-		index += write(out_fd, &hist[index], hist_len - index);
+		const ssize_t written = write(out_fd, &hist[index], hist_len - index);
+
+		if (written < 0) {
+			if (errno == EINTR)
+				continue;
+			err_msg("  Error writing hist file: %s\n", strerror(errno));
+			break;
+		}
+		index += written;
 	} while (index < hist_len);
 
 	free(hist);
-- 
2.53.0

