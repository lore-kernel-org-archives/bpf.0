Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2547534A
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152936; cv=none; b=hJsR194Fg382uQnwSoi5PlgxhrSWYS/IhVgZ4v/ZpcDfKxUmXgL5oUMiqy7r72m6uVDOGBGvmNXwz0EyQxPo9E61B6qP5eEpM6PvQVjEhpAmGHMlTu/tXnlCkAVjxzgor6CkQzcczBUmnovbU0iyq3TpCmxxjjkoAYCjTvaaQ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152936; c=relaxed/simple;
	bh=QPV5/30ZelOFwLXeB49cmnd+jmrcX9WyN+ewYiXvqNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jc7o1E2QwFISA8bZzscavsWKC9sUnzz44FdDUfEBlALQuEjYxaXKsHYXyBLcJg186dPbYTKDEdgXlCwOqvVZ3umoTn5Dtf4YzowE920gXnAm9xp2TAO/9knBxO9KJzk0E32jX5DDAVDcsLkXKbgz0a1K9bHrKgmZ64UBrkb38ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGKamAlL; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGKamAlL"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6eb11e9cso2689365e9.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790152927; x=1790757727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xszlmwOfkkD4nYoVWBWsgaZpSBqliMH+Z8y+GFcgvnQ=;
        b=BGKamAlLKcAVWDQKqHZMIH89GAPVRcJzAnyr2JjPFsoGEPGvfOqGmrd1gDmrbfWLO/
         x8CmrlSYVe+DYYZnbu/z55EQlTrBPraYQlvVLF5N5RdgvI5T3U60S/Fz9qK4BaBmL+2K
         AVwpt0gWUFx1J7nUKHEF7dYPwo0QE+vGpPkN14UwvrKgt9Go/Cux1OxXOa1NHtHPEVCh
         BOxHt1FCoj/JPJr5jaoTXsnE+scerNH53oyElOi2bKJ3GYZqkf6NJDLv0P8yQABnZhMr
         gI3ZNncAT9v8IknyewByM3aNWwFCvSI/tmGtLVMFBny2xMHv1XiTxF5WYRTEe5ajcm5l
         VdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152927; x=1790757727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xszlmwOfkkD4nYoVWBWsgaZpSBqliMH+Z8y+GFcgvnQ=;
        b=dmX7Rgq6zaBG3kthuKmKJusb8zGLAzcSodqJd12kUbGWC7zQXevspwbaKCSrmx3PnF
         oe96WOHCgcNMUfJavqB7cg90nPWFyGRmO/2wheyAt/FsMQDPOnaOLyldnuaZ0VX/mb+n
         P2iiJI9vImy0LLzjM0oK2w1W3ME0QYfaWNtbkRbKV8UNfv6r2Ln9LDoSnMcmJOj9IWhW
         RVsE3hCg/5GNoF8ddUHu/0TGfIdARR62DiJ7mQnAtb7dam1SK5K/Ug3AOXbUnZm20asF
         w5LPSlXOe6gTMy8m2VoepmVI92oZMCwcSIivlAnWm7KZJ6g8B2/5iBuWXkvAbAa9XfEB
         nkaQ==
X-Gm-Message-State: AFuF++lxhNKQpkVsyk4IVT660+HlboOac6Zamw5vh5LDODyndC7Aa1ku
	vNFQVP0uMPWn4OunqF5+B6Ii1sDnwesxBPyaN42DYcnWqJM/C64IeKhcJRDz4FJ+
X-Gm-Gg: AYBFou0K5VzHMTa1hRW7p2iUSo47HNcYhQmyTVULylbZbhB+uzHp8xvXzI+ocX8GMBN
	GrdCEaiGArrHoZ4+bEjPaxmRfF96X+XLD9tBzzZpNTPmNVNKua8z2oke+j29ibkqL6pGToFcCSz
	9fcH68YKPaTodKIysAZOrswR4oQ/Qz5OmX9CCLVBlFR+KhJGjdfQo6mm3tWZxKWElqMx6rtUIIg
	ItFgms0OdyW3H41x0RlYMXUTVX/RVtezytkAOOCNddylk7RtkIu9L4mJnhNpPkCP0Pj/AxP+S0n
	aYyKIo1uSRzvKyjwakrvMT99jevU0+788H/PEa7e5m+XVeFWzIj/ZpQjOj8Llmqzqbz7kgH5mV+
	3NcHqpTrc9FDHqUp6pL+JtDE4ac9JATjE9naykU50Z7YkERhKt4nYF1LJV4Jh7rQgKlRF1e+aUq
	fC7mVsaklyM4nTntxqQbk/ukckp4YdRLPIC0XtIG4Z/Zt1SIywehrg2PFPT7MG7Fl1yFV/Irltf
	+QswDg69LR9jMX4Qj25ZG1YyBQ8LgFKbNFCf7NDBWE26X5w9RtllLhUrQv04RUF33aXuvzZg1ge
	EO4dgEJ5WxedOj5mtDXpI/hXfld81KzOmojmvZ4NI/vT5ltYVQ==
X-Received: by 2002:a05:600c:468c:b0:49f:dd6d:79a1 with SMTP id 5b1f17b1804b1-49fdf138a05mr24175205e9.26.1790152926473;
        Wed, 23 Sep 2026 01:42:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1ccccfsm57271985e9.7.2026.09.23.01.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:42:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/3] bpf: Check fastcall contract of the frame a stack read targets
Date: Wed, 23 Sep 2026 10:41:57 +0200
Message-ID: <20260923084201.2437625-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923084201.2437625-1-memxor@gmail.com>
References: <20260923084201.2437625-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583; i=memxor@gmail.com; h=from:subject; bh=QPV5/30ZelOFwLXeB49cmnd+jmrcX9WyN+ewYiXvqNY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvzhJ3vTqZkTP9RxR66sTkl3TVRLuvKmwB/kS9+U1d+W cwjWuDaUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInY1DAyvK348/OdqJJe/4OD +d+mCzPN3Mew3mOD+fyjt17amwn9tmFk6GT98Fp8zxxuyZuufdOz+Bva8j1fct1fLFs00/TQhsU NHAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

check_stack_read_fixed_off() applies the fastcall contract check to the
current frame, even when the pointer targets a caller's stack. A callee
can therefore read a caller's fastcall spill slot without disabling the
caller's rewrite:

	caller:
	r1 = 1;
	*(u64 *)(r10 - 8) = r1;
	call bpf_get_smp_processor_id;
	r1 = *(u64 *)(r10 - 8);
	r1 = r10;
	r1 += -8;
	call callee;

	callee:
	r0 = *(u64 *)(r1 + 0);

The caller's spill and fill are removed and its stack depth drops to 0,
but the verifier still tracks the slot as holding the spilled constant.
The callee's load then reads kernel stack outside the caller's frame,
while the verifier assumes r0 is 1.

Check the contract of reg_state, the frame that owns the slot, as the
stack write paths already do.

Fixes: 5b5f51bff1b6 ("bpf: no_caller_saved_registers attribute for helper calls")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1d9defa231d1..b38c4c7562db 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3951,7 +3951,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	reg = &reg_state->stack[spi].spilled_ptr;
 
 	mark_stack_slot_scratched(env, spi);
-	check_fastcall_stack_contract(env, state, env->insn_idx, off);
+	check_fastcall_stack_contract(env, reg_state, env->insn_idx, off);
 
 	/*
 	 * Refine the in-progress load record's origin to the source stack slot.
-- 
2.53.0

