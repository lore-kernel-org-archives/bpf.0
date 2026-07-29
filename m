Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B16F242D65;
	Wed, 29 Jul 2026 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305530; cv=none; b=W6pi81VQUHGyxVstTLOo6P08YrdQx8ixPBjF3rHiESFOkosMO0l0I7r6hvFpMSa8OQZcYH6gjKbgYFa1ODLMsNdwHb7NjUUEQ5QuRRtTXVDQF1E3o1tQm/9LbLcx7Ay5CtBVfNvalT5CvTnFjT/V8N71JBu8mIPKV9DtIr0+djg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305530; c=relaxed/simple;
	bh=CRhl/ZOEP5d/PKh7HyBPjbtuw4t71FgUaBnYMmjCaOE=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=bNrzNdSoyYLUK/p4zkoM0332egR/OWZNQbpl6jeBNQ19r068nFICKQsjTLhku3SxM478RAhXpuEYTPxOZsFEhJLTh9n+WZM66O9RIkBvu5dAdc6PLMJrNzlm7bSwmHHX5FuONJTqVGSR1vqkKKS5KB8PAcKLcfwZuLRrS4uO/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h926Y438Yz5B10S;
	Wed, 29 Jul 2026 14:12:05 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 66T6Bv8G008017;
	Wed, 29 Jul 2026 14:11:57 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 29 Jul 2026 14:11:59 +0800 (CST)
X-Zmail-TransId: 2afa6a6999afbf1-9c312
X-Mailer: Zmail v1.0
Message-ID: <20260729141159128mEJmS_aujBKr-cBu1p_UI@zte.com.cn>
Date: Wed, 29 Jul 2026 14:11:59 +0800 (CST)
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
        <jolsa@kernel.org>, <emil@etsalapatis.com>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGJwZi1uZXh0IHY0XSBicGY6IGxvZyBlcnJvciBjb2RlIG9uIHRyYW1wb2xpbmUgdW5saW5rIGZhaWx1cmXCoA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 66T6Bv8G008017
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 29 Jul 2026 14:12:05 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6999B5.002/4h926Y438Yz5B10S

From: Xu Xin <xu.xin16@zte.com.cn>

Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
code from bpf_trampoline_unlink_prog(). This aids debugging of race
conditions during link teardown, while keeping the warning rate limited
to avoid log flooding.

This will be very helpful for speeding up trouble-shooting of some crash
UAF due to bpf_trampoline_unlink_prog failures.

No change to unlink behavior.

Signed-off-by: Xu Xin <xu.xin16@zte.com.cn>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
---
Change log:
- Small fixes according to the v3 disccusion:
  https://lore.kernel.org/all/82926caa-e16a-457a-8d75-61dfc8dac102@linux.dev/

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
index 1a721fc4bef5..49dceea3d51e 100644
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
+		err = __bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline, NULL,
+					&trampoline_multi_ops, data);
+		WARN_ONCE(err, "__bpf_trampoline_unlink_prog returns error: %d\n", err);
 	}

 	if (ftrace_hash_count(data->unreg))
-- 
2.25.1
