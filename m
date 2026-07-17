Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4E42B736;
	Fri, 17 Jul 2026 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300540; cv=none; b=sKEOFncHVIV1W//QFLJ97ZUUJrG2cqJtLxgRVdnWXEmo8G1F3YGRuTEg5eqrpfBlqOxqbetysH7WI5RaoRqNNTr033DdtGoewOuWd+ZAn2NzlAz0xW8HovH5v0KoBXj/XMHwnRnSgD7vEo0Nw7iYFq8Seo4VS+aCxhwGDHTecBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300540; c=relaxed/simple;
	bh=6nFAVA3D3J6ZoztLJM7SWjFVX081sR7eZPJ17zehnBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MciwvgISkDahaI9UwDHTK2GviagfyM0WoF63VOzR+rXmgFST7z5xQ+t2YhUyN88tZonZUooq4553ygQc0o12otH+7SNP07Lj4L5heXgzKKPxPcNzNU/9CuLddyzzM/KF8t4atB/ZaKMrc6g/HDs3ZO+9nUrQmaDxYbTtGgAhq2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7975a95281f011f1aa26b74ffac11d73-20260717
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR, SN_UNTRUSTED
	SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0f086ed1-37ff-4f49-a60c-2185133f39bf,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:0f086ed1-37ff-4f49-a60c-2185133f39bf,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:8dbf1e7266bc33d03e96b539114e43b9,BulkI
	D:2607172302087Y1J1LDM,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|865|89
	8,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7975a95281f011f1aa26b74ffac11d73-20260717
X-User: yijiangshan@kylinos.cn
Received: from lazy-pc.www.tendawifi.com [(118.251.51.53)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1298199652; Fri, 17 Jul 2026 23:02:05 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: shuah@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	paul.chaignon@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH v2] selftests: stop leaking OUTPUT into gen_mods_dir kernel builds
Date: Fri, 17 Jul 2026 23:01:50 +0800
Message-Id: <20260717150150.180824-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selftests/Makefile builds each test with OUTPUT on the make command line:

  $(MAKE) OUTPUT=$$BUILD/$$TARGET -C $$TARGET

That OUTPUT is authoritative (command-line origin) and travels through
MAKEFLAGS into every sub-make.  For tests that set TEST_GEN_MODS_DIR
(currently mm/page_frag and livepatch/test_modules) the gen_mods_dir rule
recurses into a kernel module build:

  $(MAKE) -C $(TEST_GEN_MODS_DIR)
  # -> make -C $(KDIR) M=... modules

which may in turn (re)build tools/bpf/resolve_btfids as a kernel "prepare"
dependency (CONFIG_DEBUG_INFO_BTF).  resolve_btfids derives its OUTPUT from
O= via tools/scripts/Makefile.include:

  OUTPUT := $(ABSOLUTE_O)/$(if $(subdir),$(subdir)/)

but a command-line OUTPUT inherited from kselftest overrides that
assignment, so resolve_btfids builds into the kselftest test directory.
Because that directory lacks a trailing '/', the tools/build pattern rules
$(OUTPUT)%.o are corrupted as well: ".../mmmain.o" instead of
".../mm/main.o", ending in:

  ld: cannot find .../resolve_btfids-in.o: No such file or directory

Fix this at the source of the leak: strip OUTPUT from the command-line
overrides handed to the gen_mods_dir/clean_mods_dir sub-make only.  OUTPUT,
if still present, then reaches the kernel build merely as an overridable
environment default, which the tools build overrides with its O=-derived
value (which always carries a trailing '/').  The assignment is
target-specific, so other selftest sub-makes -- and the test programs that
rely on OUTPUT -- are unaffected; selftests that build resolve_btfids
themselves with an explicit OUTPUT= (bpf, hid) do not use gen_mods_dir and
are untouched.

This supersedes the earlier attempt to normalise OUTPUT with an override in
tools/bpf/resolve_btfids/Makefile.  That override lives in the outer
resolve_btfids make and is invisible to the nested
"$(MAKE) $(build)=resolve_btfids" sub-make in which the pattern rules
actually run, so it did not fix the corruption; it also risked the
explicit-OUTPUT builds used by bpf/hid.

Reproduce the leak (before this fix), e.g. with a kernel configured for
CONFIG_DEBUG_INFO_BTF and a TEST_GEN_MODS_DIR test such as mm/page_frag:

  $ make kselftest-all
  ...
  HOSTLD  .../mmresolve_btfids-in.o
  gcc: error: .../mm/resolve_btfids-in.o: No such file or directory

Tested:
  * With a real lib.mk gen_mods_dir descent, OUTPUT no longer reaches a
    resolve_btfids-style sub-make as command-line (origin becomes
    environment); the O=-derived "OUTPUT := " assignment then wins.
  * make -C tools/bpf/resolve_btfids
    make -C tools/bpf/resolve_btfids OUTPUT=/tmp/o/resolve_btfids/
    both still build.
  * make OUTPUT=/tmp/build/kcmp -C tools/testing/selftests/kcmp still
    honours OUTPUT for its own programs.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

---
v2:
 - Reworked the fix: instead of overriding OUTPUT in
   tools/bpf/resolve_btfids/Makefile (v1), which is invisible to the
   nested "$(MAKE) $(build)=resolve_btfids" sub-make where the pattern
   rules actually run and also clobbers the explicit OUTPUT= used by
   bpf/hid, strip OUTPUT from the command-line overrides of the
   gen_mods_dir/clean_mods_dir sub-make in tools/testing/selftests/lib.mk
   so the leak is fixed at its source.
v1:
 - initial submission

 tools/testing/selftests/lib.mk | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index f02cc8a2e4ae..5345be76223a 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -142,9 +142,26 @@ else
 	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
 endif
 
+# The build of TEST_GEN_MODS_DIR recurses into the kernel build (it builds
+# out-of-tree modules via "make -C \$(KDIR) M=..."), which may in turn build
+# tools/bpf/resolve_btfids as a kernel "prepare" dependency.  That tools build
+# derives its own OUTPUT from O=, but a command-line OUTPUT inherited from here
+# (e.g. the per-test output directory that selftests/Makefile passes on its
+# command line) is authoritative and overrides that derivation, corrupting the
+# paths produced by the tools/build pattern rules (e.g. ".../mmmain.o" instead
+# of ".../mm/main.o", and a missing resolve_btfids-in.o).
+#
+# Strip OUTPUT from the command-line overrides handed to this sub-make only, so
+# it can no longer override the O=-derived value downstream.  The variable, if
+# still present, then reaches the kernel build merely as an overridable
+# environment default, which the tools build ignores in favour of its O=-derived
+# OUTPUT.  This is target-specific so that other sub-makes, which may legitimately
+# rely on the inherited OUTPUT, are unaffected.
+gen_mods_dir: MAKEOVERRIDES := $(filter-out OUTPUT=%,$(MAKEOVERRIDES))
 gen_mods_dir:
 	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR)
 
+clean_mods_dir: MAKEOVERRIDES := $(filter-out OUTPUT=%,$(MAKEOVERRIDES))
 clean_mods_dir:
 	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR) clean
 
-- 
2.25.1

