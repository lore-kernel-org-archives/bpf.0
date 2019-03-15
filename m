Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF325C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 18:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79A1218A1
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 18:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfCOSlr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:41:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfCOSlr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 14:41:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6746A31587B9;
        Fri, 15 Mar 2019 18:41:46 +0000 (UTC)
Received: from quaco.ghostprotocols.net (ovpn-112-34.phx2.redhat.com [10.3.112.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DE245C21F;
        Fri, 15 Mar 2019 18:41:45 +0000 (UTC)
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D8A3C4039C; Fri, 15 Mar 2019 15:41:41 -0300 (-03)
Date:   Fri, 15 Mar 2019 15:41:41 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 1/1] bpftool: Allow referring to maps by its name
Message-ID: <20190315183211.GB24482@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 15 Mar 2019 18:41:46 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While developing 'perf trace' and looking at BPF maps it puts in place I
noticed that one needs to first use 'bpftool map' to lookup a map id to
then use 'bpftool map dump map id <map-id-looked-up>'.

This is needed because everytime we restart 'perf trace' the map IDs
gets changed so we need to do the ID lookup again.

To speed up this sequence, allow specifying just the map name, look up
its ID and then use the existing routines as if the user had provided
the map id.

This:

  # bpftool map
  13: lpm_trie  flags 0x1
  	key 8B  value 8B  max_entries 1  memlock 4096B
  14: lpm_trie  flags 0x1
  	key 20B  value 8B  max_entries 1  memlock 4096B
  15: lpm_trie  flags 0x1
  	key 8B  value 8B  max_entries 1  memlock 4096B
  16: lpm_trie  flags 0x1
  	key 20B  value 8B  max_entries 1  memlock 4096B
  17: lpm_trie  flags 0x1
  	key 8B  value 8B  max_entries 1  memlock 4096B
  18: lpm_trie  flags 0x1
  	key 20B  value 8B  max_entries 1  memlock 4096B
  21: lpm_trie  flags 0x1
  	key 8B  value 8B  max_entries 1  memlock 4096B
  22: lpm_trie  flags 0x1
  	key 20B  value 8B  max_entries 1  memlock 4096B
  28: perf_event_array  name __augmented_sys  flags 0x0
  	key 4B  value 4B  max_entries 8  memlock 4096B
  29: array  name syscalls  flags 0x0
  	key 4B  value 1B  max_entries 512  memlock 8192B
  30: hash  name pids_filtered  flags 0x0
  	key 4B  value 1B  max_entries 64  memlock 8192B
  #
   # bpftool map dump id 30
  [{
          "key": 26554,
          "value": true
      },{
          "key": 2592,
          "value": true
      }
  ]
  #

Now is equivalent to:

  # bpftool map dump pids_filtered
  [{
          "key": 26554,
          "value": true
      },{
          "key": 2592,
          "value": true
      }
  ]
  #

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-rrnxuhvety3j3rf0r9zlbfro@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/bpf/bpftool/map.c | 56 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index e0c650d91784..94789992b934 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -89,12 +89,55 @@ static void *alloc_value(struct bpf_map_info *info)
 		return malloc(info->value_size);
 }
 
+static int bpf_map_get_id_by_name(const char *name, __u32 *idp)
+{
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	__u32 id = 0;
+	int err;
+	int fd;
+
+	while (true) {
+		err = bpf_map_get_next_id(id, &id);
+		if (err) {
+			if (errno == ENOENT)
+				break;
+			p_err("can't get next map: %s%s", strerror(errno),
+			      errno == EINVAL ? " -- kernel too old?" : "");
+			break;
+		}
+
+		fd = bpf_map_get_fd_by_id(id);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				continue;
+			p_err("can't get map by id (%u): %s",
+			      id, strerror(errno));
+			break;
+		}
+
+		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			p_err("can't get map info: %s", strerror(errno));
+			close(fd);
+			break;
+		}
+
+		if (strcmp(info.name, name) == 0) {
+			*idp = id;
+			return 0;
+		}
+	}
+
+	return errno == ENOENT ? 0 : -1;
+}
+
 int map_parse_fd(int *argc, char ***argv)
 {
+	unsigned int id = 0;
 	int fd;
 
 	if (is_prefix(**argv, "id")) {
-		unsigned int id;
 		char *endptr;
 
 		NEXT_ARGP();
@@ -104,8 +147,8 @@ int map_parse_fd(int *argc, char ***argv)
 			p_err("can't parse %s as ID", **argv);
 			return -1;
 		}
+get_fd_by_id:
 		NEXT_ARGP();
-
 		fd = bpf_map_get_fd_by_id(id);
 		if (fd < 0)
 			p_err("get map by id (%u): %s", id, strerror(errno));
@@ -119,9 +162,12 @@ int map_parse_fd(int *argc, char ***argv)
 		NEXT_ARGP();
 
 		return open_obj_pinned_any(path, BPF_OBJ_MAP);
+	} else {
+		if (bpf_map_get_id_by_name(**argv, &id) == 0)
+			goto get_fd_by_id;
 	}
 
-	p_err("expected 'id' or 'pinned', got: '%s'?", **argv);
+	p_err("expected 'id' or 'pinned' or an existing map name, got: '%s'?", **argv);
 	return -1;
 }
 
@@ -625,7 +671,7 @@ static int do_show(int argc, char **argv)
 	if (show_pinned)
 		build_pinned_obj_table(&map_table, BPF_OBJ_MAP);
 
-	if (argc == 2) {
+	if (argc == 2 || argc == 1) {
 		fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
 		if (fd < 0)
 			return -1;
@@ -741,7 +787,7 @@ static int do_dump(int argc, char **argv)
 	int err;
 	int fd;
 
-	if (argc != 2)
+	if (argc != 2 && argc != 1)
 		usage();
 
 	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
-- 
2.20.1


----- End forwarded message -----

-- 

- Arnaldo
