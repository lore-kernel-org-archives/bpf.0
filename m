Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAD14192FC
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511427; cv=none; b=hNB8bVDjCg/q2goR/9WPpKCRpq2WxQIev6s+tLLPF5PMe4at05XaqrxcZniru2MJUgD4yaCHI9LCTPTn7nV6pdUA0zxCfUWakLGwNqKgntP45B2KNB1pClnxToyo6OhsbIRzYcIqI4Q7d3DptDA2KHbidbEpUULJZYrZ6OTMk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511427; c=relaxed/simple;
	bh=vqPr+8/DtvTA+xX8xPo4pthRfEwtIthV37mNMud6p8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1lB0Cb/0q0Hble699xtSH6xB/2xdh7+IYzuIH3/crdBr3kDBuU0JiFn3TY/T9zZzYOabI4Z3E+oW3hjkrQZDmtd+xjavOVmsbHFfZmg2e4tg7mE4l2K3PtYpWuIFHLKuZjPOvbvmWtnURyYxWof2DyTSCxVACT2/BBQY3GgNRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFMg6+j9; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFMg6+j9"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-482dcabd18dso125635f8f.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788511420; x=1789116220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5QGudr9F3RFAr7VDHNbB8zzLItVT5G69lQGFd/B7nvg=;
        b=OFMg6+j9mgNk17qtksgIOpzH17xLxhdHy7vHhj4wRZzip00icfvj+BshM53J648oup
         +z5/tSrzx0HrFdUzXNz+nkKvpVyPrdlgmQFf6i6TaIWqyUeJU7DiwC8cxqKyQbOFudIu
         Nfa2rWbnWGYUutrEQKkiTZtIok7USoGvGbf1URqJ+YBHLnaeV0ycARXAjODFQafla6eF
         idXNFXTTuSuMPF9LNkLV3A7C2oYVFDtNNujydMfyFYAr1H67q0JYlgk3GQh5Lsg8J1v/
         fN4TGBrq3jNN2v5J6cdbeWt4T35/mssdJk6I3h/Yau2OkKt65qkyXGucl2IFV0AxZaA7
         0exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511420; x=1789116220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5QGudr9F3RFAr7VDHNbB8zzLItVT5G69lQGFd/B7nvg=;
        b=HjVUISDGgSqyqYP86Doy1VKvQuVe0fhh5JjEWMq0dEsR45rGVv/tUxMdoupsC8taXz
         EJWHEdeoNEA8fo6dK56wWSmDWwgCIG6v5ongKqEJeld9oArbgKOBBIfmTgplLPHAEUi3
         zi3sl+NgqDxgD/ZGjSBJzpZy3rZoPr542NKzDpB/Nsao0DDveyHhibRQGtCH3c5eMBGv
         BsCqKofiWQQUeO40XcMHJIhpMfOMcNdU+ItyU/cAsYWrKKGEe+SXGZn12Icyj0uWNmUD
         jOUMSZLol6pzPxGmTc+w1qD0WX9tveO36J0wEGGlPRIVUaUlUCyQUzXQcaixqD5xxtlS
         MXLA==
X-Gm-Message-State: AFuF++mP5agHESIPoOXJo0KICXg3V55Bh5LT9JEZf1f1yXUPahqaiS7x
	JTuQGCgkbqJnOHokYu2+hfbLY7MmRlZjly6Iiij8Pk28Dwl0froHxMZy7D5Qr9nt
X-Gm-Gg: AYBFou0xTcRUQFimemgONnfA8lB9+tFWOsHXO95w1bOAlhskHABkhRbmUm2eigb9W/M
	9tQHMEpQzMW15mFFuG4eMR/CyoK9P2AbmlXITlIK0Ip3hpSy2/W1eO/gJqEGY3yptIjWPcOcmY7
	0tRxxmlbLoCkrqTR6hwCZn5JLT9XGBd5KUqet+24qmnIMuIWndAcIgF4fGI8koBPOlsGFgVIQwe
	t5vj2BqA6zx3Yu2X1bOszHt63w1rpn7JR8SVGnLVukbB/84NjGIg5CMqCTbxYObx79dArDswoVR
	THnRMztPYI8dmws1VP2Pikz/xVU20J+f8TXoCXURWDKxsDxoU65kD3dLfxAmCcJLW1syS9R3SDL
	8Gn8bDiWuR+maA63tdYktuzYyA0t/OINBD08X9Kq3g3c+QF9kTZbk6n6CdjiRlVQKUrIuJt9bdF
	Yy8Sosd5iMiRnLh3CEhaB3dz/J847VCji7uj381BxnaVcaMTjxQY/9TOU8TKZLTGiWLhavCh3Ph
	hptlvFSHHTJTf1TaVqHp7yaDEffNPamR73l7hryxxpcLvgJAkMphF0pYfGHZC61PGmvcuaYFY1R
	cHuF6cmKB20sEnUY3uU4i3AN/wI=
X-Received: by 2002:a05:600c:474a:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-49cf825d722mr42261975e9.10.1788511419636;
        Fri, 04 Sep 2026 01:43:39 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883953cfsm4031131f8f.13.2026.09.04.01.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:43:38 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Ning Ding <dingning04@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 8/8] selftests/bpf: Reject refcount acquisition after RCU unlock
Date: Fri,  4 Sep 2026 10:43:21 +0200
Message-ID: <20260904084325.52250-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904084325.52250-1-memxor@gmail.com>
References: <20260904084325.52250-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=memxor@gmail.com; h=from:subject; bh=qJNzjP2fDfn9dR6wINYZGUTAHnLDZ4cmAJndrsFWOmI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtWy+SDpmen1rGy1aTf3DYtadt3//vyy2dPmmDULCs1N eNQwjSpjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExk8gJGhldHlsYIxUTduRvU fibj4fxpN9el2vl8P/E0eFHFlcPzMxcxMvS99xbgNljFunNdrd2jxbyX7LXffJqzL2pttVIdk9u SR5wA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Ning Ding <dingning04@gmail.com>

Add a sleepable verifier test that loads a refcount-only local kptr in an
explicit RCU read-side critical section, ends the section, and passes the
pointer to bpf_refcount_acquire().

The loaded pointer never carries NON_OWN_REF. After RCU unlock it retains
MEM_ALLOC while becoming PTR_UNTRUSTED, which previously made the kfunc
argument check accept it as a live allocated object. Expect verification to
reject the untrusted argument instead.

Signed-off-by: Ning Ding <dingning04@gmail.com>
[ kkd: Rewrote commit log ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/refcounted_kptr_fail.c          | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index f787ecf189d8..338e43822ffe 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -189,6 +189,33 @@ long rbtree_remove_after_rcu_unlock(void *ctx)
 	return 0;
 }
 
+SEC("?syscall")
+__failure __msg("R1 is neither owning or non-owning ref")
+long refcount_acquire_after_rcu_unlock(void *ctx)
+{
+	struct map_value_refcount_only *mapval;
+	struct node_refcount_only *node, *ref;
+	int idx = 0;
+
+	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
+	if (!mapval)
+		return 0;
+
+	bpf_rcu_read_lock();
+	node = mapval->node;
+	if (!node) {
+		bpf_rcu_read_unlock();
+		return 0;
+	}
+	bpf_rcu_read_unlock();
+
+	ref = bpf_refcount_acquire(node);
+	if (ref)
+		bpf_obj_drop(ref);
+
+	return 0;
+}
+
 SEC("?syscall")
 __failure __msg("invalid mem access 'scalar'")
 long graph_kptr_after_spin_unlock(void *ctx)
-- 
2.53.0

