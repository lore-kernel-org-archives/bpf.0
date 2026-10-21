Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598216;
	b=GvFgVyVb9zKfa/ETV2WQ/z7PlBooY3NyZzmoQzy0NrlOZwqCu6Dv52kr48txQTkW6WgN
	 EFqQ3vLVBnsHq5EjggyZuRfP4GXbW6d1D6M3zkOcp1p3R8xJKdLZ4qISeXqzejgSX9PT2
	 53Y8vwnaapxXYMogBa30mF1j9a7ZZRQpRmlVkU5QG7tRpkfGYfHmPHezDfR3J2xEPv0ha
	 b5uc3mK3Uw+eNBF7oJ7ofKgd21vGOq+ieDghVglylcXMEPon98bVUBLTBxTLIs6FGkf+W
	 qRaxkCVKScR+aJwhWxPBabMa2hTjW2WoiCmY/hUITkPDsXi1GmdD4Ol0WBlGXGzYMiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R/H0Aa4Up4KmSYMG5hbV8V8mjw4aRBSPBfTl+cyvzSY=;
	b=CzTV+IkA2EbPQK8UEjwUcX9hzPBt3F9o4RLv6q1zGv0oohNowCJfKS8X5coqumMYA3c9
	 syOha6Pko8QzG5EFSEKlwo30T/hKO2fum9HboJLLFDmzIahC+JBOoK9QJnobsIgYnUHfD
	 Mg27lB87Fje3anhdD+bfHJEy4rEDQyrJArSUW1pdvlBiaBcnSFsS++x9NT+J76PJ2w1Fo
	 VlFLdMi/AUzg8BXOA/W2Y8KSa8xIMIhrex9haGUxRJOfbC9A0wdBepkPcs5n/zafnoV6f
	 W6w63Lk3Mf7Fd7zwHrFHeAVXLLXLlNobYeD1FrVh4AXBQxPwDKVZSsbkUSS5aD7I+6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=POOfgI4q;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82868606A326
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82868606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=POOfgI4q
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so729071a91.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 08:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598215; x=1793203015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R/H0Aa4Up4KmSYMG5hbV8V8mjw4aRBSPBfTl+cyvzSY=;
        b=POOfgI4qcb75idUlrwj64NiUdNvBQHL36qyiKZxfwfgr1hUfm66xGK5FmutGQyUWTH
         HBndJHM/5BHL7VoEL56rqz2kLb+dXOa1hBAEs0gPP+DH0IQlim5bTO7qJ5JMJ7dL9RzQ
         PkQNvSr+T+LMEWYdkqGdmOU/VD5c3eeJBAmCTi7rpfNqMZ9pVxMyw4mfx41E1wIM5k8P
         DNMYJ80alnMboIWiIN4PHimgFCIBDG5LniwoPl7pFhKxj9ACi6cpIytH8EBnLKdWU7r9
         ouQ3nCKzxoQpw73QCo3BNlTj5MaNokMUHwOSeWRel0idl813NpvC7wFkTGQfGitt06HU
         ij4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598215; x=1793203015;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R/H0Aa4Up4KmSYMG5hbV8V8mjw4aRBSPBfTl+cyvzSY=;
        b=wM2d3YMXxlP3GrZcUnDBbjvN4n3PwJPXRt675LxeXhA5OfxHZYzLqARBTEK5qgWTYs
         T2VqmL3mzV5y1v1qKbY7KF+u+YFY1p1LltBBDcle+huvM8Yn31scxKIaT2SgN4Wd95s8
         POZull8ATr/3OLfM1A1JFPxNozLrbtROuhsqq/3OdB3niYyhOQd0dZdc/TlBrdhO94J/
         VSm7UbqS5/IUTrVSzYH9TE9l8BqHl3JZHoPnTWrMjBjOEcxnQT4PdBBU1KjiPUuw6kLo
         WuHtRSwzIg2zYzW11RHFTrTUKiICcDB4hP0w/ZnxGePya1JzVrATmZMLJo2FbooPEqRB
         E5dQ==
X-Forwarded-Encrypted: i=1; AKwUvByCRxh+bqu+C+YYKHG/Jua4qwUbws8f8StAKLb4XlmyVjkhGi9mdV7+QZLJml8QU93nvKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKUszfkOVrmAJhpnsmQoUtsBEeBJbJkQb+TAKbzniqhnxZ9sZJ
	AsfmSGI+DTGUxPLsluWXhBj6dOfr8fOUJ5w/qQxgYAQi3DAjcqfpIYKK
X-Gm-Gg: AYBFou0Gphq/HT/kIhC6SMFbP81IjgBrQJjIweAaVA3oCP1fsUhm5fGdY3Zdodr2UyD
	Sykg/tPL12v0kI7+RJOZ393jRA9TDTQvdoWk6nKQYIGV00PhxYSMzqZWLnR2xF3sjkOd7AMMsMt
	iYUmxJKsAQRx0cIKmRSvtFsSr5819qrgqlGYZwqFEishqizb/a+7+pIyNTtWS+BBExKSMwwBU1t
	MP3Cj/K3vSSk22yzcKHpiTjEZ0RL4CJAsewWlIp2Nh9+l4seLVxzk7G+G9nhl/STAnrHYlSTUo8
	RvDJ3zz1RTWAhu3O8s57tDqnVu7YLMiqq7wJZxWqw7/kUTH3MEJDaiA4tvjiPNBHDR8QW3UEA9a
	js260aRxIxJ2xW/wrXOOHF36soRuWkFh712nxv+GmlKE+F76EtyNFKYhqGAGLh6dGFRsNRWuLFV
	AUSpmDzCMiY0KxOiyzP3QA9qnyOhDknd1mXUxMHqS8szt8HBFx7LHx+c7x+3OGPPPhBtFTOQf88
	oS8UptXoT0TchLMmovWkpEdwKyAWvycak4pyDMP2nCV70LGeu2JqpbNkMtspareTPdIi06gJXpP
	voDg8yc0U71G4XvanaRM6mCS5EefeNdpSpC5+hx+YACYG7BIirj1PGuKJP8=
X-Received: by 2002:a17:90b:548e:b0:3ac:95d7:2fa5 with SMTP id 98e67ed59e1d1-3ad87083900mr1990329a91.44.1792598214857;
        Wed, 21 Oct 2026 08:56:54 -0700 (PDT)
Received: from localhost.localdomain (69-172-67-073.static.imsbiz.com. [69.172.67.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4890bb2sm115257a91.1.2026.10.21.08.56.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:56:54 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf] net: return page_pool frags to the pool in bpf_xdp_shrink_data()
Date: Wed, 21 Oct 2026 23:56:45 +0800
Message-Id: <20261021155645.69120-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bpf_xdp_shrink_data() releases a fully-shrunk frag through
__xdp_return(netmem, mem_type, false, zc_frag), selecting the freer from
the rxq's mem type.  Under generic XDP the rxq's xdp_rxq_info often has no
mem model registered (e.g. loopback), so mem_type stays
MEM_TYPE_PAGE_SHARED == 0 even though the frag was allocated from a page
pool by skb_pp_cow_data().  __xdp_return() then frees the page through
page_frag_free() instead of page_pool_put_full_netmem(), so the page is
returned to the buddy allocator while its page_pool accounting is still
live:

  BUG: Bad page state in process A-146-S3_S1  pfn:4694b
  page dumped because: page_pool leak
   page_frag_free+0xf0/0x11c
   __xdp_return+0x160/0x640
   bpf_xdp_adjust_tail+0x5a4/0xbac
   bpf_prog_run_generic_xdp+0x4a8/0x1204

Before falling back to __xdp_return(), try the page_pool path: if the
frag really is a page_pool page, napi_pp_put_page() recycles it through
the pool and we are done.

Fixes: 4dce1a0d7cf3 ("bpf: Support pulling non-linear xdp data")
Assisted-by: LLM
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
Tested base
-----------
Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
is unchanged between the two, so the bug is still present there.
Checked against linux-next next-20261021 (commit 9a482184d910): the
affected code is unchanged there as well, so the bug is still present in
linux-next too.

Reproducer status
-----------------
A reproducer was written and executed on an arm64 QEMU guest (generic XDP on
loopback); the kernel reported "BUG: Bad page state ... page_pool leak".  The
reproducer source is not posted here per Documentation/process/security-bugs.rst;
it is available on request.

Triggering conditions
---------------------
The ability to load a generic-XDP program (CAP_BPF / CAP_NET_ADMIN) on a
device whose rxq has no mem model but whose skbs are page_pool-backed (loopback
via skb_cow_data_for_xdp()).

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/core/filter.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..94bc367cee12 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -36,6 +36,7 @@
 #include <net/protocol.h>
 #include <net/netlink.h>
 #include <linux/skbuff.h>
+#include <linux/skbuff_ref.h>
 #include <linux/skmsg.h>
 #include <net/sock.h>
 #include <net/flow_dissector.h>
@@ -4380,6 +4381,18 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
 	}
 
 	if (release) {
+		/* The frag may be page_pool-backed even when the rxq's
+		 * xdp_rxq_info carries no mem model (generic XDP on a
+		 * driver that never registers one, e.g. loopback).  In that
+		 * case mem_type is MEM_TYPE_PAGE_SHARED and __xdp_return()
+		 * would free the page through page_frag_free(), leaving the
+		 * page_pool's accounting dangling -- "page_pool leak".  Route
+		 * page_pool pages back through the pool instead.
+		 */
+		if (IS_ENABLED(CONFIG_PAGE_POOL) &&
+		    mem_type == MEM_TYPE_PAGE_SHARED && napi_pp_put_page(netmem))
+			return release;
+
 		__xdp_return(netmem, mem_type, false, zc_frag);
 	} else {
 		if (!tail)
