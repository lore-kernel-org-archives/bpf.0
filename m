Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415615;
	b=OJVg5xbzxPHiNyetiSvi8dVdck61DVuZNCOkenWBpC7ABNdJj5NeOAnLeJHGp7qy1+Rj
	 2hpjOmHc6Xs7cnPQd7Dv7ddHV9+/qQStrLVYk6UFdr3OXBaZ9tvaXxRjm8oDCbmiFNDsi
	 g8Wcj9tZ3WKqeFVqWQNWkLLPD4l679rrWbPv0vtgKajraHPMRkE3Ih+cA3yG6BdjProB7
	 8ahDX6ZifrUM/xRR2ipekvlQE4xI6YR7JwInLPAOrkihu55xSyYEPxivXdMoO2woK+UU+
	 5TntY9SPNlutK7pJ5lF3y8eu6bRyI7cNhOO0XS6/Q8sZDHWiZuJqogr3/hqf52sI68g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=00H2MiRz9p8eLUkya05BzpmKsGZ1LM4lgngi7LRL8go=;
	b=Ox0ZSJf7k330BwLP70d892BE1hVLC+HdefRIW9sP3NkWIYkro6rouQZu9gz5jbU1iRel
	 GGG6W6FxvkzR6nc5v0A1RTjgCgRKdYVt/10lEg/6ohoKEXCw6pgt8tBhlobDJ9I3Ntsip
	 zwg/IoRsZdERqgIVLSv2/Fx6vL/b4RipPKHuVKJrDVNbensoU194DX1xOoU7nOsqzYnik
	 dUaBFxv2JnIvI6upF5OAiyfbeG2MhRMxMJFld9hQhGJ9MbZbEQ1eiZ0eyz4wNAbz/wtbm
	 aOE694BNadKROAvUo4Rw/cFlb3Yc8U2alj8FtUQ2M69/bQPBZBDWTX6F9yrZ8RR8v7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dmp5G74n;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B402606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B402606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dmp5G74n
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1348849a12.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415614; x=1795020414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00H2MiRz9p8eLUkya05BzpmKsGZ1LM4lgngi7LRL8go=;
        b=dmp5G74nUG9n5d+vYBQUrgb36L/nKh94AJ5NRWZWd+YWmdRuS9en5fq8Ul2Lho4iZ+
         KlTZ8HIaEs1nMgE4/1NVknf1+0Emipv28OiaXnRYtq+HObzWNfCY5ZYIsR0lPox6ddYr
         +DH52LUCu9G/dkEt1SDY3HZRy99i/Jc1c+wYEpFk6XsyDCqijKDbFl1NHRIp+GY7nuFP
         L6JlUgBML+Qpbn/TQ/QAx/Gq0LlcRoyzMGqurc6adDQmD1LMpAiRzt1TZzEJsh6vQhUe
         6wBorCOwaOByTI0K/tufbFqY8WsATkIdub52ifxkPgviPTFSS+BvjBbfHrnfZSwS9r67
         wFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415614; x=1795020414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00H2MiRz9p8eLUkya05BzpmKsGZ1LM4lgngi7LRL8go=;
        b=x79UKIJlspoZEjLD3Dri5vO5zUJtgfu+ocka80hXdxvRdCo/KfZI3H51lAwsDmxd2k
         QIxs+p+xMRA+/RNiHB43ntI2bXTVHVmeWRgWiC+tJbp2Hu8JXGzABunKwyA18lLa9zD6
         AjnJNmyYFn8RoEyveKQnIw7AsHmu9zPUZs+0jG+Org4oDSVXU82g+iIXR36KmoYFoaNm
         SkS1UIs/wo+fQuV60QZnvVBf6SlxBB2H2YSJjrmKiIUPQlx3qTypIr/ePvPqBT/b6kct
         W2odR/MUXBvklufhQzY/Ad76lGytJwAWQMqeGCqVSmhhvrHmyXbijMIDsBzlPgmMBpjD
         9qHg==
X-Gm-Message-State: APuU4Z9cas4vlfDhqH0PT4HxZnKZ43sAXtC0ZNl+c+FCdXEXTqgzZVPK
	5+AJTeds5JlXhgCCD/R3194xouJGp+aQq6exZNb7HpsDF2k6kZ7HAD157LmtLQ==
X-Gm-Gg: AYBFou3tVyapXHd4yIf2cC0RWEkCV5/p3W5rb7q64Rl1OffiWR6njRipV+l+o+27lYj
	Bn2v3022L/3yfgGhCQGP6VWAi/E5gWXqMq1p0YOIFW1vWwzKpgVyvU3QWUxpPutF1S0AzFHFat1
	9Vn3UNCScIvOmt6qnOWfCwQX4WMUl4OUMPjeRDFzjggLNytAvSFeALKXpWuujSvXZezNWwLmZag
	J4wfio/ZooVQ6eK5A1Pxilyqb/NfrIS7BBUYTkPg+r17BgkgDrLE/jeCYb3pmS+paMNmzccEE3b
	mUZ/g9BtwdZZPXKo33nbNcGJ/6zIUcIiWjo1LvmDbaaWbLeMgBKy/MLnTD0X8VmXa7sk91h9cT3
	VuGMt1LV8NR8T/ZXWe1xPIdqr4CoDkt+PrFJuYZt7/agZ7gYjZVGCN8JA9Ga/t3F5Crasf5jn6u
	MV/PeclaCLw64m8lzpOlUvfTmeH+/uV3YHFAcB1e3fC+/KyR+IufPlPKOvUOR2ipm9coY4aka63
	f8Jw2NEacnWqZ9mOVpwS2gxazmx1fObmfvwFKsn5yrjAygm2VcjXoB/jw2WkN0W3bfsG7WvUlO8
	4di2dj25pW/jqdbm0PJYXKdS67FHEnCK1tBn8T+72SJVy280A5gdVlCzaQQoUZCqirWurTQTjD+
	gx6VKWb+7HGRz79Xqt2lnOURgxUoYUmZlVU5mmK/Rm23uHzFym0cR0vzNL8CeTJZ5uaDwko5dbA
	==
X-Received: by 2002:a17:90b:1dce:b0:3b0:d070:3c46 with SMTP id 98e67ed59e1d1-3b182eebe5amr2661620a91.12.1794415614218;
        Wed, 11 Nov 2026 08:46:54 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8aae8sm55408a91.14.2026.11.11.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:46:53 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 09/29] bpf: Include older frames in a fill through an imprecise stack pointer
Date: Wed, 11 Nov 2026 16:45:32 +0000
Message-ID: <20261111164557.2659679-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

A fix of liveness.c. This series needs it: scalar evolution keeps the
expression of a stack slot across a call unless bpf_may_write_mask() of the
call has the slot, and this is a write that the mask does not have.

	struct scope { struct scope *parent; u64 hits; };

	static __noinline int leaf(struct scope *up)
	{
		for (s = up; s && n < 8; s = s->parent, n++)
			s->hits++;
		..
	}

	static __noinline int level2(struct scope *up)
	{
		struct scope me = { .parent = up };

		return leaf(&me) + me.hits;
	}

level1() is like level2() and calls it. The program has the first scope and
calls level1(). In leaf(), frame 3, s points to frame 2, then to frame 1:
at the loop header struct arg_track is ARG_IMPRECISE with the mask
BIT(1) | BIT(2). For the load of s->parent arg_track_deref() returns the
pointer that it was given, so for liveness.c s never points to frame 0. The
scope of the program gets neither stack_use nor may_def at the call of
level1(), and the program is rejected:

  reading from stack off -16+0 size 8, slot poisoned by dead code elimination

put(cond ? out : &tmp) with out in frame 1, tmp in frame 2 and out->buf in
frame 0 has such a pointer without a loop. That program loads, but the
call in frame 0 has no may_def for buf.

A frame holds pointers to its own stack and to the stacks of its callers:
a pointer to the stack is never spilled into the frame of a caller. So what
is loaded through a pointer to one of the frames in the mask points to the
youngest of them or to an older one. fill_from_stack() does the same for
a known frame and an unknown offset: GENMASK(frame, 0).

Fixes: bf0c571f7feb ("bpf: introduce forward arg-tracking dataflow analysis")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/liveness.c                         |  4 +-
 .../selftests/bpf/progs/verifier_live_stack.c | 60 +++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e930d928afa5..c52f0435193b 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1398,8 +1398,10 @@ static struct arg_track arg_track_deref(struct bpf_verifier_env *env, struct bpf
 
 		return fill_from_stack(insn, at_out, reg, parent->at, parent->slots, ptr->frame);
 	}
+	/* A frame holds pointers to its own stack and to the stacks of its callers */
 	if (ptr->frame == ARG_IMPRECISE && !(ptr->mask & BIT(depth)) && ptr->mask)
-		return *ptr;
+		return (struct arg_track){ .mask = GENMASK(fls(ptr->mask) - 1, 0),
+					   .frame = ARG_IMPRECISE };
 	return (struct arg_track){ .frame = ARG_NONE };
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 32bab3cb3fcb..d6a6420d219d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -3143,6 +3143,66 @@ static __used __naked void imprecise_fill_cross_frame(void)
 	: __clobber_all);
 }
 
+/*
+ * fill_older_frame_3() loads through a pointer to the stack of frame 1 or of frame 2. Both slots
+ * hold a pointer to fp-8 of frame 0: the store is a may_def of that slot at the call in frame 0.
+ */
+SEC("socket")
+__log_level(2)
+__success
+__msg("3: (85) call pc+2{{ +}}; may_def: fp0-8..-{{[0-9]+}}")
+__naked void imprecise_parent_fill_loses_older_frame(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call fill_older_frame_1;"
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked void fill_older_frame_1(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call fill_older_frame_2;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked void fill_older_frame_2(void)
+{
+	asm volatile (
+	"r2 = *(u64 *)(r1 + 0);"
+	"*(u64 *)(r10 - 8) = r2;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call fill_older_frame_3;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked void fill_older_frame_3(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"r7 = r2;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto +1;"
+	"r6 = r7;"
+	/* ARG_IMPRECISE{mask=BIT(1)|BIT(2)} */
+	"r1 = *(u64 *)(r6 + 0);"
+	"*(u64 *)(r1 + 0) = 7;"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 /* Test that spill_to_stack with multi-offset dst (sz=8) joins instead
  * of overwriting. r1 has offsets [-8, -16]. Both slots hold FP-derived
  * pointers. Writing through r1 should join *val with existing values,
-- 
2.55.0

