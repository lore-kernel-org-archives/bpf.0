Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976EC378D7D
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791502588; cv=none; b=ERSqyS4c630XdCdoI8XGNalXNIy0LoaouzPlE/f1BOZ8GRZoMENkE2OwT3COMxyvmOjbwH2iXq15en5vxxtY5P1OP1feQSrYn+HIHd7h2uWXi5CR0oMSZp20mQ4jyXK3ZmEl08lXjhgTGr+1INm7E3d3ofEBHSob3h4fu6quyyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791502588; c=relaxed/simple;
	bh=z9XdaDwozt4DVNCBsjCCo4rkJo41je1Q1+kLf3Q23Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tnkmo4CO5Dg5eePaS2AfBfT7+Wnc7pOKfsNoGmeNL6eT7AIHk+8iP0CGihBe19b90shI3+ZWdMMnXNF5RWKJQlz/Whmz7b94LHKdKuFzyktzu+pgpM6JYZ7L0++e45I0cwK2Pn3Lcwc22to7YXk3o9JB3UVXOLWwzEvqvHSCl/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKwK7lCv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKwK7lCv"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e4c00d71aso281179885a.3
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791502585; x=1792107385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H0aMo8yA757AIchUgl2zcuEjDzZI6HgSNUOupZw3Xrg=;
        b=kKwK7lCvJz1wVTkLfGaKVKfr70dIJRtyWct7BtoHRxe3CXDSUhd4E2lyJhjnrN4m99
         sORMFy7GVSAyMIOUouqjD03TbB0RbQBeyi4xo0ZHaeZ89XjWXO0pqcjBdWXsyiY/L3Ul
         16zGbHDwkQYLkTKD1wiKQ0aMzufklwBVhfOWabGS6h6AcwxBU1AHPI5NTcSmhVTPYZgW
         LD9j6b5Kwu3XZY7Caigs/5NY4keHAcTyihauPisaT+d2XHnoRGeoTqqgTXHxizQVvt9f
         i38990xka5QM+qq/4qk2Cxabe2eQzcMXqIRb1HsWtXHeiXC7UK4W1PAoZosgMiStREX6
         3+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791502585; x=1792107385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H0aMo8yA757AIchUgl2zcuEjDzZI6HgSNUOupZw3Xrg=;
        b=g4LNAC7TIh8zODOk+Vg8tWb7UvQEXbsNf72UWFhn34lTi5ShikXTFQpsh1Oq5q1hD7
         1De9dhurjn/1o3P5FtnGt5Bf0/KqCdlg502AjXIayz35KGYt9KC+uFL8SJrSySQjXrwO
         GLFBr3FELILccveQ2kEl4FvXkmx1O0E2w4u0mNgTen9KOWungEvfOk3jR0Jbc1VZCfS2
         H9Iz2l7APr0zWL0dLuy7WzgtmeCy5EsLKt9mOs7Mc5ivSDUS4CUvASysY1hlRgQRhtaV
         XasNJ/3h/ydvtifx1JgTwXvyRjlQZR7gvhI7dCaqUOrEIW7qlZ1IOHiC/98dICXMYkoC
         Gw4A==
X-Gm-Message-State: AFuF++kSLM9CitPrFVn+vGKKYRfIPtWUkQeMTZneJVq5E/mXlJhQ9emB
	LqWDs3SpF2SNLrAdaaQATA1KgHRysnuX0dpyhdX0V5xS0ZgSSdofjOypumasClgk
X-Gm-Gg: AYBFou24C2j4DJKLYT5nwHLEwcpfLuCozUKS7cH3UZze5oc/SSAv4td9GSGluMR/TF2
	tAjafRRHe/BMr1eW6xLmPpzwowGeRqJIXgL2s3lTfXmGNA42s9ayyDbpe3HlXCgWEDlqOOd36zv
	din1JRe9dthWTnRG5vPvsJVGi2fsbhsdn9DwmrnsaRBoJ8Z6W0/qjraTA/aFqxQ+mw1Ip3pTF+0
	/8TKBxaUuKSHSANR7G5zAdhIieDPurqkvSx+G1nyPHalxAVgZSePrEiM28HcQklPISuhZCHi+wH
	Sndf3bt4t7SpktnfEGoJbsmE9qnC3P+PqUi9asCk008xzzxoyVzvmwNo3VyoMOV+EdPTdbxZzxj
	gFBnrwGeFf1GyDUAtifpP7SzSWyVvvWfalcIy7qTewxl2FQuE1Mm7R5rBcqwV1AW/NqUgivjucB
	0weUGQGXTSU9GHu/fbg9N00G2NjmEmgrCzywl9EHvGyk2p2V6HeMisUS/mv4nwuPax43BPdB/mL
	51WrfInvuAE69VwCJncgABBqrD8a5nV5IMvpwa0OLhRUdRgCOYMT7r4CMqaMTLryDzlKkrOmq9t
	VW3LofgY
X-Received: by 2002:a05:620a:890c:b0:93b:d7a0:d9e6 with SMTP id af79cd13be357-93ebd2675e2mr26192385a.64.1791502585481;
        Thu, 08 Oct 2026 16:36:25 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9848702sm51693885a.12.2026.10.08.16.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 16:36:24 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yunwei356@gmail.com,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf 1/2] bpf: Fix state pruning regression in bpf_loop() callbacks
Date: Thu,  8 Oct 2026 19:36:22 -0400
Message-ID: <20261008233623.4011127-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f597664454bd ("bpf: bpf_scc_visit instance and backedges
accumulation for bpf_loop()") left dead stack slots in cached callback
states while SCC backedges were pending, defeating state pruning and
causing previously valid programs to hit the verifier instruction limit. On
affected kernels, ActPlane fails to load with -E2BIG.

Removing the incomplete_read_marks() check from clean_live_states() is
safe because zero-branch states have already had their stack read/write
effects propagated into the liveness masks consumed by
clean_verifier_state(). Pending SCC backedges only defer verifier-state
precision propagation and cannot add stack-liveness requirements after
cleanup.

Fixes: f597664454bd ("bpf: bpf_scc_visit instance and backedges accumulation for bpf_loop()")

Signed-off-by: David Windsor <dwindsor@gmail.com>

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e3814152b52f8139a5565b2e4ac1b80d82d1ea65..1e300ca71a8a833eb4c2a340b4f94342f54af5f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19791,8 +19791,6 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 		if (sl->state.cleaned)
 			/* all regs in this state in all frames were already marked */
 			continue;
-		if (incomplete_read_marks(env, &sl->state))
-			continue;
 		clean_verifier_state(env, &sl->state);
 	}
 }
-- 
2.53.0

