Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31133D7D8D
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785908484; cv=none; b=mETcbYxA07EkaW+tfnUWnSY656LT/hNugPx/YhZDKtKmP/K38W5H8f6Q0FGqzWhg5IFK9MQ/1ftHanXN8tozAuxbyk9H21QRDh9HV2JR//gihHFQzjawdS9uW/xNRhPBwwh7F9Fffa2OlCPFnOnaBTQh/PmwufXhmx1jL6nutLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785908484; c=relaxed/simple;
	bh=ywrwsMO35qriJ3f012DB3zk4zuTjPKxkuHP/zwhEiUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PEfMvzDekrkHF9a9VMDTgx9cuLY3dU1jwbiCfhgebtDLi/Id9jf6ryAxLJ5fAWyQ5sKOScRNFrAMX4OpSQnC80KJAcM5HM/17HJewj9IpxmCw/PShQ6r9FejHrZJ7uKKccXKnN88eAHdA4n8/Usai4xW/uzu9NhvSpA3g7Llr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPXt1AWC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPXt1AWC"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacb8416a1so6747315ad.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 22:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785908480; x=1786513280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9DqvMGnPgwJYNDOolmToW7Bu91CUDJtJ7cY9tf14UTg=;
        b=NPXt1AWCjR4h45h7FZqkmPLLLXq0mDe+PPScH5HAzGdezY3WtXXSAAQKQUdt/jJRWo
         Wkur+yuOvnAu7QrobAn6+bQaiBCWh1MZAgsxgRZsLFSyAUKk0LsWcXhexzWspNt3wE3S
         XUcE1bDHjf67M1oKbRObTPuCw3efIWWRG2mZ6fx+0UxKYeyVhFiJhXKHcnnzD27C3DPk
         pmGkaGaClvhKhCahj9qopKNmvbbPNFcL5PbvcGnMbew34YHRVRk9faCvlBd1o3WmJUKs
         P/iE1KzCjqZeFElXoi8jzeUWuFXnfmokkEZAAGFuIme6mg93P4ZPkABbRq/a1PI7Vmcf
         tVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785908480; x=1786513280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9DqvMGnPgwJYNDOolmToW7Bu91CUDJtJ7cY9tf14UTg=;
        b=YxCY1ZYPPKNbbyUlPvCEiJJiGh81A5S12o+YWeuHEIWXWUarR6pPcDTQAHsyurTLoK
         tGaUbs3ajT7YEPyXUnejB9kbUy7d/y+5eIjsXscwvnIvD8nBeBhQ4tAQijEy8IMqCnu9
         N9WY4nAsmqQPrWkvl72mhtvOXrl1vGbrsYsMcYdrHLqYqc/7kxRadX23+Sa7MSxKa++Z
         Ob8s2sSUkjPRrjzzqh0Z/LI65UvWLBObPjVHuldhOzIyW8ssYu5B1HSeAYm97cd5kAB6
         MC+m902l7lYmBs35uGDEvZig6Q4o6eQRFExNCl5/lzDqotUlA7YaGP3NN/0cClUd0YoS
         jWPA==
X-Forwarded-Encrypted: i=1; AHgh+RqG0JJoDpuu6lMAGlwybrDUvzCQM8zPLRjcvemculmk8VsXnOmXyzCbnN11hEN6maeX2aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywge4VzgJbYk3af74d6QwW9SjAVnPCXhMe4fXMpWq8LRLaXIQ0B
	f8qHLAcc78C3NGX6BRkXQMyDCqvDRKQPbt2EM6hNUZCSW59z3dKAmTnX
X-Gm-Gg: AR+sD12v/FLqjKpYoPko9jkLUcLDeJ3LNTYyOCDCRNbwV8b9u0upl1C2pQGIprEElOI
	Qg5dkQXbVZtOMxyc3ihCFfBEUQdzzS+smQnOowuehTYHDlY9VrsWWiadvdQnXDgTNSBSF6jz8FK
	20ViAaDLH7Es+JZIq47WpOQp4dn8LTl9wkXanvl7dO4Lo5Rhg7YhBe79iwUi4uQSU1VqSBz4Qo3
	djkkT4zsIMxXOl7Id5Cg6zTPB9mZ4KhH75b6SdxkqNLpEkzhQbO4YMAzZxdXr9OEoYw3NGbH1s9
	O+R6Z2AaN0riJKgKey8PHF5napaN7yekziNBI2EEn4GIoXkn5yqJbJ64L8MqiP1rj3UXXL2LL3T
	KjFgzAfPDEhqM3x7pxm/vHrOjbqmQJP8RaQrniV5buLENZgDLhnbWYiIl3ncoWpb9T/OhxglRl6
	zqYfsKWtbXan/mH0a77Z1bs5I3IJmFtomIGiaFwW9OuffoAn8KEVzB7xM3UXgVAxSb/RiMPphk8
	Nb2pgHtfTPp3zCwCDkaeN4uU4BCCnlKL14rSRILKMSlSY7TFNe+
X-Received: by 2002:a17:90b:224e:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-3903c5c443dmr3485495a91.16.1785908479682;
        Tue, 04 Aug 2026 22:41:19 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903f5ab5d3sm852195a91.2.2026.08.04.22.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:41:19 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Fix stack out-of-bounds write in cgroup link update
Date: Wed,  5 Aug 2026 14:28:59 +0900
Message-ID: <20260805052858.2390918-3-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cgroup link update path checks only the program type, allowing a UDP6
sock_addr program to replace the program on a UDP4 link. Running the
replacement writes past the smaller IPv4 context into ipcm_cookie::opt on the
stack.

Require a replacement sock_addr program to have the same expected attach type
as the link before changing link state. Limit the check to sock_addr programs
so update policy for other cgroup program types remains unchanged.

Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
 kernel/bpf/cgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index d2da5063d8f8..65bf25deac4f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1055,6 +1055,10 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	if (link->link.prog->type != new_prog->type)
 		return -EINVAL;
 
+	if (new_prog->type == BPF_PROG_TYPE_CGROUP_SOCK_ADDR &&
+	    link->link.attach_type != new_prog->expected_attach_type)
+		return -EINVAL;
+
 	hlist_for_each_entry(pl, progs, node) {
 		if (pl->link == link) {
 			found = true;
-- 
2.48.1
