Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815116;
	b=FwbgVCC48EqQe9CHVjlFRkflIm27HnjDRihikJvkarx/RZkIQkhyAXP+KkAcwfaK13xN
	 X97cs/C0z8YbMP2y0pwMIeifGmYbXLERWb1TXjdwePDYEr3/8YGpBrgn0BqwauGQC9lSt
	 xy74ufQnfwXBD4iP4HsknhSnNy1nwBRQviqDktMnlHfkP4pV3mc0eMlY7+yCk55pXUOxv
	 k1lOAAftcOoZ9DTcHLSe7Cm4nnkfgARPgoF5YIgL3IGkSk6yg9qfrR9DGdUg/cPO58r6h
	 2DEBBn00VQ9IjVbN0Hldlno18Z/uGvpmFzRkjubTxj38DGRr5v3IelhVqvkJG6QcMfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ozgIPcufN0VwTmoMbHvCE4hmUPjkUXY6RFC3n6CpNkA=;
	b=jPszd0EJ4PtAxSeQAQ6cw4HCgODDNsj+HuxulQ1jMxYHAobF96jZsoU/jgwkkZVJ0U/k
	 U2W1E2M/+AYTsnyPkAs041jJrcFSwgIu3VjGkIUmel42V/+qCtTGqbGCfu+VUcCboQ3aJ
	 O08N7Y1cFd7Ww8kokxkPjNAFrA6RI+jEU/qWu/IpyHCjoybr9+sj2KxdxMLp2Ftd0mYaS
	 jAnAZ58C3kemKhULn45o+X5zcK9srmatpLqan8kxdVwam6MApZWlx5bjf65/IClSurIo4
	 uscOy+93gdGL8nx9aBnCLkOtRzXoX6n/qY0mZFrENUpbSYoVs+COLERgThHjSjxtYtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Xx4WqCB5;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0E606A32A
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70F0E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Xx4WqCB5
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso4012647eec.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 23:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815115; x=1795419915; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ozgIPcufN0VwTmoMbHvCE4hmUPjkUXY6RFC3n6CpNkA=;
        b=Xx4WqCB5tqlm/KTL3SAJr6Dtd+Ir7vI1HhtYWz+62n2w3bhRjWkHXZqiFE8EHcuw10
         uCEyDlyS6ZNBw5hoUyJ+Livr73w7IGedIzEULjacdTayl+wRIE3ih6BDHq8KFaEGy3tB
         tFpQSlDYkYR9ZPN3Pk4Y9cSBfEvQ1y0okQS0OhFGmM4lspLP1yskDd7WrLAGxDFX/n7G
         Q77bug9WPdcUcHYbD3fiqBtBj1MbivVRY2RTDPWzFVlbebNot0KXtiftS/JkDG6nmvzR
         j14q85spUoAInJ0NQEkMT21U18RzskhhGgPUlK5fUJWGCJYlTYEO1wIskWk5JNF7s2z9
         6agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815115; x=1795419915;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ozgIPcufN0VwTmoMbHvCE4hmUPjkUXY6RFC3n6CpNkA=;
        b=uBzTZZwWoSB7ovQI6w2wRIFt3DyRHMUYg4McCl0sPZ6hk07Um0GHdf3jozB9e8ez84
         mt8tKJeOCqjoNXaKO3iqtC2twme5QeOLP+OrXHk8IURJKpx6P0wbvq0WgRZ28L6EmCau
         PcWecQaCdbEy8TXoo8Xckjv+A1BLBvJHJ5EtceO6FeW7NVnd9Ymrnavkv5X11HYzyN2x
         peGYaOzveEGPStOGihyvISdtwaP/zgzB7I04SqxbS7cxIfGoiLAGuoegcB+BR/e02z2j
         W5UHc79WSs4IK0dTOkGYyIiqySEZP0YsCpjQWScpHveDBRwiraDMIJ/bq8UvqfiT5BB0
         VRKw==
X-Forwarded-Encrypted: i=1; AL+hErEaVpR65CfZl2qIveYe7gkAmB2De5mfucS+UN6qMI4VL1Cym/lexil8pLjcVHe3vDqx0Cc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+e5+ulEFDoQh0g6ncgGTGqmF7J31kmHvLjrcnnoCuhGwr4CqNG
	NcqAupZwkqreDqKMdsGtvUvFehSvyE5jB3p6ifXpPbc8I/zjMKVIUTy2x9uK9AvrkrwbsKHpWqL
	cI3i4o48JRg==
X-Received: from dybgv25.prod.google.com ([2002:a05:7301:2319:b0:36f:5688:8a11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2a16:b0:369:fa21:ba0b
 with SMTP id 5a478bee46e88-3796721cfc1mr9291632eec.33.1794815115033; Sun, 15
 Nov 2026 23:45:15 -0800 (PST)
Date: Sun, 15 Nov 2026 23:43:59 -0800
In-Reply-To: <20261116074414.3174737-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116074414.3174737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116074414.3174737-5-irogers@google.com>
Subject: [PATCH v3 04/19] bpf: Export stack_map_get_build_id_offset() for perf events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make stack_map_get_build_id_offset() non-static and declare it in
include/linux/bpf.h (with an inline fallback when CONFIG_BPF_SYSCALL or
CONFIG_PERF_EVENTS is disabled) so that the perf events core can reuse
it to resolve user-space instruction pointers to build IDs and file
offsets.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/bpf.h   | 14 ++++++++++++++
 kernel/bpf/stackmap.c |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 31ff71d829b9..9b2ca352ac6c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4503,4 +4503,18 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 	return 0;
 }
 
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PERF_EVENTS)
+void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
+				   u32 trace_nr, bool user, bool may_fault);
+#else
+static inline void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
+						 u32 trace_nr, bool user, bool may_fault)
+{
+	for (u32 i = 0; i < trace_nr; i++) {
+		id_offs[i].status = BPF_STACK_BUILD_ID_IP;
+		memset(id_offs[i].build_id, 0, BPF_BUILD_ID_SIZE);
+	}
+}
+#endif
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index a19126f5db02..11f6349b2b8d 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -406,8 +406,8 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
  *     id_offs[i].build_id is zeroed out and id_offs[i].status is set to
  *     BPF_STACK_BUILD_ID_IP.
  */
-static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
-					  u32 trace_nr, bool user, bool may_fault)
+void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
+				   u32 trace_nr, bool user, bool may_fault)
 {
 	struct mmap_unlock_irq_work *work;
 	bool has_user_ctx = user && current && current->mm;
-- 
2.56.1.703.gf848ed807c-goog

