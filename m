Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168202;
	b=Ho5AoF10KaAaRKt8ZVirxuw5s3vVSztYZTcr/eVEE1OcP32p+bPZS4/XZ3xmtWoD5o/q
	 ailvtQaZppB8SLCnIXLLCwoOkzwbXZwRgjhHHWrSv4aLxYbo9zCwLwurZMZBhqj2ZcJu1
	 Qxrfnm3V1vox/mYIH6ysCZsi0SICbFqce9N2LzdKS7Tq2ruzj7KJOaT1YqNQsrXhykFwL
	 1ukctREoPC9mhCscubWJAN2UIUujlReGN5t15bJKFba+M8WglQVpU2KtMsSmjs4rAfwrF
	 m9Ajt9ZA0+zH5qtgWu1UdlVlr6RrQQDLGWmINhKgEJBireDvKCUxGSDfjJ0TfS39BCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168202;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lh33mMZKlVO2Az+vYHEZ3Fz3R7ZSYhBcAIVt8l6o+9Y=;
	b=EVQk0Cx//AvZ/twIDzYu9HlRmA1ra2KLdlSUanUJVOCzpHs9FDw6SuToJ7lCh/vlKnZg
	 EOZfSZxD9PJhfW4wIoZIBPUBuENXmX8xzQolNNn8J5dSFZR+nPp9k9F9SyzKDonc0zex9
	 cThMeb03n0ZFZMhW27Tt2akD+aObO0G1gneaNt/5twIa2d7yEHQqf0LVbSiuRK1O0qzwg
	 y7SzKkAsvNFdZ0/tWLHm9yzoiM0qpmWjmBSi3sJ65X5RFaXmtupMCieeZ15eQl92vf7al
	 hYYgTuJu3f5JWy358E3/wUmN91ePLW/9rhdyukVp5KYWoOi6H3fKw8hUC9AN8LiX0ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BC606A326;
	Fri, 20 Nov 2026 09:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 912BC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bc112cfce4c711f19a56ed5b684f684d-20261120
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c5ab480e-477b-4bc3-8d62-adcb90228800,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:c5ab480e-477b-4bc3-8d62-adcb90228800,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:925ad11916f6df59c4ffbacb147413ae,BulkI
	D:261120174956KPP190RS,BulkQuantity:0,SF:10|38|66|78|102|127|153|865|898,T
	C:nil,Content:0|15|50|99,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bc112cfce4c711f19a56ed5b684f684d-20261120
X-User: sunshaojie@kylinos.cn
Received: from sunshaojie-pc [(114.244.3.119)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 777979842; Fri, 20 Nov 2026 17:49:53 +0800
From: Shaojie Sun <sunshaojie@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	sched-ext@lists.linux.dev,
	Andrea Righi <arighi@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Shaojie Sun <sunshaojie@kylinos.cn>
Subject: [PATCH v2] tools/sched_ext: Add "arena" BTF type tag to the __arena qualifier
Date: Fri, 20 Nov 2026 17:49:34 +0800
Message-ID: <20261120094934.979574-1-sunshaojie@kylinos.cn>
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

tools/testing/selftests/bpf/libarena marks __arena types with
btf_type_tag("arena") so that whether a type belongs to an arena can be
determined from BTF alone:

  commit a0fa68d8ce75 ("selftests/bpf: libarena: Add "arena" BTF type
  tag to __arena qualifier")

tools/sched_ext defines the same __arena qualifier but without the
"arena" BTF type tag.  Add the tag so that both describe arena types the
same way.  Add it to the fallback definition too so that older LLVM
versions and BPF_ARENA_FORCE_ASM builds record the tag as well.

checkpatch reports a false positive on the new definition:

  ERROR: Macros with complex values should be enclosed in parentheses

The macro value is a sequence of declaration attributes, not an
expression, so it can neither be parenthesized nor wrapped in a
do-while loop.  The selftests copy of the qualifier has the very same
definition and triggers the same warning.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Shaojie Sun <sunshaojie@kylinos.cn>
---

Changes in v2:
- Add the tag to the fallback definition of __arena as well, so that
  older LLVM versions and BPF_ARENA_FORCE_ASM builds record it too
  (Andrea Righi).

 tools/sched_ext/include/scx/bpf_arena_common.bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
index 2043d66940ea..9f6373218106 100644
--- a/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
+++ b/tools/sched_ext/include/scx/bpf_arena_common.bpf.h
@@ -16,7 +16,7 @@
 
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
 #ifndef __arena
-#define __arena __attribute__((address_space(1)))
+#define __arena __attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))
 #endif
 #define __arena_global __attribute__((address_space(1)))
 #define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
@@ -74,7 +74,7 @@
 		     , [as]"i"((dst_as << 16) | src_as));
 #endif
 
-#define __arena
+#define __arena __attribute__((btf_type_tag("arena")))
 #define __arena_global SEC(".addr_space.1")
 #define cast_kern(ptr) bpf_addr_space_cast(ptr, 0, 1)
 #define cast_user(ptr) bpf_addr_space_cast(ptr, 1, 0)
-- 
2.50.1

