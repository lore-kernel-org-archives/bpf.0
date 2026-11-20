Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795172380;
	b=AFyzYNag43WEIbMBeuCnW7A9UNns7iroCilh/IrTSIo/y98rd4/kTwhQ540g5wAN4JSh
	 b3Tyc8iMBv7rbacqt1ONyQYjf6n3/e0vxkeUICuf29WiT8g4+tS/x03UkBWFnajifcGJ8
	 ytpAlTg1A0HFipq5dE1+8ym0QWNL8PCBS10lmNkkrkAb/8nCUV90pzECQZ90hNSHBBQEa
	 bD+xbpeyHgiAGiaW9HK6rGv44SCPJiUQUex26bOP6QD16bpYoeIPkm9cplUpstOD4TLgB
	 jDjGFPFU/3emE1MS39NsoYLUvRzhriGGrRX9lRHkCa4JiIv5x1cOjWGtO8D12z0qIbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172380;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gKB2zN8fHl+v20z/ojO6XPfd7Vc7yeUXwiCeklkycXI=;
	b=wwRELMf3nfDug906wxbiC24KVMIR+AIVzuVvhniHY9wjYW0ofirbGjcTwGKxP4whHmre
	 EmgVh9IHS3anROYISpEQcyZf/yYNsPvy4sdTJAGlVjJDAPCMwMgXnq/XTn0QHs/oHFZg1
	 Yku2Fqae0XXkzverfyoodwGAYSicKD7D+JLRymg+/M44B88k7guTjzmjT6Sj7At9obqJN
	 s+V+VuN0dne4UsRQbjhcfNNYff1/31/zAQzF7G+rFzF1ZRK+AAayUElqXVnNxV/xI1/5A
	 im9+hqhT6JSlGyBF0Gn6RSmfpFYT7CtThxJHYT/eNlC80qfjqMOSSD43khZTU42xQcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HqrK2iDh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDEB60A260F;
	Fri, 20 Nov 2026 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HqrK2iDh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795172380;
	b=gTJ1clNzLpIp4f+bVMJ/muHycncJtiI8xo/VoLbcKYnHhaXN3Vwzn1hZQ9H5Yb7dM62m
	 4nfos+Ydf/SgUbz9y40PY1ceNvEqtGxndcUtD0mxgT4WVmC+LH2SLmrF4X9UgZQdQZG8U
	 Bn+yUzUu3WYbhDWU7muM6A2hrQJ/yNd2EsOtm5442kleziyjRBrW4rbM54/cyu9mq8IM8
	 7iZbYeRBy3YTKCogjB7CFFqS6OeJwo8Z5wqBfzlWgUd7r8Z6bVH+z92FvMpfcRsAKFxuE
	 k/EcIiKSIKj5zNuc41BQ9JQ9rLSCGiU1yFJVZ5EMDVk+CVMs9IhUhz/MHc+w9xngy4Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795172380;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gKB2zN8fHl+v20z/ojO6XPfd7Vc7yeUXwiCeklkycXI=;
	b=oa4/ep5OaOOhPti/I4E109qbM702Vv6pXFX9rnmO+/1jN351kOmx9Fd+6tnAygbPxK/t
	 Af6DItVcmvEz8HMDwA5m7Q4rjc/6+jLVNFkfRuyhhAb4P8rT/O/+eGVAL4vcBNQvQEPKx
	 WJ+WQXA4PVDeRtm4pkteuTvezSsWZHvCv85mhMNXLEYw3MG+Mnlt7YLLUyLyPBQrkwQ3A
	 gnVtNUhjzuUTGZn9sIwwed4SixGwAfFj+A5dYITzkXjx5aRtNnj6mhNF8NBbd0rGKPGNo
	 wLSqza8MFokybmkmGKsA1AATRyQ5i/NCfbU/lRkNq1QLxbTxdOuk5gs1NTXTH+aZOxw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 90CDC1F000D3;
	Fri, 20 Nov 2026 10:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795172380;
	bh=gKB2zN8fHl+v20z/ojO6XPfd7Vc7yeUXwiCeklkycXI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HqrK2iDh2FaehwB1WyGjixhIRK5MC8Ex0Ry1Mn0g+AcSnEO8vGtMHNr9RrVv74yzO
	 LxMXDKrFY9s5VbAElSltKgPCaKyX2eP3Bhm0F8BPx70RYB5oxYDbPKtBzxwDHob0z2
	 VtpiITuexON0ZM/pkFOJQPK6rN+NQtzQcQLecobEoticTIfxsWuG7USEJri3hTkHzA
	 LpiL0Q6sicQE86ULou3p2E+pezP3b1wTShUgKIi1ulYG0GqQx8a7kfGvFa5Q6EpiH2
	 2+GN5TT0D7CZKq13M3y679ZTo/kSQIub054NvvX2V7myGACyL7jiN2+S8zlpz+K2vC
	 yUBr13jBhvX6w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1CFA349826;
	Fri, 20 Nov 2026 10:59:25 +0000 (UTC)
From: Mike Bazov via B4 Relay <devnull+mike.bazov.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 12:59:12 +0200
Subject: [PATCH bpf-next v3 2/3] bpf: Limit nesting of mmap_read_trylock()
 in BPF helpers
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-bpf-raw-tp-regs-preempt-v3-2-ec109009a5d2@gmail.com>
References: <20261120-bpf-raw-tp-regs-preempt-v3-0-ec109009a5d2@gmail.com>
In-Reply-To: <20261120-bpf-raw-tp-regs-preempt-v3-0-ec109009a5d2@gmail.com>
To: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
 Matt Bobrowski <matt@bobrowski.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Mike Bazov <mike.bazov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795172363; l=3076;
 i=mike.bazov@gmail.com; s=gmail-20261116; h=from:subject:message-id;
 bh=HKoapPVt+y68Tmqmk8BOQ4lm6ZdE9zNq151YdINJiy8=;
 b=FBHB3WVLGm2+Z5TJ4RNHlFPXH/ljQYiLTyzi0rFT/3iP4qs9oFRUjuDAZoYdstzetwlw4TCcE
 Ih8rA23e/cUAEfK+WqczgpuX+Y13GbFzCYkEF31CIzhf2enWOS3Rv3k
X-Developer-Key: i=mike.bazov@gmail.com; a=ed25519;
 pk=Rr9fagn0pNA+bs8tgc6DXZpRAhl/maU6BeqkttIR7DA=
X-Endpoint-Received: by B4 Relay for mike.bazov@gmail.com/gmail-20261116
 with auth_id=1544
X-Original-From: Mike Bazov <mike.bazov@gmail.com>
Reply-To: mike.bazov@gmail.com
Content-Transfer-Encoding: 7bit

From: Mike Bazov <mike.bazov@gmail.com>

bpf_get_stack() and bpf_get_stackid() with BPF_F_USER_BUILD_ID, and
bpf_find_vma(), take mmap_read_trylock() on the current mm. That fires
the mmap_lock tracepoints, so a program on one of them that calls these
helpers runs the tracepoint again from inside itself:

  prog 1 on mmap_lock_acquire_returned
    bpf_get_stack(BPF_F_USER_STACK | BPF_F_USER_BUILD_ID)
      mmap_read_trylock()
        prog 2 on mmap_lock_acquire_returned
          bpf_get_stack(...)
            mmap_read_trylock()
              ...

The recursion check of each program only stops it from running inside
itself, so this nests as deep as there are programs attached, and each
level runs all programs that aren't on the stack yet: the work per
tracepoint hit grows with the factorial of the number of programs. With
irqs disabled, the per-CPU irq_work already allows only one level; with
irqs enabled nothing limits it.

Count the levels per CPU with irqs enabled too and fail with -EBUSY past
three, the same depth as the other per-CPU nesting limits of BPF
tracing. The helpers then fall back as they do when the trylock fails:
bpf_get_stack() and bpf_get_stackid() return IPs instead of build IDs,
and bpf_find_vma() returns -EBUSY.

The counter is per CPU, and programs with irqs enabled can be
preempted, so a preempted holder counts against the other tasks on its
CPU. They can hit the limit early and get the fallback; they never get
wrong data.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Mike Bazov <mike.bazov@gmail.com>
---
 kernel/bpf/mmap_unlock_work.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.h
index 1834db20b..02af564e6 100644
--- a/kernel/bpf/mmap_unlock_work.h
+++ b/kernel/bpf/mmap_unlock_work.h
@@ -13,6 +13,7 @@ struct mmap_unlock_irq_work {
 	struct irq_work irq_work;
 	struct mm_struct *mm;
 	atomic_t active;
+	int nest_level;
 };
 
 DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
@@ -28,8 +29,16 @@ static inline struct mmap_unlock_irq_work *bpf_mmap_unlock_guard_get(void)
 {
 	struct mmap_unlock_irq_work *work;
 
-	if (!irqs_disabled())
-		return NULL;
+	if (!irqs_disabled()) {
+		/*
+		 * mmap_read_trylock() fires the mmap_lock tracepoints, and
+		 * programs on them can get here again.
+		 */
+		if (this_cpu_inc_return(mmap_unlock_work.nest_level) <= 3)
+			return NULL;
+		this_cpu_dec(mmap_unlock_work.nest_level);
+		return ERR_PTR(-EBUSY);
+	}
 
 	/*
 	 * PREEMPT_RT does not allow to trylock mmap sem in interrupt
@@ -51,12 +60,15 @@ bpf_mmap_unlock_guard_put(struct mmap_unlock_irq_work *work)
 {
 	if (work)
 		atomic_set_release(&work->active, 0);
+	else
+		this_cpu_dec(mmap_unlock_work.nest_level);
 }
 
 static inline void bpf_mmap_unlock_mm(struct mmap_unlock_irq_work *work, struct mm_struct *mm)
 {
 	if (!work) {
 		mmap_read_unlock(mm);
+		bpf_mmap_unlock_guard_put(NULL);
 	} else {
 		work->mm = mm;
 

-- 
2.43.0


