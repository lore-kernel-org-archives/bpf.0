Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7299C3CB555
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788227303; cv=none; b=ihoT1i2z5Jwvmi4f2jl52fyYOXJWNMzidK2XbSxRHmNDij39D+GH9AIzgGh3zBiKdmTNxcBBLV776pTdhiQLjWVsbtSMvlvQeOSh3kP1/JxdvIFBTiZhwtdFyEbCa0C0evIDugGRbmUKl0HORen0VFbO3cCq0VpTEwNG25OsjCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788227303; c=relaxed/simple;
	bh=sEqoE/JOspzAh4I7PK3klxs+bcydlAXZlE1An4cO3Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+5eCFZ8v3l8rZ7+RNSMq01amkh2YJo/Aav+ZYxdEnhs5Ny60lF9R7+qGPqvXoVvnfa19jprvZDVpCdowGRsVbfmJwxkcxR73sevsn6DuUEXwq8m5BuYil7LapZRFtx3kCqgzfjHEGAHn7GCVbhVGV9z4kZal2gwf+1FFL2i+CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT/nKl5D; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT/nKl5D"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d9004f39d3so24961685ad.2
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 18:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788227265; x=1788832065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+/E7TIF3u/RGKDlz/vbcdmW4BNPGxEY5+7Q5goscvkM=;
        b=WT/nKl5Dzj/WdzvVmNlFS3qRcJ375vzVwNdet9nLaZ8IIDZtK9gzZoDSX6hPXjq6Cr
         9rmnpEDOPNzGvDWiZqJahzs7Nc+zFsq58rXSgQd5fJR5y5LlfN4Mdl7bOgp4JR+sJIgM
         y/FO0WmUaI8rhMbPdHqKT4Wbqw+eJ5n5e/z0twM08EC59vGmEtxFEg/warf3OPl52xWO
         4ZPc73X1HddUtSJQdIhXQl0l6URyWuNn3CRCx8KvzISwLzXkAcbp+M+A788RkO0WJoS9
         SXVUxko9F8D1jLL47HNWBoJzOrqaKWUTB0tgWu28QDWE4wIdn/cXtR3K6pWDVLmjE3fi
         MuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788227265; x=1788832065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/E7TIF3u/RGKDlz/vbcdmW4BNPGxEY5+7Q5goscvkM=;
        b=Rde3z3uxcJnZSZer1naioG0apB2Tzo1SvDeWA7pvbHG9kwit1/KTf6s/1kY6DpAVWU
         OYHcwn6ECDWUJOKZUBq0Wp5m11Qn18hbPqJOHBjyCc/X70ANl4D0GcbnaEX8plKrGNdw
         lnoEdYC74fomT6ZVG0Qvw9pgLzfR+RxY2/Scs/FlhqXg9fD3rc9kuxLM46Iy7woWt8Gq
         /uXBxtDnwm8dzAj1HHAomnzuQvD/kU47g+lsA0M50e0rXn1b0NJOzn/HcoPcievkxPpg
         OPDoPtTrrGwEwpNHNmGle2N+P2nnejVFGcA/IhtiPGrTGXkscG9gW+6yTfbxpgoGCVZU
         dkTw==
X-Forwarded-Encrypted: i=1; AKwUvBx7L1Ubvg6d8rmKzg5YVd6MPNkdFF1QNs1AfsupF2k5TG96s4+rkJjUBRypxmsXjT5hwOk=@vger.kernel.org
X-Gm-Message-State: AFuF++krBesiGLEJ1Wswqs+dHToVU0cb4LUSdliSOrpeUg8WLfmn1r4X
	8CBnF/FIwslUexA+5ea3sEGytl7LLuQnF2RRWpNlunrzX/GHOiakHxgH
X-Gm-Gg: AYBFou0m+RixmuRN52WLedns3M0+Ib8CzXyjONyA1IV6mnBDvUwmr6qOqwHTuEhRTo7
	97M2XRiy7UVcZg6r3gB4aCOPaww4iLxvDwhpUXfN1tU+ubYvbXyIx+T9niu1f9mX8l4eqzSboQQ
	qgipU4t+Mebvdi5+OjV9ACE47NZTPU1Pn160Ct5ufC+GjJ1Vaq3DwfNFOa0ihlcpc5Q8WgEUtII
	C23szoNm9QRs9sY8Fg5IGQaK1XwsYQz+DJLrtjklX9uT9tJeG8FbQ678lHqvd17ua6di844PfLp
	hN1oAK6PqNR2VYp1C34fax2kjr2otZdmK1Pdon5NPbgilcUM8G6OGm4Eg9bDaqq44rxtTcx7nrd
	2AwXpqSOMmor9dkC8ZB0ppkvyFzUR1DlZSgHukYZVC+6GTyCOHp3Ag67fssDclkNZIFIOzwpmcL
	YvOJ6y+zBzPRODEzs7BrGngqXQCFBAG0D/7W3BQYMeGN4uJMHi6Y4yKReO2b6/YcLqjOFD+8jRN
	HfGTJ4bDKtOONA+tYi0wmUjBhRiI12IukmAUIkpM74rErf54sMQZA==
X-Received: by 2002:a17:903:4686:b0:2cf:c543:2c7e with SMTP id d9443c01a7336-2d94a8f455amr62657115ad.10.1788227265233;
        Mon, 31 Aug 2026 18:47:45 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d911a9651csm27053495ad.21.2026.08.31.18.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:47:42 -0700 (PDT)
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
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pu Lehui <pulehui@huawei.com>,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 1/2] bpf: Validate program attach type during link update
Date: Tue,  1 Sep 2026 10:47:09 +0900
Message-ID: <20260901014713.3502900-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cgroup link updates compare only the program type. Programs verified
for different hooks can share a type, so a UDP6 sock_addr program can
replace a UDP4 program and write beyond the four-byte ipc.addr field in
the stack-local struct ipcm_cookie. The same gap permits incompatible
LSM_MAC and LSM_CGROUP replacements.

Validate every replacement program against the link attach type before
dispatching to the link-specific update operation. Keep the CGROUP_SKB
CAP_NET_ADMIN check at initial attach so pinned or delegated link FDs can
still be updated after a capability drop.

Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
v5:
  - Fold the link-create permission check call onto one line.
v4: https://lore.kernel.org/r/20260831023918.1857658-1-sanghyun.park.cnu@gmail.com
  - Validate every program link update through the shared attach-type helper.
  - Fold the LSM attach-flavor check into that helper.
  - Keep the CGROUP_SKB permission check in the attach-only wrapper and rename
    the wrapper to describe that role.
  - Follow the preferred BPF multi-line comment style.
  - Add focused regression selftests as patch 2/2.
v3: https://lore.kernel.org/r/20260821084726.3769957-2-sanghyun.park.cnu@gmail.com
  - Factor the CGROUP_SKB CAP_NET_ADMIN check into an attach-only helper.
v2: https://lore.kernel.org/r/20260818061021.2551771-2-sanghyun.park.cnu@gmail.com
  - Extend validation from cgroup sock_addr programs to all cgroup program
    types, including exact LSM attach flavors.
  - Preserve legacy CGROUP_SKB ingress/egress replacement compatibility.
  - Keep the CGROUP_SKB CAP_NET_ADMIN check on attach, not link update.
v1: https://lore.kernel.org/r/20260805052858.2390918-3-sanghyun.park.cnu@gmail.com
---
 kernel/bpf/syscall.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6874ba1424af..2bcd3f3a2a55 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4481,14 +4481,9 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 	case BPF_PROG_TYPE_SK_LOOKUP:
+	case BPF_PROG_TYPE_LSM:
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
@@ -4542,6 +4537,20 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	}
 }
 
+static int bpf_prog_attach_check_perm(const struct bpf_prog *prog,
+				      enum bpf_attach_type attach_type)
+{
+	/*
+	 * CGROUP_SKB programs can be loaded by unprivileged users, so check
+	 * permissions at attach time.
+	 */
+	if (prog->type == BPF_PROG_TYPE_CGROUP_SKB &&
+	    !bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
+		return -EPERM;
+
+	return bpf_prog_attach_check_attach_type(prog, attach_type);
+}
+
 static bool is_cgroup_prog_type(enum bpf_prog_type ptype, enum bpf_attach_type atype,
 				bool check_atype)
 {
@@ -4606,7 +4615,7 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
-	if (bpf_prog_attach_check_attach_type(prog, attr->attach_type)) {
+	if (bpf_prog_attach_check_perm(prog, attr->attach_type)) {
 		bpf_prog_put(prog);
 		return -EINVAL;
 	}
@@ -5805,8 +5814,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
-	ret = bpf_prog_attach_check_attach_type(prog,
-						attr->link_create.attach_type);
+	ret = bpf_prog_attach_check_perm(prog, attr->link_create.attach_type);
 	if (ret)
 		goto out;
 
@@ -5968,6 +5976,10 @@ static int link_update(union bpf_attr *attr)
 		goto out_put_progs;
 	}
 
+	ret = bpf_prog_attach_check_attach_type(new_prog, link->attach_type);
+	if (ret)
+		goto out_put_progs;
+
 	if (link->ops->update_prog)
 		ret = link->ops->update_prog(link, new_prog, old_prog);
 	else
-- 
2.48.1
