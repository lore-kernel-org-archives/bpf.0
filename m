Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3913BED4A
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621632; cv=none; b=kHQZ0I9FuWOcOvo0n7GmjfJzkgSzY4lIMBv+UOYjryUb01Az2nB3AyDDjfT6zhw8U05aqZYz1+yXv6hTeucNymiGepVURNfoYCz58YFlVhRwTEtysNxXNfZZSAhb0l8EUfHghAyDH32Hn7QrAKn4v3el8eE88eOdsV5+iq1f9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621632; c=relaxed/simple;
	bh=qQ5K9OKGZulWiLhYOB1FrnxadGcL5+/YeLvLHsca+1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyfLdJPCKv7TcZ0gvzvqNR9jyjATNy94YZs2xQfDpfmvNIpQWZEPgZvLRsDOJa/vOfKao+B7Crfgl9xO3KnJgKy10maCXcbSy8LBYKe4le7h5Oj8QyUOrld3d8EPZWAo20xnEQQiQ1f0DnXzs+9pCk/0YIZremjPmMWEA/Er8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBt5z+ye; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBt5z+ye"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6d817a94745so1099308eaf.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621625; x=1791226425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZR51Idqbkctd9YFgZiJO5Qq1jjz1fe5rgHJdzXHZtCI=;
        b=SBt5z+yeudFO50aejTGtOS7tJn2EguwYMnqmrDysyh/6gLhb/z3H7bD2giVSExvpXo
         K31dS6Pf/Rnw+7Z8HnK3AnL4j40N8ximq5Qjp3edGsM4qFB+GuvXMYixxwsqCEvn/5SW
         eDiZYBc0JQRc9M0O8/DPFjcVr+6dePl2+DNnJJF1iSZNHBZhLPRKJar716tQ+lj7ejJ1
         D2Y9ZtwzEJCPNAav1d5/fAe5IchAubdy3muDmPNwVpiidyPqWwuyGnDf92xO0UqptB8o
         0TbgR2lH3OVtfw8pHFhrBrvbXshhp2laHi9s9LDbouI4Q+bPTuglvwLpeA0fe8i3N0Qm
         JxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621625; x=1791226425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZR51Idqbkctd9YFgZiJO5Qq1jjz1fe5rgHJdzXHZtCI=;
        b=cV7apt8S4ieGGMGaSt4NSNNUCpQazLb050TIW/ZbVfR+Jvx9ZLdLJQLRhBON/nydTu
         3ZxFyyfDnczed7IPm2b3yzd4rpg55K07sbuQLR8CV7JNSLP83GoEOznRdfH9vSEDayHn
         byJuPmKTjFNj/jgEiZbWqUdBTyvW7ZyUdyVEry68YhOhoKQ6dU7cqR4Ej4uhCJXEGF75
         MF/41gYDEkIP38+v6Xecl7ayofU/zbWwq/qoPS4dE6KQZ6tbXAYjLQlD39NprrPReph0
         Ty6jfO3pkqjGKH+zukkNs3h7Qb+w/juTEi4dkghakGi0+UpkK8rqDe0r0lKX9oa/EVNg
         Wqig==
X-Gm-Message-State: AFuF++lFSpSfrMkrAWfTdgLpqTzyvNpSXAOmxnbiwZOeu4fPm7+1Ci6R
	5ONeKckOqWamerlwFZFUl1r4+2zJ4RtCYvGXIgjbLxo1oIHP3l7nh1s6MbwG6A==
X-Gm-Gg: AYBFou0NzlibOMlCTVHd9HB6mHCuU06A2o0zpkLgXdXTSovK/hbDu0unibXjHn1jqPy
	Ve0oi5Vl8Uvc2FN98+EFaylmnNUvhyOCmtbYB7ID/13ML3u2g3aV2At8jlNaoDqz+AGvf/B+Gi/
	tJPqBbC9QcGC+T6+hECsATVqnx35lw1eqU8Ss/QfL2ugxdNRej/pP1Yq6AOtCgEYuh6ixlcTxSU
	ZSgN90oUqZZB3U0JfELplAUsIYMBZjL17z8F08RYj/pO9WF2OOofh/kIq54EhuLYbJLczPzULgb
	UZXC/mUTlaV4qrZBV0MipyHD3gdsSpO//KRJNaS/9K90qqJ+WetfU6YsrtOd+LCIUwgXXqthrcw
	DD85ZiglvhpB9yUVPj00iAuWfzvikvOUndJYo8SfJldfTWCI8sehyq7XiN4kO2n0y49w/5a4eX4
	VKG+0+2kJ2ymaDC3srfOOSlTmtFPO/HPPGY42biT+e93gW/WljiDzOZoiReA==
X-Received: by 2002:a4a:ee10:0:b0:6b3:4a99:bd87 with SMTP id 006d021491bc7-6d43e80c99fmr14236893eaf.30.1790621624751;
        Mon, 28 Sep 2026 11:53:44 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d58f1748fsm2729849a34.23.2026.09.28.11.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:53:44 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 06/11] bpf: Check subprog context arguments in the common path
Date: Mon, 28 Sep 2026 11:53:29 -0700
Message-ID: <20260928185334.1004200-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928185334.1004200-1-ameryhung@gmail.com>
References: <20260928185334.1004200-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subprog and helper/kfunc context arguments require PTR_TO_CTX with an
acceptable offset. Route subprog context arguments through
check_func_arg() and update the verifier-log expectation.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                             | 15 ++-------------
 .../selftests/bpf/progs/test_global_func5.c       |  2 +-
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 79b9e7242fee..659820a4b805 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10880,22 +10880,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
 		nslots = btf_arg_slots(t);
 
-		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE) {
+		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
+		    arg_type == ARG_PTR_TO_CTX) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
 				return ret;
-		} else if (arg_type == ARG_PTR_TO_CTX) {
-			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_CTX);
-			if (ret < 0)
-				return ret;
-			/* If function expects ctx type in BTF check that caller
-			 * is passing PTR_TO_CTX.
-			 */
-			if (reg->type != PTR_TO_CTX) {
-				bpf_log(log, "%s expects pointer to ctx\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 		} else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_MEM);
 			if (ret < 0)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func5.c b/tools/testing/selftests/bpf/progs/test_global_func5.c
index 257c0569ff98..4573ecd96aa0 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func5.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func5.c
@@ -26,7 +26,7 @@ int f3(int val, struct __sk_buff *skb)
 }
 
 SEC("tc")
-__failure __msg("expects pointer to ctx")
+__failure __msg("R2 type=fp expected=ctx")
 int global_func5(struct __sk_buff *skb)
 {
 	return f1(skb) + f2(2, skb) + f3(3, skb);
-- 
2.52.0

