Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2B2F7EE1
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786420921; cv=none; b=S19SqMBmcEKSRkVYX0LSjk6KadYebb974Hh2uYBNlQRabe4IAgHu7uJbdiu04AGTwvhdHbXl7HyMzHTlFcSFe1h1IpkDDVP9uYvoU4qhUVDalo8ylwCJ0Qh36NlBQ1/jQNf7i8A5jxzuf6HrFW37ALznLB3mCRyZF8snYyMbyAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786420921; c=relaxed/simple;
	bh=wyrRbzBCRcFfgGyw6L0mkv5rVWa6/BFxWE6D7AqovX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7+cpo0pwm+I7FXVifWrOgE2/eZjtO/GzIzgsUdqR8S08SQjvdeFOycbNyExWnB2AtsT42va6en28Ej7Ac4TXMo0rstNPn2xh6gN01G8hfZqTRv8lmQESSxdegBkGTKa5ISyCBvkeBGfx7ugMdGFnq5R2a8XDGIfClDSkRIc2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3vFiTOY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3vFiTOY"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso2475950b3a.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 21:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786420918; x=1787025718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ht8yfAM2PTIYfCuXzXj9SbALgiJ1GqBCtjRB+c6/JlU=;
        b=j3vFiTOYzUJHgn2eJy0FmYQeq5OUcuUSqij7IobVMl0KfAleE+Tm1xsyz5GlV7JhSe
         tI63QlwSx9kcoUI6JVLw1adTfDf93m0GAnBzHYWwPax9w6jCZZFFAstCjaXzA/nN3mEW
         s6Xctx0Mb+4c7hRcXnR0AxdBoklzZPmsqzRq5w0BnHS433D+ix0U/55/7cgpheAG0NfS
         79TFqQZzCSx45hU4jwnfZWsD/5EokPaMjvWANMURuHSnbXueMVJ36hFaPkuufBpiydqy
         uijvvAX3K3NYW246MrwPwYVdCMrVlyDxVOusU/F8XzAnernOXxgNRcgfMxzsAGIaHfti
         JqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786420918; x=1787025718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ht8yfAM2PTIYfCuXzXj9SbALgiJ1GqBCtjRB+c6/JlU=;
        b=JGvqUY+xSJUXb86wOymsHwOXKAoYvbSYy/1YZ7CLtEyM3RVil9riarcjonzpp4krNR
         NCUhRKMREHbbjgLTPq57khzYK7Kz2ccktecrf/C6lyNr5H/9m6PZsCn3NYh1o2F8hw87
         s20F6vcv0+vJMHJB3FTfixUuCeelGyUCwNK+hSfKmG1mylwh7hovnPCgkGRhuJt37Igw
         QH19VyENkoQEyTP1ZyXc+QiNshPZUyQQnWh6CAKiP8r2MDuKjYfG2bgh1pOpBKqk8Wbu
         sWrGm72SXey1/wdlN7SQiQz/d2vUnrEBeKU2HMnBLngjEGgOyt6z2/qPoyf+/ntrJN7q
         ecqg==
X-Gm-Message-State: AOJu0Yyt/QS4zsnmalmK4c5Y5/eygT8NNFeAssgqdZm9jUZli5w0KcxT
	Pbr/cf5nZ2HSVbw27dj7r6BamE3nhZFc83dTKM/inGAPiWst7BtO56ckWb7QmA==
X-Gm-Gg: AR+sD13/Q+gBRRmMW0bLRnSqrn/fmpt2HG47BskdDoKI58oMLTQpK2d2Pz+epOtABEY
	f4GyAsoqK0LL3UbZGl1J3sWkVP1yT0VtSJ0pRs9O7RRKJIw09bGQfNCfO0uoAqfu/pVfHYC8/Om
	CV1B0JSP/r8TLOZ4flEJTwan5u1FwavqDzFXEw7c+bQ+LwYeMyvMVfolK2jGzDjojg+lMpykc4Y
	wrQIWRf9wxLBeprV2DGURNq6Y/jTQ0TZKOoQpyioRktAb7iN7laBT88LMNdZzV3w9XgT+tPnA++
	GdnVTmEeWvpRDHkpUAFcYrNCoBxtVJswat3r/leYvURG8aQ7CLDWZMg0CURo7NxXgfRYlh9wQ7Q
	//OMCrWVdbw4KshkRuXZzPn85WM0dsJHZu8V9TA6f4lExytT07g1qyH2e1873dB2lsXCGS/i7aj
	j1mExs2VztXipXZLJZUL/1v8wPYp/E6mtSsr+UYjIG6aKzRVWAV5OGNH7C0Gavx6BvYq1j1NiA9
	XDEDmuDuxRc8DlAcEmXMEi72yg=
X-Received: by 2002:a05:6a00:987:b0:847:7f3c:b5f5 with SMTP id d2e1a72fcca58-84fa869923dmr299588b3a.11.1786420918167;
        Mon, 10 Aug 2026 21:01:58 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbed8bb9569sm163683a12.3.2026.08.10.21.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 21:01:57 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Ning Ding <dingning04@gmail.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test RCU iterator state pruning
Date: Mon, 10 Aug 2026 20:59:55 -0700
Message-ID: <20260811035955.132989-3-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811035955.132989-1-dingning04@gmail.com>
References: <20260811035955.132989-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a path where RCU protection reaches zero and then starts again.
The iterator is untrusted after this gap and must be rejected.

Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 .../selftests/bpf/progs/iters_task_failure.c  | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c b/tools/testing/selftests/bpf/progs/iters_task_failure.c
index fe3663dedbe14..566a1d3dffeab 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_failure.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
@@ -61,6 +61,52 @@ int BPF_PROG(iter_tasks_lock_and_unlock)
 	return 0;
 }
 
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("expected an RCU CS when using bpf_iter_task_next")
+__flag(BPF_F_TEST_STATE_FREQ)
+int BPF_PROG(iter_tasks_rcu_state_pruning)
+{
+	struct bpf_iter_task it;
+
+	asm volatile (
+		"call %[bpf_rcu_read_lock];"
+		"r1 = %[it];"
+		"r2 = 0;"
+		"r3 = 0;" /* BPF_TASK_ITER_ALL_PROCS */
+		"call %[bpf_iter_task_new];"
+
+		"call %[bpf_get_prandom_u32];"
+		"if w0 == 0 goto unprotected_%=;"
+
+		/* Keep the outer RCU lock active on the straight-line path. */
+		"call %[bpf_rcu_read_lock];"
+		"call %[bpf_rcu_read_unlock];"
+		"goto merge_%=;"
+
+	"unprotected_%=:"
+		/* Create an unprotected gap on the taken path. */
+		"call %[bpf_rcu_read_unlock];"
+		"call %[bpf_rcu_read_lock];"
+
+	"merge_%=: r1 = %[it];"
+		"call %[bpf_iter_task_next];"
+		"r1 = %[it];"
+		"call %[bpf_iter_task_destroy];"
+		"call %[bpf_rcu_read_unlock];"
+		:
+		: __imm_ptr(it),
+		  __imm(bpf_get_prandom_u32),
+		  __imm(bpf_iter_task_new),
+		  __imm(bpf_iter_task_next),
+		  __imm(bpf_iter_task_destroy),
+		  __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock)
+		: __clobber_common
+	);
+
+	return 0;
+}
+
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 __failure __msg("expected an RCU CS when using bpf_iter_css_next")
 int BPF_PROG(iter_css_lock_and_unlock)
-- 
2.43.0

