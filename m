Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8C1C10F14
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E8520663
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 13:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfDHNyN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:54:13 -0400
Received: from www62.your-server.de ([213.133.104.62]:46170 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfDHNyJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 09:54:09 -0400
Received: from [178.197.248.24] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDUio-0003io-QK; Mon, 08 Apr 2019 15:54:03 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v5 16/16] bpf, selftest: add test cases for BTF Var and DataSec
Date:   Mon,  8 Apr 2019 15:53:48 +0200
Message-Id: <b786878bdf46d0c7c7de6800a5803372ba09d62a.1554731339.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554731339.git.daniel@iogearbox.net>
References: <cover.1554731339.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25413/Mon Apr  8 09:56:28 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend test_btf with various positive and negative tests around
BTF verification of kind Var and DataSec. All passing as well:

  # ./test_btf
  [...]
  BTF raw test[4] (global data test #1): OK
  BTF raw test[5] (global data test #2): OK
  BTF raw test[6] (global data test #3): OK
  BTF raw test[7] (global data test #4, unsupported linkage): OK
  BTF raw test[8] (global data test #5, invalid var type): OK
  BTF raw test[9] (global data test #6, invalid var type (fwd type)): OK
  BTF raw test[10] (global data test #7, invalid var type (fwd type)): OK
  BTF raw test[11] (global data test #8, invalid var size): OK
  BTF raw test[12] (global data test #9, invalid var size): OK
  BTF raw test[13] (global data test #10, invalid var size): OK
  BTF raw test[14] (global data test #11, multiple section members): OK
  BTF raw test[15] (global data test #12, invalid offset): OK
  BTF raw test[16] (global data test #13, invalid offset): OK
  BTF raw test[17] (global data test #14, invalid offset): OK
  BTF raw test[18] (global data test #15, not var kind): OK
  BTF raw test[19] (global data test #16, invalid var referencing sec): OK
  BTF raw test[20] (global data test #17, invalid var referencing var): OK
  BTF raw test[21] (global data test #18, invalid var loop): OK
  BTF raw test[22] (global data test #19, invalid var referencing var): OK
  BTF raw test[23] (global data test #20, invalid ptr referencing var): OK
  BTF raw test[24] (global data test #21, var included in struct): OK
  BTF raw test[25] (global data test #22, array of var): OK
  [...]
  PASS:167 SKIP:0 FAIL:0

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/test_btf.c | 665 ++++++++++++++++++++++++++++++++-
 1 file changed, 663 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
index 5afc3f7..08010e6 100644
--- a/tools/testing/selftests/bpf/test_btf.c
+++ b/tools/testing/selftests/bpf/test_btf.c
@@ -85,6 +85,11 @@ static int __base_pr(enum libbpf_print_level level __attribute__((unused)),
 #define BTF_UNION_ENC(name, nr_elems, sz)	\
 	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_UNION, 0, nr_elems), sz)
 
+#define BTF_VAR_ENC(name, type, linkage)	\
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), type), (linkage)
+#define BTF_VAR_SECINFO_ENC(type, offset, size)	\
+	(type), (offset), (size)
+
 #define BTF_MEMBER_ENC(name, type, bits_offset)	\
 	(name), (type), (bits_offset)
 #define BTF_ENUM_ENC(name, val) (name), (val)
@@ -291,7 +296,6 @@ static struct btf_raw_test raw_tests[] = {
 	.value_type_id = 3,
 	.max_entries = 4,
 },
-
 {
 	.descr = "struct test #3 Invalid member offset",
 	.raw_types = {
@@ -319,7 +323,664 @@ static struct btf_raw_test raw_tests[] = {
 	.btf_load_err = true,
 	.err_str = "Invalid member bits_offset",
 },
-
+/*
+ * struct A {
+ *	unsigned long long m;
+ *	int n;
+ *	char o;
+ *	[3 bytes hole]
+ *	int p[8];
+ * };
+ */
+{
+	.descr = "global data test #1",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* unsigned long long */
+		BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),		/* [2] */
+		/* char */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 8, 1),	/* [3] */
+		/* int[8] */
+		BTF_TYPE_ARRAY_ENC(1, 1, 8),			/* [4] */
+		/* struct A { */				/* [5] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 4), 48),
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),	/* unsigned long long m;*/
+		BTF_MEMBER_ENC(NAME_TBD, 1, 64),/* int n;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 3, 96),/* char o;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 4, 128),/* int p[8]		*/
+		/* } */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0m\0n\0o\0p",
+	.str_sec_size = sizeof("\0A\0m\0n\0o\0p"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "struct_test1_map",
+	.key_size = sizeof(int),
+	.value_size = 48,
+	.key_type_id = 1,
+	.value_type_id = 5,
+	.max_entries = 4,
+},
+/*
+ * struct A {
+ *	unsigned long long m;
+ *	int n;
+ *	char o;
+ *	[3 bytes hole]
+ *	int p[8];
+ * };
+ * static struct A t; <- in .bss
+ */
+{
+	.descr = "global data test #2",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* unsigned long long */
+		BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),		/* [2] */
+		/* char */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 8, 1),	/* [3] */
+		/* int[8] */
+		BTF_TYPE_ARRAY_ENC(1, 1, 8),			/* [4] */
+		/* struct A { */				/* [5] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 4), 48),
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),	/* unsigned long long m;*/
+		BTF_MEMBER_ENC(NAME_TBD, 1, 64),/* int n;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 3, 96),/* char o;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 4, 128),/* int p[8]		*/
+		/* } */
+		/* static struct A t */
+		BTF_VAR_ENC(NAME_TBD, 5, 0),			/* [6] */
+		/* .bss section */				/* [7] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 48),
+		BTF_VAR_SECINFO_ENC(6, 0, 48),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0m\0n\0o\0p\0t\0.bss",
+	.str_sec_size = sizeof("\0A\0m\0n\0o\0p\0t\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 48,
+	.key_type_id = 0,
+	.value_type_id = 7,
+	.max_entries = 1,
+},
+{
+	.descr = "global data test #3",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* static int t */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
+		/* .bss section */				/* [3] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0t\0.bss",
+	.str_sec_size = sizeof("\0t\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 0,
+	.value_type_id = 3,
+	.max_entries = 1,
+},
+{
+	.descr = "global data test #4, unsupported linkage",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* static int t */
+		BTF_VAR_ENC(NAME_TBD, 1, 2),			/* [2] */
+		/* .bss section */				/* [3] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0t\0.bss",
+	.str_sec_size = sizeof("\0t\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 0,
+	.value_type_id = 3,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Linkage not supported",
+},
+{
+	.descr = "global data test #5, invalid var type",
+	.raw_types = {
+		/* static void t */
+		BTF_VAR_ENC(NAME_TBD, 0, 0),			/* [1] */
+		/* .bss section */				/* [2] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(1, 0, 4),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0t\0.bss",
+	.str_sec_size = sizeof("\0t\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 0,
+	.value_type_id = 2,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid type_id",
+},
+{
+	.descr = "global data test #6, invalid var type (fwd type)",
+	.raw_types = {
+		/* union A */
+		BTF_TYPE_ENC(NAME_TBD,
+			     BTF_INFO_ENC(BTF_KIND_FWD, 1, 0), 0), /* [1] */
+		/* static union A t */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
+		/* .bss section */				/* [3] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0t\0.bss",
+	.str_sec_size = sizeof("\0A\0t\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 0,
+	.value_type_id = 2,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid type",
+},
+{
+	.descr = "global data test #7, invalid var type (fwd type)",
+	.raw_types = {
+		/* union A */
+		BTF_TYPE_ENC(NAME_TBD,
+			     BTF_INFO_ENC(BTF_KIND_FWD, 1, 0), 0), /* [1] */
+		/* static union A t */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
+		/* .bss section */				/* [3] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(1, 0, 4),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0t\0.bss",
+	.str_sec_size = sizeof("\0A\0t\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 0,
+	.value_type_id = 2,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid type",
+},
+{
+	.descr = "global data test #8, invalid var size",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* unsigned long long */
+		BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),		/* [2] */
+		/* char */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 8, 1),	/* [3] */
+		/* int[8] */
+		BTF_TYPE_ARRAY_ENC(1, 1, 8),			/* [4] */
+		/* struct A { */				/* [5] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 4), 48),
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),	/* unsigned long long m;*/
+		BTF_MEMBER_ENC(NAME_TBD, 1, 64),/* int n;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 3, 96),/* char o;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 4, 128),/* int p[8]		*/
+		/* } */
+		/* static struct A t */
+		BTF_VAR_ENC(NAME_TBD, 5, 0),			/* [6] */
+		/* .bss section */				/* [7] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 48),
+		BTF_VAR_SECINFO_ENC(6, 0, 47),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0m\0n\0o\0p\0t\0.bss",
+	.str_sec_size = sizeof("\0A\0m\0n\0o\0p\0t\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 48,
+	.key_type_id = 0,
+	.value_type_id = 7,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid size",
+},
+{
+	.descr = "global data test #9, invalid var size",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* unsigned long long */
+		BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),		/* [2] */
+		/* char */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 8, 1),	/* [3] */
+		/* int[8] */
+		BTF_TYPE_ARRAY_ENC(1, 1, 8),			/* [4] */
+		/* struct A { */				/* [5] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 4), 48),
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),	/* unsigned long long m;*/
+		BTF_MEMBER_ENC(NAME_TBD, 1, 64),/* int n;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 3, 96),/* char o;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 4, 128),/* int p[8]		*/
+		/* } */
+		/* static struct A t */
+		BTF_VAR_ENC(NAME_TBD, 5, 0),			/* [6] */
+		/* .bss section */				/* [7] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 46),
+		BTF_VAR_SECINFO_ENC(6, 0, 48),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0m\0n\0o\0p\0t\0.bss",
+	.str_sec_size = sizeof("\0A\0m\0n\0o\0p\0t\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 48,
+	.key_type_id = 0,
+	.value_type_id = 7,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid size",
+},
+{
+	.descr = "global data test #10, invalid var size",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* unsigned long long */
+		BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),		/* [2] */
+		/* char */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 8, 1),	/* [3] */
+		/* int[8] */
+		BTF_TYPE_ARRAY_ENC(1, 1, 8),			/* [4] */
+		/* struct A { */				/* [5] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 4), 48),
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),	/* unsigned long long m;*/
+		BTF_MEMBER_ENC(NAME_TBD, 1, 64),/* int n;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 3, 96),/* char o;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 4, 128),/* int p[8]		*/
+		/* } */
+		/* static struct A t */
+		BTF_VAR_ENC(NAME_TBD, 5, 0),			/* [6] */
+		/* .bss section */				/* [7] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 46),
+		BTF_VAR_SECINFO_ENC(6, 0, 46),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0m\0n\0o\0p\0t\0.bss",
+	.str_sec_size = sizeof("\0A\0m\0n\0o\0p\0t\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 48,
+	.key_type_id = 0,
+	.value_type_id = 7,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid size",
+},
+{
+	.descr = "global data test #11, multiple section members",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* unsigned long long */
+		BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),		/* [2] */
+		/* char */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 8, 1),	/* [3] */
+		/* int[8] */
+		BTF_TYPE_ARRAY_ENC(1, 1, 8),			/* [4] */
+		/* struct A { */				/* [5] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 4), 48),
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),	/* unsigned long long m;*/
+		BTF_MEMBER_ENC(NAME_TBD, 1, 64),/* int n;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 3, 96),/* char o;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 4, 128),/* int p[8]		*/
+		/* } */
+		/* static struct A t */
+		BTF_VAR_ENC(NAME_TBD, 5, 0),			/* [6] */
+		/* static int u */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [7] */
+		/* .bss section */				/* [8] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 2), 62),
+		BTF_VAR_SECINFO_ENC(6, 10, 48),
+		BTF_VAR_SECINFO_ENC(7, 58, 4),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0m\0n\0o\0p\0t\0u\0.bss",
+	.str_sec_size = sizeof("\0A\0m\0n\0o\0p\0t\0u\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 62,
+	.key_type_id = 0,
+	.value_type_id = 8,
+	.max_entries = 1,
+},
+{
+	.descr = "global data test #12, invalid offset",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* unsigned long long */
+		BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),		/* [2] */
+		/* char */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 8, 1),	/* [3] */
+		/* int[8] */
+		BTF_TYPE_ARRAY_ENC(1, 1, 8),			/* [4] */
+		/* struct A { */				/* [5] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 4), 48),
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),	/* unsigned long long m;*/
+		BTF_MEMBER_ENC(NAME_TBD, 1, 64),/* int n;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 3, 96),/* char o;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 4, 128),/* int p[8]		*/
+		/* } */
+		/* static struct A t */
+		BTF_VAR_ENC(NAME_TBD, 5, 0),			/* [6] */
+		/* static int u */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [7] */
+		/* .bss section */				/* [8] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 2), 62),
+		BTF_VAR_SECINFO_ENC(6, 10, 48),
+		BTF_VAR_SECINFO_ENC(7, 60, 4),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0m\0n\0o\0p\0t\0u\0.bss",
+	.str_sec_size = sizeof("\0A\0m\0n\0o\0p\0t\0u\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 62,
+	.key_type_id = 0,
+	.value_type_id = 8,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid offset+size",
+},
+{
+	.descr = "global data test #13, invalid offset",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* unsigned long long */
+		BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),		/* [2] */
+		/* char */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 8, 1),	/* [3] */
+		/* int[8] */
+		BTF_TYPE_ARRAY_ENC(1, 1, 8),			/* [4] */
+		/* struct A { */				/* [5] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 4), 48),
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),	/* unsigned long long m;*/
+		BTF_MEMBER_ENC(NAME_TBD, 1, 64),/* int n;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 3, 96),/* char o;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 4, 128),/* int p[8]		*/
+		/* } */
+		/* static struct A t */
+		BTF_VAR_ENC(NAME_TBD, 5, 0),			/* [6] */
+		/* static int u */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [7] */
+		/* .bss section */				/* [8] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 2), 62),
+		BTF_VAR_SECINFO_ENC(6, 10, 48),
+		BTF_VAR_SECINFO_ENC(7, 12, 4),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0m\0n\0o\0p\0t\0u\0.bss",
+	.str_sec_size = sizeof("\0A\0m\0n\0o\0p\0t\0u\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 62,
+	.key_type_id = 0,
+	.value_type_id = 8,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid offset",
+},
+{
+	.descr = "global data test #14, invalid offset",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* unsigned long long */
+		BTF_TYPE_INT_ENC(0, 0, 0, 64, 8),		/* [2] */
+		/* char */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 8, 1),	/* [3] */
+		/* int[8] */
+		BTF_TYPE_ARRAY_ENC(1, 1, 8),			/* [4] */
+		/* struct A { */				/* [5] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 4), 48),
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),	/* unsigned long long m;*/
+		BTF_MEMBER_ENC(NAME_TBD, 1, 64),/* int n;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 3, 96),/* char o;		*/
+		BTF_MEMBER_ENC(NAME_TBD, 4, 128),/* int p[8]		*/
+		/* } */
+		/* static struct A t */
+		BTF_VAR_ENC(NAME_TBD, 5, 0),			/* [6] */
+		/* static int u */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [7] */
+		/* .bss section */				/* [8] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 2), 62),
+		BTF_VAR_SECINFO_ENC(7, 58, 4),
+		BTF_VAR_SECINFO_ENC(6, 10, 48),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0m\0n\0o\0p\0t\0u\0.bss",
+	.str_sec_size = sizeof("\0A\0m\0n\0o\0p\0t\0u\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 62,
+	.key_type_id = 0,
+	.value_type_id = 8,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid offset",
+},
+{
+	.descr = "global data test #15, not var kind",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
+		/* .bss section */				/* [3] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(1, 0, 4),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0t\0.bss",
+	.str_sec_size = sizeof("\0A\0t\0.bss"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 0,
+	.value_type_id = 3,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Not a VAR kind member",
+},
+{
+	.descr = "global data test #16, invalid var referencing sec",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 5, 0),			/* [2] */
+		BTF_VAR_ENC(NAME_TBD, 2, 0),			/* [3] */
+		/* a section */					/* [4] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(3, 0, 4),
+		/* a section */					/* [5] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(6, 0, 4),
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [6] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0t\0s\0a\0a",
+	.str_sec_size = sizeof("\0A\0t\0s\0a\0a"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 0,
+	.value_type_id = 4,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid type_id",
+},
+{
+	.descr = "global data test #17, invalid var referencing var",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [2] */
+		BTF_VAR_ENC(NAME_TBD, 2, 0),			/* [3] */
+		/* a section */					/* [4] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(3, 0, 4),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0t\0s\0a\0a",
+	.str_sec_size = sizeof("\0A\0t\0s\0a\0a"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 0,
+	.value_type_id = 4,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid type_id",
+},
+{
+	.descr = "global data test #18, invalid var loop",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 2, 0),			/* [2] */
+		/* .bss section */				/* [3] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0t\0aaa",
+	.str_sec_size = sizeof("\0A\0t\0aaa"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 0,
+	.value_type_id = 4,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid type_id",
+},
+{
+	.descr = "global data test #19, invalid var referencing var",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_VAR_ENC(NAME_TBD, 3, 0),			/* [2] */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [3] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0t\0s\0a\0a",
+	.str_sec_size = sizeof("\0A\0t\0s\0a\0a"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 0,
+	.value_type_id = 4,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid type_id",
+},
+{
+	.descr = "global data test #20, invalid ptr referencing var",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* PTR type_id=3	*/			/* [2] */
+		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 3),
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [3] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0t\0s\0a\0a",
+	.str_sec_size = sizeof("\0A\0t\0s\0a\0a"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 0,
+	.value_type_id = 4,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid type_id",
+},
+{
+	.descr = "global data test #21, var included in struct",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		/* struct A { */				/* [2] */
+		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 2), sizeof(int) * 2),
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),	/* int m; */
+		BTF_MEMBER_ENC(NAME_TBD, 3, 32),/* VAR type_id=3; */
+		/* } */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [3] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0t\0s\0a\0a",
+	.str_sec_size = sizeof("\0A\0t\0s\0a\0a"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 0,
+	.value_type_id = 4,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid member",
+},
+{
+	.descr = "global data test #22, array of var",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_ARRAY_ENC(3, 1, 4),			/* [2] */
+		BTF_VAR_ENC(NAME_TBD, 1, 0),			/* [3] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0A\0t\0s\0a\0a",
+	.str_sec_size = sizeof("\0A\0t\0s\0a\0a"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = ".bss",
+	.key_size = sizeof(int),
+	.value_size = 4,
+	.key_type_id = 0,
+	.value_type_id = 4,
+	.max_entries = 1,
+	.btf_load_err = true,
+	.err_str = "Invalid elem",
+},
 /* Test member exceeds the size of struct.
  *
  * struct A {
-- 
2.9.5

