Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99D26C3BD
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518553; cv=none; b=ovKGEkPvChG8SibTyuweyyfUXXCXSNJGM/JMwU1C1dAJcGdhkUkjBbE/Goo5IhOuHEoMMbqBMO/4VG0yaG1bU6eZMFL3biLKRcjjGCbqsd8IRQg+jqGayK9BgXG5CKzadcd/u69AKP9RwvDBXsiJsMTtCk37ngKQ43Jc0JRjVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518553; c=relaxed/simple;
	bh=ruF0vEm9I2PBlEEr7G+aYPPvh8f/5YqqDVYZsfx0suE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riq4siZxdmiqwZlVe6mnZjAoixL6JCn6jmkSjB/okMcY/I5n8omTR5ERFVh6MKjxY9hsRIPxUGx6/aIcPDYSg1Y4unL0SQZm1EbE7PiwfXaAQ3Vx3Q6FNhoJ8krMdKO0uloo26jR093FSifU2R5KxlNGfJyjNWgg+tda1CysE3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn9yu/0w; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn9yu/0w"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-48431648f33so1355283f8f.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518547; x=1789123347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aYEAwFBzZklxJ/jS1iIWUuDEHxxju0C8fhf4ZdCt258=;
        b=Tn9yu/0wABbn05C8N3u+hAKu1jeTy1lfOmlqGUNjAlRd/iwFD9qj/jr/l9N7hT4oCy
         0Syb/yxsC1iCnK9ZYHi4NGGqcHPaJyn1wPozeIFApY4fk5mIZRmSzZ1FjpucoIHileU8
         0UMfkYMdsm4BNzrj4vvlXQWdfYIH+fbmTMn5cQZ3Dyxc9BcEbpi0h1WJ9vwxCzwpb4oj
         cgf+sPpVqYVIz6Jjs1pswiz87K3zMySNz0OxNWx5M04QV8C4oK16BNpwWGV3vS2g9Nuw
         KcuYo8ILAs3akRs8GMXc7FnH4OrkHdrVAxdeAR4oKKkhOXPL4l7n1k/9ZO6IVc0/1xW+
         Oneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518547; x=1789123347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aYEAwFBzZklxJ/jS1iIWUuDEHxxju0C8fhf4ZdCt258=;
        b=A1V1IC8xv3j3xAJNzMbGhMaK+BaiLOn6MCfvldK+ZgYClZaP+gnWOTz+AVPtIfMZau
         rXaW10rBo4F8A+BTEgLtC8DwzghuEOMcrbcswFZxJZUSy38KOkP+JI6KjvPkfYWAoWeB
         4i+MPA6BCYbGxzZND1CSKvxoxqbFIm6tzV8/j7hImuP7jpkpiYHFEtKukKulB2RG3RF7
         hZTSWxXonCD8zmNYWwRqll3Ip7jjEbr+111e3ypUM+1Ztkxq5Yxxs/EnzjnauFo2PdDo
         AcxC7nQW1ZWYcLRWAxlYRR5gMXly+pBxuLq8XyaK+621VWcL+INgFGM3UJiUlwfVPQg9
         TwuQ==
X-Gm-Message-State: AFuF++lFRrwXApyP0PsOaGlw2ef1DSnG22l6bUzwIibVb4Ukf9+CPvdf
	KMp9AkqUZEwPYy0ExrVFrpGJPA1Us3PTIDJV5XXpsfSKnuJLP5hDT1m7Ox48CNkg
X-Gm-Gg: AYBFou1Q++a1ziXx/ZPHO9TJduJ38l9KTqY+h1UwDZc7EwZT+sJs75/3FOdntUKNW2Y
	n1gGof06Za6/OiUCXeLg4E6lzyzbNd0/sbJGTWFmve/sj+UvJS970fsv+uRnjzy8R+fXLhR2N4e
	nwRieDNiMszyq+/DPjulJp5tRhLWeULH9D75Xnx7f4npLAIhqxtWACPsgZCiI1og167TiV+S/32
	kt3oDM+BgNFPFcdQ+9CQxNqaKkIrFwD/q65Cwqz7vloaqN5FXVy7Ywfz807pOON/R2leD423QXu
	wrrtbf5f8VyrxTkz3y/n7w9UmsfvRQKP3dEE6J0R/URNN+Yrb5wZusJYqh/EYYSYrAAgCi3jks3
	o+39g0rQM1sXNsIo3izirVHQqtQCvdvWEUf2w0Xrj0XZcUyk+GI2Ygyx3poXaTtx6mkRO+embOG
	Pc2n+kgiKPjk8ddcz+IlvPQ3I/BEplbPm2u3czzfHRfbFiXJOY6w5OU9zDtqZedk+F/qHO7wh7v
	FwFYesVY30UbpZjqrgi01Ovp1t4AQqi+Z3fkeVQI8WI1eTRvuSXi62n/xRhXOggQ61zPMfxC5gi
	0rKlfYqkUBD11DmylPYeMB83hpY=
X-Received: by 2002:a05:6000:27c6:b0:482:ea3e:882a with SMTP id ffacd0b85a97d-4857e4dc23emr11244638f8f.6.1788518546745;
        Fri, 04 Sep 2026 03:42:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858e239862sm363621f8f.9.2026.09.04.03.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:42:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 7/8] bpf: Preserve inner map identity in callback frames
Date: Fri,  4 Sep 2026 12:41:58 +0200
Message-ID: <20260904104203.345917-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904104203.345917-1-memxor@gmail.com>
References: <20260904104203.345917-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4503; i=memxor@gmail.com; h=from:subject; bh=ruF0vEm9I2PBlEEr7G+aYPPvh8f/5YqqDVYZsfx0suE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvW/HOqJ14w8e6UKcn8FcHye/aDo9vP2bXKvjyuemt/l Jfm91O7O0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCR/9MZGZ7+T2qu8MherZXP +P5oleqXre9Drq67oeTz6Wrsgujmuh5GhveHejpYhFT2ij24s4G5o/Rm5C8Bth+ZDa/k3q0791q zmxcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Callback frame constructors initialize map-typed argument registers with
__mark_reg_known_zero() and then restore map_ptr. This clears map_uid,
which is the only field distinguishing inner maps that share an
inner_map_meta template.

When a timer callback invokes bpf_for_each_map_elem() on a second inner
map, both the saved first map and the second map value can reach the nested
callback as the same template with map_uid zero. bpf_timer_init() then
accepts pairing the timer from the second map with the first map.

The runtime records the first map in the timer without taking a reference.
Freeing that map does not find the timer stored in the second map, so a
later timer callback dereferences the freed map.

Copy map_uid from the same caller register as map_ptr when constructing
for-each, timer/workqueue, and task-work callback arguments. The existing
identity check can then reject mismatched inner maps while allowing a
callback value to be paired with its actual map.

Fixes: 3e8ce29850f1 ("bpf: Prevent pointer mismatch in bpf_timer_init.")
Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
Fixes: 5c8fd7e2b5b0 ("bpf: bpf task work plumbing")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ba9753bf529a..c9c0504b7edd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9994,10 +9994,12 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
 	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
 	callee->regs[BPF_REG_2].map_ptr = caller->regs[BPF_REG_1].map_ptr;
+	callee->regs[BPF_REG_2].map_uid = caller->regs[BPF_REG_1].map_uid;
 
 	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
 	callee->regs[BPF_REG_3].map_ptr = caller->regs[BPF_REG_1].map_ptr;
+	callee->regs[BPF_REG_3].map_uid = caller->regs[BPF_REG_1].map_uid;
 
 	/* pointer to stack or null */
 	callee->regs[BPF_REG_4] = caller->regs[BPF_REG_3];
@@ -10075,6 +10077,7 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 				    int insn_idx)
 {
 	struct bpf_map *map_ptr = caller->regs[BPF_REG_1].map_ptr;
+	u32 map_uid = caller->regs[BPF_REG_1].map_uid;
 
 	/* bpf_timer_set_callback(struct bpf_timer *timer, void *callback_fn);
 	 * callback_fn(struct bpf_map *map, void *key, void *value);
@@ -10082,14 +10085,17 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 	callee->regs[BPF_REG_1].type = CONST_PTR_TO_MAP;
 	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
 	callee->regs[BPF_REG_1].map_ptr = map_ptr;
+	callee->regs[BPF_REG_1].map_uid = map_uid;
 
 	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
 	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
 	callee->regs[BPF_REG_2].map_ptr = map_ptr;
+	callee->regs[BPF_REG_2].map_uid = map_uid;
 
 	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
 	callee->regs[BPF_REG_3].map_ptr = map_ptr;
+	callee->regs[BPF_REG_3].map_uid = map_uid;
 
 	/* unused */
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
@@ -10189,6 +10195,7 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 						 int insn_idx)
 {
 	struct bpf_map *map_ptr = caller->regs[BPF_REG_3].map_ptr;
+	u32 map_uid = caller->regs[BPF_REG_3].map_uid;
 
 	/*
 	 * callback_fn(struct bpf_map *map, void *key, void *value);
@@ -10196,14 +10203,17 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 	callee->regs[BPF_REG_1].type = CONST_PTR_TO_MAP;
 	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
 	callee->regs[BPF_REG_1].map_ptr = map_ptr;
+	callee->regs[BPF_REG_1].map_uid = map_uid;
 
 	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
 	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
 	callee->regs[BPF_REG_2].map_ptr = map_ptr;
+	callee->regs[BPF_REG_2].map_uid = map_uid;
 
 	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
 	callee->regs[BPF_REG_3].map_ptr = map_ptr;
+	callee->regs[BPF_REG_3].map_uid = map_uid;
 
 	/* unused */
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-- 
2.53.0

