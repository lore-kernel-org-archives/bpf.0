Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648515;
	b=YiIj+yXKrSsNUQ6D1sQni0TRmYkJhpmZm5DgeooTUvu4xw96W+QW3IGEDBzxMSwi8F+X
	 MF4VBGOJCnc7WLapBPs/VpcbeY8bcyYoqN2CKpp2n9L90dii0rXcFAcUBmBtSkvNWiMiT
	 ZHqMSC5+y6udpwhJUEH7yEtCJ0pvvYdyeZnc1Sx2gpcmut0B7y6+ilDNc+xJPp52mCg1T
	 ikMenIxLREH9biZhE3Gefe5DVCWSvWsFSgMQoo7fvmY3Af396JbNZuyotj0xiFimH1wTU
	 NbYUuh43/NbfQ3uJQNTVvX0K+G6fygxtfAUXeS13DrkU46xH8A1++ars2B/w/2ho9xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SpB8+CQBXkjbs7fgG+qom3QzkI74HttnULs4D1eQfjE=;
	b=Gmnu+aa+vAp0sC9oRR0Yz2FcI6lvEyhFX2g1s9esK7jOYH1r1ISSnUEpQu7U31YDjb87
	 bHxWhkGJsdQL0x0KM9hT795FnH+4cHxmf+zm/0pIWKOMrfuL3ULwIVHOAW0dIt/PlXIc5
	 f+25EyjrK7elQvtyogRR71blYaG/GLNBv1W03q6vhBRS+DgzGwywO9qGm4X1dHe6bM1tD
	 VUGsWTJ+7aVmaaPfRKXGzvloLxjD91R6J1UffZeva9ooJYzxc52bSiPKC8DXGL/Vjv99K
	 2jJl9UYdq3i2wYqo4CGk1YuxzMyqpyD0JciEiwvxv9duU1tV7KblBXrJKc+cWgz5Yuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GtziaFNk;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B77606A335
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 19:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9B77606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GtziaFNk
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so28581835e9.3
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 11:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648513; x=1794253313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SpB8+CQBXkjbs7fgG+qom3QzkI74HttnULs4D1eQfjE=;
        b=GtziaFNk7i2iMppP9Qcz+i8RcKdgwHDsyTAT934sJr/OaTBtb3h2dV5qniSRazAapp
         SUmrDaGzlrYlNg89YGnCT4Mf0eqOr18dHSkyOsRIQIADiu9aBs9ESliC+dwl7FwmCznf
         nrKGLS3s2SXxKzVbc6rw1XISBr8HI5awkFV3U4/xNg+C56qymnJLf0AipwEAx5z2r7no
         13EVVHzDcta2f2NGD0XUIYLViGjxozUYAIPs5FRAceTjVog7ywHy6xeKvBlUJRSUlzca
         aylDB3rDbVguUDXteFKsWzGmcZYfChkkVaRqpIZROnhOwNjsjs12B2cM2pS1PXfY2o/C
         KmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648513; x=1794253313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SpB8+CQBXkjbs7fgG+qom3QzkI74HttnULs4D1eQfjE=;
        b=ybEUlktsGUUSBwgnFD7D6TQkcxp9L0G/P0OnjTGbqZAU/ykKgfsBlEELiJfe/fpCmb
         ooG/pTPrXldAb3On7vDTSWOjvlhLV+En6rfOeBekjEjTBIOmzlQ7ddzFRThu18ukDzSm
         pj5Yue00nkQj6Zi7ty8jS28Kvoc6ObK35ctwPko41JD5zK1+uwtGn+xev7JYNEfoomKU
         BlcxLJ0vOORy5YylCy5wDAxHoM9UcGIt64NabVWhGjZIStHPt8DLcHk2+s/HAR+moDAR
         0GV8ERuCHZRSQSy87qvQgNdSl+rBtqFZlfxCXsEvxhGphNxgh3/kbeovtewAm3smuU4I
         p5Yw==
X-Gm-Message-State: AFq9FYJQ0HMTwn095+bn+VhzIFdZh9WSCW5i/nUEkPjL/eM/1B03b7Pl
	QcHAi8ichQ2dXot/If74zo29Gt4vZYfGkLuToPcBdHDn3bvRVKQLeA3r8YJkjthQdImEHQ==
X-Gm-Gg: AYBFou1Fxm+gwhDlxSYCqZTfLvsnrnTnBPjlGtbgYCH9bMlaG5HfZhQUkj4qOX0U4hC
	/8ibkJotGv5h1XYcn+Ew2x4CbmIYBb6l7VI8MZ+Ee9oDKfAH0sUDrZgd22URRwlmnEQzLLYBVIH
	yrKeHkbdYTWAkhVsWlcIlxA0RBylxqyNAgeQcAZwnpxdlGcFha+C78GtOz0USGGwPlTNxr930cR
	R5jmNI3JIRB4ta/qzILxcz/R8Meh5BxvVgfPqhLanli+8yYhXi+La6zhwV//6KEUymhgLEVVYqn
	QOMrUzq+b9slsGjQRPp9Xd3Euoy7g9+bvt5473EVF6HAQunArbfdbTSnyohQKwF3wVM82eqjWPM
	1t6f/eTZN5+2ydyoYRqqO55U2PY6LQzx6XmBxHHwVYLDK2TbrvM7lOX8DDPUFd9t8DtbQROlMgR
	6yXicFV+zrK6vUTkkrEGsXQjaoQJRnWoJb1YrUcIebBBLwamhmkSO0FQUABUyZHQdWT0xfP6AvH
	pOs4vyK309env1AlnWdRqWKzPYX1bORqJYOOBcv2uSU338ovlrmDN3BMDAU7E9MfKy0uEL+vtlS
	ZWhtQH6ubCKooYsq7MIS1szObh4nYKMuFslS+B5gcmyK/pH8a5fefCBTHZ1uVqFeUSF0INDGqjp
	e
X-Received: by 2002:a05:600c:6215:b0:4aa:1527:659 with SMTP id 5b1f17b1804b1-4ac17a366c0mr264076435e9.17.1793648513483;
        Mon, 02 Nov 2026 11:41:53 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4ac0a0a3495sm231386345e9.4.2026.11.02.11.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:41:53 -0800 (PST)
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
Subject: [PATCH bpf-next v2 2/5] libbpf: Track generated loader link FDs
Date: Mon,  2 Nov 2026 19:41:41 +0000
Message-ID: <20261102194145.620210-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102194145.620210-1-mahe.tardy@gmail.com>
References: <20261102194145.620210-1-mahe.tardy@gmail.com>
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

