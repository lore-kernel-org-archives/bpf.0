Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ADC368957
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503819; cv=none; b=gT2/zdkbtr+cEGYKAMTvZBh94/91JLkNk2IXDrpTrY6ZvrYlNx1Md4jGDoGCiG7a7OM5b/HGGQioq4X2FgiZxYmOoq7J5L4Fx4HT70pT+l2CeenFqRgJt/SaCJnijppccp3Fx2CAYXNtz08zIG0mkAUJQ/hIrbdTnYBu02pFjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503819; c=relaxed/simple;
	bh=KZwM6a3VZxaj4sMHGYhUUpBrjNnVWCw2ZvQaE/7m//c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eC176q7kMGUzipdzMVG554bZM6Q+p+iHyBGj4j3msSnrTwL3y01bxviT+jkfA1XBErtn5B+3gQ0nnFRTm1aDCcI1Zn+0X9QdiGLlNFyLH6UW9udVVuS0laCJ81lZFz2bNx9E82RLVM64d9SMnLyzzu+IJz/pkTlcaNR6fplows4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER6CXhba; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER6CXhba"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e61db882so138447f8f.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 23:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788503815; x=1789108615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z3WAr11vjblmaC/H/rSaD9688Zc+rMF5P2kN9YAP1h0=;
        b=ER6CXhba/WS9oWipvybkSNDWJ09162inH6JDJ9W8PiWZ/+cgXUFWw25EJZ62006imK
         dilnprdQObq8qLeGdOQj8ddaTPOh7GNEFPn8AuJWrG8OfUhswD/RWPBijuMZ91wU+Vlm
         l2X/9YVMmILkfGFjLsEmvhVSXDN37R9YPJmwMdWrgL4G73PGXBJPpYJj8M63D9e8LuFF
         /jJey7etnUZdd8vFkn/DR0FMy6bjGO1UGV33l3t9pcgBUR5Q2HmzDya7p3xTTs1Awzhk
         8jkb2LdoyBhUGfNbte0hpIKEV0C+rKSQ2dsuCba6KFXxe8VLUkY2qMJ65Bu5y3adISKq
         SMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788503815; x=1789108615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z3WAr11vjblmaC/H/rSaD9688Zc+rMF5P2kN9YAP1h0=;
        b=ShSzZq3yPajveFVN4hROcSbCHgHLUOa6iBygiMjLHXGXlZ38tNOmaTmkXNGwcDhGL0
         SARDB1Diq3+savMccEBJsqs4fAiSjbEDyP9okR7KodxUTio0B/qVAKEUg3eXyjAJcsZc
         +a5/5q6odO+QMaBh7YK0RtHMaOf2xB4V8RrLI1FIr72tzj2kkGQt3l8fORKtfaDdJ4+T
         gA3tlSXSwt5GzNWob0hPj63PqdlxZIcVKvhU1Z0Eno8kxodsl1NujfOzpOgDcQrtHqYd
         UarcQEZq1PV6TrhYpM3xumrwJE+e0xkYASyt3PBL9+Jf0lkHkmZWnv68sosJE2i2fwoZ
         0iUA==
X-Gm-Message-State: AFuF++lRGaEdZcmfVfri6RVNn4CpDABtcxr9ybdSy675UbeUL2+ypkDN
	KqPx7mocKqBG8gKXO34TRvaImZFwmA4ZmuWvRhFoZbuShkdkTWPshKgmF2os7Ovm
X-Gm-Gg: AYBFou1iweptNUsD0aBTqiopeGxitLTYLr3+tYm9OfvPJ6EMXC470qyqH5rBfjIjMI9
	xBRycE615fb/PVJ0V+xarxvQqIc0ND8U7hAJ9eKctHiwj6ESaQ7JMmFj0vNDc827JfU++PER27Z
	UzBBeXF7uy3/yhKBcX/TSdtMzfnWvNf4S4R05j2HOOfVew1DMi/CYNslVEIm60oC78Fbh8pWh0R
	FhRydHzu7J/npOnL31zhVVs/FKcqj0/1JMbiCKLCydm3nprZMh+PqMKSQI71F6oBPxdf3iHI2im
	QrbtawA/exUgzTsUsPZejT1HVRlzocfIbRlIG/b8LTelUiyh2MPqU7Bgul7ghlfwaodjJgYuqVM
	+s+ypEzpWCxbtfLa7P3npDy3PINRXyTIFbYtmMHtnQvyh6Wr2z7nYzKMyZv7zT4YfeT53lN3mOk
	5px8/0Z3ZnxPsagmFhwSaUnKlf80vyi2oDnc+uGdOajDQo6b3E+ZSgN6epL7WmV0+rDhE5j/WYT
	dPMPoeDJkdFXsZGNQ8nSB6GFB4HfI9pLxDIib8+V+xrbLlzor9nLqBNkGp2xnnEQylQm02tb0jO
	lv15trRrnoW/KF4F34kdY8Nw5Hg=
X-Received: by 2002:a05:6000:186b:b0:485:8c16:a35b with SMTP id ffacd0b85a97d-4858c16a72bmr1194804f8f.51.1788503815108;
        Thu, 03 Sep 2026 23:36:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858bcefd59sm1552552f8f.19.2026.09.03.23.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:36:54 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 2/8] selftests/bpf: Reject non-percpu values in percpu kptr fields
Date: Fri,  4 Sep 2026 08:36:40 +0200
Message-ID: <20260904063650.3877826-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904063650.3877826-1-memxor@gmail.com>
References: <20260904063650.3877826-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2612; i=memxor@gmail.com; h=from:subject; bh=KZwM6a3VZxaj4sMHGYhUUpBrjNnVWCw2ZvQaE/7m//c=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtW2qX3xUGlrzIlWsMfPpJcPi/v6cSSQ2V3ROuO50wSm v5ku9jvjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzkozMjw5a55zbF78sOOnPf Wfeco7xsX4Dl/r63t/i3//sx+dLW/rMM/wNdF5Zd5J1kzFJWUikwX+9qvPsR8/vXnkjz/35dscv 4Ci8A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add verifier coverage for the two ways a non-percpu pointer can be stored
in a __percpu_kptr field: a program-BTF local allocation returned by
bpf_obj_new(), and a referenced kernel-BTF task_struct pointer.

Without the verifier fix, both programs are unexpectedly accepted and the
negative tests fail. Requiring MEM_PERCPU makes both programs fail
verification with the expected invalid-kptr diagnostic.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/percpu_alloc_fail.c   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
index 08379c3b6a03..3701f4ea58c7 100644
--- a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
@@ -33,6 +33,20 @@ struct {
 	__type(value, struct elem);
 } array SEC(".maps");
 
+struct kernel_percpu_elem {
+	struct task_struct __percpu_kptr *task;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct kernel_percpu_elem);
+} kernel_percpu_array SEC(".maps");
+
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
 long ret;
 
 SEC("?fentry/bpf_fentry_test1")
@@ -137,6 +151,51 @@ int BPF_PROG(test_array_map_5)
 	return 0;
 }
 
+SEC("?syscall")
+__failure __msg("invalid kptr access, R2 type=trusted_ptr_ expected=ptr_task_struct")
+int reject_kernel_ptr_into_percpu_kptr(void *ctx)
+{
+	struct kernel_percpu_elem *e;
+	struct task_struct *p, *old;
+	int index = 0;
+
+	e = bpf_map_lookup_elem(&kernel_percpu_array, &index);
+	if (!e)
+		return 0;
+
+	p = bpf_task_from_pid(1);
+	if (!p)
+		return 0;
+
+	old = bpf_kptr_xchg(&e->task, p);
+	if (old)
+		bpf_task_release(old);
+	return 0;
+}
+
+SEC("?fentry.s/bpf_fentry_test1")
+__failure __msg("invalid kptr access, R2 type=ptr_ expected=ptr_val_t")
+int BPF_PROG(reject_plain_alloc_into_percpu_kptr)
+{
+	struct val_t __percpu_kptr *old;
+	struct val_t *p;
+	struct elem *e;
+	int index = 0;
+
+	e = bpf_map_lookup_elem(&array, &index);
+	if (!e)
+		return 0;
+
+	p = bpf_obj_new(struct val_t);
+	if (!p)
+		return 0;
+
+	old = bpf_kptr_xchg(&e->pc, p);
+	if (old)
+		bpf_percpu_obj_drop(old);
+	return 0;
+}
+
 SEC("?fentry.s/bpf_fentry_test1")
 __failure __msg("bpf_percpu_obj_new type ID argument must be of a struct of scalars")
 int BPF_PROG(test_array_map_6)
-- 
2.53.0

