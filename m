Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31C2F3614
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200620; cv=none; b=PDeW50rm1RbiQzFROYX31xeG3tOy6T0WwzmWB7PvOKOPihLVEQ6umFeT/4uwwkJQxFGQKqouYlg4JrqG9ohDY8wOzxSdUMvECu3vsqkoKGxj9lup4NuKzcnHVmNavR9gb+Mu4T8wOuK3dBRaHxiGsX9X8btBSZPjki+n/yLURqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200620; c=relaxed/simple;
	bh=pGOCrlht/5JKJ4wLHC/LTfvfNyE+Tah6Y4Jh+6xXwO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6sdoqOlUrC24aWw3tJvWG5sGwqJ8lDthR69Q/PjLhDoAxw3hwVSbjWR86lsyvA9kWm+3P9rLVHJc8nlz2ahUZQLDxnb8kJkOLnb1TnDL/Xs1uzKWFlnM4y/7yE5LTvCumkGbMS8iHRxIaZCpgEr+n1NloDJOHSxW3RTdkuaDfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAo8ETjU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAo8ETjU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e5d0ee1951so2816825ad.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200619; x=1792805419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQIOxyhf2PbQQW6RWNbZBxmEX3PKBk/yK3ayrqaRkDU=;
        b=PAo8ETjUlMh3C0yo5yuktL2VhxJB2GTdBmijnHM8WNESy8XVlMiIbzj4XcO1HzrkoY
         1BFhGDrPX9YgbmxDbtv8xHDJwuI1kchXm/Nrxubk2y6Q/vvdduV89r6Fdwc6ruOolZWO
         7wX8Dj4utN6NFKyhCZ275ko6rqVG7eVjsV7iVMBI0v4qxNOR0QxfWuSYdjrVv6VCgr1B
         hw1O/moIuFBs3KFZ4eJrvLMYVlredfwQcoUMfHqqfwVFUvyKD2ycTLu6JktvRbEggi2N
         Wx1mmmZMRRRhGntTR0fywK14StqAjSVUcpjDb47QCXxtLnM5uwG4vMxuybvciJWh+IBF
         nTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200619; x=1792805419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jQIOxyhf2PbQQW6RWNbZBxmEX3PKBk/yK3ayrqaRkDU=;
        b=WD+mQ0MwhQ2mnjXh+jtyY4f7JSw/MYdXQHMhMqfMIpnTnZv009FRp2hsgRYxtG2OpK
         zkQe8VuvUsl9BfVqj/ctXMzFRqKqjPXgN2a4I1ad3/WEHhbyg9u6axCUMLKDhIKxOUfD
         r4wfVR1UVLQY3AjOAB8P1AfVWIuWureTp8HxzBWLn3lKsqZMi/hyh8m3EbKUUD6pbbEz
         L7jFVjeunwPpsc6Ez89eXaeSs5FdZYW5NJbW311ObsfemQsW1J4oQ7JsMPFKz59Xy7pg
         XlVqX6jvo+hKWStAsLMLct9sJsSk5l66jtDsJOssbmfJ81bwvIRhp6vNcsYJx4rsMETQ
         f4ig==
X-Gm-Message-State: AFq9FYKhO2MHvXOsiABFDTdx8vG3CJDP8xwyME0HJaPvWsyvnFgugZoz
	OGY/CgT5wnEGS37F2gSFfhICC3X26XJjE7LFvR+YI94g5VpYN4nJiJRF83PEuPcj
X-Gm-Gg: AYBFou0sWTMh8LWFvQtQQ2ONDDQUuidZEz7WvOjb0Zh1LucxIsTkLS5XEGTHJyDzGdt
	wX8USKANC6YNvA2ZN7LrZhj6H1mWypSzTwtSWPuJf7aRpLVMoLt5q2d4xKgrey6nu5U2Pw8UjLP
	fdTxdWgeFwMnGMXlXQhRF0iG9+XYmYBdFP81H9xOpsKu4h+NpoycV65zOwuVt6cHzOtG1WVXl2F
	suqcutKN2WuWauKeNym7evyUyVg/B4fFFQV5NNocUL6ckm5VH42/Zz2QeUtAr6cc0BSvahNmUOr
	jntiWiDdUSyu53eZNpg3/xj/PCxQaxNxphlpuDDL7p+y9DI7ws0j8yNrFoPcTVAywBjTeAeuejH
	qNSe3WIgeUV+Z9xseHafc955gqzZ4CH5dkBvY973eVknIiEdp3sknDbleyUXn0J/6dlVWqZFBWj
	NZs7ooZDCXczvnRosU2+xmBzxmDh+vKVLC7QvNsNL0i4QnLo5MBtA32TF/L86UnhYdXV2IVzzm9
	ol5HzCumi5WttVvXNZSOHkjjflidFDEfEzDZZUvI0c7EQO+aYp7HHEZNDc0TF4oiKZvnOXJ98bQ
	tKST3W7Euh080ZdaLJQQ5wj5xPwlGW+84y1/sfjYy9I=
X-Received: by 2002:a17:903:b8e:b0:2e9:8202:509c with SMTP id d9443c01a7336-2e9a6846bbbmr14728775ad.7.1792200619220;
        Fri, 16 Oct 2026 18:30:19 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1f0asm16983545ad.68.2026.10.16.18.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:30:18 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 24/38] bpf: Assume no bounds for buffers behind a tail call
Date: Sat, 17 Oct 2026 01:24:37 +0000
Message-ID: <20261017012451.364800-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The bpf_map_elem, bpf_sk_storage_map and sockmap iterators hand the key
and the value of an element to the program as buffers.  The verifier notes
how far a program reaches into them, and the iterator compares that with
the map when the program is attached.  A program that does not touch the
buffers passes.  It can tail-call another program of the same target,
which gets the same context, and whose reach nobody compares with the
map:

  BUG: KASAN: slab-out-of-bounds in ___bpf_prog_run+0xa46a/0xae80

The program array can be filled at any time, so there is nothing to look
at when the link is made.  For the same reason a program with a tail call
is taken to use the whole stack and the whole packet.  Take it to reach
as far as can be into the buffers as well, so that these iterators refuse
it with -EACCES.

Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
Fixes: 0365351524d7 ("net: Allow iterating sockmap and sockhash")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 608621d7f225..002c3935a8eb 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2151,6 +2151,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			if (!bpf_allow_tail_call_in_subprogs(env))
 				prog->aux->stack_depth = MAX_BPF_STACK;
 			prog->aux->max_pkt_offset = MAX_PACKET_OFF;
+			prog->aux->max_rdonly_access = U32_MAX;
+			prog->aux->max_rdwr_access = U32_MAX;
 
 			/* mark bpf_tail_call as different opcode to avoid
 			 * conditional branch in the interpreter for every normal
-- 
2.55.0

