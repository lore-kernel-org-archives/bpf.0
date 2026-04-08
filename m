Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD72B2EA498
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 03:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775618082; cv=none; b=EIgrRTHegBObgFfXFka4a6r5gzkDruDv6GoJgligsalbsOS419ezBjkdxyhutAV2jzl+PrC4mPxHlOp2fsMHpI9IxoPWk4KONaNFfqnVE6pXN9mf2/wHT+ROPild0YBjkqrtzid1w64dBZM469wc7PI+M142vGfVl+dmvu1ccSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775618082; c=relaxed/simple;
	bh=wW8+WCBgIrCEX56/SsdT2XQwxb/50iQNCug2jZFhLrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLP77Q2W3FcFjpgJP58GSsXsFc+WksNdsBjQk7Fcu+g15szF7nzBwEUXer1scYupHCmFfJlt9bhpou/tGMfUY1S78zBK67arDUVBXZSIpTXso043hYE0WBLCKpHcdiZijHb7/c5foWztRp4FfOFStIi+1UyOOzvYK17Nmcc7+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRSI9Wke; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRSI9Wke"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so4943204a91.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 20:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775618080; x=1776222880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeCg0Ef5NFNCG+pFZ483XFA+LTJBKt1oc3PUJbKPktM=;
        b=SRSI9Wkew9MyCjh74rjwrY2iVE123LqRFkpexTEXRI0tbKMr+udI6yXe9iwkBrW0oD
         +YRr2JuqJhsqk1kjW38EtSDpNU64eiOqibYWTfAJnDEkp3QkhtcSS1pWfA8JenIfpkty
         2it85ZCcNd4sybhefdZc0iitUz0EeeB12WYDCfL8QfQXPvt2NjFCsLtMIbkduhewWqBB
         6xjcshDuSgVARrobbYIta+piCGALQXHrcD3Wb0rN/h713sGtIp+npoIDDdMSbW7pI/xt
         gCgr8n9STFp3a5Kx8XqcGGz1IK82xQKui65nJOyyrzpEzplNkgj35dIUrZEgcYtX1/77
         fmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775618080; x=1776222880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XeCg0Ef5NFNCG+pFZ483XFA+LTJBKt1oc3PUJbKPktM=;
        b=Cfwt9r19z7wvwK3GQp0GmJ1B7lZoaRm4LMOFbfGCV9IYpY2I6FwUxd2I/7m7Ae76g8
         Y0dazeeq9Hl2wG42lMrooIxLBCEpkeLDY8pX3cig8BrKJEU915gslPpq69T9egzcsqbI
         CW1mc81Z2b6PVDTl+9g0Flji6TjAedhrZIk9DLsxTs81ZSjSQyma+SDM9WCneLwF7DY9
         xlrSfHDhoLh7gh24pt1XMdAdz6hdWd2HWwioahn0/AwSfqhYzZxTfApiBbh0YtLXVqdT
         fckBff0nwsPzpjFPp1OPCHiCdo6ldARZJTu6ivMobcRfUOg0bPfRS//SUcJPtVr1uupm
         WcdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuUcGtr5MYc16CSUJxrTztWvrouayarqXttfffwL//fpnYPx4MM1zZAjkqJwQdO5eUIOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/nMNW2E9dqH3AcWOnPOyyj3TsNFprYvO8/y1X1+0hePHPI6GM
	fr/qUnIhXj8GZpi7rCsbic1T9QkepAbXwrqFrDRdSUo+8nFBRtySozRm
X-Gm-Gg: AeBDietiGdnEoaOfVgyu7zKZ0Y/BkQbQ06OZgrkdKv2yBXgfXfL1ZpxePDdg4ZPC/2C
	7BeRliiTU1mp5l6HFgSZ5A2vDVfJArv5pDFLlmq06KfvHet7cilqUALz8Zc6KP/UhunTJRp0Dpq
	dBmuKDveFIoq8NOh7FBi6gyfFFqscGGDleTmzQnm4dGd2SuS0ScQFUy5vKekGIXgK8KyFhlPoMJ
	Q1iPv4w+GG8VFwalLTgDD3i+w1PwWpuIU/p7COO94NLGo6vNTcfwowsQKzokNuK7UaFnZi4Ffcl
	asiAfiOhMWZwC4Eh/zF24nE2WjfVOePb5WHCknm6oMNYcQvYyFPpaEoh38GGRb2P1pjlgd15T5o
	/a4hmTXYs7Qr8MK5kEGrOBj8iLfuICmnoakYyilhQMhc3EKVX8EU6rp8umBdovmJXXRLVYGzkAz
	wJnNIgHKWOPz2sKuYU2Zzp
X-Received: by 2002:a17:90b:3b86:b0:35b:a8cf:7960 with SMTP id 98e67ed59e1d1-35de678fa63mr18665076a91.3.1775618080003;
        Tue, 07 Apr 2026 20:14:40 -0700 (PDT)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe41b11fsm23506913a91.0.2026.04.07.20.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 20:14:39 -0700 (PDT)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 1/3] bpf: add missing fsession to the verifier log
Date: Wed,  8 Apr 2026 11:14:14 +0800
Message-ID: <20260408031416.266229-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408031416.266229-1-dongml2@chinatelecom.cn>
References: <20260408031416.266229-1-dongml2@chinatelecom.cn>
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

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/verifier.c                               | 8 ++++----
 tools/testing/selftests/bpf/prog_tests/exceptions.c | 8 ++++----
 tools/testing/selftests/bpf/verifier/sleepable.c    | 2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 594260c1f382..707eaf262307 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11757,7 +11757,7 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
 
 	if (type == BPF_PROG_TYPE_TRACING) {
 		if (!bpf_prog_has_trampoline(env->prog)) {
-			verbose(env, "func %s#%d supported only for fentry/fexit/fmod_ret programs\n",
+			verbose(env, "func %s#%d supported only for fentry/fexit/fsession/fmod_ret programs\n",
 				func_id_name(func_id), func_id);
 			return -ENOTSUPP;
 		}
@@ -25561,7 +25561,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
 	if (!btf) {
 		bpf_log(log,
-			"FENTRY/FEXIT program can only be attached to another program annotated with BTF\n");
+			"FENTRY/FEXIT/FSESSION program can only be attached to another program annotated with BTF\n");
 		return -EINVAL;
 	}
 	t = btf_type_by_id(btf, btf_id);
@@ -25686,7 +25686,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_TRACE_RAW_TP:
 		if (tgt_prog) {
 			bpf_log(log,
-				"Only FENTRY/FEXIT progs are attachable to another BPF prog\n");
+				"Only FENTRY/FEXIT/FSESSION progs are attachable to another BPF prog\n");
 			return -EINVAL;
 		}
 		if (!btf_type_is_typedef(t)) {
@@ -25952,7 +25952,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
 		return -EINVAL;
 	}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
index 84ab73e08b0e..94a62fcd4543 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -128,7 +128,7 @@ static void test_exceptions_success(void)
 				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
 				       "exception_cb_mod"), "set_attach_target"))
 				goto done;
-		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
+		}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);
 
 	if (test__start_subtest("throwing fentry -> exception_cb"))
 		RUN_EXT(-EINVAL, true, ({
@@ -138,7 +138,7 @@ static void test_exceptions_success(void)
 				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
 				       "exception_cb_mod"), "set_attach_target"))
 				goto done;
-		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
+		}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);
 
 	if (test__start_subtest("non-throwing fexit -> exception_cb"))
 		RUN_EXT(-EINVAL, true, ({
@@ -148,7 +148,7 @@ static void test_exceptions_success(void)
 				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
 				       "exception_cb_mod"), "set_attach_target"))
 				goto done;
-		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
+		}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);
 
 	if (test__start_subtest("throwing fexit -> exception_cb"))
 		RUN_EXT(-EINVAL, true, ({
@@ -158,7 +158,7 @@ static void test_exceptions_success(void)
 				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
 				       "exception_cb_mod"), "set_attach_target"))
 				goto done;
-		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
+		}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);
 
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

