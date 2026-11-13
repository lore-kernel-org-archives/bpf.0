Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608088;
	b=0jAUdrZMXIN3nLRrsy/Hwc88AW28hC6LUkUbpox3bToBmCnnupHpXvGiRPfgtrxL3qYQ
	 Fs+GomHhkFf6vzedjUQzeQWipPD76IrSZ+I+vpPONd//ulHnU61Af0of0qCSs7Jb62Y3w
	 A7CIqLVAdYjeWZarztEisWvtLG3cKNBqmwvWjrrDdVxfMT4XMo2OwDPzrweIqvupc9UYb
	 LtloXFwQVxjQ7ioMb85mr7MdLTQyyRHoqcUG4OY/erbrhVQUiGg+oAudQOKT6NP58UPEd
	 5i/vRBKDZYumYNOR5e0I3pw8MysYpORN29h+X4dQaMNofe+8zXukaSnXtsjkmjDaufA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ggQ4FFC8Bi0XuOsjCC8PKsr9I1n0o4RHBwZ93v/svPs=;
	b=qzhqbCEy1RpH8ZNxyGVieFSMG9atKyPwJnPYumjS5vsuvxbUPbKUi70gNWN9ec741gcn
	 iRsXqoQ2hyF7T5ebnQ1MX8ZF0l5j0gwCEJYZ2iVEtAeu2nFL3lcDIiHEPCwkqW0BMj4B8
	 7S77id2drrlSJI+zCtJjMcep8kVNjBNYUMt1b9nrSC7EsjDc/pHuyG2rJBVKiy+kt079R
	 WfovzS/LRZ2SduOddnWBpT7Nu69QNpkTYnbZxQp+8JUzB24u/hbe8a5Idpb0D2XelUb6/
	 sMllQT9qcZsQS92pO9xuBPsqCkoLqdfcAOR2l4CGra5oWk6FJwRsuCO8TthZSJdTiIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Rt7C8vFD;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69960A260C
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 22:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F69960A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Rt7C8vFD
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b25d977b91so1235585c88.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 14:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794608088; x=1795212888; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ggQ4FFC8Bi0XuOsjCC8PKsr9I1n0o4RHBwZ93v/svPs=;
        b=Rt7C8vFDdlUdWI68CAfjn/FsIho2bh+RfoQ4YIesgSYGQIy+zo6sTBFZgGiuf8gHKo
         Uv7r7VcwqXZ2ihrLc0u4a5V+K4/zCgFqEFEMQzPTwlCEnRtZC4FvH2Ggy1hAUmvkYzOP
         RsjIfszZgC0cSTEWs7Vmm0HpbEwLxcEGA0l4B6cva3aEqYRB71WgJ2q+oishOX8Md5zV
         vUMaYDVlKIBo4eFXSiJcWHNCqUrTQ5MV73O6M55Aws2dWCb4cadq+r4Nq8mXKXYkEDpi
         fQi+ih0McSSVJyePrGliNJVYaN+nuYNj7zCn4sjKT07GgBij9ihSwAASy3T7K5gKfs5A
         6Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608088; x=1795212888;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ggQ4FFC8Bi0XuOsjCC8PKsr9I1n0o4RHBwZ93v/svPs=;
        b=ojg8/6Bi2FC+oFhce81ogUw0nDQVYZ08lIrwvuOOXb93KogpOmUc11kInFci0SnBDD
         4ikvB52wQ1Jb1uELkdF0xBj4uR+rWTlsmuXvaIxtBydaMGWWglgy92O5nzvgskJ32JeX
         3Cgyp8W+6z5tvGVebUBhqpAxrPY50EiI+OSUUZq6m5jdewBZC7BcaLEbfFhEgeX/aO41
         +iDj7T9DtE7bGDHiH38rfOhNAQz85mQGX4+j0K52ZDVAs8grlniN13kyMkyisIeOim+3
         tvC0gxR8LhZMH/IkhH2na4uXyS6iwSC+ogrZgZo/2cyKIJE+ofmK/4HZ6AbS6VFTRgeO
         hrtg==
X-Forwarded-Encrypted: i=1; AL+hErG3/bLa08Q46rnS2K0WeSSMzN7DsLNW/Qf5zDp10Bb/zJE4CLMHu0KZ+vMK2ABOMEtbecM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QaP8xdxZIpeUsuDVQly9wa6laOStvN3Cfe29c4+WONJ+TWiK3
	mZoi6NpHGM917/AaW7fggz8DcvFoExQk9QHjPYtI8ZV0p5zGl+/Ht0TOk54wbqO+WVDHwrQ4wC8
	Oz4aQJUgqRaoa+A==
X-Received: from dlbph19.prod.google.com ([2002:a05:7022:3713:b0:195:8b4e:20b7])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:b905:b0:1a9:d04f:1b55 with SMTP id a92af1059eb24-1b50311e3efmr3121638c88.26.1794608087024;
 Fri, 13 Nov 2026 14:14:47 -0800 (PST)
Date: Fri, 13 Nov 2026 14:12:54 -0800
In-Reply-To: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261113221248.3535369-20-wusamuel@google.com>
Subject: [PATCH bpf-next v3 9/9] selftests/bpf: Test typeless module ksym resolution
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The module ksym tests use typed ksyms, which libbpf resolves through
BTF. Add a weak typeless module ksym to the ksyms test, to cover the
module path of KALLSYMS_QUERY_BY_NAME.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 tools/testing/selftests/bpf/prog_tests/ksyms.c | 9 +++++++++
 tools/testing/selftests/bpf/progs/test_ksyms.c | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testing/selftests/bpf/prog_tests/ksyms.c
index dc7aab532fb1..801d38560473 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
@@ -11,6 +11,7 @@ void test_ksyms(void)
 	struct test_ksyms *skel;
 	struct test_ksyms__data *data;
 	__u64 link_fops_addr, per_cpu_start_addr;
+	__u64 testmod_ksym_addr = 0;
 	struct stat st;
 	__u64 btf_size;
 	int err;
@@ -27,6 +28,12 @@ void test_ksyms(void)
 	if (!ASSERT_NEQ(err, -ENOENT, "__per_cpu_start: ksym_find"))
 		return;
 
+	if (env.has_testmod &&
+	    !ASSERT_OK(kallsyms_find("bpf_testmod_ksym_percpu",
+				     &testmod_ksym_addr),
+		       "bpf_testmod_ksym_percpu: kallsyms_find"))
+		return;
+
 	if (!ASSERT_OK(stat(btf_path, &st), "stat_btf"))
 		return;
 	btf_size = st.st_size;
@@ -47,6 +54,8 @@ void test_ksyms(void)
 	ASSERT_EQ(data->out__bpf_link_fops1, 0, "bpf_link_fops1");
 	ASSERT_EQ(data->out__btf_size, btf_size, "btf_size");
 	ASSERT_EQ(data->out__per_cpu_start, per_cpu_start_addr, "__per_cpu_start");
+	ASSERT_EQ(data->out__bpf_testmod_ksym_percpu, testmod_ksym_addr,
+		  "bpf_testmod_ksym_percpu");
 
 cleanup:
 	test_ksyms__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms.c b/tools/testing/selftests/bpf/progs/test_ksyms.c
index 6c9cbb5a3bdf..0506bb574c4a 100644
--- a/tools/testing/selftests/bpf/progs/test_ksyms.c
+++ b/tools/testing/selftests/bpf/progs/test_ksyms.c
@@ -9,6 +9,7 @@ __u64 out__bpf_link_fops = -1;
 __u64 out__bpf_link_fops1 = -1;
 __u64 out__btf_size = -1;
 __u64 out__per_cpu_start = -1;
+__u64 out__bpf_testmod_ksym_percpu = -1;
 
 extern const void bpf_link_fops __ksym;
 extern const void __start_BTF __ksym;
@@ -16,6 +17,8 @@ extern const void __stop_BTF __ksym;
 extern const void __per_cpu_start __ksym;
 /* non-existing symbol, weak, default to zero */
 extern const void bpf_link_fops1 __ksym __weak;
+/* module symbol, weak, zero if bpf_testmod is not loaded */
+extern const void bpf_testmod_ksym_percpu __ksym __weak;
 
 SEC("raw_tp/sys_enter")
 int handler(const void *ctx)
@@ -25,6 +28,7 @@ int handler(const void *ctx)
 	out__per_cpu_start = (__u64)&__per_cpu_start;
 
 	out__bpf_link_fops1 = (__u64)&bpf_link_fops1;
+	out__bpf_testmod_ksym_percpu = (__u64)&bpf_testmod_ksym_percpu;
 
 	return 0;
 }
-- 
2.56.0.679.gc527c65306-goog

