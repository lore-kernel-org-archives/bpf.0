Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702666;
	b=eOe+puBlPNGpvaW13rGGzfbbgSx+eiUtB5p3BmuahN6L4atF1SR9Qu6uBUdTwiP3kT/K
	 oR9xJswmCK20aEDu6PxKbiGsgEanrQ3Xzm+uHlwdzJSqPLqMCV0KEbRB5CSm1Pw1UbMke
	 wlJfjw/GrApzCdhW9caY2uF3Aekwcgy/wHRSp+kmHhUFsK0CbF2QXnJ7Pk+UyKJ74u2oy
	 sU80lJKSNik8RgDc5qqyyYZTAavPJfX7h6gVSWO9Gi2wA5tfRH1oe9gqmJcGtWcG2Onmh
	 kdAYf26jnTA7FlBrb4tzLLgjOG5YEiztn14GMhTYajfNFwm8XVxLr2TL+WpH6hxUtsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702666;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d5kPjlmVukUgh2VIiEqN1J+EQssu+1tSxEHNxTN5XCU=;
	b=ZZoGod41eDu7XjAxQVzaNVcep8XtgFHmF2kXrfZbq+Smxh6ByNrTgY+mENAT4dfTqDkd
	 5vtAUK1kIfL8HKSsvAhCCBjsIATew3T7CnhRUnMfe0S3dEYZTiHDUkajOROVe7+RrmFIx
	 vBPGr4h8zQJ3LbXqp4I7rg73wEeOMtTkK9hFkWrg05BoPNO7kOOo26ftFgMNs42HLLOUH
	 l0gsYO4JYEmxdJdhvVP5Zp6ysEZIjVWx8CpnUWqRO05XFwDMh2jQa2U742NLKcpufDVmG
	 cTjrIW/g+IC4TYLoldGHlNVtrrYgAG4RMr6NhpUun/O1ZCtwVQ2ADTY3Ty3/+dkKQ+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jc6iRkKp;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55C606A32C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC55C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jc6iRkKp
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bba5e17cbeso17920315e9.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795702664; x=1796307464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5kPjlmVukUgh2VIiEqN1J+EQssu+1tSxEHNxTN5XCU=;
        b=jc6iRkKpoFBU8iE35sewqPITyGJuG166299CPS6EGuA1MTv+7/ZLihTvos0Fh5qfqm
         //OrOPspQGnskk63DexqSOVcP9jV5zksVNcUeFDNdgWdt1ADjI5cp4gPFXkhZ7bGzUn5
         QX3W1ZrMMAP4A9CnEbe9u7dEcH+uJ4GYBtZp1sX4cdXdUHokiKvHMCj6XDWuPYRY0wDX
         AuTRSls6qmDE22dR7V4zhO1TfJoqgQYxNFWIar8+hFqBl9FyV7OIxBkdjEmwdkrYwUDh
         pr7HaPWq+XDf9HGl0m8SzkNJ6+GkAo1r4jKY7N369k+wIISjGSUDZFemE1bUGwJD5uFs
         NcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702664; x=1796307464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5kPjlmVukUgh2VIiEqN1J+EQssu+1tSxEHNxTN5XCU=;
        b=M78Ko2ovFCiA4Rh/3LNdPsweFIVcuGlsGdyz7ueLspvD0etTyiC27pRodNyrMX4fgy
         ObcCOq3EYUuTPfMrbQZrN9aI52rpoWGAeKwYbn9/quNOHD+dxbv036TOmsktLG521G3q
         W/rngPsqyCJTvFe11bDfZy9zfABTz7mEiCGccZS4VN63x5/Mord5ZWPzOZSUhOqq3JTd
         JO1XlCJuiglkQ06A5ggN4TnO+zHd0+MnBd9riMsGpeurL124OuP7IKw7ORMe890vdVFK
         IAU1UlG8ZdbL6jc0Sc23CgTV/Gfkl0PZvsGQ+Z6hpCy8djrrCop5iIksrxNmB279wP57
         QLfw==
X-Forwarded-Encrypted: i=1; AL+hErGXRPnT8wFQkYJ2vStAalHtrAKMdQbi0vGFJuQYGDPlQckDaS4HSihZY8DetBP4e+J6YkE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+5acemdJXnFFl8ilb9sXdE+dA0tP5plQW7rKFfctKV6qT9RWl
	aILPu5GI86UeoIQPnZXJQ9wVL+X5UPfxq1i8wUrDOhh4R64kTBQBIg+r
X-Gm-Gg: AZFdTZeQdZlCEjcaUFogCHrevVj/Rr+8td3VF+CCCGK2tSMbV+sVfIrNbwdkPKOQD0K
	sjAKPoYrZ50sJ7+KJF3gAy35dRzpt7aGAhQGLWCqJ/bcQIfigL47TXebihj4n4St+qU4OcLncgY
	FRuuzqS2P3oTtuZeXv3sK4Rp5oe2yq4jaE3FEZcH6L2HNApoycscYmAAohDI0kiOhFt+XpsAFQT
	8oVb6ga9PXFjq4RK6UwofOPJbPLf9KLJMlX7szho+4SaDMRw6V0UsbpG/OqxOLDPKIsFF9efwcS
	ki6/vrIKJroxiaYXaZISC1y2gWfidn61LGRahXNHDlqmK3n2G5kEFMMMfJsn0/yVCjI2KdzCK/o
	ImWeOuPH3aHnJ52QNyfl2qlu18OJWEet2a6ApbL/UZ7nMRcglScczswvGe3OQTWgjgtaI4l4wfE
	PB71A8Px2+UlGP/5u07qJj6w+rYlduA2xSUbvWW9Hz7bSMR0G8UM7w3GYliax3T3bF8fCzejmai
	qnUOfDHB3tbAQFXK2EXTHupkCaKJf4HUsCofpJz4amC9RC4h3RQjRuc2Xo2KNIvY2dH5inJGs0F
	etyzHDVFR/9hoGmSbvcGXuz1XEYVew2QugsqtMkFEPn1pSM=
X-Received: by 2002:a05:600c:3b84:b0:4bb:6f45:2a6d with SMTP id 5b1f17b1804b1-4bb888074bbmr515405005e9.12.1795702664026;
        Thu, 26 Nov 2026 06:17:44 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm596496575e9.5.2026.11.26.06.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:17:43 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 1/7] selftests/bpf: Test the tag of vmlinux with do_epoll_create()
Date: Thu, 26 Nov 2026 14:29:07 +0000
Message-ID: <20261126142915.1106330-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
References: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tag_of_vmlinux attaches to the bpf_dummy_reg() of bpf_testmod. It
shares the FUNC of vmlinux with a bpf_dummy_reg() which has a tag,
and the verifier must not take that tag. But the one of vmlinux takes
a struct bpf_link, and the build is going to stop tagging such
functions. The test would then pass without testing anything.

Use do_epoll_create() instead, and load a program on the one of
vmlinux: if it loses its tag, that test fails. It needs CONFIG_EPOLL,
add it to the config of the selftests. (It is on by default, but make
it explicit.)

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/config              |  1 +
 .../selftests/bpf/progs/fmodret_retval.c        | 17 ++++++++++++-----
 .../bpf/test_kmods/bpf_testmod_retval.c         |  6 ++++++
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 30b744844ef5..ce0db4be4d26 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -30,6 +30,7 @@ CONFIG_DMABUF_HEAPS=y
 CONFIG_DMABUF_HEAPS_SYSTEM=y
 CONFIG_DUMMY=y
 CONFIG_DYNAMIC_FTRACE=y
+CONFIG_EPOLL=y
 CONFIG_FPROBE=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_FUNCTION_ERROR_INJECTION=y
diff --git a/tools/testing/selftests/bpf/progs/fmodret_retval.c b/tools/testing/selftests/bpf/progs/fmodret_retval.c
index 112f1575ce1f..ae2332bff2f0 100644
--- a/tools/testing/selftests/bpf/progs/fmodret_retval.c
+++ b/tools/testing/selftests/bpf/progs/fmodret_retval.c
@@ -176,13 +176,20 @@ int BPF_PROG(not_a_target, int value, int ret)
 	return 0;
 }
 
+SEC("fmod_ret/do_epoll_create")
+__success
+int BPF_PROG(tag_in_vmlinux, int flags, int ret)
+{
+	return 0;
+}
+
 /*
- * vmlinux has a bpf_dummy_reg() of the same type, so the two share the FUNC of
- * vmlinux. That one returns an error and has a tag. This one returns only 0.
+ * The do_epoll_create() of bpf_testmod has the type of the one of vmlinux, so
+ * the two share the FUNC of vmlinux. This one returns only 0.
  */
-SEC("fmod_ret/bpf_testmod:bpf_dummy_reg")
-__failure __msg("bpf_dummy_reg() is not modifiable")
-int BPF_PROG(tag_of_vmlinux, void *kdata, struct bpf_link *link, int ret)
+SEC("fmod_ret/bpf_testmod:do_epoll_create")
+__failure __msg("do_epoll_create() is not modifiable")
+int BPF_PROG(tag_of_vmlinux, int flags, int ret)
 {
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
index 85722e48d34c..ba48f0f393f3 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_retval.c
@@ -159,3 +159,9 @@ static __used noinline __init int bpf_testmod_retval_init(int value)
 {
 	return value ? -EINVAL : -ENOMEM;
 }
+
+/* vmlinux has a do_epoll_create() of this type, which returns errors */
+static __used noinline int do_epoll_create(int flags)
+{
+	return 0;
+}
-- 
2.43.0

