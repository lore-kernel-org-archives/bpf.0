Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03B62F3621
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085659; cv=none; b=uU/FdjemZAAeq4uM3NSecPb74yuLnxQ4eDd59zC+v1NrcgY2/rbzlG2lBnTC+W0mHqw76B+3fyKvZmI2ra6R2swZnRlvXx4qTVmAWPSFCFRogDctYUzrqQlrSucT+3n5JLsrRoxOGpKYyMta5nXZY+r8r11xdW+r5HGYoimowZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085659; c=relaxed/simple;
	bh=kSmjWLmcefmycBNqZaCB5fBXIFk5C4u57kzOKBBeOtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIBiKOpIuB97z1EHinyZFD2DBzluUqhpFHN6JAwnciS/etMZUX6+xR0EoHz3d83s42WqgHyjXfeTAnaY2o2tV52/nPaUbCJF2GuSBN0r7KM+ph8eP2qEXx/JPpEdf50IiYLmZC/4ECyt/d7ZlVTM5g8frsV3kmA0u0EQrQiLm6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuIFP+8w; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuIFP+8w"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so4089873b3a.0
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 18:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770085657; x=1770690457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bu1IOx9397kcg+x+veWwtPTpaDzd2JZvwlujnmQyLjg=;
        b=PuIFP+8wE0ggenSH5zzJ8M1OLbPGTwdT5poamgzfWgQDWkD4HNAFxZgKLI94pjY70i
         lE4nk36w9SLpfja7FeDMKoHF/zMXCeZLMjbQ7XyiYkVHRuf3LMyirNs+sUUQTdQLHIdx
         DYcuGEsnO1680jUj9t+zXSUTmfM/8QO4xc38s4PxxjdcZ+gOIG6AFkTdAo9zvhp308Oa
         lcEq3TvW+NmBT/LQ/iEpLfsuIDUY4/Yxey112ji2PjQIvtiISy/h8H/fYjh8mkCOJDVu
         Gd+kmCeQe0IMX2x2N5dAwTPNScYZItimmEJYb7fYAM9YCCp5LW02RCjtyzwe3A9dQ3Et
         ldmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770085657; x=1770690457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bu1IOx9397kcg+x+veWwtPTpaDzd2JZvwlujnmQyLjg=;
        b=sztGndWxyTd4iTL/KFnxS2cHkmikiJPBuJ4S4H8thRO3cWIWdYINVRo6wO7A6Kquxy
         nADTfwH3ItAiYsNLIor2tpMM1zpUHliIVlLshUgvFstZxz3aglupU1BGWcwD5mvtEVcP
         AQSgsXNEQWQRab80+iOggohRC3dhaKxyoHIhRz5FB/xsAqF7qWg2RyFoWHq+kj5r12Vr
         q8BXFSEOBOT/quRtahu1dR37LvTFXr/tERudYATmTEPh4WvVQtkqC3y0Myfo+wEtTBHJ
         rJ4a7DMF/jH9doCHZGUUsnOfjZOUmh9Aso7jShuUvqpAacrhqCkuUOQhFVEZbgjLSPsF
         zMCg==
X-Forwarded-Encrypted: i=1; AJvYcCXKYbcNz8YlSP6IASn0wPTdTzc6l8vGgOAonpfoHraEptkAJ6nAb0Q+30Qs5BPHvP7UMvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7yuK2LSsXYIaAYtxdx5h6cZdEe2/MgFsuLdc72wkgrKvKp2x
	MOtfdIVwhyxXNtB3wfftf2/T9KyADSTEVynwU98J43OvtS21c/5JJHTs
X-Gm-Gg: AZuq6aKupZSXcpJKDCQjvmjyhBzOgnrNVEHi+gZ1J3xTdps0NR6/f7qutCU9sCUfWwQ
	jaR5qC0VREwar4UsbmAXJcFjcw/2CPtBDWjLfxINiZ96ISyBElZ9RWu90/wYenr1IEum9NCh3jZ
	0uHTN6NoLvs7ErLWCnRqYHPs5AQXb1VzsuyKTTpcq6GSzqrO+Gj9wEgHivZo82gxUFhNtclCG3Y
	KaIm0+q/oSZyDYZAIzFMT8eyX/i5RaEuYqkYaraA2+YV5TufkMxpmrpRVElmOGQKRUORhwlZ08c
	bVsdDbXPwpyKDTnVducwGUoKTN/0knZbEzhtxG26WDvjNJTQviiqZ2AlrODOWP+xdl6YcbfRvom
	oLRDg7RBsmHEAgcrivtPWPvPQrBS7/UUk8x68dMbUO6/bzL4itEtGYKC3IEYa0EQW76u02u3mgB
	6Y+ODn1EkPheFlovzkiEO3W7qKWU6t+Yr1nFS+TiJe/hyD2FeQT6s7
X-Received: by 2002:a05:6a00:130f:b0:81f:3e3e:c1fd with SMTP id d2e1a72fcca58-823ab63fe4emr11969495b3a.5.1770085657235;
        Mon, 02 Feb 2026 18:27:37 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b58f38sm17803073b3a.24.2026.02.02.18.27.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 18:27:36 -0800 (PST)
From: Chengkaitao <pilgrimtao@gmail.com>
To: ast@kernel.org,
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
	yangfeng@kylinos.cn,
	alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chengkaitao Com <chengkaitao@kylinos.cn>
Subject: [PATCH v5 1/3] bpf/verifier: allow calling bpf_kptr_xchg while holding a lock
Date: Tue,  3 Feb 2026 10:27:10 +0800
Message-ID: <20260203022712.99347-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260203022712.99347-1-pilgrimtao@gmail.com>
References: <20260203022712.99347-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao Com <chengkaitao@kylinos.cn>

For the following scenario:
struct tree_node {
    struct bpf_rb_node node;
    struct request __kptr *req;
    u64 key;
};
struct bpf_rb_root tree_root __contains(tree_node, node);
struct bpf_spin_lock tree_lock;

If we need to traverse all nodes in the rbtree, retrieve the __kptr
pointer from each node, and read kernel data from the referenced
object, using bpf_kptr_xchg appears unavoidable.

This patch skips the BPF verifier checks for bpf_kptr_xchg when
called while holding a lock.

Signed-off-by: Chengkaitao Com <chengkaitao@kylinos.cn>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3135643d5695..05a6a6606b6c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20387,7 +20387,8 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 
 			if (env->cur_state->active_locks) {
 				if ((insn->src_reg == BPF_REG_0 &&
-				     insn->imm != BPF_FUNC_spin_unlock) ||
+				     insn->imm != BPF_FUNC_spin_unlock &&
+				     insn->imm != BPF_FUNC_kptr_xchg) ||
 				    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
 				     (insn->off != 0 || !kfunc_spin_allowed(insn->imm)))) {
 					verbose(env,
-- 
2.50.1 (Apple Git-155)

