Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAC03FE66F
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565591; cv=none; b=AUVebYUVTvYl8AacVjYePlzh+f5Bj6nR/aPe14cyyg4IgVEIIkKMp4/vnXB6iZlppQbJQYTtWPRtUX2uMEchxngtGtwzI/zV/HBZcRoX5n7/5z/DZ00oc5Fusjy//nqjYH3oAj+qpP8r9rn3CFT7nBLopRzN/fAQagMKkKZX0BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565591; c=relaxed/simple;
	bh=whicB2ftr5oTRrTNIW+rmCW4aEeQ9SHLQFsgKCkj210=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrH4J7Me8oUs5RAih/SqXUfLGYggSxO1F374AGh25FHtrqX2Oi8GOkdqVi8A4+pmxMJPpOQ07JfFSRJFuR942qDvLLcGfPX5S6VFvFO/F8V/wx6FFC1+YbzidkRT5ihffQM0Nr7518qvKrjTtbzSlyfDiRGey7rvqSBaQJESG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fP1J/eXX; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fP1J/eXX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778565582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Svt+4NlaIIFnDXWH/eCk2Ml80i80lObraw1UrKQl8Y=;
	b=fP1J/eXX7t3frf+lw1lGF9VPcd7W83eIvpJZtOzIWiFqwY6ifpnzw/PJTlU+1Y1vC2Yzg+
	IVABDCmQoFBStd4nbWOnHfrPwzhAfow/75wEg0B1VudH3xMKBMfGF1z3EZTacOSLVCoy6f
	qMgjTlwcuLPRLCHG4uWnneVYsOndxzM=
From: Kaitao cheng <kaitao.cheng@linux.dev>
To: ast@kernel.org,
	corbet@lwn.net,
	martin.lau@linux.dev,
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
	skhan@linuxfoundation.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	vmalik@redhat.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RESEND bpf-next v10 1/8] bpf: refactor __bpf_list_del to take list node pointer
Date: Tue, 12 May 2026 13:59:12 +0800
Message-ID: <20260512055919.95716-2-kaitao.cheng@linux.dev>
In-Reply-To: <20260512055919.95716-1-kaitao.cheng@linux.dev>
References: <20260512055919.95716-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Refactor __bpf_list_del to accept (head, struct list_head *n) instead of
(head, bool tail). The caller now passes the specific node to remove:
bpf_list_pop_front passes h->next, bpf_list_pop_back passes h->prev.

Prepares for introducing bpf_list_del(head, node) kfunc to remove an
arbitrary node when the user holds ownership.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index baa12b24bb64..9cd7b028592c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2550,22 +2550,24 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 	return bpf_list_push_back(head, node, meta__ign, off);
 }
 
-static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tail)
+static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
+					    struct list_head *n)
 {
-	struct list_head *n, *h = (void *)head;
+	struct list_head *h = (void *)head;
 	struct bpf_list_node_kern *node;
 
 	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
 	 * called on its fields, so init here
 	 */
-	if (unlikely(!h->next))
+	if (unlikely(!h->next)) {
 		INIT_LIST_HEAD(h);
+		return NULL;
+	}
 	if (list_empty(h))
 		return NULL;
 
-	n = tail ? h->prev : h->next;
 	node = container_of(n, struct bpf_list_node_kern, list_head);
-	if (WARN_ON_ONCE(READ_ONCE(node->owner) != head))
+	if (unlikely(READ_ONCE(node->owner) != head))
 		return NULL;
 
 	list_del_init(n);
@@ -2575,12 +2577,16 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tai
 
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

