Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980628DB54
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893294; cv=none; b=Eyc1tb43GSNoaAX8oMuVnYEY3b0DMyKlP/Lv3BNoC3e+kNS+NR+YRuHlpcWc5ZED4/8HBu6l3IlEKEDwJ+hxNZ3xpnXTSlIb5tu2Q0tsh1qn1Svi7c1dVYitNHG4WOhlDqsW4wBh4YIrmj7LDB6dupVGFK0N1lULT0wWvsZquBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893294; c=relaxed/simple;
	bh=nvNjJxN8d7S7fwFmCmCVHAK94UdVcm9NUdeYMSQFoRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzQk2bIlJCkwx0gxopctc8kRgeECoLKdo15samtNj9iWpkz+jwPBG7z/isJzFD80NZN0bnRLeJz00M5tKtbApFlKVl7titb2AYOYzvXpOO32rwgBDufBn6V1L9Y4G9Cj6GFbgIb2ujmX2sbPL0HbgkpY9TpBExyEqTtuujYGJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2pwR7zN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2pwR7zN"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-845c92bc464so232382b3a.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782893290; x=1783498090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dr3ca9Gbche1v8ZCkSbyudGXgkkz76Bf2v/z4hZeM2M=;
        b=P2pwR7zN5bKIi4llG30rY2wHwnCoVcyb5DsnD32qDG7SHl5NvgrhxS4oEkpIGUG/gq
         Ba9zKX3rciKz4IoOKMuOU/l3WVg3OAdiVmkqo0emvr/VedT1csK09U492Wa9yZqArBeg
         GsomI9ToGZhdF4BbS1CnsOMErHxp5tPxJ2DtNH8oZb8BJ+t8rfI4SHCyHajIfzTS3TiD
         qFnpf7tLrLBiWB3cw+3whYYQoeK58SZ3F2+WCE8l5gJ7hZ4XXuSvKglQnCKVxzjpX5By
         YRZStcin7olFCYEk6dFbqTahcDqGdMvzF+OPv+2oOc2rMn2ydUjymC9bZ48RqBSJgOVv
         +Qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782893290; x=1783498090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dr3ca9Gbche1v8ZCkSbyudGXgkkz76Bf2v/z4hZeM2M=;
        b=UvUWnNN4VaMafLxfZhdd2kS94tKOIl/z7y8PvYIc86dm1sVj3WJQVeNMcyAc1biRyH
         HdKxcxZvcMeMaYSjtCx7kfJZqQ8F3up/KCcals0I8UlpE/1WURj/Duz22KJwl8/Shsm8
         fby0TzfpXe+oLQulEosf5ZnYrbO2WrSgdErp+YTHBwP8Jzu/aB/mve+WrMF8ioKJ9B5Y
         DP6jlIl8fcSA/mA4BIQSj0eaVeZmXONQSA65ByzW0Ube0KCbubeAftiJpXnij7nqa3R6
         0/bu0arRbHgcQflkI/4EsbOKaG2QVuY2t62fEySXxXnYPLwOaZmRhsIJtgAiGQMNalfi
         9Obg==
X-Forwarded-Encrypted: i=1; AHgh+RraL08Yc6zCCFpdQq4apNmz28SRIRiRnzsR6SnAMc1ntQj+vCo30bJrhrKUKJ2udT+e8Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywon/93FjyZa13xl9QYVcs+PSHUp2SqteLOnI+pIFRGw6ll22f1
	Qzs2qR4DTbgKxpoIoaQ3PQ2APqElb0HDpz1VM3xhz6+MleGekiJ4ClBW
X-Gm-Gg: AfdE7cnK+EclgbLCSABMPd4Hz5FbE4jVn+dLRY75xOV6aGho5WUc/pH4kBUD2cWWri+
	62By0QInki01ynE1BvQw/tcZhW2SlkkSkt+eSQlGFCJY3hau5zr5FiiC/dcUynMTseNwn3g13O3
	maGwlLSGK1eUAyy67Bjek7RULx1BC58Xn+nGEgoZ+FQbwgFys8qUNylVJ9XIS8rGyU8yBxK0sYD
	4srFOXSYuKentV8e6JqskuKxwTSYhzvO/08cN4DeyyC8umyBOiK8RDMhHM9ZitnqxjMNueJcZkl
	Ankolx+wrPJ1A79b59xDFPzZCpQkRa62vSJIFe/QBQC0uWRRf461JLI6Njf11PGRlMCAcWds1Lb
	d6rf1PRnrBah3wbEoQ6w72H++sqM7RdOIO8r30d+94/20sIi4WaCrIajkoqqmhRuPArGy781ZcS
	b3Z3QedF3E+ljccaKO2CnSK3VkyrL0lazpv4ZKUCzpGK+CFWUEhEQ=
X-Received: by 2002:a05:6a00:2d05:b0:842:5a8d:302c with SMTP id d2e1a72fcca58-847c093f017mr478860b3a.38.1782893290425;
        Wed, 01 Jul 2026 01:08:10 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479fffa4f0sm3567781b3a.19.2026.07.01.01.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:08:09 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2] bpf,lsm: drop bpf_prog_free from sleepable_lsm_hooks
Date: Wed,  1 Jul 2026 08:07:51 +0000
Message-ID: <20260701080757.1394144-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__bpf_prog_put_rcu() is the call_rcu() callback for non-sleepable programs.
security_bpf_prog_free() called from there fires bpf_prog_free in softirq;
if a sleepable LSM prog is attached to that hook, might_fault() BUGs:

  BUG: sleeping function called from invalid context
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5038
  preempt_count: 101, expected: 0
  Call Trace:
   <IRQ>
   __bpf_prog_enter_sleepable+0x1cd/0x320 kernel/bpf/trampoline.c:1255
   bpf_trampoline_6442549705+0x53/0xd7
   security_bpf_prog_free+0xde/0x130 security/security.c:5465
   __bpf_prog_put_rcu+0xab/0xd0 kernel/bpf/syscall.c:2365
   rcu_do_batch kernel/rcu/tree.c:2617 [inline]
   handle_softirqs+0x236/0x800 kernel/softirq.c:622
   </IRQ>

The call_rcu/call_rcu_tasks_trace split reflects the freed program's
sleepability, not that of any attached observer.

security_bpf_prog_free() also frees prog->aux->security, which has to stay
after the grace period, so drop bpf_prog_free from sleepable_lsm_hooks
rather than move the call. Non-sleepable observers still run there.

Fixes: 1b67772e4e3f ("bpf,lsm: Refactor bpf_prog_alloc/bpf_prog_free LSM hooks")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
 - remove security_bpf_prog_free from sleepable (Alexei Starovoitov)

v1:
 - https://lore.kernel.org/all/20260626093711.2969648-1-rhkrqnwk98@gmail.com/

 kernel/bpf/bpf_lsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index c5c925f00202..d2dd5a1b557d 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -292,7 +292,6 @@ BTF_ID(func, bpf_lsm_bpf_map_create)
 BTF_ID(func, bpf_lsm_bpf_map_free)
 BTF_ID(func, bpf_lsm_bpf_prog)
 BTF_ID(func, bpf_lsm_bpf_prog_load)
-BTF_ID(func, bpf_lsm_bpf_prog_free)
 BTF_ID(func, bpf_lsm_bpf_token_create)
 BTF_ID(func, bpf_lsm_bpf_token_free)
 BTF_ID(func, bpf_lsm_bpf_token_cmd)
-- 
2.43.0

