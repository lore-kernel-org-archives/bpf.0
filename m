Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692942EEBC
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013370; cv=none; b=YlcwUPF56h58Sc86Eudu0/1bElsAgmibjdduDAmZJgoMGCgcD6Oe3hxsLB4locEvRQzea2UHNCouLTxtnQe0Muryck8mUgxBwIjLJUoaB+hsDFdJa5kyP+V+ePQyOqTuTlpIA3bcgXdd3kgozO0xFTRV/U46nZuqRXE0byvjCKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013370; c=relaxed/simple;
	bh=UqVNFGJfDdd0kyN6R0iGsNtgaDj3ye0cvUiB41jCyBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbMbx9kfCl/FmpHYLGwvbd7OwAOLb/iIe+F8r1eDaAVH1eQnWdv4THuAwbTEpirOR1AxkiyVlvjXpMR5XSnXLa8WIYsbV63FVqDZtuiOG/CFLZVcy67O0PT8WsjcXeLV7KVR0gXxVNz8Rx3D38x/YNpyNOmeegSNk/hCocXjX1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8lPozpk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8lPozpk"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ac10e337so49189845e9.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 06:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781013368; x=1781618168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VORlzG4J3+9OsMpc4x4bAnSfjCXZwFKTUiBRjE5exs=;
        b=e8lPozpk4tTtcjEYP5JY+DQ6HagRZONw5t/BFZ3hh5A9YlsS/+iXGxo0t+yBasM/EB
         gaeQqDSUTv8C6wupywvdosM72kX84g5epo8rC+RZrARTrht2CF+hIFX1f2fHwkaaAIu4
         FdY+5VJyqeMNVqeKGyk0frpd3rvyNH96kgjU/2ozhmnpkg80o80LksaNIKqBK8UtNf/W
         uX1AkFFBEKaZlOe7w5MkjLHriQ9eM4AjbfSLmb426/wS37BMs85N7SmxTx7hsTrnyXuX
         2O4an9a9oVjvZCLJhU2E6Xpdyb9tiMk92X1FdNGRJEiqfc0oqmx8Ld1D4aQ8WbrP1DTy
         IbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781013368; x=1781618168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8VORlzG4J3+9OsMpc4x4bAnSfjCXZwFKTUiBRjE5exs=;
        b=TeEvU0DiPvAYS7AnTeH3WrlaPPmvmdBXxHA0ZdeOjaj4noPFrTXvrx34eo4C5GQL4Q
         KJ2BFxAso572iLtW4is862xeeBo6obgsXBRYXzeuzLcxxhcvIv35qlTIFeZL+u0btxt1
         ouV0OQa13VEwYrvbQSJQNH6HA2irZM6FtkS5bALVc9Sp95qsXrNk5TQub6UoBTIV6Zp2
         YgcEHcVMzhMHoL73Ke71iluaYiynXlqm6YosiqkvIdRErbeLNrM8p+m0H9GvEnFOdIeT
         oa3fdKn4qzcmGxKFXVraSPfawAQbyCGr1m8HqkY4duH9p6eTzV+3cNp43n6gMnV0IIFb
         LQGg==
X-Gm-Message-State: AOJu0YwvlNygGmg2P5/ZY6e7bRFEcJtoQQDKEpYTYNiSET0lHkAn2Yku
	1Y8gUL+Ed3xagQnBGdxoNJBNetd6CwZrj7wrNGoVhZfaTpGvCdsXVBX/8BNPZ0Z/eDmOzjew
X-Gm-Gg: Acq92OFKSKeN/cIS00rf/8PG1m2pGPmK5im0vbk95RvKsOcadKBrcIT3Ai2HVo0TTJl
	edxectGgEX3f9I+Wj/DyCCYklHk6bixrHoC8XI2teEHNMwgJqEBoW703l1OK12UVZWcVw6OAzaB
	n+FykNjAjaws4PWxNjp+aDne4TWkhxwHTOH4U4ZTqqimHdhz4IfSf/EKwuXBRxxeKTPbn7zVTGj
	ExA7gG995DrqUiHRqJji2iUO2w2by2Cpq870wpwTwLTXgzqkPok/LnjE39CWbzJ3YvAp461Hjl2
	li8qrfrda9FqZ6YX+grsb9hSbuikVbvAhALb/IB44cvSnYcx90AD+kgQkA1mtlQMQNDd2XHV3T0
	Nl80AwVTO/XBM6vOP3yoM8fPBBqYucmy6/Y6xfeTpo+wX+CqPUlmf0DQIuXwLmWsuZU2j54leeO
	uHscj3BmqFfIH4njTpWB/JLeu+Bw==
X-Received: by 2002:a05:600c:609b:b0:490:5466:8576 with SMTP id 5b1f17b1804b1-490c259854emr324063715e9.1.1781013367725;
        Tue, 09 Jun 2026 06:56:07 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm429927045e9.1.2026.06.09.06.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:56:07 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 2/2] bpf, lpm_trie: Allow sleepable programs to use LPM trie maps directly
Date: Tue,  9 Jun 2026 06:55:58 -0700
Message-ID: <20260609135558.193287-3-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260609135558.193287-1-vlad.wing@gmail.com>
References: <20260529174233.2954240-1-vlad.wing@gmail.com>
 <20260609135558.193287-1-vlad.wing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous change relaxed the rcu_dereference annotations in
lpm_trie.c so the trie walks no longer trip lockdep when reached from a
sleepable BPF program holding only rcu_read_lock_trace().  By itself
that only helps tries reached as the inner map of a map-of-maps, or
from the classic-RCU syscall path: a sleepable program that references
an LPM trie directly is still rejected at load time by
check_map_prog_compatibility(), whose sleepable whitelist omits
BPF_MAP_TYPE_LPM_TRIE:

  Sleepable programs can only use array, hash, ringbuf and local storage maps

LPM trie nodes are allocated from a bpf_mem_alloc (trie->ma) and freed
with bpf_mem_cache_free_rcu(), which chains a regular RCU grace period
into a Tasks Trace grace period before the node -- and the value
embedded in it that trie_lookup_elem() returns to the program -- is
released.  That is the same reclaim discipline BPF_MAP_TYPE_HASH relies
on for sleepable access, so a value handed to a sleepable reader cannot
be freed while the program is still running under rcu_read_lock_trace().
The writer paths take trie->lock across the walk and never relied on the
RCU read-side lock to keep nodes alive.

Add BPF_MAP_TYPE_LPM_TRIE to the sleepable map whitelist so these
programs can use LPM tries directly.

Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..71c1e59e4df4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18122,6 +18122,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_PERCPU_HASH:
 		case BPF_MAP_TYPE_PERCPU_ARRAY:
 		case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+		case BPF_MAP_TYPE_LPM_TRIE:
 		case BPF_MAP_TYPE_ARRAY_OF_MAPS:
 		case BPF_MAP_TYPE_HASH_OF_MAPS:
 		case BPF_MAP_TYPE_RINGBUF:
-- 
2.53.0-Meta

