Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641447;
	b=lA34+ZNVfGN+IPrK59SK9iaQB1Q9z4kR9L9Y/oDhDC/vh7zo/SWw2ZCGJc8XjmoP99yA
	 L2cMn7sukZfFLlX6dSiQQwjVukNsngyuU1GKzJZlVimZNRj6SlQ6c8CVEPpyjzM87QZm2
	 M+SwDO2PZd0CCmxH48GNlbxUIaW9sjPdag2HW9pf9JJASD9OGfDNb36ZODGM9mxVd9fIj
	 VS+MT5Vq5aWGFLUpMEiOR7bcmfOCvR8T6KSAwE702IG+EYIPqv5VM4U1cIanlqwLZhUaE
	 cfwFNB6prYGg3VKdghOP3SOIO36LA1bFLfQwchYxnFIZmD6z8dFO4ehWnEpZHEN4uNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5rxxH7+cQ5HkS7MFH2Qr+YBYSCyX6MWrvnTbu9hTqUE=;
	b=HJlZaXMh/YL5TV7Wg+cZpy6yqtpOccWWsiWV79/DAiUfy5qefIUQhrXeVeTSa+BvM7uQ
	 RCML5sVoAitXJ6ZjUJFbNQ9zZEqAPSN5u+QKOsvUWgjfRJa0ac/lHCi6xnhJ6JZGbvN1n
	 vHYsqdxF/qQ9lBNViNVNIVMs0ZZaVLwlBk9EKnKWaR/uVj114qVprBZk5soxx5jSfaLb8
	 OWZPksVcGS32fNUWrDKE5cjPAy3MVIEzpFvUgoKeFglQzxsCH1O2BPSLioj6SnCe00pi8
	 ZoUtubS4yBpcEQzJ+fksy7H71M2Q91LtulnOX8FqRoV8jTA0DkWk6BcVX4qCJ0KzDsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="MGzIJ/Eb";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD5606B1E8
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBFD5606B1E8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MGzIJ/Eb
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so25383885e9.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793641445; x=1794246245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5rxxH7+cQ5HkS7MFH2Qr+YBYSCyX6MWrvnTbu9hTqUE=;
        b=MGzIJ/EbOe+kRpHMDpywg4y7B2rWkRIpe8S1IhQj2/0WHiS6lgmunAxnZFXXk7pSVk
         lJhbfYHlHUzjSWJ9Fx7oSuZ5LzgU/oecIL5G9Q91d7Z95DeN1bT/lp81f6/ylGxx5/UE
         Y/Tz20FP7lM7mYu7C26jBGEkrCjqpt4nWg5vfLIB0qlRhvja3DIL6pu0k+QXmDBTMKyV
         HF6lDwED6dkSdjMvaumTRH0471R0GFpxlv+VAxqDRIcIp4lFS+eSZ1ovchw4E1A9UK9T
         Yve1pIoF4S5QpS4IFqYtarRumP/pFVINLRWWLSwxIFpMvATdb7tOzWWq1io2XE6Vf/YC
         UiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793641445; x=1794246245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5rxxH7+cQ5HkS7MFH2Qr+YBYSCyX6MWrvnTbu9hTqUE=;
        b=lr5UgShPR8UJb2gNVrM5D2GeBYhHCAjFz9Psi1xbpBAEiApwi0JeMo94zNWvvMNi7T
         K/oUcsRlw6t2iUjORPM8tFUba3n1xeCB+qppPpihM4aJUkEBLUmjf+tb60g/TBlTcxqm
         xOWE3VpdiQbBsJ8xDExj0Q5Psugl3D0Xfzx81lYWJmSpY4e0jl+nQnbLrr1Sgvje5xsZ
         KpWzYh49bIjTvJj7GcrqTxFuN8MASD/3T4vBpxCYBn05jC7YUWsXXnAPE24vX+Yis6yP
         VJHrUaxOoOUf7+bB1NWbKkywPWHyJvxCLrZ2353oCiFn5fnUxUvdGoQzYIDTQoFedNKq
         G7Pg==
X-Gm-Message-State: AFq9FYIRgAel4as9R65W1W4NmczYwDV06IbwAsXHIT/6Ncyoti0It0+V
	uvHYPAyHHl1HY43xh1uFdqJVNpPeB2SAiUe6UTs/YLZfXRFe23SOxliY3BzmC8mR848=
X-Gm-Gg: AYBFou11U9fkQrcW0ymxrRdi6ZHhkprWyiFu1aEaHsSeNOhLjaS1cdjQZLJd2ijJ0PI
	Itzoozg82xXeICJzSljGK2N3bp7SKFEIqfDUK1t00V8Guwpvx7re1fDLR3TvS47bQxUK3yAXSVl
	VOqLbFdXOZ6PWZmwomN35yXEHYZR0+MsCpDM9m2kZ62xTHEkmscDam5iG7tDYRiO3weOVqpY4gu
	4YyDsF0J28vThzcUjF9Z8qqgbyqEPt4HhAmh2HJGucCjdKucRl26Xr7nNj7PeMuiZd6KlihmXJ7
	k3EitpxsNI9T5VKy8JOPBaPlyN+acXrISy1MO1U8mioWdbvc94tsgbQSBfvI5J6s3vZhDzi7mjk
	PCAqTlQiY2TIR/hsfVoUqOgjJSQkZloHDBUTs/ekXp3GfgMrv1FPAYbDqxFonGhIBn9BUPyqWht
	AT6gPz7y4BOcBL6FG7E1bjwnPYHKd4zSQ1EJGyDq/kl0XDBKFpEh8ngQRUIZLc9Gxh7qFCsV8dY
	/QGuooTYkxP9JiBBONJh/grkj+Z5cyfZwrS5qfvog3kH+ehcUq+kjxAxUsXBuKkmIdX2dpeuWlm
	vJPhnc2MZ68eoVovelnycMNDGRyFuiMeM3mMTI8yN8JCuesTwhA++/9WQLORlzg8z9c8P+vUz0Y
	FYw==
X-Received: by 2002:a05:600c:c48e:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4ac16bc47f8mr249490135e9.11.1793641445310;
        Mon, 02 Nov 2026 09:44:05 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4abea533a1esm196311865e9.1.2026.11.02.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:44:04 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Tianyi Chen <hi@tychen.cc>,
	Gyutae Bae <gyutae.bae@navercorp.com>,
	Hui Su <sh_def@163.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/5] libbpf: Track generated loader link FDs
Date: Mon,  2 Nov 2026 17:43:47 +0000
Message-ID: <20261102174350.472592-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102174350.472592-1-mahe.tardy@gmail.com>
References: <20261102174350.472592-1-mahe.tardy@gmail.com>
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

Introduce gen_attach field to emit program attachment instructions in
generated SYSCALL loaders.

Generate failure cleanup that closes any created links before releasing
programs and maps reusing emit_sys_close_blob(). Store the link fds in
the data buffer similarly to map fds.

Append bpf_link_desc outputs after the program descriptors and copy the
link FDs to the loader context on success.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 tools/lib/bpf/bpf_gen_internal.h |  2 ++
 tools/lib/bpf/gen_loader.c       | 17 ++++++++++++++++-
 tools/lib/bpf/libbpf.h           |  3 ++-
 tools/lib/bpf/skel_internal.h    |  4 ++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 206adf28793d..b601269abe45 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -39,6 +39,8 @@ struct bpf_gen {
 	ssize_t cleanup_label;
 	__u32 nr_progs;
 	__u32 nr_maps;
+	int link_fds;
+	__u32 nr_link_slots;
 	int log_level;
 	int error;
 	struct ksym_relo_desc *relos;
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 80a6b5306183..17690cbd299b 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -127,6 +127,10 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 		gen->error = -E2BIG;
 		return;
 	}
+	if (OPTS_GET(gen->opts, gen_attach, false)) {
+		gen->link_fds = add_data(gen, NULL, nr_progs * sizeof(int));
+		gen->nr_link_slots = nr_progs;
+	}
 	if (nr_maps + max_func_ptr_maps > MAX_USED_MAPS) {
 		pr_warn("Total maps exceeds %d\n", MAX_USED_MAPS);
 		gen->error = -E2BIG;
@@ -153,10 +157,14 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 			      /* 6 insns for emit_sys_close_blob,
 			       * 6 insns for debug_regs in emit_sys_close_blob
 			       */
-			      nr_maps * (6 + (gen->log_level ? 6 : 0))));
+			      (nr_maps + gen->nr_link_slots) *
+			      (6 + (gen->log_level ? 6 : 0))));

 	/* remember the label where all error branches will jump to */
 	gen->cleanup_label = gen->insn_cur - gen->insn_start;
+	/* Detach any programs activated before a later operation failed. */
+	for (i = 0; i < gen->nr_link_slots; i++)
+		emit_sys_close_blob(gen, gen->link_fds + i * sizeof(int));
 	/* emit cleanup code: close all temp FDs */
 	for (i = 0; i < nr_progs_sz; i += 4) {
 		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -stack_sz + i));
@@ -416,6 +424,13 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 			      sizeof(struct bpf_map_desc) * i +
 			      offsetof(struct bpf_map_desc, map_fd), 4,
 			      blob_fd_array_off(gen, i));
+	for (i = 0; i < gen->nr_link_slots; i++)
+		move_blob2ctx(gen,
+			      sizeof(struct bpf_loader_ctx) +
+			      sizeof(struct bpf_map_desc) * gen->nr_maps +
+			      sizeof(struct bpf_prog_desc) * gen->nr_link_slots +
+			      sizeof(struct bpf_link_desc) * i, 4,
+			      gen->link_fds + i * sizeof(int));
 	emit(gen, BPF_MOV64_IMM(BPF_REG_0, 0));
 	emit(gen, BPF_EXIT_INSN());
 	if (!gen->error) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 03f794f4adb0..f7759cc15a54 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1953,9 +1953,10 @@ struct gen_loader_opts {
 	__u32 data_sz;
 	__u32 insns_sz;
 	bool gen_hash;
+	bool gen_attach;
 };

-#define gen_loader_opts__last_field gen_hash
+#define gen_loader_opts__last_field gen_attach
 LIBBPF_API int bpf_object__gen_loader(struct bpf_object *obj,
 				      struct gen_loader_opts *opts);

diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 9e16b8e8cb7c..cac7b1d2abfb 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -47,6 +47,10 @@ struct bpf_prog_desc {
 	int prog_fd;
 };

+struct bpf_link_desc {
+	int link_fd;
+};
+
 enum {
 	BPF_SKEL_KERNEL = (1ULL << 0),
 };
--
2.43.0

