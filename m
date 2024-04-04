Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E43134418
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712273027; cv=none; b=TILBP/68TTGJV3HntR/Uok0af4zQ0n95bvh94dxvF3NM291WRKSHKNZc8vfVUxsyinWfAQYxnp8MMF6+WvU5Qvbvl0leSnI3lgPNj0nbLhOJE6u0yskN4a101zrKdHPgK9PdnfBRMXBVRaGnPHMHcmlrBf/GYKjB4yEzdmqdiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712273027; c=relaxed/simple;
	bh=UM8v47oYGRPLOMYjH/GCnZr9Up5sMCyq4KGxiBGPzms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Df3eO5/etSNc+uNYln4iVk5KA5NR7RhvuqzqRtG2MKcbkGCG3uKSqyTmYI84qSsniNNf6bvb08MjYMniLRv13BW9OMkJxTos8g4R89JYLu5RfD11FFsufKUHRUqD1frcDedte/7T6NsEhh7GDYc7K+6KUbJf2OUd3wFNFj5zHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/9Uy722; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/9Uy722"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e9ee593e76so467656a34.0
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 16:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712273025; x=1712877825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ueU0LC5vV0lMu5ycK7BP+JE8GTTD+XC5Xfal6W8yhhU=;
        b=W/9Uy722FCH5MQOeoS76CdNxNNpfoZ1NlRO5xyp9OWEk7tw9Ab6CKBEIyjmNeL3UXY
         fHjqmIEIhycSDWVOTas5ZuySCawCEzvTa/AnkyRW93/u789RH2c9ALFWsfZ/je+5U7T8
         etH5UoTKgQOl1QiG/Smgue0SrQkMxOziqYCyJBmJ5suMQkF2efofov3VQjrDLgRJq2m1
         3Lph7VAfwrVXUS036Jkk8rIq80WZtBQ1vUXX24fpjRnfRIIC6XtYDRtISHJ2p58Xej4N
         VQ4153rAk7ujOdeyvELgA6qYS7zED941QinooNtyb+OvL3vjfcRZYkh9JSf0D6QlJlW1
         cUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712273025; x=1712877825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueU0LC5vV0lMu5ycK7BP+JE8GTTD+XC5Xfal6W8yhhU=;
        b=SYRbvpIjEvYqRuwR55EJc41/QryUprgOMgfJh1xQsIKEDjXUO4kpRLcV4jZz4n3Gq9
         sT6lhg5FwF+lxI4ER8plUuoOVLb7KVz0YAJacArmYz1yeM9h53ValmykV5HUXOR5fm+R
         OjJUh/yWy40BtkvrcPiRoaKeyMNGMW9PjmnhKyRet4bWIDSI2vmZL24d7bPUu89/RFp5
         iYHL4AYeopaohIOp+HURIFdCijqhStGvubP+JPzTv8Q/t8HWw1QeO3x+jztwnzBDPsfn
         7iDZDB9gWVDM2bv4koRVQAPvJDjep87Nw+OuYbVVRhVFRc3StyrRtZtPRSvnbeZR1+3o
         1Dtw==
X-Gm-Message-State: AOJu0Ywh2+fgDOSYlBqKXOgkIELqsAkULs5+GfKsF7Mpgr4FxelYubbk
	bBZW2KDDY9XYKaeIS6hACUfl6O95iznJ+sDwPCfxHBLSSmhIJbtC8N0Xvufz
X-Google-Smtp-Source: AGHT+IFQI8HmPnCgo3JshxRx9D7smqxWGEzCDuWr6w/b5NNNrTBHCiSHBJGdlG2WBT5pj7Eg+8xYZQ==
X-Received: by 2002:a05:6830:93:b0:6e6:c48c:1010 with SMTP id a19-20020a056830009300b006e6c48c1010mr1297766oto.22.1712273025325;
        Thu, 04 Apr 2024 16:23:45 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:f392:66db:d394:7da8])
        by smtp.gmail.com with ESMTPSA id h20-20020a9d6a54000000b006e676df1a6asm76665otn.80.2024.04.04.16.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 16:23:44 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	john.fastabend@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Make sure libbpf doesn't enforce the signature of a func pointer.
Date: Thu,  4 Apr 2024 16:23:42 -0700
Message-Id: <20240404232342.991414-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier in the kernel ensures that the struct_ops operators behave
correctly by checking that they access parameters and context
appropriately. The verifier will approve a program as long as it correctly
accesses the context/parameters, regardless of its function signature. In
contrast, libbpf should not verify the signature of function pointers and
functions to enable flexibility in loading various implementations of an
operator even if the signature of the function pointer does not match those
in the implementations or the kernel.

With this flexibility, user space applications can adapt to different
kernel versions by loading a specific implementation of an operator based
on feature detection.

This is a follow-up of the commit c911fc61a7ce ("libbpf: Skip zeroed or
null fields if not found in the kernel type.")

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

---
Major changes from v1:

  - Rephrase commit logs to remove the description of trial-and-error
    approach.

  - Fix imprecise description of the verifier. It checks the behavior of
    the bpf programs in accessing the context/parameters, not signatures.

v1: https://lore.kernel.org/all/20240401223058.1503400-1-thinker.li@gmail.com/
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 24 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   | 13 ++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 098776d00ab4..7cf2b9ddd3e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -138,11 +138,35 @@ static void test_struct_ops_not_zeroed(void)
 	struct_ops_module__destroy(skel);
 }
 
+/* The signature of an implementation might not match the signature of the
+ * function pointer prototype defined in the BPF program. This mismatch
+ * should be allowed as long as the behavior of the operator program
+ * adheres to the signature in the kernel. Libbpf should not enforce the
+ * signature; rather, let the kernel verifier handle the enforcement.
+ */
+static void test_struct_ops_incompatible(void)
+{
+	struct struct_ops_module *skel;
+	struct bpf_link *link;
+
+	skel = struct_ops_module__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_incompatible);
+	if (ASSERT_OK_PTR(link, "attach_struct_ops"))
+		bpf_link__destroy(link);
+
+	struct_ops_module__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("test_struct_ops_load"))
 		test_struct_ops_load();
 	if (test__start_subtest("test_struct_ops_not_zeroed"))
 		test_struct_ops_not_zeroed();
+	if (test__start_subtest("test_struct_ops_incompatible"))
+		test_struct_ops_incompatible();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 86e1e50c5531..63b065dae002 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -68,3 +68,16 @@ struct bpf_testmod_ops___zeroed testmod_zeroed = {
 	.test_1 = (void *)test_1,
 	.test_2 = (void *)test_2_v2,
 };
+
+struct bpf_testmod_ops___incompatible {
+	int (*test_1)(void);
+	void (*test_2)(int *a);
+	int data;
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops___incompatible testmod_incompatible = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2,
+	.data = 3,
+};
-- 
2.34.1

