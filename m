Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D35013B9
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702185; cv=none; b=B7GonaDKEK5xW96CiavwjB9gRvIr/lKCKiWegRC+pyhLwTy2nYd6UXavVhS1xMb3kJuJDKormQWiDj7gOYXCnjPxH2LAVfKbhYiKg/+4CgvXzljO3hZrQVCnEXgtrzg28cpw4AnWhFKq2RU7SiGRfb/5FLyG+41f0SEZBmGcS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702185; c=relaxed/simple;
	bh=O8YdW4YSHUYyF3GwEQN16WzJM7UkZZFfh8RzVwv7xJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AbbdlJUw4pSyYvDpYJYzzdKS0GCYRzI0NvyIJtH/MCU0oXmTqHtQ1Ac1HRzlfB+bX/Rd3mWOl/kitZJtK8O0PGhBc4K6Cm39uG+GfXXZyeRuJMjegZF3f0nD4nFrYM4ZayYvRe4CBk44IUDfytXQfjE5sXdHkGE3NGJDeyioe4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=RdaydNM3; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="RdaydNM3"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-914446005e8so34586876d6.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790702183; x=1791306983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MkP56mJgKixcgLXoBxrfzz0NyJo14L+hjKFrNfKE/2k=;
        b=RdaydNM3P3WI9DRxOf9UXQckzoS3MeQ7aF3YGbSZIsbgTwsVj7UlwtpRjOe2RhLpfd
         UafjXQY9G9c7DjNhiIZxyLYTBsgA2YnjM19keg9zXuJ+ghbSwa0jI4zwL+wdi8kETaGQ
         Z8Hzs/QZCLA+qtcjG/ZudMiTv0EWBrdxiEJqIuiUZXNKeDS9UasjWAcj6OEHpNBFJyS1
         HH05nk+1lMUXRI/In25sy7oL9e4n7KALFckZl3KeF1b6Htn25cvNI4BNpK1Bsxk1iexn
         vtAYgEc4wL15qXkWJhjoNH1pmg8Ee3mrBJ9JUovWBPP6w2CFrigvl7K7xamz3D6uYgKd
         rVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790702183; x=1791306983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MkP56mJgKixcgLXoBxrfzz0NyJo14L+hjKFrNfKE/2k=;
        b=cWmOpWXpCpR1AaZsD9HnAqLkI2DoePl+TjUmk5ym6iY2jd1drtn2YMT4NSowPFUmfg
         cqTp2KAzBR/Kl96lKlXaZq+9U7p6Nvp7fvsxv/5pHb4ktsjiu33Fs7PkziWOJt3RyV3T
         xySsAWtW1HyVFthLqZa4lc98PrGDF3FmKnnxkKAzJ0jIiS3s8HCWUK/822r/ApPE9HZz
         dXa8xwo0Kcz4Y66+9CCokMZ0C8tvVShsqhuxTlXezcK7tVHDLU7cjSOgDSzj+WgT/Pup
         5yxEslOM6zrhzjTx6SEXoPpc/ltMzrsn2T3OTgjcM/22UelcyUBDV9J6YTFvhND2V58L
         E40w==
X-Forwarded-Encrypted: i=1; AKwUvBy2pFiHUaud/cdz9ovtXvOqBF27hMwn6nC7ATvW4J5NmHlolMf3nTGWIjpeOg5PE6zMqhQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l6yTN6HvgvxlwnMESss4wb/g1OygfeiK0TGieNZ9mEJ+FQVr4u
	mG54rYldCX2R7/2w5b1VXhmOPMe8ZHohwyrCzHZ87xD2IJ1BDtOZWdOXRMyEngqvdiQ=
X-Gm-Gg: AYBFou3gLP649Z9stqb7XbcouQEeYyOJQ/H1blFAhWzcIhq31vM2qT5O15x9iLO+CZ3
	4g254AqmEYFivPLXTss5e1bKgkk5yfGnqUVXiCt6R6UC4PuYeZfl40e9aaOFeDWNlmbxXs2ldvh
	TC0mOhFZN65tBhwGV0ktmvHm0xI92WrBAk3RgJN3nft+V6rdOsbqce5Pt8PnSEIN21TFCWGxEJI
	vKhDp+SWHMUf4MWqaoIow1r8qQqa0yAiNbmKesuF/O2ivXWtMkOihvdvRJhpCp4FHgkYfWiQgtg
	wTrCyzo44xtCn7mXybfPnbiAsMw+ORz/xAKGzYCm+xgilLbYsB0RMaJv0OmIGuWxvZdSu1xhCoW
	0MR7jePReovciITXhci+s3Bqxj4tp3JTFzPGx+g/ZUbwbSijRoYNgtBaDxK9C+QJHTyUwJVyB21
	foSROW2+9L+1or0gaLSE5VZo6Sl8ih5LE6DQKw4n9V/oj/XJ9fGYJq8IAfWgZPYEcM4mGz9ylrC
	+ndrYyEjR0Jf/o=
X-Received: by 2002:ad4:4ea3:0:b0:917:8c86:6608 with SMTP id 6a1803df08f44-9178c8685e3mr38720066d6.42.1790702182375;
        Tue, 29 Sep 2026 10:16:22 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917981f5c18sm546196d6.0.2026.09.29.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:16:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Sep 2026 17:07:29 +0000
Subject: [PATCH v6 12/14] rcutorture: Make Tasks RCU readers Tasks Trace
 readers where required
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-b4-rcu-tasks-preempt-qs-v6-12-c111ee02caca@toxicpanda.com>
References: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
In-Reply-To: <20260929-b4-rcu-tasks-preempt-qs-v6-0-c111ee02caca@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Boqun Feng <boqun@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 rcu@vger.kernel.org, bpf@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1790701682; l=1716;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=O8YdW4YSHUYyF3GwEQN16WzJM7UkZZFfh8RzVwv7xJM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QG3jQwCkEzXVFZFj5OJPsasIxdbQv9M/HHEGtLd8yZhbdChJa1bb33IuFQ5NDeb24Kaa8oYTn7u
 N5DM7Y1DOQA0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

rcutorture's "tasks" flavor has empty readlock/readunlock hooks because
a classic Tasks RCU reader is simply code that does not block.  Under
CONFIG_TASKS_RCU_TRAMPOLINE_READERS a preemption outside trampoline text
is also a quiescent state, and the thing real readers (trampolines) do
to stay protected across their call-outs is take rcu_read_lock_trace(),
so have the torture readers do the same there.  Otherwise a preempted
torture reader would rightly be treated as quiescent and the test would
report false-positive too-short grace periods.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/rcu/rcutorture.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 794937e13e7c..ab870ef09af0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1142,13 +1142,23 @@ static struct rcu_torture_ops trivial_preempt_ops = {
  * Definitions for RCU-tasks torture testing.
  */
 
+/*
+ * A classic Tasks RCU reader is any stretch of kernel code that does not
+ * voluntarily block.  With CONFIG_TASKS_RCU_TRAMPOLINE_READERS a preemption
+ * outside trampoline text also ends it, and what a trampoline does to stay
+ * protected across its call-out is take a Tasks Trace reader, so model that.
+ */
 static int tasks_torture_read_lock(void)
 {
+	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
+		rcu_read_lock_trace();
 	return 0;
 }
 
 static void tasks_torture_read_unlock(int idx)
 {
+	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
+		rcu_read_unlock_trace();
 }
 
 static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)

-- 
2.55.0

