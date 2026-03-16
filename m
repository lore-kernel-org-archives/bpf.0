Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7914526738D
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660551; cv=none; b=lsJDmYYqSs1a+Z4U9a9NBcHGkTJqfbfM+NaTaJuSFqLNVDVllETwufANJKbnm9s0DqJH+XfV/jvPyiH+SYA30ITppzLcWNm1z32/1BV1sbbzXi3qKK06m8zsjmJzasGEKKjas8crR3/DAWimNoFTt7Bgc4s5XSMR2UtZiM8d0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660551; c=relaxed/simple;
	bh=UjK10OBfDG4cifl9Mz4i7HLK/ZoPL07F/KNEv3xPjSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUoBwE4S+jCoLRFzydNZMQUNcjdDq3cPUvc4oFEeHi62adbjHafNjBTrmyD9H3HYh1NNDATowidQ9un2b0FBjdp0IoTlVQ6CW3lqHBjRFP0sFOgQxD6DnClA9xwMqbREsKmfchmIDMp7NwupFk7VNOkenhLcdojPV+iGHpRRv/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTIRw/ct; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTIRw/ct"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c73bc3dd25fso1675557a12.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773660550; x=1774265350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpPRbYYnTe0Bs7rJxn1jlZ275hZTs9fjUlBButpAMuA=;
        b=YTIRw/ctKVt+YLqTE4cSt64k3AZn3q9DpzeRgQ4uzBbtOm05XInj7EAuJorrxbWpo1
         /iyU0ob19rJfbHve6oJcNrN5GpQj2GyrEhCXS9nV9OoIaDeTjYIzT4M7Bl6Hx9NMMKWb
         +vTiUEH2kGaQUfk1sWHR/FTy/VaxTqR9uuHCO8NqVF35gjuFWVhwn7B149eq6+9n/ash
         883Fhwzb5EA3lYb0MMdw0lra1Bxk8MSADXHvsepaYHSWtRm0jEvgoldKB+Ba5PP+DsaN
         ASl56O377Wa1ZgGRjxWXSUxzFjdTPHHWz8QJwYniZCvuJWEYOtq0gQurzFqOse+SiroQ
         cMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660550; x=1774265350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HpPRbYYnTe0Bs7rJxn1jlZ275hZTs9fjUlBButpAMuA=;
        b=TKdyZEaFAcuDTw4cGa8NYSTG56EA3JFLk1vGfd+klfjM4Gn1rrX4YQjxfdID+Y1R11
         pAVmFFo5e0UxCh+ApPSgxO3V5K+XkOkZTsa+PJTKaQvvR/KAMrkbcd/3282t/9b1JWv7
         bKNiU9UPtbCnH/xAcsSYgOcHErqtqQAbC6HYWG0ewEtYscIqMJUqgmyIl4+hVCT4Hq9q
         FguH1SjXjMrHIaooERpYwfFqHcQk9HJFK46EJPgnVhC4fW/DplbTSjcl7P+2iXs36CAz
         +vkzd1G6rJvv/nTWCg1+r0HTqzxRwiEr4VFX33hslW9iJ+IP9MxJY++4TS5GoPiolPbU
         39Ww==
X-Gm-Message-State: AOJu0YzeKdmRCLW2JBFGAxWtQBqW0LUkTl5dYMNPphLvP/TziLngR58F
	6GS/Plfv1UeLxsSYWjQGWLo/cGvq/gKLE4I6vpJ5ZgrZY/b0nYp87z35
X-Gm-Gg: ATEYQzykjNMen7dnj+pp/C28jQwiHAGpJv/LwaI4xFwS+LURB3R7nB7eLJ3Ngux0DNG
	rmqUwnirTB6ZPonV+KyQcOJziIutVCQmsfKtVUHX/EV0HO5RE39XfgYiAqSx1Rdfl4OjxyDMGz7
	j/DGgu1UoOIixKKcqbgpC24Hr6+x+LPs0BKJNvz2kJSDn5UGGUX+FDa2eYWWi6p5dg4nLxVVtvd
	zKqt0EUkCTXuOvG+sNyFP28sBYxFf6QUH71uRnCN5SxNStrkUz+uGizxfHHPhIWSHCbyxbk+hNm
	ueZ7MqjjqQ9ZetrfsxraChjJYihsNH4PhBHapErfE8JL/KPGbbnhjqx9NPHBakWnDW01w7KsSWV
	67btJW4M+/sVaPEGFwCMKYhDCObS4YbebjrEx/9JC4HzvZCfL87xlJlpyzKOPux7SXCxGnQ2s3v
	xHcop/9Iu3IYuYOcNHF/mJFdDJWouwO3YN0dwrBwNICotyOA2JFuH8pix68VmiMRhSLw==
X-Received: by 2002:a05:6a21:4d8c:b0:38e:54b8:60a1 with SMTP id adf61e73a8af0-398eca2fc4amr11781405637.4.1773660549984;
        Mon, 16 Mar 2026 04:29:09 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7401588ecesm4684940a12.32.2026.03.16.04.29.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 04:29:09 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 2/8] bpf: refactor __bpf_list_del to take list node pointer
Date: Mon, 16 Mar 2026 19:28:37 +0800
Message-ID: <20260316112843.78657-3-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316112843.78657-1-pilgrimtao@gmail.com>
References: <20260316112843.78657-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Refactor __bpf_list_del to accept (head, struct list_head *n) instead of
(head, bool tail). The caller now passes the specific node to remove:
bpf_list_pop_front passes h->next, bpf_list_pop_back passes h->prev.

Prepares for introducing bpf_list_del(head, node) kfunc to remove an
arbitrary node when the user holds ownership.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cb6d242bd093..e87b263c5fe6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2426,9 +2426,10 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
 }
 
-static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tail)
+static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
+					    struct list_head *n)
 {
-	struct list_head *n, *h = (void *)head;
+	struct list_head *h = (void *)head;
 	struct bpf_list_node_kern *node;
 
 	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
@@ -2439,7 +2440,6 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tai
 	if (list_empty(h))
 		return NULL;
 
-	n = tail ? h->prev : h->next;
 	node = container_of(n, struct bpf_list_node_kern, list_head);
 	if (WARN_ON_ONCE(READ_ONCE(node->owner) != head))
 		return NULL;
@@ -2451,12 +2451,16 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tai
 
 __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
 {
-	return __bpf_list_del(head, false);
+	struct list_head *h = (void *)head;
+
+	return __bpf_list_del(head, h->next);
 }
 
 __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 {
-	return __bpf_list_del(head, true);
+	struct list_head *h = (void *)head;
+
+	return __bpf_list_del(head, h->prev);
 }
 
 __bpf_kfunc struct bpf_list_node *bpf_list_front(struct bpf_list_head *head)
-- 
2.50.1 (Apple Git-155)

