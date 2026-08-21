Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15FB37F8DA
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302140; cv=none; b=FeAhQvXkG153ckjooCCigeYxliQ4PegdQvK5p8JD8eN72AV6RfGy3mPjn31WqjYUg06dRK7ryQh9vnyTmCv82nqIzTgsuU5yeC2j6DzJZF+xP1GtXrHt4w5cMvnE48IV02sRwI+c/6KQhNIRTStHlgyTz/o0gvy4nIrPIM3wbqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302140; c=relaxed/simple;
	bh=auit6dJltMpMVdfk93UUlHOF7Xuq5X5jz1un/m4E4Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfvOloqxwmr8/iyUoR6caiQs5HnYuMioQw6e4s+6MBMQDtF8LOkOKhLStdgbAV1L5drxVc1HgL1mJJmm3FVqIbJyHEfVlnZ+EGddrZwhSQTXGY92Ela5a3snDneZdBZaWYquJkJ0ySgNIb3rEz0pnLqEUqino8eFqZmEoC2kJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAOSiUhR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAOSiUhR"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacf197759so11065335ad.2
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787302138; x=1787906938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lIWaHIfvDsxfbMU61aIVlsPkb+smxtYg8ROPDZM3qQQ=;
        b=RAOSiUhRmM6CvF7IqtlgNFRm6JXJJWxbPB4kDx0S/Ll0rAB2xUN0/PM119N133WuZR
         dC1Dy9+Jf4Cs9l11Cj2j6E1V/Wy+S1oeWaUdDT1d1eZT+3k/z0eT/6kyJrFwavGuou+0
         A8owo86tez/2eD+8YWJO0THzDTRzM2tGe7qeGMffFtZsYy8f3GwGxogWVb8diCwNu1yi
         6RPV8RcaDAO3gnde/PBkiuNUZtnPbHCudpOQoCmj4X56LdAjSuxTtyHBI5wSlhOU6VCb
         8hKVTakv0xop9x/m0e3ylmL7P77ke5AA2WcMr56bmdYW+KaadbBOyxYInqsrfVmtJ/oS
         EcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302138; x=1787906938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lIWaHIfvDsxfbMU61aIVlsPkb+smxtYg8ROPDZM3qQQ=;
        b=Xaa3fSeNDdQNS4jnR3h/zjTH5sfvGijlhwrwgIL9ENk9VfSOZnEQK4zLzELORG5+rv
         vyuWjG5Sr2zJ8CHEDBGNcEsPvZH43gfNC3EwyFwrGASeCucbsl0kHgESsqrCM0d28KRE
         OxPy9h1IhrkAlBV2Ymq9pQGOEcNYSu679vf7T+kHsOYV5ZAZQPo4omrzXh5AjTOUfrVe
         Nz7L1aq5BRoMjP1zvfrEyABK16KO5OS0aFAyz5e1ph2Xc3iKH4yQaX9pj0UFcZPVYtwV
         Gq9aShZ3TV0Nvxj7LGh1/eO8/YC4b9FTqEuPagj/N9yBUNhnJJRu4Dpn510kqjQ39h+U
         D+sA==
X-Forwarded-Encrypted: i=1; AHgh+Rqg6pvjNGzkQ857R0PaniNkDtopTzaiyh459WmxM5XOccC27NBXLAtDIV27saV+dz3eaFk=@vger.kernel.org
X-Gm-Message-State: AFuF++nbjI/3GE0d/JaXrwQ+429Pk+MJNO2W0/X5Xpz8PODncJxuGvns
	jPGuAdTm5vrZw4LVtPG8MSeSd71QFVV9hrgOceIvgBcyk/2wp0u2jUcO
X-Gm-Gg: AR+sD13P25KuUEZwJVCPxxuOIUt5tG5Lf4arDWiJnpFZuTfLpdDk5ViQTY/gEsFpBWV
	MoNiwJ9X2/875wm0Cislwt7jQOcsij+g6V2tXziMYzHYcC/GihbC2V8ubHpQwccttlpN8PYkFpT
	ztK85cgfjY0AoTpnOxGyicBhDeUcyRPFfbaaaadIV4UfCh0GevWBPBvclGFagkiLPDPfRvgqePW
	KmNrtMEGgd75d7By54ymZd/kphUygbX90JixGVhZp2jUvupYqIFvFmkg8cdWZpDsksR3u8eQ20Q
	PnMoKI6B3zkhOF3gSUUlVyIId50z2Z5W6c0CLwCHYWYPL4zWyJd72FawlUT5LYpI5w1qQXm6ke1
	wFgoKGMVvfhM6w3Tg/UsG/p2nJ4jgUQcJvXyvdXZUSGB0vfgo0Ons+xWjpLB9r11LT4VrAEaN3N
	sHMAVDF4l5o+E/1Q/x7dlMhpZl7zrStUzUQ43YHe89X8tdvufH0Pf5OZa/a3BwmqFCzMxfjmS60
	Y0+EzHS6hEedMHwVJYqZsiWjd1CS/EMwHoC80rq92CDWd4TyCiG
X-Received: by 2002:a17:902:fc4f:b0:2ce:93a3:c168 with SMTP id d9443c01a7336-2d64afe9f5dmr95925235ad.7.1787302137796;
        Fri, 21 Aug 2026 01:48:57 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d555b2esm16432225ad.11.2026.08.21.01.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:48:56 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pu Lehui <pulehui@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3] bpf: Fix stack out-of-bounds write in cgroup link update
Date: Fri, 21 Aug 2026 17:47:27 +0900
Message-ID: <20260821084726.3769957-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cgroup link update path checks only the program type. Several cgroup
hooks share a type while using different runtime contexts or verifier
contracts. A UDP6 sock_addr program can therefore replace a UDP4 program
and write beyond the four-byte ipc.addr context into adjacent fields of
the stack-local struct ipcm_cookie. The same omission lets an LSM_MAC
program replace an LSM_CGROUP program despite the incompatible return
semantics.

Validate replacement programs against the link attach type. Use the
existing per-type rules where applicable, and compare LSM
expected_attach_type explicitly because both flavors share
BPF_PROG_TYPE_LSM. Preserve legacy non-enforcing CGROUP_SKB
ingress/egress updates.

CGROUP_SKB programs do not require CAP_NET_ADMIN when loaded. That
permission is checked when the program is attached. Once the link exists,
updates are controlled through its FD, so BPF_LINK_UPDATE does not check
CAP_NET_ADMIN again. Keep this behavior and only validate the attach type
during link update.

Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
v3:
  - Factor the CGROUP_SKB CAP_NET_ADMIN check into an attach-only helper.
v2: https://lore.kernel.org/r/20260818061021.2551771-2-sanghyun.park.cnu@gmail.com
  - Extend validation from cgroup sock_addr programs to all cgroup program
    types, including exact LSM attach flavors.
  - Preserve legacy CGROUP_SKB ingress/egress replacement compatibility.
  - Keep the CGROUP_SKB CAP_NET_ADMIN check on attach, not link update.
v1: https://lore.kernel.org/r/20260805052858.2390918-3-sanghyun.park.cnu@gmail.com
---
 kernel/bpf/syscall.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6874ba1424af05..dfea337ff25ea5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4483,12 +4483,6 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
-			/* cg-skb progs can be loaded by unpriv user.
-			 * check permissions at attach time.
-			 */
-			return -EPERM;
-
 		ptype = attach_type_to_prog_type(attach_type);
 		if (prog->type != ptype)
 			return -EINVAL;
@@ -4542,6 +4536,19 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	}
 }
 
+static int bpf_prog_attach_check(const struct bpf_prog *prog,
+				 enum bpf_attach_type attach_type)
+{
+	if (prog->type == BPF_PROG_TYPE_CGROUP_SKB &&
+	    !bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
+		/* cg-skb progs can be loaded by unpriv user.
+		 * check permissions at attach time.
+		 */
+		return -EPERM;
+
+	return bpf_prog_attach_check_attach_type(prog, attach_type);
+}
+
 static bool is_cgroup_prog_type(enum bpf_prog_type ptype, enum bpf_attach_type atype,
 				bool check_atype)
 {
@@ -4606,7 +4613,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
-	if (bpf_prog_attach_check_attach_type(prog, attr->attach_type)) {
+	if (bpf_prog_attach_check(prog, attr->attach_type)) {
 		bpf_prog_put(prog);
 		return -EINVAL;
 	}
@@ -5805,8 +5812,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
-	ret = bpf_prog_attach_check_attach_type(prog,
-						attr->link_create.attach_type);
+	ret = bpf_prog_attach_check(prog, attr->link_create.attach_type);
 	if (ret)
 		goto out;
 
@@ -5931,6 +5937,7 @@ static int link_update(union bpf_attr *attr)
 {
 	struct bpf_prog *old_prog = NULL, *new_prog;
 	struct bpf_link *link;
+	enum bpf_attach_type atype;
 	u32 flags;
 	int ret;
 
@@ -5968,6 +5975,22 @@ static int link_update(union bpf_attr *attr)
 		goto out_put_progs;
 	}
 
+	if (link->type == BPF_LINK_TYPE_CGROUP) {
+		atype = link->attach_type;
+		/*
+		 * BPF_LSM_MAC and BPF_LSM_CGROUP share BPF_PROG_TYPE_LSM, so
+		 * the helper's default prog-type check cannot distinguish them.
+		 */
+		if (new_prog->type == BPF_PROG_TYPE_LSM &&
+		    new_prog->expected_attach_type != atype)
+			ret = -EINVAL;
+		else
+			ret = bpf_prog_attach_check_attach_type(new_prog,
+								atype);
+		if (ret)
+			goto out_put_progs;
+	}
+
 	if (link->ops->update_prog)
 		ret = link->ops->update_prog(link, new_prog, old_prog);
 	else
