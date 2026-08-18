Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F3306744
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787088314; cv=none; b=LzVg/q1fVMo99/D1CvOI7vUooCqUhAfD9hB5XQjJb4chpESNUuC0G6GSKEvmTIONNUrYCcleFf6V+xhs+8v/aHrMWoZUFw+gE7+sGBUAUcDT9Ly6xBzOQmVayGGdT2EJhMxveRpvXum00951lLaUgQ8f0pXDdcBqHDKndPBmwG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787088314; c=relaxed/simple;
	bh=r2FgQ/HdyGi2HS8tZDe+weZ55AOvx8Nyoa5GiLqke4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQNrCO4RXbMO0MbGd5j9v6Msl9FLRvE3KvKIEbDR/oOGLODztO82ucfWdCCmqgnHtUCyUWmLonpzyL4Uk9AgNWBoA8zBT82n7CmU/tr0VZkTo0D3fTETayzP1dJRytCfA92rIi3k5bLl+3N/PnT7wf4QAOaax4kAQ2Lu8MIt+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mcyd15CF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mcyd15CF"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso181297a12.1
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787088312; x=1787693112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LMyxz9jOaZnEGXaOhUkxWJff/1PqbJKX6RH8c8vpkrw=;
        b=Mcyd15CFWjDM19CCjAwPe/Qgh1jXWxAWcUPtomWTI2dBTDQ2wqpMylXMdZjTnmXyAT
         xDW3aml5r8PjpER54TE6adYO7OYmSL+zzK6veTXGhvbfmVx/IxJQwYpcUYyogzsukGgi
         NGGdg+dvFmJ5TNXs/iTxHn92//U3lDPwJ9WeLYOqMbsrCfRvvA5n8VcCzxKKYlGgxpVV
         3ehS8SCyXmypSm5c4DgBPWwzp+HvdY263O09//znRWmtuBnS7gVbgZkcPVySi0DqDP8L
         df2sxAuv34PmF4oISf6MMY8d52ItIEGLB3ocj5HLNftNvx09aRGVuUZ7yGzQk0BxjBgL
         QH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787088312; x=1787693112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMyxz9jOaZnEGXaOhUkxWJff/1PqbJKX6RH8c8vpkrw=;
        b=SYrQmdDB0TIHniyS14Y9T8VQoDfFnWEM4WqvesiqLAkpJAWLIu+EETFHOWKEJQjIzB
         MlD/pgwRr2yl4qCoMa8EP0yMEq9csRUhUwT//ZaBwc411Yr8mV5OChamse2pbpJGm/n3
         G/8rRy2VWvmGvRWD565O2uQhM8sm60dOGp2aqNM/y+BF0FffOSEk6Ooxqrhim2sWa93Z
         lyR+J0b4sSyOf53TKKg26bl9hA1vskaVpK13/+t+G+D+8BjsOybb97kM/19oKJLCMAka
         QbWX8JRBhPAo06cZb8r+vMwjX3794ZHwwQCNUerF1MASVgaZ/YhwnWkj6EtIy2Z24uxa
         3fvw==
X-Gm-Message-State: AOJu0YwWhY7L6SxmNYeSbtvrYTKTz9n5b+D9zFTZGtRuG1QL8cVqXAHE
	DvEBmf9JizAeKdEXaDQuveG4GT5h+iK935a3a6j5ubDZ2Yuwc2MjcwenuuR6aIZ2+Xk8rA==
X-Gm-Gg: AR+sD13GxFaoYpWcabbAjUgV8eJrV9S/6rlQyh4Zf6arBsOtW85+QPq2bfySf1qZPmQ
	c7dQSzh7gV4yHXZ7w3ucJCbMGDrcKsULEDFj7zLJf9oF7uOuSAfXtAGDfBbhGXdEcwOnKXUTOfk
	AwMBgxDlFP2oFlMcHxnssjL2lzeJgNLCt4E9ck8+z05eR0VwK6AIJT3JX3kYIcf/YUtyJ5GsQYp
	mzraMo2enZfr1SevOy3709ChTXNLWpKaMDe70lnuwvKoTf7wxrA0LF6T/j5rKQuGrvN6jWFZyPi
	dTtHY5BgWVFYNHF4nSwGea1Ko6d7iT6m/TfqhaWWINbtVPnI05qdUSJw3JiT5HC6r3HeLluywvz
	QK1Dm4tYuMISt+E9zHMg4upZayb1uBQHJFnZECBBwCv4ebS7zhg2+8Jqi8QaM2SsFmmDuRC5ayp
	1YkCApc42Kr2SS+TONy4SS6Ph7s+94a5EzrvkF170h9zx6jprUDRw8R/x8txFQ8ir+WvT5P4K4n
	X9bDOTtpMPbMBQnjS5hFul7SYk8j2FXmh+43OzZBA==
X-Received: by 2002:a05:6a21:4c03:b0:3c9:1c1f:f516 with SMTP id adf61e73a8af0-3ccff029346mr1238565637.19.1787088311749;
        Tue, 18 Aug 2026 14:25:11 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326793ca665sm21941057eec.8.2026.08.18.14.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 14:25:10 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH bpf-next] bpf, verifier: Invalidate dynptr slices on skb_ext COW reallocation
Date: Wed, 19 Aug 2026 02:24:48 +0500
Message-ID: <20260818212448.60816-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When bpf_dynptr_from_skb_ext() is invoked with BPF_SKB_EXT_F_CREATE, it
calls skb_ext_add(skb, SKB_EXT_BPF). On cloned or shared SKBs, this
performs a copy-on-write (COW) reallocation of skb->extensions via
skb_ext_maybe_cow(), dropping the reference count on the previous
extension buffer and freeing it if the count drops to zero.

However, bpf_is_kfunc_pkt_changing() does not include
KF_bpf_dynptr_from_skb_ext. As a result, the BPF verifier skips
clear_all_pkt_pointers(), leaving previously obtained PTR_TO_MEM
dynptr slices pointing to the old extension buffer marked as valid.
A BPF program can subsequently dereference the stale slice pointer,
resulting in a Use-After-Free (UAF) read/write on freed slab memory.

Fix this by:
1. Adding KF_bpf_dynptr_from_skb_ext to bpf_is_kfunc_pkt_changing() so
   that clear_all_pkt_pointers() is executed, invalidating any active
   dynptr slices across the COW reallocation.
2. Updating __bpf_skb_ext_store_bytes() to use skb_ext_add() instead of
   skb_ext_find(), ensuring that shared extension buffers are properly
   COWed before any byte mutations.

Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 net/core/filter.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7aa47342dc65..4b584ec6ef2d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11243,7 +11243,8 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
 
 bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
 {
-	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
+	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data] ||
+	       meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_ext];
 }
 
 static enum kfunc_ptr_arg_type
diff --git a/net/core/filter.c b/net/core/filter.c
index 11bb0d236822..a9a164738389 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12290,7 +12290,7 @@ int __bpf_skb_ext_store_bytes(struct sk_buff *skb, u32 offset,
 	if (unlikely(flags))
 		return -EINVAL;
 
-	ext = skb_ext_find(skb, SKB_EXT_BPF);
+	ext = skb_ext_add(skb, SKB_EXT_BPF);
 	if (!ext)
 		return -ENOENT;
 
-- 
2.43.0
