Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937244;
	b=vkBzikCnK3Ta/ym/1mVMDghkNl3IolsxedYVVbNvNhktjgBFSeXD5dho8TXhaZNnFZ93
	 u9mAcY0uGRTPvYAxn7Vpme8uQLvY9rfCM9ozkm02SDAahuSIeHWtPrO3AP6+0LgFUTsAs
	 +0eIn8cIdMc7QdTKDz5Ri3n5cdgnRlpVw7sMMMSgsLFpW4xU2DD5+YgvU87rj7GBcD4gS
	 2AK1ACW7P7FjlFpn4sqWMsmk/2SkAHOvcn/doaESGCULxA13y+oeY5c3UJsOAWxZvVsbH
	 pzDdtmQOn97rnQmPNqNXOrYDOARkkLBp8nKEB2hjd62s5ow0UZx9M55LPsC2Nghvnbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=07Ct+gCgGTxuYOTK12HKawkTd17VhQTSWACQCnFRS+k=;
	b=u0TErB07x/jSIvbS/i0kb17K8S/R5yKpv6R1+DZjfxNhpAQA0xNPxQtn+CTRhrLWuMrM
	 valIoFJzEhw4SPMJvztEesJww9r0/tVDvYXuZsuAQTDRTwsmEya7WmEgon72M1HTwzhOB
	 52SSsUekk8KorNui675OjT8VSIfbk6KR1Be9+U01ggi7THRcySrCH8FN7om+2Agmt95jR
	 NM6uw8iFx+67hJg/MQyP653a//sglkXGnGyqu3ZE4SIu2w2oJ9T0keko6tuqSUk8NLiWO
	 D0vA5XTBaLh8OqmaByyOZkZJqlCDEDmIa3dZfIOql+srPX4zyc4WXkN7dr7H1edH9ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nltltiJ5;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835E5606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 835E5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nltltiJ5
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so77190a12.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937244; x=1794542044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=07Ct+gCgGTxuYOTK12HKawkTd17VhQTSWACQCnFRS+k=;
        b=nltltiJ503sYJKpMBhzmMBUZT9pwk3VBn4N8Uw8OyglrPmpaBjowqofC0wlBR+VpuX
         iwfZsO7BOqSRhiucdD4wxRzLWQc0jNWg8yt6iKyGmikVjXxcJGcGj0kZLqpfW2NjJkaI
         UuaNS+HOUNEQtMHFpLzAohQ23ZkgtvVmR5+t7OyW/EwiP8Aqa+mCb+MVCp8Qi/sb1zUN
         nEyxV8Rr/ZRxdWXsgI9ytP874L5N70BlHtwzG0Z4m8uFFQIglKIIQX+o2G0wSiv/fLc/
         JbrnLbyJB53QoyftJgwelcikzhYkHCxF7LYqRqBmCgwv87rhOLHtMImrfY4Xt62ziXm0
         jLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937244; x=1794542044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=07Ct+gCgGTxuYOTK12HKawkTd17VhQTSWACQCnFRS+k=;
        b=wDI0xMyHTsC0n6mzU0iPpnfgSCLHIj34MLlY+/9KiMFggBUX+8Hd9/NZ7WRNUL+KhJ
         Ly4OCqzsI+WjrJxMmTuzi57GJW4KVpZ1oY4gZ+XtIHc3bZMlGTclX5fIUROxV9hYlHcF
         M0/qBcmRyQtuFWg3HVX0aP9PhyfArMpQ/ATIrOo83TiAqWveM2MRSt/xw15IdgUalIIk
         CS3RY2/u7hoIkeIsl3Y8ceIkcTUWg6DGzmDb7fROS70INHqH5I7pvq5/l8k0cD6havfr
         KGqtS4aDtN9oZ4vd79gBpOaKeq3Wa4obuf2BwO6h+M6G7TccaqgBXo57o5Wv7LIIDkOM
         uhww==
X-Gm-Message-State: APuU4Z/3Jj7mjoy5q7vdW8zgzOtX3Vq9ZEKpiVIWMTcoO47dyz92Vosh
	Ggs0a2eNViOI4x+E8ozITCALnlogm8Fx18xWoHnT0Z5VnJKw95e6n1TmZJoIaA==
X-Gm-Gg: AYBFou2J0HfLqEKUo4GUEpG6QTJ0B17GgNp3x3fFbYzOFzuEpnHt7AV1qA7qL9XAWZl
	S1vMbyZhxAkaSVxVW0uTZ+2m2GlG40gE1i6PeGQk/rhjSjqxlVT6TJqvRcFklWXPOS2h/AtHha+
	tNmft3LFoaUS7mcbp/Kv4a7bYgWabGOdMymNNNMa1rNw2uI8PB+sQX2ldV4biqTOTnsBFddu3Mn
	6sKjPMWAPXAUK+C236ozv0kGzPsBMopVGV2aC3o/Z3zRPsvdqBjVy/uLqVlHI2FYUf4jReVB8sk
	EUjS/rDSZXjUtIe+ZavDxp59eQN4puUfiXtGEPkz4qiSCThJUk7uWSfP8YnZdPZlMasJlRhxSje
	9ACbjl4mI/Cvi9F2xt01qLZkvyuekIhmFC/Fj8dJU751gCrh4aY11O+TZsE9FlOIAb77LhGU5wt
	PCvGMJ40ddM5x0R/FUiznA35SIrjlzJnGbWDlc8YcAF+7GZd/6VCS9OnMvDlob2SRBp4/DCZ17a
	N2aTWsvdrs3xCL16c/hO5JZbyn2bMqQ9fTTe22B4PPwRSfUhIOvxSlDibkKYzqSbelFr9JcNUQP
	QkP/wNrheynJOQF3EpNyidwkKjGbYTX6IMJdE08Bsie9WaU1nfUNr87BaIA2x87Fpuq7L2HYuzP
	rAwHKq/dmtRWSLgBuByenTBAoo6ub1CBzkmfrV74tkZC4TXJ5c8l9lWJuk0QGAXzxUY8D1J350A
	==
X-Received: by 2002:a17:90b:5291:b0:3ac:adce:60a9 with SMTP id 98e67ed59e1d1-3b0db6217f5mr1238700a91.9.1793937243765;
        Thu, 05 Nov 2026 19:54:03 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d78b0a8bsm1529420a91.2.2026.11.05.19.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:54:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 29/45] bpf: Don't take what bpf_core_cast() returns for a number
Date: Fri,  6 Nov 2026 03:50:53 +0000
Message-ID: <20261106035111.3315285-30-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

  struct task_struct *p = bpf_core_cast(t, struct task_struct);
  x = z ? p->pid : p->tgid;

clang makes one add and one load of it:

     if w1 == 0 goto 1f
     r1 = 1856			; offsetof(struct task_struct, pid)
     goto 2f
  1: r1 = 1860			; offsetof(struct task_struct, tgid)
  2: r0 += r1
     w1 = *(u32 *)(r0 + 0)

A pointer to a kernel object takes a known offset only, so the main pass
must not join 1856 and 1860. It joins them, and rejects a prog that loaded
before states were joined:

  invalid variable offset access into struct task_struct

bpf_flow_compute_kinds() takes void * that a kfunc returns for a number,
unless the kfunc has KF_RET_NULL. That finds bpf_obj_new(),
bpf_dynptr_slice() and the like, where the verifier makes up the type.
It does that for bpf_rdonly_cast(), which bpf_core_cast() calls, and for
bpf_cast_to_kern_ctx() too, and these two cannot fail. So r0 counted as
a number, and nothing asked for a constant in r1.

Name the two kfuncs in flow_returned_kind().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/flow.c            | 6 +++---
 kernel/bpf/verifier.c        | 7 +++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9b7c31fefe72..78a787aaba44 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1965,6 +1965,7 @@ static inline bool bpf_is_kfunc_sleepable(struct bpf_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_SLEEPABLE;
 }
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta);
+bool bpf_is_cast_kfunc(const struct bpf_call_arg_meta *meta);
 struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem);
 int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off);
 bool bpf_insn_is_cond_jump(u8 code);
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 62115e396635..d5dbe417421a 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -733,10 +733,10 @@ static enum flow_kind flow_returned_kind(struct bpf_verifier_env *env, int idx)
 		t = btf_type_skip_modifiers(meta.btf, meta.func_proto->type, NULL);
 		if (!btf_type_is_ptr(t))
 			return FLOW_IS_PLAIN;
-		/* void * is a number, unless the verifier knows the kfunc. Such kfunc may fail. */
+		/* void * is a number, unless the verifier knows the kfunc: it may fail, or casts */
 		t = btf_type_skip_modifiers(meta.btf, t->type, NULL);
-		return btf_type_is_void(t) && !(meta.kfunc_flags & KF_RET_NULL) ? FLOW_IS_PLAIN :
-										  FLOW_IS_OTHER;
+		return btf_type_is_void(t) && !(meta.kfunc_flags & KF_RET_NULL) &&
+		       !bpf_is_cast_kfunc(&meta) ? FLOW_IS_PLAIN : FLOW_IS_OTHER;
 	}
 	if (bpf_get_helper_proto(env, insn->imm, &fn) < 0)
 		return FLOW_IS_OTHER;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b0d4410076dd..2a0d5a280a1a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14259,6 +14259,13 @@ static bool is_bpf_cast_to_kern_ctx_kfunc(const struct bpf_call_arg_meta *meta)
 	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_cast_to_kern_ctx]);
 }
 
+/* void * in the prototype. What it returns points to an object of the kernel. */
+bool bpf_is_cast_kfunc(const struct bpf_call_arg_meta *meta)
+{
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_cast_to_kern_ctx]) ||
+	       is_kfunc_call(meta, special_kfunc_list[KF_bpf_rdonly_cast]);
+}
+
 static bool is_bpf_dynptr_clone_kfunc(const struct bpf_call_arg_meta *meta)
 {
 	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_clone]);
-- 
2.55.0

