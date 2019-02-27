Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39056C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED31721850
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 23:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="PT7YTO9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfB0XbO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:31:14 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33115 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbfB0XbL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 18:31:11 -0500
Received: by mail-qt1-f194.google.com with SMTP id z39so21482562qtz.0
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 15:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F5lRiUiw3F3eX0KxbrL0M5pggJT7dCKUsgeOXQoWa2Q=;
        b=PT7YTO9GbVqHQHP/elgQbFKOA7GQ2soE9lyMSi/ejyWWBcK+XTomiiDWJt0Lf/OKDP
         V0mnqHpIwMhHodVIWqpyqBmIFZaxkn6JF3Wef0Q+3BCbRJZXS/na/1Z5rqcncVryI8dJ
         CBm/J9HUrICXQhR8pd6pBRvISlDUEZ1lpz7TH1H5J/9TbNscrjK1UOeaiXxly/mg/yIS
         NikeP2w4GurnyOcS7FGyLGsfCUubt8mGFITGhHR+QBreRIR3v6xkbV00SYDNX5p8OMja
         61VH99GEbfVerqvt1pB/hD8gj3oSV4IXC2TGQGqt6BQLG1oxG3SfjKCf3AlIgHpWEEHO
         KgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F5lRiUiw3F3eX0KxbrL0M5pggJT7dCKUsgeOXQoWa2Q=;
        b=ElyRC5Bd6Ui8lIJo0W/7tyXFMkOxl+ZmBLshYIo/6/eYikSE26DPq/1XayidS0m16J
         A7htYPgdRT2NG27DLwrzz/waRCwsHPbzdJoYuRp3fx/2tVgbyGZ6vMxxPhLBwu/qQp29
         zULrLc66qgqgaY8OIFGmgWcjZ03yMBBrs9ntXwAxadp4xMy7R/QEEpby+W+BkK336/AO
         ArLa10N+ZCF7w/9pPDpI6PBMeptXQ1H4KHcUZ5+CSY7aa5ntyA2JKqLZCeuJYDjn/2L1
         I3a6XF8oIRCZ9eF7nhTqInOf9aiTo3ycI4DuXLGQEvPbmVg9MElX7wO9NixHfpeMNN6W
         nkFg==
X-Gm-Message-State: AHQUAuZA6AC6Zx+MCaOH5yfGp5P3xtwTAH8FTYfj2XxoMSupgkx863iB
        sk2I3xUiYV2If0LJ3FjFe9aP/A==
X-Google-Smtp-Source: APXvYqwIdXzwvAKKcWEsJ3i/JCsc5t7Ts1iGowLRShQE9BbDdbGDCMv1lZ6KZ38Gkx1lBHPUoFaAaA==
X-Received: by 2002:ac8:3fc5:: with SMTP id v5mr4017553qtk.62.1551310270261;
        Wed, 27 Feb 2019 15:31:10 -0800 (PST)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id z28sm11509741qth.85.2019.02.27.15.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 15:31:09 -0800 (PST)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next 3/5] tools: libbpf: add a correctly named define for map iteration
Date:   Wed, 27 Feb 2019 15:30:44 -0800
Message-Id: <20190227233046.11718-4-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190227233046.11718-1-jakub.kicinski@netronome.com>
References: <20190227233046.11718-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For historical reasons the helper to loop over maps in an object
is called bpf_map__for_each while it really should be called
bpf_object__for_each_map.  Rename and add a correctly named
define for backward compatibility.

Switch all in-tree users to the correct name (Quentin).

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
---
 tools/bpf/bpftool/prog.c                       | 4 ++--
 tools/lib/bpf/libbpf.c                         | 8 ++++----
 tools/lib/bpf/libbpf.h                         | 3 ++-
 tools/perf/util/bpf-loader.c                   | 4 ++--
 tools/testing/selftests/bpf/test_libbpf_open.c | 2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 0c35dd543d49..8ef80d65a474 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1053,7 +1053,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 	j = 0;
 	while (j < old_map_fds && map_replace[j].name) {
 		i = 0;
-		bpf_map__for_each(map, obj) {
+		bpf_object__for_each_map(map, obj) {
 			if (!strcmp(bpf_map__name(map), map_replace[j].name)) {
 				map_replace[j].idx = i;
 				break;
@@ -1074,7 +1074,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 	/* Set ifindex and name reuse */
 	j = 0;
 	idx = 0;
-	bpf_map__for_each(map, obj) {
+	bpf_object__for_each_map(map, obj) {
 		if (!bpf_map__is_offload_neutral(map))
 			bpf_map__set_ifindex(map, ifindex);
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b38dcbe7460a..f5eb60379c8d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2100,7 +2100,7 @@ int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
 	if (err)
 		return err;
 
-	bpf_map__for_each(map, obj) {
+	bpf_object__for_each_map(map, obj) {
 		char buf[PATH_MAX];
 		int len;
 
@@ -2147,7 +2147,7 @@ int bpf_object__unpin_maps(struct bpf_object *obj, const char *path)
 	if (!obj)
 		return -ENOENT;
 
-	bpf_map__for_each(map, obj) {
+	bpf_object__for_each_map(map, obj) {
 		char buf[PATH_MAX];
 		int len;
 
@@ -2835,7 +2835,7 @@ bpf_object__find_map_by_name(struct bpf_object *obj, const char *name)
 {
 	struct bpf_map *pos;
 
-	bpf_map__for_each(pos, obj) {
+	bpf_object__for_each_map(pos, obj) {
 		if (pos->name && !strcmp(pos->name, name))
 			return pos;
 	}
@@ -2928,7 +2928,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 			first_prog = prog;
 	}
 
-	bpf_map__for_each(map, obj) {
+	bpf_object__for_each_map(map, obj) {
 		if (!bpf_map__is_offload_neutral(map))
 			map->map_ifindex = attr->ifindex;
 	}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6c0168f8bba5..b4652aa1a58a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -278,10 +278,11 @@ bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);
 
 LIBBPF_API struct bpf_map *
 bpf_map__next(struct bpf_map *map, struct bpf_object *obj);
-#define bpf_map__for_each(pos, obj)		\
+#define bpf_object__for_each_map(pos, obj)		\
 	for ((pos) = bpf_map__next(NULL, (obj));	\
 	     (pos) != NULL;				\
 	     (pos) = bpf_map__next((pos), (obj)))
+#define bpf_map__for_each bpf_object__for_each_map
 
 LIBBPF_API struct bpf_map *
 bpf_map__prev(struct bpf_map *map, struct bpf_object *obj);
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 037d8ff6a634..31b7e5a1453b 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1489,7 +1489,7 @@ apply_obj_config_object(struct bpf_object *obj)
 	struct bpf_map *map;
 	int err;
 
-	bpf_map__for_each(map, obj) {
+	bpf_object__for_each_map(map, obj) {
 		err = apply_obj_config_map(map);
 		if (err)
 			return err;
@@ -1513,7 +1513,7 @@ int bpf__apply_obj_config(void)
 
 #define bpf__for_each_map(pos, obj, objtmp)	\
 	bpf_object__for_each_safe(obj, objtmp)	\
-		bpf_map__for_each(pos, obj)
+		bpf_object__for_each_map(pos, obj)
 
 #define bpf__for_each_map_named(pos, obj, objtmp, name)	\
 	bpf__for_each_map(pos, obj, objtmp) 		\
diff --git a/tools/testing/selftests/bpf/test_libbpf_open.c b/tools/testing/selftests/bpf/test_libbpf_open.c
index 1909ecf4d999..65cbd30704b5 100644
--- a/tools/testing/selftests/bpf/test_libbpf_open.c
+++ b/tools/testing/selftests/bpf/test_libbpf_open.c
@@ -67,7 +67,7 @@ int test_walk_maps(struct bpf_object *obj, bool verbose)
 	struct bpf_map *map;
 	int cnt = 0;
 
-	bpf_map__for_each(map, obj) {
+	bpf_object__for_each_map(map, obj) {
 		cnt++;
 		if (verbose)
 			printf("Map (count:%d) name: %s\n", cnt,
-- 
2.19.2

