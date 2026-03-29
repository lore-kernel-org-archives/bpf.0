Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA933793B0
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774793147; cv=none; b=NOnv6j5O2/33pMUbcSpyo3BAh/jNlWtGXDY6AkJOKlnNg2VzpQ6LndLuCEsjdr0u1f2fIcd6W75oE6lMk7JSUJ5g481zzLuU/VXEOqUwfMCYqHrBuD9Uzt+6vc328+UHnNRLhWSJE9PQg9IymVgkAe+2IYKBNnifpLV57byoz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774793147; c=relaxed/simple;
	bh=QHI8JtS+6j5swan0XlMnxTRWUG/+dPcF49oye/Dz5Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3P18i6VYQNOHqTeWBXMRbAnuHH/oC7JidIEdb/bg2uinQMio+xNKAHeddMMEkuPGs6tcYcd6RLzkcAuw34i7Iclj72eZ8KHWdxchzpbMLfCt9v1xab7K0PPFlL6DCSDkGIsAkUm5mwfjSJ16T73gdlEpmJ9TK3MO7XejHErgYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii/+f5ay; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii/+f5ay"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35c1a131946so2170061a91.0
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 07:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774793146; x=1775397946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXAn5RbGKGbLHjyb3tFwIH2zU+FTjnwaItuZJq6CaG4=;
        b=ii/+f5aybcPjv6Aw1lnR2CbgsvvUs50Y0qKbM/D/VZv/fq8qsIgeMrVq5Rpdvu0idB
         ub0plH8h5Sx5G8bADZR96KSCj5gHBE9VMSpyXEDOVyvWgAKSrty4mutXSb+XRP+iqV2n
         V2VqEPZNQp0zSGYE4KZA4dtNs6NzAiNINUrGPlynRQZdMrHB9cF02AIs6QfvZQOFBs5B
         /o8kal7KPtweDxoLWBt78kNLqieXlqc/3iK/SQ6hZGOWANpJwIEgbdwjJjOAWjtOgy4z
         fLRIITmrjiocwSiHJZ+s9tY+Q8ODd8vYoAs3EsXDMMA79ZU68vgeXDICWE41zB0//3vB
         IKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774793146; x=1775397946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iXAn5RbGKGbLHjyb3tFwIH2zU+FTjnwaItuZJq6CaG4=;
        b=bV+piIr4b2BTuQob7WGPlmLUwaTSga3+hdidAduj42lPlwegXL2A4iYVH65iK+KBox
         5cexwcqb92VKKgGbscqp6u7z80noyVfN8DYKMI8ku/er1C7dG5ac2xyyEUiF5/hPVYW0
         TP+KjvVrI/xUrhZO0V5dQelzTIEUoB+GkNnSUMNIqgTZFFj3tFWQdI41iyAnNHxCVq6D
         1dHmr3Nq5Qpc7t8McnS7RkZPIEi9bW4UadtN5bfsXcudx+fUI84WmfKdI8UtBcaBGNxH
         LNHZ7fxZALo2idtg217Ct6JuyXAvmA8Vx227eM6bw+C6JrRFrc1JQiJopKWmcWS/fOs4
         vHVA==
X-Gm-Message-State: AOJu0YyWNm/eh++cg4LX/vJkCUOtAp2fAOtgHCakF7uP18LEUQ6+evLp
	HpzOvpy96dU82oE9TK83Csg8Tumlj8ez+ArdEb9whXXPIepoOkGKq3fB
X-Gm-Gg: ATEYQzy348nKRoZpI0YkI0HrrhSYUvLb+ISCt5kVbrQLZq7OR6tfa1fgwDjBzSFqwVs
	h0IdJcEh2Wxd2QHKNKqvSCRp2d1q30vP6cuBeukCKOhekFVNBqjdNsN/A6Lxu5/a+pFW5FicjkF
	3rG8f6WoJZxlBkVCoPuLSl5NRwn19fHeBM0RhDcGL0naj1iWXb09SFr7AqjbkiGzl4Ik0Kf7d6q
	kiq58uzJPxCtZIn1WzcSb9tytcU5fkIYFxuqQzeKcZQUNTMLOThPwzfbSbzWFKosBPVdefj52p5
	C0guYcGT7KywPxWRAyEc2ldPWQAUJkpv5NPXkvrcDjs0pdQHc0rk5Gc4PeDviDDTIV0psyuDnSp
	zS0Sfb3x2MFaWGesRCBQWa8Muv6z2S1+D6onITIZJbeo46LfmyfNY1k3cL8T8lSg/5hc6NeO7ao
	RhDkJ+NqDK+lWdNurLQa5fEC2Mkex9Fr2R/LtAV1Xeeksmmfli27CLGw==
X-Received: by 2002:a17:90b:2887:b0:359:8ca0:308d with SMTP id 98e67ed59e1d1-35c30dc50b6mr6972922a91.14.1774793145740;
        Sun, 29 Mar 2026 07:05:45 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950bd630sm4417454a91.16.2026.03.29.07.05.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 29 Mar 2026 07:05:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 4/9] bpf: Introduce the bpf_list_del kfunc.
Date: Sun, 29 Mar 2026 22:05:01 +0800
Message-ID: <20260329140506.9595-5-pilgrimtao@gmail.com>
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

Allow users to remove any node from a linked list.

We have added an additional parameter bpf_list_head *head to
bpf_list_del, as the verifier requires the head parameter to
check whether the lock is being held.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c  | 10 ++++++++++
 kernel/bpf/verifier.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8abb99712043..6dddb2377047 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2471,6 +2471,15 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
 	return __bpf_list_del(head, h->prev);
 }
 
+__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
+					       struct bpf_list_node *node)
+{
+	struct bpf_list_node_kern *kn = (void *)node;
+
+	/* verifier to guarantee n is a list node rather than the head */
+	return __bpf_list_del(head, &kn->list_head);
+}
+
 __bpf_kfunc struct bpf_list_node *bpf_list_front(struct bpf_list_head *head)
 {
 	struct list_head *h = (struct list_head *)head;
@@ -4557,6 +4566,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f2d9863bb290..ae8d1f2e32de 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12480,6 +12480,7 @@ enum special_kfunc_type {
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
+	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
 	KF_bpf_cast_to_kern_ctx,
@@ -12540,6 +12541,7 @@ BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_pop_front)
 BTF_ID(func, bpf_list_pop_back)
+BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_cast_to_kern_ctx)
@@ -12617,6 +12619,7 @@ static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_pop_front,
 	KF_bpf_list_pop_back,
+	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
 };
@@ -12625,6 +12628,7 @@ static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
 static const enum special_kfunc_type bpf_list_node_api_kfuncs[] = {
 	KF_bpf_list_push_front_impl,
 	KF_bpf_list_push_back_impl,
+	KF_bpf_list_del,
 };
 
 /* Kfuncs that take an rbtree node argument (bpf_rb_node *). */
-- 
2.50.1 (Apple Git-155)

