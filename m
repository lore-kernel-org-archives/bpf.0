Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3D4DD3CE
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396798; cv=none; b=tG0rYXS0FzzfGqhmqFgY6RzjBgSQSLVQaqTcnzm4iXcCwhYCyGfDCAuflzSdCs1V6xqDdFv4ayRF9fE8rjetAoa4dTsuu2IvdbV1B3quCCu6uVHanYgIWWzKUhE2l9YmxgkWW6guTjb/VMTKzHkSClleeUhqN6FjS6Gi/MYvx8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396798; c=relaxed/simple;
	bh=k183NUhj1qwHVJsFTyAHVX6htBfZ4hKlTE4Xzh8MQTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMSmRhP/SfMZoV8e/OWWZfjDLyc7bIfDfLa/77H6rYgndM/UiGCiobyAOtonTXY5KXfDL7X/Bvwvr5/CGdG4pN/zLIjFPDcBFVyVw9NgEHltRqbx+zXmLlTgzlKTJ2ObrdCnG5OUNgME8+E6fK7aWIn6FPB7ww5kjGGpOORmNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeVHtaJo; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeVHtaJo"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a9ad623098so1589841fa.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 11:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791396795; x=1792001595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1qSCjp+BKxpET3CUaJgBBRS2Eq6s578cQ0Ck4M7Ypvs=;
        b=OeVHtaJo4Qp54sXfuZ1f3BJZODIVg5XBAmfAWY3/Wnv4qW1/G2a2dYg7ouoZWbuKQg
         usi5SDZCFtI4IGE/iiGwqbIt8+c3gZSXD0S7/t5a7upEXOMZ0ZmTdze6vuvrEbsqahYQ
         ZpGaDssE1ST/iGnr1KP01Fe6EbwEDKuYYXUE2xiOO4khY51nay1guS4HWJyYYq0pO257
         kdHoqrAPJP1KUkQXcmbbQDci9gsxqNsbRdUYh0HfoMUkBUO5yOVg7t6mVMTJotG7cwsP
         f11fYDjjTxf7mzZ/9KLe9LWi5WXxAgOpMH5SBn4xOX6jmJc7c2tTJI4RuMONDaKT7nr/
         Dn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396795; x=1792001595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1qSCjp+BKxpET3CUaJgBBRS2Eq6s578cQ0Ck4M7Ypvs=;
        b=sHEGt479PrkL1ZT7jZARon7inOxWxgDAuGIuzmqOEzjL+m0u3+9kwBT0FdtvXAjxwK
         vJpWoE3xO7j7uxS1wbhLJzXHG1gY5kdFPy57CYeLzRpYniDvPOfRt7rRnUyXhIVrp8/H
         pDVI+udKFaeMG40kK9MS7Dmh2YZ3MyJYRto234ULOV7gAMnHS5LUEJ2L3YHf+JckkJ3j
         Z3sW6k0hB8D7/rAdnRBcJdODswtKBfvv7R7lYRGCCAgZ2tfxIkTfDSmHrq2TUT3renRo
         ezAr+zHovSRsvwlM4/dlnN06RKuntMtlEr6unacVBTgofyX9yyPjRuto13OzLZXGLGi2
         9j1w==
X-Gm-Message-State: AFq9FYKM//yIZ66NFqeE6AUmVy++aoqy+rCZd1jX5GVCHGZ65jh2U+ec
	Z0RDJazZ/QoWiRfZeG/lksStgZfamkGUCLxedb0hYnVyXbgKHmrJkugvWoB1xGXM
X-Gm-Gg: AYBFou15vUDlZCp6ceOy1QPvDxXHyUIjCwitbF0PdykL9sb8MjNRLrl1K0uUM83LVcv
	idDPKtJuPPTfQzablWSbm9frVOx2CvhVCQM8bR5MBoN7U0vo4NCphjVvVxaOV4NoS690o7PoWcd
	pvhEdikT/dFkC6s0QgIMJ+5yNf7478fU89ievDG/KlOjCfOSWeEHx4JtBY2a35I5LQzNUtEcrfB
	AerUfatH5mc376Hpc3brQxtRDFfP5sHuhYVt6pWHlXuFJRAy4Rpc7FN1Ks+wTJHvKMQADtTYBGa
	V6cY0ayINwTj1sBFvWmmqFOofrMNTd1KjupNpabUwDV/znLZUV/+Rb3m6vC5aCuzMEKFGNa0eqI
	f2fxJGcEKLvqcXh7bvv7DsLg+ou33AHWn2351/NjwLTSqq1njGPje/gV3hVoIeziMApgTILword
	91jiUzLUGUnmVFQWcB1bRbtgHdVRtyzD9yL0QtNTig0879p2CmkMotovf3Wu1dvnRnM1PnPIRQ2
	midQAXwSr4NGfkuFXZdIEPiie2B37lVW3EvTalwDn7t9HuTD5q5
X-Received: by 2002:a2e:be04:0:b0:3a6:568f:40dc with SMTP id 38308e7fff4ca-3a9a2bd9398mr7050691fa.2.1791396794682;
        Wed, 07 Oct 2026 11:13:14 -0700 (PDT)
Received: from localhost.localdomain (95-24-167-79.broadband.corbina.ru. [95.24.167.79])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9a1d59661sm9000041fa.18.2026.10.07.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:13:13 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxim Skokov <skokovmaksimevg@gmail.com>
Subject: [PATCH bpf 1/2] bpf: test_run: Fix false -EBADMSG after skb leaves CHECKSUM_COMPLETE
Date: Wed,  7 Oct 2026 21:12:41 +0300
Message-ID: <20261007181249.352831-2-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261007181249.352831-1-skokovmaksimevg@gmail.com>
References: <20261007181249.352831-1-skokovmaksimevg@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With BPF_F_TEST_SKB_CHECKSUM_COMPLETE, bpf_prog_test_run_skb() computes
skb->csum over the packet from the network header to the end and marks
the skb CHECKSUM_COMPLETE. After the program has run, it recomputes the
checksum and returns -EBADMSG if it does not match skb->csum.

bpf_skb_change_tail() resizes the skb with __skb_trim_rcsum() and
__skb_grow_rcsum(), which move a CHECKSUM_COMPLETE skb to CHECKSUM_NONE
and leave skb->csum as it is. The post-run check still compares against
that stale value, so a correct program fails with -EBADMSG. After a
trim, skb->csum still covers the removed bytes. After a grow, later
writes cannot update skb->csum, even with BPF_F_RECOMPUTE_CSUM, because
skb->csum is only adjusted for CHECKSUM_COMPLETE skbs.

skb->csum only holds the packet checksum while ip_summed is
CHECKSUM_COMPLETE. With CHECKSUM_NONE the stack does not rely on it and
validates the packet in software, so there is nothing to compare. Only
do the check if the skb is still CHECKSUM_COMPLETE after the run. A
program that keeps the skb CHECKSUM_COMPLETE but leaves skb->csum stale
still gets -EBADMSG.

Dropping the checksum offload is documented behaviour of
bpf_skb_change_tail() ("implicitly linearizes, unclones and drops
offloads"), and the stack does the same in other places, for example
skb_forward_csum(). The test harness has to accept CHECKSUM_NONE either
way, whether or not the helper is later taught to keep
CHECKSUM_COMPLETE.

Fixes: a3cfe84cca28 ("bpf: Add CHECKSUM_COMPLETE to bpf test progs")
Assisted-by: LLM
Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
---
 net/bpf/test_run.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 513354e928cb5..45718fa9adfd2 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1237,7 +1237,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		memset(__skb_push(skb, hh_len), 0, hh_len);
 	}
 
-	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
+	/* A helper such as bpf_skb_change_tail() may have downgraded the skb
+	 * from CHECKSUM_COMPLETE. skb->csum is then unused by the stack and
+	 * there is nothing to validate.
+	 */
+	if ((kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) &&
+	    skb->ip_summed == CHECKSUM_COMPLETE) {
 		const int off = skb_network_offset(skb);
 		int len = skb->len - off;
 		__wsum csum;
-- 
2.47.3

