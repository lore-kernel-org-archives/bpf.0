Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A033ADA0
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472092; cv=none; b=lG8jmP4sByxzQS110ymC8eBKTCbsc/KEjh4FzV4GpbjKZfPyoyR46qGOwTSq90T/atDtcZNZ3Cyt1HWLE3xK3u0k0GwNN2zc7KGuBe14Xem4pdp85ZhsO4/fbcMkiMq22JTZbb810QS9QqYJxBYigDWCPRHQeg3D8+cWrHKW77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472092; c=relaxed/simple;
	bh=qJdfWxdDnKj13XrhJaZHd4m24v164U7oUc/dypgIVfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6lkp/lwqX3PcLcq1MGt1XcSlw9Ow2zLq/Y87YJgQvis3DMaTvW0we0TC4tJpxO7u5Lp839TOcUF+e5QhDvwZj/QdeyJt5oqfCVWC7UUu3sY+xYw5KIGhKDVbhGGQ702IeXgjzQU5GJEppsuGAfmhCzWIuITpj9bQshdlb2gFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGsc6xXD; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGsc6xXD"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499aaf0a723so1016685e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 14:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788472089; x=1789076889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fwcuuDoREK4ZtF/TYhSApNRR165wDYw+KHihLXluZYw=;
        b=rGsc6xXDsQeVIz0sfB37OBzC4/16ycpYjh3geVke6enSoDMAdVpgpctlqX+y9+jtpu
         Q5JL2PyeALqIcrVTXquwQCINv6/HI+g4zMXJXw/Vgi0KhDHbTY/iFcpydzz8lYz7Ekmp
         lK7Y7ncxIQxEf2a48gtBLhlICxutgguzkLYLMz4SYCd0wluMZy0T3joGa6qzR2T3cyHa
         qZeFwJT2rHEHYPnq1i7cXXGlylXmAF79pHV3GEAkLntCBlMfHzIZF/W7VyeCuY2jpAuz
         AGNgmLIRELwfQRoId7Wd75tekUyXrUs+HvYLXeeLXE4YN4YYOZVg/QCK3FjJllMlNKPG
         L34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472089; x=1789076889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fwcuuDoREK4ZtF/TYhSApNRR165wDYw+KHihLXluZYw=;
        b=as8tGY+eELPGfv4Man1cn98AE20zQvmOmqTGf8CmczNPVF87VGFk5hQe57WGcW4pwH
         /8S1bnp4KZf/WC3aNcc7wYslC74/C+31OD9p8BSed7OlyHEhGqSsyq0p+Y7qloLOuCgR
         vD7X7v5Z8y/wvJ/Jjx6adrbMikE8d7X5+Fq+KK++leim/k6JA3LI2EFzAe0UJFRU7q2d
         thDYYYNm/DIjIxCw79gdTemBaM1z8SiATrLBDLgaDQoSxARDUe9exxpL/jDw7i8fzR+d
         EvZQ4OOt0Tg3fSjXLZQ7dGJ2YywiktFiXkQgJpSh0PhCHkKlgc//pZLIr0OSNP3eNmbs
         rhHA==
X-Gm-Message-State: AFuF++nwEHAKF4VZTRJ3q/XMaxANyO4+SbmFMZONI+RGvjhPilIB9crA
	B/8m+lW5kVLrka7hvsmKHmSaLE7jixji86wnWj0DG5CTF9qBnvXCSMEZ/4PalR4q
X-Gm-Gg: AYBFou0c4IsVg8BHsLIHYAOvfzCWlWOQU/draxRvEoMe+SNXFS4BbkRtBRCJr0tRQu5
	eDR6nTbektWzYxeznRbkmx90XdmeVzeJy/2H1d867wyIyACarLbuViw7sgDTIEhxEJhf4QcA+XO
	qvMl4mC9DFt05zduPI4Ph3BvhcuX6yOwZ5VWtmNUUB3vIEU37FxYP2lMFG7d0MJ0acDWsJ6k4co
	lB2CSxtVcxzb1PUQab4oYcR3/AiVkEukCRsEW9rduU7CzNSCyfzDnvZufFdxLCvNY3PjV2ZdVhw
	tIDy9PwyAdix/d6wkr8U+I0n5OOvWHdSE0C5Kk6DMoeFWKIv+Blr9Iil9dNla5re8RcqHjtUQsI
	NMXKqtqcjZKNdyyjsMgjaP1Yz4s5e4soggiQ8h0HrAykyWuzdxO2uLZK5YJnCkEOZTTnWF7D3v4
	nAo/jDSMBDG7hptNmkjJl5zyqpll2ok3Wt1+Q5sWgkZ5yaccJtbXvA+bnHnmlzB4J8oY44mfyHt
	b4T4BDMwrn853OXyZKTgja9oTNjlzAYcdd8IeW3eZGzRxQFfrsnv/JEo7PW4qIIUJGyxB9p3FbM
	d899cMrvgYGbOTcxGWKfPwk7a6w=
X-Received: by 2002:a05:600c:4712:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-49cf8248cd3mr11555835e9.13.1788472088938;
        Thu, 03 Sep 2026 14:48:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm34096505e9.15.2026.09.03.14.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:48:08 -0700 (PDT)
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
Subject: [PATCH bpf v1 6/8] selftests/bpf: Check faultable stack helper contexts
Date: Thu,  3 Sep 2026 23:47:52 +0200
Message-ID: <20260903214758.2727663-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903214758.2727663-1-memxor@gmail.com>
References: <20260903214758.2727663-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2425; i=memxor@gmail.com; h=from:subject; bh=qJdfWxdDnKj13XrhJaZHd4m24v164U7oUc/dypgIVfw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvma9a28KuGVbFVj4IPN/k0c6+b7N9hUD313KsVV6KUc mwiCqw6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBHjGwz/tOZWb0n8vcFs7hph lecbsnqrL2+8+fGq/Svfaa8bd2j+42b4H//U/3aQfWpLNvd5E87NJ61bzgey8e1qlcoItmDeNuU WNwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add verifier coverage for the sleepable bpf_get_stack() and
bpf_get_task_stack() implementations. Call each helper while preemption is
disabled and require the verifier to reject it as sleepable.

Both programs load when the prototypes lack might_sleep, so the
expected-failure tests fail. Keep success controls outside the
non-preemptible region to ensure ordinary calls from sleepable uprobes
remain valid.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/preempt_lock.c        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 6d5fce7e6ffc..81c459435680 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -115,6 +115,58 @@ int preempt_sleepable_helper(void *ctx)
 	return 0;
 }
 
+SEC("?uprobe.s")
+__failure __msg("sleepable helper bpf_get_stack#")
+int preempt_sleepable_get_stack(struct pt_regs *ctx)
+{
+	struct bpf_stack_build_id stack;
+
+	bpf_preempt_disable();
+	bpf_get_stack(ctx, &stack, sizeof(stack),
+		      BPF_F_USER_STACK | BPF_F_USER_BUILD_ID);
+	bpf_preempt_enable();
+	return 0;
+}
+
+SEC("?uprobe.s")
+__failure __msg("sleepable helper bpf_get_task_stack#")
+int preempt_sleepable_get_task_stack(void *ctx)
+{
+	struct bpf_stack_build_id stack;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+	bpf_preempt_disable();
+	bpf_get_task_stack(task, &stack, sizeof(stack),
+			   BPF_F_USER_STACK | BPF_F_USER_BUILD_ID);
+	bpf_preempt_enable();
+	return 0;
+}
+
+SEC("?uprobe.s")
+__success
+int sleepable_get_stack(struct pt_regs *ctx)
+{
+	struct bpf_stack_build_id stack;
+
+	bpf_get_stack(ctx, &stack, sizeof(stack),
+		      BPF_F_USER_STACK | BPF_F_USER_BUILD_ID);
+	return 0;
+}
+
+SEC("?uprobe.s")
+__success
+int sleepable_get_task_stack(void *ctx)
+{
+	struct bpf_stack_build_id stack;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+	bpf_get_task_stack(task, &stack, sizeof(stack),
+			   BPF_F_USER_STACK | BPF_F_USER_BUILD_ID);
+	return 0;
+}
+
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 __failure __msg("kernel func bpf_copy_from_user_str is sleepable within non-preemptible region")
 int preempt_sleepable_kfunc(void *ctx)
-- 
2.53.0

