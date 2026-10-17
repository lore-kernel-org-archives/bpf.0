Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548B49BB6E
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278649; cv=none; b=ezoQw7V2w+hDEkrEeSDysPFI1kWGtfooDLp/ms9eFM1ikh7CqhyIsXkzQOxTCRzNxTm7TGwR5G3GEgDd7dWfWjJkoiF1/oNf6T036fW6dJevENbDajlG+EtAsGsjGMvpHxarxSu17wKkXjNkhToV7a1auFOdVmoBIX860gPIc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278649; c=relaxed/simple;
	bh=4RD41nmik/Te0tZffGBYJ/A0lksREPFzblJ14x31Qrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMdVShik/GA5xpGnjMDt8rmsuehHsNgCWzuWY3ePxDy+nUyBY0l5iMItLj+Y4EiCSDLsRMqc+GJBYOGErv0AFNUtqw5F6H9DCPAMI7aQglNZWnrEFaYJXstG6vQH+/cJqsnzwqeFUaL3ESdk0wXqOJzw+ZL+efPugaY79cjU52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBCXIP0f; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBCXIP0f"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9d1114320so1490145ad.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278647; x=1792883447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=int1YABfoCvaO6HZzBYTZFq9yRwP0JNWlCFdyR9pj4s=;
        b=eBCXIP0f3k8Axljvc4jsjClFouTZMxsWx0qD95JHMmhJk6fm1tcLa2FeF51SMUZcWl
         zAwCxrl94u4G+hx6w8+57c3I1Jv1H5pguTJhReRns/+tNZFSI0dqdC34ns8YIVvNR7jw
         pBMMed3CkAwNE+uh4l+uRTrnbWyHAta9qJiQ7JtSBlNOUF3NFTguGVCyE3NwtRgo9hGw
         OrG2D+o59NvjYOg8K42NmNLkE+kujMQEdipIeeB3QFQ6gKtnor5JI5YN+V93Fvamd72t
         URb+4UVj12BvoldLsezJ1uGiFzH/ad3/ZQP0HIZtmhak9tggLCQNTffX2Pj0CkCFeCn+
         0GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278647; x=1792883447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=int1YABfoCvaO6HZzBYTZFq9yRwP0JNWlCFdyR9pj4s=;
        b=yJFspjPEsGxYiqBVql8PW3qzZi8ntCtBhV6qlf6fvo3fAXU2sXPlkohzloePKBYLr3
         arX0Gm9wdKD4gc+OZKkc+ecPMvgXigrngIx1SHYgxH33r7G9ie5lwHAV6x3DbJenLq4a
         tqZ+WdRTwMCUkiSxt9pe5taQ4CNvmXuN0XiV/K+pTTaczzK37C6cPyT3GGq80b9jrO7a
         ymDZpA0HR8sw7q+kKD0kWZiVUGwxzbTSxHIQQMVWkZR+320V42Zw8MM4a/ipNWC1RAAR
         x7f7jxnAFasuofMy5cdpEDUyAsbk+LTbD93wJz68Or3aQPCOwSjMh6ONNtgH3utArB/o
         58ew==
X-Gm-Message-State: AFq9FYJb+SG4M2vEyspeEGKhY2F1h5DLx+W47VJbDlfBLnHSINbc9VHx
	EFNjMBDslkcj+GPmdm7FvyJIqO3a2UbCV6RL8ToCqCJiOS7xQT3X2oHYbbxFQQ==
X-Gm-Gg: AYBFou2okgzhgr2+MeDzXKpy4GRlIl5zKGg9hM2MXip4OzF+pD4z20VMclJAGV84bcc
	K/4wk5mMkGr2deIHR3OPWpZRJ2g+jfQBBQgVUQs7equOKCqE+4dxFTxUyrYRACpk70vgzvnKUQt
	j8bPqiGZ5x9TUBvaeOmtv5TOlH4KsGSuEKkoGaxDoD4N7t4/+K4F9WEe+Ju6v8hD7kW/zLS9Eul
	miIVQWARaNsf3VHvRoK9hL3bFjLJ1bhOAkBeF3BQ8fweXCbU834fm9y2j02J0NprfS9be4N+woB
	RYDeVAfypac2s7bdtW72nAs0EaLJy4/+XajSqTq4C0c6eLk6Id6nANyGrWpahHNZMFjK4IJfoiM
	v0pwtkE6BfRYhlb9cwzCjaUe+nalnkPdD33WDqQOWXp1gFvd9TbVUL5Q9JvYFVV4uhQLfY63X8K
	2DdWC2jut4ZnIQIkdgDJ6sIONkhPoDN1rA9H8Wt/3KH9TCVt6h6zRWmR6sxkRHS5Zsu0eZE3/j4
	yGxCRKM21/5kr/GGHOhQExHXGLh0AkZE6n/Fa8CX+Wa7+vRS7218C6gVJqCu/nRXZDfYhpI2acS
	UQOWtt4dH2Wen2ai9+hM2jtJqFoRZaBOHADRlPxDpM0TqT4INQjWvMU=
X-Received: by 2002:a17:902:ea01:b0:2e9:4b9f:b81f with SMTP id d9443c01a7336-2e9a69f957cmr34509525ad.31.1792278647404;
        Sat, 17 Oct 2026 16:10:47 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804becsm23805315ad.21.2026.10.17.16.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:10:47 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 09/16] bpf: Let bpf_dynptr_write() mark a global function
Date: Sat, 17 Oct 2026 23:09:43 +0000
Message-ID: <20261017230950.802052-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The caller of a global function loses its packet pointers if the function
may change packet data. That is found out by a scan for calls of the
helpers which bpf_helper_changes_pkt_data() lists.

bpf_dynptr_write() is not on the list, because it depends on the type of
the dynptr: check_helper_call() looks at it. The scan cannot do that, and
so a global function which makes a dynptr from the skb, or gets one as an
argument, and writes through it counts as harmless. The write can
reallocate the head of the skb, and the caller goes on with pointers into
the old one, which has been freed.

Let every call of bpf_dynptr_write() mark the function, as a tail call
does. The same mark decides whether a program may replace a function.

Fixes: 51081a3f25c7 ("bpf: track changes_pkt_data property for global functions")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/cfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index bce7b5abcfda..2ee950e9ac82 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -598,7 +598,9 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && fp->might_sleep)
 				mark_subprog_might_sleep(env, t);
-			if (bpf_helper_changes_pkt_data(insn->imm))
+			/* nobody knows yet whether the dynptr is that of an skb */
+			if (bpf_helper_changes_pkt_data(insn->imm) ||
+			    insn->imm == BPF_FUNC_dynptr_write)
 				mark_subprog_changes_pkt_data(env, t);
 		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_call_arg_meta meta;
-- 
2.55.0

