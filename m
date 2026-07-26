Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16322BB13;
	Sun, 26 Jul 2026 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785078459; cv=none; b=NlKgoYP1Yng5VPZBM5gMU4qboJRZPXFfbWAoYLVjArO6e9vsUim+r/AHaQqARYeuz7IsnuSVQ7JdiHG1JG8UiJfFgyUnIhp6tq9YpMy2LIQo8pEtcreyG5mKKDc2IaPMW9Ob/0hF43jFn3LmRmjgWhbbLThqd7PrG84JPuCIE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785078459; c=relaxed/simple;
	bh=rbOPdMJrFsfgJ6v0U/Km+E2Ys6B/55CxQNM9hNXJ4OY=;
	h=Message-ID:Date:Mime-Version:From:To:Subject:Content-Type; b=RZDP06dw1Q5o1rOq6F1XP2tllNSWmX3WBfUjCy7h1S2zT0o2EzPk7gDfMyGKL2BjpyS29HqzF/LtIjMbS/qAK3ej7pQ6ecIM+xTC2Ez+QLRkS6imfY2XuRHicy960oqaj4YPc1MPDVrIuUmWwi23qd75isrHANvd5L897f76kLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h7Q7g6nVzz5B12k;
	Sun, 26 Jul 2026 23:07:27 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 66QF7MWs045803;
	Sun, 26 Jul 2026 23:07:22 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 26 Jul 2026 23:07:24 +0800 (CST)
X-Zmail-TransId: 2afb6a6622ac97f-e8342
X-Mailer: Zmail v1.0
Message-ID: <20260726230724742Z4CDN9ntFInEofAf2YxME@zte.com.cn>
Date: Sun, 26 Jul 2026 23:07:24 +0800 (CST)
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
        <jolsa@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <leon.hwang@linux.dev>
Subject: =?UTF-8?B?W1BBVENIIGJwZi1uZXh0IHYyXSBicGY6IExvZyBlcnJvciBjb2RlIG9uIHRyYW1wb2xpbmUgdW5saW5rIGZhaWx1cmU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 66QF7MWs045803
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 26 Jul 2026 23:07:27 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6622AF.000/4h7Q7g6nVzz5B12k

From: xu xin <xu.xin16@zte.com.cn>

Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
code from bpf_trampoline_unlink_prog(). This aids debugging of race
conditions during link teardown, while keeping the warning rate limited
to avoid log flooding.

This will be very helpful for speeding up trouble-shooting of some crash
UAF due to bpf_trampoline_unlink_prog failures.

No functional change intended.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
v1->v2:
1) clean the subject name by remove 'syscall' suggested by Leon Hwang
https://lore.kernel.org/all/20a444b2-aeed-4af8-ba76-e994e2c14087@linux.dev/
2) Add up the missed case in kernel/bpf/trampoline.c:bpf_shim_tramp_link_release()

kernel/bpf/syscall.c    | 9 ++++++---
 kernel/bpf/trampoline.c | 5 ++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6db306d23b47..2348dc33abf4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3626,10 +3626,13 @@ static void bpf_tracing_link_release(struct bpf_link *link)
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
+	if (err)
+		WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);

 	bpf_trampoline_put(tr_link->trampoline);

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 1a721fc4bef5..dae3c2104ed4 100644
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
+	if (err)
+		WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);
 	bpf_trampoline_put(shim_link->trampoline);
 }

-- 
2.25.1
