Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA7158FD02
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066292; cv=none; b=lBCdTR+K4GYXW3c+ZtfDV0yhynyGZ9G5M0rM1Gw5qIbfipjTXDlqDHZWovZbP/QggiVxK139Cc4k/1jC8d3EcYPRP2AhUI+pi8yjeiVHZs1pgUiaBb4ClmZbNOErDYQ/IYrJQmzOtvoB7LdvZ2DQ9ETTm1/6e0rdgSKQeIhkUVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066292; c=relaxed/simple;
	bh=c9hUQ9kAAl2b2IbncqDZq1k2ejJxuc1g83EyvfAIkis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GKDFfOpAyy1CywrfRvTnjWNyLgxR4v8t3PzBuS6XjB2KKM+L2C0RznH/doTjngREZuj9SZ+9XaiaSA9waOBO1oEqO8D8wLpjsTz+QP0/XNZTP8niJmvFN7/zz7MJoHK0Zyv7Tib4L5fD6asTCOiDKy2ao7Qs1d41MID4qZnHrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ZT+QHQOL; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ZT+QHQOL"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-939d698e0d2so85254785a.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066275; x=1789671075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twz7P/UgrzFqFrDTfXn+06wBF94/L3aT/pnjRwe1Smk=;
        b=ZT+QHQOLa6RGP+APk20ltNsal1w/dCUGd4vqqbR6Hed8n7USi7jymaRnDPfJKzWjeR
         YddlC4IFv24U8i/3lE+gBq+f8CzWloCFwVLnzxWUX6sRQyS8B/44SfOw3UQ50QN39jZQ
         1U1Rdjlv5nTN1jGfRs25YlzkPcs6ZkqLYAj4AnmtdaqD545UdHrNXOg8JVAKdcTgNUXa
         bARuoRzSU4qm7HSuRhPOpBtmazV0NRsBtkyzCOD3E1N0N4q0335UD1u5+q6DI57z1C3U
         k4D/pLxaeBOA8D5QRkH6BDIH+6N76IaFQ9YDMnXc67aMXaL0B4ygBBXqV9OCddN0CgIv
         oNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066275; x=1789671075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twz7P/UgrzFqFrDTfXn+06wBF94/L3aT/pnjRwe1Smk=;
        b=eOTaUZhBUUM51oq5YjFVecNHHnqAkhFexNuIVkI+gWpqRuuiagL8/30jPp/EHS0KYJ
         +ir20EhG/eyRRHfYfaby0f1LpjrPApZEkCnvceThRQL/RU+qAWe50eIYlom5inkUD4/t
         DaVz7V+v7iQad9fL6IlmEdk+taV2T5GGg+p5/mw8/86JFfeMJBaww5nsZSjJlyScbB4b
         FFkTUR5hUVFFPjNR2Rb2sEXuVvhOZvDMXm0Z/QDi/Ws0QJaw2+loAjg3/U+ssZm/ESoT
         QgPPwK3/cnqJ+V27AnYEaQh8hMuINmQ2QaCvnzCAj5tKEI80NKyyyQEb2REBWQbViDo1
         d4Fg==
X-Forwarded-Encrypted: i=1; AKwUvBzguAX2UuAVzb28H7pupnYqtvccdw5Hlicp+ySVeh8R1uUR/RqvudotQ1WdXorEamQAvNI=@vger.kernel.org
X-Gm-Message-State: AFuF++kabiafJOzx4UlmZK0XKPIiZS11VSlQm0X+XSaioA2kf2FfCXbX
	rQ2gHtY20m0uZICrGHop5vuB2YlsY2PyQAxbh2evEIj2YpPqwaJRCN3YuaBddka8GVc=
X-Gm-Gg: AYBFou3Rl+XIbRNF5BM4aSBJhOS8/3AN9ZaCS+bW6jKNAM/fSMS6Vod86AzYCRj7Drn
	3d6hWqc1wmTwUVdBZG+YjmNome1cLtv3j9ZZT7B9N0gAPXEiMSnzkP8R/rtmTM5vjLAi0PKBZlO
	qTl46YqIsf8QvbQKDOXAtoYH23t2HZGUSsKjv+zzFRgJ+r6ljVHjLTXCvojGs1Fi89MpJS2pvWU
	EASH3wN6PP8wvFbubYqYIPJcIFi8U60dPH1TgfBvuA+aEsiFOhmibfJ0Iu7L0eeHKoKntTN5BTb
	WgyT8gbUlzNuEQeKyNw21sW5/rNrQZPIsThjGjfSPl7GIbULJ7aq+4r6KtYdUPzokL1odsPt1zY
	yJInXq+8I4bQr+H7fnL8HA24vDtrMABPU66wEL0FZInQk/ECULCQ+JQSVTvDmxTlSKHhQNpMJpa
	IjgSIQT8ziDRpEE39INvwx3zStS7Tw5RW4R6h4/1La0Sr+W1B1kyAVQu5R0pkR9804+10UJGx+j
	jNQpjb2njKg6+5xm5tMGSdatFD+BrXoBNu56le6yMFMP7qjGt2JyMdf
X-Received: by 2002:a05:620a:269d:b0:939:6de9:208b with SMTP id af79cd13be357-939ea2b3827mr16779985a.48.1789066274997;
        Thu, 10 Sep 2026 11:51:14 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f184f5sm49053285a.15.2026.09.10.11.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:51:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 10 Sep 2026 18:50:35 +0000
Subject: [PATCH RFC 12/13] rcutorture: Bracket Tasks RCU readers with
 trampoline nesting
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-12-d4469f4cc101@toxicpanda.com>
References: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
In-Reply-To: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2

rcutorture's tasks flavor models a Tasks RCU reader as "any stretch of
kernel code", and rcu_read_delay() deliberately preempts inside it to
check that a preemption does not end the read-side critical section.
Once preemption outside a trampoline becomes a quiescent state that
model no longer matches what Tasks RCU protects, and the readers would
report false too-short grace periods.

Have tasks_torture_read_lock()/unlock() raise and drop
current->rcu_tramp_nesting so the reader models a trampoline, which is
the thing Tasks RCU actually guards; the deliberate preemption inside it
then continues to be, correctly, not a quiescent state.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 794937e13e7c..df6dd708cea7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1144,11 +1144,17 @@ static struct rcu_torture_ops trivial_preempt_ops = {
 
 static int tasks_torture_read_lock(void)
 {
+	/*
+	 * Model a trampoline: with CONFIG_RCU_TASKS_PREEMPT_QS a preemption is
+	 * otherwise a quiescent state and rcu_read_delay() preempts on purpose.
+	 */
+	rcu_tasks_trampoline_enter();
 	return 0;
 }
 
 static void tasks_torture_read_unlock(int idx)
 {
+	rcu_tasks_trampoline_exit();
 }
 
 static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)

-- 
2.55.0

