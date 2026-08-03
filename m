Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06437AA9E
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756391; cv=none; b=pwDzdbPkIwFJeuOhOukoTEDmESfGv7++DIjlQRM/HeUQd6fBstiuUZUFRKFFKHXGNe/2ulbcnjYOvx0hLVsuYgCeF18En+AyVQb8W3iF70QPr72oFWaY5l/EuKGuMmjNMbrwY3Eyajxh6gRiFVsN2s/THJTdcIQ8POWC3SPlGfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756391; c=relaxed/simple;
	bh=FO5vyvXYubh9xLdJJX9nNTjIgljLuIFuxRrkGt608PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBNy6Ii50smavcBxMB3uzEl4fja1uIbUtwGvSRarzWxXrXT/VIT+1rI5+/rUKNbwbkmf1ZRQh+mmmjLqxU+J6mt3VYk2YjsJ/1RQ6YsAlWmzDArbgX67rE9xZu5knUBUKMP39nCCBQEw1IMRKq8aL2DRT0cWhQv+A/BAU5wNaKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ng+z3iwH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng+z3iwH"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84864086bfeso3398989b3a.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 04:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785756389; x=1786361189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZYaa0/tQdQClji27lPADOlgciFEhzdO3RD1CXiBjOHg=;
        b=Ng+z3iwH3dXtr1d9ahHeNN0e7BAm0OSAG2AYYFVXgOcQ6wWhSyAclE/rTMTywK6KMf
         5aZvwMA7KJO0h5oxgrUbrdmH0bP7wZ9/fY0H1iKt+QTinXGSlXUZzoljLAVGHqyXknUp
         ZnGrWUAXDAwvaODCcJuN0MJQixwIBttVPolnKtO0vnXsoTXC3CkRhBU23ng+WEV/UUJh
         KSKJz/oDM+rnFbNmt1/e01nn9LCP31zXzh6e8WSXZ0207HauGepGo/lT7uzWnElsjCXk
         09z81X4mxQgq9S94qLf1cwzd29GoPhs/P/O8DizN0qEEjhqOrqB/hJAhDhsTIwibU2z1
         BJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756389; x=1786361189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZYaa0/tQdQClji27lPADOlgciFEhzdO3RD1CXiBjOHg=;
        b=gH/1o3k/ewFGAczpj5qII4wCnWKHpW2pad8RQ5b8OtWC4o0lrjhM8zZAbOmyRCxhH9
         EDvG0pcubfkUfG0KlhI3hSnv7TG1tqFO70wZb9iM334uZ3ftZm/Kcj0Sd5sSe0/Vlu63
         ndVMvwEl1UDmFBmmCu5nHYjfP0rE7Vcbh6br63qCJP1pyKsckapCesTzSSSNXAqYN6S9
         xZEJR+5hh9Br600lmv5oyA/E0WxabdKd9ZncIIrLM4V8F8P3U4jFoc2lXxE9MkKsSWxy
         ioE8aINhaXFSKJwy2GKDP/HjZFgyCAnMF7S4PH3jiJk26Y1mloFD+FP8G+ZR543Qhilw
         rouQ==
X-Gm-Message-State: AOJu0YzfuKfCDkbMlzD4F9gUhgZU6U+9/ZHwc6Yi25pNwCn+Smzyy8LA
	dQhXlPdmoyZiqTxODKrEY35p1i9zTUniW55FHjiO+iETlaoehgifA+VMYKR8Tw==
X-Gm-Gg: AR+sD13ocg1mUB1UfHxZgD/eBYk6r1XZvBjUZgk/FsmDUUJYjDD+mfhmXOh2cCXrbTy
	ZPYD2+wIIOx8rBBFwz6gsoOhYlBt0TxHWMUNPZS/oikc63niXVjvzjwRXVk54bDs5sB10d+Q941
	QT4/Jguq5hpWD992SnOpXPd1aVoJMBHAs654IrJzKz1pRJcpdMEMJLBbEQrPT5XZa1eDr56O7Jh
	dm/MrZEviYKTkLMM+no4d8MBEj3/7VGvfhrvU9igHn+5A+d/UGi6Ecy5IXS/34sL25+Vm6uSNn1
	Vnk/D9moK3I548wn6FskL+n6fcav7krNzMJTV7xzTxOv0sgbIAS7hVQSzO8X66FKAqVbUWzHZg6
	kSIeNGOfbSd13SbraXRzNNn8URjX+GgYev77TuYU3asp+TO23q6U71MgsLZolNZNjEKJRJo3ktx
	2GulA1wIlBA7v8okhpt7mR3PuF8MCEEQ7dWwWNy7k+bcI7KTQho50XRbs1OYKB98fGa3KDVwByp
	u4nBzIqZuIzhufv
X-Received: by 2002:aa7:9a8c:0:b0:848:731a:fa47 with SMTP id d2e1a72fcca58-84ee4930583mr9080731b3a.59.1785756389312;
        Mon, 03 Aug 2026 04:26:29 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2a8223sm3494930b3a.28.2026.08.03.04.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:26:28 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: Ning Ding <dingning04@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf: Invalidate RCU pointers after final spin unlock
Date: Mon,  3 Aug 2026 04:26:08 -0700
Message-ID: <20260803112615.3362122-2-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803112615.3362122-1-dingning04@gmail.com>
References: <20260803112615.3362122-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a sleepable BPF program, a spin lock can provide the only RCU protection
for a kptr. The final bpf_spin_unlock() ends that protection, but the
verifier leaves the pointer valid. Another CPU can then free the object
before the pointer is used. A capability-limited runtime PoC triggered a
task_struct use-after-free in __bpf_get_task_stack().

Record whether the program is in an RCU-protected context before releasing
the lock. Invalidate RCU-protected pointers only when the unlock leaves the
final such context. This preserves valid pointers in non-sleepable programs
and inside an explicit RCU read-side section.

Fixes: 5861d1e8dbc4 ("bpf: Allow bpf_spin_{lock,unlock} in sleepable progs")
Assisted-by: Codex:gpt-5.6-sol
Assisted-by: ChatGPT:GPT-5.6-Pro
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b274004fccfd9..7439afdc851a7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -206,6 +206,7 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
 static int release_reference_nomark(struct bpf_verifier_state *state, int id);
 static int release_reference(struct bpf_verifier_env *env, int id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
+static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
 static bool is_tracing_prog_type(enum bpf_prog_type type);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
@@ -7165,6 +7166,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			return err;
 		}
 	} else {
+		bool was_in_rcu_cs;
 		void *ptr;
 		int type;
 
@@ -7192,10 +7194,13 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			verbose(env, "%s_unlock cannot be out of order\n", lock_str);
 			return -EINVAL;
 		}
+		was_in_rcu_cs = in_rcu_cs(env);
 		if (release_lock_state(cur, type, reg->id, ptr)) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
 			return -EINVAL;
 		}
+		if (was_in_rcu_cs && !in_rcu_cs(env))
+			invalidate_rcu_protected_refs(env);
 
 		invalidate_non_owning_refs(env);
 	}
-- 
2.43.0

