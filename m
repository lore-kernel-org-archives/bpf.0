Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926A409295
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763805; cv=none; b=CuBFrmJ3kBdEOKCM6t9jiAzrChG9qzOUgR+CDFqjmQaxpw9LAGFyFUFDrW2pnu9VSfbkCVYXnGYHSBFcw68xzj5oQFtqgWjTh9iWDoQcX7FWip09NmWJ0RNKKzaA/iD8Y/iyecHPXwfhgabu1RqBWUaYJQm4Hx/womtaYT1lj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763805; c=relaxed/simple;
	bh=GnAHVebleQJJnmt8WC+Szgot5FGZ67IN3635nKxQqYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/JKtkEb0/Kc5b5PQeviu0EtQFRu5qPmKOwFJclaEs3nTaxQXtXOdWBHWWw4h9D08g5bGAmqqpPGDCg5W5FwD6CxyUpEwRy08Nid915itNP0ELjD1bPDp6y9PGMhxqPg5yUVhNo0N10z1T6Ir3ymSoF2eym9fZnC3dPToXY1FmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoPAS09y; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoPAS09y"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1c9879395so2152284a12.1
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 23:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763802; x=1789368602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kcyHQ8J0eTBJ6x/cyto2HEpUStNZUbDWvhiih6YejS8=;
        b=HoPAS09yLbIku9yxi/P0ZN9wtj+LiQa3JE38G9F6zTXwZrtzliTdUUj6BmuK5jBO39
         6QgtMSAvnRhh6lo5pAfo2DgvczANEkHCSJvLivoJOq4wkX5/J7IWNxmiGVyF6hi9UL6n
         v/paFgEU4Rz8XGd2kXhvlOWOaie+VpJcQywBJuANvIBmQQ0J5vnYPLAjINn0OG4aeSWo
         98HRPXfE4kKPhszeb4spLNxPXQ94IFscnY7Wj5GnC1EijiUaXIMYwene32SGZj1l3MmP
         /SKJeoEcYLGuCInjw7cKYWmI1AJ/3WfRihgjnEZ+ezcIss2/6RkT/TY7Gs8U4woyNAA0
         XP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763802; x=1789368602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kcyHQ8J0eTBJ6x/cyto2HEpUStNZUbDWvhiih6YejS8=;
        b=O+wyrqxOt7mH8xyFUZFOecV2K1GbbFLu5BGhTRT8RLIbqVgYv69Ytxrp5QJ6qhaD1a
         7w+6AF4y0Rsbv0Biro6vLqPGJS/JN4o+pJIvozpAzzDX34LMROYYI3Q+1Jgu8Cy+TDHz
         vwNGL309YgGGJF0MRJYtSuQMXYclzmRnYHq4n2GlNlZO+835RbiknQBHfuPZan3e5AkJ
         9RK5tWBXFn85jIN0TUoJjlJ2xTOr9WWM0FaqFnvhCJSaeBpBHRpKmghAh6PShu4NxvUz
         eMaDmbAnQjOLe57TxtQxhYzu2cJdn/VioAPxCz5vZ2TnZ9aguXXLG46dLd2YgqCMDNEH
         fmhg==
X-Forwarded-Encrypted: i=1; AKwUvBxNJh2SGmVBIUEqwrb7gCtBxeDq9VaPF8+40Wq+X2LVKyHXjdge3mSfmNFaJeyISpt2fT0=@vger.kernel.org
X-Gm-Message-State: AFuF++nsiOBj+3LsgBHJdqEzUTAgJHH5WlPz8U1yuEoJdfcWYZOtlpgJ
	sVdFtARXBYwrm/DCfMPJf2xhqgD4MNDSuEq6kjhQo/Q8/OO59qKaBQJV
X-Gm-Gg: AYBFou3P8IN/SL1uz/cqg3QIO93ceqSgVZK8yu16gYs2PvNvuet51iLoJQ5jFKMv+tF
	qr1Tcix1Nh4iPMBLVxVGfLX+1M2kMYRyhs0LQmEW4wpJVfBX7ea2eG/InfaoRXbXqr2gtmWU2aN
	c+vYYiET1P2kPruPdyi/kZ3UMT8ZGy/jG1DSl6gmfu8T5yqIeBEm99oGTKfYTTKCNroGfd/i7c0
	RxD6U7CAkh7pX0Czv74IAJVE46jvhh33u6BXsRY6JhE2/ZC2bPrNQKYgEtCEQ366CXqgN8S+8GE
	nCOUiX2GGr6vimLHdi9MjJUPXgs762W211EgiOtKlkGbdoD22+KNgXZKaYG7i2vjPFZnqf00+L7
	hFrzFFKEAsW4WAnhW7nGO2njRUrmV1drSDxRPpxv7ArhQZ+SDsExILEtDolp6NmSRAqTtiQ4tcF
	+sAslYBbJwegP5VEL97M58fvWyTElchNW60Ab80wExFSw0aeQhumzF0+EuhgoTQ0qcr/pkZ8C8b
	w47v59BW1cEMg==
X-Received: by 2002:a05:6a20:5681:b0:3cd:8bba:824f with SMTP id adf61e73a8af0-3da39eacde1mr33933937637.4.1788763801799;
        Sun, 06 Sep 2026 23:50:01 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338778fb926sm465210eec.31.2026.09.06.23.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:50:01 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/2] tools/sched_ext: fix repeated word 'be' in comment
Date: Mon,  7 Sep 2026 12:19:43 +0530
Message-ID: <20260907064943.25304-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907064943.25304-1-hemanth.selam@gmail.com>
References: <20260907064943.25304-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'be', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 76f5e025e107..9660b43d612c 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -306,7 +306,7 @@ BPF_PROG(name, ##args)
  * Similar to MEMBER_VPTR() but is intended for use with arrays where the
  * element count needs to be explicit.
  * It can be used in cases where a global array is defined with an initial
- * size but is intended to be be resized before loading the BPF program.
+ * size but is intended to be resized before loading the BPF program.
  * Without this version of the macro, MEMBER_VPTR() will use the compile time
  * size of the array to compute the max, which will result in rejection by
  * the verifier.
-- 
2.48.1

