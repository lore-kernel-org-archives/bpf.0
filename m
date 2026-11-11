Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401888;
	b=BH5eKe2clLI7F/LvY6J6PyY7TRNbpm656Jp7J3WngY7Vb5OF/BEKrH1Nk54OYcNM7nyv
	 SRQ0LYRVNLMo9NBlovXCcv1CGsUGsbbdoDXjK34JrFDIH/6cZDTZzC5lPo/9FgbjCCXlO
	 I0faDB0nGv00cVWRd+KRuvm+Qki493xqDRnZptiTkLBfU+H7AvtimJOnyFJRHPGsYKxzA
	 FUSD5X3m5emnt4omoF4CDb1QErQJPSmWBPMz0T2QVYGdBf9974BJfZCZZZwpkCLzrmvcP
	 7LbVR9DNKrQex2JYTaMOFlz0ZhUs59ppi9jHyM+YOLQdKFcKEOTMWEcGL0cHvqodPxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=9UnkYWaGiAXmluWrSK8Sprh2ndqa0JKy1egXYVC/3/M=;
	b=kybx6mIy8R6IsCw3zK5IzckL0HAv7/LHW2mDO+Xu3NFl+44yBjkM87hgptUm0nM0Ega9
	 9se8ohYO8B6pfNJh0Kpa3QQ9IrGCbJOuIar7zu90nEoZ62/zpwIz60bEnJPYW8OurveQ3
	 QmK1TpF72Lw6wDfHsiTyYiKlLhzRbo2tG8l+tjljFgcjSGGLAPirF/pq3Wql1P6l55q1L
	 0P2NHlgkyIgr4W5wrG++F365CkE+OEx73d7jcrxEUNXHWKN4VyAeP4mK0Nrjc4W6RmFjX
	 6viB7viQv0KqLPGJEEK301GR5RE6jJv+Xsa3zyR1237y6/lpRdYAF+vsdGN1va9MB1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aj38dMIz;
	arc=none smtp.remote-ip=74.125.225.75
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E86606A32D
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22E86606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aj38dMIz
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48fdea35dafso1200740f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401886; x=1795006686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9UnkYWaGiAXmluWrSK8Sprh2ndqa0JKy1egXYVC/3/M=;
        b=Aj38dMIzLF3Twpa7XxNBn50/zibC4StART7+yvp9XrYPLHZ13UDYmNWKL1s48QyF5z
         5goQM8Mkpwcpl1inFIvrHzGETexXVc1+7B3zcH6IFP0p7vg6BT8Ujv1GgZ9d0/VbKBsi
         TzNTjALUto3Cu0GmKOo106h3C0mIQ6yirzpS2Ba1GWPY2PS+YqRLidl9DJQ79bLZ5XMO
         Qa/cuSpCCuBGHltB5pI/Bn6oV8U/AQnWYPT7HqQ9h2ghWmv0E2HF4/9y6z+kJJgqQE4d
         NM0ZZNqP51uAyrUZJxxQMLSTJdyQ/DI4bAdDp1aAUnRxs/1JfkLIJRreKDjTO4SLQMkG
         fC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401886; x=1795006686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9UnkYWaGiAXmluWrSK8Sprh2ndqa0JKy1egXYVC/3/M=;
        b=t71Y/W+gsWddx/7DM3mfcAihgbanaSqD8V/8S3iHHHjDmT4go7BRNxD2zKn8/bQ3AE
         EDK6nCEAzM8wIjpPUh4Lphlvc9YHhkkhTf6Hv/pn3FDDaaL491rbqBYm7tgvqBQ9ZLcC
         gK1q4xVsyiP+OnEnTzmr/qOK/oWNRHT/DSEQu21CUMwdTPvU4o1WjUgIWCm/GFvT5Dqk
         hagD2wHEfA3Dbk9P16tkbSeKyvW1IiZ63WeGWsOnUIv5Ov0NnD2yTFGkTYPf3fujnIct
         mrmpxE7CdthOX/KShDj8uInURUAw85Lt5BmJE8g+eliwAIw8EE4Sh+dl8at/iEuhOpob
         Rh3g==
X-Gm-Message-State: APuU4Z8mYebOoRcd4rQX7rLaQxAsx/F7l3LwTF3pXIqX+lsPCg8/g8Sv
	BRFcBgBQ6gdf6gocL9nX6p1ieM5tJDKFO02uQ3e7DGv4DhPabPhFTJfxQrerjjQersk=
X-Gm-Gg: AYBFou3Zo0zDqYd1AfqufpNk6U73y+irUzgunfw77Ic81zeq8Iu43Gxy4xZgiqKT8ju
	pDtW66pdyYd7fCmgc8eWfgMovefBfk8NRRfuFHXtyq/dwPXSyT7e7VBRMIdcNi8N94HkiVd+6ly
	8gheylYm+TMW8Yf3AnX6tXADVLKOdjqMzEwG6CyeQX3yxA7tNPEpE+azbPPISJuGgwt360nzpL/
	6vKyjgFeGxTk5IkNkuqOYc6NiCGpLcoy929WUMcdkKhGWWtLz3L+znK0MElDkRNIAMN79JN6IMi
	HEfDE16zNQrQe7XOPZEBBLl0e+sG7K8spMTeo+OtG7Sk5IOlvoqj7O9TjZXVVmi8l0X2SDTDUay
	cd2Jai9hGwwRW0hFzTudBZM7JDO59bajaiJrB/8tSJEZvyBtHM0NfcuERgfPg0z4/6IFgNo8VtD
	NzQ/BcdFo987I38AhCcZXy6H376mg4C1bt1pj+dKabe1V8f3FochraDbwXHlVhCvQvC3nfsJbD9
	sZs9+9fJRMHS2Xj3uIat1EN6ATf7MF/PbC4Tlez/x19Jw1wJnOtIrLleShWJJ5kTeyaYmLjygTI
	Em8DYy8oMh0iy1O5T9hb8YAGRdtca6nRX3+8rh0klJWAjhemzJIoan9UQMt4DmOhBB4BvMnyHwp
	lpF1q2dYdTIoB7L9niS8x7BLRqRBXR/O7ceCmS5RM4ZUzsOufLwGBQwmkpSG+KwiMb+0d
X-Received: by 2002:a05:6000:26c9:b0:490:b23b:8017 with SMTP id ffacd0b85a97d-499c75529e1mr4127999f8f.34.1794401886381;
        Wed, 11 Nov 2026 04:58:06 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585923bsm11165328f8f.11.2026.11.11.04.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:58:05 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 22/29] selftests/bpf: Test rejected throws that hold resources
Date: Wed, 11 Nov 2026 13:57:20 +0100
Message-ID: <4dde945c2be2bc3b2618ee5426b808b0dc29de44.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6945; i=memxor@gmail.com; h=from:subject:message-id; bh=MX4GtiWpvXBmFgdjwWLcm3VyYztUNJPhZGxIKB9YHA8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzOK2S2qfJso5XGRneize9Uzt1MPHthK+MaKMHXovO 5O7Fi/rKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQ6OxgZXkcuYCxZqllyWSzq 2QYu5/u/Jab+f7FkrR7fbDPXEr8zzgz/i0NPBsoHzY8v/5DGM4lDa84MN9sm+fgVQgEBqQenich xAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a program to exceptions_fail for each rule that a program must follow
when it throws while holding resources. The programs are rejected
because:

 - a callee may throw while the lock of its caller is held, and again
   after it has released the lock;
 - a callee is passed a record that its caller keeps in a hidden slot,
   and returns without discarding it on some paths;
 - a callee leaves an RCU section of a caller that counts its sections in
   a hidden slot;
 - an object is released while the lock inside it is held;
 - an iterator or saved IRQ flags on the stack are overwritten;
 - an RCU protected iterator outlives its RCU section.

The programs run on x86-64 and arm64 only, where these rules apply.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/exceptions_fail.c     | 214 ++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index f02882224a03..9b47345d5fd0 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -458,4 +458,218 @@ int reject_subprog_throw_irq_lock(void *ctx)
 	return 0;
 }
 
+/*
+ * What a program that throws may not do yet: the frames keep what they hold
+ * in hidden slots of their own, see kernel/bpf/frame_desc.c.
+ */
+
+struct locked_obj {
+	struct bpf_spin_lock lock;
+	int data;
+};
+
+private(L) struct bpf_spin_lock held_lock;
+
+static __noinline void throw_around_unlock_held(int before, int after)
+{
+	if (before)
+		bpf_throw(0);
+	bpf_spin_unlock(&held_lock);
+	if (after)
+		bpf_throw(0);
+}
+
+/*
+ * The callee may throw with the lock of its caller held and after it dropped
+ * it, so the call of the caller says neither. The lock is in a slot of the
+ * caller then, which the callee cannot reach to empty.
+ */
+SEC("?tc")
+__arch_x86_64 __arch_arm64
+__failure __msg("releases what another frame holds in a hidden slot")
+int reject_callee_releases(struct __sk_buff *ctx)
+{
+	bpf_spin_lock(&held_lock);
+	throw_around_unlock_held(ctx->len, ctx->mark);
+	return 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} fail_ringbuf SEC(".maps");
+
+/* Discards the record when told. */
+__used static __noinline int discard_if(void *rec, int drop)
+{
+	if (drop)
+		bpf_ringbuf_discard(rec, 0);
+	return 0;
+}
+
+/*
+ * The two paths to the throw keep the record in different registers, so it is
+ * in a slot, which the caller empties for the callee it hands the record to.
+ * The callee returns holding the record when it is not told to discard it.
+ */
+SEC("?tc")
+__arch_x86_64 __arch_arm64
+__failure __msg("releases it on some paths only")
+__naked int reject_callee_releases_sometimes(void)
+{
+	asm volatile (
+	"r7 = *(u32 *)(r1 + %[len]);"
+	"r8 = *(u32 *)(r1 + %[mark]);"
+	"r2 = *(u32 *)(r1 + %[priority]);"
+	"*(u64 *)(r10 - 8) = r2;"
+	"r1 = %[fail_ringbuf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 4f;"
+	"r6 = r0;"
+	"r9 = 0;"
+	"r0 = 0;"
+	"if r7 == 0 goto 1f;"
+	"r9 = r6;"
+	"r6 = 0;"
+	"1: r1 = *(u64 *)(r10 - 8);"
+	"if r1 == 0 goto 2f;"
+	"r1 = 0;"
+	"call %[bpf_throw];"
+	"2: r1 = r6;"
+	"if r1 != 0 goto 3f;"
+	"r1 = r9;"
+	"3: r2 = r8;"
+	"call discard_if;"
+	"if r8 != 0 goto 4f;"
+	"r1 = r6;"
+	"if r1 != 0 goto +1;"
+	"r1 = r9;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+	"4: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(fail_ringbuf),
+	  __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_discard),
+	  __imm(bpf_throw),
+	  [len]"i"(offsetof(struct __sk_buff, len)),
+	  [mark]"i"(offsetof(struct __sk_buff, mark)),
+	  [priority]"i"(offsetof(struct __sk_buff, priority))
+	: __clobber_all);
+}
+
+__used static __noinline void leave_rcu(void)
+{
+	bpf_rcu_read_unlock();
+}
+
+/*
+ * The paths to the throw are in an RCU read section or not, so the frame
+ * counts its sections in a slot. The count does not follow what a callee
+ * does: the callee leaves the section it was called in.
+ */
+SEC("?tc")
+__arch_x86_64 __arch_arm64
+__failure __msg("a subprog returns in other sections than it was called in")
+__naked int reject_callee_leaves_rcu(void)
+{
+	asm volatile (
+	"r6 = *(u32 *)(r1 + %[len]);"
+	"r7 = *(u32 *)(r1 + %[mark]);"
+	"if r6 == 0 goto 1f;"
+	"call %[bpf_rcu_read_lock];"
+	"1: if r7 == 0 goto 2f;"
+	"r1 = 0;"
+	"call %[bpf_throw];"
+	"2: if r6 != 0 goto 3f;"
+	"call %[bpf_rcu_read_lock];"
+	"3: call leave_rcu;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_rcu_read_lock),
+	  __imm(bpf_throw),
+	  [len]"i"(offsetof(struct __sk_buff, len)),
+	  [mark]"i"(offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+struct obj_map_value {
+	struct locked_obj __kptr *obj;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct obj_map_value);
+} obj_map SEC(".maps");
+
+/* The unwinder would unlock a lock in an object that may be freed by then. */
+SEC("?tc")
+__arch_x86_64 __arch_arm64
+__failure __msg("releases an object whose lock is held")
+int reject_release_locked_obj(struct __sk_buff *ctx)
+{
+	struct obj_map_value *v;
+	struct locked_obj *o;
+
+	v = bpf_map_lookup_elem(&obj_map, &(int){0});
+	if (!v)
+		return 0;
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	bpf_spin_lock(&o->lock);
+	o = bpf_kptr_xchg(&v->obj, o);
+	bpf_throw(0);
+	return 0;
+}
+
+/* The unwinder restores what is at the address of the flags. */
+SEC("?tc")
+__arch_x86_64 __arch_arm64
+__failure __msg("cannot write over saved irq flags in a program that throws")
+int reject_write_over_irq_flags(struct __sk_buff *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	*(volatile unsigned long *)&flags = 0;
+	bpf_throw(0);
+	return 0;
+}
+
+/* The unwinder destroys what is at the address of the iterator. */
+SEC("?tc")
+__arch_x86_64 __arch_arm64
+__failure __msg("cannot write over an iterator in a program that throws")
+int reject_write_over_iter(struct __sk_buff *ctx)
+{
+	struct bpf_iter_num it;
+
+	bpf_iter_num_new(&it, 0, 10);
+	*(volatile __u64 *)&it = 0x1234;
+	bpf_throw(0);
+	return 0;
+}
+
+/* Nothing may destroy the iterator once the section it is protected by ended. */
+SEC("?syscall")
+__arch_x86_64 __arch_arm64
+__failure __msg("an RCU protected iterator may not outlive its section in a program that throws")
+int reject_rcu_iter_outlives_section(void *ctx)
+{
+	struct bpf_iter_task it;
+
+	bpf_rcu_read_lock();
+	bpf_iter_task_new(&it, NULL, BPF_TASK_ITER_ALL_PROCS);
+	bpf_rcu_read_unlock();
+	bpf_throw(0);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

