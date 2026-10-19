Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32983361666
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 02:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376890; cv=none; b=b3iXoZe7R7L8MoC9aU/s7Yp+nayPF4FZjfFXVsY/4jfEx+6rsHVrZUL9j9dPwr4yD+351pwYSfftW9ZS80zCeTbuCOXpC/EsMvz+HbS3s5GQPuGDB3ECDv0lDF6tgp6be7o8aGQ7w9PWsDwLbQFbzUUg6kVdd6OLaVGPQ0jNRrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376890; c=relaxed/simple;
	bh=0imXMVLvOwwix9YUdq6XqYgfrrARm+8HJOJ2LHyQZMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YBKogtsnRGA5+3ypr5ULA2+Js62Lkq4TE6ngkKOr+rWT1b8uHoido3W3ZqIaK7INfIKUNm8c8tAOOUyD9+vgUojYbvj7XeoqdcMmBlqQJWSJc+dlA40wTkZxFu3sP4gP0A1eLQtpi778Fkq58JNdbC85M5TO6D9JyrD8/9HrF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anMmvuc/; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anMmvuc/"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3329067eec.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 19:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792376888; x=1792981688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0pPuCC48Hy2fsKRIjoJrlINKPfQUMeKQHIeAV5LoC0E=;
        b=anMmvuc/JK6MIeHph1L8ZU9FemErsUkcJQfCdd+PZeD7+frcyU3hE88GtJ7OgQU9t7
         7U6VtWAfKcFO9+WtXRLljNukzYp1hReqv5vFHMeUqOA1M+LnYwwTCbE+oqhqdwB1DHW8
         BnjaEldCqAewf+P83CvwBSOl0IU7kOsMykfMSf74+Rlq4DStl0l//WE5TstwvTQMM3ty
         hBiKZY6ZkrWket+AfCvvWY4w7nhEMaNz/09e3HZCSCbjxx5dRzokgrywxO/cltuLnRfV
         1SbiyYkcu4OSCn9wKlXFMNKEqLWrNOPQ3ejyKMuYjIHznwleyuH8xy4XESr3skeaZBpY
         KIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792376888; x=1792981688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0pPuCC48Hy2fsKRIjoJrlINKPfQUMeKQHIeAV5LoC0E=;
        b=iDh/IWRSWEJ8WiP/0ZGl1Uz3WqSKuBnEcbYgb3oXWuBpM7tLWwDffY2relewcYNlir
         WuxkYbtR/Gc92gEOC5JPGH14MOEpxiRb/Kqj+y2sKo7r8UkLaX8noFxx0G1T3DlmFCGK
         l4YDW8OnwhaSPMseChR7iIhEz+Llk8LzX3bF0uMv03Gqq/pM/dWnQeCA2U6v9HtO2bxQ
         YCu26h8N8/0PIV/QUUjYy8huZkA3Nlwh0QIijsIbp3PDltlPthvCtJh+8U45QZ9/KsbT
         wJzcRXY1l60/r1ZQSuQ9AZnynehEnPQyplKTwtbpodDXcphUVY39WW/l7aqdSpsBqEYi
         fYcA==
X-Gm-Message-State: AFq9FYKepvrYqpMXHJUeDvxQx3qcNShvr12d1BQTV9jfBHRiPvqdRVLR
	dMWAPsp3se2CGrcdpOM2fYVkltCnyCe11D8QA+zrtK+VeBMxkPMrsijw
X-Gm-Gg: AYBFou1pO38ldS28u6Vi0l5ldq5mIS26ad+L4HswzxjxRhHOIyKz9hC18efoUeb6ODq
	L501dRQVvvy5dWTKwnRG7ajVeOS0iQm0bzvSSTcw+DA8TVaTSs6oLM9K0H3b1svsR7gD+pim+VX
	fLZp+IFWDiZzC85oHvYSOjxkF5jSM4jgKWIjZuCPYbKtIvjCaHuVm13B9H1OBgZ6i//MsreibcK
	ysHbwUcReaYrmjkI7dvJOBQ1fonD3+35wRa7WLCXWPevNbcKulcKu0B5EUOPhjk5RgQIDJ6iyYS
	3LeShT3pVE4g4r+sf00M9+gHnAXbORRw5GO1tBMb6C2uAl+0QswBGFIOY1bWiZ8yBEA0nIU9RnG
	a2d+pjVVQADHkj9Coxrao5FOReqhmKK/tp/e2xIbm8CFYjkWA6YJitgagtt8lCtb1Ak54xO3twC
	PpBXiCX0Tu/UrQhvlNa1UcWIbwAFgVTJSV5tZV4K1e4xbv7DvTSsneW++DbnvTm4/mIw==
X-Received: by 2002:a05:701b:424b:20b0:185:b157:f271 with SMTP id a92af1059eb24-185b157f2famr8552199c88.23.1792376888154;
        Sun, 18 Oct 2026 19:28:08 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm28341876c88.0.2026.10.18.19.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:28:07 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 19 Oct 2026 10:27:55 +0800
Subject: [PATCH bpf-next v5 1/4] bpf: Protect the struct_ops association
 with a spinlock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-selftests-bpf-struct-ops-assoc-timer-v5-1-77b2e181e5cc@gmail.com>
References: <20261019-selftests-bpf-struct-ops-assoc-timer-v5-0-77b2e181e5cc@gmail.com>
In-Reply-To: <20261019-selftests-bpf-struct-ops-assoc-timer-v5-0-77b2e181e5cc@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

bpf_prog_assoc_struct_ops() and bpf_prog_disassoc_struct_ops() update
prog->aux->st_ops_assoc under st_ops_assoc_mutex, and the latter puts
the map of a non-struct_ops prog while holding it.

A struct_ops map is about to dissociate its progs from
map_free_pre_rcu(), which bpf_map_put() calls in whatever context drops
the last reference, including softirq, e.g. bpf_struct_ops_put() from
tcp_cleanup_congestion_control(). A mutex can't be taken there, and the
put of the last reference under the lock of one prog would take the
lock of other progs.

Replace the mutex with a spinlock taken with interrupts disabled, and
put the map after dropping it.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 include/linux/bpf.h         |  2 +-
 kernel/bpf/bpf_struct_ops.c | 19 ++++++++++---------
 kernel/bpf/core.c           |  3 +--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54144372281cb..2a51acd34f9a9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1960,7 +1960,7 @@ struct bpf_prog_aux {
 		struct rcu_head	rcu;
 	};
 	struct bpf_stream *stream[2];
-	struct mutex st_ops_assoc_mutex;
+	spinlock_t st_ops_assoc_lock; /* protects st_ops_assoc */
 	struct bpf_map __rcu *st_ops_assoc;
 };
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 1178acd72296e..a1ae30b145a03 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1541,10 +1541,10 @@ int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map)
 {
 	struct bpf_map *st_ops_assoc;
 
-	guard(mutex)(&prog->aux->st_ops_assoc_mutex);
+	guard(spinlock_irqsave)(&prog->aux->st_ops_assoc_lock);
 
 	st_ops_assoc = rcu_dereference_protected(prog->aux->st_ops_assoc,
-						 lockdep_is_held(&prog->aux->st_ops_assoc_mutex));
+						 lockdep_is_held(&prog->aux->st_ops_assoc_lock));
 	if (st_ops_assoc && st_ops_assoc == map)
 		return 0;
 
@@ -1569,19 +1569,20 @@ int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map)
 
 void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
 {
+	struct bpf_prog_aux *aux = prog->aux;
 	struct bpf_map *st_ops_assoc;
 
-	guard(mutex)(&prog->aux->st_ops_assoc_mutex);
+	scoped_guard(spinlock_irqsave, &aux->st_ops_assoc_lock) {
+		st_ops_assoc = rcu_dereference_protected(aux->st_ops_assoc,
+							 lockdep_is_held(&aux->st_ops_assoc_lock));
+		if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
+			return;
 
-	st_ops_assoc = rcu_dereference_protected(prog->aux->st_ops_assoc,
-						 lockdep_is_held(&prog->aux->st_ops_assoc_mutex));
-	if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
-		return;
+		RCU_INIT_POINTER(aux->st_ops_assoc, NULL);
+	}
 
 	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
 		bpf_map_put(st_ops_assoc);
-
-	RCU_INIT_POINTER(prog->aux->st_ops_assoc, NULL);
 }
 
 /*
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 05c89396119ad..fd4e4dc4acc8c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -141,7 +141,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	mutex_init(&fp->aux->used_maps_mutex);
 	mutex_init(&fp->aux->ext_mutex);
 	mutex_init(&fp->aux->dst_mutex);
-	mutex_init(&fp->aux->st_ops_assoc_mutex);
+	spin_lock_init(&fp->aux->st_ops_assoc_lock);
 
 	return fp;
 }
@@ -291,7 +291,6 @@ void __bpf_prog_free(struct bpf_prog *fp)
 #endif
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
-		mutex_destroy(&fp->aux->st_ops_assoc_mutex);
 		kfree(fp->aux->poke_tab);
 		kfree(fp->aux);
 	}

-- 
2.43.0

