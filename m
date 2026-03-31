Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45DE3EC2E1
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992965; cv=none; b=e6qUSxPNRS+y8YAjLFxx00Tcg01rEsLkqcxVuqzrDxw6JzvD/AMPMg7rh46V7XuGXEtbFQrs+B54RTzSdkV2+NUh20RkaWWoqrGoVezgk6vvcUHwyLxCJccVreVspO4u1x6GQv62XUBstPQmp3EpSyAV/obCl4IWss0xnlZLh0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992965; c=relaxed/simple;
	bh=B957ddM31Zahw8V//QtJ/0ii7TPZNU/wYhc0JowkEio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yw3qSa88Wz9xqdlZp5+exROZCTJkERwXuqaFgQSdkZc1rlPzDj0gJL67dDd5njsbwpJ5bVmFFIfWh+2V/IaeLcLJRu40AtbYbC2LqtoMs/y1VyCLPfm2/nhw7SyVfEzhWFRo8eVruHrHU1zFr5z9hZmYHNBmjKXEoD/D/uz5B0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6xoi6HV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6xoi6HV"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c76b0cda2aeso570474a12.2
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774992963; x=1775597763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NZ3rbLtYIC+OsfIp8yl3gPRxf4HwgIR8326w2D8YeE=;
        b=Y6xoi6HVSlANMAo/sn2zEJ2mxD8ntC/MI7f7Bzy00Ktxk5Op72RTL7iARSakRecypw
         zs+iT1mBBlmrZ6n34Ji2MlufjZ5zWQenqMJeugYxFjDU2HAUkvDPk5rVCjirhpy0YCtx
         G6hhGLgr4/3TfCjtoedUcf4TQOsj3o7y02OA7yJQ+CxEj3X7w5C16y3LSr4/lJS+qyPs
         RHc/8IXSpFHtRczFKaxJn2Tq4SgURBJ38qK5x7lmRbJyaCHD+V0WcKxai5ALKJnLJe2S
         hdkUy9BGeVgbX7N97Hp/ObpeszND3e6mgsIA5KB/RjgZ+XFrtH6RV3VfcnxpDteaTGZ8
         VZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992963; x=1775597763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+NZ3rbLtYIC+OsfIp8yl3gPRxf4HwgIR8326w2D8YeE=;
        b=MhMLcMPa6VQnzUyorFcLOjNJ/MbDia9WkSAD8uH0LEr5KSrsreQDDXV4yVxwMlw9a1
         RwZPdkFUS8qEtW3Ui+hA+tP446ZLXLM/Dka59IJvnD9pGyGtSFoc98Ag2v9Ka6SCVPHB
         5AJOY8v7FRdTfggQFe7eDtRHe2HQKpRbKa07BlSpUn4wy1PlQ/U3eUXlo8/HLgJQCxwa
         sG/j6u1dC5AvPmZ4B0Bm/kcdeO8KeQnH6pvGidCfRSE9gJQ94vONiteptA7N1mZ+xtb7
         XYIB5aMu1W1YbN7KHuClGNMKW+ZI9e86QE+vxcHO+Xaq/y21pFGZdjSs79arKIPJ9LVf
         qPOQ==
X-Gm-Message-State: AOJu0Yz7DUC8eHpdo3WhnnT0DNMsf0zBYv6TU/8+S5ndpyq36fb0cHIT
	SxROKsIzzmaihnzWpJFayNyXq8TYvYRgx7GOv33XjtXeeY4bhjcIdJTS3s3vSw==
X-Gm-Gg: ATEYQzzl8PzGcz1FszuZnSjRJSdDPBOjZMzadAqIcrgRhB06WRKeGez3BQIgtkuN5Ko
	dwIqz44Lcit52zz92Z1IVUhwYqAkl3B8rGsb7mG/IAnGHTuBZKDclRUyureqPUJSTLnV5jjcMeJ
	n2Bed1rTcuXvtHUQC9DANBOfXHZnUCosWByNYemheeEvlYUfJLLe5KHKL5L7tg74re4xyM9yrft
	q+t51yh0FlhXWfHzf8cmaC9vSI4BDmBLOWg8xJfeUiTK28hkw3TyI7TzofnDdWBANCQ+YtobBiW
	F0LygqUMApLdQ8F4BBTjCKfhYp0xzysP+aqrhFb3UrKFUFT8MGwBhaJbP3lx4PMAczqSSozco0v
	KU74GwaL7O6xnrhBXCQbKj4iBzeu4TtG7jhEq03ESKVSxnHGhDJDrZ85ZNeWqk9qm0pzWCpXPYk
	f1OJMErtoV8dhm1Q==
X-Received: by 2002:a17:903:fa6:b0:2ae:a928:f544 with SMTP id d9443c01a7336-2b269cffde4mr6920725ad.45.1774992963138;
        Tue, 31 Mar 2026 14:36:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24ae15201sm91966615ad.84.2026.03.31.14.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:36:02 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: Remove TLD_READ_ONCE() in the user space header
Date: Tue, 31 Mar 2026 14:35:54 -0700
Message-ID: <20260331213555.1993883-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260331213555.1993883-1-ameryhung@gmail.com>
References: <20260331213555.1993883-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TLD_READ_ONCE() is redundant as the only reference passed to it is
defined as _Atomic. The load is guaranteed to be atomic in C11 standard
(6.2.6.1). Drop the macro.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/task_local_data.h  | 8 +++-----
 .../selftests/bpf/prog_tests/test_task_local_data.c       | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index e242c455ddae..91f3486439bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -67,8 +67,6 @@
 
 #define TLD_ROUND_UP_POWER_OF_TWO(x) (1UL << (sizeof(x) * 8 - __builtin_clzl(x - 1)))
 
-#define TLD_READ_ONCE(x) (*(volatile typeof(x) *)&(x))
-
 #ifndef TLD_DYN_DATA_SIZE
 #define TLD_DYN_DATA_SIZE 64
 #endif
@@ -184,7 +182,7 @@ static int __tld_init_data_p(int map_fd)
 	 */
 	map_val.data = (void *)(TLD_PAGE_MASK & (intptr_t)data);
 	data->start = (~TLD_PAGE_MASK & (intptr_t)data) + sizeof(struct tld_data_u);
-	map_val.meta = TLD_READ_ONCE(tld_meta_p);
+	map_val.meta = tld_meta_p;
 
 	err = bpf_map_update_elem(map_fd, &tid_fd, &map_val, 0);
 	if (err) {
@@ -207,7 +205,7 @@ static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
 	int err, i, sz, off = 0;
 	__u16 cnt;
 
-	if (!TLD_READ_ONCE(tld_meta_p)) {
+	if (!tld_meta_p) {
 		err = __tld_init_meta_p();
 		if (err)
 			return (tld_key_t){(__s16)err};
@@ -338,7 +336,7 @@ static inline int tld_key_err_or_zero(tld_key_t key)
 __attribute__((unused))
 static void *tld_get_data(int map_fd, tld_key_t key)
 {
-	if (!TLD_READ_ONCE(tld_meta_p))
+	if (!tld_meta_p)
 		return NULL;
 
 	/* tld_data_p is allocated on the first invocation of tld_get_data() */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
index 9556ad3d986f..e219ff506b56 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
@@ -26,7 +26,7 @@ TLD_DEFINE_KEY(value0_key, "value0", sizeof(int));
  */
 static void reset_tld(void)
 {
-	if (TLD_READ_ONCE(tld_meta_p)) {
+	if (tld_meta_p) {
 		/* Remove TLDs created by tld_create_key() */
 		tld_meta_p->cnt = 1;
 		tld_meta_p->size = TLD_DYN_DATA_SIZE;
-- 
2.52.0

