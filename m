Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89995F862
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721946; cv=none; b=oQHiox75ZQMiFec8Xt08/cgbGoeq10Tw6QGNgwOi3Qr6bBKm/Ko7Shs1ObFYlEPGUfLLmMLIrtRFCRsdgKS87raJo75Q7UzEzOO2SZRhUg6/P3Ps4BGQvWtyzrC6758NqZMqbP6cmY8blvE0VrX5LTQg0yukf3MYMdHHzbC/bEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721946; c=relaxed/simple;
	bh=AlwMdNFDJS0zfuU+xc0pIGyGfGCAdfWXrniIcad1Ym4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SV/+r2kypw1oDWlYjHbgrvMAcip+UBuVypBfzXZaqbiMDp5N5kWzhIVS9VkAsD3uBr6q5upb7WqDOCGDt0+ItUE0wT6x8mC4lfjWJc254jVBoDp3dF5A9Uv0lk/N6phi4NXMklDrhsiUO0JGbym4+2QjaHWVfm8EQj/uRX3zIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6yRk0Fi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6yRk0Fi"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so127236766b.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721943; x=1710326743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLXKB51WZ7Tdq/MZem0e2IjeQIkn0MywkjVRYEGvqSM=;
        b=h6yRk0FiZRgQniMFe3slKT1S1dOaLcHGlciHH5AW2JKhaqUdlQIOyNotMntlh99YZH
         DcgfUPO2kKGVP0Wl8jP0ic1tktMko/grKDtCKjdTxlxNauzv33HaGJAZ/9LAm1P72QJn
         UHvkxta5f8un8ICTpuG+uQBJX+Baymr6yuHiDPZ8b9IEGMqXUP1cm4pE1f4/eU28OiKA
         z7stYOVGjbWfQij1k/3YUG+uYUUqG056vzogaB+de/5erMrjJNG5ZRoo2dbIJxJTwaGm
         rWQuBKKemibpNYPmkXCNxbHNkx/yqsuXW+Bt4pPhXKYJm5Apa6UVqkbxZpPkkLLrUW4e
         9Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721943; x=1710326743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLXKB51WZ7Tdq/MZem0e2IjeQIkn0MywkjVRYEGvqSM=;
        b=O6bpbHmKjfx6BZtbKTgqDSUrLoEMxY6pC66nSAWE4BgmG0ofqwB4cDRckZLMIAGAhe
         2nt8LHRW/J5FApEG4O1N9uKAuV2CTnSmtW5NzDBL5mvGUks7NWcTrfrc0UQ1lfIv3dav
         EHjEMLpZe1SFdkQB3i9e0KD2A2Vd7vbp2OKy1SMy1LBfE61o8ygjDeE0HhiwG1WzpnBc
         +RE71EntGDn3J6YWerungyjZk/+pydSeZd5tf+bQhKFDgXZrPhRNGUZjwc0W7ffQoFDF
         ScN0uwk8ca15SQFJlOMemnVnpEBTRxMj9ZTISxSizjcL6f3A8BUWuUI21L4UMRRT77hy
         yCag==
X-Gm-Message-State: AOJu0YyRBVAqa119p1YKRZtwcbIE0AnwsZgb5SU770xwCh4soBuADmAB
	/7D8S7H2wSaO3N+as9JJRuluaa40dAg3SBmc635FOgAC+ntBFMPGcx9QfwzW
X-Google-Smtp-Source: AGHT+IEOd6UC3s+YZkm7Nd5u1zhgVV5zOoRkzSAWlCG6dP+6ORk22h/xQLS6R8LS/8PRpBEtAZ3R+g==
X-Received: by 2002:a17:906:1511:b0:a44:144e:3463 with SMTP id b17-20020a170906151100b00a44144e3463mr5756337ejd.7.1709721942514;
        Wed, 06 Mar 2024 02:45:42 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:42 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 02/15] libbpf: tie struct_ops programs to kernel BTF ids, not to local ids
Date: Wed,  6 Mar 2024 12:45:16 +0200
Message-ID: <20240306104529.6453-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306104529.6453-1-eddyz87@gmail.com>
References: <20240306104529.6453-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enforce the following existing limitation on struct_ops programs based
on kernel BTF id instead of program-local BTF id:

    struct_ops BPF prog can be re-used between multiple .struct_ops &
    .struct_ops.link as long as it's the same struct_ops struct
    definition and the same function pointer field

This allows reusing same BPF program for versioned struct_ops map
definitions, e.g.:

    SEC("struct_ops/test")
    int BPF_PROG(foo) { ... }

    struct some_ops___v1 { int (*test)(void); };
    struct some_ops___v2 { int (*test)(void); };

    SEC(".struct_ops.link") struct some_ops___v1 a = { .test = foo }
    SEC(".struct_ops.link") struct some_ops___v2 b = { .test = foo }

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 49 ++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e2a4c409980b..2c0cb72bc7a4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1146,8 +1146,32 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 
 			if (mod_btf)
 				prog->attach_btf_obj_fd = mod_btf->fd;
-			prog->attach_btf_id = kern_type_id;
-			prog->expected_attach_type = kern_member_idx;
+
+			/* if we haven't yet processed this BPF program, record proper
+			 * attach_btf_id and member_idx
+			 */
+			if (!prog->attach_btf_id) {
+				prog->attach_btf_id = kern_type_id;
+				prog->expected_attach_type = kern_member_idx;
+			}
+
+			/* struct_ops BPF prog can be re-used between multiple
+			 * .struct_ops & .struct_ops.link as long as it's the
+			 * same struct_ops struct definition and the same
+			 * function pointer field
+			 */
+			if (prog->attach_btf_id != kern_type_id) {
+				pr_warn("struct_ops init_kern %s func ptr %s: invalid reuse of prog %s in sec %s with type %u: attach_btf_id %u != kern_type_id %u\n",
+					map->name, mname, prog->name, prog->sec_name, prog->type,
+					prog->attach_btf_id, kern_type_id);
+				return -EINVAL;
+			}
+			if (prog->expected_attach_type != kern_member_idx) {
+				pr_warn("struct_ops init_kern %s func ptr %s: invalid reuse of prog %s in sec %s with type %u: expected_attach_type %u != kern_member_idx %u\n",
+					map->name, mname, prog->name, prog->sec_name, prog->type,
+					prog->expected_attach_type, kern_member_idx);
+				return -EINVAL;
+			}
 
 			st_ops->kern_func_off[i] = kern_data_off + kern_moff;
 
@@ -9428,27 +9452,6 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 			return -EINVAL;
 		}
 
-		/* if we haven't yet processed this BPF program, record proper
-		 * attach_btf_id and member_idx
-		 */
-		if (!prog->attach_btf_id) {
-			prog->attach_btf_id = st_ops->type_id;
-			prog->expected_attach_type = member_idx;
-		}
-
-		/* struct_ops BPF prog can be re-used between multiple
-		 * .struct_ops & .struct_ops.link as long as it's the
-		 * same struct_ops struct definition and the same
-		 * function pointer field
-		 */
-		if (prog->attach_btf_id != st_ops->type_id ||
-		    prog->expected_attach_type != member_idx) {
-			pr_warn("struct_ops reloc %s: cannot use prog %s in sec %s with type %u attach_btf_id %u expected_attach_type %u for func ptr %s\n",
-				map->name, prog->name, prog->sec_name, prog->type,
-				prog->attach_btf_id, prog->expected_attach_type, name);
-			return -EINVAL;
-		}
-
 		st_ops->progs[member_idx] = prog;
 
 		/* st_ops->data will be exposed to users, being returned by
-- 
2.43.0

