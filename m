Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578ED3C7E19
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255332; cv=none; b=M26fODsZIrQbe+AAuoXTDKBd6nPkBkU9YNJII+6Rw77NyRVLyRGy9ZG09qinXRIEpBZBj7kr6HOlWwkljtWjESEvo+rRB0WofPnFZZrR/JkMPtb9fohC46LhA1QZNWJFEDMigU0rjdf/a+GQ8bMG1z4F8xBuV1++xh+WMEbxeO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255332; c=relaxed/simple;
	bh=cUgZPO6rDmBAZ3TBd8ca2pe/kBrG6oSkTuzTM3KDQjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8EkMj80Vr2WY8aFsvudX2M1G+AJ8liOSvpW/MZoageBPteNVmSOMrZHHfcI8X8bbxA0/+dkLrLdj4e1V6T/SKIbGOtbDKt5sj29DaEV7nnkKq8/Yla/s7Ykp4Az6+Rv6bp4WgHjFsbK5Y+6GKiyCuxnjyJWk1NGlQ36MTcLAmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VN1M9dk0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN1M9dk0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e8ad5b31c7so3896225ad.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255331; x=1792860131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8GSrpwkIAy4RJ9hTxdnQg9rKeSuvGVvr1IWVsPK04zY=;
        b=VN1M9dk064FciW2mgKlESZLEwCCmji+U23+7liI25UK+weYxMucQ0HnyFGVmwUP2R5
         lVp11PfrtHzcnIX+t+OMVq/HmOMglb3aVr2TuY7XS0TLpud+ylYOA4zCncHrMTAvxTsz
         jr+49TwzzeTQTYEio4wqBoeiG8o3tVDUkiBig0dWoZNHhqLDSkT5tWiFRA46Flgumgz5
         sBiGjEKG/eDwkZQRvAfGxFrwVAe8LtP3t7Hnv7Ocq4J9jS3N7UzuY4etvZU2aj2q64lg
         tXIywV9DEbwgoImgNj9YLKmwH7BM8gEsfjjNtWWa1piqeewAOytUwBaZLw4NmH0G4owA
         g2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255331; x=1792860131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8GSrpwkIAy4RJ9hTxdnQg9rKeSuvGVvr1IWVsPK04zY=;
        b=kAHAgf4hznPCehgmefsnedT1ke5nUiDrLKU8kPFmqXUc7Ie7svn7FTlJD/S5xUMVUr
         8tSNX24afAEZ7YuIpljalRQSJOijplQxgSSFScAwD7h3dk7ZrzPZimJSgAIQKJnXLP+V
         9KyAiZJK8ptRMEc6dRcj2y+N0OjmlfROBdSG1Odrb50uUGDQMY4Xr3QhTOfWehTQVCNw
         BveDH3CE+eKilzIw7NJ285G6Bq5PSboBlL0hy6ls9IZPon4+eHhln7qYbCVot3ssk0f/
         Yi2XtqAY6jJlUdAm73xBxZIP8Nc1p6tysYDvzJblCFAmcMD6QorHNEVwgrqlrOCwNazo
         q6pg==
X-Gm-Message-State: AFq9FYIIT2zGDOuQqEvnNpRtK8U5slxeqx699uqJcJFRYwbqzwph+5Fw
	4g8yD+PCQfeaBIumCds/pw8dPvyHwdN1OPPM+ovzrLOwGVMNQU3QSwgpoFepbg==
X-Gm-Gg: AYBFou1XgeAb/eELbgh9+A/DGt5NQbA0t2Ih/smR7OZCKx2mUJCdPELdp9rVwQRUynh
	xBmh7eU+ytygyMNqI8DVRb2/2ho1DM7Q0SuQaOEjBU10Gq38M1az3rR6/caoha9vRaX9kStebWQ
	umkThTZ9h1JT75MVqXWaqBEUpBfikzK9P9+d35Wnbdt/DcJ4WXyRDdKxB1Jz40DqSJ3inv95Ve/
	WHMPgjufU8lZGiGYUYEpyYyCdQpZaAbVNV6nzKHFwsLU4RepqNfWT0Ze9BKD588QCYsmmSqT7cA
	dG85XHJvLhemR/L4iPHeRCvPe99rnqQ3gm645HujWBX1x5OPApeMNZ+H7qo9T0Lr1LtZ3r0P+NY
	ItfbO+PpIp/ZznHLCA5bTPTVc56h2R0j0iR8c7a6DcibYC35KSrqH2IG/FHV0rEhF1+kxId0bku
	xvFnlsZjbyHwtNVkP7WlWcY3Cy4xs0gjAERVYhg4SKn3IH3R1LoN4eW8HHRObUELU+fYl1KchMn
	H+KLcms73tq4gfJuotaK7BfXRlY6UvQ+gXl5ucF7k8Jp7hnsVrEe9Pnv0qhzeTkTYuBDQgQ3i+8
	h2ZUhtRafQF2DCD8jcAJ64bDxgRxk6z5DE8zl+tXcxI=
X-Received: by 2002:a17:902:d492:b0:2e4:a360:fcc6 with SMTP id d9443c01a7336-2e9a6c18d0dmr29946625ad.35.1792255330703;
        Sat, 17 Oct 2026 09:42:10 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b35eesm21952125ad.73.2026.10.17.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:42:10 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 43/43] bpf: Refuse packet slices for packet-changing helpers
Date: Sat, 17 Oct 2026 16:37:45 +0000
Message-ID: <20261017163745.3341787-44-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The helpers which may change packet data do not take a packet pointer as a
memory argument: they have no pkt_access. bpf_skb_store_bytes() makes the
skb writable before it copies from its source, and that can reallocate the
head which the source points into.

A slice from bpf_dynptr_slice() of the dynptr of the skb points into the
same head, but it is a PTR_TO_MEM, and the verifier lets it pass. The
helper then reads the old head, which has been freed:
bpf_skb_store_bytes(), bpf_lwt_push_encap(), bpf_lwt_seg6_store_bytes()
and bpf_lwt_seg6_action().

Refuse a slice of a packet where a packet pointer is refused for that
reason. All other helpers take slices as before. bpf_dynptr_write() and
bpf_dynptr_copy() can be used to copy inside of a packet.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 47e2969928a4..8cddbcf079b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9693,6 +9693,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if (err)
 		return err;
 
+	/*
+	 * A slice of a packet is packet data under another name. A helper which
+	 * may reallocate the packet must not go on reading from the old one.
+	 */
+	if (is_helper(meta) && reg_is_dynptr_slice_pkt(reg) &&
+	    bpf_helper_changes_pkt_data(meta->func_id)) {
+		verbose(env, "function access to the packet is not allowed\n");
+		return -EACCES;
+	}
+
 	if (arg_type_is_raw_mem(arg_type))
 		meta->arg_raw_mem.mask |= BIT(slot);
 
-- 
2.55.0

