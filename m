Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E23B71C7
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591635; cv=none; b=GVtvzE3fBSRTacoG6gDi5XvtqjefYE6PRTW8aMVqE/CNn0QMz1lchkb1O7HwD9gpxPLBscpT5jT6Zz3U9i7Q7f4Y3+P5EOd5+Er7KvncWTVkFmfHF6L61cv9uWY8FRkU5pY17H4/OOp+xN4hgB/dMzAdXT5R8DA3MoS/JEKlROQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591635; c=relaxed/simple;
	bh=nJAWTsOFzzQ5VawivE4h3EfZFBeT3Iw3dgLy1hDKhW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ri7FF04sEqSqIL6SF0pE1ksCmeWvhRg5KLJGpkPFtYGrRZRlHEMNJNazoQYTvx6f5w1/ZENYyDw9mTuuo25WbJoLqV2ixTvWup5uEmDjU+LdwR69jq3VJcAOFYWO2wDQQR55F4kYiMoCeoF73AuYSg3a7NMntAx3qHSrTAoFuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnxQ6A+T; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnxQ6A+T"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso6223465e9.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 00:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591616; x=1789196416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VoYoQ1jBURPpSe2kbQ2ENyZBjfqnc21mSLLWfnQhqz8=;
        b=GnxQ6A+Tmo3xGGmrSYwc4va+y9kyXutCNc/223BilIzX+0EmIU1B7JMZZzgKJAp8PT
         S7pt9jlHqpnU9k+Ta6QuybCcX2BVUTCDjD3BWARa5NTlK7IREfxC2R35Og68m/AJR2N4
         Azo/sZ07uZhj7C/QB1CtA4SU7J2mIr8xKghizYiyXVfZR9C+uXQr4G33mF2aIkV5gS+a
         NcQc6R/8AuwyEM5xUw119W2zQvarteWqCjrIGuJ6KYX38jRgQg5Ozz0YoaA51xwFbORr
         Y1bZjzS9An9kLXtQdzb2KvbGpz2zUWW7/8N+9LeYLXVSiJ1MqK3rNWFP1dEaEtlsMuFq
         3mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591616; x=1789196416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VoYoQ1jBURPpSe2kbQ2ENyZBjfqnc21mSLLWfnQhqz8=;
        b=JpCH/FJYPL2XBzM/o2H/MhMghraK45PAkT4qgF2FZYC27P5Ov8CBicFziQFF4MrXS3
         zmAU0WIQXdQ9iJPNnlyFYtOZ0sGGOTsijKZP+wDrXqZyLCftP3vVc+l7vfybEppHrJ2o
         QR4pdbkJtgptHNedHSg9WTQH8EcdlIb6e7CAfEm+ZobtjODtrDgABKHyACDX+xjIDBYS
         Ou/vMGxhmg1McpXpl1JTfDx6GAdAof4wuyB3nZWJzoxPKQUCOz1cxpAz2bgNFDGCyiCw
         VwdKysX//AC1H+QQK5j02zXap1GPHis9CSPEkl6aK6VKJC9k0Wv44HkF/cz/+9rEn/GA
         QwKQ==
X-Gm-Message-State: AFuF++nWRxDkY+L24xVhr9piJqN+J1xh+trf2AcKI5OeCdULlpakJ4S+
	D3aq6RDUVswOClRtUGfgdsE8Bj6UTINSkmdmmlGTp0/BwpSoz6480nvPEiEgE8Ra
X-Gm-Gg: AYBFou2qXOYtetjhgxyBAwwDiMER72fjSCiJiWOeRiDCT78+vl8YhrwEExwMjBsI8HN
	Ei+mjzIG2ACqrwiHfRPzFio5MSCvCpuJWQZ72Kh+v8Y4hm/nhqFXGGOJkU42GYggUDlOIIbjUvi
	s4oU4Y0qEWn5bkdzw40ABuEr0LKZgrCHDKw7SIYyiCkZaa5zztP2YK7PjRFK/OQczoSLIqZZiAR
	7JgT5JnMwatopHWO3Rmevk64djYA/2b96n3+RLYX8243loI1ALsWQiOiO2+RQPeplKtwipyT054
	Mk0y4MFeGQwxAtdVzv+fREAW/NjETEnRJ3WpUzJS1WvwPv6GI2AjfISh9QhSdIj9gmnolxcUelW
	Kl7/mbKCSfuQexiOFAOjZp0uuXK+epC878+X4dnxVuYN9ySKGioP/iLS4967TSLVvdoaYqVgxGt
	Jt6/O5WvoGmlMoI166w5QIib8R0Mo4NxJVPG4O8Jt73Cx3pQiUudTBD/CLZGkKweBJRnr3nTJm4
	CQM83fFMjyPvaCBfgXXQI2X8lb1jZKONew51qgY4fKANaK7lIqg8+UclH3eTWyZi+O9bA7wS+Y4
	UC0zm2YEj9s0ZOItQbDNYpDWwUY=
X-Received: by 2002:a05:600c:4e46:b0:49c:fc6e:8cb4 with SMTP id 5b1f17b1804b1-49cfc6e8e51mr78292305e9.24.1788591615593;
        Sat, 05 Sep 2026 00:00:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7febb4sm225206155e9.14.2026.09.05.00.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 00:00:14 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 7/8] bpf: Assign lock identity to callback map values
Date: Sat,  5 Sep 2026 08:59:58 +0200
Message-ID: <20260905070003.3193366-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905070003.3193366-1-memxor@gmail.com>
References: <20260905070003.3193366-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530; i=memxor@gmail.com; h=from:subject; bh=nJAWTsOFzzQ5VawivE4h3EfZFBeT3Iw3dgLy1hDKhW0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv23uUcvRwneircvJbG/jQ74bzSvrkvi7MxvjHBcbHNn VfPPAs6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJH9axj+J8f8vsGx6LrqV22j Q1PUWrcckrL58Knzw/ls7ma9xVILAxgZZh674MU0ITd0QdqanqOV70Ve1EVckfYLvCa2W0Th5Oe pbAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier identifies the allocation containing a bpf_spin_lock by the
pair of the map pointer and register ID. This permits ID zero for direct
map-value loads because those maps have a single element.

Callback frame constructors also leave map-value arguments with ID zero,
but their maps can have multiple elements. Consequently, nested callbacks
can hold two distinct elements of the same map with an identical lock
identity. The verifier then permits a lock acquired through one element to
be released through another. The same confusion lets graph kfuncs operate
on one element while another element is locked, allowing concurrent list
corruption.

Give lockable callback map values a fresh ID in the for-each,
timer/workqueue, and task-work frame constructors. Preserve ID zero for
single-element array maps: their callback argument and a pseudo map-value
load are aliases of the same stable allocation. Maps without locks remain
unchanged, while copies of one callback value continue to share an ID and
support balanced locking.

Fixes: d0d78c1df9b1 ("bpf: Allow locking bpf_spin_lock global variables")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c3039f3fc32..b08501734ddf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -447,6 +447,11 @@ static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK);
 }
 
+static bool map_value_has_static_identity(const struct bpf_map *map)
+{
+	return map->map_type == BPF_MAP_TYPE_ARRAY && map->max_entries == 1;
+}
+
 static bool type_is_rdonly_mem(u32 type)
 {
 	return type & MEM_RDONLY;
@@ -10035,6 +10040,9 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
 	callee->regs[BPF_REG_3].map_ptr = caller->regs[BPF_REG_1].map_ptr;
 	callee->regs[BPF_REG_3].map_uid = caller->regs[BPF_REG_1].map_uid;
+	if (reg_may_point_to_spin_lock(&callee->regs[BPF_REG_3]) &&
+	    !map_value_has_static_identity(callee->regs[BPF_REG_3].map_ptr))
+		callee->regs[BPF_REG_3].id = ++env->id_gen;
 
 	/* pointer to stack or null */
 	callee->regs[BPF_REG_4] = caller->regs[BPF_REG_3];
@@ -10131,6 +10139,9 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
 	callee->regs[BPF_REG_3].map_ptr = map_ptr;
 	callee->regs[BPF_REG_3].map_uid = map_uid;
+	if (reg_may_point_to_spin_lock(&callee->regs[BPF_REG_3]) &&
+	    !map_value_has_static_identity(callee->regs[BPF_REG_3].map_ptr))
+		callee->regs[BPF_REG_3].id = ++env->id_gen;
 
 	/* unused */
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
@@ -10249,6 +10260,9 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
 	callee->regs[BPF_REG_3].map_ptr = map_ptr;
 	callee->regs[BPF_REG_3].map_uid = map_uid;
+	if (reg_may_point_to_spin_lock(&callee->regs[BPF_REG_3]) &&
+	    !map_value_has_static_identity(callee->regs[BPF_REG_3].map_ptr))
+		callee->regs[BPF_REG_3].id = ++env->id_gen;
 
 	/* unused */
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
-- 
2.53.0

