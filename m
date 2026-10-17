Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8946C841
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278619; cv=none; b=gd5VfbUMBmZFNpk3M9ofOnIfhKUkTlAPmlJxdxJeJoYBiwhTau3xTnbbr9lDbX7ZduN6eXjPPdlICBI8Lulh7eKfVp7LTnpKoiaUsm0HElS/yznK7sMXqiYsfrqtfEQEW9yTgVbUe31tUwiFSy2081vQ3NQH5FO2671LXrE6tSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278619; c=relaxed/simple;
	bh=9aByiuY6uviIXExgY+w0sYV157gG0bi2Of4rSv4eqIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1/e89nZaEDrcfDDVzLcf8+NrY4CauMUG/qMNVmiYInZ8zdtfFzVyJpOskB1w9mYCz5zmaHoRBDiMJOTWHGTsLSIYQd6lj8HtXTU2qziR88vNL739wlzxz1VQQYYhJZhcxBhnhTfsbj6EtVOHrF+6vsdOoKsCXQtYueFpj0bTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMAwS/CH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMAwS/CH"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e5d0ee1951so6483185ad.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278617; x=1792883417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/qciBoMPYJlnJRP8tFkm767/AyPbCuLkauH7cTHL5k=;
        b=XMAwS/CHGX/FWulieEwPxkrlOS2+1oJTchdl0N8ckw6flrjneb5QAFXz28hVrXp6d5
         rkBha9wnlw4UBevu8WU3png5KL8W755s4cksJdDBHXUfbqPBOsJwJvOIyWjlcJXrR/Mq
         5QM3kb9wmeNPaVMXNIZDVmqyCvNShVvd63TvueWZkHRgRti2MlgQ6T48aFtpc29iRqry
         R8iwmCk5Yweh7gZUZHRQoJIbwokySJ/fAJ0thck8OP6PtdgThnocII8xLXS44mcni1+d
         EwbC3atkFPCncsU9cGsjipX4f2WgV7bqpCpzGNDvLWcSlEIp53Z9jxSCfHpSCZLEzbnO
         f3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278617; x=1792883417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/qciBoMPYJlnJRP8tFkm767/AyPbCuLkauH7cTHL5k=;
        b=zNQmnN3PeZPeKQVy+UqY1gXkx+6k8RZ7wXNn3v45FKQGIDFx09jQvfKwP6ijxMgHeX
         akWvE643T/p4L+VgO4AMA4pMzOaSNss/A3tapdUtsnecLCoKrIba0IszQ9yi4kxAOsqO
         MZCvSBBocAcxIIgbwA/D587/9GGaeipII2cUuHfHUGxNSjT9KXfxROgMG20FeGbHVTpn
         pIF1cvjxBKEAt60C62Fw3dxTzF/uXwwaVnIrwrwa4OYeI34MMNDTAvwUtOk7w45BJAT4
         c8/UJhEcgUwuWpYJhYDVFbhWgDtGJaV7R22AkoMdSyijyQd0f5IDvHcMRJ2qSfdmPn+R
         KRdw==
X-Gm-Message-State: AFq9FYJxqy1sdg+XQR4ksXc6LUaJdfwrZW4IMnEmJxr4Li59FwC2piob
	laL+GAiZx1slCg/S8+JcK3y1Lfc+rB6LmEX86lDj5T9zuq4EORMmKTVSE4SIiA==
X-Gm-Gg: AYBFou3fsLr1/cobnKUG5Y9y/LXHAhmbrdR5Q1kd3LvXuLwUI7S1BoES3/i8MVYj01Z
	WcuZoJidv4li+9ojXQhAHrZRoLvOW88GEYXUf1OscRLeSWZeinOBkYcmfjUEckBPF2k0fU8AHVK
	f6sCrr+VqJAMj81b3+YG0yLlrfdu0O/7c9ljBr1uJq9Bj95fqPfr2Gu6HdcgUHqtTa5+vjk311R
	ntAcTucj33/B50Nr0NaOsZe5ik4xknq7K7kTdAZbhkSd7lxDM7davy4wRFa4MhCuoQHamk+4dH8
	MNzG28gI+s0i5rcf0NZBZksvyZfm1evPF3Ix7bLkGi/AFS7A+D8Ax8R4ZEK2mUSn1vSKriJEIrq
	fAGVVyRFo3FUxWu8QZVTQXyFLjvnpe5ojs8e0hRWgrRYL1I54j1jXm2xbT7pbeD4SkeDYnnplKB
	/TPnomtUd5JyX9cH0oOZn5yK2FntXe928rqzQOyo/bI9vvAeu7XK2CCJ+t+VQHE9ME4plqmCAdC
	v1Zg7gK/GJIDsDr+A/IKVyNUMpC547xoa255e2rFA7xiS6RxFalBzY5gVLZcVLS1UbqCXGk59F0
	rE7K1pczPY+gto1QfFBD+qgxPARHala9wYqZ5Md56kY=
X-Received: by 2002:a17:902:cecb:b0:2e9:8ef0:cf6c with SMTP id d9443c01a7336-2e9a6d40b8cmr34714555ad.26.1792278617413;
        Sat, 17 Oct 2026 16:10:17 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b35eesm23391515ad.73.2026.10.17.16.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:10:16 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 04/16] bpf: Don't take an extension for a function that runs sleepable
Date: Sat, 17 Oct 2026 23:09:38 +0000
Message-ID: <20261017230950.802052-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

An extension cannot be sleepable, and it is verified as a program that
runs under the RCU read lock.  But it runs in the context of the function
that it replaces.  For a sleepable program, or a function that is called
from a bpf_wq or bpf_task_work callback, that is rcu_read_lock_trace().

The verifier lets such an extension use maps and pointers that rely on
RCU.  Its maps are not counted as maps with sleepable users either, so
that what it got from them is freed behind a plain RCU grace period:

  WARNING: net/core/sock_map.c:903 at __sock_hash_lookup_elem+0xe8/0xf0

  BUG: KASAN: slab-use-after-free in bpf_prog_b3bad285227d855b_ext_storage+0x245/0x297
  Write of size 8 at addr ffff888108717a50 by task fr/955

The verifier knows the contexts that a global function is called in.
Refuse to replace one that is called without the RCU read lock, and the
main function of a sleepable program.  A function that sleepable code only
calls under bpf_rcu_read_lock() can still be replaced.

The summarization test has replaced functions of sleepable programs by
ones that do not sleep.  Expect that to fail.

Fixes: 1e6c62a88215 ("bpf: Introduce sleepable BPF programs")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 20 ++++++++++++++++++
 .../selftests/bpf/prog_tests/summarization.c  | 21 +++++--------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2c812a5f1da8..d738ce6e7428 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22151,6 +22151,21 @@ static int check_unreliable_func_args(struct bpf_verifier_log *log, struct btf *
 	return -EINVAL;
 }
 
+/*
+ * An extension is verified as a program that runs under the RCU read lock. Does
+ * the function that it is to replace?
+ */
+static bool func_has_rcu_read_lock(const struct bpf_prog *prog, int subprog)
+{
+	const struct bpf_func_info_aux *sub_aux = &prog->aux->func_info_aux[subprog];
+
+	if (!subprog)
+		return !prog->sleepable;
+
+	return !sub_aux->called[BPF_FUNC_CTX_SLEEPABLE] &&
+	       !sub_aux->called[BPF_FUNC_CTX_NO_RCU_LOCK];
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -22247,6 +22262,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Cannot extend a writable raw tracepoint program\n");
 				return -EINVAL;
 			}
+			if (!func_has_rcu_read_lock(tgt_prog, subprog)) {
+				bpf_log(log,
+					"Cannot extend a function that runs without RCU read lock\n");
+				return -EINVAL;
+			}
 			tgt_changes_pkt_data = aux->func
 					       ? aux->func[subprog]->aux->changes_pkt_data
 					       : aux->changes_pkt_data;
diff --git a/tools/testing/selftests/bpf/prog_tests/summarization.c b/tools/testing/selftests/bpf/prog_tests/summarization.c
index 6951786044ca..3e4bcf071735 100644
--- a/tools/testing/selftests/bpf/prog_tests/summarization.c
+++ b/tools/testing/selftests/bpf/prog_tests/summarization.c
@@ -53,17 +53,6 @@ static void test_aux(const char *main_prog_name,
 	err = summarization_freplace__load(freplace);
 	print_verifier_log(log);
 
-	/* The might_sleep extension doesn't work yet as sleepable calls are not
-	 * allowed, but preserve the check in case it's supported later and then
-	 * this particular combination can be enabled.
-	 */
-	if (!strcmp("might_sleep", replacement) && err) {
-		ASSERT_HAS_SUBSTR(log, "sleepable helper bpf_copy_from_user#", "error log");
-		ASSERT_EQ(err, -EINVAL, "err");
-		test__skip();
-		goto out;
-	}
-
 	if (expect_load) {
 		ASSERT_OK(err, "summarization_freplace__load");
 	} else {
@@ -86,9 +75,8 @@ static void test_aux(const char *main_prog_name,
  * Also test a case when main subprogram itself is replaced and is a single
  * subprogram in a program.
  *
- * This holds for might_sleep programs. It is ok to replace might_sleep with
- * might_sleep and with does_not_sleep, but does_not_sleep cannot be replaced
- * with might_sleep.
+ * An extension is verified as a non-sleepable program, hence nothing that runs
+ * sleepable can be replaced.
  */
 void test_summarization_freplace(void)
 {
@@ -111,7 +99,7 @@ void test_summarization_freplace(void)
 		},
 	};
 	const char *pkt_err = "Extension program changes packet data";
-	const char *slp_err = "Extension program may sleep";
+	const char *slp_err = "Cannot extend a function that runs without RCU read lock";
 	struct {
 		const char *func;
 		bool has_side_effect;
@@ -136,7 +124,8 @@ void test_summarization_freplace(void)
 				if (!test__start_subtest(buf))
 					continue;
 				test_aux(mains[t][i].main, mains[t][i].to_be_replaced, replacements[t][j].func,
-					 mains[t][i].has_side_effect || !replacements[t][j].has_side_effect,
+					 t == 0 &&
+					 (mains[t][i].has_side_effect || !replacements[t][j].has_side_effect),
 					 replacements[t][j].err_msg);
 			}
 		}
-- 
2.55.0

