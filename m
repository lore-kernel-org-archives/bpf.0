Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714663;
	b=1EF1Vuw//kBgW73wmyeipCtM+vHejSsxIbpWB7Pp+1WSCbwAAZLpmFz3njEsk4wEtAoP
	 L52zVFEXU6HZfTkQSeSWtB1i08p2j7ytzxwY6Or3dSAF4k6lX4JQtcechor8VBP8xE1+7
	 BUXZpJeoFoW4Hf6mIRDhT/SD36YCLsPMzluF+PPiWPfMI8AWL+Ett5Z67yNSJjKpx4C24
	 1LSjw7DU1y6T8nQ0ddNYOPESybxchjY5fbIbpN8LLPkfUCcqegrtfp7nia452fTb+lQRS
	 d1G2/djUifNVwlAvi/J/7FuiUQOVjwpyfDkPtQ45I+1J9ymgFRPBWnXfYLZaMU/7wxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DqleeFdjbt6KHN7sXzWbOq4/x+wnYCrVXyGZTqdZ4EU=;
	b=e/aXHlgspZanusN9n+MbH7kn9z/fUoF9GeCv30ipaJRmjvq14pIV0lM/VMYPviinW6Yk
	 qs51Sr2R8pfybm+M380WVKIslpccluN6fAEC/FnbO3w2X9K3ScipCHRI25cFj/5BjacVN
	 izXw87w8xoC0+NRN0A9dcvJnBnfRHwgHZY2YhNkKoyd8k537KulNTzJo7KEnJw44ehU5o
	 ych+F+hNkaAbeQddh9JCqaz7NV6xYKz9yYC73bZDgPyNsdEeVms7V7vnLbt0iZQPtJvEs
	 fWjdYOzThldQsBmgQ6I6ZhYaJhSNSWJbAPgocwu6IGOm6lnoByxK5wHa4f0quRxGNLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mU39zfAw;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCD606A33C
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8BCD606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mU39zfAw
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso477771eec.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792714662; x=1793319462; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqleeFdjbt6KHN7sXzWbOq4/x+wnYCrVXyGZTqdZ4EU=;
        b=mU39zfAw9jnaX4X+dglnA6VBcIqvTFsVSZq6kyuDhMMBKP6bUIGMsnhaJktzMva418
         R6Tu9nweM6+3+hlpU9VqOvtJ8kNli5d8VZCFC6YERhdUtrX0W87pNy5F+p3bXAkI/Qtg
         /bxlP0HLCbMx2KJOyVLRoSg+vp/PKwTin1e35AkrC/g0rZIA0x1xM9C1JHNdybJUxfn0
         dgV3IkDl7P6/PfClFz2YVLBdDscq/u5Vlnil9vqZejdZk72p9ZFPryPCkSG67ddb1MAb
         5RUXZbhNAk4wlFohKXQgo0HYzn3KF8M9b3S+R49/GQ+IEMz/ukh9DtXhpuTIqusLjuHA
         zXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714662; x=1793319462;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DqleeFdjbt6KHN7sXzWbOq4/x+wnYCrVXyGZTqdZ4EU=;
        b=l5juy5vBUvcpnR+63//PB0lFkv31I74+HV75ERdQ55rGN1rxUD3D8eXTlCtMwej9f7
         qbhCFTJcDdlMXEdxhoM7jQlINrjONfRWux7KIBfCAJyMVT6aY2owy0EC8H12bz8Ds6cq
         vPh0Ep7Npx3cHgVW69aZyWNzA9YpZtTKDE4CZ1AndCjneK/OtKzG/mqKYXKInNLM8IMc
         ItCq9Rta05zBVeUH83EfYV3hJDv07Tm7uZrnd2Hyhs8lJ7r388vhpWnLJQGJflwxjG45
         sSOEO9Bi11raLK+sGy43RJhI5M62b+fXbe4ARvUSMgU/A0K4XebCin4CwzlfVgRG/GgK
         EL7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwLfyh9L8wcp8dkHBLMYDBZdFZjhjlwEhG+A/XstXz5t9oDDLDwHJfoBRSziqzQEioHGJU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRFssglXmCbupPs6avsgXcMB6agN4oU6AKSSARdA/XKLnerzPz
	dqEJUM9UYjCoo1j5/3S8q1+dx2HimKJBfEQVExUD7LbPF3FgoifKiOrB4jnEsCu9rqZA5LPgKxA
	k29kVnCdcVgeuqw==
X-Received: from dycam14.prod.google.com ([2002:a05:7300:fc0e:b0:369:739:9a00])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1c93:b0:366:703c:5ef8 with SMTP id 5a478bee46e88-369d9731914mr883157eec.7.1792714661530;
 Thu, 22 Oct 2026 17:17:41 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:16:06 -0700
In-Reply-To: <20261023001603.560210-8-wusamuel@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023001603.560210-13-wusamuel@google.com>
Subject: [PATCH bpf-next v2 5/6] selftests/bpf: Test typeless module ksym resolution
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Typeless module ksyms are resolved through kallsyms, but the existing
module ksym tests (ksyms_module, ksym_race) only use typed ksyms, which
are resolved through BTF. With KALLSYMS_QUERY, libbpf resolves module
symbols through the module lookup path of the ioctl.

Add a weak typeless extern for bpf_testmod_ksym_percpu to the ksyms test
and check that its address matches /proc/kallsyms when bpf_testmod is
loaded.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 tools/testing/selftests/bpf/prog_tests/ksyms.c | 7 +++++++
 tools/testing/selftests/bpf/progs/test_ksyms.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testing/selftests/bpf/prog_tests/ksyms.c
index dc7aab532fb1..62760284f746 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
@@ -11,6 +11,7 @@ void test_ksyms(void)
 	struct test_ksyms *skel;
 	struct test_ksyms__data *data;
 	__u64 link_fops_addr, per_cpu_start_addr;
+	__u64 testmod_ksym_addr;
 	struct stat st;
 	__u64 btf_size;
 	int err;
@@ -48,6 +49,12 @@ void test_ksyms(void)
 	ASSERT_EQ(data->out__btf_size, btf_size, "btf_size");
 	ASSERT_EQ(data->out__per_cpu_start, per_cpu_start_addr, "__per_cpu_start");
 
+	if (env.has_testmod &&
+	    ASSERT_OK(kallsyms_find("bpf_testmod_ksym_percpu", &testmod_ksym_addr),
+		      "bpf_testmod_ksym_percpu: kallsyms_find"))
+		ASSERT_EQ(data->out__bpf_testmod_ksym, testmod_ksym_addr,
+			  "bpf_testmod_ksym_percpu");
+
 cleanup:
 	test_ksyms__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms.c b/tools/testing/selftests/bpf/progs/test_ksyms.c
index 6c9cbb5a3bdf..69309f2a2d0a 100644
--- a/tools/testing/selftests/bpf/progs/test_ksyms.c
+++ b/tools/testing/selftests/bpf/progs/test_ksyms.c
@@ -9,6 +9,7 @@ __u64 out__bpf_link_fops = -1;
 __u64 out__bpf_link_fops1 = -1;
 __u64 out__btf_size = -1;
 __u64 out__per_cpu_start = -1;
+__u64 out__bpf_testmod_ksym = -1;
 
 extern const void bpf_link_fops __ksym;
 extern const void __start_BTF __ksym;
@@ -16,6 +17,7 @@ extern const void __stop_BTF __ksym;
 extern const void __per_cpu_start __ksym;
 /* non-existing symbol, weak, default to zero */
 extern const void bpf_link_fops1 __ksym __weak;
+extern const void bpf_testmod_ksym_percpu __ksym __weak;
 
 SEC("raw_tp/sys_enter")
 int handler(const void *ctx)
@@ -25,6 +27,7 @@ int handler(const void *ctx)
 	out__per_cpu_start = (__u64)&__per_cpu_start;
 
 	out__bpf_link_fops1 = (__u64)&bpf_link_fops1;
+	out__bpf_testmod_ksym = (__u64)&bpf_testmod_ksym_percpu;
 
 	return 0;
 }
-- 
2.56.0.257.gf7497c7d27-goog

