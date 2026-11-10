Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270484;
	b=sdf23LXNKexjomk/qKafw5u3CZI+A7DLW3TnbmeFq42xPdraq9TgRhrHxxUAw8trREpc
	 TL4hYdVBwunbEYbx/kJIKPspLy7CBK5T9Wygn6bQ5Rwq14uVHnRWfSc7RttlhXdrjH3mq
	 /tnTRSws0PkiXJ8Sd54KVHFeeMBv+hNKKb9WQcELzAnCVdESrUX1QG5+liM03KfaDpH7K
	 D++Ys7R4biYgsPzBzQ7C5B+5tStQrXH454mwlfU+hCCr35QduIjY4yAgd2bPBxNBi2Fb+
	 gtTUK+zss4Yru5iX6Bil1Adg5RyYG39fRuGGrU3uQ+B1uli6UjKfFtxQEZfJZsDsUow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=ue6PVUGojqn2xXjHHvnnbX+MGRlEMI+M9KU4LQMvdgs=;
	b=HGMy5sIf4192hV9yH5sjxxxCpKjDzVTiro/6myHAuvaZZ11XEAkN3wNtJbVW9QmWFahj
	 XdX3RrxUA4lJOWT5QguppIwGQjfQN/6tplb4NuylvaVCKG+kUJKVmxWQs6xy+wG6oBc5/
	 nYRC9YX7XSPuBqXYoZ1iek2X1+e81du5eSwRLNQsDesX22WU3Vnp3JdkFVD+Sy+SY6lhT
	 b5aP6QUOWBKEH3fkFc0FPSV5tH86S4M4tfR7qSyiUGN+X2hkZK7EEc1geoq/xuYBbhm9I
	 fxbasNKLXY/fW94LOFBFBO+bYWVb6MJySHzE13AM1ZsPhEiggcmdrN6h0v2PsP2YIqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1S9NFNR;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C894606A325
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C894606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1S9NFNR
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ff9833fedso4328755e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270483; x=1794875283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ue6PVUGojqn2xXjHHvnnbX+MGRlEMI+M9KU4LQMvdgs=;
        b=t1S9NFNRqW8R3LMuxuAZeC8eukmVWidGCU4rbYMWF7+gVM9oWgKQHntxjoUbc2+rM+
         3T5EeMCDWSOstJv1i/L4HgGEvKzSEvo0mwRquyN35a1sYAxu03gb7M9J2SiTOqty0weO
         gsJ6mp60Ajrb04iJa2vZgPaVCEaEq1/FS6VbBAJR4ZAMjSUiYt/M9JSKp7lEXaN8J3oc
         22SlPny7CPHJ/D+i+2q21znaveIViZ+mMiAfFAW6rUGuDu3qgQvTAiqX9kp+Ps6aKE4C
         rXuksuVudV6g8LUleSpIT5WNYaK/aFYoFuUUlb68CgZli6F4tqe+ww7XG5LHQYM7M/6y
         aFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270483; x=1794875283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ue6PVUGojqn2xXjHHvnnbX+MGRlEMI+M9KU4LQMvdgs=;
        b=V9NK1y4qHgsDNzr8AY8DxK6OAmWj+bYb9AVDQYJ3+Y6oP9JWOgXKX4560jvcftfECO
         84U77TkYTbWZHcRn0c1FZEXqyw3nRZ88whKTpOmv58wofWKhPlkMd6VfPgnuxtsjx0fl
         xOv9OsiHI2NTJnotOp7tVpXEMuOh3S5Llc7sbfa8SO/KEsCX7IlYTTnsOYlD8vw3Q0Ak
         mM+5C04GrvAkeBoI3DFJLQ5JGxryuQef6+7geEikztY/6ae8f0v8L+omnFOJboFkdUCh
         Um+7PCDZdgBLYiTiinc1AN7BU4EA9svWmgHnlN9rEEUHaw6+GvtnyDyAjYSg/Z6GAYOg
         DLig==
X-Gm-Message-State: APuU4Z/OzkCa8dSDlqM7ePQ0mGwbD/lqhHkOlT849gr+nLKYiBFK77U1
	y59YcL2lpZRhH02MqCDZSzPGrK3VgotCTk/n4Q2Bnf3T7Zrfyv+VxabXITjYRW65
X-Gm-Gg: AYBFou1kyLe9tbG6n6wZJtq/bodI1PDFGPd/dS+WOCM3RCU4sibZf4OhVo/cHq5nTNJ
	Mr/12jQUgQx6OBH9vXs1+lA2nh1jMrCPKS7NNHG04oKgk433CVrqfUenVxKe5cbBIwA7MqUrCiq
	r9UfmyoDDYrkRSiQh5vR8Qx9t7gCbbNglpP7XksQYacaeaW/2cgvjNH4TF36OajgQ7xcGMO0qV+
	NLEKGMmjsWCk4nNIwLpgK4xjMwnlcA+Wnpbmyy4dbwbyhu5cXggP6u7860v5wPQHhmOAuV3XSlL
	MBJk6tTD+gXLg1J27SFx2zBjZQNK/0ae24PSJVg7KXv3vUzBccwHHsRdHoqdB31a/a50tM6PvC+
	zmsdQc8wjf4sYF9HToIlR/v2WPOJSgq5K9QmAfuctTzqHi5+cSkhMbY9YlNuyQ82OsKVVj+MZYL
	5f0SvOVYids3f1Pji1xO4YwxwjRg/9nZW9E5as42SJnj6L5df3SpWwQYb8VmmRXo15dI8AW5tkK
	GoDUDF2g3V/bXzvXYUGqf2VuoSmhlmvTwiJ8MYWk2cdwhvQoWnVy2+ja8fLXH9mdlgu8opx446J
	4eP+ddr2NI4qhETJmaLD+CIiD6gkjitSjMiwD1NfYTlwTF8S6K9E5ei2Gt5vK0y113MUAeRrc92
	i8nCwjB8Xhrt/3Up1QcWX743wFwLmUDSYtj9MgMyqswHogRmeVRRjhEi2r/kYdTtsjqDEutA5NU
	iQTpkiRQfdCWuatw==
X-Received: by 2002:a05:600c:8b21:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4ba023085c6mr12149755e9.4.1794270482755;
        Mon, 09 Nov 2026 16:28:02 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe2f09sm28043175e9.4.2026.11.09.16.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:28:01 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 09/20] bpf: Register bpf_task_wake() for all program types
Date: Tue, 10 Nov 2026 01:27:31 +0100
Message-ID: <d3069dd53406ddc20ca68dc1a1904ee9b73c52b3.1794269506.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3234; i=memxor@gmail.com; h=from:subject:message-id; bh=WgeJofHYh8Pylh5WpyOsyU+ab1UjrLG/n12R+hqpMZQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTotuznFV293unFPJEny8T31Kx+63Dwrf1j72T9dP2C n/LKWLqKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwER2xzAyvNs8ZaVB3Q7Jb2U1 /45feZ0p0Xjnv4lM9jWn6aZMZwz0uhkZZp8R1pqZ63Xk9+KWlTx7GiyS4u/Y1TwSb2TT2elyjCe eFwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The kernel event that makes a parked task worth waking is usually not
one a syscall program sees. A thread parked until memory runs short
wants the wakeup of kswapd or the start of direct reclaim to end its
sleep; one parked for a queue wants the enqueue, which may happen in a
tracing program, a callback of a BPF scheduler or a networking program.
The program on that event has the task, as an argument or as a kptr in
a map it shares with the waiter.

Register the wake for BPF_PROG_TYPE_UNSPEC, which makes it available to
every program type, in a kfunc set of its own. It takes a referenced,
trusted, or RCU-protected task, so a task kptr read under
bpf_rcu_read_lock() works without a reference per wake. The park stays
with syscall programs: the audit that confined it there concerned the
runner, which has to hold the program across a sleep that drops its
Tasks Trace RCU protection, and the wake sleeps nowhere and touches only
the task and its pending word.

What the wake does depend on is a context in which try_to_wake_up() may
run. It takes the task's pi_lock and a runqueue lock, and a program can
run in kernel code that holds either: a tracing program on sched_waking
runs under the pi_lock and one on sched_switch under the rq lock, as do
the callbacks of a BPF scheduler, while a perf event program can run in
NMI context, where neither lock may be taken. All of these run with
IRQs disabled, and a wake asked for with IRQs disabled is queued for
irq_work instead of being issued. A program that runs with IRQs enabled
holds neither lock, whatever its type, so no program type needs a rule
of its own.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/task_park.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/task_park.c b/kernel/bpf/task_park.c
index 0e3d7f3ec597..9de1b496ead1 100644
--- a/kernel/bpf/task_park.c
+++ b/kernel/bpf/task_park.c
@@ -281,13 +281,31 @@ BTF_KFUNCS_START(bpf_task_park_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_task_park, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_task_park_kfunc_ids)
 
+BTF_KFUNCS_START(bpf_task_wake_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_task_wake, KF_RCU)
+BTF_KFUNCS_END(bpf_task_wake_kfunc_ids)
+
 static const struct btf_kfunc_id_set bpf_task_park_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set = &bpf_task_park_kfunc_ids,
 };
 
+static const struct btf_kfunc_id_set bpf_task_wake_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_task_wake_kfunc_ids,
+};
+
+/*
+ * The park stays with syscall programs, whose runner holds the program across
+ * the sleep. The wake touches only the task and defers itself where it cannot
+ * be issued, so every program type has it, to wake a parked task from the
+ * kernel event that makes it worth waking.
+ */
 static int __init bpf_task_park_kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_task_park_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_task_park_kfunc_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_task_wake_kfunc_set);
 }
 late_initcall(bpf_task_park_kfunc_init);
-- 
2.53.0

