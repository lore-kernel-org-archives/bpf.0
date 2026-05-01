Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2563FB06F
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777652168; cv=none; b=O4Yz7/l8DZKvA4EIn9clbQKA079KMkNnIyW3EawBTwSr03XqucW3SFN1w1i45o9E0cjz8ZH2P4MOn9ohAkC0h1fzZ4a6tKKNlSGqd7vnA+EbVW4dtCDNEDbPQzoy8fVqBUodc6iykebaNx6JF5Z9SuOmSfC2VMGKu38MVS/f3k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777652168; c=relaxed/simple;
	bh=qLPcmMpCv13oX166+RVfXYyfmhdBuFM6ixJMcIaG54Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogHANRxtzDn8mayR5lwDDmKYZzX7D9Lesmod/jCuSXHRxurW3rA+4W86jSC42ZM9nWWUl76z9XJGxpw/xcjyKq3xWgC+q/ViwLqcaAPHIt7fge6hHTIkdAvZq3+5X6yn9IGByUBzG4tdpB/Dj08lZ361J7vRqfVkMptDhoQLV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
From: Florian Lehner <dev@der-flo.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	sdf@fomichev.me,
	sun.jian.kdev@gmail.com,
	Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf-next 1/2 v3] bpf: Add LINK_DETACH support for perf link
Date: Fri,  1 May 2026 18:09:00 +0200
Message-ID: <20260501160901.224134-2-dev@der-flo.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501160901.224134-1-dev@der-flo.net>
References: <20260501160901.224134-1-dev@der-flo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the .detach operation for bpf_perf_link, allowing BPF_LINK_DETACH
to release the perf event without destroying the link object. This mirrors
the existing behavior for xdp and cgroup links.

Introduce bpf_perf_link_mutext to guard perf_file against concurrent access
from BPF_OBJ_GET_INFO_BY_FD and /proc fdinfo: the detach path NULLs out
perf_file under the lock, while fill_link_info and show_fdinfo take a
get_file() reference under the same lock before dereferencing it.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 kernel/bpf/syscall.c | 87 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3b1f0ba02f61..efd759970e10 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3880,13 +3880,35 @@ struct bpf_perf_link {
 	struct file *perf_file;
 };
 
+/* Serializes bpf_perf_link_release() against bpf_perf_link_fill_link_info()
+ * and bpf_perf_link_show_fdinfo() to prevent a use-after-free on perf_file
+ * when BPF_LINK_DETACH races with BPF_OBJ_GET_INFO_BY_FD or /proc fdinfo.
+ */
+static DEFINE_MUTEX(bpf_perf_link_mutex);
+
 static void bpf_perf_link_release(struct bpf_link *link)
 {
 	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
-	struct perf_event *event = perf_link->perf_file->private_data;
+	struct perf_event *event;
+	struct file *perf_file;
+
+	mutex_lock(&bpf_perf_link_mutex);
+	perf_file = perf_link->perf_file;
+	perf_link->perf_file = NULL;
+	mutex_unlock(&bpf_perf_link_mutex);
 
+	if (!perf_file)
+		return;
+
+	event = perf_file->private_data;
 	perf_event_free_bpf_prog(event);
-	fput(perf_link->perf_file);
+	fput(perf_file);
+}
+
+static int bpf_perf_link_detach(struct bpf_link *link)
+{
+	bpf_perf_link_release(link);
+	return 0;
 }
 
 static void bpf_perf_link_dealloc(struct bpf_link *link)
@@ -4095,22 +4117,42 @@ static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
 {
 	struct bpf_perf_link *perf_link;
 	const struct perf_event *event;
+	struct file *perf_file;
+	int ret;
 
 	perf_link = container_of(link, struct bpf_perf_link, link);
-	event = perf_get_event(perf_link->perf_file);
-	if (IS_ERR(event))
+
+	mutex_lock(&bpf_perf_link_mutex);
+	perf_file = perf_link->perf_file;
+	if (perf_file)
+		get_file(perf_file);
+	mutex_unlock(&bpf_perf_link_mutex);
+
+	if (!perf_file)
+		return 0;
+
+	event = perf_get_event(perf_file);
+	if (IS_ERR(event)) {
+		fput(perf_file);
 		return PTR_ERR(event);
+	}
 
 	switch (event->prog->type) {
 	case BPF_PROG_TYPE_PERF_EVENT:
-		return bpf_perf_link_fill_perf_event(event, info);
+		ret = bpf_perf_link_fill_perf_event(event, info);
+		break;
 	case BPF_PROG_TYPE_TRACEPOINT:
-		return bpf_perf_link_fill_tracepoint(event, info);
+		ret = bpf_perf_link_fill_tracepoint(event, info);
+		break;
 	case BPF_PROG_TYPE_KPROBE:
-		return bpf_perf_link_fill_probe(event, info);
+		ret = bpf_perf_link_fill_probe(event, info);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
 	}
+
+	fput(perf_file);
+	return ret;
 }
 
 static void bpf_perf_event_link_show_fdinfo(const struct perf_event *event,
@@ -4163,26 +4205,43 @@ static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
 {
 	struct bpf_perf_link *perf_link;
 	const struct perf_event *event;
+	struct file *perf_file;
 
 	perf_link = container_of(link, struct bpf_perf_link, link);
-	event = perf_get_event(perf_link->perf_file);
-	if (IS_ERR(event))
+
+	mutex_lock(&bpf_perf_link_mutex);
+	perf_file = perf_link->perf_file;
+	if (perf_file)
+		get_file(perf_file);
+	mutex_unlock(&bpf_perf_link_mutex);
+
+	if (!perf_file)
 		return;
 
+	event = perf_get_event(perf_file);
+	if (IS_ERR(event))
+		goto out;
+
 	switch (event->prog->type) {
 	case BPF_PROG_TYPE_PERF_EVENT:
-		return bpf_perf_event_link_show_fdinfo(event, seq);
+		bpf_perf_event_link_show_fdinfo(event, seq);
+		break;
 	case BPF_PROG_TYPE_TRACEPOINT:
-		return bpf_tracepoint_link_show_fdinfo(event, seq);
+		bpf_tracepoint_link_show_fdinfo(event, seq);
+		break;
 	case BPF_PROG_TYPE_KPROBE:
-		return bpf_probe_link_show_fdinfo(event, seq);
+		bpf_probe_link_show_fdinfo(event, seq);
+		break;
 	default:
-		return;
+		break;
 	}
+out:
+	fput(perf_file);
 }
 
 static const struct bpf_link_ops bpf_perf_link_lops = {
 	.release = bpf_perf_link_release,
+	.detach = bpf_perf_link_detach,
 	.dealloc = bpf_perf_link_dealloc,
 	.fill_link_info = bpf_perf_link_fill_link_info,
 	.show_fdinfo = bpf_perf_link_show_fdinfo,
-- 
2.53.0

