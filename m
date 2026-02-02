Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D075339719
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770022875; cv=none; b=ovnqvTxfV+uXzqituVFKfj5goBbf+IqJg14D1WAimUmHCkfipgZokyVHlijoMt3YX/pY7CTtaqW8F+HC3pgXUqKg5sHGS026wlipbVEc4Szflj87i+ul+e6TO1Szk9d4CoGtw0olmRKPqmXIGPz9d6YlIahTgROH0QVCy9u+qK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770022875; c=relaxed/simple;
	bh=uUL3+hIqzzN4FF56+RZlxBho1NEz93n03uZmaBVx188=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yh68JVQX5DpE5QH05S5xD/r5soS230rPOAxhD8C/1mU8qic48RO+dKTf3KGgmpsIhOVAQJqA3lDmvz3CHtax2opoR5huMZ0JHKpU6+eJoc6e5NIwLi/UBCWFeDPgb1TBF+VZa70bd1gRiWK6QtSiotEFTlcY+63qX6OcXoFzpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGcnQ+CV; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGcnQ+CV"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c2dc870e194so1801762a12.2
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 01:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770022873; x=1770627673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32rXQW4BVZZQ4FbVA0RQJRaOaveBTs70Lc0Lq+KuBq8=;
        b=RGcnQ+CVutx+QZWU96DSzT7lgWeiAhn+WbSBXYeHLNvrKrHfMphkQCFyU/+bg/AJcd
         kHB1M8QnrlgPFpYo2vMcYNyJWAHokuaWhlMa53ayWoMORQcDIUQUKmk/46pJIFnARZQw
         tTlrX8HtW0RbNzkGkvtkmaC0NO88epNkJBzBTRnMI1oVkugN5PCtluzU7WDF1NISHnc6
         7pyPxvSYQWjAACp13DUvt6jXbk9x3FniVfHsIRzkuYe++kAxyiNGPajfSkRjLyrpO6Cp
         4ysk7R1NpUyERQcD6VDSiJV5z04SQdJebhN9b5+3766rclKAOfcy0tPmmZtIjY/jgj9b
         qEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770022873; x=1770627673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32rXQW4BVZZQ4FbVA0RQJRaOaveBTs70Lc0Lq+KuBq8=;
        b=g8poWItsxslOnIpSbpHQX7nM9wKDWlw5uhLK6lu7gvBqVYPlx1a8EqIKasswKdEt2j
         p5EoUshSjCI6zY+EpHjedB1YXG5ltFFqxfnwIpSpMzmLeVHaH7C8sylqjaaQ5DKR8LNc
         z+SVuen39+wbWcxeJ+8UC3IngXiOBFQUm3/EWaeaSp/6c7+MJYXwPeQr1LkLYso5IzEf
         aZbiPQRg+YQtvwOfDUPpEHOZBFS1+2umlDITvRv7GGYr2UXDoAWa1E6zrVbmjbw4lfiB
         zxH9ZKTfnm6aqWKKF8u6ggL3olXjGt0UH3IYQ7bmXtaBwmq1UcbQDUfe6zVgLVQv3+r4
         oLMA==
X-Forwarded-Encrypted: i=1; AJvYcCWELwZEloFkRVuWMez+nJU+tfJgwPbxsdTEiKa6yaKwuF/CF3FNyq703fTSrF/k63/Is7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM9ly28grjxqNXt3Fj50CfWsKOzbGyVzXm7tCQA54OV+vKitaf
	QNMRxf9lPc2+i1Ftik3ig9Jv1K0zZvOahFXceU8AJdXp1gG6XM8c4K1U
X-Gm-Gg: AZuq6aKm31ZgNhWgupN/6H9+04Z6lGFZT6ShustGFZYKccJK9e0GboshafZxvaXqEAG
	xnq8nTouFFOGD90btDMofP/AtNt0HZcYNpffrVKjD9+Or3GCbzwruQu3ahB+0nMekDS2eTJtNAc
	w1/UvjroqyMClehZkPkXQyM6YnePqrcHGDj7CQS/R4ATF333V14J6h5S22iziqQXcOsvLipy9PM
	RjSnTkrkVX3unJ5CH0RVJdswTq1HLSm40h5l7iUC1I0JSC/9ZF3R2fMJAiBaJ2O098/xal/8fh+
	UyePT2ThLF9NF2vYIW95SYQ8HtnUMPWYOmk+tlVlpyfBBKw4EuCB5HO2ktLEAnjGXbSyVrL5pKM
	SborTTopOid7KpVmRsG0hd6ZHNXrzDqutT5r7ih99eyk9C7r0Gh69xMbD5olWKaGHSLXz5i28lR
	Lb2wrGo5cRa2cdot2biEkfsErQyWkH6ohE0PUkpCbxlw==
X-Received: by 2002:a17:903:2b04:b0:2a7:62d6:d049 with SMTP id d9443c01a7336-2a8d7eb55c4mr94604105ad.8.1770022873338;
        Mon, 02 Feb 2026 01:01:13 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b414f1esm139167635ad.24.2026.02.02.01.01.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 01:01:12 -0800 (PST)
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
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH v4 1/3] bpf/verifier: allow calling bpf_kptr_xchg while holding a lock
Date: Mon,  2 Feb 2026 17:00:49 +0800
Message-ID: <20260202090051.87802-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260202090051.87802-1-pilgrimtao@gmail.com>
References: <20260202090051.87802-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

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

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
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

