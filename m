Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795157777;
	b=5uB2OESxzT9VL0Q+G5pSTncK5JCn3otMGN4DcJnrv5uv3+60KTB/qdDkF2qvr2wFcu2X
	 pelEvVbadqfgElJmdkV9suyRJfAX603wwTOLWF02OseGPwv88GPmLpGrmuTnnd0W/zyEO
	 l56wG3sjqwwBV2Iqr+mfwb96iTdJNso3i9uAK4A/Hd9J45rTXEj1Qi3ovIgiVNV4aobQ0
	 yFDEWQ8MeFL/E8kcw0wFqG3b5x+OKQYGHrmRCqa51H/UEAndJlRs6S6rNg8Qz1Zu1/oPh
	 cDWAgepHRpbvG4AEWru47F52nqL6aPLX56o+XZgtGCwkABLgMxWwBaVnbcVerpybhmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JSpsy0UKa4DIFK4RDl3FsapGjP10wN6PK5z9B1SUUFk=;
	b=g+7IcOdwYiNzxyMBrZN/Eh9vc1MrM0IfxXoCl4EUQKD2uNaDLbmgMWCZSC2ebrHezW3s
	 kZmU+KPkg+WQySM+8V7Q7sOm3/6ipunIEgjdHPFPpOcUKh8K35STJ6GQXhc45ePEnovsL
	 Us7CTWBl/m3hE+n8qUxIBzNx4pGGuptbeE1Wx6hR8d0FBM4pzBTA5CSqEsEwhtn+nA1t/
	 po/rKbS3jx/H9ddF8F8Vb9SOfYy6ZtPDrzXZ5Lc97J2fbO3Xf/NoCgH7RPkcMggzbgxIa
	 Mw4Tm5dd+rskF3X2SK9QiJfVRKwxd0b3cDRkMZbqQ7Jbg2JYv1Vpz+5no15ftzJSyTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D3dSOuK8;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E578606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 06:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E578606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D3dSOuK8
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso345772a91.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 22:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795157776; x=1795762576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JSpsy0UKa4DIFK4RDl3FsapGjP10wN6PK5z9B1SUUFk=;
        b=D3dSOuK8blb0kHtl09c10+5Fp1Z+ZrQASGIiIVZKmUlx2qPo1qGKHk7NzGrv++yXvj
         mY9Khua8KaqGTYIXlYujWXGkgT9WlfDmpPkph/hCtJbo3iX3h7YDEP/QDyjuDZCGPK+3
         8IL+nwhqTIPjteOMI/DwIP/jORxh2MyIkvI8hdc1/qYBp96mWFX2TeDd3O2gMtGCbfii
         szZ1DcEAjyrWNCPNbazT6PecXNbrdMl4RfGlnjtrrIV1+KEGpLoklovD+VndqkDkS6xS
         2Qri1yMVoaXOXw8D6fOZVY06XoqjlhwVwTsgOifz6VbU48XSWrnhRbFHp7JgC1g3Xfop
         hDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795157776; x=1795762576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JSpsy0UKa4DIFK4RDl3FsapGjP10wN6PK5z9B1SUUFk=;
        b=OuLGoKcMo5MsWDsLKIL15LcS7aCqmRoC8xKGDgG7Zi2kRp6bAc+Q6wUbzPROzQkNr6
         1gSLfw/f1diovMF+OxdfA68Ctl9/QROCEGfBOcIRe+fxPa0Z/DZ61KjdVKMPaoFvjK/1
         HXnNujoD7Ro40sDkUAEuj02S0sOb+zqJItHCsdoiIMMGpPaHlv8r6b6tRIIhIVGSZJ1u
         1Bhpn23HayVQ7tHITxVkXQ/A9vqMc961NN/Ewr8cYHKUzmXaBDnOlxmchsHe+R5kHGaM
         i+zkVLoKdL5Gdo8Em67/r20hBvVSlVib0Q15l5dOOixeg3BLBYtEiVtynwQeYSPYmQLz
         CRmQ==
X-Forwarded-Encrypted: i=1; AL+hErH2mTOpmSUlggGdxGMW8sbrnSYcaitlGxYolaOXblB1JYN3VoeeTdk1uVjwXObQ89bOJxA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Cl3jD60yiZxn2uIvsH4zI29Hxf88mQWruVrQErKrRGm9ojxJn
	HgdSQNQv9+FOxo0G23cTxGujja0NJI0HizujDJYN3rKYsDqLWxYubfQN
X-Gm-Gg: AZFdTZfCrdsQTkZ3K+2mRpfWZmH6pwOGfZ+1DgPaOVlZ++2D7wGuypEvZaIfOFMXwmo
	N1luu0gKbe/gvxfyAmpawc1pEH/f7In3jamnqyCAqXIT0IvtMwtb+zxs3vzqV3sUrs6fmsmMjUi
	QWY2/IYZmp3cPMA+N/51YBv3ZKpQo1ZMni1ZQubXz/QkUqOy1XHtoxgA4pwtmpH1/YPXVhce51l
	tNaTIoMX3/ItSR7nkyANHKkPShDXZ+/COR1V9zOgpJI5c89a3B7w3mCLTaorqWPugCioHMbOWeC
	YdcF+21OrGa7Qns5oSPr2wA3EbBCTQ2Q3zvCXf/xrl6mB3gLSzVkXDoeUS59qKSGVChDHZpI2vL
	HEHvJ5KAMCJOa0rCzTzQFwQ32+CrjyOoEkU0F9dNW5AB2wVoSfp31lQr5oYIhDjyzTOBrlDbkL5
	YcCrzkC7qRK1564i8/UGEJnasPTHGz+iFFaIz3zLTiE5ccHerXhdrhPAfNUEofNy6uiEbWMOG21
	xnH/6O7mk6ixT4kS32xYvi/nhPD9v0H8Q7IJhGn5Sl1+gNlUpsJTekMbbZ7JvyYI+OGr9oXaYt+
	qAg1epHRz78atvzUObRMDCuqBxbgcRN93qccGlloQH0wZfozZniEnEmI1PZQOez4
X-Received: by 2002:a17:90b:4a47:b0:3b3:fc1f:a5c4 with SMTP id 98e67ed59e1d1-3b41c8dc821mr1899005a91.20.1795157775908;
        Thu, 19 Nov 2026 22:56:15 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b420e1307csm1952926a91.7.2026.11.19.22.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:56:15 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	haoluo@google.com,
	brho@google.com,
	joshdon@google.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2] sched_ext: reject oversized dispatch_max_batch
Date: Fri, 20 Nov 2026 06:55:54 +0000
Message-ID: <20261120065559.3979434-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

bpf_scx_init_member() accepts dispatch_max_batch values up to INT_MAX.
The value determines the size of the per-CPU dispatch buffer, but
__alloc_percpu() rejects allocations larger than PCPU_MIN_UNIT_SIZE.
With BPF_F_LINK, an oversized value passes the struct_ops map update
and triggers an illegal-size warning during link creation before the
allocation fails with -ENOMEM.

Calculate the buffer size using the effective batch count, including
the default used when dispatch_max_batch is zero. Reject values above
the per-CPU allocation limit with -E2BIG during the map update, before
the allocator is called. This also covers registration without a link.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
 - add braces (Andrea Righi)

v1:
 - https://lore.kernel.org/sched-ext/20261120054913.3795562-1-rhkrqnwk98@gmail.com/T/#u


 kernel/sched/ext/ext.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..56d75d179822 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9196,11 +9196,17 @@ static int bpf_scx_init_member(const struct btf_type *t,
 	int ret;
 
 	switch (moff) {
-	case offsetof(struct sched_ext_ops, dispatch_max_batch):
-		if (*(u32 *)(udata + moff) > INT_MAX)
+	case offsetof(struct sched_ext_ops, dispatch_max_batch): {
+		u32 batch = *(u32 *)(udata + moff);
+		u32 nr = batch ?: SCX_DSP_DFL_MAX_BATCH;
+
+		if (struct_size_t(struct scx_sched_pcpu, dsp_ctx.buf, nr) >
+				PCPU_MIN_UNIT_SIZE)
 			return -E2BIG;
-		ops->dispatch_max_batch = *(u32 *)(udata + moff);
+
+		ops->dispatch_max_batch = batch;
 		return 1;
+	}
 	case offsetof(struct sched_ext_ops, flags):
 		if (*(u64 *)(udata + moff) & ~SCX_OPS_ALL_FLAGS)
 			return -EINVAL;
-- 
2.56.1

