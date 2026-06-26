Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20BA30C16B
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510679; cv=none; b=dlxUEBfl/C1toI260gn01+8Wf8OVWhoeINQjqTKypgNYHQYLiml6L1JqIHxNduUCY9xgSFlAtb8OFUR6SE+jeHL3gbT/ALpN83sS7vmbcCeZ/+wwbkEnIJ+VrhBIvGRkYtN5pxXkTr3tO80elFZib1jtYhGURaePdREsIWy6EEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510679; c=relaxed/simple;
	bh=v6v3rVihR6ZnE+U0rUlf6Fe90h3KWGAa/tMBDsyIwf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvxE2l13BNlrjepoGeSaUYXbiy38Ec5yQmscFV7bnXIDjBorjo4TkpwJC4LvDz6DTdc+xcfUGDL/FbCKmPjLJwjb7nMFcMKUVlXVaaw+7IENprTJbF3x/QTJSckb2dCi4lrmEXPYekewm4ORmgMfZYHlx82nZFIxpq78Oq/iipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIkMyZ2o; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIkMyZ2o"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c88973b6965so1241127a12.1
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 14:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782510677; x=1783115477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tc75uA27tps6tP4iUSBy2Y0THPi4bf6/uC/yP+W8zA=;
        b=LIkMyZ2oKu3hxZdsBjE1y2kSWp9J7JYHMbft0paxLiT3ZK9r4qcli/72TBiQxo7gFn
         Dr+mQXDgy6OL2EI9nNsWBC/hJdmjWVCUoMZ3vL5qeB/DSC6JAlKYCcTH3UtKICivoWMu
         P+JGmaGeLYEssQBiFr0Q6Yr5tfvMUBB3ZkToKs+DEcjx0hMGzbcZhPiZ8D57XPdR0Fdn
         u/3EEL+AvXJ5a5qLQUJ4jjcypt7h/wSHhX/rxNmzqP/BchRoHKrUFN4j/wGM4/TWPJSH
         yEDJUXxHlYHRL0BXPQ8fVcBCVq8gbkjyYHfzfWgmBZ+4oVEUap3TnVDGluM7vlFLc1qR
         3Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782510677; x=1783115477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0tc75uA27tps6tP4iUSBy2Y0THPi4bf6/uC/yP+W8zA=;
        b=nzvWsobTTcgqm6FG5l39HJ45d/738pXK6Bu9F1NM4PspJhO5FH3o3HdPD8sMCMEQyg
         j/VeRD/7NghGVdlRWvOFIERilyBhJAPISnGJK/38hO3lMpCVCB1ngNaUYh1fgjZSwlxS
         EJkLki7I2Z3tANVLel23uuCUVziB2cwk2tPU2xHrtT9RCGO7uCDzT99Zw5No54nDSOp8
         zbb00FDKyfNEorVk9P5lixMDzYGXY+gxcWQRCJgJFybyz92Wfau9RGIdUgWWMR92pGlx
         8+HKrZNEze26WFscOgbPG9IqJIBDKxN1/X8uqzjeq40QP8gaqY/2OQuzFXgNXdS7vseT
         s4SQ==
X-Gm-Message-State: AOJu0Yzu2ywIxbMtH2/bQzHdW2jpsO9K89WrmBoSArk/GjXu0CZiEvhS
	3yercQvIpNsbYb9Jss93VybhreAbOmPGSdgfVZ2+B3a3/rNTtj3P6g+pTOBD5A==
X-Gm-Gg: AfdE7ckj47Uo6yirptxGAZoyqzqTQuytLo1bK0E9x85WDyd+X206Rn4ZdHInQVwSvd5
	OS8dViUnA3ldIBIdviFPva4Bfxcz6MCFD7bbg6mBHW43WrAg5VdgCzeLVxRm6ulwmhykFqWNs0K
	clQ0AFUzdshW1WMzNQmxZF39KNHBkq180KtbNrsOKW3oWsg6SHh4m/5ps5lLAhVsZvnte8zgoct
	0tFZcFQn7o+dbowJb6S53mZzu0rJINYg2IZEXBB3NsZRJdlBf0SLB8sFJPGwGAZf7J/mMR6N4ky
	jGzreS4mW5Gj9IJVOODpufC8FtxJhb87YkYSYwoibkNeHLxAMGnYd4U64c+oB/Dw+aA92sO0eDg
	71B0rkNpJ19eju0LG3R9uvnruw9kYLfRH4sAn6rPGYmBA7xnmZCEYVimo1fd+44VMoDtE4d1OTC
	/nivnn6O7kb6k=
X-Received: by 2002:a05:6a21:3282:b0:39b:bc11:9ec5 with SMTP id adf61e73a8af0-3bd10a2cf4fmr16825619637.13.1782510677120;
        Fri, 26 Jun 2026 14:51:17 -0700 (PDT)
Received: from john-p8 ([98.97.43.120])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92ba0a8666sm4110799a12.13.2026.06.26.14.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:51:16 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	daniel@iogearbox.net
Subject: [PATCH bpf-next 2/2] libbpf: selftest for bpf_map__reuse_fd_from_loader_ctx()
Date: Fri, 26 Jun 2026 14:51:13 -0700
Message-ID: <20260626215113.52273-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626215113.52273-1-john.fastabend@gmail.com>
References: <20260626215113.52273-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend signed loader test case to exercise __reuse_fd_from_loader_ctx().

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/signed_loader.c  | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index 5fc417e31fc6..0af33362ab1b 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -8,8 +8,10 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <unistd.h>
 #include <linux/keyctl.h>
 #include <linux/bpf.h>
+#include <linux/if_ether.h>
 
 #include "bpf/libbpf_internal.h" /* for libbpf_sha256() */
 #include "bpf/skel_internal.h"	 /* for loader ctx layout (bpf_loader_ctx etc) */
@@ -699,6 +701,117 @@ static void metadata_ctx_initial_value_ignored(void)
 	test_signed_loader_data__destroy(skel);
 }
 
+static void loader_ctx_reuse_fd_shared_map(void)
+{
+	LIBBPF_OPTS(gen_loader_opts, gopts, .gen_hash = true);
+	struct test_signed_loader_map *skel = NULL;
+	struct bpf_map_info shared_info, reused_info;
+	__u32 shared_info_len, reused_info_len;
+	__u8 excl[SHA256_DIGEST_LENGTH];
+	__u8 pkt[ETH_HLEN] = {};
+	__u32 key = 0, expected_retval = 42;
+	__u64 shared_value = expected_retval;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = pkt,
+		.data_size_in = sizeof(pkt),
+		.repeat = 1,
+	);
+	int nr_maps = 0, nr_progs = 0, ctx_fd = -1, shared_fd = -1;
+	int supplied_fd, r;
+	struct bpf_prog_desc *pd;
+	struct bpf_map_desc *md;
+	struct bpf_program *p;
+	struct bpf_map *m;
+	unsigned char *blob = NULL;
+	__u32 ctx_sz, data_sz;
+	void *ctx = NULL;
+	bool ran;
+
+	skel = test_signed_loader_map__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+	if (!ASSERT_OK(bpf_map__reuse_fd_from_loader_ctx(skel->maps.amap),
+		       "reuse_fd_from_loader_ctx"))
+		goto cleanup;
+	if (!ASSERT_OK(bpf_object__gen_loader(skel->obj, &gopts), "gen_loader"))
+		goto cleanup;
+	if (!ASSERT_OK(bpf_object__load(skel->obj), "gen_load"))
+		goto cleanup;
+
+	bpf_object__for_each_program(p, skel->obj)
+		nr_progs++;
+	bpf_object__for_each_map(m, skel->obj)
+		nr_maps++;
+	if (!ASSERT_EQ(nr_maps, 1, "one map") ||
+	    !ASSERT_EQ(nr_progs, 1, "one prog"))
+		goto cleanup;
+
+	shared_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "ctx_reuse",
+				   sizeof(__u32), sizeof(__u64), 4, NULL);
+	if (!ASSERT_OK_FD(shared_fd, "shared_map"))
+		goto cleanup;
+	if (!ASSERT_OK(bpf_map_update_elem(shared_fd, &key, &shared_value, BPF_ANY),
+		       "shared_map_update"))
+		goto cleanup;
+
+	ctx_sz = sizeof(struct bpf_loader_ctx) +
+		 nr_maps * sizeof(struct bpf_map_desc) +
+		 nr_progs * sizeof(struct bpf_prog_desc);
+	ctx = calloc(1, ctx_sz);
+	if (!ASSERT_OK_PTR(ctx, "ctx_alloc"))
+		goto cleanup;
+	((struct bpf_loader_ctx *)ctx)->sz = ctx_sz;
+
+	md = (struct bpf_map_desc *)((char *)ctx + sizeof(struct bpf_loader_ctx));
+	pd = (struct bpf_prog_desc *)(md + nr_maps);
+	ctx_fd = dup(shared_fd);
+	if (!ASSERT_OK_FD(ctx_fd, "ctx_map_fd"))
+		goto cleanup;
+	md[0].map_fd = ctx_fd;
+	ctx_fd = -1;
+	supplied_fd = md[0].map_fd;
+
+	libbpf_sha256(gopts.insns, gopts.insns_sz, excl);
+	data_sz = gopts.data_sz;
+	blob = malloc(data_sz);
+	if (!ASSERT_OK_PTR(blob, "blob_alloc"))
+		goto cleanup;
+	memcpy(blob, gopts.data, data_sz);
+
+	r = run_gen_loader(gopts.insns, gopts.insns_sz, blob, data_sz,
+			   excl, sizeof(excl), NULL, 0, true, ctx, ctx_sz, &ran);
+	if (!ASSERT_TRUE(ran, "loader ran") ||
+	    !ASSERT_EQ(r, 0, "loader retval"))
+		goto cleanup;
+
+	ASSERT_EQ(md[0].map_fd, supplied_fd, "ctx map fd preserved");
+	ASSERT_GT(pd[0].prog_fd, 0, "prog fd populated");
+	if (ASSERT_OK(bpf_prog_test_run_opts(pd[0].prog_fd, &topts),
+		      "shared map prog run"))
+		ASSERT_EQ(topts.retval, expected_retval, "shared map value");
+
+	memset(&shared_info, 0, sizeof(shared_info));
+	memset(&reused_info, 0, sizeof(reused_info));
+	shared_info_len = sizeof(shared_info);
+	reused_info_len = sizeof(reused_info);
+	if (ASSERT_OK(bpf_map_get_info_by_fd(shared_fd, &shared_info, &shared_info_len),
+		      "shared map info") &&
+	    ASSERT_OK(bpf_map_get_info_by_fd(md[0].map_fd, &reused_info, &reused_info_len),
+		      "reused map info"))
+		ASSERT_EQ(reused_info.id, shared_info.id, "shared map reused");
+
+cleanup:
+	if (ctx)
+		close_loader_ctx_fds(ctx, nr_maps, nr_progs);
+	if (ctx_fd >= 0)
+		close(ctx_fd);
+	if (shared_fd >= 0)
+		close(shared_fd);
+	free(blob);
+	free(ctx);
+	test_signed_loader_map__destroy(skel);
+}
+
 /*
  * The load-time signature must authenticate the loader instructions: a valid
  * signature loads, and the very same signature over one-byte-tampered insns is
@@ -1112,6 +1225,8 @@ void test_signed_loader(void)
 		metadata_ctx_max_entries_ignored();
 	if (test__start_subtest("metadata_ctx_initial_value_ignored"))
 		metadata_ctx_initial_value_ignored();
+	if (test__start_subtest("loader_ctx_reuse_fd_shared_map"))
+		loader_ctx_reuse_fd_shared_map();
 	if (test__start_subtest("signature_authenticates_insns"))
 		signature_authenticates_insns();
 	if (test__start_subtest("hash_requires_frozen"))
-- 
2.53.0

