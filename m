Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B24DDB48
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168962; cv=none; b=Els1gqjqKWK6qWaF707lpVi5URyJr4hT3q/RqbhXmldYWXykBxIWaQ31vnbB8msW0J5f2251CEbiSOOTnsvTX+x2zu40OfWv3+PR916gQAHOJLRfvizoLIh1LFiYsIiJk5tuQmb29OKtOFCX99MDmxlPYQwrJ3D2QNKFzNrvbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168962; c=relaxed/simple;
	bh=6fGk/cz4lM/vcLtY4nj0S79G2e4HoMiA2Rti2eE6utc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=gZLOuTAtOFYz/lQFPMx+uN2PQ9leS94Fk9xETjn4zR+TtbnTLs4flXIThFOpn0Ps7KPTQJqwMF5OyP2utkZGzhTSIDBONpc12SKb2BROWTUd+FDf8uc44Xav2eWWNYywwsgSROZdVTttxjSGLlQgwp/vpyVeb9WrS80QQ+nlJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9Sg8swK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9Sg8swK"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso139603a91.3
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 09:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168960; x=1792773760; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eCAyx7AuZ0Q0woC1cedtvhLk+r2xvJ+25iib/kChqHY=;
        b=e9Sg8swKEvFpVmVZ+PEqqD+A4N+RWX7CA1qgVJPlhgpblgswpuPoHC/GPxmTKz18q4
         nSKExaw0VOkwr/rdWLHh9l0WBFl63MgjUBTYVGGTGo8E/UkonCfMbKKOV/RyV0ZuM9jV
         yGkzwD/n5XzqL659LttqMa6+6SyH56xNStFAE2vodQe0t0dJNOTAizxKwv0flRhC+FNR
         2R61m/ZsK2iCFRl/dcXdXjT9e24KVqU/MZQjO5seTngc+bo2yJJaJNp22C8FtHSkLVVI
         vh2kiQtYiup83XmjVTSu/lzYeZCIXTe9T38Wd/dTFs1dXgd7U2hCpQH23JHzve2d3+Xx
         fOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168960; x=1792773760;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eCAyx7AuZ0Q0woC1cedtvhLk+r2xvJ+25iib/kChqHY=;
        b=lMwnXrLVliMlzGEagKfAdv8127mbRDYqcsrPAg1/KixfCw/6Vx+3sS5GUNMbGPOGnq
         gR8nkgHI79z3LqX3tiF7cdm0t0YX8Cf+ovEoA7nPkYiPSNByjWtYoOxt0jAWqHXjCCeb
         n/lDZWt+X7SSAg/GjlQAHCSvymzj43S4XLIdYKBQS55kpFdO8Y5BxcP7ZgJRmLuqrWtN
         LGUD7GHpNykCXn4z3KZeGXHIi80Cr3Eq1CLM5GDQrMz8f+rB48ZDKl9sVHTnK8l5iYZM
         cMnjgpaKzvEDpKZMhxsi+S0OQ/egFEYQW9IFjKkQa1JOlO9F4P+McAhz1paJqw0mqm4b
         nmOw==
X-Forwarded-Encrypted: i=1; AKwUvBwFidwHN+uFkrr8QgZNn2a5nFdgvrWtcYa/K3TvbZBbUGRUtoBHe/4/nSRATDUzGJ48HQg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcuyHBqJbU8nzRyw2RIohm7lysjIOkFFN3IIE8gLQvoqdyEsoY
	KN6wfRMoRINScAlFLm5E8rODv8gWaPgwc5eS3UFho3MkhYvNyBFaSj+j
X-Gm-Gg: AYBFou1C7rfB6iYdnWTFF8HjOw1AZEpX29hoz9NMDtRfWKgQq70qOGuow8Uvwj3/i8C
	yD8BYddsrmGmt0fLu0HalrdMovsb1Yl98ZKnomjPF2M3Cv4kmvvqnRFQCVTA2xJuwmDeJkiPRdd
	6cTrIEpLhxqJ2EHbcjeGGmb18y9ysOlXfuccdDn8J3YAw5kzQ0E9u6yuPWiqkdiG5LE+B0cNmFP
	AZ1s87vSs+OkQp9AbwOkJtxBJlmSyYA6y0qAFyRWXW2bYyUT7Z+N78oC3d1kz5ayXbVpZbSseUv
	gu7fer1EDQmdSum+zANnkVpLyonDJ4FrD/Xz/qEX41ehmL+jS+KvAOHv2io2kPfh5g50wEVTO7Q
	6v/YgKcE8zqunFNgMau5iqdcZd5YQv7XvRFijR28TB1KsRz9hEGd4+46BkU2612kuoD+Lg5A7B2
	9v7tjKzLvO09vmJ57PuiC6vtNjEO05DuhxP4S58oItVRtCP8/gqQuk1lcJ5lE9sCb4M4z61yBbU
	pJYxBcc8o7xGz2V2zg+iyH1WaTmwOHGUvIaYZFQn8UWi2bxolqncVZ6l+gigp5cKNlmRga8mWLE
	8Eg=
X-Received: by 2002:a17:90a:d44d:b0:39e:4c80:f67b with SMTP id 98e67ed59e1d1-3acef13e596mr338758a91.26.1792168959867;
        Fri, 16 Oct 2026 09:42:39 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e74bcsm10102429a91.3.2026.10.16.09.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 09:42:39 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 16:42:39 +0000
Message-Id: <DM6EVHTVM3IR.3RCFLKV9WC80J@gmail.com>
Cc: "Amery Hung" <ameryhung@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Nicholas Carlini" <npc@anthropic.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 00/11] bpf: Scope callback arguments to
 their frame
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20261009202759.50520-1-ihor.solodrai@linux.dev>
References: <20261009202759.50520-1-ihor.solodrai@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 09, 2026 at 01:27 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
> Introduce REF_TYPE_FRAME for this use case: a reference owned by a
> callee frame, dropped when the frame is popped. Tie each argument to
> this reference so callback return invalidates it and its descendants.

Another idea...
The id is owned by the frame. Can we keep it in bpf_func_state
like diag_frame_id ?
release_reference() already takes ids that are not in refs[].
See unmark_stack_slots_dynptr().
Clones copy parent_id and slices hang off dynptr's id, so both are
reached.
All setters have callee already, so no need for patches 1-3,
REF_TYPE_FRAME, frameno in refs[], the reg that is its own parent, etc.
Something like this (compile tested only):

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54144372281c..4f82b86cdfe2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3185,6 +3185,7 @@ int bpf_iter_map_fill_link_info(const struct bpf_iter_aux_info *aux,
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee);
+void mark_frame_scoped_arg(struct bpf_verifier_env *env, struct bpf_func_state *callee, u32 regno);
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 112ca1511da4..8865ece94ef4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -364,6 +364,8 @@ struct bpf_func_state {
 	 * reused after returns, while this ID is preserved across state clones.
 	 */
 	u32 diag_frame_id;
+	/* parent_id of the args that are gone when this frame returns */
+	u32 frame_id;
 	/* subprog number == index within subprog_info
 	 * zero == main subprog
 	 */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 0fe9afd4a591..3376cc81e5d9 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -855,6 +855,16 @@ static u64 array_map_mem_usage(const struct bpf_map *map)
 	return usage;
 }
 
+static int array_map_set_for_each_callback_args(struct bpf_verifier_env *env,
+						struct bpf_func_state *caller,
+						struct bpf_func_state *callee)
+{
+	map_set_for_each_callback_args(env, caller, callee);
+	/* the key is on the stack of bpf_for_each_array_elem() */
+	mark_frame_scoped_arg(env, callee, BPF_REG_2);
+	return 0;
+}
+
 BTF_ID_LIST_SINGLE(array_map_btf_ids, struct, bpf_array)
 const struct bpf_map_ops array_map_ops = {
 	.map_meta_equal = array_map_meta_equal,
@@ -875,7 +885,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_check_btf = array_map_check_btf,
 	.map_lookup_batch = generic_map_lookup_batch,
 	.map_update_batch = generic_map_update_batch,
-	.map_set_for_each_callback_args = map_set_for_each_callback_args,
+	.map_set_for_each_callback_args = array_map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_array_elem,
 	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
@@ -900,7 +910,7 @@ const struct bpf_map_ops percpu_array_map_ops = {
 	.map_check_btf = array_map_check_btf,
 	.map_lookup_batch = generic_map_lookup_batch,
 	.map_update_batch = generic_map_update_batch,
-	.map_set_for_each_callback_args = map_set_for_each_callback_args,
+	.map_set_for_each_callback_args = array_map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_array_elem,
 	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 953700822fa7..43d6682037fe 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -995,6 +995,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	if (!old->no_stack_arg_load && cur->no_stack_arg_load)
 		return false;
 
+	if (!check_ids(old->frame_id, cur->frame_id, &env->idmap_scratch))
+		return false;
+
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (((1 << i) & live_regs) &&
 		    !regsafe(env, &old->regs[i], &cur->regs[i],
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec136cf377c1..bc12df55d2e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11465,6 +11465,14 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return check_static_func_call(env, subprog, insn_idx);
 }
 
+/* The arg points into the stack frame of the helper that calls the callback */
+void mark_frame_scoped_arg(struct bpf_verifier_env *env, struct bpf_func_state *callee, u32 regno)
+{
+	if (!callee->frame_id)
+		callee->frame_id = ++env->id_gen;
+	callee->regs[regno].parent_id = callee->frame_id;
+}
+
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee)
@@ -11631,6 +11639,7 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 	 */
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
 	mark_dynptr_cb_reg(env, &callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
+	mark_frame_scoped_arg(env, callee, BPF_REG_1);
 	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
 
 	/* unused */
@@ -11885,6 +11894,11 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 					     callee->allocated_stack / BPF_REG_SIZE - 1);
 	if (err)
 		return err;
+	if (callee->frame_id) {
+		err = release_reference(env, callee->frame_id);
+		if (err)
+			return err;
+	}
 
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
 	 * there function call logic would reschedule callback visit. If iteration

Patches 5 and 6 are fine on their own. Pls send them separately.

pw-bot: cr
