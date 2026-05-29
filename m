Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB7F367F5F;
	Fri, 29 May 2026 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024659; cv=none; b=dF6MBwP+VN8j1SDI1U9rDyvc/7/F5HuKAwnr1UeVaM+Gjcu2LZQoyacjAhiw5BcKs+dUKEGVEUXF/EZ6voq0LmLUzUSBbmOcRHkh9JxM1OD/YIdFu9+qYTrtfD4IVHcsm1ihoCskD3Bd89GR2xbyeGTbvzPuARTT2p2gqkpVuY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024659; c=relaxed/simple;
	bh=xQ2OkSs8riTHwHt2or05rVMp1SXSKQg2BtIKfLkEWWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7ixPvuzmIsITnu0Kp1HAWZyk8T+anWC9iTYAIBECI7GkgUI+CxtRM5E1VNtSOOdE/mWfLVNmipC3c0uS0jLkKnaaEujvFTqxNo+aZUtBDJQ22o6i6D3vQrnw5M75VvFaRcYd9pEHBcb2Kd1tgYDT6067Rb9uAn+aQeW5FVYwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pNH33B5v; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pNH33B5v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=pB
	UYS5/1hD1njZ+SRg/h+C/eOlx8ep4fSlGa9e+pEQA=; b=pNH33B5vVmXFFWLeIE
	wvWUlh41w4t8Y1IlRGhw8ZSRzyBmFt4kk6r5TFkW+lSRV7NflHvlAdWxX7Yj0xku
	0j/F2cH6Ml9MT/yf34aIrLoM2DxIOfLips8mWBnTgfHUk/nUJo++dWkisDzyyiZt
	qOtmzIe/13tn3WXDnvibO3gkM=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3vwD_BBlq5RfOAA--.34835S2;
	Fri, 29 May 2026 11:16:15 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH] selftests/bpf: fix token tests for bpf_object__prepare() probe_loading
Date: Fri, 29 May 2026 11:16:04 +0800
Message-ID: <20260529031604.888137-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vwD_BBlq5RfOAA--.34835S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar4rJFWxtF43ur4rJFWxXrb_yoWxWr4Upr
	1vga9rtw1UJFWUJr40qay7ur9YkF4jyF1UKFnIvw1UZFsFvrs5tF1qv34vywnIqrW5Gr9I
	v3WY9rn7ZFyruF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrkucUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQAi32oZBQC6VAAA3k

From: Yuan Chen <chenyuan@kylinos.cn>

The bpf_object__prepare() function internally calls bpf_object__probe_loading(),
which attempts to load SOCKET_FILTER and TRACEPOINT programs to verify the BPF
environment. Without these permissions in the token, the probe fails and causes
the tests to fail.

Fix the following test cases by adding SOCKET_FILTER and TRACEPOINT permissions:
- obj_priv_map
- obj_priv_prog
- obj_priv_freplace_prog
- obj_priv_freplace_prog_fail
- obj_priv_btf_fail
- obj_priv_btf_success
- obj_priv_implicit_token
- obj_priv_implicit_token_envvar
- obj_priv_prog_kallsyms

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 68 ++++++++++++++-----
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index f2f5d36ae00a..25a76e09a3c9 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -1168,8 +1168,13 @@ void serial_test_token(void)
 	}
 	if (test__start_subtest("obj_priv_map")) {
 		struct bpffs_opts opts = {
-			.cmds = bit(BPF_MAP_CREATE),
+			/* BPF_PROG_LOAD is needed for bpf_object__probe_loading */
+			.cmds = bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
 			.maps = bit(BPF_MAP_TYPE_QUEUE),
+			/* Allow SOCKET_FILTER and TRACEPOINT for bpf_object__probe_loading */
+			.progs = bit(BPF_PROG_TYPE_SOCKET_FILTER) |
+					 bit(BPF_PROG_TYPE_TRACEPOINT),
+			.attachs = ~0ULL,
 		};
 
 		subtest_userns(&opts, userns_obj_priv_map);
@@ -1177,7 +1182,10 @@ void serial_test_token(void)
 	if (test__start_subtest("obj_priv_prog")) {
 		struct bpffs_opts opts = {
 			.cmds = bit(BPF_PROG_LOAD),
-			.progs = bit(BPF_PROG_TYPE_XDP),
+			/* Allow SOCKET_FILTER and TRACEPOINT for bpf_object__probe_loading */
+			.progs = bit(BPF_PROG_TYPE_XDP) |
+					 bit(BPF_PROG_TYPE_SOCKET_FILTER) |
+					 bit(BPF_PROG_TYPE_TRACEPOINT),
 			.attachs = ~0ULL,
 		};
 
@@ -1185,16 +1193,24 @@ void serial_test_token(void)
 	}
 	if (test__start_subtest("obj_priv_freplace_prog")) {
 		struct bpffs_opts opts = {
-			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD) | bit(BPF_BTF_GET_FD_BY_ID),
-			.progs = bit(BPF_PROG_TYPE_EXT) | bit(BPF_PROG_TYPE_XDP),
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD) |
+					bit(BPF_BTF_GET_FD_BY_ID),
+			/* Allow SOCKET_FILTER and TRACEPOINT for bpf_object__probe_loading */
+			.progs = bit(BPF_PROG_TYPE_EXT) | bit(BPF_PROG_TYPE_XDP) |
+					 bit(BPF_PROG_TYPE_SOCKET_FILTER) |
+					 bit(BPF_PROG_TYPE_TRACEPOINT),
 			.attachs = ~0ULL,
 		};
 		subtest_userns(&opts, userns_obj_priv_freplace_prog);
 	}
 	if (test__start_subtest("obj_priv_freplace_prog_fail")) {
 		struct bpffs_opts opts = {
-			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD) | bit(BPF_BTF_GET_FD_BY_ID),
-			.progs = bit(BPF_PROG_TYPE_EXT) | bit(BPF_PROG_TYPE_XDP),
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD) |
+					bit(BPF_BTF_GET_FD_BY_ID),
+			/* Allow SOCKET_FILTER and TRACEPOINT for bpf_object__probe_loading */
+			.progs = bit(BPF_PROG_TYPE_EXT) | bit(BPF_PROG_TYPE_XDP) |
+					 bit(BPF_PROG_TYPE_SOCKET_FILTER) |
+					 bit(BPF_PROG_TYPE_TRACEPOINT),
 			.attachs = ~0ULL,
 		};
 		subtest_userns(&opts, userns_obj_priv_freplace_prog_fail);
@@ -1204,7 +1220,10 @@ void serial_test_token(void)
 			/* disallow BTF loading */
 			.cmds = bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
 			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS),
-			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS),
+			/* Allow SOCKET_FILTER and TRACEPOINT for bpf_object__probe_loading */
+			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS) |
+					 bit(BPF_PROG_TYPE_SOCKET_FILTER) |
+					 bit(BPF_PROG_TYPE_TRACEPOINT),
 			.attachs = ~0ULL,
 		};
 
@@ -1213,9 +1232,13 @@ void serial_test_token(void)
 	if (test__start_subtest("obj_priv_btf_success")) {
 		struct bpffs_opts opts = {
 			/* allow BTF loading */
-			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
-			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS),
-			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS),
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) |
+					bit(BPF_PROG_LOAD),
+			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS) | bit(BPF_MAP_TYPE_ARRAY),
+			/* Allow SOCKET_FILTER and TRACEPOINT for bpf_object__probe_loading */
+			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS) |
+					 bit(BPF_PROG_TYPE_SOCKET_FILTER) |
+					 bit(BPF_PROG_TYPE_TRACEPOINT),
 			.attachs = ~0ULL,
 		};
 
@@ -1224,9 +1247,13 @@ void serial_test_token(void)
 	if (test__start_subtest("obj_priv_implicit_token")) {
 		struct bpffs_opts opts = {
 			/* allow BTF loading */
-			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
-			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS),
-			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS),
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) |
+					bit(BPF_PROG_LOAD),
+			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS) | bit(BPF_MAP_TYPE_ARRAY),
+			/* Allow SOCKET_FILTER and TRACEPOINT for bpf_object__probe_loading */
+			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS) |
+					 bit(BPF_PROG_TYPE_SOCKET_FILTER) |
+					 bit(BPF_PROG_TYPE_TRACEPOINT),
 			.attachs = ~0ULL,
 		};
 
@@ -1235,9 +1262,13 @@ void serial_test_token(void)
 	if (test__start_subtest("obj_priv_implicit_token_envvar")) {
 		struct bpffs_opts opts = {
 			/* allow BTF loading */
-			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) | bit(BPF_PROG_LOAD),
-			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS),
-			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS),
+			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_MAP_CREATE) |
+					bit(BPF_PROG_LOAD),
+			.maps = bit(BPF_MAP_TYPE_STRUCT_OPS) | bit(BPF_MAP_TYPE_ARRAY),
+			/* Allow SOCKET_FILTER and TRACEPOINT for bpf_object__probe_loading */
+			.progs = bit(BPF_PROG_TYPE_STRUCT_OPS) |
+					 bit(BPF_PROG_TYPE_SOCKET_FILTER) |
+					 bit(BPF_PROG_TYPE_TRACEPOINT),
 			.attachs = ~0ULL,
 		};
 
@@ -1257,7 +1288,10 @@ void serial_test_token(void)
 		char kptr_restrict_orig[32] = {};
 		struct bpffs_opts opts = {
 			.cmds = bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD),
-			.progs = bit(BPF_PROG_TYPE_XDP),
+			/* Allow SOCKET_FILTER and TRACEPOINT for bpf_object__probe_loading */
+			.progs = bit(BPF_PROG_TYPE_XDP) |
+					 bit(BPF_PROG_TYPE_SOCKET_FILTER) |
+					 bit(BPF_PROG_TYPE_TRACEPOINT),
 			.attachs = ~0ULL,
 		};
 
-- 
2.54.0

