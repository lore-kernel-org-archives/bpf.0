Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C393C09F8
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762369; cv=none; b=qarG5q1R67s7xprMOg4eIiypuFsTVo2jv3Z5kh/oXvti8v+3XML2t4848Itdl7n7UAheSJAR4Em+sYPqfFhZkX6teOkUURuI1f211bpVp3r18ZDgB2Da6uf0OxkFSdMADSYf5UyxiWFg+7WNrp8N1BF32DJV2Lfz/5gAzt9uc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762369; c=relaxed/simple;
	bh=NEql0wbFfJNHdv8vfWeIdRu05ASk2DmdB8HrfvInOno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkE/DdivPwcZdpiJF6TAxMGoG2bSvbW58wSRkok1OQjaw1LQ3zbJaU5Mk0AUgdidVVe+PVxbpjIWcLZKuDNxm8+NCxJpWj/eOkvB6jZXN36afkl6qmGojkMmj86vcd+XMDxe/7oNARlWbrgG7BqTMN2XEeQZR2MGf2bs6hLcykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu1Q1Vnc; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu1Q1Vnc"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a49573b8bdso1450338a91.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 02:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790762366; x=1791367166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=buTPHsHKHzXndRvS03G7R+CJqakcQg3KUfosNRoLVmk=;
        b=Yu1Q1VncV1axfvl+/Bm8DNdMX2M40PVcY6Hvtrw/fMQkICK7AIuupG5bN50oyNa0sO
         tCPVX+s3OErtrDlfN9929U1X2kRF7Eh9zJx0UGrvwKTCQXalP9OhartNIFz+jU75CVDI
         NyVkn52kBEH6mhhI701zcvaqivWwH6BIS1yYwFOBJ0+auMAvY8pdpJQHAxKT0gIzzx4f
         SM7txbEXnks5YQ3pYZcPPs+S28vLZ23rwqz9P1KFfoOmSKaxV7aRinbVZqzRsSsBS1UW
         0/kAMXKHS5Ut0+LP1FqT4l0HXdbndAiYioWE2m6AOGpMx80VW3+uKQX7FaJZNUHv7KFA
         XQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790762366; x=1791367166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=buTPHsHKHzXndRvS03G7R+CJqakcQg3KUfosNRoLVmk=;
        b=tZ+ueDTSP4+5029+BGgKNZbHQUQVh6gDQLXrIryKmUB+evCIE7WEwljPFHLMMZFlql
         oHCYOJbiijD83qVYP+3fhHBbvzmUeHQODTxqgy6ZoiQCI2Q6cTNbu0N3fb13YfvrYmP4
         T6QnWXH08AgS+LtJn/37dtS5PQrX4BSrvVA+SOQ7Smyr8G+Q++64GfJsDF4aed8mr6So
         tDIZMUxgIz78btNtgC1L5nbSjjxXtLk1PIu4/zmI+L/hyYIuMtI/GFuOKL/yEu6pSlYj
         91uuIuXDxo8NEsk4Ddgmye0OAswdWav4iyRfJ+WNxFQvigHyLPGm7NbhTC8wWryxc2Ij
         /OOg==
X-Gm-Message-State: AFq9FYJyP4ze1YmYwzACBkurqVCEm/hiY1IujmxqM0llk6dWqnEKyyb2
	pvOVsMnYsFSug0iPmXDds9Bj7BuJmwD/9bP5adLE9FV2IRAhcYKqdfBR3nWixIbO
X-Gm-Gg: AYBFou1R5Ck9sPHjyqswY8gRG/OpTvo96LqINU5dGM6nyr+MdiRYALoB1HminGxPxZf
	7UcivRWSKiYbecuOYfFb2lUicwl6YsahkwF2MlaQf4seMx0pWJknKCj2ofVX0ndNlQDGB3aKukk
	o+5jCeE74j77XVVT+xFxC/a+UtXU9l6fQUJFbUjMW5sAvc6V0LbYxktv2HlqPTMFNy/6LM856lh
	D4mnFTQWALxowAfWl9+Cqd7dA6IOvqYTKkd2/G8iGPv2QyZj7cQIJAShlgxd4sMGJevLLgDcsGj
	Y7EBM4240kFd46/KzXsxOmhB61fh6lkrucuno5pPjnoYR0UqTzT0uRsLakewUyTa4zQgfGSNrMR
	Jris5shLyVDlgfRhLUctWXxsRTZGXmMgnw7WWOvWPa6GYnbkx+Z25L4PmICB82iGAhEADUgwx+R
	p77MldUca86GXrHVI0OghMrd1LhdW4A2THsafzXTmnrf4imPEmZVrpV7mpdB3jk7HOlCqDUxt8j
	M6IJqJt+YiZOqc/FQkG/b9ZalEmypUer75ma+qxW0IKGcok1EEslhv9OufTqnOWf/DPwrRF3Ni2
	M+oe11oKcqqOKsa3sILsSXtdFnOhx5swFhEGwe0BkyY=
X-Received: by 2002:a17:90b:4a8e:b0:3a4:b418:94ce with SMTP id 98e67ed59e1d1-3a4d103991bmr779616a91.1.1790762365631;
        Wed, 30 Sep 2026 02:59:25 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cae71827sm2934098a91.14.2026.09.30.02.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:59:25 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 1/3] bpf: Factor out __do_call_rcu_ttrace()
Date: Wed, 30 Sep 2026 09:59:18 +0000
Message-ID: <20260930095920.601738-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930095920.601738-1-alexei.starovoitov@gmail.com>
References: <20260930095920.601738-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Move the part of do_call_rcu_ttrace() that runs after
call_rcu_ttrace_in_progress is set into __do_call_rcu_ttrace().
The next patch will call it from __free_rcu().
No functional change.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 8a8f088e83e6..08e4dde66cd5 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -298,19 +298,10 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
 	llist_add(llnode, &c->free_by_rcu_ttrace);
 }
 
-static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
+static void __do_call_rcu_ttrace(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode, *t;
 
-	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
-		if (unlikely(READ_ONCE(c->draining))) {
-			scoped_guard(raw_spinlock_irqsave, &c->lock)
-				llnode = llist_del_all(&c->free_by_rcu_ttrace);
-			free_all(c, llnode, !!c->percpu_size);
-		}
-		return;
-	}
-
 	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
 	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
 		llist_add(llnode, &c->waiting_for_gp_ttrace);
@@ -328,6 +319,22 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 	call_rcu_tasks_trace(&c->rcu_ttrace, __free_rcu);
 }
 
+static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
+{
+	struct llist_node *llnode;
+
+	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
+		if (unlikely(READ_ONCE(c->draining))) {
+			scoped_guard(raw_spinlock_irqsave, &c->lock)
+				llnode = llist_del_all(&c->free_by_rcu_ttrace);
+			free_all(c, llnode, !!c->percpu_size);
+		}
+		return;
+	}
+
+	__do_call_rcu_ttrace(c);
+}
+
 static void free_bulk(struct bpf_mem_cache *c)
 {
 	struct bpf_mem_cache *tgt = c->tgt;
-- 
2.55.0

