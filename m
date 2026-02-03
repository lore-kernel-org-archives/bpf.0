Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206672F12CF
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770154488; cv=none; b=bMSeDHLprXu/a3l4+f8ayol/KdbRfTD4DPpGhAsg9Jv8o2A3SgGTUUbTxGqqbdael8tFUYC1H1TeKueOq7PN5T3XuMNlBWAPYN/sNQHv7hAfL7whyAMlMgE7Tnk11fLH92O4cnxGeZvBfrBmUsLXQ75qPm6fyvwrGqTH+ArgBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770154488; c=relaxed/simple;
	bh=cfUL+QBLB2rC0uMmfJo10d4zYQEiZ5xQupjfnOTI7z4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j7rshfxmVvd0R7+TslpZsDO+eWdb73j6FaFJyAqeCmaJVMlTB+pVgZnavlwp1GWeAOvxUAxDGLQQP3HcC1GpNgNADaO9JtoQ2nvVpMdbqFrwHNtKOtaygNnn7J+LCbHqM3rzGrDQhjlqAa4dnkxlePJtFRBMO+SL8hlF0P0vlcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=agikC0kS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agikC0kS"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c6b1b22b134so1095039a12.2
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 13:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770154486; x=1770759286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJzIgisjODq9k+q4iYcmrXlk9lhsHBo7an9mjRBWdmQ=;
        b=agikC0kSs415UUxUwojBF042Xy9arx1OUm+5GgilGpZc/uep03Y1E8/b09qDLozUdK
         nJQqTQehm5Y3TLb0PXqT3JkBsXF4Zy7TVW/UTIz3q36eMt6WKgrUuOyUsF/Y1XC91EZw
         24eiViZjs91V6UxnPpi57ivdwarLEKoHPpWpBL5+NMR1N3BlbOe1/wApzE3tUMyLJlUj
         5R4d631G1EPsfVUr62TxFYnJTW8rm0XokDoifgk967Cju4pC8Wz/l6Kkfg5mHbd0u7YS
         cLe4gyX+tih8Za1+QaI3igNTxv/URd0E45eWHiEK333e+F9L9tenBZLOJhjL/D3UpS7U
         08TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770154486; x=1770759286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJzIgisjODq9k+q4iYcmrXlk9lhsHBo7an9mjRBWdmQ=;
        b=vq3m+VJonLWvB7CnYZBcrjtuCO7J0hOGPtL6sbSjFGlbyN56CkOQv3M5V7DXo6Ngv8
         IISIjVIqjRojhDZOSr6aQbesmHpZQv9nFHZepQu2iGKVEcjEKppw1+JyETykiwiJE2RA
         VW11QLSS7y4Xq6g3ZWrzPGj6d+0XJgV3T01WOgno+lDcpZjoOcsRbIik+4UN+HhX1x7Y
         nUnvsqK+B+LfoZU8o2aUTDMzD3tR3ubzeDG/B1Fm1f8lpUfgM8IZFu2jyOkOCa1PMMWO
         Zcstz426MZVY3R5LMin27KFPFDKcmgSaD+UCUOPHkTmUVgVyc3CIkaYRVl0eThfDBvtD
         vfNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdYPpLp5/+gYDN4dCH5JEufInrnQTbmvLuIMC64QVzqqxzs270R6Y94SwSr7/nmgOoDso=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUxLsBSzD55cJjUHrmaouevsSglohE/355ERRdAeAJ4r4pNtys
	UtxOp6ym3JSCPeRCmJg/1Cag58eCaGUivwRBZB/rCKyMACcVjbXug8wXxxPkJeNZFZV15PWpFWe
	kaFOtjA==
X-Received: from pjbqe1.prod.google.com ([2002:a17:90b:4f81:b0:352:b687:3b20])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b02:b0:38d:f084:e342
 with SMTP id adf61e73a8af0-39372437323mr653921637.48.1770154486339; Tue, 03
 Feb 2026 13:34:46 -0800 (PST)
Date: Tue,  3 Feb 2026 21:30:06 +0000
In-Reply-To: <20260203213442.682838-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203213442.682838-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203213442.682838-2-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 1/2] bpf: Use sk_is_inet() and sk_is_unix() in __cgroup_bpf_run_filter_sock_addr().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sk->sk_family should be read with READ_ONCE() in
__cgroup_bpf_run_filter_sock_addr() due to IPV6_ADDRFORM.

Also, the comment there is a bit stale since commit 859051dd165e
("bpf: Implement cgroup sockaddr hooks for unix sockets"), and the
kdoc has the same comment.

Let's use sk_is_inet() and sk_is_unix() and remove the comment.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 kernel/bpf/cgroup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 69988af44b37..b029f0369ecf 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1680,11 +1680,7 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	struct cgroup *cgrp;
 	int ret;
 
-	/* Check socket family since not all sockets represent network
-	 * endpoint (e.g. AF_UNIX).
-	 */
-	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6 &&
-	    sk->sk_family != AF_UNIX)
+	if (!sk_is_inet(sk) && !sk_is_unix(sk))
 		return 0;
 
 	if (!ctx.uaddr) {
-- 
2.53.0.rc2.204.g2597b5adb4-goog

