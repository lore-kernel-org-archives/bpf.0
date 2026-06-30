Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C62264617;
	Tue, 30 Jun 2026 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789183; cv=none; b=cQztp5//kcw/ZClhWStSm+d6103fjORCO/BYwu5hTqQ/ylwAJwN6afee9Q5Slly4xfdZTZ8sXNOuhPKhX6QQgyw8OTYCekQiWw1U7NoEzdtKvNp1MGpgX/GCjINQsxUCdYB1mJcL5qxQOqftygFTgrgG4ifjsEa6WVbAjR8+Vjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789183; c=relaxed/simple;
	bh=/gjzEm9ltNohmq6N/JYDwBx5hXvsLgmkU42gn6o4lhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cWg8+op6Vq/ygtCXXP31sKGcIa4I6Z0LbXY0Ho50JgKsDV5FidOl8zHDofLUp9CXKeYqR53S5srOtYB6XWtHbShrRvF22rkiQNSfBeQav7QxxnOAr6jmOC9Tf2Ctxstd6RPGySSTKa9vIyqmdXNGEySqAjqLAo4RthILN3ZMCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 94166692743111f1aa26b74ffac11d73-20260630
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:65eb45f9-2d48-46f7-9c6b-e8dad5cd176a,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:24d84fac57e3adc4c16301e1f1b049b9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 94166692743111f1aa26b74ffac11d73-20260630
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1777881677; Tue, 30 Jun 2026 11:12:51 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] tools/sched_ext: use btf_vlen() helper in compat.h
Date: Tue, 30 Jun 2026 11:12:46 +0800
Message-Id: <20260630031246.2618216-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luoliang <luoliang@kylinos.cn>

__COMPAT_read_enum() and __COMPAT_struct_has_field() open-code the
vlen lookup via the raw BTF_INFO_VLEN(t->info) UAPI macro, whose
result type is __u32 (t->info is __u32 and 0xffff is promoted to
unsigned). Comparing it against the int loop counter triggers
-Wsign-compare in every example scheduler that includes compat.h.

libbpf already exposes btf_vlen() for exactly this purpose; it
returns __u16, the natural width of the vlen field, and the usual
integer promotions turn the 'int < __u16' comparison into a plain
'int < int' so the warning goes away without any cast. This matches
the pattern already used in-kernel (e.g. kernel/bpf/inode.c) and in
tools/bpf/bpftool. Replace the three open-coded lookups with
btf_vlen(t). No functional change.

Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 tools/sched_ext/include/scx/compat.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 039854c490d5..df5ca1ce20f6 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
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
@@ -97,7 +97,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 
 	m = btf_members(t);
 
-	for (i = 0; i < BTF_INFO_VLEN(t->info); i++) {
+	for (i = 0; i < btf_vlen(t); i++) {
 		n = btf__name_by_offset(__COMPAT_vmlinux_btf, m[i].name_off);
 		SCX_BUG_ON(!n, "btf__name_by_offset()");
 			if (!strcmp(n, field))
-- 
2.43.0

