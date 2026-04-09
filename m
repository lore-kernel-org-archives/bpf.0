Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68DB31280C
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698410; cv=none; b=kX8Bo374aesjw0p7rsQfZVYU7q9qT+WugAadcqEsrtDwp42+HWVmHgY1BKXyOmONnQVFLDspDX2dOuzt6Gej6K/+HLJ1BI36D/Lbkpbid+Tm7pDcbLhrE/iqKX95Ng88ugL8NQU4sB+Tu8NbAAz0D+V3y34Dh+aXSgEGH+yaJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698410; c=relaxed/simple;
	bh=WScI9TKD5e34k7VJanPUhLP+NF/1cm4d4zg1XzQdljY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N83+QjjKdF/aP3hGrc5xpGvBgwqTMXwVlO0W3+eBQhCMgSlLSLfN+pVyhqs6jizq7l/nk73TBFgCkpszLP6pU1I+BxQMhoeNBY7/JXhicsDoVtQD9Eavt7cWCMhgFlbzfDfUBCqsTigO7S3R2nHeMPSB7TzINcPk/g4x4CAAJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDozc23f; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDozc23f"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-128b9b7e3edso609654c88.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 18:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775698406; x=1776303206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hirvb8MQh0RHTUEJhWg71eQP6C3L0JxuIv2RQHo6poQ=;
        b=DDozc23ftgKxfkc/SP/zLH3u3MaXuBG9a6+YM0Hn041XQ5tu5zOP8SyTN2VA8F0jVn
         mL+59mgt3nzOdZVzHcBawK7dggJNK6kGneLrlDq+Ohi44qa0n1uBlxY2KBGymKgJ6HwQ
         sHIo+7GRroBV6aGOjHlZnwYcxqVnoucRCt5HUfa3WUmQL76w9sSMhcFQMwC6LQtqrJP+
         R2fHmu7XUWL4arfz/yPm8+zsIVuvPVni15/kuu6BdxH7s/+WU2np6oXz/q/o4U6240XP
         KCCsBNWKYu336u7uP02Mt2dd7lwxfoUPjxX4JHXbbdKJXf5pThBaxDf3/rjLvCgGhYnR
         WQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775698406; x=1776303206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hirvb8MQh0RHTUEJhWg71eQP6C3L0JxuIv2RQHo6poQ=;
        b=RFBbXE6ECe44X3jVbzp4VaNGL5HbhFN7qMbsnwxrAtZPH/BdXT3y8C1jPig6W7eWpl
         C7J4rYpMroaSB21wXuNe5PTTxoESUYEut8L4NTRmjZQKKaUn+2GrlVXwHVAMoPcE9UIV
         0/EOo2EbJrYhp5k8mVmCSxkl+YBuCl3GR1mluHdtddn5h4lhgLZhDKY1nhEX603bkwwg
         go8rKmhxzZQkPJhpvkBeb8LfWbPCx6BK40InGgXOcFqRe6YxoCuKDKuwoBGQhi9za5Me
         grWHtpFzwvwP+StnuZXeroUX/CDI5QvH6sQIn4bBp+3EVAY7i5XHwtCRqFh3Kr7A62po
         dOTg==
X-Gm-Message-State: AOJu0Yye5JNKmJmVWaCEeHujDMOxozDx+x+0dsescEayWz8NI0CcqZIu
	PRoo8VzBRYMoMT5lIETtnjGbfoRE5gQskgmCXTfTFA8EcNo/dbJAZ5+d9T6u/pPH
X-Gm-Gg: AeBDievUAFh6PGNcG32j1dMZlqUI9+sYbnihVe7Yx6rtuv8AR0+DqUsxcRsqhKBpLbG
	TfWv4RxU3AkYRiFsp3AXU7mPdCvfEMMYWehNrsnFjmJCqZ66DFt4CtXtANHitO/0uCjxjom1hxZ
	ENjPUZ11ZC2918qNJvE2n+Yv1x7G77R9+pcmfZLVLP5SNrS2LAfcAakf/IGoqKnUD1j4IPVeCQN
	lRdwxsX0FV0wrTwF6eaYagUFA2RLCyUx0OOCCg1s7bCVF+eYrVZ7UOKaUnqBHW9Sy7ISHHaJnOO
	hNlGyXr4xn039Wsi0Gz/CyeCK4SxE4+INN/LolQ1kwiXP39ayjcss95kYCjKix+mNEN2d8mSZOz
	ktQCeQMaazsou1SSs//owk5bK0UdyJJnQd3rxMkpkpqt5QQGGQ77Tr2H1+z3exdS/aAtOuxNTLF
	W+I3zkk/QYFchuyDJkqQtvV754JovEGz7g6mueNz7mec/g2w7aRutKALZYwVpJ1EojhedIT+XIE
	v0U5kpe+TiWrA==
X-Received: by 2002:a05:701b:2202:b0:12b:fb81:d69b with SMTP id a92af1059eb24-12bfb81d909mr7421754c88.19.1775698406274;
        Wed, 08 Apr 2026 18:33:26 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::c05])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c0ce7dfe8sm15943230c88.3.2026.04.08.18.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:33:25 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 02/14] bpf: save subprogram name in bpf_subprog_info
Date: Wed,  8 Apr 2026 18:33:04 -0700
Message-ID: <20260408-patch-set-v1-2-1a666e860d42@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Subprogram name can be computed from function info and BTF, but it is
convenient to have the name readily available for logging purposes.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 15f7f9f35be98f6f30c46cdf03cf5c0249a8ac38..410939d7b3253f62c18b85072c921395709d7a3a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -664,6 +664,7 @@ enum priv_stack_mode {
 };
 
 struct bpf_subprog_info {
+	const char *name;
 	/* 'start' has to be the first field otherwise find_subprog() won't work */
 	u32 start; /* insn idx of function entry point */
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dd81cfbad680712e4d871163b8ee179fafe8587c..c1da28de869cbb395dee7d7f700d90113af9f433 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3635,9 +3635,12 @@ static int add_kfunc_in_insns(struct bpf_verifier_env *env,
 
 static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 {
+	struct bpf_func_info *func_info = env->prog->aux->func_info;
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	int i, ret, insn_cnt = env->prog->len, ex_cb_insn;
 	struct bpf_insn *insn = env->prog->insnsi;
+	struct btf *btf = env->prog->aux->btf;
+	const struct btf_type *t;
 
 	/* Add entry function. */
 	ret = add_subprog(env, 0);
@@ -3689,9 +3692,16 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 	 */
 	subprog[env->subprog_cnt].start = insn_cnt;
 
+	if (func_info) {
+		for (i = 0; i < env->subprog_cnt; i++) {
+			t = btf_type_by_id(btf, func_info[i].type_id);
+			subprog[i].name = btf_name_by_offset(btf, t->name_off);
+		}
+	}
+
 	if (env->log.level & BPF_LOG_LEVEL2)
 		for (i = 0; i < env->subprog_cnt; i++)
-			verbose(env, "func#%d @%d\n", i, subprog[i].start);
+			verbose(env, "func#%d @%d %s\n", i, subprog[i].start, subprog[i].name ?: "");
 
 	return 0;
 }

-- 
2.53.0
