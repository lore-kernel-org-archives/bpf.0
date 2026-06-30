Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34C1FCFFC;
	Tue, 30 Jun 2026 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782807453; cv=none; b=egKnihbRPsUHAbE4NJgX2l8i4ETMeyC2Q79cx9SMy3eIpoiVkF+szFxxRkYrIYvVh+wMfeINdMc6faJRr3z9VVcaJoSPuphNdBZmOp8Ev1uujcdwkCyMIj+YgsNBIykvwaQ8lH1SURrUCCRLib2KtEPzOF3RY082jHBzFlym0e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782807453; c=relaxed/simple;
	bh=MpuoeFiYRUru7+IN7NYrK85QzexMC7TplV+axDwaRSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWLGWcJdzB4OjYcM5PglAKWZgK2Ws3pdLxVj+L+pidEGJhgI21W3aA34aMdLTsSdDpTJDLpfvEzl6wet+ML/tJ1wfCtA+0ryxkLQ2D9/mDBCuqERr2nsrHRQBd5ufwmLQ5VKf0CuTFghzgtrHIG646XJqTEkKOTrqQYGCTvxjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1fc6a48e745c11f1aa26b74ffac11d73-20260630
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:cfb2ea10-322a-43ce-b860-0fe983f407ea,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:be54bdaf2cb40a74572f806b68361e9c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|123|850|865|898,TC:nil,Content
	:0|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1fc6a48e745c11f1aa26b74ffac11d73-20260630
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1271888801; Tue, 30 Jun 2026 16:17:24 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH v2] tools/sched_ext: use btf_vlen() helper in compat.h
Date: Tue, 30 Jun 2026 16:17:20 +0800
Message-Id: <20260630081720.3081733-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260630031246.2618216-1-luoliang@kylinos.cn>
References: <20260630031246.2618216-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luoliang <luoliang@kylinos.cn>

__COMPAT_read_enum() and __COMPAT_struct_has_field() open-code the
vlen lookup via the raw BTF_INFO_VLEN(t->info) UAPI macro. libbpf
exposes btf_vlen() for exactly this purpose; use it in the three
call sites, matching the pattern in kernel/bpf/inode.c and
tools/bpf/bpftool.

btf_vlen() returns __u32 (since commit cacd6729c0923, "libbpf:
Adjust btf_vlen() to return a __u32", which expanded the BTF vlen
field from 16 to 24 bits). Declare the loop counters as __u32 to
match the return type, keeping the comparison as a plain
'__u32 < __u32' and silencing the -Wsign-compare warnings.

No functional change.

Suggested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Liang Luo <luoliang@kylinos.cn>

---

Changes in v2:
- Correct the commit message: btf_vlen() returns __u32 (not __u16)
  on mainline since cacd6729c0923. The v1 description was accurate
  only on a v7.1 baseline. (Thanks to Sashiko AI review and Andrea
  Righi for catching this.)
- Declare the loop counters as __u32 to match btf_vlen()'s return
  type, as suggested by Andrea Righi. This properly silences
  -Wsign-compare on mainline.
---
 tools/sched_ext/include/scx/compat.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 602f07061ee3..23d9ef3e4c9d 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -28,7 +28,7 @@ static inline bool __COMPAT_read_enum(const char *type, const char *name, u64 *v
 	const struct btf_type *t;
 	const char *n;
 	s32 tid;
-	int i;
+	__u32 i;
 
 	__COMPAT_load_vmlinux_btf();
 
@@ -42,7 +42,7 @@ static inline bool __COMPAT_read_enum(const char *type, const char *name, u64 *v
 	if (btf_is_enum(t)) {
 		struct btf_enum *e = btf_enum(t);
 
-		for (i = 0; i < BTF_INFO_VLEN(t->info); i++) {
+		for (i = 0; i < btf_vlen(t); i++) {
 			n = btf__name_by_offset(__COMPAT_vmlinux_btf, e[i].name_off);
 			SCX_BUG_ON(!n, "btf__name_by_offset()");
 			if (!strcmp(n, name)) {
@@ -53,7 +53,7 @@ static inline bool __COMPAT_read_enum(const char *type, const char *name, u64 *v
 	} else if (btf_is_enum64(t)) {
 		struct btf_enum64 *e = btf_enum64(t);
 
-		for (i = 0; i < BTF_INFO_VLEN(t->info); i++) {
+		for (i = 0; i < btf_vlen(t); i++) {
 			n = btf__name_by_offset(__COMPAT_vmlinux_btf, e[i].name_off);
 			SCX_BUG_ON(!n, "btf__name_by_offset()");
 			if (!strcmp(n, name)) {
@@ -85,7 +85,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 	const struct btf_member *m;
 	const char *n;
 	s32 tid;
-	int i;
+	__u32 i;
 
 	__COMPAT_load_vmlinux_btf();
 	tid = btf__find_by_name_kind(__COMPAT_vmlinux_btf, type, BTF_KIND_STRUCT);
@@ -97,7 +97,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 
 	m = btf_members(t);
 
-	for (i = 0; i < BTF_INFO_VLEN(t->info); i++) {
+	for (i = 0; i < btf_vlen(t); i++) {
 		n = btf__name_by_offset(__COMPAT_vmlinux_btf, m[i].name_off);
 		SCX_BUG_ON(!n, "btf__name_by_offset()");
 			if (!strcmp(n, field))
-- 
2.43.0

