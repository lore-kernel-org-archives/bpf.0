Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4D3C282CE
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 21:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A8420820
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 21:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDIVUl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:20:41 -0400
Received: from www62.your-server.de ([213.133.104.62]:52090 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfDIVUk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 17:20:40 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDyAS-0001d9-Ni; Tue, 09 Apr 2019 23:20:32 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com,
        jannh@google.com, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v6 08/16] bpf: allow for key-less BTF in array map
Date:   Tue,  9 Apr 2019 23:20:10 +0200
Message-Id: <20190409212018.32423-9-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190409212018.32423-1-daniel@iogearbox.net>
References: <20190409212018.32423-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25414/Tue Apr  9 09:53:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Given we'll be reusing BPF array maps for global data/bss/rodata
sections, we need a way to associate BTF DataSec type as its map
value type. In usual cases we have this ugly BPF_ANNOTATE_KV_PAIR()
macro hack e.g. via 38d5d3b3d5db ("bpf: Introduce BPF_ANNOTATE_KV_PAIR")
to get initial map to type association going. While more use cases
for it are discouraged, this also won't work for global data since
the use of array map is a BPF loader detail and therefore unknown
at compilation time. For array maps with just a single entry we make
an exception in terms of BTF in that key type is declared optional
if value type is of DataSec type. The latter LLVM is guaranteed to
emit and it also aligns with how we regard global data maps as just
a plain buffer area reusing existing map facilities for allowing
things like introspection with existing tools.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/arraymap.c | 15 ++++++++++++++-
 kernel/bpf/btf.c      |  2 +-
 kernel/bpf/syscall.c  | 15 +++++++++++----
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 455d31b55828..64cdf2a23d42 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -51,6 +51,7 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
 			   u32 expected_offset, u32 expected_size);
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
+bool btf_type_is_void(const struct btf_type *t);
 
 #ifdef CONFIG_BPF_SYSCALL
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 217b10bd9f48..584636c9e2eb 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -391,7 +391,8 @@ static void array_map_seq_show_elem(struct bpf_map *map, void *key,
 		return;
 	}
 
-	seq_printf(m, "%u: ", *(u32 *)key);
+	if (map->btf_key_type_id)
+		seq_printf(m, "%u: ", *(u32 *)key);
 	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
 	seq_puts(m, "\n");
 
@@ -428,6 +429,18 @@ static int array_map_check_btf(const struct bpf_map *map,
 {
 	u32 int_data;
 
+	/* One exception for keyless BTF: .bss/.data/.rodata map */
+	if (btf_type_is_void(key_type)) {
+		if (map->map_type != BPF_MAP_TYPE_ARRAY ||
+		    map->max_entries != 1)
+			return -EINVAL;
+
+		if (BTF_INFO_KIND(value_type->info) != BTF_KIND_DATASEC)
+			return -EINVAL;
+
+		return 0;
+	}
+
 	if (BTF_INFO_KIND(key_type->info) != BTF_KIND_INT)
 		return -EINVAL;
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0cecf6bab61b..cad09858a5f2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -326,7 +326,7 @@ static bool btf_type_is_modifier(const struct btf_type *t)
 	return false;
 }
 
-static bool btf_type_is_void(const struct btf_type *t)
+bool btf_type_is_void(const struct btf_type *t)
 {
 	return t == &btf_void;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 198c9680bf0d..438199e2eca4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -504,9 +504,16 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	u32 key_size, value_size;
 	int ret = 0;
 
-	key_type = btf_type_id_size(btf, &btf_key_id, &key_size);
-	if (!key_type || key_size != map->key_size)
-		return -EINVAL;
+	/* Some maps allow key to be unspecified. */
+	if (btf_key_id) {
+		key_type = btf_type_id_size(btf, &btf_key_id, &key_size);
+		if (!key_type || key_size != map->key_size)
+			return -EINVAL;
+	} else {
+		key_type = btf_type_by_id(btf, 0);
+		if (!map->ops->map_check_btf)
+			return -EINVAL;
+	}
 
 	value_type = btf_type_id_size(btf, &btf_value_id, &value_size);
 	if (!value_type || value_size != map->value_size)
@@ -573,7 +580,7 @@ static int map_create(union bpf_attr *attr)
 	if (attr->btf_key_type_id || attr->btf_value_type_id) {
 		struct btf *btf;
 
-		if (!attr->btf_key_type_id || !attr->btf_value_type_id) {
+		if (!attr->btf_value_type_id) {
 			err = -EINVAL;
 			goto free_map_nouncharge;
 		}
-- 
2.17.1

