Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E962773F0
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772658758; cv=none; b=T5/ssnyOaEVdg0ECeajJWg8WXPDH9evJDp8g+KbGHGWnrlOK2jABAQmbmzInMixm27G5miuceuZwOpaIKSf+QSMHynmfoqU5A0iZnt1K0LRiv2Jaefc4fCvf3piKljQTwkYfI2gsOLturhUX2UY80uXtFf3V4LBoa2/oUsKl4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772658758; c=relaxed/simple;
	bh=ELGWHiMLoBkdN15sw9tbutNiasB3w2CAJkH4oGvBpHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5Gibr5zFA8jludx6azYFAyee3k6ONC0JYAT4TBgo8tGx2VRZA2PT4xY/3rHeyNPZCp5Clyyz3fAY2oMM9cwsZBUfDMU1Rdz6+X+21P4mnJr7RexVtoImj+ZSnqfz/OV+0xXPl3HqvbKUT2hkbZJqFVaPa8z6pyf3zUmv7WZNiI=
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
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf-next v2 1/2] bpf: Add LINK_DETACH support for perf link
Date: Wed,  4 Mar 2026 22:02:11 +0100
Message-ID: <20260304210212.235096-2-dev@der-flo.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304210212.235096-1-dev@der-flo.net>
References: <20260304210212.235096-1-dev@der-flo.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_perf_link_detach() to allow detaching a BPF program from its
perf event via BPF_LINK_DETACH while keeping the link file descriptor
alive.  This mirrors the existing behavior for xdp and cgroup links
and enables temporarily disabling uprobes or other perf event-based
programs that are attached via bpf_perf_links without closing the link.

bpf_perf_link_release() is made idempotent using xchg() so that closing
the link fd after an explicit LINK_DETACH does not call
perf_event_free_bpf_prog() a second time.  bpf_perf_link_fill_link_info()
and bpf_perf_link_show_fdinfo() gain NULL guards so that querying an
already-detached link returns an empty result rather than dereferencing
a stale pointer.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 kernel/bpf/syscall.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 274039e36465..7d567cd20a3f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3863,10 +3863,23 @@ struct bpf_perf_link {
 static void bpf_perf_link_release(struct bpf_link *link)
 {
 	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
-	struct perf_event *event = perf_link->perf_file->private_data;
+	struct perf_event *event;
+	struct file *perf_file;
+
+	/* bpf_perf_link_detach() may have already released perf_file */
+	perf_file = xchg(&perf_link->perf_file, NULL);
+	if (!perf_file)
+		return;
 
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
@@ -4075,9 +4088,13 @@ static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
 {
 	struct bpf_perf_link *perf_link;
 	const struct perf_event *event;
+	struct file *perf_file;
 
 	perf_link = container_of(link, struct bpf_perf_link, link);
-	event = perf_get_event(perf_link->perf_file);
+	perf_file = READ_ONCE(perf_link->perf_file);
+	if (!perf_file)
+		return 0;
+	event = perf_get_event(perf_file);
 	if (IS_ERR(event))
 		return PTR_ERR(event);
 
@@ -4143,9 +4160,13 @@ static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
 {
 	struct bpf_perf_link *perf_link;
 	const struct perf_event *event;
+	struct file *perf_file;
 
 	perf_link = container_of(link, struct bpf_perf_link, link);
-	event = perf_get_event(perf_link->perf_file);
+	perf_file = READ_ONCE(perf_link->perf_file);
+	if (!perf_file)
+		return;
+	event = perf_get_event(perf_file);
 	if (IS_ERR(event))
 		return;
 
@@ -4163,6 +4184,7 @@ static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
 
 static const struct bpf_link_ops bpf_perf_link_lops = {
 	.release = bpf_perf_link_release,
+	.detach = bpf_perf_link_detach,
 	.dealloc = bpf_perf_link_dealloc,
 	.fill_link_info = bpf_perf_link_fill_link_info,
 	.show_fdinfo = bpf_perf_link_show_fdinfo,
-- 
2.53.0

