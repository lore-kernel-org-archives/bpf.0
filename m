Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579291;
	b=0NFky005wFNQwMAcVt38i9lVHKEvPdWGxHRCT6Weake5wqntHSELrGyI45EOdgobG31Y
	 UUZQqy+qMZZ1FP/mgCPqCTSbwZ1Q3XocSK3n//CKnKVqm4jAdGoZmR30cDzfzlQVxKohX
	 h3DKsDGVJ+O42ZyvWAuKfKQ6eNNSyBHRreRbdDb8JYjqFGlYmGn/ZXbbWOEJ0KL6SOWks
	 vWw5anNS0YZChppoBAI7+H/2L18jtIarKpzG+dYY8ulF9qqScjrZ1n6MRv8eO6UqbTjGW
	 71l33yUSEILARhvqEs3b9EYB7lSYWe0INQYX/PQWqRyfhAD4UavJdx5yBvuNjxDR64w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6REgkPS8nzDDPYO6M6ZYR52ogu8+a8y/VCwAF9sUv5o=;
	b=UHnFkoZ8Y7jhhmfIKT6jXfEoaX7ux+7KxzkA5mzH0TAG5EYwKIe8+k4ZfkJ9OO0uZj5/
	 P9a7PAiVcMnRR9nWfQAOvm1wNwOgjNEBLIYVYNzp9PRtOYsM6S/Ej5ZmBnE3FegfWGG3Z
	 BTyxwGW/AaFBsRJ6vnEHAuSImOoiDb9i6VAsnWoA1qtSDBgqp0ec4hituDDlb0ZMxTsW8
	 mVd1+ZvEPZvgkg+IQ36UEQsWyE70Jod/Ejh+e5qMp0lX3uIAoUK+rJEETtqbIv6ElvohH
	 YZFH4DnLfQQt61bKkcffmqhThoTWNee4SFCxmDg9ChriB+vPIIh1u3iRUiARp+EdjrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZT78E86w;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC1606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77BC1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZT78E86w
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-385d8a00598so7781518eec.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579291; x=1796184091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6REgkPS8nzDDPYO6M6ZYR52ogu8+a8y/VCwAF9sUv5o=;
        b=ZT78E86wQe3bgt5nxImE5+aVBs7YtYvND66iVpyhs1/A9gNHPkXnPWIFJTwm6HEtmj
         k22zmdcmU3/DR92JOkZ2XTpF3ZzjuPFZPvQXXi5LlK5ozQztsKXJhclNqRSxc7u1JBRR
         hVstKwp7XzzEaBvmewUFjLvKvJuVPJu+blAcCzgfH6BFOH46y1K2IdTuqq5MlS/dXXKC
         vrS9A5jrqkfSYpZnZWh/YTCJuv4YiBCuqCIaM9s1kiz/manx5VCl97QbOrOsuMUjp5eh
         ZKEcl5P32ExOK/pMkfDMAXjTwxs2MMYhaYTIqZejtG9+YDkt8fJ12jYor+qYuawzHxcs
         CG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579291; x=1796184091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6REgkPS8nzDDPYO6M6ZYR52ogu8+a8y/VCwAF9sUv5o=;
        b=vUbcNhnKz4Rg1uaFOrniab0cjM1/L4sqQm/6v18qY9n++LWiN9dpehj2QYIpYnoFd6
         3tW8Oqiaa3KihH2Xbh41yFl2fKgsq3xn4Lj6BEwslYowG2D1uYp2B70jUoyFeV6ee9u8
         EZC0s9HUUgnUN/4Uw9pH7u5H3buLNTRKWSHUG3FdEXgBwganLCD/s2/uZL0hPrifcVbg
         W9DlDRBnYGJjlx3ojpZb4c38BnZnBs6SK4Y1RZ+ryCbxDV7PFE/dlPPuFMEc9QQN/eMv
         rdwTAPuqNpANroltZj56TJAoeJ+NjwSR35ozYXoh4ZZ1vyu7kWSeoc1CiF2DIAaKiMeL
         d1JQ==
X-Forwarded-Encrypted: i=1; AL+hErGYiOYONJRIvnFYnwAWblSKxX/WZMINnViuTx9O8LJECEz2Lrohe/gaPwyzTxEHtNEqNYM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+z7yITew9Gnl5RtdxPwC5M/iddWocFhvTh9Vb4esOZAAu1g19M
	dmgXc9FRIlZB+5EQ8QCepuLaldMvjatvShFTHtzya+xOz0HtnhAl/kZF
X-Gm-Gg: AZFdTZeXqADvUwb1rmQdtNf+eTIC5HlJ9a98r2/rgMVA6jQQvHjcYXKKEYygeLMEWtM
	oVol8cJgxglna+RPgcyM4Ayfd0E6ACKD3OzyTzU7BIPBp7BwSv/DBudsY1ElhHxwT5jBMKoCHvv
	vAVc99erOXZs4LQQspmmIwdnolaOImfLmswXNCnb90/IeKguVIoeD3rT9D5U0xgQX2AcFWjghH4
	Itl1sG5D528WLtZJWK/VKOqz4emW9E9BXTO9niVdSq1awcBGXa4HyMNGc1bWtmBfEw0gZNLzWXG
	TZ9ebFJXvNAYN9XhgoDIwA1vfaYjCVfha/pxSs7stlmJqV8EsvpCX5Xu8w8ON+L2Uk7Du9aO4ae
	epn+14TopnqKJt8/PS+jSF0UZ5aSrS+imYJhgT0mKvpHylJUBUD+eEFinl6bqIR5/g4WCN2wccY
	1u+BI/EPJzfcxh5i7zJKJiovtTqqdCRl3A6x8BnrFa2DJ4VJ1PE5PaLq5lxQ4+Ax1WCoV+WNzEG
	Ot6PR4B3MXJ+nF72mQIhDyPJHsZ6M9KqnLVl0gTIvADMQjC9DBjPnCSdybGBcsbXfT0yWiMCPFC
	vyCvX9bxS/kSZXjr3qUTjQy1s766d2B1XA/ZcqRqIJddWnBrMORan/zgALuFiL+tVw==
X-Received: by 2002:a05:7301:2419:b0:367:185e:867a with SMTP id 5a478bee46e88-38571027a5dmr18690085eec.38.1795579290373;
        Tue, 24 Nov 2026 20:01:30 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm19892400eec.27.2026.11.24.20.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:01:29 -0800 (PST)
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
Subject: [PATCH bpf-next v2] bpf: Add rcu_read_unlock_special() into btf id deny list
Date: Wed, 25 Nov 2026 04:01:02 +0000
Message-ID: <20261125040106.2200628-1-rhkrqnwk98@gmail.com>
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
rcu_read_unlock_special() too.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
- Deny the attach in btf_id_deny instead of marking the function
  notrace (Alexei)

v1: https://lore.kernel.org/rcu/20261124185659.1370644-1-rhkrqnwk98@gmail.com/

 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

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
 
-- 
2.56.1

