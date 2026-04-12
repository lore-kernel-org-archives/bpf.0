Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963B271468
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775973846; cv=none; b=G1TGA8TT/SAyxw4OAgTF8JLXMuGm+u88Fg31gD7iVhpmWVvtR+XhYT0ThjSsQgxKHsiJZCLUOdbCrR/TdJB8udoFycj0ntUJigNaZHKu9EILgxT+TU2seulZytSv4h3fBx3NXWa8Pxb3zS+/6o2qnMx/8Ys/z8DEvMDEG0oRlPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775973846; c=relaxed/simple;
	bh=tH97OV+P0DlPe6LxB5CgjEjvpu/auSFpJ5iJ63eCf6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOnKf/g9evX9NFtuqueYxVmAyF0zCg5VCYGvyvTyOyeggmjEiVVYSUBxTa+tS1LAUqnH8eftmt/Vd9m6QFh1m5a/H/TY0t511QdMiWGnOxU3tqBepCftp7yryhoviPjzIFjLlq5GHVnNsR6Qr1PUYsGMoNIQ5k/euQvdWDc0wu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQA5EHdJ; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQA5EHdJ"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so1235633a12.3
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 23:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775973843; x=1776578643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFbAgBrmlqnGRPpGIwv5xn3IZvtUwanJPAMvMFafaIA=;
        b=dQA5EHdJzKce4LlD2AF4qe+U/IRwLoexGwlia43aE+mTBnoi5PIpU2lKRh/wTFfjCC
         V3VlMPxsJhzBfaFdkC9pDQ2/MdKr74kQz+8U3jjkExM5TjvMMmZ7RymdacW64lnb1mk7
         /vYBs4hb4q2s/6GsrH4gGkjJF7Ky831je0e2A5vErFzRdYpSaCSxmHN5oXan+IW2tDa8
         tKkaLBmpW7OMelSBvrBJgSalcMjQmMSkPrwrsDG1t5JWODdH45X050RkPSKiJXel+TDr
         ze/eCvQ4x8CUODCRUbs9GKZln3rpxco55cERlcDjLeRL4MqQ/45wvM/KOFd7yn0ntyPH
         ufug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775973843; x=1776578643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LFbAgBrmlqnGRPpGIwv5xn3IZvtUwanJPAMvMFafaIA=;
        b=IEKwUyVltIp6tAMqi9UUiHhKvwIBTtyt2b0DmCMFWIBZDHc4M99FeTeeC8HVdp5Bxz
         DKptsCQpknLjChEZhzk/+KXpiNixt4KyNeh9qbCxoDhRG5iME5m0ZsfbdzQ7QNt3tYAH
         4Osv3aN4ZWZjh0N0SHGh/EMcJ2F5vNzj40OyLVVEfnaYG2uB7mCW87mZWiV4cMNvzo3B
         HfgtuiSlU/dN3F3+bTYsSAX9hfW/zy8UEmzVkHbsZi/mwz9KYJxEtvLxVn5rqG+iTv8t
         GhjdhLrtx+8UVeNkU6wOhmV6LzMDiQ+kujH/PEPMw2PmkeCVF7r/A0sAwGCH58w0ORn1
         oYgw==
X-Forwarded-Encrypted: i=1; AJvYcCVGhrv1K+KsYMpuysoX9wR06o68vecsE5mMVEzo4jQ3lgcguGEMF5WQpJxL7dMhCrvnKlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE0OGVSr5kfM1FAKiPqCh9yJH3PeW69vqGZ/0kNPww2nw80adM
	KfxKwu35RwQCo0ljuIau3+ZJHdDChT3Ljc1xuhqIAtk2WppsZER2lKVB
X-Gm-Gg: AeBDieu/vPYxVMt+eQA050IwMpDZ2HHD020QpdX73yM7Z/lW3JVzQQytPU0D/7yQVU6
	25OQwAlO8CMoPKet8mR3+pFjyO3zmymyfC1NH/CWHksEqA8liPcVTG8f7gENPLYHdk1KLuTMhAR
	P3zW1kaS15rCuFQGeXfdAT7rKOZZH1y1/h88oYLvVKMRic0FvpY0+RiJfWcWVD44VUqg/uvdOFV
	tqT8N7UrvoK5KMyNk0pQaHPaEJ/AUZhZ16WSx8uASCWKkvkOZfz/Nl4PnZFlH2xAHZjwb8xz3oc
	BcPYEhDG/TqKRSmB9PC9iOXEAfkJM8QfQZQxSuviOZCnXdOikAL+FNfpM291iSrQNi6G6ZkkTRo
	3H6y2NBAsjNeZaZqu35+tnyTm2bedmHFC0WAZbtsa+HywayNeke/RQL5ctnEJC3ryKep5xxSmmb
	JFaXgOrc5E3z0bNgIyDnLH
X-Received: by 2002:a05:6a00:302a:b0:82c:daa4:ce29 with SMTP id d2e1a72fcca58-82f0c2d93admr9215246b3a.47.1775973843395;
        Sat, 11 Apr 2026 23:04:03 -0700 (PDT)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b251esm7072645b3a.37.2026.04.11.23.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 23:04:03 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	emil@etsalapatis.com,
	leon.hwang@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 1/3] bpf: add missing fsession to the verifier log
Date: Sun, 12 Apr 2026 14:03:44 +0800
Message-ID: <20260412060346.142007-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412060346.142007-1-dongml2@chinatelecom.cn>
References: <20260412060346.142007-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fsession attach type is missed in the verifier log in
check_get_func_ip(), bpf_check_attach_target() and check_attach_btf_id().
Update them to make the verifier log proper. Meanwhile, update the
corresponding selftests.

Acked-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- replace "FENTRY/FEXIT/FSESSION" with "Tracing"

v2:
- add a missing FSESSION in bpf_check_attach_target()
---
 kernel/bpf/verifier.c                               | 10 +++++-----
 tools/testing/selftests/bpf/prog_tests/exceptions.c |  8 ++++----
 tools/testing/selftests/bpf/verifier/sleepable.c    |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 84699a428077..ac89ad992f27 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11690,7 +11690,7 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
 
 	if (type == BPF_PROG_TYPE_TRACING) {
 		if (!bpf_prog_has_trampoline(env->prog)) {
-			verbose(env, "func %s#%d supported only for fentry/fexit/fmod_ret programs\n",
+			verbose(env, "func %s#%d supported only for fentry/fexit/fsession/fmod_ret programs\n",
 				func_id_name(func_id), func_id);
 			return -ENOTSUPP;
 		}
@@ -25494,7 +25494,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
 	if (!btf) {
 		bpf_log(log,
-			"FENTRY/FEXIT program can only be attached to another program annotated with BTF\n");
+			"Tracing program can only be attached to another program annotated with BTF\n");
 		return -EINVAL;
 	}
 	t = btf_type_by_id(btf, btf_id);
@@ -25530,7 +25530,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (aux->func && aux->func[subprog]->aux->exception_cb) {
 			bpf_log(log,
 				"%s programs cannot attach to exception callback\n",
-				prog_extension ? "Extension" : "FENTRY/FEXIT");
+				prog_extension ? "Extension" : "Tracing");
 			return -EINVAL;
 		}
 		conservative = aux->func_info_aux[subprog].unreliable;
@@ -25619,7 +25619,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_TRACE_RAW_TP:
 		if (tgt_prog) {
 			bpf_log(log,
-				"Only FENTRY/FEXIT progs are attachable to another BPF prog\n");
+				"Only FENTRY/FEXIT/FSESSION progs are attachable to another BPF prog\n");
 			return -EINVAL;
 		}
 		if (!btf_type_is_typedef(t)) {
@@ -25885,7 +25885,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
 		return -EINVAL;
 	}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
index 84ab73e08b0e..e8cbaf2a3e82 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -128,7 +128,7 @@ static void test_exceptions_success(void)
 				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
 				       "exception_cb_mod"), "set_attach_target"))
 				goto done;
-		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
+		}), "Tracing programs cannot attach to exception callback", 0);
 
 	if (test__start_subtest("throwing fentry -> exception_cb"))
 		RUN_EXT(-EINVAL, true, ({
@@ -138,7 +138,7 @@ static void test_exceptions_success(void)
 				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
 				       "exception_cb_mod"), "set_attach_target"))
 				goto done;
-		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
+		}), "Tracing programs cannot attach to exception callback", 0);
 
 	if (test__start_subtest("non-throwing fexit -> exception_cb"))
 		RUN_EXT(-EINVAL, true, ({
@@ -148,7 +148,7 @@ static void test_exceptions_success(void)
 				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
 				       "exception_cb_mod"), "set_attach_target"))
 				goto done;
-		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
+		}), "Tracing programs cannot attach to exception callback", 0);
 
 	if (test__start_subtest("throwing fexit -> exception_cb"))
 		RUN_EXT(-EINVAL, true, ({
@@ -158,7 +158,7 @@ static void test_exceptions_success(void)
 				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
 				       "exception_cb_mod"), "set_attach_target"))
 				goto done;
-		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
+		}), "Tracing programs cannot attach to exception callback", 0);
 
 	if (test__start_subtest("throwing extension (with custom cb) -> exception_cb"))
 		RUN_EXT(-EINVAL, true, ({
diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
index 1f0d2bdc673f..c2b7f5ebf168 100644
--- a/tools/testing/selftests/bpf/verifier/sleepable.c
+++ b/tools/testing/selftests/bpf/verifier/sleepable.c
@@ -85,7 +85,7 @@
 	.expected_attach_type = BPF_TRACE_RAW_TP,
 	.kfunc = "sched_switch",
 	.result = REJECT,
-	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
+	.errstr = "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
 	.flags = BPF_F_SLEEPABLE,
 	.runs = -1,
 },
-- 
2.53.0

