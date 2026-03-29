Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C6379974
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774793140; cv=none; b=OSOuqxjEiJ/Xc7K6yZZxGt1oo3fpXGUy3LIfmaSyMzOLnaj9syt7BEMmbpomv8Ozc+PVWxGAq2eU2ZE0Qb/n8f/5CF5z6d0hH5sJJLkr8YV6flTktIdMXhrm0E79bAAjlwFvqGWSbNde5EvOFsqE5lQndIEXDFi2W6+oT+uhTlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774793140; c=relaxed/simple;
	bh=RnEU1GUyt7gozCKuyT2/MNHb4AIB3MO0vNXjvqRs7mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPHe58SI0HSnpAsjDCIu2ALItmX6yz3vhbdrBBBcdk2tDKen+pM6SSOxdYfD2t8cKSFiH1g3pkCvsg4UGO0eQuadKMrh5s+Ad02H7L9fq3CNY+wMRCDHCGiJmcKbujV74mTxnnyl7KrVoK7kmXGFmBXWbam9OyFm5gcckp8CGw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=intMsBj+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="intMsBj+"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so777420a91.0
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774793139; x=1775397939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdhoS7VmQGxLal6rB9oI7wDO5oAIKWN4gPVOSCiN2cw=;
        b=intMsBj+V01XL0Fa0ij1l+7KwOoF883DylHpXpmYNllwiBSv7WITH3F5uVAB1r0Wpw
         S81E4HN4ESyxoXsgW8nnW+5w29DpgpKljjgsutqXMzZac8kYth1W83HFfkWfSsgua7I2
         O8EmoA+YELqb+9etsW2LcOBkC6pcQ6PVgdPcf7ihTPJq3GFPinhqipYGYuSaRV/hZ1VY
         1FK+sIpx4vYZFgLMVMyzZzOinhCR4feFwXMEK1p3I5+nwJ4OT0Bfrn+oTPQKh9tCRqO3
         6fXJrGg39unLUVv4I+KtKIPsA0T96SnkFt+q9U3FZAkg3dpDJDbHHG7oe7w0oltuYbVC
         ovQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774793139; x=1775397939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZdhoS7VmQGxLal6rB9oI7wDO5oAIKWN4gPVOSCiN2cw=;
        b=ATch6kpN9rS8njWGd2pr+Omlf7LIZR3WY+3PLQbadpKnbV7gtiJXD0LgcgX99EbS1L
         urKXcnIid1qgiZs7mR2XjPaJ3LFNNyTLXCfWRNvwPL/nVtwe47slXAaatEXyWHCUhZWj
         VWwI/12VP1ryiF9hoMeq7GBpv9hFEHt5h3OwDmmEKGdR54100VvoCH7EjglILOhfCTf4
         Et/TGsmAsuvl5f+QhQgvnDtUIAeKPJwes9fwociWMHXgx4PfspRHkOh1iuposqJ7ymrG
         Cop/9q4ZtRpfFwDeadUtMW4842vqYjMr5bJNAitNJfAlTuSh+8WvlRkdK/wpLGVNbZdi
         K9+w==
X-Gm-Message-State: AOJu0YzwId36qX9VdVYZnMHfbntvI131YikiKjlmieQoFcQ0/bzaK6ol
	rFn1Gvq2H3Zj3kvhAtuFUgB3bV5q0OndP21oAsZGvgNHhqOro88PiMm3
X-Gm-Gg: ATEYQzx8V2hdbHz7/BlmEttJEdmAzbS7z0hNRfDE024N3YOmW1I0j4orYxgVr7gq6r9
	PuDbXcgIsdiCg2vzjtyc0pjUHzKVH3VjXlv7IBwgiIxu969nipIlrCcz0CmcMMy7VXQHx4LJCTw
	ZrCSb7H0Era6kVFqK7uCx4ZsSaxyI7B0aXct6Ett3vcea/AVKoGkFNRa659woFRgpZap9FOl5Dt
	cpnyiRerqujY7TGTIrviVjjBuFJQ4h9+kV8OkZZhUSrI2WejM/GjB7XrSnWqW9KUl2TChcab4VP
	ri1iiG5OIGk38Gek9E/yaNGM9hnEfv9p+PJzx8IIeZ4Ha/rjesigwY1BHWe69H8kYH8mSaoUrAj
	XT7b5FH/q9le/pfIJYd+JsXuYZRnd7S0VMQe711Q2VShRGiRnO+suybUKc2231cSpaP9ExAhFRF
	ITuyGd2I88qK9lQmkf+Xw9ENKVlAywrjo7/OS/xKKjKFEd024mldQl5ORhkca6vCin
X-Received: by 2002:a17:90b:3f46:b0:35b:e4f0:f9b4 with SMTP id 98e67ed59e1d1-35c30d790admr7033452a91.10.1774793139041;
        Sun, 29 Mar 2026 07:05:39 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950bd630sm4417454a91.16.2026.03.29.07.05.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 29 Mar 2026 07:05:38 -0700 (PDT)
From: Chengkaitao <pilgrimtao@gmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	chengkaitao@kylinos.cn,
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v9 3/9] bpf: clear list node owner and unlink before drop
Date: Sun, 29 Mar 2026 22:05:00 +0800
Message-ID: <20260329140506.9595-4-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260329140506.9595-1-pilgrimtao@gmail.com>
References: <20260329140506.9595-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

When draining a BPF list_head, clear each node's owner pointer while still
holding the spinlock, so concurrent readers always see a consistent owner.

Delink each node with list_del_init() before calling __bpf_obj_drop_impl(),
preventing subsequent users who hold a reference count to the node from
acquiring an invalid next node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 94fcd4ab39e9..8abb99712043 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2232,7 +2232,7 @@ EXPORT_SYMBOL_GPL(bpf_base_func_proto);
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock)
 {
-	struct list_head *head = list_head, *orig_head = list_head;
+	struct list_head *head = list_head, *orig_head = list_head, *pos;
 
 	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct bpf_list_head));
 	BUILD_BUG_ON(__alignof__(struct list_head) > __alignof__(struct bpf_list_head));
@@ -2247,6 +2247,9 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 	if (!head->next || list_empty(head))
 		goto unlock;
 	head = head->next;
+	/* Clear owner under spinlock to ensure the owner is always valid */
+	for (pos = head; pos != orig_head; pos = pos->next)
+		WRITE_ONCE(container_of(pos, struct bpf_list_node_kern, list_head)->owner, NULL);
 unlock:
 	INIT_LIST_HEAD(orig_head);
 	__bpf_spin_unlock_irqrestore(spin_lock);
@@ -2255,7 +2258,9 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 		void *obj = head;
 
 		obj -= field->graph_root.node_offset;
+		pos = head;
 		head = head->next;
+		list_del_init(pos);
 		/* The contained type can also have resources, including a
 		 * bpf_list_head which needs to be freed.
 		 */
-- 
2.50.1 (Apple Git-155)

