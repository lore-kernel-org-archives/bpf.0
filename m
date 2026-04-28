Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C613C3420
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777407283; cv=none; b=jC3Mfl9TxCpLCtQIjjm3viryiOFrsYzaNySGmr3vcD2fmmjExcn/4ZXgIKTcZSUvBMJmgfRctVQHTqN1Ia+hPFfDVnPMvNhBzZvDAd+a04f1vpEHh8KoIaYrxT09jjK7ws5vx0JOynKtWOfc1k0FnwAAg3MbBm+x3xhoPUhBFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777407283; c=relaxed/simple;
	bh=1q4TLVmoLeT69MEbQPGYWdeD/g7Q7os3928cIaxHyo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4HHnN5wH61Jx81XQXthkvP4aZh2dWgA4Z7w4PgqZR8WdvrdFJ0O+WIzy9aroOrH5TIeoOD3LEvPE5tah7Kh5MEYSGYb0p6dHEQRKjprMVxZIcAgDYBFy5ISFRQe3ys5F73PRXAW5Vp7KtEf9FNmx7D4S9jSuH0X2jN+hZfgQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApckJlWx; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApckJlWx"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7b4ee3a88e1so126813747b3.1
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777407281; x=1778012081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFwcnYAiHk5PGcTmT4nIhQaro9qZE/uyGnCLgPRNDPE=;
        b=ApckJlWxu1wGczIwd7zC9+oOPvHLUIZjtyXFR/C4ZMPH8bNjb8JzzuGXG6gWizQyKP
         nSOJUZCX1klcw/yADVKclQboyukPn/gnqc6ozbmY4TkDKZCj5cpPUcvsRjixitFz90GV
         96+C7GTX8OIf7Dos5zu33tbXbLLg4xkvc1TqQ/JPBQn5GoDNskVAaN1CeJ1I78XEAGhC
         9EVGDSFMTxHEuupySlri2JzYb/NLTVN9ZGe7n17yx+ssZRy3lo7r/zPR3EuN+pwFo6Js
         W6kEfYqh3BZFNZ41t15SDp8/HFSRJiqd2xIPXpnbk4vVFZ86ry/ys09AV+DEzoXwWoZT
         8JVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777407281; x=1778012081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFwcnYAiHk5PGcTmT4nIhQaro9qZE/uyGnCLgPRNDPE=;
        b=PxWQvkfw3jL/+BUHPGM8VpXrfRkzdIHZ4g5jPsxpVMXR/JM9VBtsa6FgT9WYngXCkb
         I7tWGzmeduqVah7MUaoowby+g37+feZaSP49Qgx1Njp/lVGf9fG8QnlDfFV9N9lubZqq
         5Fr7xA2aFrrUyF/CiZRs3DFb0Ol4hw5qSToXRyw4gSwDW7M95Ik3DwFstDqzfsgI3Tgf
         lXIcXaUPDPhKAstDRLp44ZLt9gdHJsnJnJGxFX0sT03d2eblrrNcldxhSbLrdbfa5UEl
         njCuYopLGQYwDr0MAJB1C3JZGHvZBJpxsG651zbTxrS6z+TysbPv2HSc2vqqkBboggST
         uONQ==
X-Forwarded-Encrypted: i=1; AFNElJ8O4N8v346Vsl1Y8wmKz46wRubKx0bmma9gyTlob56151jhxtANIJn+OB3mjsqmZGtc7fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz/47AiNTj2h1Da/rknow5hdVt5BeiGfQ1Ik7Q7sdxAWBK1Ten
	5nFmnpTu35Thjo5rrir5b61vC+b7M0HgxwH3jXKTJdDZBpwVQBkrhkdT
X-Gm-Gg: AeBDieuiOY8A6QfWqW/AqvyqBPvlk4z+cqbdzbozADFvbVDwMVUHj7UHhtH32pT2xCB
	bYlzrUl0XOfd1ZZBYD5iWNR0fvVWwOFqk9lm6RfZ6WC0PyV0qJ4C9kY2+ZD830MDgOwhsfZpcBx
	kAiUOtK5nQjEeB3L9yszeNj20HZw7QYJUtv7W5aZGYrXiotudKyR0v8ZLMj2EarD3hzly/KcO9T
	fwVIz12FrZKj147venDbsDU58uKWIoJHZDY2kJ6T/DOuak5w6faMPxOcmEfR0I8TmocKadUFH4Z
	EwJZhXfsk8DFLFpBWN9tnQit7XtCsV9vY+akbfOEa+CxjUYRk1o57XoYqox9RLTHrfHH0lRqDhF
	rXK9rJLWojGPTVpZ5RHztHKHcuc86+4M8WB+dTS80kSrCK/L1DIkAq7Mg59t+4dAN4xnLeB4I5u
	reoF7u8qL+8d0/6zg3V614QV5Zp2VkJuqCDk9MN2jvl4EUhAkwDuaMBPdhpR0u2QVns9msO3dto
	9/wF2I4Rb86FU4twCqaHA==
X-Received: by 2002:a05:690c:81:b0:7b2:2382:e309 with SMTP id 00721157ae682-7bd1d988e3dmr12395177b3.33.1777407281015;
        Tue, 28 Apr 2026 13:14:41 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:4c60:c627:eabb:73c3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd25af5385sm1392077b3.48.2026.04.28.13.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 13:14:40 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 2/4] bpf: Use rcu_work in BTF teardown
Date: Tue, 28 Apr 2026 16:14:20 -0400
Message-ID: <20260428201422.1518903-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428201422.1518903-1-utilityemal77@gmail.com>
References: <20260428201422.1518903-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue final BTF teardown from the RCU callback onto a rcu_work, making
sure all rcu grace periods cease before proceeding with free work.

Necessary for follow on patches that need to sync an irq_work but aren't
safe in rcu context.

Work queue is per-btf object. Work is flushed during synchronous teardown.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/btf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 77af44d8a3ad..2b0511663319 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -28,6 +28,7 @@
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/overflow.h>
+#include <linux/workqueue.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 
@@ -264,13 +265,13 @@ struct btf {
 	u32 data_size;
 	refcount_t refcnt;
 	u32 id;
-	struct rcu_head rcu;
+	/* Final free runs after an RCU grace period in process context. */
+	struct rcu_work free_work;
 	struct btf_kfunc_set_tab *kfunc_set_tab;
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_struct_ops_tab *struct_ops_tab;
 	struct btf_layout *layout;
-
 	/* split BTF support */
 	struct btf *base_btf;
 	u32 start_id; /* first type ID in this BTF (0 for base BTF) */
@@ -1880,9 +1881,10 @@ static void btf_free(struct btf *btf)
 	kfree(btf);
 }
 
-static void btf_free_rcu(struct rcu_head *rcu)
+static void btf_free_work(struct work_struct *work)
 {
-	struct btf *btf = container_of(rcu, struct btf, rcu);
+	struct rcu_work *rwork = to_rcu_work(work);
+	struct btf *btf = container_of(rwork, struct btf, free_work);
 
 	btf_free(btf);
 }
@@ -1901,7 +1903,7 @@ void btf_put(struct btf *btf)
 {
 	if (btf && refcount_dec_and_test(&btf->refcnt)) {
 		btf_free_id(btf);
-		call_rcu(&btf->rcu, btf_free_rcu);
+		queue_rcu_work(system_wq, &btf->free_work);
 	}
 }
 
@@ -6013,6 +6015,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		goto errout_free;
 
 	btf_verifier_env_free(env);
+	INIT_RCU_WORK(&btf->free_work, btf_free_work);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
 
@@ -6400,6 +6403,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 		goto errout;
 
 	btf_check_sorted(btf);
+	INIT_RCU_WORK(&btf->free_work, btf_free_work);
 	refcount_set(&btf->refcnt, 1);
 
 	return btf;
@@ -6535,6 +6539,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 
 	btf_verifier_env_free(env);
 	btf_check_sorted(btf);
+	INIT_RCU_WORK(&btf->free_work, btf_free_work);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
 
@@ -8446,6 +8451,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 				sysfs_remove_bin_file(btf_kobj, btf_mod->sysfs_attr);
 			purge_cand_cache(btf_mod->btf);
 			btf_put(btf_mod->btf);
+			flush_rcu_work(&btf_mod->btf->free_work);
 			kfree(btf_mod->sysfs_attr);
 			kfree(btf_mod);
 			break;
-- 
2.53.0

