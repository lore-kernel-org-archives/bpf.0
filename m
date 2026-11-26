Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672410;
	b=10XojXp+hLOIYgCjFISt7eKy7JR4hISWy8KDkRVIBosUrpYAdYfSrnh/daGemnD38Qht
	 g+7sWciFiispUxybLRbwBuICCoula1L9S1F4NIOSgx+JCRL7Wxaa0ecGDI+5umsdCnWee
	 /Algm4mwBjuBYOcMk8y7y4ObHgiWIKm2mtsw0TNN5WOlQ4qeZTJmkdOZWUtnhJuQ8PUB9
	 1cCuPIpGxqaHfPizv5wCTnvD83BuMQGdXEJFLiQbv/un2gQ1GkfzbBARFg0dqSjcOPogs
	 UZl4AbwwOG9g4mTP2Pt/uREBlcOW3IiM/LIg36UYOJ16XfPSSqVyi4hDo2ia8LQuTHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672410;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ra7LaUQ9JUQBkxGCXeGWTiweCdwL+ozh23gAP3eLfVw=;
	b=NjjvpjwIb6v01ntAkR+TwCNoS4Kyj1Jvd4pV81DsRg6hpXyOIt3f1zJhh+iW0y8NHpB3
	 wRTffq9x95tnC5XLpeOGGk/8skm2Rpv/iqDOzmPJWrlgRFyRM7XHBvnL9npt56r1ue7Ec
	 TqT5UvHq4IWZOY+Gb5Fgj3HAP9NG15zamDkrIsCzwv5eUJFbylGA4kYY7vDtev4As76/C
	 NV7n6bIBlXBAt3o+BTrIwky0bnKahjvU/W04/DZFmAvMefVtmSybS9sSEtXuFoFHQZLWT
	 wMpWfr/10m+B/WVAEFr+dDF/KAjvTD2+U4n3XbDIx1qpoEgqiB03TqcjUy6Bb0+JtiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E396A606A31E;
	Thu, 26 Nov 2026 05:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E396A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b06cbcdce95d11f19a56ed5b684f684d-20261126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:452bdda6-a909-41fa-8d32-ec859bd9b39b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:80195e9552410481c2bffcb4d680bff0,BulkI
	D:nil,BulkQuantity:0,SF:102|136|865|898,TC:nil,Content:0|15|50|99|100|102|
	155,EDM:-3|-100,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b06cbcdce95d11f19a56ed5b684f684d-20261126
X-User: sunshaojie@kylinos.cn
Received: from sunshaojie-pc [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1764309833; Thu, 26 Nov 2026 13:53:22 +0800
From: Shaojie Sun <sunshaojie@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Shaojie Sun <sunshaojie@kylinos.cn>
Subject: [PATCH] tools/sched_ext: Document clang requirement for arena schedulers
Date: Thu, 26 Nov 2026 13:53:01 +0800
Message-ID: <20261126055301.652002-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Schedulers that use BPF arena (address space 1), such as scx_qmap, only
load correctly when built with clang 22 or newer.  Older compilers do not
insert addr_space_cast around inlined memory intrinsics (llvm.memset(),
llvm.memcpy(), ...) on arena pointers, so the verifier may reject the
program with "invalid mem access 'scalar'".  LLVM fixed this in 22:
"[BPF] Handle certain mem intrinsic functions with addr-space arguments".

Mention the requirement in the toolchain dependency list and add a load
failure entry with the characteristic libbpf error, so that users can
tell it apart from other load failures.

Signed-off-by: Shaojie Sun <sunshaojie@kylinos.cn>
---
 tools/sched_ext/README.md | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
index 0ee5a3d997e5..10d767f3a7c6 100644
--- a/tools/sched_ext/README.md
+++ b/tools/sched_ext/README.md
@@ -33,6 +33,9 @@ is actively working on adding a BPF backend compiler as well, but are still
 missing some features such as BTF type tags which are necessary for using
 kptrs.
 
+Schedulers that use BPF arena (address space 1) need clang 22 or newer. See
+the [troubleshooting entry](#bpf-arena-schedulers-require-clang-22).
+
 2. pahole >= 1.25
 
 You may need pahole in order to generate BTF from DWARF.
@@ -246,6 +249,32 @@ In order to resolve this, please follow the steps above in
 [Getting a vmlinux.h file](#getting-a-vmlinuxh-file) in order to ensure your
 schedulers are using a vmlinux.h file that includes the requisite types.
 
+## Load Failures
+
+### BPF arena schedulers require clang 22
+
+Schedulers that use BPF arena (address space 1), such as `scx_qmap`, need
+clang 22 or newer. With older compilers the program may be rejected by the
+verifier, for example:
+
+```
+libbpf: prog 'qmap_dequeue': BPF program load failed: -EACCES
+...
+R7 invalid mem access 'scalar'
+...
+libbpf: failed to load object 'scx_qmap'
+```
+
+The register number varies with the program. Clang older than 22 does not
+insert `addr_space_cast` around inlined memory intrinsics (`llvm.memset()`,
+`llvm.memcpy()`, ...) on arena pointers, so the verifier sees a plain scalar
+being dereferenced. This was fixed in LLVM 22 ("[BPF] Handle certain mem
+intrinsic functions with addr-space arguments"):
+https://github.com/llvm/llvm-project/commit/94f290fffd80bd7c7d65db1df78cdacab633aab4
+
+Rebuild the scheduler with a sufficiently new clang; run `make clean` in this
+directory first if the object files were built with an older compiler.
+
 ## Misc
 
 ### llvm: [OFF]
-- 
2.50.1

