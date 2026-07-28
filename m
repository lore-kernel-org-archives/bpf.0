Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94AF26C3BD;
	Tue, 28 Jul 2026 06:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785219999; cv=none; b=h2no4ezw+39YvQ7OPCy4MxqzWLxngBQ+ThxRxKSWSmPluVLyRQTGmMlHp5NmI0KjqLRhq37lAWptS7ub1so6Ygf2hvv0jvsBIEKzLWmYU7ttdLBawDy+zaMjYHFJCiYiymbqqBI8aUY6ykeIs9/DksWvjF/Rz7cUkBEKahFI+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785219999; c=relaxed/simple;
	bh=+duzhlG8qhxWKNgs4k0KOl8CVaDLz+MIINhnF7/MVag=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=LWWYeCHWW7qtAIPUmw7KxqIfCTr1WZ/xIxMZo9G5uIGaEE7di+eCL/YmdNaGlIWt9A+O+hx0P140jHl5T9KkXZtBicqHbYD+aJLYF8kzUzS/CXETkQpoYNUyDExotQzZY5MCit3jzuh8v0xt9VfrNtCn7USNevSKd7vpva2GNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h8QTc0ymQz560RJ;
	Tue, 28 Jul 2026 14:26:28 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 66S6QJgX046683;
	Tue, 28 Jul 2026 14:26:19 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 28 Jul 2026 14:26:21 +0800 (CST)
X-Zmail-TransId: 2afb6a684b8d202-5905f
X-Mailer: Zmail v1.0
Message-ID: <20260728142621001Ee2lrcnZpeNuxtxRES69Z@zte.com.cn>
Date: Tue, 28 Jul 2026 14:26:21 +0800 (CST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
        <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>,
        <linux-kernel@vger.kernel.org>, <leon.hwang@linux.dev>
Cc: <bpf@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGJwZi1uZXh0IHYzXSBicGY6IGxvZyBlcnJvciBjb2RlIG9uIHRyYW1wb2xpbmUgdW5saW5rIGZhaWx1cmU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 66S6QJgX046683
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 28 Jul 2026 14:26:28 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A684B94.000/4h8QTc0ymQz560RJ

From: xu xin <xu.xin16@zte.com.cn>

Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
code from bpf_trampoline_unlink_prog(). This aids debugging of race
conditions during link teardown, while keeping the warning rate limited
to avoid log flooding.

This will be very helpful for speeding up trouble-shooting of some crash
UAF due to bpf_trampoline_unlink_prog failures.

No change to unlink behavior.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
Change log
V2->v3: 
Add up the case in bpf_trampoline_multi_detach. And remove the unneeded 'if (err)'

v1->v2:
1) clean the subject name by remove 'syscall' suggested by Leon Hwang
https://lore.kernel.org/all/20a444b2-aeed-4af8-ba76-e994e2c14087@linux.dev/
2) Add up the missed case in kernel/bpf/trampoline.c:bpf_shim_tramp_link_release()

 kernel/bpf/syscall.c    |  8 +++++---
 kernel/bpf/trampoline.c | 12 ++++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6db306d23b47..52c57f8beb37 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3626,10 +3626,12 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 {
 	struct bpf_tracing_link *tr_link =
 		container_of(link, struct bpf_tracing_link, link.link);
+	int err;

-	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link.node,
-						tr_link->trampoline,
-						tr_link->tgt_prog));
+	err = bpf_trampoline_unlink_prog(&tr_link->link.node,
+					tr_link->trampoline,
+					tr_link->tgt_prog);
+	WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);

 	bpf_trampoline_put(tr_link->trampoline);

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 1a721fc4bef5..a34ddb97ff6b 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -997,12 +997,15 @@ static void bpf_shim_tramp_link_release(struct bpf_link *link)
 {
 	struct bpf_shim_tramp_link *shim_link =
 		container_of(link, struct bpf_shim_tramp_link, link.link);
+	int err;

 	/* paired with 'shim_link->trampoline = tr' in bpf_trampoline_link_cgroup_shim */
 	if (!shim_link->trampoline)
 		return;

-	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link.node, shim_link->trampoline, NULL));
+	err = bpf_trampoline_unlink_prog(&shim_link->link.node, shim_link->trampoline, NULL);
+	WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);
+
 	bpf_trampoline_put(shim_link->trampoline);
 }

@@ -1712,15 +1715,16 @@ int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_
 {
 	struct bpf_tracing_multi_data *data = &link->data;
 	struct bpf_tracing_multi_node *mnode;
-	int i;
+	int i, err;

 	trampoline_lock_all();

 	for_each_mnode(mnode, link) {
 		data->entry = &mnode->entry;
 		bpf_trampoline_multi_attach_init(mnode->trampoline);
-		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,
-					NULL, &trampoline_multi_ops, data));
+		err = __bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,NULL,
+					&trampoline_multi_ops, data);
+		WARN_ONCE(err, "__bpf_trampoline_unlink_prog returns error: %d\n", err);
 	}

 	if (ftrace_hash_count(data->unreg))
-- 
2.25.1
