Return-Path: <SRS0=N7Fo=A7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EF3C433E8
	for <bpf@archiver.kernel.org>; Mon, 20 Jul 2020 19:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6792080D
	for <bpf@archiver.kernel.org>; Mon, 20 Jul 2020 19:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGWSJyPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbgGTTzK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgGTTzJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 15:55:09 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9247AC061794
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 12:55:09 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s21so14383873ilk.5
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMjpMjNih1+jm3foEyZS3IDJgvYOqAdwPfkk24YvvLw=;
        b=RGWSJyPCQUcGlhpL063FDpEgAiJtvgnCMEU2rDNW0ST43OThbRKACt+3ZvIlz95ox6
         6lpcTIoFLRHG9rhMfPdWqDx9e7cXSX17wDPShH82zSyBT2X5OTaAWmo6Ak1QHZcl/Pdt
         zMRViOGCTh52aS/KTXievJPBGgOsdD4HV10WsrcUXfEv7tWg0JquWJNFllnhGiUiTViD
         Qom/gh2g0LDBgJQH86Sn4BmtDJWRjzx367tZdlXPdg2zNnYvqUv8wNfTqJkGnlRVzE5N
         f3eD+BoiEb4gfOgsUEUORpDLlI+HJmJwJmY9XQQaaUMDQbs1ibpNufSudMUXeGgYKufK
         h0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMjpMjNih1+jm3foEyZS3IDJgvYOqAdwPfkk24YvvLw=;
        b=GjSc4mCAWj1FIH0Rp1oNHMaAgbDyXzvCOEGGeEAyCqhpwma4P0VaGx5mNdJdMDUCQk
         yVaosDmYy41oWBbPL5eX21IIssKobIJRDFnt7+qEWKR+yJrw42g8lrCGxyIBlfq2jziX
         XNadu87uJ+0Z4DZUW1TDAEUxagWZJd+YfJqtCZJu5wmbh7hCpHcquFtibNDb0cRfDkVT
         PcD5szbjBLkOCL/HX5ehtwBFhUC9wEgwrXh41R8Af23pon+ggwzqjBVEFkvPEfGmK5Qz
         DIFuvYWE4vzMZwm0iETX9mrn/+aHZgH6wpmdqNxJzvcPWxbCT/Fyl8jky7Gj+2VeGUjy
         Tefw==
X-Gm-Message-State: AOAM531wKBKzYGyJD/BBtUFu2y0vHftkZ92NoVW+qdkEAsePhrgFNSCg
        AucXK8DHF3fHCav5wJZo1TkBPu6GHb7tSw==
X-Google-Smtp-Source: ABdhPJxBT4q5gz6t1eC0iQVU5BtiP40QqcwBevyEOa5IRNwa+cDYzyuER1DS1/UVKxjU4Lhb8qJeNg==
X-Received: by 2002:a92:9fcb:: with SMTP id z72mr24837388ilk.195.1595274908728;
        Mon, 20 Jul 2020 12:55:08 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id v10sm9347174ilj.40.2020.07.20.12.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 12:55:08 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH v4 bpf-next 4/5] selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress
Date:   Mon, 20 Jul 2020 14:54:54 -0500
Message-Id: <3a1fea5958605766b326fff3b6e78488f155510d.1595274799.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595274799.git.zhuyifei@google.com>
References: <cover.1595274799.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

This mirrors the original egress-only test. The cgroup_storage is
now extended to have two packet counters, one for egress and one
for ingress. The behavior of the counters are exactly the same as
the original egress-only test, only that the total number of
invocations doubles from having both egress and ingress being
counted.

The field attach_type in the map key is ignored in the kernel;
however, keeping it is pointless here and we are demonstrating the
expected usage of the map, so it is removed. That said, keeping the
field will not fail the test, for backwards compatibility reasons.
In other words, the original egress-only test is not affected by
the change in CGROUP_STORAGE behavior and will pass in both cases.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 .../bpf/prog_tests/cg_storage_multi.c         | 90 +++++++++++++++++--
 1 file changed, 83 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
index 1f4ab437ddb9..aa2b448c4214 100644
--- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -28,7 +28,6 @@ static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
 	map_fd = bpf_map__fd(map);
 
 	key.cgroup_inode_id = get_cgroup_id(cgroup_path);
-	key.attach_type = BPF_CGROUP_INET_EGRESS;
 	if (CHECK(bpf_map_lookup_elem(map_fd, &key, &value) < 0,
 		  "map-lookup", "errno %d", errno))
 		return true;
@@ -48,7 +47,6 @@ static bool assert_storage_noexist(struct bpf_map *map, const char *cgroup_path)
 	map_fd = bpf_map__fd(map);
 
 	key.cgroup_inode_id = get_cgroup_id(cgroup_path);
-	key.attach_type = BPF_CGROUP_INET_EGRESS;
 	if (CHECK(bpf_map_lookup_elem(map_fd, &key, &value) == 0,
 		  "map-lookup", "succeeded, expected ENOENT"))
 		return true;
@@ -156,14 +154,92 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 static void test_egress_ingress(int parent_cgroup_fd, int child_cgroup_fd)
 {
 	struct cg_storage_multi_egress_ingress *obj;
+	struct cgroup_value expected_cgroup_value;
+	struct bpf_link *parent_egress_link = NULL, *parent_ingress_link = NULL;
+	struct bpf_link *child_egress_link = NULL, *child_ingress_link = NULL;
+	bool err;
 
-	/* Cannot load both programs due to verifier failure:
-	 * "only one cgroup storage of each type is allowed"
-	 */
 	obj = cg_storage_multi_egress_ingress__open_and_load();
-	if (CHECK(obj || errno != EBUSY,
-		  "skel-load", "errno %d, expected EBUSY", errno))
+	if (CHECK(!obj, "skel-load", "errno %d", errno))
 		return;
+
+	/* Attach to parent cgroup, trigger packet from child.
+	 * Assert that there is two runs, one with parent cgroup egress and
+	 * one with parent cgroup ingress.
+	 * Also assert that child cgroup's storage does not exist
+	 */
+	parent_egress_link = bpf_program__attach_cgroup(obj->progs.egress,
+							parent_cgroup_fd);
+	if (CHECK(IS_ERR(parent_egress_link), "parent-egress-cg-attach",
+		  "err %ld", PTR_ERR(parent_egress_link)))
+		goto close_bpf_object;
+	parent_ingress_link = bpf_program__attach_cgroup(obj->progs.ingress,
+							 parent_cgroup_fd);
+	if (CHECK(IS_ERR(parent_ingress_link), "parent-ingress-cg-attach",
+		  "err %ld", PTR_ERR(parent_ingress_link)))
+		goto close_bpf_object;
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK(err, "first-connect-send", "errno %d", errno))
+		goto close_bpf_object;
+	if (CHECK(obj->bss->invocations != 2,
+		  "first-invoke", "invocations=%d", obj->bss->invocations))
+		goto close_bpf_object;
+	expected_cgroup_value = (struct cgroup_value) {
+		.egress_pkts = 1,
+		.ingress_pkts = 1,
+	};
+	if (assert_storage(obj->maps.cgroup_storage,
+			   PARENT_CGROUP, &expected_cgroup_value))
+		goto close_bpf_object;
+	if (assert_storage_noexist(obj->maps.cgroup_storage, CHILD_CGROUP))
+		goto close_bpf_object;
+
+	/* Attach to parent and child cgroup, trigger packet from child.
+	 * Assert that there is four additional runs, parent cgroup egress and
+	 * ingress, child cgroup egress and ingress.
+	 */
+	child_egress_link = bpf_program__attach_cgroup(obj->progs.egress,
+						       child_cgroup_fd);
+	if (CHECK(IS_ERR(child_egress_link), "child-egress-cg-attach",
+		  "err %ld", PTR_ERR(child_egress_link)))
+		goto close_bpf_object;
+	child_ingress_link = bpf_program__attach_cgroup(obj->progs.ingress,
+							child_cgroup_fd);
+	if (CHECK(IS_ERR(child_ingress_link), "child-ingress-cg-attach",
+		  "err %ld", PTR_ERR(child_ingress_link)))
+		goto close_bpf_object;
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK(err, "second-connect-send", "errno %d", errno))
+		goto close_bpf_object;
+	if (CHECK(obj->bss->invocations != 6,
+		  "second-invoke", "invocations=%d", obj->bss->invocations))
+		goto close_bpf_object;
+	expected_cgroup_value = (struct cgroup_value) {
+		.egress_pkts = 2,
+		.ingress_pkts = 2,
+	};
+	if (assert_storage(obj->maps.cgroup_storage,
+			   PARENT_CGROUP, &expected_cgroup_value))
+		goto close_bpf_object;
+	expected_cgroup_value = (struct cgroup_value) {
+		.egress_pkts = 1,
+		.ingress_pkts = 1,
+	};
+	if (assert_storage(obj->maps.cgroup_storage,
+			   CHILD_CGROUP, &expected_cgroup_value))
+		goto close_bpf_object;
+
+close_bpf_object:
+	if (parent_egress_link)
+		bpf_link__destroy(parent_egress_link);
+	if (parent_ingress_link)
+		bpf_link__destroy(parent_ingress_link);
+	if (child_egress_link)
+		bpf_link__destroy(child_egress_link);
+	if (child_ingress_link)
+		bpf_link__destroy(child_ingress_link);
+
+	cg_storage_multi_egress_ingress__destroy(obj);
 }
 
 void test_cg_storage_multi(void)
-- 
2.27.0

