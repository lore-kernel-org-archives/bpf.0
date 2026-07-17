Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7204363C75
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263229; cv=none; b=mIC8o92l8otvmpv6OzwUkQ8bja7zCtCNY1W06Sv0bkfPmC6OG3xqbVLEVyul3Hu8GGiPO06xX5J6N4pwZQADJA/nRSY5bfLrJYoeuX2T0ks0pW24C0JRX17Qkc/vZGYZ0zTdH8hQpz0GAeYgQ4hk7tdQ5xS5FhRKLOAmfkxFJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263229; c=relaxed/simple;
	bh=jY6kh4XC2NGi9/DE0ccHa6BIGDwbNokirU2hole0S5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCpv86aiFPdt42pzAL/3kQyHrirEb95GTmN3wPEA6bWmLdTGWLJxpwDTvba8oaV298i6KnxhwnKIx2ig3CnQ3e/3tCrn7yXNd+lZRSQ6nA6fC67Ro2ky+ABm2Lx3e5267Wdz7N2mIpPMUWJzNSIbOnVfFl1qQnZ+/tvak40nbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VDHPe6pi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VDHPe6pi"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69e2266b07fso3798607a12.2
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263224; x=1784868024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuhrAU/mn5X6tovhkVA4Hb80vOZwT8wqQL2ZxCrhgho=;
        b=VDHPe6pi6Zc3kS5AbH0VxjdXFFGWo7cqae4NHiHlJiksmXpBbpe1fNJHD4Qd5uVIkS
         jbSixEcCOX4RdiawHAFURqjh9jHqK/9EsdowThbELbNZ0QKNBOZLI5n1WkwePpHDwMv7
         zg5BB6nWfgjBqTiCD2qhmkrphgVUuKwoPOJcUuaARNGDpSXmfNY3fHhxj0OX2puQ4AaM
         XsoUu8gcXvTgH+Bm7wB1Os81tJ8MeAQigTR9VmxO0RwlN+TYn72iNHZxFKEnsmCEmy/O
         bPsBdSqS2phms3ZFLc3drFKcU7PwMn49WhB/r75C3INTpsbDpj0XOYmHKRUE7aMcW/3Q
         h1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263224; x=1784868024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuhrAU/mn5X6tovhkVA4Hb80vOZwT8wqQL2ZxCrhgho=;
        b=dQAOzruok/oHAn8jEOaMIwSUGoPopKzrX34ZD4YUdiN+NFtpdb/sNjHoRFLs5l63Az
         9gE4oRjPM2zhGjDm4vEMCjGRSKenEH0a+StJxOr6cLUyI1LjNksS/jYI43B8JcsKU3Fz
         CWXhJXjny7sQR4WBu8VIniL8YixLlUPkNvwC840qiTEBlFfGWAeu1FBhF6LVOzgFB8CR
         dE+v6KfmngrBV5t/l/7MupnaFoXW+6BYNG1PoQh2zpH2mhUISqjHIm7Lu398XjA0LKvE
         ay9//rKQbCpyqwx/7xioTVjidz/tbyvy7CeHmMW3cSohVgM1j99R1YkE7/dNkerHRMW7
         cbVw==
X-Gm-Message-State: AOJu0YyKu/FzQxn4g9Uq/5TUmAMwVEdqPPnQQvtLYthCNWICrZHvpkMA
	yvVLP8b/H2cnAWmuvSoJcRi92Fa72/VlhU0Gwx7eAupIuqyC6+GZKqfUGQenB05rBZqGbUwzA8D
	HD2Q7
X-Gm-Gg: AfdE7cn/k46jLMp1tUBYHIHnb8q0Lr1yJwoJlAWOiA9NaxXL21B3hgChvT6x04EMBA+
	ayW0pvjyD4MLtlapjNbADuRrcflctKJg0cJB2n8k6TN4qUc5bLehMlvghfCL3NqvKEXKXXDJYBj
	MrpSL+dz3j4fpkEtv+YKPPQckDsfJPg8gAYlXDgdp8kjx4QIPnf7yJ0XijuJBaB8oldpMRyLur9
	eGyelCNFkhFVfsOBXgRQx3AfU8wUq/2NQeODoshgn85gL1gAMZiiBZPgn8bhSV3wwVEFRY4HddP
	UkLA1yoa0ZL5Bae0p8MriC3JBbfXPp2yZHFQb4h8SUmF6y+W+X4TQT8Cz1o3TBAZTxPYLmZNNf4
	ny/uNSlmY2rHF2FNnPqfzaodJIQCnQCEgTUBjknShcejm9FE3zeYVonjx9wSUNRbaJT/U35/H+1
	QuLC/rp6qpBj9Ltm5nCI/346mi7zdkzIA=
X-Received: by 2002:a17:907:db02:b0:c16:652c:3db7 with SMTP id a640c23a62f3a-c16b47818bdmr26575466b.36.1784263224099;
        Thu, 16 Jul 2026 21:40:24 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3474100fsm3403715ad.66.2026.07.16.21.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:40:22 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.18 1/6] selftests: bpf: Add test for multiple syncs from linked register
Date: Fri, 17 Jul 2026 12:40:00 +0800
Message-ID: <20260717044009.120224-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717044009.120224-1-shung-hsi.yu@suse.com>
References: <20260717044009.120224-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

commit 086c99fbe45070d02851427eab5ae26fe7d0f3c0 upstream.

Before the last commit, sync_linked_regs() corrupted the register whose
bounds are being updated by copying known_reg's id to it. The ids are
the same in value but known_reg has the BPF_ADD_CONST flag which is
wrongly copied to reg.

This later causes issues when creating new links to this reg.
assign_scalar_id_before_mov() sees this BPF_ADD_CONST and gives a new id
to this register and breaks the old links. This is exposed by the added
selftest.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260115151143.1344724-3-puranjay@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/progs/verifier_linked_scalars.c       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 8f755d2464cf..5f41bbb730a7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -31,4 +31,37 @@ l1:						\
 "	::: __clobber_all);
 }
 
+/*
+ * Test that sync_linked_regs() preserves register IDs.
+ *
+ * The sync_linked_regs() function copies bounds from known_reg to linked
+ * registers. When doing so, it must preserve each register's original id
+ * to allow subsequent syncs from the same source to work correctly.
+ *
+ */
+SEC("socket")
+__success
+__naked void sync_linked_regs_preserves_id(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r0 &= 0xff;	/* r0 in [0, 255] */			\
+	r1 = r0;	/* r0, r1 linked with id 1 */		\
+	r1 += 4;	/* r1 has id=1 and off=4 in [4, 259] */ \
+	if r1 < 10 goto l0_%=;					\
+	/* r1 in [10, 259], r0 synced to [6, 255] */		\
+	r2 = r0;	/* r2 has id=1 and in [6, 255] */	\
+	if r1 < 14 goto l0_%=;					\
+	/* r1 in [14, 259], r0 synced to [10, 255] */		\
+	if r0 >= 10 goto l0_%=;					\
+	/* Never executed */					\
+	r0 /= 0;						\
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

