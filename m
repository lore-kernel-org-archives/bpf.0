Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650446;
	b=joymdDz2ZtgTvR1/BZmKeYdWjlj4F+pK/ChX+WFlCpPapGpMCpDmvsVZ4o2qPTXrm56V
	 7MhRqDrBmXAkzqHoyXU4oKgAf3cgENKmplgyykV7p/kQPsrYpYRO3VepaxZNM7C4mGwOj
	 ESy8NHFdeh/SJvCfvG+zvVdIpS5VteGm8MDLTT4fd53Pw5fV+b419TinneQbNjT2tmwkD
	 lIGS7SZM/NJhZoTgmShPWtUkJ0M0zJDH6DbaMM8aeVVJ2Xsiw9wKPIIubGpKCUhSeWH4p
	 SzD/iRkjFQ1zj8tXTVePMRPn0wC6L3t6Z5RNakgQv0hbGJ4HSo8S7RNmY3EuMX4Kfaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SpB8+CQBXkjbs7fgG+qom3QzkI74HttnULs4D1eQfjE=;
	b=h5Z0aJ9M0bA8Kt7EcICsqXn0LhGlDW6LBQT0GTbTf0HNAku4Pyd+7W5anTTJjbqhMBow
	 2u7WB7eCrCZTkaxe3eXEWGsmW+nc/d6dQxZ2Bj/MX4J7REdu4dHppJBKgOUp/X+MVQoCA
	 b4lH4g2v6qQjaMlQy8xhbOgCyyfsleWHwWHTufthGKOQP2o5M/wmem7ofzQecsuJdDr9/
	 /kSV6QaELaxJdMkVEwAF61UWPQxhF/kzxAQ5DD1V0lbMV15hMJLJabup4YCEFQh287CYS
	 +MH6Ax/8TtM+wGvIo1liPNlz1asDAxjiqcQA+ZEDRaBGAqrx46ndqpXGIUmhPk9KCsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Xz/7OcJX";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B2606D802
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 20:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B44B2606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xz/7OcJX
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e4831c028so3017006f8f.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 12:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793650444; x=1794255244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SpB8+CQBXkjbs7fgG+qom3QzkI74HttnULs4D1eQfjE=;
        b=Xz/7OcJXv3n4ZVkfvZLqVkQ49KduMxBQGkYn2pPkc5XmTFjdVb8jW68KmFqWHjVvhM
         bVP7+zxxszE5Jq0hpZ1cfeHu3LKdYOZ5La/U72fIgb1837PvJpLSbJqiXlzjH/nVzADQ
         ujlp2H7p2Flopqfz3PPnapZqcm1jCt4YlNEoSlls9F1sE40tm4RKcBFhKT8OPONcdcXg
         wfQuyk1m+oMdQoANoIsa7IJ5noDwQu8YK/jV6dTzicRcC5vH2SyHGknIQcDa/AzihZiZ
         zN/CnlEkM8hhgq1md5JRT4UXVhW66MsoNd+mTaWPmbOqNPxMTH3tXik7z6aOZ4RpC0yP
         95BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650444; x=1794255244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SpB8+CQBXkjbs7fgG+qom3QzkI74HttnULs4D1eQfjE=;
        b=1Ls9IFq2D8Hytvi2XEAiheu/IvxFpkH6cQY1ubaJec1Jq/XWKF7dLDWLi2DQ7JEtqw
         DjDnNFVnRas0v1gYt3R4EG92da9ZNVxJEeseMwNXOugyW12MftAMq/ayOYt8s30tfjFN
         9zWblM0hu+goa+WNQTPnRG9qcoANTTI/thoDUAnAU8+joQ6FHNQq8E3cVUzZXHp8XBZu
         EpyhS3nl3uYGZEpnYjfdnvFCkF7BDsdKRkKanXFkgQ6sq1Tzo18UESV8qVkiEzrb5e5R
         K65MSVOpz75/YGEAMjeFPnjQuQhIgiebgZs4BLJoD4Pw5+noP6XKtkLJCk9tObP9oI9i
         TEXQ==
X-Gm-Message-State: APuU4Z8NRVV/liziKu5KTsmtgaTgn4m4R54HdQsP1BjRTJHcORYNe+Dc
	B26roTXCKAUcs60j71KNN+uxsykZHDkKO7UrTU0EvbkRVZLkpth7fDkiRbH0i0lBKR8ztQ==
X-Gm-Gg: AYBFou2c+73mtDzGaZVAUyEKW+t+OWmg+AE0Ml34HnfmgdRs3XSnq3HlcJJ17HQODba
	TSUUfHoqSSnQ8EXgZvlmXv7g1zCvgQb4pEqtOZZx6Kv6vmokqzHYN6yC2/mto2eL4i27pfZofFq
	OX6nps4I3uHLB0yqtdLPNHqTOi6dbXbzOacVyY8RMgmC+0x+PHM3UqLfDVKHYl04YT4b1jp6kU6
	zZqwdiV0kfXORDPKW+pJsbbb3gXESFnR7EamWUZnZhdVQGi3oczvZcT/w+kvV8Fabe1m6OV6bJ9
	FeCe1XuNVlybheqSWy4K2BX4dkfGtXPaGWIW3tMJdCxw9Jh1hx6GrYKjA5aYI80+b17aYv0TSbP
	Jh3w9DPOjQe4cfTiZh2bI/rMjKToHN3epSqpi8UqQziohCEMaC9ssAPvnvIcisv76LRhwESfXT3
	608RuH+DgTjzbQ/fQOmb+lP8S3WBeiOjmQnDJKwaWC3cNMyLuBzd+2SKFLYhQE4LdKq+Envew0b
	CS6yN/L+P8dxhx0SzbWSfR7k0ATtrbLJ0tmjvvpx9lG+toNlBMZCKN3OSeJxeFnq5oAPA/aANn7
	GaHps7nUHiMnJZZduaaGOGRU+z+1NjxhzdL8NNSPUU3HS8pdVssRFzEfGL2eHXW+OiRqov++h0X
	X
X-Received: by 2002:a05:6000:4919:b0:48e:7b12:aca5 with SMTP id ffacd0b85a97d-48e7b21f3c1mr15888370f8f.46.1793650443909;
        Mon, 02 Nov 2026 12:14:03 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm21471805f8f.43.2026.11.02.12.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 12:14:03 -0800 (PST)
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
Subject: [PATCH bpf-next v3 2/5] libbpf: Track generated loader link FDs
Date: Mon,  2 Nov 2026 20:13:53 +0000
Message-ID: <20261102201356.5798-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102201356.5798-1-mahe.tardy@gmail.com>
References: <20261102201356.5798-1-mahe.tardy@gmail.com>
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
index 555d4757a898..7f41b5a517fe 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -122,6 +122,10 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	gen->log_level = log_level;
 	gen->nr_obj_maps = nr_maps;
 	gen->max_func_ptr_maps = max_func_ptr_maps;
+	if (OPTS_GET(gen->opts, gen_attach, false)) {
+		gen->link_fds = add_data(gen, NULL, nr_progs * sizeof(int));
+		gen->nr_link_slots = nr_progs;
+	}
 	if (nr_maps + max_func_ptr_maps > MAX_USED_MAPS) {
 		pr_warn("Total maps exceeds %d\n", MAX_USED_MAPS);
 		gen->error = -E2BIG;
@@ -150,10 +154,14 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
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
@@ -413,6 +421,13 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
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
index 22204a544b23..a2ee239c114d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1990,9 +1990,10 @@ struct gen_loader_opts {
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

