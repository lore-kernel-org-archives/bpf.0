Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D941A929
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 01:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788227373; cv=none; b=SOAMK8w+mOu2ecPD3rnX7yBvFSTFuMbic2DcWavHTOZIy3PhBLUzUlgBeQRuRZsS0ntBuuYqyIYOPIyi7UnJKV5VAl2tohqVOKcY+BdIJ69ELpmGbWwg6aEDxfBCYj8tiiXKyqIuRm2AQoNJg370aEDsbNTRXm9BEXfTuZsnPTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788227373; c=relaxed/simple;
	bh=hzJqku1NKnKQ3kDzXaTk1gV8CP1VqSkYqMhFtIY65xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2GOyhzt4AngdMvkgZ6ovHMch67UTrbCImQrLDA9O4xdWWc0bOG7M9LJNOPYMnu5zMt7uMD57LSjQh/VuEmiWzT5CQTrkC67Eb4XBwD3DEFPwKasKoniGllqZ6RtE+YjiIVYLAZhtMve/+aOjx8xKVHtPqLp2FkIxlYhbetTlq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8fqvtKF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8fqvtKF"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398b3c37877so3014947a91.0
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 18:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788227325; x=1788832125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UtPjE3LBTPQKBFDeLu8tjdOsc0ywo3CyI93GelhRobE=;
        b=A8fqvtKFZkLnQXLXgvESFKhjlsLBrkPlDEspdF9aQEkOALFNHt4aLRqK/vUxsJroC7
         kmdS6Lcmwyi57326yto8kZUcFruJl61sGtmlEryIj/1o7q2zWLT2h6+Ig3tdn39q0cbB
         eN66lF+qkbuCfAGIyiWACVv81s6O6UtEgDnzu0tXLoW46lsrOyUf4eLdJwuyfT5viIl4
         aWWss3EOzC33XY6yc+n2sG9/fpHxgVlsg+W/OX6wY5WYHT+XtG2IB77aQFd6UFbdq5/l
         mLzylLmyU/1kCT/H6G5z3EAw1LZtzlRlqRtfISw0bfy+k6R1V6iZaE7X7Xdubx409bV1
         0ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788227325; x=1788832125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UtPjE3LBTPQKBFDeLu8tjdOsc0ywo3CyI93GelhRobE=;
        b=U6Hax88KIXsxs5pMEH/ZSAymOzQoWh4biYARJEmfEMJ6DJOR16QyDTcAPxw6kG3h8s
         ruL/Fb25Lljb5sPg8z6I89mjpPN4JPfEM6wzkWT4mAYbuvbTvlw1gYcnoTszIUAJ9wLw
         P4UnyrRWHE/qLjPSmzjTkkCUCVOAODkDVFFrPaaRGQQ1byoPw46NU2DIWk3tYFFTRLqt
         o4s4wJeULuFZQFmUP8AW5/7TOPda+zszNfLFemI1mQNxKAj2/agvOBzfEhOlMbz5wEFO
         AExaD1MjrVTu7F7AWd/C+2cbJSd4FIvDobTZB3Xm2GLoGYap8rEIrmVopbcGJZIpRWR1
         CNrQ==
X-Gm-Message-State: AFuF++mfHyXvigyE5dCPB/Acgt2cW2uFm3Oivp7Aa7Y+v0BaiQIJNwRf
	SOfCPWAcvw95m+W3gAc5s/dV40q5WKwG4q3uQUrlRXQtzht1HYxtOFTqYnYBPce3
X-Gm-Gg: AYBFou0GaNAk/NaiZL42TC1kKWOVWQPoiOR1RMe1JbIb+qZ2/jS0vxLDCwEgXkcfd3B
	i+nktHmMMoQ1JDoJDTI4eOJuIkHXdUr9WwnjPxwMgS5aRb+hdklsIRflMQUx1SMQFb5ebEx/1f4
	T6gK4cVL51juvcK+etrsZKUIYmf6OA+KVVJ+S4txjTvYjWk3aOqTPiuiCZ9kg6ckSBOEgb+dx2y
	VWGrCga4OwI7Ej5KqJyXBS72A4ulksK4XcS0QpKKmzL1VxGdqEAXu8rjHduBs33FUfA0ZdDT4r0
	UUmm+rUFLgp2ShgfPxUOA49UR60Jp11VVuph+0UbqhBtPw4BxUnbPqGLJfAcThh3R012rRWiDvv
	GVHDEgqYnAH501SMiqPu7/GwcolQysCHsSwfBrtUhlbWJ33A4ImQPjFvCjT7PZs5S6WOalWGaJ0
	Cyl4k8SSQRmCn5Kgl0m7BIwFvm5RKQswnP7h3AA4qx/gBrtMqDX2lQYfKoGVQiauq1q6E5qBj8Y
	aXzsO9gVZijVStqR5ZZ0Jv2lbrp6VTFHRwqzTkV8VaZrzjrlZ1a
X-Received: by 2002:a17:90b:4c0b:b0:398:9c0c:7c72 with SMTP id 98e67ed59e1d1-3989c0c7ffemr30120187a91.25.1788227324764;
        Mon, 31 Aug 2026 18:48:44 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d7ba9d5sm2820668a91.13.2026.08.31.18.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:48:43 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: bpf@vger.kernel.org
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: Fix program BTF use-after-free in sleepable programs
Date: Tue,  1 Sep 2026 10:48:29 +0900
Message-ID: <20260901014829.3504342-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Object kfunc calls embed metadata owned by the program BTF. A sleepable
program can remain active under Tasks Trace RCU after its last reference is
dropped, while program teardown releases the BTF through ordinary RCU. The
invocation can then dereference freed metadata in bpf_obj_new().

Move btf_put() into __bpf_prog_put_rcu(), the callback that frees the
program. When teardown is deferred, that callback runs after the program's
own grace period (Tasks Trace RCU for sleepable programs and ordinary RCU
otherwise), so the BTF outlives every active invocation. The non-deferred
path invokes the callback synchronously, so load-error cleanup stays direct.

Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6db306d23b479f..3b6cf93c43c4d6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2438,6 +2438,7 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 {
 	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
 
+	btf_put(aux->btf);
 	kvfree(aux->func_info);
 	kfree(aux->func_info_aux);
 	free_uid(aux->user);
@@ -2448,7 +2449,6 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 {
 	bpf_prog_kallsyms_del_all(prog);
-	btf_put(prog->aux->btf);
 	module_put(prog->aux->mod);
 	kvfree(prog->aux->jited_linfo);
 	kvfree(prog->aux->linfo);
-- 
2.48.1
