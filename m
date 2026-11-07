Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794073810;
	b=GRZC176/oAzOiynfU62knKI7tqZCxcdQlG6hkaEGwEE5WI0MA2EffyWS+mFL0dIJb9Gd
	 +EV/cC2FfNFGLckz0SOHg0Lv1JPqzmVSD2zaCqra8n/IlWelpimLRv4cK6yeYPeX4fyrs
	 TdpK+O5+E7iumeM3tye07Dl61jsO+WAG5sNkpggzVMUKdb9WCfUFl2eLq8BQUUxqBBI/m
	 WUwEt22NN7ObNVsaIO+B1hm4f35wVfP8ubPDw6WcFmVPRsNRp51IDLsq+Jdwb5i92jnnN
	 jVkqpT6dD/I/EL04QnuZGOgiTjJRnNvP7eFqzhABlqdDe2CU9Iiq1B2b0G00WO0gmSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794073810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FU7hldyD1T2Gh72lDujQRuCyfKsUDRML9CjefsYYZfU=;
	b=PYKNdrftkmmab+PnmzPNsjJL+VOmCYa2oioiA947ZvD8n2mkh0YkKLbxaO6Wdqqf5xzk
	 cIprdfhr3D9ecXkdAIS2oQ8hyCOUbLVgi5yNr3z7G8KWaKKreQdaXXngo5y6NT9B9W8ZC
	 sZP9T0w79/e6mlHset2QCHbXNyS9Xxq++X/T/tgEOsouvWlVllafMR2SG/CPU7y3rWjG6
	 XpkUIaWGaiJmC21BpQIBgRThgFLokwOWiMI+jauNds74jFr2pTiLEl7kAtTC1E9oymsQP
	 H0EYddTyeT7clUrkYPXvqJEsgWPtAjZc7IqBGiaN6JOczAjJLS940yK4B1+7d8iJlCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CDdH+GLy;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA683606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 17:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA683606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CDdH+GLy
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a60f90a924so636827b3a.3
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 09:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794073809; x=1794678609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FU7hldyD1T2Gh72lDujQRuCyfKsUDRML9CjefsYYZfU=;
        b=CDdH+GLyUnuoMn5mnBMCEBJJMx7KbvZLXAOR8+1l8Z6tqTRP8FI2so1Eva19OGkO+q
         dByvXZzdqIAJB4A8IfB9MIwD73CujfRaeSPlFIwfPeb7PwWm0wI7dOJ7akbTdiKTwCtd
         JBNaQ4N3TqgDwfwN/JIMKCPnghHx1Xvhx8H+pmjmWQYxs10qWzo0G2c2bg5ylWNJy0h0
         Fn310szFHo7wM3brwKaO2m87xodlsUI+kxSbJIydRLEaJSFIPhQUmgPa7RX5GNgkJ6fP
         l87XY41nblcB1tsgwnypXb0buXHd1oZvRn8YW/2At/y1E3SwYTxCAyKejw71mVHVl+1Y
         SrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794073809; x=1794678609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FU7hldyD1T2Gh72lDujQRuCyfKsUDRML9CjefsYYZfU=;
        b=JVhLWynxjiEVIYR+RhMMrJjdqlCnV0ZZeQ08Zu3RDahTakOkm0NEUnAQbyeaJR5a0M
         YJbnTxLMTjdZcNm/RQFAj49FR7DIS06iTFD6IgzLmIOv+lHZocfwbfa332x0HumGl1sv
         0vm5w9NEGp35ukAdKIeHJoNdsMpI1k92Ehg41lSiYIrr9Ycg2PAu7J23r0bq7dSvwBGa
         EIai4FSFsus0DsKCte01w/HfhJy6q8L1Z0IFPFmdF9+oIuLd8lfuWnW6dd+nPqRe0oXP
         WLlGhezvvyqCRjnZJMaAsryI/I3Rp1hoBKV4BmJ2KRUZFoxn946e6YHj8JzanXhfmq+G
         upcQ==
X-Gm-Message-State: APuU4Z8crSrqQX1k8NlyAJFJdQg7trZyf4TCnOgynW7z0mgaaKvdeFXc
	3PxOTZW6WsAtP4JZIwaYwvUnQshhMCTOobY/UwYX587bXYPYqvBUF8MPG5XJCg==
X-Gm-Gg: AYBFou087LJJXC/6Wdk8Qmc0dDpGLEjD35yWZPuu6wWTh37BZiOxC2tY6nWJKky1XEt
	Kl1GxuZzXmqAP3vsLZMSgkFdXYBqb75DW4ybZa2BMHN5EGHHqjOA4L+OXudgzy/Lx4uko7zDwG+
	Kfl57V3UgOW4q2b1fZH+3ghJEdzieVVAVz2iDdSONPOb2NZbhdSI4iTKeO+LUUMEUrm0+8/BeIJ
	Q8x9UJuZjc1SqIZK2hMaNVOQKRNwyIYQQrcq5GNzciRZBOy3x4PVg9HKHY1t5F8DLHYoZnck2YG
	HuuNRReomvuK09I5xdoIbqudvSo+qDBqJmpoEWNQeXHs7JBkKLl6qJwobwHhvIoPt+QxCmk+vVh
	CFXuxcXCovgvB0cGk7KqrwL94tngpkxCA1EjXxIdGpGu8PnR+dhtvczd1UP10L5/I5B3FrCEGKT
	AovuLZBYOMSe71VR0pBolGBJrDQLYZDWBdGqpZlwvC6A1tDBuIU6Lt3Xwaa8/GURkzK/1nM6x/A
	GctPVZj/nTOwTQCEAGQUObBLJx4kRl2BFpAv2pXGZlFJ4rIOgh4vg7vm9bX7az03K3gkM8MFjG0
	imYzqPFJLpEO58yAGUHKZcv22OMEdCSfYhEJpm6m14QBAOOZtVf4rKcR/8VboTEdRMNzMik2jMM
	X9LS388hf35+T39h5JM1cCF8q30lv341g8Ib5M9O24+3s5mWOFT3BC4kE9he49cTIxnGDkIoJPA
	==
X-Received: by 2002:a05:6a20:b096:b0:3de:b120:bba4 with SMTP id adf61e73a8af0-3ebb2a58c5dmr6008849637.50.1794073808713;
        Sat, 07 Nov 2026 09:50:08 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70aa3ffasm1576733a12.26.2026.11.07.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:50:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next] bpf: Don't attach to a subprog that is called in a recursion
Date: Sat,  7 Nov 2026 17:50:06 +0000
Message-ID: <20261107175006.3591773-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

sum_to() of verifier_budget.c calls itself:

  sum_to:  if r1 != 0 goto 1f; r0 = 0; exit;
  1:       r6 = r1; r1 += -1; call sum_to; r0 += r6; exit;

It goes on while r10 is in the upper half of the kernel stack. The lower
half is for what it calls. check_max_stack_depth() looks at that chain of
calls when the prog is loaded. It cannot look at what is attached to
a subprog of the chain later. For that reason an extension cannot replace
such a subprog.

fentry and fexit progs can still be attached to it. The trampoline and the
prog run below r10 of a subprog that passed its check. The frames of a
tracing prog are in its private stack, but not all of them: not when it has
tail calls or uses R12, not the frames of subprogs with stack arguments on
x86-64, not the frames below 64 bytes. Such a prog takes up to 9K of the
kernel stack, and nothing left room for it.

Refuse them like extensions, with one message for all:

  Cannot attach to sum_to, which is called in a recursion

The main prog is never called in a recursion. fentry and fexit progs
attach to it as before.

Fixes: eaea73907052 ("bpf: Allow recursive subprogs")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 09a44723bb2e..4a4d970627d1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24047,9 +24047,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Only fentry can attach to %s, which can unwind\n", tname);
 			return -EINVAL;
 		}
-		/* It can have tail calls, which are not allowed there, see check_call_depth() */
-		if (aux->func && aux->func[subprog]->aux->in_recursion && prog_extension) {
-			bpf_log(log, "Cannot replace %s, which is called in a recursion\n", tname);
+		/* What it takes of the stack is not counted, see bpf_insert_recursion_checks() */
+		if (aux->func && aux->func[subprog]->aux->in_recursion) {
+			bpf_log(log, "Cannot attach to %s, which is called in a recursion\n", tname);
 			return -EINVAL;
 		}
 		conservative = aux->func_info_aux[subprog].unreliable;
-- 
2.55.0

