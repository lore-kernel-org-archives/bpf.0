Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642836215A
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629293; cv=none; b=kk/nVtiaywulvdyk/SVkhP0pqttmXVjMaXaQMZhndP1lS7cg4qFOtezqsfmNMyxu4w8yI8EX/ysyb/FprbIdVVCT4equq5zk5kBnhmBsqFtjRSIkQ2dimGkinuPnhGGd9h0aNLsqi8/kww+qR3usdvUUHCUyCqiq4kdzheasyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629293; c=relaxed/simple;
	bh=g6iPd9ATB3hMw2AbhUnAxLoFbKhETQcJ+0N+xSs+iyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hiv4xkrNI+bwkYQ1P7Uh4uNVtLsei4mzkI05VIBL/ldURN6ux9HqDGi5vM3hddrCYu8eFjUzOpp3d3D1EUs3OujBcM1Pa5+Deo9W+/0Nk6qtylovIqgpco1z69oI19+eJ/6cyZwFFNrfvH3A1GPf8AC1DXjgjYQNuewohgG4xUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAz5/czw; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAz5/czw"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so2549945b3a.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775629292; x=1776234092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDTY5WrNSh8QrJOXxdvhaX13ggf9iBqI3yFnGFwM5a0=;
        b=eAz5/czwApn/CKYYclKShyJSo+MCWX4aUkNk1FiYZraLl7dyhrtQJXQtMp91RI8i3k
         orvDVSfCVX7TuqZ06rL0XM/vJVpPOWg7epswCgnHCfOJ7w0uDbJbCRprIepEBcQpZp4F
         +3GSMP7YXVIuryvkrP3oA4UM//yBIGz81MAVLAKnR0yZKpPLBBUiEDTPJXJ9hR7TNTHf
         AceGWoiYSGEYrU4wuZ4x2xyuCeS14piHAgCwPycCk7xL1lR7hDN/KieKc07GVb74DVx7
         SaqXvJswg1ecqCUqs1IchUNXr39C/ufktvvWbE9OUKGpGZwYzIVytGTWwoyl+cGybiTc
         kgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775629292; x=1776234092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qDTY5WrNSh8QrJOXxdvhaX13ggf9iBqI3yFnGFwM5a0=;
        b=b3SodvnMHv9FRGPwN++TpPouHyCL8W/h+ilPq7szlrfwspdnK1ZNdRkqvj/CLVkqeN
         fXiJCwQ7pcibnCB3/N5DjUPVy/IyPheXBhzYcQ5ML3PzOJ2Q861mhf5VDhq/+lGepGyi
         UU77wafG5AxyKGJ8JNZVUXgJRj6aNg27OakQhuQcPFmprXMKAN54YSDboTaSJSZ0uHzS
         d8K69Vq0TH+IiP/ZxXEaFYdtJf+OfXGCHPKSSpDP8YQuWSxl0MgaOP9QizKGBNT5bEJW
         kRA8FKzD0nKXKCyqAJmDAVEIXDyD2b3k4g9eJW5siFCDcLd8BweWq8puNf1JhCLDPrVf
         Cn2A==
X-Forwarded-Encrypted: i=1; AJvYcCVKI+e4ZsdnJnC/pgG1nqug1oAITQDDRu+aJpWoLwHCnSa23UE9uKyOXa2NUg70em7/KP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtKA1zPeoVn9nfAAQjtv+qo4kqQYIRnSZ9U2JrtJEzDvVxcfK5
	2xQROm1U6Yf03roCYEs15vpd42hN/2tcfTnNHFZp5qeIagUJItZZeXiZ
X-Gm-Gg: AeBDievDqGTxMOYLEyPyEhDvPKWsyqzsIUuaZuCLi6yghNmTIsjz2RALsBmFS38Xe1c
	znO3f2jyrC2TPWWHZfE5SoINeGxHYgJtF7j5puLD7HQgRGXxQML3Rz1nRZrrVZ+pLG4p32I37nt
	RxVvZji4eGVeW/1zbh8rIgfTHqVgYAGwzGaOjGQdA8LzZ80iVcbLA3IJreWRLR5as9Ye5MN+BA2
	Q7+uFzyADhuSiAE81ip9MzdR4Qyw4eSmLGWL3I3hfVlrG2PWRANC9pLsvHe6C52UfH4H5M8PQZK
	eY+RzfhkMgweyma9yrwZEh6B/lE88QBWWkYMoetbWfQmhWYSYZ8qf8qwh9yqPRg5rteNWnYvOU1
	TIJgxj1Cu2Y6EONAiT3gZCk1P0/KTqPW6k3UGanSsbjGIJiZIVWmRhKNK/o46+x7hgM6GIUv+xR
	fpS5aAqFkyld/o5Cm374tV
X-Received: by 2002:a05:6a00:ab84:b0:82c:225e:63c5 with SMTP id d2e1a72fcca58-82d0da4cdf1mr18748819b3a.18.1775629291883;
        Tue, 07 Apr 2026 23:21:31 -0700 (PDT)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b60199sm17827638b3a.25.2026.04.07.23.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 23:21:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/3] bpf: add missing fsession to the verifier log
Date: Wed,  8 Apr 2026 14:21:07 +0800
Message-ID: <20260408062109.386083-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408062109.386083-1-dongml2@chinatelecom.cn>
References: <20260408062109.386083-1-dongml2@chinatelecom.cn>
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
Acked-by: Leon Hwang <leon.hwang@linux.dev>
---
v2:
- add a missing FSESSION in bpf_check_attach_target()
---
 kernel/bpf/verifier.c                               | 10 +++++-----
 tools/testing/selftests/bpf/prog_tests/exceptions.c |  8 ++++----
 tools/testing/selftests/bpf/verifier/sleepable.c    |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 594260c1f382..beb660b4c3ec 100644
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
@@ -25597,7 +25597,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (aux->func && aux->func[subprog]->aux->exception_cb) {
 			bpf_log(log,
 				"%s programs cannot attach to exception callback\n",
-				prog_extension ? "Extension" : "FENTRY/FEXIT");
+				prog_extension ? "Extension" : "FENTRY/FEXIT/FSESSION");
 			return -EINVAL;
 		}
 		conservative = aux->func_info_aux[subprog].unreliable;
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

