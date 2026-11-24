Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546630;
	b=2GXBPo70tKmkVJmOVCogAY8KW6O3Fq7qx8arLEN1By0poGu24v0AdWWDgnwlgCnnnFhT
	 Iy7ZFEZ281C+jbQ626bh1SZoHZ1ozREW21ciW9EHVyik68vzyjyOx6YPNo149MWr5ZaE0
	 hGPv6yZrj7j/B6ce7vuexAGK7jkclW9H9gjUIEJPXCdgv/aH1hJ/+GGBeyTpeHwMBUIDK
	 MA43CoB8S+X/AI/YI0SifM4KcEiudh9XWASrjtGTh4rpm+25jlQ8kEM2DpTgo7fsCzd3r
	 IoNJFFi/jBjIEph96nzcbV0c7BHkVBQHMtWBeY9zHyf45ckJKCZodEqEHGCZHIFpwGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=arzni2V7CrMLgh1PEHwqbV/RWJ1P6YxymRnMbqwvePM=;
	b=Ak2+tmmUpIfUq+HgPsY9VED0VtqUTJEkejcSTH9+lJwZcU4y0+xbMaQ3YZ+M7nVik5uk
	 60cQkoev68UAFFL7Vn/zt945HQzWV87QkFRIgsYYQWphtWXs1CknzkDCniGq6qcIT4MFb
	 HBjX3WHvIYY3/uM4uUch0ZM4qBm62Xs6WtIM/Wru+N0uEXwTQxFN3szj2mydGFXKcoceG
	 aPPixiBER6dBxTOZq4OH+I6D0cc6rycaE8x5Lpx94Xpz+VS7maOHDKwOfPWvlodMwR1Sk
	 fTmJdrFxXj2UOR8s6FcfH4mG6ofRfIdfzcWriqFtbiQijR5kNRA41XnZeI6/pmW5sjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hphrqmhn;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E673606A326
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 18:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E673606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hphrqmhn
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso2588900a91.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 10:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795546629; x=1796151429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=arzni2V7CrMLgh1PEHwqbV/RWJ1P6YxymRnMbqwvePM=;
        b=HphrqmhnFR6ceVJnnr/kHMTyQArxBxTQQMxHXWQBXvUpnd0mopwa5nph77tZLWcR+f
         f+aGEN1hVgFAhXGuATZk+HJakseSOSMwnThINi9mMyQim7ddvjAjdlCCfGxxETUdYq21
         ggzb/aG9I/pOBlMvZsMW8pjsuqbB/YGIpij6+c4/E11UGNSZFMK9vbfRW+QySoRQgc+7
         lW4DgB8aDyn6zY4e7hw+17dI8liB5BBLFM/5kdWShHl8JOT9y/ZMPNfJ1riwVEe5RvQe
         f0/hKObHkjQTqspjMa5cBCl9rNp8+RQeln/CdiTz5KaraLdVN9bBhhXScLxo3PEZS7WE
         qvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546629; x=1796151429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=arzni2V7CrMLgh1PEHwqbV/RWJ1P6YxymRnMbqwvePM=;
        b=sEiEZWXAqaIP9LZ+SKeeKSyngCpnUNhwkZZGDnLjI/KZWcuXCIy3Si2KNLEUKOf07O
         ZSJejQU3BLa1N5+zu+40tRaPwOf3vZeYIdmW1GOEM1vS2DmFHE58+0YLIdnSjMn3g4Yw
         opYwVsrnRnMlFctFrp76pVoMHwS6g92pacNkKdgJSRtwz2UYEbqQdLv4J4tKuy32H1bv
         DsEQGQlFsYsyeDty2+wqSZ3r5dT9fvGw8VVCirU1kbWy0NtvuhASihzbb2zZDBrTROkS
         WfESKH72ieziuxFiiX0RzDdj1pe45FGHEaJuNLEpZRa71Wk8P7SzwHJttezAoO95YCqq
         8mhg==
X-Forwarded-Encrypted: i=1; AL+hErGUHSskw1K2T/WPuf6oCbH8Pe02xDaG2Ebp1yV7FpqEqtUDTvURIWR9VfFTtG7b6jsKvfM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZbW3nFQa1OyozyMn32grqq7i5xBJiiF9zkAX7PnG2gBzXJaYW
	YHpDhJiyQOwSPt2gehdwLvXfMH0XoyU6/MnbWSky+Tf96oMZX3gBykhC
X-Gm-Gg: AZFdTZdlWCg73JYnYsVgDDLsNrSfWPfkSlqf8RLkF3pNgVlwIz9q4Aj28RlPZIq+fXY
	pnZmwU5dCyH2Z7BrPRP3dfpoc0CH3QAJCTfVvAY8vY/7mkJIm67HBru4PDr243QEwdttYroN5eK
	Uv79DxfMLbIW2y/AVXgCsv3Tl0B+rFIpkg3ZryAo14wZ5ZP9QY3y2je+NyN1etF4GtQOmNjAV/1
	Awbq6mM5coJ3/+IaBDXVm2+BmZMEUkJHCTmBa0TjqTekKM+c1lJ4gVk7dSli4J6RPa8eENbQVca
	s1xD3RKdz1SGG2S6AqQ3Anb3/r81i5RiLh6g8A6ntMkXloDFkbnYz/AQ6mgulXTqvlxalts5CFh
	zOkd/XPkPpXjQb4lbgHIrGU0CajStY7bsrHP4Ww59IklLFDkWa2fx9wmMhePkOlqKiF9OObbNes
	QDxofs7YzhC1ODzfp0umd88TJFHRpfZxGVl+h4JF9193m8gkQHAz8SAqm3KF5PRQ7q8eP/Ly7N2
	r0+bfaUw32ODOQyW9HPnaWhxYz3jayyJbZVAdgddoETosMlkI3PTCE9NiBkn8Ss/RdDB99Uphin
	fatp/knivASmZ0SSZbUED4Ici2N/8VDMBfiUmMi9wFPJL25/4WdUmNl5f5EXR1VL
X-Received: by 2002:a17:90a:d2cf:b0:3aa:f2c4:12e9 with SMTP id 98e67ed59e1d1-3b41c7c22b4mr13144995a91.3.1795546629335;
        Tue, 24 Nov 2026 10:57:09 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm26499487a91.14.2026.11.24.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:57:08 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] rcu: Mark rcu_read_unlock_special() notrace
Date: Tue, 24 Nov 2026 18:56:51 +0000
Message-ID: <20261124185659.1370644-1-rhkrqnwk98@gmail.com>
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

The BPF trampoline calls rcu_read_unlock() on its exit path. If the
task was preempted in the RCU read-side critical section, this ends up
in rcu_read_unlock_special(). When a BPF fentry or fexit program is
attached to rcu_read_unlock_special() itself, the trampoline runs again
before ->rcu_read_unlock_special is cleared, calls rcu_read_unlock()
again, and recurses until the stack overflows:

  BUG: TASK stack guard page was hit at ffffc90001657ff8
  ...
   bpf_trampoline_6442575622+0x5e/0xac
   rcu_read_unlock_special+0x5/0x490
   __rcu_read_unlock+0x9c/0x120
   rcu_read_unlock_migrate+0x93/0x220
   bpf_trampoline_6442575622+0x5e/0xac
   rcu_read_unlock_special+0x5/0x490
   ...

Mark rcu_read_unlock_special() notrace.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ae5d21bae7bc..a887ab69f486 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -746,7 +746,7 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
  * notify RCU core processing or task having blocked during the RCU
  * read-side critical section.
  */
-static void rcu_read_unlock_special(struct task_struct *t)
+static notrace void rcu_read_unlock_special(struct task_struct *t)
 {
 	unsigned long flags;
 	bool irqs_were_disabled;
-- 
2.56.1

