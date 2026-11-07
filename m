Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071025;
	b=2nJfbgCQzStQzEHnfYrfqwLVgfoTEaXMRzdCnItRjdaDt3TwT17WXTBe6Xis6fzpE48s
	 w8sFer6hMhB3Q4TIgZgoE8K9otZ9Ib5DfVeIhvc+yfS2BQd3aGOSUffrbGKLcVD91CS4f
	 C0ZNddNCFS9hSqeHzmcSZpdyMzxYTmdyrcGjXMKsksPQGCCFwpG5HiYrCsopFhnRx+2SV
	 226+H5BAHlWjXxzj2/7YID3a7E3CnuAIHhNySE/eKjzr97rGRXbNtHI99+cRadTjQRVSI
	 8ThmIISE3RhCULLvhVSrLxVQ/SCCeNyhYHLw6Plt11aOhGXBhu78neNtBn5AYqj4sMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ktsPQBErMfZdOvhkTqNaOVoFzAUNXkcUP43BGaLyjvk=;
	b=BM6wMdh6yIozgyPF1Uz7XaFthfI7TQTFn7pOiae/TEXMBuClaR39mf7FlLaNqSW43OZS
	 MjwLSeq3EPHz/QUNMgpOJfZxl0lwLvb7Id98ONCMm9zliykVAAFZ+MBxps3q/K8BdyReb
	 9PgMkyXdbxKmxndiV7lMGY05zPx41TpHLY5cGUAX8m2iIs6PwOGkTO/Bdlz5hWFasMrnY
	 u4qUOyH+JHVmhqY3cv7KdGQj9FNU+6tKaeNODqbirIC5KHhiDIexCVPT0o8OIjnLvKyJr
	 BxYhzPIi9Lgv7z7QgepCyii8mP8iqa79VurEkdFm3yFoNaoaAt0OWO0JrdnJPPMpzpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OGe6H3Jd;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB83F606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 17:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB83F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OGe6H3Jd
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so177368a91.0
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 09:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071024; x=1794675824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ktsPQBErMfZdOvhkTqNaOVoFzAUNXkcUP43BGaLyjvk=;
        b=OGe6H3JdrqQLL2fbTIifLovyrgV2FII2+ytiN1hv60qG2AqBLoUbSjDRmhvlaFroij
         NEJV1vMxu0IJSBRzsSpaYgJoBnAamZj2na+39QvMinIup3uvEHuS1vEcOBPqVIkh+dSV
         L/xWSSK+R+UIHAQaPnlcELw/5YsprnJdLML/dy1K8ZjwnTUlpG991jfIkfV1U0YTqJKR
         A/P9kT7FVeLCv6o1oew5KvfmjoE6zdDiEMaP9ssnLiKGNE0RJvKcCz90QVH+OMAWBs4s
         tEA9c260qGX25ZeK6a1Q7rldrfZ6W+qo6Y+o7OPRiVmv1XKrPSXACJPbtbUQRTnS/oPO
         r4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071024; x=1794675824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ktsPQBErMfZdOvhkTqNaOVoFzAUNXkcUP43BGaLyjvk=;
        b=W6BuzxtGtyT/F/KxPn1O5bdq93E0CZL6vYLW901mZgfvf+bzsgoJC3YL677ivCV7xb
         2pQVD/FMJQDsg7pCgBcpJyGt6ogMRoA+W63zqRLNbBOd/0lqovcEhr3nCyoXVPJESQ33
         CfwVgfE7N2OyGPIir35OrG2+FfhaceA0EjETHlTNH4QwccN5IqhhYPfR9LM+ckEUmLOU
         R0/zgo/udmUjfQHQ+Wl5feD9MBAPDH8t5WrMVlbh91Vo810nZ+6F8NMPJNFeJLf+xrCL
         gvdjDkLQh9mknleSidaUlvHsgqVPWOyy1EPlLI6YzxdpnFxb+fiOw3U+6PxyFBKZhpnV
         tfhw==
X-Gm-Message-State: APuU4Z+ljrUzyC4CRwbc0SJZFke8vFh/x/Hn9LnF35r5dLglbo4kNx2y
	d8yL0PM8zLjhlebuIiBoroGphq2vbOPuFnUVSS7IQh2l9Ysdj3jhmkTdr/eyUw==
X-Gm-Gg: AYBFou3ZCme6AOKA28ZNI9uJwFlW5NFjKEdTYDkvjFu2M3Gf2Sg3LkzJp7rh+RlaBrC
	ivHjAj0jOddj1DYHq2wn5pp2xp19Is2kjVBoZNgF/DikhtlKkpspW/I9JtvnMpVxOFq6AQYqaSk
	mqQ8qD9OBAgpXxnr5iDbCPWExZPCb7enbUcJ0be0Rf0Rn0aVptAjYdCmNna6TpK5yObKHgBJTNg
	Uv/wCTIMv9smmwwNi/xs7jsz85jWD/KQRWpzykWMKWg/2TDQX5MuFEnYcDdXBLJMJu3yJ9bojsP
	tZUVdNPhAzWsLuSe/ENSQA4Tx2tBW2xTW3NdfxVqXxrN0Qiecl4YtiI+ewDPZZJS3+lf0jgoKj+
	XBjITIhMJbeYvAn/3HAxRx8X6IKGgspYAC3J7rbJWHcNwJrCXBcpvp/n/r1I59MM16nEheTWScj
	ogsyRjyEg0VSyzv94TmJ0b5M3flOGp1GmCKLhGtZZML4thcuQ0CV747kVw2qgoi+jA3ufF4wypi
	YL2pQcOyiUrNCjzhakO6Tu4jkqWArP6QKz4on3ZKxvIBZqiqTJS06wOJa//yvdqaA3n3fIXXUfu
	luSOE1YCrTszAquNQ6s7dmnCEWM9CeOZVf/vQI0XdjBYDTpMKHp5PvTXnp3Wjl8ezv/9tv0SEki
	4vFCckpKUaexKRA/l2l6YarF94w2C9vtV/m5KQpN+BH4kLIljYZgVy3fXJmfSBk5Eh0r3vqeN+g
	==
X-Received: by 2002:a17:90a:d446:b0:3b0:9cc6:62ba with SMTP id 98e67ed59e1d1-3b0db70adc6mr5381985a91.38.1794071024055;
        Sat, 07 Nov 2026 09:03:44 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057b17f8sm3891545a91.1.2026.11.07.09.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:03:43 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 4/9] selftests/bpf: Skip plain_c_test_wakeup_source without the kfuncs
Date: Sat,  7 Nov 2026 17:03:01 +0000
Message-ID: <20261107170306.2831028-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
References: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

The s390x jobs of BPF CI fail in:

  plain_c_test_wakeup_source/iterate_wakeupsources

The prog calls bpf_wakeup_sources_get_head(), _read_lock() and
_read_unlock(). They are in drivers/base/power/wakeup.c, which is built
with CONFIG_PM_SLEEP. s390 has no suspend and no hibernation, so its kernel
does not have the kfuncs and the load fails:

  libbpf: extern (func ksym) 'bpf_wakeup_sources_get_head': not found in kernel or module BTFs

prog_tests/wakeup_source.c skips when bpf_wakeup_sources_get_head() is not
in the BTF of vmlinux. Do the same for the plain C form of its prog.

Fixes: b5ae07f77d27 ("selftests/bpf: Test progs without bpf_for(), zero, can_loop and such")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/plain_c.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/plain_c.c b/tools/testing/selftests/bpf/prog_tests/plain_c.c
index b7305118a454..bfadbbfd436a 100644
--- a/tools/testing/selftests/bpf/prog_tests/plain_c.c
+++ b/tools/testing/selftests/bpf/prog_tests/plain_c.c
@@ -152,7 +152,17 @@ void test_plain_c_tailcall_bpf2bpf_hierarchy1(void) { RUN(tailcall_bpf2bpf_hiera
 void test_plain_c_tailcall_bpf2bpf_hierarchy2(void) { RUN(tailcall_bpf2bpf_hierarchy2); }
 void test_plain_c_tailcall_bpf2bpf_hierarchy3(void) { RUN(tailcall_bpf2bpf_hierarchy3); }
 void test_plain_c_tailcall_callback(void) { RUN(tailcall_callback); }
-void test_plain_c_test_wakeup_source(void) { RUN(test_wakeup_source); }
+
+void test_plain_c_test_wakeup_source(void)
+{
+	/* prog_tests/wakeup_source.c: the kfuncs are there with CONFIG_PM_SLEEP */
+	if (libbpf_find_vmlinux_btf_id("bpf_wakeup_sources_get_head", BPF_TRACE_FENTRY) <= 0) {
+		test__skip();
+		return;
+	}
+	RUN(test_wakeup_source);
+}
+
 void test_plain_c_tracing_stack_arg_tailcall_tgt(void) { RUN(tracing_stack_arg_tailcall_tgt); }
 void test_plain_c_verifier_arena_large(void) { RUN(verifier_arena_large); }
 void test_plain_c_verifier_iterating_callbacks(void) { RUN(verifier_iterating_callbacks); }
