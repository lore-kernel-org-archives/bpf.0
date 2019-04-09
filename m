Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73ACC282DE
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 21:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC5020857
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 21:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDIVVD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:21:03 -0400
Received: from www62.your-server.de ([213.133.104.62]:52074 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfDIVUj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 17:20:39 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDyAT-0001db-LB; Tue, 09 Apr 2019 23:20:33 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com,
        jannh@google.com, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v6 10/16] bpf, libbpf: refactor relocation handling
Date:   Tue,  9 Apr 2019 23:20:12 +0200
Message-Id: <20190409212018.32423-11-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190409212018.32423-1-daniel@iogearbox.net>
References: <20190409212018.32423-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25414/Tue Apr  9 09:53:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joe Stringer <joe@wand.net.nz>

Adjust the code for relocations slightly with no functional changes,
so that upcoming patches that will introduce support for relocations
into the .data, .rodata and .bss sections can be added independent
of these changes.

Signed-off-by: Joe Stringer <joe@wand.net.nz>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/lib/bpf/libbpf.c | 62 ++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1ebfe7943d53..6dba0f01673b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -871,20 +871,20 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
 				obj->efile.symbols = data;
 				obj->efile.strtabidx = sh.sh_link;
 			}
-		} else if ((sh.sh_type == SHT_PROGBITS) &&
-			   (sh.sh_flags & SHF_EXECINSTR) &&
-			   (data->d_size > 0)) {
-			if (strcmp(name, ".text") == 0)
-				obj->efile.text_shndx = idx;
-			err = bpf_object__add_program(obj, data->d_buf,
-						      data->d_size, name, idx);
-			if (err) {
-				char errmsg[STRERR_BUFSIZE];
-				char *cp = libbpf_strerror_r(-err, errmsg,
-							     sizeof(errmsg));
-
-				pr_warning("failed to alloc program %s (%s): %s",
-					   name, obj->path, cp);
+		} else if (sh.sh_type == SHT_PROGBITS && data->d_size > 0) {
+			if (sh.sh_flags & SHF_EXECINSTR) {
+				if (strcmp(name, ".text") == 0)
+					obj->efile.text_shndx = idx;
+				err = bpf_object__add_program(obj, data->d_buf,
+							      data->d_size, name, idx);
+				if (err) {
+					char errmsg[STRERR_BUFSIZE];
+					char *cp = libbpf_strerror_r(-err, errmsg,
+								     sizeof(errmsg));
+
+					pr_warning("failed to alloc program %s (%s): %s",
+						   name, obj->path, cp);
+				}
 			}
 		} else if (sh.sh_type == SHT_REL) {
 			void *reloc = obj->efile.reloc;
@@ -1046,24 +1046,26 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
 			return -LIBBPF_ERRNO__RELOC;
 		}
 
-		/* TODO: 'maps' is sorted. We can use bsearch to make it faster. */
-		for (map_idx = 0; map_idx < nr_maps; map_idx++) {
-			if (maps[map_idx].offset == sym.st_value) {
-				pr_debug("relocation: find map %zd (%s) for insn %u\n",
-					 map_idx, maps[map_idx].name, insn_idx);
-				break;
+		if (sym.st_shndx == maps_shndx) {
+			/* TODO: 'maps' is sorted. We can use bsearch to make it faster. */
+			for (map_idx = 0; map_idx < nr_maps; map_idx++) {
+				if (maps[map_idx].offset == sym.st_value) {
+					pr_debug("relocation: find map %zd (%s) for insn %u\n",
+						 map_idx, maps[map_idx].name, insn_idx);
+					break;
+				}
 			}
-		}
 
-		if (map_idx >= nr_maps) {
-			pr_warning("bpf relocation: map_idx %d large than %d\n",
-				   (int)map_idx, (int)nr_maps - 1);
-			return -LIBBPF_ERRNO__RELOC;
-		}
+			if (map_idx >= nr_maps) {
+				pr_warning("bpf relocation: map_idx %d large than %d\n",
+					   (int)map_idx, (int)nr_maps - 1);
+				return -LIBBPF_ERRNO__RELOC;
+			}
 
-		prog->reloc_desc[i].type = RELO_LD64;
-		prog->reloc_desc[i].insn_idx = insn_idx;
-		prog->reloc_desc[i].map_idx = map_idx;
+			prog->reloc_desc[i].type = RELO_LD64;
+			prog->reloc_desc[i].insn_idx = insn_idx;
+			prog->reloc_desc[i].map_idx = map_idx;
+		}
 	}
 	return 0;
 }
@@ -1425,7 +1427,7 @@ bpf_program__relocate(struct bpf_program *prog, struct bpf_object *obj)
 			}
 			insns[insn_idx].src_reg = BPF_PSEUDO_MAP_FD;
 			insns[insn_idx].imm = obj->maps[map_idx].fd;
-		} else {
+		} else if (prog->reloc_desc[i].type == RELO_CALL) {
 			err = bpf_program__reloc_text(prog, obj,
 						      &prog->reloc_desc[i]);
 			if (err)
-- 
2.17.1

