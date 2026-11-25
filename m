Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795586057;
	b=ca1fyrtLgwX2gkioRf5yRm/rVJfSUJEApBVuwETqrN0+EYeG9sm2kV11xgXlINnMwDBB
	 30NbRLgj/LLmJvDx5Q41gZAoVBijlqWzF1J/lF+1RXZLqoqHy1fwySv/gkaB1QchAnIFw
	 TuuCYJ6gQFZiCu+v0pQOUAUb8rRNYk8XpMcIItvlVdzKkOSMp8+/3cmTPo4nMPvypc0tY
	 ohacMF+kqheyijM/QF9KGVF44L7xfLA1Q+GTQ7+/H7wl1Rq4ChPRkzirY59zfcUboQQLd
	 K6ET4UnVeL81vhmDhtcw1ev5l/zcyxHF9d7bAH9fnk7EBxyc8zcJVEisOsn1XAgE5Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795586057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6pKvzatahiPidZtQMxBJ0ZI+apNQN7C4O8J1p+1Ev9o=;
	b=kmkITE0t6BEyHjnSTPa9THBoRx++9I0IXcjkd0j4PJb1Mi82TzqbfpjcP3aOB/teKWBo
	 LNF/OYWtm0/V7d4bXJexmW0siveT+jnKTzv20DsnxnvWnjqiEFxjB1upRSRfDqcx5YLpB
	 Hl49Ppgr1vN30u4T7tjn/AqKFq6q1/hicwSV1jKi4JvqfPcy6fzrAcT28pbc+3Hp/tc+a
	 iaWfvDB/zmJZTgUjlbzNxOIPxFNWcTAB83YeOJeYXwXNZszHSLEYt2ZM6av3nIoNgKhB0
	 R+FS1RzvIEUS3hap4MF8SgTYCcOXsdWM5JnE/g7LFkWYIbh8eEw/XN4kXk9zrFpt88Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALSU72SV;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C4606A327
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB7C4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALSU72SV
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so2755784c88.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795586056; x=1796190856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6pKvzatahiPidZtQMxBJ0ZI+apNQN7C4O8J1p+1Ev9o=;
        b=ALSU72SVxb4d7DBoCjnkEFAwQ3Vjc/krmNw4HYCI46cO/Q27JsTvwaz8bmdDQoi7Uc
         F1j4M7pdRYOaqoIpZoUrGJEYboZc1b/LzIMMvU+7Wckwir2O/ElebSu3zP1huSgaNTL5
         Kf0brgQZiz0R60D9NbSgSGMBb4PL++uw4/77CCMuzqT/BYD38GVeH2OjzjTEEcQWzSrM
         zAN4fhNDKIbhOgXIlpQrQNPD5S7R7184vbWSXL7heQxI+T4yV8l/FIX5p3h8Ev2l0Axi
         vStDgOk8XjOEQ7ah05+57FtT+eH3eTxeNMq78raFmh+j7Gri2jZUvTodCUJuBAxiajwf
         DDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795586056; x=1796190856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6pKvzatahiPidZtQMxBJ0ZI+apNQN7C4O8J1p+1Ev9o=;
        b=KxdMvmI3leonw8NMp9XEh56iS/ssdUxcLm87xPcB/EHHKm28gxWlL5KXg7BBQfaabW
         SymL6hJJ35mi0JeL9LxECJ4YzqGOs/nlLe2gCNTxC5SE2IRoy7JP+irrBmijz2/jWQ0V
         87rHhZtLpLYouM3Cb/PqN6SAA16/tPMczabybB0tWP65DhwVpMFbxxzAv5MfA7p9I9Dv
         PahklL3OLK8kduI9Sf9rS6KutW1kXeMGAQNVaNdwN/GKJ3BdEaBvKCphQCPKOKWURR4A
         BniR4H3jUIGq4SN/R+MVoY4NVJtG7TbcsB/NXpJT31UysDQhxTf92LBuu0h+INoWhiqy
         21YA==
X-Forwarded-Encrypted: i=1; AL+hErGmtrkKi5aj7nWM7Zz7vHkScI+F+oGj3fBoXeoF4QmagzyN8rL5E2z/A2DGswT9Svf3j/0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qDQtfkj1UtpHz2j/+G+QimajqL45ylwwTCPfh1a3kZyvxHRB+
	Wa4rIs49/pGQqi6OsRL1t1con4tqOQFGBKbC3K96WRK8xQNS3/8cKkOv
X-Gm-Gg: AZFdTZdoNv1T3z9kT7zgB5PUXspn1gtSzYBorzuCMw0Xe9wrRj/ZRN+kwbi/uFyq9hs
	D4JC6A3EgU+QIIITo1+cElJ6dhXDZXsVy7EY1f3mS0fTfMHgTz4OFweJAIFZgv8NDUpm+pM8elZ
	aOdN2e+N1dqlMtpxVIw7/EwzslDLdb7PpmVaVV67YpXI0yYlQJtNDPD/D6cOL3kH+hq5CozVDTJ
	Dv1viACsgbDUySZ1E5gFVUFq8TL5eWNRWhjrPlmSgypoKfoUfrhc5GNVqA1tuZpSHIzn8okpBTX
	zR7b/8t1nHkyvY15ccWor6tk4Dmqngd90+gXPIgsfj/Tp59rEIHcr05MBO3mh8ZAAeFvbECRABh
	PMso3APU1EtlTmMw5cM3nZeLg/6iw4yhhJZfVGbATFrpRzBN/KECuM9w9J1dGn8HxpixDU16faP
	EGPeN/LHEw5Kc3l6OsvCaZ2Wc5DCcfJu4h8RHmu/2xxIwznQgWBeHzODT6P58h38Ks66PtQTt7X
	HHeBbToHmUFtzWophtxNtvxrld9ZA4cQkTnb1IjhReBnC/AIfzvWO7p2WuDoc9oIAR34K5QJgm9
	G74G+JC3D46vAKNxCTLQiYrAHnUEa3/SRvxsfgZNkWWp1ZFSOf4bf4Req4YSHIsqyWzApad2UiC
	JJSwAcwNvzg==
X-Received: by 2002:a05:693c:80cd:b0:385:b8f4:756a with SMTP id 5a478bee46e88-385b8f47b36mr17716685eec.12.1795586055792;
        Tue, 24 Nov 2026 21:54:15 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm51790854eec.6.2026.11.24.21.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 21:54:15 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Bradley Morgan <bradley.morgan@linux.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3] bpf: Add rcu_read_unlock_special() into btf id deny list
Date: Wed, 25 Nov 2026 05:53:35 +0000
Message-ID: <20261125055359.2715140-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF trampoline takes and drops the RCU read lock itself. When the
outermost rcu_read_unlock() finds ->rcu_read_unlock_special.s set, it
calls rcu_read_unlock_special(). If a fentry program is attached to
rcu_read_unlock_special(), the unlock on the trampoline exit path still
sees .s set and calls rcu_read_unlock_special() again, which recurses
until the stack overflows:

  BUG: TASK stack guard page was hit at ffffc90001657ff8
  ...
   bpf_trampoline_6442575622+0x5e/0xac
   rcu_read_unlock_special+0x5/0x490
   __rcu_read_unlock+0x9c/0x120
   rcu_read_unlock_migrate+0x93/0x220
   bpf_trampoline_6442575622+0x5e/0xac
   rcu_read_unlock_special+0x5/0x490
   ...

With fexit it recurses even earlier, from percpu_ref_get() in
__bpf_tramp_enter(), which takes and drops the RCU read lock before the
program runs.

__rcu_read_unlock() is in the deny list for the same reason. Add
rcu_read_unlock_special() too. It is static with one caller and gcc
inlines it, which leaves the entry unresolved and breaks the build with
CONFIG_WERROR=y, so mark it noinline.

rcu_unlock_needs_exp_handling() also runs with .s set. It is normally
inlined, but an out-of-line copy would recurse the same way, so mark it
__always_inline.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v3:
- Mark rcu_read_unlock_special() noinline for gcc (Alexei)
- Mark rcu_unlock_needs_exp_handling() __always_inline (Alexei)
- Drop Bradley's Reviewed-by, since the patch now changes RCU

v2: https://lore.kernel.org/bpf/20261125040106.2200628-1-rhkrqnwk98@gmail.com/
v1: https://lore.kernel.org/rcu/20261124185659.1370644-1-rhkrqnwk98@gmail.com/

 kernel/bpf/verifier.c    |  1 +
 kernel/rcu/tree_plugin.h | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7013ed8cadd..0e8afc0250b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24735,6 +24735,7 @@ BTF_ID(func, preempt_count_sub)
 #ifdef CONFIG_PREEMPT_RCU
 BTF_ID(func, __rcu_read_lock)
 BTF_ID(func, __rcu_read_unlock)
+BTF_ID(func, rcu_read_unlock_special)
 #endif
 BTF_SET_END(btf_id_deny)
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ae5d21bae7bc..40996dc29b28 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -689,10 +689,10 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
  *
  * Returns true if expedited processing of the rcu_read_unlock() is needed.
  */
-static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
-				      struct rcu_data *rdp,
-				      struct rcu_node *rnp,
-				      bool irqs_were_disabled)
+static __always_inline bool rcu_unlock_needs_exp_handling(struct task_struct *t,
+							  struct rcu_data *rdp,
+							  struct rcu_node *rnp,
+							  bool irqs_were_disabled)
 {
 	/*
 	 * Check if this task is blocking an expedited grace period. If the
@@ -745,8 +745,10 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
  * Handle special cases during rcu_read_unlock(), such as needing to
  * notify RCU core processing or task having blocked during the RCU
  * read-side critical section.
+ *
+ * noinline: btf_id_deny in kernel/bpf/verifier.c needs it in BTF.
  */
-static void rcu_read_unlock_special(struct task_struct *t)
+static noinline void rcu_read_unlock_special(struct task_struct *t)
 {
 	unsigned long flags;
 	bool irqs_were_disabled;
-- 
2.56.1

