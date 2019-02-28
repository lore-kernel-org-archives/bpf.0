Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E367C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D4720663
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfB1XTJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:19:09 -0500
Received: from www62.your-server.de ([213.133.104.62]:52340 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbfB1XTJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 18:19:09 -0500
Received: from [178.197.248.21] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzUxE-0000mB-8q; Fri, 01 Mar 2019 00:19:04 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, joe@wand.net.nz,
        john.fastabend@gmail.com, tgraf@suug.ch, yhs@fb.com,
        andriin@fb.com, jakub.kicinski@netronome.com, lmb@cloudflare.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 4/7] bpf, libbpf: refactor relocation handling
Date:   Fri,  1 Mar 2019 00:18:26 +0100
Message-Id: <20190228231829.11993-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190228231829.11993-1-daniel@iogearbox.net>
References: <20190228231829.11993-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
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
---
 tools/lib/bpf/libbpf.c | 62 ++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b38dcbe7460a..8f8f688f3e9b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -851,20 +851,20 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
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
@@ -1026,24 +1026,26 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
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
@@ -1405,7 +1407,7 @@ bpf_program__relocate(struct bpf_program *prog, struct bpf_object *obj)
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

