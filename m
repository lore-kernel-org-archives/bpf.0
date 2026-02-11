Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD60346A0A
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833575; cv=none; b=tzYmZCX8jYbEmNOqE9RgYROXI8Boq/2rNWmX/ojKlD8WROOfjChYHBo/AIMpBRkLHV9jtnN0ySL/apAOQb35yp3OgArUnmxzvjX++JBYeX2ZS0/ibqlc7pi8o/djpwZ4qxj0XFMlZ8/7f7i1dUeqQ+QYqX/4CXYGkIcIL5OBrLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833575; c=relaxed/simple;
	bh=/+Wqp6gff6UDAUk8LigKRqxq9TN0Zr9nbrmOfygsRvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVygnTfCiyQ/VgfjP3wSA43mmK0uPOTmWxq654FLpe8lYTYuHY7N8k3fUsjrL2qjx9IRHLras0P1gAW9rQmN1JYyVhbnczEPsiwIKCC44tqyFFzY5BVM/fk5QeA+MdvNR27lo2+dh0QG02U0pJ/GTVkdKSFL8CDDW/xKjMb6tMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoWzaPXa; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoWzaPXa"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-45c87d82bd2so4455291b6e.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 10:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770833573; x=1771438373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4/kortQrGco8FRPyQ3g8+Khvd3BMUv3bPH7eGfp65E=;
        b=KoWzaPXa3VvpqSZotdAtzxUL0Zkzo0/6/5HqWfrWgY7JZtM6vvf9LbGWQMVZBJRKI3
         zDLKkP67HLswh2KL9iI039pvJqxk1lD2Bh5+CcmCuEEr2us498/c978abJyZf1Gmgw7t
         2DgZ/dalDMIj9GnFrgWGuMcmxAYNuzbmI42lrVJwejHMG6VzrTXAoGjls/4n6CH5X2aI
         8Wis8gmwFqJ08ca36RvPuFjDtUOJJb8O+q38Yv7EnOrZs/7/W5acjc0kWaniAjht0K+p
         RVsDgsKgvIgHdc4DF5Y5QWQSDFKM5xoNqHPcsc48lQ0c+8gZvc9+UpL4Squv6m8tjXPc
         OOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770833573; x=1771438373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l4/kortQrGco8FRPyQ3g8+Khvd3BMUv3bPH7eGfp65E=;
        b=aplZxgavanAznOxghAxtnEVy6KH+AkVdWMf2HGbA8NAla9zawq9Aiq+Z9qvM2fGZ9I
         Fph1A3APugGgHIiL4eWr9LOfgOHjVTxRwgBOiVQVJocxAmFc1eA1Tf7csy0v3GvFlk4i
         9PFN8Q9UAmSIZW3YIjTaU5s/x6Szb57/WaEQ5JcDwQs2zJn4z1HURD4U/93pP9zcN8SP
         fPeDQmIrHJVHKPurYiUh5mixn2hhGz4hrU/BQA0WmRWR7a76zNRWqCljhEphTCLNGQwS
         Mc01McDPsrBiD2Pa5wIeaqgUIXJZZb+ya7SsgRmC2X5ES20V1KX4iyFtaLfJQvXJXJBb
         I74Q==
X-Gm-Message-State: AOJu0YwqzXmGmSsZ0wNbi2K6OSbO/S7Hc9YI0q4/CvA8nJLcWTNZY00H
	kIWAA51uZ++WokGEtcFR+tAA7C7iXA49mkHmcsJ07WObKd/6xRw0V2gbjYn+jOWsaGYkqg==
X-Gm-Gg: AZuq6aJcvhGcqoxl+ic9xEJ/xUSyfr536Ihz1cG+9H6gv+S7ZxN9qT3+N67wpbFSdnI
	ADkVMPealcISrQhjXjcOcTHCTtKZTBKNZg6IeouM5ddqFCNFpE50BwlHLtb7Fp2A7flyy1NWndB
	B+0KidjjRH85B/BKB3F6IyGnZ/zn9DZ9HkMmkpK7TnZHaMtFfxhhQZIT2M6apv65AkmTknWunQf
	tEo/RWNQhqkQfT0Vk9r7lhNNXphCYz5MqqRz0FOwWWHiFzmH1JK4qnvvTw2qHefcLmqq1yOLLzX
	NKyN06bKCmdYjwymtaqe4+wcAqjJFcbqSU+K4sLPbftZ2asesdvlVe63qQX+0M9vQ3blvOzLFjq
	vOu+buLAr2WSg6hUD9ec/0R9pPpBH8KZ9rrw1WXWgtdlJyEt5fXr4wZFldzvNZS6myIxujbqNx7
	/Vhtou22c4aLyujOIxuHtbhAHlGlNH73HBdiV117a7AKr2
X-Received: by 2002:a05:6808:3023:b0:45e:a76f:2f43 with SMTP id 5614622812f47-4637b68946dmr89837b6e.1.1770833572947;
        Wed, 11 Feb 2026 10:12:52 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4636b093ee1sm1411674b6e.14.2026.02.11.10.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 10:12:52 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 2/6] bpf: Allow timing functions in lock critical sections
Date: Wed, 11 Feb 2026 10:12:42 -0800
Message-ID: <20260211181248.3040142-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260211181248.3040142-1-memxor@gmail.com>
References: <20260211181248.3040142-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; h=from:subject; bh=/+Wqp6gff6UDAUk8LigKRqxq9TN0Zr9nbrmOfygsRvE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpjMUe6TKUq4DPPuC5Hx0T9ZyA8GRlrlvEVZwiJHYk fB9Ewa2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaYzFHgAKCRBM4MiGSL8RytCSEA CfBPz8qWVDjQhvl6ei8ZuZIW/xU395uuYjit5kpQgqA2OWi5AdPhJzpl+gx1LSqWLCN0zoruzkKOaG xZa8Jx7fknXpZC0oKxe5alXF2m9ZSh6qOri2j4SuedIr8JwCyBCOYyKVbiIsIbM0lu9MXPqY5YNim+ zrzDNT4XCPzlEcqh/5QKzw3r4/3Yr6fF0MFtB1WoyYXLEaPJkRw5dxR3dFDNnJWJCnDdn5cR3sZqjK dUGZX/w0Y8DH7xqf7j21Qj9sDnZOUwp2SUFXr8553IAF2LbQRzehgVkUUy2Z3mX8geSD5lksXaN6f+ gojQN7xXGZAsDoij0mR/yyWjsImLJG2OOEYpc8VfkkY/wA7ohTyNnPpR0QY4KXGvXaCi7/yEuZnDg0 h268AM6RLRRwX+DCvR+TcYrp12ayQi7C2epLfmDYtd9+xO6Wg4kPYdpWJXL2x9z12tj92PXB6F8/YF UoZRsbgMWNyVwAe3tXVdUQ5WoK0PLxc5a+jDHRmIsJ0k0mBD4j4t92IopM5iDOCQrueNqzeTgX63QK SLM4KgzMpQnyZ9VhFsMfge9mNt5Kz1Fk5e6yaH+6CodwgBUOV+xuBeqRPPGX+DCMlShg+ZekT3n+D1 5EtcBZd1KLx9lKpyQZIlMoz1q3aCyx8A38Bv39+Yi3HNyPogt1MsvUtv8vag==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Allow timing related functions in critical sections, which is useful to
measure the time spent acquiring a lock inside BPF programs.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf5342b982f..4acd8e848c88 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21044,7 +21044,11 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 
 			if (env->cur_state->active_locks) {
 				if ((insn->src_reg == BPF_REG_0 &&
-				     insn->imm != BPF_FUNC_spin_unlock) ||
+				     insn->imm != BPF_FUNC_spin_unlock &&
+				     insn->imm != BPF_FUNC_ktime_get_ns &&
+				     insn->imm != BPF_FUNC_ktime_get_boot_ns &&
+				     insn->imm != BPF_FUNC_ktime_get_coarse_ns &&
+				     insn->imm != BPF_FUNC_ktime_get_tai_ns) ||
 				    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
 				     (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
 					verbose(env,
-- 
2.47.3

