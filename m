Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893631A254E
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 00:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684914; cv=none; b=NlV5Al4VFBU4qiKQTK/WCli/XQ72zqg3VLLYgywIBs4NjI/bk2husQn+dBa0bFArZNBtM1EIY8JnSDIjfogNuIg8ULm8lh1MS1tRcyih7xFW/qsDuzIluaaJYn8KABqFMi3ogDQAoe+vfBhEvda4UNRaoznq/cGslfVT8cA7Zis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684914; c=relaxed/simple;
	bh=jAoRHWibG6Dqe8UVGGflvStmPmKfuT13q3iqy/2/XlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d8Qm3itMeEzrPLT8blSbW/9oXYlnbfeugnEj9MbtPPOKUZYHfF21vl+wSQ6ZXY2TbO87ZVBP7OyglQOlxMP1b0FN+Uh0HmYI76qM0Y2CsM/Cr7NTu0wc8p3JM0J5fT+9UyYtc70Lmlw89DsVO6oqS22m+8+1Qza1gYDf2L9smDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=SjQqoRfz; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="SjQqoRfz"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c5384ee23fso398524685a.1
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 16:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770684911; x=1771289711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sAMwb6CWGocCHvRHjO4RrSEOPyIRs5Gdfyc+1v3hWAg=;
        b=SjQqoRfz1a3XnoLAR+Jr5P8GSPo0i5nr6TKrbacAfWC2qNSbSmZyE+YGv58dqcZHDN
         vRv0pkEgp2LaS4zYXs8Xf5VNfZLY0P/H1NPJeNTC1UQByNI60p58Uf775nlhYoE3W3A9
         xzV10w51nExUdxgtBfmqH4esGQZfY+lxY87wXb0xHxraCg50zJe5oAUDvq06R3yaFhVh
         ZDFAX0foNla3vsuvAsJ8+vnIpLVadPXRiXfW8xJGPCU6QBczPUVcHqmG41MXEj4wFHpz
         UcKVH87LU3zpx7/7qFtpLTFVFM1WJqr7y++S6LgS/DH9RMxyy6xEJGk0aENVW68Jq/i3
         eT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770684911; x=1771289711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAMwb6CWGocCHvRHjO4RrSEOPyIRs5Gdfyc+1v3hWAg=;
        b=TS26ygMQ2A6gniGAJZQZ/Eqn5WRdGcCRSf/ISarOizjee6DawgHRmKm3F3EDxfTfhn
         3ssFx79lj/r2ICM7Bh2zk06GyCIWSZAeM5nIBz54BiA0FRxiS+mSQjd9QeYiqs/PiKBy
         Hx7Qis7aVkqhX+4Sz6OstRdfvWCt4nzV60KI846NmcaAOJCFchkurr7cgs6u+ucPsEeJ
         +twam64V6akUBw/0QyDG2RfWMkCA6dWLPJp3de5+zSeUtBl36XYr/WcwdynvJvmnMuMZ
         6c/R9cXc95IWwbmIroMm5i5N3iGY3QqNbL2SaXJWzERr7b52MalwKr55HUcg8uKjBxAG
         VJvQ==
X-Gm-Message-State: AOJu0Yw8xec7+uMB5mmqoJDTUG01W5VGF+opPj0FqeGp0mLWAFY/tOHf
	MLpzvCrA8tUpM1X0JXE2KjFNt7NEijSws/+BxQYB9vxn911LX6CVsfU5wx2/c+XNq4vyjrB3bEM
	sv5+B9xo=
X-Gm-Gg: AZuq6aJJDtDEwI1UdBmfy65pxGeMMOMSd1uV+9MK3KEcBEsVMlIZnXWlsGFPBoPMPD5
	ehzBaN+AYDXSZH3RthoZo/XKnGq/7+uoAo/lxYahEAwBQ2NEDJOBcfdZwaHGKhPkUgxuyutjqWA
	BJcqvKNJUsKlKOLd+Yh0Q83atPwJ2irF1dThRWd0rQqSVrI95hFIobYmS3FkWZdao6Fnhscc7zM
	9QS8L0H4KHj9MaFnKl2hvVnmOcOp3RRwXBv7pgR1jWmGiESuvYVjL3KkylaQAGcb1cJzVYm7Vrl
	I17nIeDa3suRD/DjSiCx1u2ep7oOjnCmgcVkDWiy0UDFfSFSXM6dwf8o5ZceU7DFbmzNNrOqt1S
	0n6rYI2piifKfSAJStW9zbtmG2WRgRLXQybA4Ipc8HMWl2wDngnAQNMe5ZHUgwzdif2TZ/dlHIC
	+yi8MxBUZscIq0OFu+KjTQ4g==
X-Received: by 2002:a05:620a:44cf:b0:8c6:a1d5:47e1 with SMTP id af79cd13be357-8caeeb4e117mr1654154185a.9.1770684911321;
        Mon, 09 Feb 2026 16:55:11 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8970404b049sm28917596d6.10.2026.02.09.16.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 16:55:11 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3] libbpf: Add gating for arena globals relocation feature
Date: Mon,  9 Feb 2026 19:55:08 -0500
Message-ID: <20260210005508.3642641-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add feature gating for the arena globals relocation introduced in
commit c1f61171d44b. The commit depends on a previous commit in the
same patchset that is absent from older kernels (12a1fe6e12db,
"bpf/verifier: Do not limit maximum direct offset into arena map").
Without this commit, arena globals relocation with arenas >= 512MiB
fails to load and breaks libbpf's backwards compatibility.

Introduce a libbpf feature to check whether the running kernel includes
patch 12a1fe6e12db, and only relocate arena globals if it does.

CHANGELOG
---------

v2 -> v3 (https://lore.kernel.org/bpf/20260209234850.2750149-1-emil@etsalapatis.com/)

- Rename feature to better specify the verifier feature it probes for
  (Andrii)

v1 -> v2 (https://lore.kernel.org/bpf/20260209210240.2051209-1-emil@etsalapatis.com/)

- Reworked test to use simpler array-based program (Andrii)

Fixes: c1f61171d44b ("libbpf: Move arena globals to the end of the arena")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/features.c        | 92 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          |  7 ++-
 tools/lib/bpf/libbpf_internal.h |  2 +
 3 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b842b83e2480..034ea9b20617 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -506,6 +506,95 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 	return probe_fd(prog_fd);
 }
 
+static int probe_ldimm64_full_range_off(int token_fd)
+{
+	const size_t bufsz = 1024;
+	int btf_fd, prog_fd, map;
+	char log_buf[bufsz];
+	int ret;
+	static const char strs[] = "\0f\0";
+	const __u32 types[] = {
+		/* [1] FUNC_PROTO `void(void)` */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 0), 0),
+		/* [2] FUNC 'f' -> FUNC_PROTO (main prog) */
+		BTF_TYPE_ENC(1 /* "f" */, BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOBAL), 1),
+	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		.token_fd = token_fd,
+		.map_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
+		.token_fd = token_fd,
+		.prog_flags = BPF_F_SLEEPABLE | (token_fd ? BPF_F_TOKEN_FD : 0),
+		.log_buf = log_buf,
+		.log_size = bufsz,
+	);
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 1UL << 30),
+		BPF_EXIT_INSN(),
+	};
+	const struct bpf_func_info_min func_infos[] = {
+		{ 0, 2 }, /* main prog -> FUNC 'f' */
+	};
+	int insn_cnt = ARRAY_SIZE(insns);
+
+	btf_fd = libbpf__load_raw_btf((char *)types, sizeof(types), strs, sizeof(strs), token_fd);
+	if (btf_fd < 0)
+		return 0; /* BTF not supported at all */
+
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr", sizeof(int), 1, 1, &map_opts);
+	if (map < 0) {
+		ret = -errno;
+		pr_warn("Error in %s(): %s. Couldn't create simple array map.\n",
+			__func__, errstr(ret));
+		close(btf_fd);
+		return ret;
+	}
+	insns[0].imm = map;
+
+	prog_opts.prog_btf_fd = btf_fd;
+	prog_opts.func_info = &func_infos;
+	prog_opts.func_info_cnt = ARRAY_SIZE(func_infos);
+	prog_opts.func_info_rec_size = sizeof(func_infos[0]);
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SYSCALL, "global_reloc", "GPL", insns, insn_cnt, &prog_opts);
+
+	ret = -errno;
+	close(map);
+	close(btf_fd);
+
+	if (prog_fd >= 0) {
+		pr_warn("Error in %s(): Program loading unexpectedly succeeded.\n",
+			__func__);
+		close(prog_fd);
+		return -EINVAL;
+	}
+
+	/* Be conservative and NULL terminate the buffer to ensure strstr terminates. */
+	log_buf[bufsz - 1] = '\0';
+
+	/*
+	 * Feature is allowed if we're not failing with the error message "direct value
+	 * offset of %u is not allowed that was removed in 12a1fe6e12db
+	 * ("bpf/verifier: Do not limit maximum direct offset into arena map").
+	 * Instead, we should be failing with the message "invalid access to map value
+	 * pointer". Ensure we match with one of the two and we're not failing with a
+	 * different, unexpected message.
+	 */
+	if (strstr(log_buf, "direct value offset of"))
+		return 0;
+
+	if (strstr(log_buf, "invalid access to map value pointer") == NULL) {
+		pr_warn("Error in %s(): Program unexpectedly failed with message: %s.\n",
+			__func__, log_buf);
+		return ret;
+	}
+
+	/* Feature is on. */
+
+	return 1;
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -581,6 +670,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_QMARK_DATASEC] = {
 		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
 	},
+	[FEAT_LDIMM64_FULL_RANGE_OFF] = {
+		"Full range LDIMM64 support", probe_ldimm64_full_range_off,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c8bf0b5cce4..93e59ed8d9a1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3009,8 +3009,11 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 	memcpy(obj->arena_data, data, data_sz);
 	obj->arena_data_sz = data_sz;
 
-	/* place globals at the end of the arena */
-	obj->arena_data_off = mmap_sz - data_alloc_sz;
+	/* place globals at the end of the arena (if supported) */
+	if (kernel_supports(obj, FEAT_LDIMM64_FULL_RANGE_OFF))
+		obj->arena_data_off = mmap_sz - data_alloc_sz;
+	else
+		obj->arena_data_off = 0;
 
 	/* make bpf_map__init_value() work for ARENA maps */
 	map->mmaped = obj->arena_data;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fc59b21b51b5..974147e8a8aa 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -392,6 +392,8 @@ enum kern_feature_id {
 	FEAT_ARG_CTX_TAG,
 	/* Kernel supports '?' at the front of datasec names */
 	FEAT_BTF_QMARK_DATASEC,
+	/* Kernel supports LDIMM64 imm offsets past 512 MiB. */
+	FEAT_LDIMM64_FULL_RANGE_OFF,
 	__FEAT_CNT,
 };
 
-- 
2.49.0

