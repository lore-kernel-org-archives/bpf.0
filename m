Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980F3FB070
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538674; cv=none; b=s3fEGgmZUzWJcUPy8L13pje9SAe8SheI1oqMehW7RiFCPek/a3fFL4U5W8hTX//s1gtqCgHyy+syFw325p/kMGL2dsh+Xp0z0gqk3GZyxzOcN4dPvFElH6vWJ/3BMgAeax2ZUBjjdS9o9Nn9N5nANy1O2Ml1AVFmI0lC6f8VizQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538674; c=relaxed/simple;
	bh=wHJZHlhQATkgvaH4ZORqkgzCPcgYCdywLzx2mWeJ63E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ab73bejb1+bVwilK177Fu5NE8C5y6mVFov8BiOs3KbVwNYBPxhSy5+NxYWi0MaIVXdVRN6fUkI3+9vjuT0jdSsLDOpl2uk03GuyfCQFkFhwRfW9sz7V47RlsNFICM16c29X8KNoCHa/PRtjjJM6toMXF5hNRZWttATZmnQj4h/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzjUm2d/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzjUm2d/"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d70b3e159so341982f8f.0
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777538671; x=1778143471; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GgFoP+Hqf8/38qhDMqyf+8AbFzuKkMT9RvTAVFKvNjo=;
        b=OzjUm2d/siiM6Yn6libH9WBg256REqAc2U7Iw4WQJNaV6ciCRGf8nie2x0gCudecSi
         WjT1KukTa9jWOcGtqexD5SkPsZaXG/P1ov6moRSbh+36oQFKO5sLqaWkzPPyPF2DvDgm
         YsWlkNyXYQaEanfkQeNV4vyLJD0YhFJUs8k0BPhqbMuJaZymCTm6OmEvpQgDcPmSlAPz
         RGbKlkLqPUBUC+9X6h/23WMt8YjiZHOdwyaQLFbTCqLqcu3YyxkmUxxvNwFb6ZVYmgTP
         Db46xSm99S78ZUW0vcUa4tNzd7LrZXDlYElOTt5cDZI0voPKd217Fuuk1sxlVKKUz/g+
         YMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777538671; x=1778143471;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgFoP+Hqf8/38qhDMqyf+8AbFzuKkMT9RvTAVFKvNjo=;
        b=mS0B8/CgzqVbu/jl90JkoMd1ZrqW5/J34sSYUgfyGDIewMGZdjoWUc4mMkmHXJggZm
         IC7ScgtiP+K5OVE5ONAbwpOuSJtAvnLiAlqQQZcNKKBciVHz+L6rcK+y/fcCSyrVU5EE
         0bWSk8d9KAV4OsE2pm4WqI4Zf1mzXHIHkhkLe1TYNmJQaPFtEpTq0oYzgTn/melDZbtv
         ui/Ed2kr7pQCJAnOIjo0CkbX6wzU1c/BJ5NEWpDduNWyIEPhJuXM0kO7TO/BUNyHYVhg
         NMo0ndFB4AtThqadsmEtnLjtKH5nufkGPV60p4ZzYjWPTeRk8LwoLS97NOH6mk2XGBsq
         eLuQ==
X-Gm-Message-State: AOJu0YzGvyYli3fybOIhbX/YWPuWBkW9QemPE97YuOP8s6OkqMwDa9hh
	EYqRPRvG3YRqT1xuMK8RBrdZ2TZstUSlMogpbcSvi0J7dwH99VsBZGRl1AxM5Q==
X-Gm-Gg: AeBDiet0eagDj/7LAzy6odX0HPRh4Q/oF7gUsYAmHykwxoePln+tMBQCdaR+GJHsLPW
	n49RKcYnQ+9Cw1/8bD9xBJks4cEqELEOlfPs6jKlSTfz7UBHaQJkAfUmz+a6mcsGFLVaaBeoHog
	3dxUFBM/dNU2wuw0BRtuBNQBKT7ikVfEGuySnNOKzNd6MZzQjc/U18TNpyGkAolfL3rKLVct/iq
	X0cvGEy/lzuuD/x3Mxk4cpoQuQBFrtDUj0JUfKEyZKrMA+uzf1A3sp50innldnZi9vEhNwE0jfA
	pgvs3WsqY5I9Ul7+hhTFqwSWlfCdrcw5ROZsfVATgTVsjN/b/CTOWTJUmYM8wXXfBg5CAgTAL5Z
	8+Ng1WIiJm/LdT4sUbfrOCLAAHFBJhxpUYob8lz+C0g1P4BskecfwYyZKS4iyQAXqcXAfulPU9Y
	mToqUuSCj+OC3uIzOdj7oIKjp5v9nPqWrib4mjVOJqTmWEce7bvycg/QKyWdomz6BJaGz8qqdPB
	4yITzWRvCasOqtALrWkJpOXJzqRdljaB42fOQ9I66CpBvrFFD2AtN4RP7pI239ilkCw8dmcmayx
	IK/ixDbsYKlAO7gdGAufaOjzBPzDVRKFaaBfESp4xokicbDvsZABSw==
X-Received: by 2002:a05:6000:186c:b0:441:2473:c30a with SMTP id ffacd0b85a97d-4493ec61a3bmr3026040f8f.31.1777538670700;
        Thu, 30 Apr 2026 01:44:30 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00275e75a6e46be847.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:275e:75a6:e46b:e847])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm11647119f8f.28.2026.04.30.01.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 01:44:30 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:44:28 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: Print breakdown of insns processed by
 subprogs
Message-ID: <5590f9c67e614ec9054d0c7e74e87cc690a52c56.1777538384.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When using global functions (i.e. subprogs), the verifier performs
function-by-function verification. In that case, the sum of the
instructions processed in each global function and in the main program
counts towards the 1 million instructions limit. Only that sum is
reported in the verifier logs.

While starting to use global functions in Cilium (finally!), we found it
can be useful to have the breakdown per global function, to understand
exactly where the budget is currently spent. This patch implements this
breakdown, under BPF_LOG_STATS, as done for the stack depths.

When iterating over subprogs, we need to skip the hidden subprogs at the
end because they don't have a corresponding func_info_aux entry and
calling bpf_subprog_is_global() would result in an OOB access.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v3:
  - Skip hidden subprogs when displaying stack depths and insns counts.
Changes in v2:
  - None for this patch.

 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 25 ++++++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 101ca6cc5424..976e2b2f40e8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -779,6 +779,7 @@ struct bpf_subprog_info {
 	u32 exit_idx; /* Index of one of the BPF_EXIT instructions in this subprogram */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
+	u32 insn_processed;
 	/* offsets in range [stack_depth .. fastcall_stack_off)
 	 * are used for bpf_fastcall spills and fills.
 	 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03f9e16c2abe..11054ad89c14 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18215,6 +18215,7 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 	struct bpf_prog_aux *aux = env->prog->aux;
 	struct bpf_func_info_aux *sub_aux;
 	int i, ret, new_cnt;
+	u32 insn_processed;
 
 	if (!aux->func_info)
 		return 0;
@@ -18229,6 +18230,8 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		if (!bpf_subprog_is_global(env, i))
 			continue;
 
+		insn_processed = env->insn_processed;
+
 		sub_aux = subprog_aux(env, i);
 		if (!sub_aux->called || sub_aux->verified)
 			continue;
@@ -18236,6 +18239,7 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		env->insn_idx = env->subprog_info[i].start;
 		WARN_ON_ONCE(env->insn_idx == 0);
 		ret = do_check_common(env, i);
+		env->subprog_info[i].insn_processed = env->insn_processed - insn_processed;
 		if (ret) {
 			return ret;
 		} else if (env->log.level & BPF_LOG_LEVEL) {
@@ -18262,10 +18266,12 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 
 static int do_check_main(struct bpf_verifier_env *env)
 {
+	u32 insn_processed = env->insn_processed;
 	int ret;
 
 	env->insn_idx = 0;
 	ret = do_check_common(env, 0);
+	env->subprog_info[0].insn_processed = env->insn_processed - insn_processed;
 	if (!ret)
 		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
 	return ret;
@@ -18274,19 +18280,20 @@ static int do_check_main(struct bpf_verifier_env *env)
 
 static void print_verification_stats(struct bpf_verifier_env *env)
 {
-	int i;
+	/* Skip over hidden subprogs which are not verified. */
+	int i, subprog_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
 
 	if (env->log.level & BPF_LOG_STATS) {
 		verbose(env, "verification time %lld usec\n",
 			div_u64(env->verification_time, 1000));
-		verbose(env, "stack depth ");
-		for (i = 0; i < env->subprog_cnt; i++) {
-			u32 depth = env->subprog_info[i].stack_depth;
-
-			verbose(env, "%d", depth);
-			if (i + 1 < env->subprog_cnt)
-				verbose(env, "+");
-		}
+		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
+		for (i = 1; i < subprog_cnt; i++)
+			verbose(env, "+%d", env->subprog_info[i].stack_depth);
+		verbose(env, "\n");
+		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
+		for (i = 1; i < subprog_cnt; i++)
+			if (bpf_subprog_is_global(env, i))
+				verbose(env, "+%d", env->subprog_info[i].insn_processed);
 		verbose(env, "\n");
 	}
 	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
-- 
2.43.0

