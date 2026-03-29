Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150D436C5BD
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774819545; cv=none; b=MbF51C/QXhxQWRmGA2Mzyqy56DKNIObyKSNtY0hCBeK83OIAF0rA0dslQlMeWRfzEXtpLes8pB9dvav62NeI4t9+y7diHnVfigvud0s1xSNneRo7GXlm2AX7t0fa1PNfSnotIpI1YdzRgeJvA0oT9N3Izj0Xhb9LBY6jDt7qUME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774819545; c=relaxed/simple;
	bh=bKI5bNxQUtO0/6qHxB1Ww2UE3+hExnBymx891Yvnhw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGn01+swoNtacEZeorbdvWZzbYg2HGX06br/UQNpCAdFnnHQg16HaNwgvotzfKkEaRocsmnUZLqkIYBQk6nkpsHkBy2yGDKSySO3Ke2o6ZonHZMdUlxa1FnqRmVdVYip43/Dad07jcIhjh5ejLXdXzYvdW2seFZtiOLB98kBzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7Vm37aW; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7Vm37aW"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7d7eb85fb81so3868325a34.0
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 14:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774819542; x=1775424342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4yFVfd5J6VlKZjRGlD0SwubSo3BQLfXRkpgZzsxPx4=;
        b=S7Vm37aWJSkszpqTO9pONmduZDQwvEJ1MzHMQJpPLYTeFbICnBoEoMjC5EBBOA/T5V
         0u6g1wNJ7OAQsBQRHx5Qxb1WZwraxoC8l2E6JCRj3QfV2DUln9DQP3AjKPesEluHTC4G
         0U9xvLBG8AeRJbBTEWm+C5S1YKufqbnTVSODTTs7JZdzEw9bjwoLIVcu+Px5uFFaG+ZP
         7eXM5q8migXbM4im3xT1ZelSw1+qsw7Y5eIUeQgoOhhiXTlRo2kk7kPJVkWa19zQqHzM
         61WoE5w1CE9SubX+1M4Z2t/v3dd2bjKx2EF4vLlfrQW9fsJkS4tykHwyjaBElHapnJSn
         4gUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774819542; x=1775424342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C4yFVfd5J6VlKZjRGlD0SwubSo3BQLfXRkpgZzsxPx4=;
        b=WHErVg6BF/BwjW7DsUMX/m6M5mrHVtXR67YJwEVzQA9VHg6bJXWxnLCGiGADqyNa3k
         kUQ95ULSh4zl3vaqljycHMWXGEK5Ra1Fa10GDumjqgjaQlIl6MVyrNzz4M0sVNYZuoSo
         hg647CPvVRd5QthTH8h6Yj3eMARB+lttBnyoH5fcpTCMSCn5uLJL5jftopn6IzENe2Zh
         LY9tsUEGnrNzwYz7Go7c4x+U+a6F5aVMOtBNdx/u5f9MnhSPHGPVRGpRHyN6IaiVAaos
         PzMkIQ7Pm+hdMr0hCtB1Ni9OtavMeISLkVTgIh0e3Fkz1r7f2EdT9dZQ0bJhlTdzciDu
         pIcg==
X-Gm-Message-State: AOJu0Yz45v1KX1w6CbdbZmfsI6J04HZ6BKl2uboJ4Ul9hix+noNoPnEl
	yO8DuPqNdoIiOc3bjb2td0sY2Y6SF51QiAZnvR9MNQ+QUh2LCq1YIxAGRJ6CINV1FE4=
X-Gm-Gg: ATEYQzxGtHi//ge97dyRzh1ioA99tS04K5nsQozRCSRz4OxO4/fcrlAQH+xiW83kH/Z
	+zFW+a6f/GIxXwuwEHvakmh9ZABs/mU9ANKzIKvKrNAi6MoW2npSjlPXK/w8HZDVQqRCyCS/yNE
	yz+r8fP7okDKdohhefVn63in7kL/fQDS039Xo05qXHSEbbC5U8/8MvlKIMEwtAx5zUIAvLC4VLF
	aZnxzyXOumdnXomBVHyl9gpxduKtcWvhcvkDtC7oYNhyeAp4t8G25iWqxfIR9lfxUItiw2ZwSr9
	RfbkPFFzjHmXyEt+qBByL0bNe+ilLIQWzwtwu3UVffp3TjvDcKaWx5Guq2qDugoMdPDJxZfF3QU
	5BdTOtUnvOGPhhz62ixdwMwBQN1kSExm/kYh3dTYGp7YyFDTyD9rNpw0ikWTZ+tUz5cZ7m4Eila
	atb8Iu6UHJ299y2M0uBpZFVlmXpLD1Yp+IUPGjN6kTDvR+YXFy5VwJHg==
X-Received: by 2002:a05:6820:222a:b0:67c:2752:8dd5 with SMTP id 006d021491bc7-67e185eb834mr4839579eaf.9.1774819542564;
        Sun, 29 Mar 2026 14:25:42 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d0496591csm3464959fac.8.2026.03.29.14.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:25:41 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/3] libbpf: Wire up verifier warning display logic
Date: Sun, 29 Mar 2026 23:25:33 +0200
Message-ID: <20260329212534.3270005-4-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260329212534.3270005-1-memxor@gmail.com>
References: <20260329212534.3270005-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; h=from:subject; bh=bKI5bNxQUtO0/6qHxB1Ww2UE3+hExnBymx891Yvnhw4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPkdFXmg8uE3ofILD6T/XjhMmOf0Ok+iUG1Um9NtieIrVyq brG0o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPhLGZk6E384Lza6IXg4iNz3I6usy xliVnMIOuS+7sldHvjqcagRQy/2RxEr3MYnn93csFsW3t2phN6uy79d968pP/onmMvf72x4AUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Wire up the flushing of all accumulated messages in a program's stderr
stream after verification is complete. An example is shown below of a
warning printed now about usage of deprecated kfuncs.

$ ./test_progs -t kfunc_implicit_args/test_kfunc_implicit_arg_legacy_impl -v
...
libbpf: prog 'test_kfunc_implicit_arg_legacy_impl': VERIFIER WARNINGS:
WARNING: kfunc_implicit_args.c:40 calls deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl(), which will be removed.
WARNING: Switch to kfunc bpf_kfunc_implicit_arg_legacy() instead.
WARNING: For older kernels, choose the kfunc using bpf_ksym_exists(bpf_kfunc_implicit_arg_legacy).
...

Note that test_progs overrides the default logging function, hence -v is
necessary. By default these messages would be printed for the user.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9ea41f40dc82..f308bacd083f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7826,6 +7826,27 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 
 static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_sz);
 
+static void bpf_object_load_prog_emit_stderr(struct bpf_program *prog, int prog_fd)
+{
+	char chunk[256];
+	bool emitted = false;
+	int ret;
+
+	while ((ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, chunk,
+					   sizeof(chunk), NULL)) > 0) {
+		if (!emitted) {
+			pr_warn("prog '%s': VERIFIER WARNINGS:\n", prog->name);
+			emitted = true;
+		}
+		libbpf_print(LIBBPF_WARN, "%.*s", ret, chunk);
+	}
+
+	if (ret < 0) {
+		pr_debug("prog '%s': failed to read BPF stderr stream: %s\n",
+			 prog->name, errstr(ret));
+	}
+}
+
 static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog,
 				struct bpf_insn *insns, int insns_cnt,
 				const char *license, __u32 kern_version, int *prog_fd)
@@ -7950,6 +7971,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 				 prog->name, log_buf);
 		}
 
+		bpf_object_load_prog_emit_stderr(prog, ret);
+
 		if (obj->has_rodata && kernel_supports(obj, FEAT_PROG_BIND_MAP)) {
 			struct bpf_map *map;
 			int i;
-- 
2.52.0

