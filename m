Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577395;
	b=fNyr52GdwEAzFOrVP+Wx8p8+gfHd4+c7bFTcZ4GMRwbHFoUu0AN0AR4FVcG59rIspWOo
	 qJGwaD30TgdQqBxpUAmZV7qde6yVw4dGj/OzAMtBdRXIboSuRmSJrnY6GBWHenRRwW0G6
	 piob+ayMd58RAPdoHfZAaBa4xelDiFU/kc778iGuxDLWZ2wcOvLykBbGAJvIWjxEWw4wY
	 PbD6oKCpl6BxbWUdG8e/5+ka8UWvU/T6i19B0hvWx/Y2hCRGk4hX0gm9sfF2KfMxrIwjA
	 heCuY5lQEXcp5OPaIzdG/i2C6ZPIZufZzEfocT5eOI9G8YPiIXvrStSZODWMgkEnrgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jhGs0wcLGdC6EeYYrFudgvd6hGnh6OGeSUMJpvTZEW4=;
	b=3ach2W0w0pI+uuH4p7R+Uvr6pjaVp1bN2iJDduOkxbu70qO6aJyvCwjWAXeAmNysqEvw
	 l74bYCSfzU/uzCPKEIotktdYxU7uWAG2/K1cfvF6UO6khBLTFOj0CZIqzCa4JJv2s42Fw
	 rMwJob3wl5+EIH0jxKC2Dge8+aRCBYOG1rsk7SMggpYYGl6QCS3h701LQSa4gkao4o1Fm
	 fCcCYXfi1vBIS3hwFnug8kpc21Ny4nXaViKm6SxGY6RtC4NorN+OW4+H1HYMsNkzQ98Ei
	 wWguHu8amf4UUG+oNC0/nlnWZ+Bs9GHbU15KAKM6MUGp2CZ9x1CsontHHw6JxpfD1rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UHTcWIa4;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3469606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3469606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UHTcWIa4
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cde1479f76fso2988022a12.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577394; x=1796182194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jhGs0wcLGdC6EeYYrFudgvd6hGnh6OGeSUMJpvTZEW4=;
        b=UHTcWIa46FZh1Y5bR5Uet795L/pvNotMQPAFfwJVDdsG46HyR14uKbK9hZz9XE4P8O
         zwTlK9Jnszo+Fet/4c9y/CXtJ9BA9et2902YjzhXGq/AqSL1mMdbty0ZrA3dtFsEMPMm
         rkQhYMMDwahSrMUUI8UjJMVMzQfHDdPMSJRj3+mmt7yLNjhC2n7cIkosUNepLUWZHjJI
         ++IGgpj95zIEsP9ovZD+4FEXfNJY4zRJlC0OsWuHBZ5w/Nk0mjdFfuaRBqFM29zABgWv
         ubTzDcpB7rHiSb/UTFg1rq1NgduGYPtWxSuhj1ZjYHFsyo/7D31g6JR7q+Ys2RnvpgYD
         NgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577394; x=1796182194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jhGs0wcLGdC6EeYYrFudgvd6hGnh6OGeSUMJpvTZEW4=;
        b=nDQZ/1469rAc3x6T2qb1SesKUkKihxEvRGi0AUU/M6/OsiPLW4gBZ/K/xzPdQbVCMh
         W+/jwzKMLx7pTIjuXuTkWyFuy+5LvGe9+gAxJ+kGgiwkRJzfk8M1x0ZQREKymgTGdKne
         /niCpVmBuJO5XZaqEkM+dJKXmkzaZRKU9U8hwlVTyFc2hxb7qRl/P4wRd70eUQwVJuSl
         5NjR5k5gwGTj19yxWAFDXMMOYTs34NJckTu7lwdi94jBhsXnBu7GuvmuMAWIv1LLFng2
         Sb9CPgV3mW+rPuqD/PN2izdZoR/2LdvKeyi8VL6pPEn9znIIpGpu54rCx9O3QAr1z57K
         BRfQ==
X-Gm-Message-State: APuU4Z+RA3qK4+7/cllURzfhdqlcl5ikaYo51IMeumLDcMI9cSqnzSOs
	7XxCtFs7FWP+0u2HLpfRpCJvWj6k6TIqy9/BAPeOiXYt84dYrWJj8fm1WEMSftiZ
X-Gm-Gg: AZFdTZd5bcEYuj9K/lEKrA7w84alsQLjsCQ95M0AXK/GhaIz+zhBadZQGH2GGKr3rGB
	TQbTCtTjeKXw9GFH+sogruju2/z/ABeFU+s6ZACVcyRJ2wfsSuF357IMUwyxleRRSL21B5zxnvP
	W0pgi6cK8CiMKBYRDjmO3+YUCXvRaT84IA+9u3bosqBmK6yHdQclZ4AudQsiK9f/ZNKU9FAU61y
	SY3MxlbHkBBaoENSGcBeHcGKPQx41TKQodL7JofrcZGw5IuAwvhpXNFjOivozwayBopjWHL1z+u
	W6RhVMgp+kJ+hZLso4tVuGjX9aJIjqJkxpbtujOMFDzvW2EyM0J+0E7d4xqBZyYe4EuMCUGvXow
	kgirw+TomL31tGPtf9LsG9WJMn2KoD6rlt0k04QOOmIi1rRwyUfE4U7UnZPyVIDEGGIh3Rh+aQH
	J/d9d7Rtn8OYWYKcYYky/q0KDq8nOIeHo/ZMDnjYM9T2dDTzqmRIxaLVWINXZJrMCE+ZuMqQomQ
	ekC0C0T7cdubBeAu3mpq07xtwsxVLZOJTLX22kRtXOTZTPgVkzj0+Cgu3AlKrAb8v+yzOUXJj/4
	X3Xq+SZiYhwbJyGM3wFD+eqCny+6bTXsA9QJb47j+2LaPto6VUO7ybNlRKTyAvPT0hnk1J+1QmG
	pyc7NuRXU2a1BEQsmw+8TrkM0f0eZbJFGx4CLPhnPXebPgpejwOSbxi4k/9j5Ezjj3QHaQ0V2ng
	==
X-Received: by 2002:a17:90a:e705:b0:3a0:9640:803a with SMTP id 98e67ed59e1d1-3b41c7e118emr15617016a91.5.1795577393850;
        Tue, 24 Nov 2026 19:29:53 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b457a58d04sm10225045a91.0.2026.11.24.19.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:29:53 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 02/47] bpf: Look at the type of a program next to expected_attach_type
Date: Wed, 25 Nov 2026 03:28:53 +0000
Message-ID: <20261125032938.670542-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

expected_attach_type of a struct_ops program is the index of the member.
sock_ops, cgroup_device and cgroup_sysctl programs load with almost any
value. The kernel compares it with attach types of other programs:

- Members 25, 26, 27, 43 and 58 can read ctx[nr_args], as fexit does.
  The slot has stale stack.
- The trampoline of members 58 and 61 clears that slot, as for fsession.
  It is the last argument when the member returns void.
- Pointer arguments of member 23 get the rules of raw tracepoints.
- Members 59, 60 and 61 cannot be loaded.
- The release of a cgroup looks for the LSM shim of a program that says
  BPF_LSM_CGROUP and has no attach_btf.

Look at the type of the program too.

Fixes: 27ae7997a661 ("bpf: Introduce BPF_PROG_TYPE_STRUCT_OPS")
Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h  | 3 +++
 kernel/bpf/btf.c     | 5 +++--
 kernel/bpf/cgroup.c  | 4 ++--
 kernel/bpf/syscall.c | 3 ++-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1dd9db16f324..a1c96ca14afd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2517,6 +2517,9 @@ static inline int bpf_fsession_cnt(struct bpf_tramp_nodes *nodes)
 	struct bpf_tramp_nodes fentries = nodes[BPF_TRAMP_FENTRY];
 	int cnt = 0;
 
+	if (is_struct_ops_tramp(&fentries))
+		return 0;
+
 	for (int i = 0; i < nodes[BPF_TRAMP_FENTRY].nr_nodes; i++) {
 		if (fentries.nodes[i]->link->prog->expected_attach_type == BPF_TRACE_FSESSION)
 			cnt++;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f5ecac4abff4..7c83f3bdfcf1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7485,7 +7485,8 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		nr_args--;
 	}
 
-	if (arg > nr_args) {
+	/* expected_attach_type of struct_ops is the index of the member */
+	if (arg > nr_args || (arg == nr_args && prog->type == BPF_PROG_TYPE_STRUCT_OPS)) {
 		bpf_log(log, "func '%s' doesn't have %d-th argument\n",
 			tname, arg + 1);
 		return false;
@@ -7622,7 +7623,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
 		info->reg_type |= PTR_MAYBE_NULL;
 
-	if (prog->expected_attach_type == BPF_TRACE_RAW_TP) {
+	if (prog->aux->attach_btf_trace) {
 		struct btf *btf = prog->aux->attach_btf;
 		const struct btf_type *t;
 		const char *tname;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index f195d5fcae6c..88b49238931a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -399,7 +399,7 @@ static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
 		return;
 	}
 
-	if (link->link.prog->expected_attach_type == BPF_LSM_CGROUP)
+	if (link->link.prog->type == BPF_PROG_TYPE_LSM)
 		bpf_trampoline_unlink_cgroup_shim(link->link.prog);
 	cgroup_put(link->cgroup);
 	link->cgroup = NULL;
@@ -509,7 +509,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 		hlist_for_each_entry_safe(pl, pltmp, progs, node) {
 			hlist_del(&pl->node);
 			if (pl->prog) {
-				if (pl->prog->expected_attach_type == BPF_LSM_CGROUP)
+				if (pl->prog->type == BPF_PROG_TYPE_LSM)
 					bpf_trampoline_unlink_cgroup_shim(pl->prog);
 				bpf_prog_put(pl->prog);
 			}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 60c4d84b9aba..48ed0944f31d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3025,7 +3025,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_PERFMON))
 		goto put_token;
 
-	multi_func = is_tracing_multi(attr->expected_attach_type);
+	multi_func = type != BPF_PROG_TYPE_STRUCT_OPS &&
+		     is_tracing_multi(attr->expected_attach_type);
 
 	/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
 	 * or btf, we need to check which one it is
-- 
2.55.0

