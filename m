Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577548;
	b=hFeKwBOkvNHDsao75E8L7iiwd7eNlwK0rv4TdXKtzHmcKx7oIsmYk6gdqKGvySGGffqZ
	 rDgt4umi1GIUvohpWyOPvh2QpSRlfYZS7S4Bj8BnNKYVfHywJkd9G1NGqKMM4COFBlk60
	 X0hdadlV1+/Mp9Wqi+feSPhbASlNmBqSgQjCzwW2YOtKs7TlQioh0QDWNWMmZDqIDWcEB
	 Wf0f3lMy6ere/PyF8TbW3bIzAyCd7MPQnsfMw3X84GfkwtSn2OUqcjNrTMNmhdFuIDpIw
	 BCqXX5lFFvuehDxPKTNsYK7kaD/dguh8c+7v6xsDYb3hlLQBil8nFenFef0hJw47y7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tRHki3w2Kqh2hcFR0F/e1uXDOFUXH5wXN+txi6+NaHc=;
	b=UY5h+30OuXUfrh+HxLSfzfCGWkkczg7Zs5kw7XShcoChC8rSLTwh9GXTu8A6ZxjaTTFV
	 67OgY9AWBiQ3LJkOe2OSvogZv0gymgfRIl09Llrznf5XaHvbdihdG+L/ELTdC4gwRNMiP
	 syNJnzajwzI6SB1HG6X9839vdoEf2kx57yYiXQ0D79c1yAohp6HngkIo84A0UHkxUeAAP
	 gfrLannxSWqhyVXl2/zBk21TmH5k6S2NpDnmmwSbVGWxphZXfGT01EG2HpTi8Bsmg6Xng
	 OnjdurJtF7WuYnZMz6tNUlO9KWWIPI66zKY/8yvKGaHoxjVlmlNwzJONTwtdscJ39pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dMdycwA5;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF902606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF902606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dMdycwA5
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cde84cb8803so1259040a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577547; x=1796182347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tRHki3w2Kqh2hcFR0F/e1uXDOFUXH5wXN+txi6+NaHc=;
        b=dMdycwA5jhuAX87bJ8owcJ3azjqyHnpatpOlRL49ZlMmTbH6XtiyxuYeub+tY7F9RY
         OsiDSg4LmjgqjiDApwRHP9X+zVaukkLqTugBzCJN6lulICXD7loYFCWEslGaiR070pVW
         N1GvLXwUeXKXqCQyNen69WGiK1kaCgPeDP+LCfsXQ1iCNwg8Lsua2YbiVRll4FYRbr7q
         pt43kg3+EEbD7WciI+JB/YwM8k6JigjM5B+6CRn8lfsTI2oyC6ADhC32uvri0PUl7zuz
         ebkPnjT6nqL4EeT5zBfJZEYxqE2zsDKAlwbaMDFeboPpSx2/eFweOUx1m3bTqJOEUDNf
         2QwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577547; x=1796182347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tRHki3w2Kqh2hcFR0F/e1uXDOFUXH5wXN+txi6+NaHc=;
        b=zRuPxlowdExWI14ygQ7OZaaroYZ1PXXIgUWvPO2DOWUvAj4ZijAA9NPTwgChJsmgdi
         v+ezqj+495AE0NNZZujDfrmxY62UkpuwYRYGCLY80AZE9totgqasOphYseQ7vRPGX7oo
         JXmRIzFEBprgeS8u+0ewBxZ5XyFC4zj0zAxbv6Ze/8PtFnzLIqDlSAL1qOPmnBuv2J+A
         qsJDTVZdQm/sMEW1UzZQiSzuxrkY73/PKfZN8mp0lu9s5G4GaRQqE6o7O7t+HGNjW9jm
         Gz7T2gKB8YRVPIjnqPMa63YEUpINbXrn2/Bxv3ULpUXc9WC76A+Z9c1vw008xjvdPmAT
         qasw==
X-Gm-Message-State: APuU4Z95VPqhoUjYE5cCP+iKCndIKmusU9/R5ZYbS3IoYyD1XhEv4riL
	OzygPet8V7ROpLAJe9iY8IDBVZTGckKZ9BNQHQlgW7lNt+452PvtR+Y5rZizsBwN
X-Gm-Gg: AZFdTZeCBLtIALD5h8WFfmek7Hxc9uzw1W4P0KzRY3TqJpg6B695I0mG6qp52X/ouGG
	rldvEpdUEdZRYKEHE2jdgJN1al4fwY5aFIQLZj8hIkoSsZa5EWM3gvnFPe7C8SSacvHdUA24hAy
	JRi/vldbg3qIRe+zqH4X9u4pNOnKmL8X+VcQDLjnjxmI58+3MQcLMFK++/X1KyXfSzkGqWOqpUt
	PkpfkCFzDV9wt29Kz8reBq7hwaDAjmznYlrWCRlDoOEHUA7V0Xwv6sKYjkUfyBoqz88almwRH8B
	MQWVRlI0kjzleG1x++wCeA4XF8k/eiv70ZPocNd3UOQiWRRhV5C6Rh6u+xzuU2mFIMlnERduXMQ
	gZ4H0qG3msnLiWqNIs6YmKq+gyRX2RiuzdnY0xAhqE1TS8dhGU/K3AMnvFNiCwQSF1yeYpYvb+Q
	LpS9cwFnjmD05ojXEx9kkFBQPoYAhHjqpZ5CSGarXVzW0G7JjA2gy6fZUtzOFXZMq/ulnlgXyG/
	6K2Z9kPJmwwSk0ftemg10dJWgOQdXJ0pNO+r3sFQbG0FmQN8YE0jElcssKdqbze6XRMwC+4EfaN
	+vId+wNPY67IxRmz0UbhbjZ3TVO93mzJMklqBMfv6o18gGPcwf2mNKjM3nJjUMBgT2Ghi1NaU/W
	NY4qRJMyHwAsPMcO8vNWzy+V8zpTn+gGPvaxu5QYp+EB/7X90C9ZVO/8X6xEhAysnyc7oZILfBw
	==
X-Received: by 2002:a17:90b:5109:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3b41c953f98mr16768021a91.49.1795577546934;
        Tue, 24 Nov 2026 19:32:26 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4afeaaa84sm9735585a91.10.2026.11.24.19.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:32:26 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 28/47] bpf: Limit reads of variables of the kernel
Date: Wed, 25 Nov 2026 03:29:19 +0000
Message-ID: <20261125032938.670542-29-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

ld_imm64 of a variable that is not a struct gives readable memory, so do
bpf_per_cpu_ptr() and bpf_this_cpu_ptr(). Many variables hold addresses,
and CAP_BPF is enough to read them. The size comes from BTF, and that
can be BTF of the program. Loads from such memory are not probed.

Ask for CAP_PERFMON, as for the access to a struct. Addresses of
functions and of per-cpu variables can be loaded as before. Take BTF of
the kernel and of modules only, libbpf passes no other.

Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
Fixes: 541c3bad8dc5 ("bpf: Support BPF ksym variables in kernel modules")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/helpers.c  |  8 ++++----
 kernel/bpf/verifier.c | 11 +++++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 61ddc45b0330..b570b7314ab4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2185,10 +2185,6 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_spin_unlock_proto;
 	case BPF_FUNC_jiffies64:
 		return &bpf_jiffies64_proto;
-	case BPF_FUNC_per_cpu_ptr:
-		return &bpf_per_cpu_ptr_proto;
-	case BPF_FUNC_this_cpu_ptr:
-		return &bpf_this_cpu_ptr_proto;
 	case BPF_FUNC_timer_init:
 		return &bpf_timer_init_proto;
 	case BPF_FUNC_timer_set_callback:
@@ -2292,6 +2288,10 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_branch_snapshot_proto;
 	case BPF_FUNC_find_vma:
 		return &bpf_find_vma_proto;
+	case BPF_FUNC_per_cpu_ptr:
+		return &bpf_per_cpu_ptr_proto;
+	case BPF_FUNC_this_cpu_ptr:
+		return &bpf_this_cpu_ptr_proto;
 	default:
 		return NULL;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 410804e80392..3cfc64e2f9e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20989,6 +20989,12 @@ static int __check_pseudo_btf_id(struct bpf_verifier_env *env,
 		}
 	}
 
+	if (!percpu && !env->allow_ptr_leaks) {
+		verbose(env, "access to '%s' is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
+			sym_name);
+		return -EPERM;
+	}
+
 	type = t->type;
 	t = btf_type_skip_modifiers(btf, type, NULL);
 	if (percpu) {
@@ -21034,6 +21040,11 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			verbose(env, "invalid module BTF object FD specified.\n");
 			return -EINVAL;
 		}
+		if (!btf_is_kernel(btf)) {
+			verbose(env, "BTF fd for ksym is not a kernel BTF\n");
+			btf_put(btf);
+			return -EINVAL;
+		}
 	} else {
 		if (!btf_vmlinux) {
 			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=y is specified in Kconfig.\n");
-- 
2.55.0

