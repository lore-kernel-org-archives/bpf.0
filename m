Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ABB384258
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425953; cv=none; b=XHMuLGrVHeMLSArqAHDkLArkL05ZD9YhhNO0olwPspQHZKeHGVNf81eaz0LmLtw20IL01nwyGOUQGYKAZSvzpT2ebxVCDezVQwJRIQ5/PaI29VOSZ6u8vqjKvjl9atJbj2xZzhiTBItXif17bGPNC8rVqkvBu15zjbz1e7mPtmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425953; c=relaxed/simple;
	bh=TfYjiyxSZQWShWeKuVieNR1hpXAfbNI9JGyEi+hZeA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPG73fUFxanSFOxlqidldUDxInBmCQiyn1VLFHB5/a/G7tjSbO7B1sHr3itzOS0++MToi5WJDBJ7fpbyXHrADRL787PjGVqWzr0AlEk4F+5Axj3vyE4Gv7o6NSZ4LxeHokMS24Ybjg5pmS8KkR98xxyFBOz5L6iHuWE+SKf4pAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=AmM7Lohd; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="AmM7Lohd"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-caf5fee4196so707405a12.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785425950; x=1786030750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2EIBFtdmD218tgwkiMxBZe+9ZM0XALpaRjTlqLBpcvM=;
        b=AmM7LohdavokgRhj+yTgsGfKges88Du2VbYjSDHU1aB7jHa6Rl0cTLmNaJh26XLG3+
         j3q6tj/pQUnl762MtXewmbqx/uCqGFTZYJG8kEVjXi4m6AgbjmL8BN05Wb8bacsGUqAX
         E9GjR1lPLC9hFwy6613/a5jAvIotdimyanQSn8vAQXbbLY1olLdFvwLjCC6YyGXIJwQk
         DOgPHGXnNTxRm/7Wj6iaQpeP7HOeZa3uen92LQlbWo7VVP8+k2v5NiCbY3OklpdvvdUo
         XrtBypP60SNZsuxgaNk78/Ky5QR5Zq1RH6ScsTse2uP35AouJlbO7H9C+9yqbaSTAWxR
         6Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785425950; x=1786030750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2EIBFtdmD218tgwkiMxBZe+9ZM0XALpaRjTlqLBpcvM=;
        b=LJbSZnEVnFSGd3XwEHpRFi5YSXy5cT53wtPwKoLUudpDZxNcDGLQ0ZRqG46fgmQ0YW
         1Ov05QgxJnpiwKQPVVQHp9/9svPa3MTC9+5wCmXjbpW4APE+XFH8uogoIDZigSMPCh0m
         Oj0qEkJ1bQOvXbECJhUqqMKPByCX3EtUTcVr9hDIzQjNUOILXxDLWDvYpxGm2/Pa5ZT3
         oK2dXvAUpJ6gb50HBS1YNX1kkBymZ6PVwlNyUaSYWPHjmcMbri+lkaMvK9/rViDegptC
         J33cgSzIHzvDz+W0HtTiDq4lKrmNues4dxHqX0QdW0hAUkbzHEmBrZQ1ztwQzGmMFqKr
         aguA==
X-Forwarded-Encrypted: i=1; AHgh+Rpsf9obfmRZl73XChEvYEU8mhQttmxnH4AJWcERgs0Hg87aWXTvaYWwK86BhyiP5Wfnzo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkbdGLbvPjO+Rw1fKdpC4Tn3Nu8xWUyF/ixe/bBQY0iacCAiqP
	JjCUNwCPY5uzQOp//iBwnoV3n1/6XLQt7v17mONpMY4/DibijBGXoHe9mFiseJ274KG/
X-Gm-Gg: AR+sD13taWcJBWx7FIdTfWJXBn5x29NmWy7QQ1XGzo7qLtHWIL8m7O4ntel/t9xI/LH
	oemuSDyx4SPhiPDPdnWZutUIEv+0oqvucRhdsBHIOHOPUL1fvVXW5qefG+JuzRT+vHF2KOw9yCI
	6WFnQp2YxqkejXA2ySlQ8J2ZUUx9Bw3/iUuIUKPJcWIPGnQjmxkwVcHi/e1F6OG3EiRAMmTY9S3
	VMNk6fPsz519dOUtYPgbKqrvtw0maE3EL3hAwvfw5RYds9wM4jClil4DeMgZ3ClRv0Wi62EF3tX
	KpmnR/mce1VJypm8SwtLDLmUXuOPH2OQ89UW7xksrSAe2Ls39tmyC+sP/RMNCk2E7DcVT/T/4z6
	NqupvT1ctLhaMN/I013D89Wg52Je5T9H62dur7Ee+s5tIQ+M9bzVn4EKBLcH9YmamZaIswTgINS
	/F2PUmTXfcu94xm7S6prTthnISVKFcMC2/KHh6b7jrtNZd8LeHWxzffK3bqGjUKEZ7eJBbrmQ=
X-Received: by 2002:a05:6a21:150c:b0:3c3:b57b:645e with SMTP id adf61e73a8af0-3c900470cf5mr3301025637.5.1785425950026;
        Thu, 30 Jul 2026 08:39:10 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb824f077sm2242214a12.11.2026.07.30.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:39:09 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 1/1] xsk: account ring allocations to RLIMIT_MEMLOCK
Date: Thu, 30 Jul 2026 15:38:32 +0000
Message-ID: <20260730153832.11238-2-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730153832.11238-1-zihanx@nebusec.ai>
References: <20260730153832.11238-1-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_XDP lets user space create RX, TX, fill and completion rings via
setsockopt() and mmap them into the process.  xskq_create() allocates the
ring backing memory, but unlike XDP UMEM registration it never accounts
those pages against RLIMIT_MEMLOCK / user->locked_vm.

A process with CAP_NET_RAW in a user and network namespace can therefore
request very large rings and pin a large amount of kernel memory before
bind or any packet I/O.  The later vmalloc_user() conversion changed the
allocation mechanism, but it did not create this missing resource boundary:
the unaccounted mmapable ring allocation already existed in the original
shared xskq_create() helper.

Fix this by accounting AF_XDP ring allocations with the existing
mm_account_pinned_pages() helper and unaccounting them when the queue is
destroyed.  This puts ring memory under the same RLIMIT_MEMLOCK /
user->locked_vm model that AF_XDP already uses for UMEM pages, without
introducing AF_XDP-specific limits or socket lifetime coupling.

Fixes: 423f38329d26 ("xsk: add umem fill queue support and mmap")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - replace the socket optmem limit proposal with RLIMIT_MEMLOCK /
    user->locked_vm accounting via mm_account_pinned_pages()
  - drop the earlier socket/pool lifetime coupling changes and keep the
    final code diff limited to xsk_queue.c and xsk_queue.h
  - retarget Fixes to 423f38329d26, the original mmapable queue
    allocation that introduced the missing resource boundary
  - v1 Link: https://lore.kernel.org/all/cover.1785313094.git.zihanx@nebusec.ai/
 net/xdp/xsk_queue.c | 8 ++++++++
 net/xdp/xsk_queue.h | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
index 4dd01b7d858e..8be251096277 100644
--- a/net/xdp/xsk_queue.c
+++ b/net/xdp/xsk_queue.c
@@ -25,6 +25,7 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
 {
 	struct xsk_queue *q;
 	size_t size;
+	int err;
 
 	q = kzalloc_obj(*q);
 	if (!q)
@@ -45,9 +46,15 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
 	}
 
 	size = PAGE_ALIGN(size);
+	err = mm_account_pinned_pages(&q->mmp, size);
+	if (err) {
+		kfree(q);
+		return NULL;
+	}
 
 	q->ring = vmalloc_user(size);
 	if (!q->ring) {
+		mm_unaccount_pinned_pages(&q->mmp);
 		kfree(q);
 		return NULL;
 	}
@@ -62,5 +69,6 @@ void xskq_destroy(struct xsk_queue *q)
 		return;
 
 	vfree(q->ring);
+	mm_unaccount_pinned_pages(&q->mmp);
 	kfree(q);
 }
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1bc42c8902f4..b2e96c65f955 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -7,6 +7,7 @@
 #define _LINUX_XSK_QUEUE_H
 
 #include <linux/types.h>
+#include <linux/skbuff.h>
 #include <linux/if_xdp.h>
 #include <net/xdp_sock.h>
 #include <net/xsk_buff_pool.h>
@@ -46,6 +47,7 @@ struct xsk_queue {
 	u64 invalid_descs;
 	u64 queue_empty_descs;
 	size_t ring_vmalloc_size;
+	struct mmpin mmp;
 	/* Mutual exclusion of the completion ring in the SKB mode.
 	 * Protect: when sockets share a single cq when the same netdev
 	 * and queue id is shared.
@@ -532,6 +534,6 @@ static inline u64 xskq_nb_queue_empty_descs(struct xsk_queue *q)
 }
 
 struct xsk_queue *xskq_create(u32 nentries, bool umem_queue);
-void xskq_destroy(struct xsk_queue *q_ops);
+void xskq_destroy(struct xsk_queue *q);
 
 #endif /* _LINUX_XSK_QUEUE_H */
-- 
2.43.0

