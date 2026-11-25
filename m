Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577495;
	b=YN3et9vEB6wrzjlGM4yCxqGnQJSUvqrnHBV24gFmgboFE4WHVIwv9qyfiWCs3X3eNCdq
	 qq5O6bTVmLOuVLqs32wzhtIyWRnopaTyDVybXwgMLAOGAuaTR+o1Hn8mG3FusrgCzJ55D
	 CzQnCwv+aZJ7EY6SDZRDPkr4a6R7N5jp8/8PmpK2e4tUIuWA1yQ6t9A0OVVUb2QVATNWm
	 oqqFQhjy73oujnRpSkEvQ9ek/Xj8/PEBinoKrDtfZI8/KpqHe5uVE+iUoyHFL9hUhweHq
	 thepVs1rp3XKCbwBwDMtN/E0p+xrMjdREaDhh5vfW1tYyGfIZcl6TgRJ1QEsRe4clEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IGeYop8QFo4Dh+O2L3u67JkSJGivN//i0lkXH46Igig=;
	b=IEnL0fW0n4NtRn8shYi3RIvFWzhEdOo7dV+AQTzbn82jRrBejcVIAykCXNt7ui9eM0au
	 YZcgKMj1eOjIZiuAFr389hy5l6ruiSXfk+Q0j39ushnBhVKx8LlVo3QnaDcvKXULGnjBN
	 4EZxMtfw/kCu9ckntN7v0gLSdxToqG0ogxPwYbpKYJNhx3EMFgkkhdCLXrVUKCWCyY4Tx
	 eplyBKDHUCMHsMxiYT4THwX5oP+iKdfq1zqxdvbH1zCcUZconcIh/DRd12fzd+D6myE1j
	 c4H+NLL6JmKZoAOxF3iIoG8yCPuIc9JR+ewyMQdLvEbAdSXTITXFiN6mDIDBEDdr3tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNklbvYV;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9E606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07B9E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNklbvYV
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdba1bbde0bso2038549a12.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577494; x=1796182294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGeYop8QFo4Dh+O2L3u67JkSJGivN//i0lkXH46Igig=;
        b=UNklbvYVA0bS5VMGwJnuRV6p/4CIFtaV5ZAGb8DH0AfCoqgwVFIX5VmrMN+5dnxt5Z
         f3qxsuKwR8ad6x61b0PnO+oyLhY6gGcGTPI0ptnXBqnAmfTnjNIA+YU3Imw3AxmtrVfF
         wwyrzPTZWk4hNVVN96mK1lkdsRejsCTxXhQOsCYfdT716QEyT8QoGL9+ruDiOO2w1i4v
         vEA/w8W0thY/k/vt+ssxSvgbZN9bEhUoz4UzE6JkundHWlBTkTNjUXDxF2/ii+wfyGMG
         LphBW1fj17Y1Od/LoOM6EMfvGsJnT49rM5B9Hw+Zd9CTx3EokTo/4uaqw9Pv7chvzypQ
         aH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577494; x=1796182294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IGeYop8QFo4Dh+O2L3u67JkSJGivN//i0lkXH46Igig=;
        b=GKhYMKct47i8q0vxp2uKPzm/xD/Bk3f0oRZU+yZVXEQo4BC1ALDXt1f6Zjj/kYNzpw
         TbeLnL69XMJTREH/BMtKtzHXDACojGDGkbGIFcwNejY26Q8qC9n/Id6lsXssVlEHLYER
         yTL3cNvk5kyS7uhfIEC40rUx0AcBjXnzsgsuN9E2/TpEXuhHndI8jugDkPx0V1QZdBu8
         RMkxFUJK4qnlz5lsYlkaTkfXQpnGTqLeMyIeE4wQcWmXVkZ0hGYJ1dcGkaI4faUshWXE
         Tm6v2VrLVgkp+qiaoGAQ8YiFcsBGfA2d1pOzQOyY/BukOIC8QMgqxdJI9nAHkwOre65G
         /0hg==
X-Gm-Message-State: APuU4Z8gpgiZQAdkAt2jISnxACzwUGvCmg8A5LnzMSNrEoZZ4TxTrOGT
	5e7fsxvFF0QUJk5S7LUutfVp6kD5IJdOFOplzz5/+f1yTEzYzxJTv3+np3iHXOB2
X-Gm-Gg: AZFdTZegvA8eOrr6ALV/JeUxhTw4h//xAbAmFrlAKRqP8jdFSe3G1Gv6fa9akDcmKIl
	feraNDz+ViPlLMo4X/reEiW+rhEymRBgGAK7EmnpdGuyBUfBQBKYCNJckmvN5nhrUzE5RbMvA56
	PiLmU632nWG6h/iujyhhzpqJ2turjJZUN8pCXGlngV2ZffDPK/k42Y0OfBZ0qQmdO8tkJk0E1Tc
	n+uBjV0by8/emk7Biw2nJFTI4Agthxpd/DFgJb2g/rFeU16eJ5u4ko56uK58e3K7JSDBIZLHbY2
	qL5F+ENwRTabPltxeY9xf1WfLoDdR3DHNA5UbQhs+y8RI0WR68Bwo8XpTnUHz5nrb1gVnqhGpd9
	zfmZcAd3qOxxbq/cbFAohrZMsS8FoRWcUcdiYUwhuGOvYBbTiYAx3umfq8gRe6RzhQxxzZT2OLj
	O+EiDSOz5m9SbBeCgWA+8WzjY/LALnn9qKp4Qlj1ODyxnioI7yAy86BJJDRtEXgfp8ayuop3Trn
	umZ5l0Kz4JC7+Lt1B37SyCNKDCyhdqYfhGbeqqhxNkSrT8b1z2OALxP7tyAJEU944HvZew+W9cR
	77kioIkb2IIBJuSAQDyaMJLQkezfsNF1ldGpiO0Ihy+rqQ+4clLM5K6ePx64m5oTgYl3L6zjx7r
	s14ljBBUdmRCYPNGchbAjbiOYhSLAboo1ypyCiLz1EX2GU5nH7yh5T9IDP28QAC4Rry2EdkbzHy
	QnhLSOrNmI7aYfx5rqSXgB
X-Received: by 2002:a17:90b:3b47:b0:3b1:83d4:5d33 with SMTP id 98e67ed59e1d1-3b41c99524bmr16017446a91.60.1795577494142;
        Tue, 24 Nov 2026 19:31:34 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8ef99sm26159736a91.12.2026.11.24.19.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:31:33 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 19/47] bpf: Take bpf_lock with interrupts disabled
Date: Wed, 25 Nov 2026 03:29:10 +0000
Message-ID: <20261125032938.670542-20-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

A program can disable interrupts with bpf_local_irq_save().
bpf_setsockopt(TCP_CONGESTION) can put the last reference of a
struct_ops map there, which removes the symbols of the trampolines with
spin_lock_bh(). Use the irqsave lock, as bpf_map_free_id() does.
PREEMPT_RT is as before, both locks sleep there.

Fixes: 5db69b0fbdc8 ("bpf: Make struct_ops tasks_rcu grace period optional")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2f6392ccef73..47c43e8099dc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -648,11 +648,10 @@ static struct latch_tree_root bpf_tree __cacheline_aligned;
 
 void bpf_ksym_add(struct bpf_ksym *ksym)
 {
-	spin_lock_bh(&bpf_lock);
+	guard(spinlock_irqsave)(&bpf_lock);
 	WARN_ON_ONCE(!list_empty(&ksym->lnode));
 	list_add_tail_rcu(&ksym->lnode, &bpf_kallsyms);
 	latch_tree_insert(&ksym->tnode, &bpf_tree, &bpf_tree_ops);
-	spin_unlock_bh(&bpf_lock);
 }
 
 static void __bpf_ksym_del(struct bpf_ksym *ksym)
@@ -666,9 +665,8 @@ static void __bpf_ksym_del(struct bpf_ksym *ksym)
 
 void bpf_ksym_del(struct bpf_ksym *ksym)
 {
-	spin_lock_bh(&bpf_lock);
+	guard(spinlock_irqsave)(&bpf_lock);
 	__bpf_ksym_del(ksym);
-	spin_unlock_bh(&bpf_lock);
 }
 
 static bool bpf_prog_kallsyms_candidate(const struct bpf_prog *fp)
-- 
2.55.0

