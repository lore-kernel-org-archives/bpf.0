Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B702365A00
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058322; cv=none; b=F7nsIsWb5hkmtVWmNnbG+a2BBPDEQB2uQeVRKq5ZtBo7uliJB5n2HU/If6eimVc+JLVyxQCvVR66B/qCoi93nm8C118wqRgcr5ditk0e+Ioxu9dAf06npUOhRRTluSsM9YHnysObWsEGpf2+ZtStIxIg1FLN7QvSzKUayFZuclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058322; c=relaxed/simple;
	bh=bVTg7g/DgY21o4JRsmGKmk0kP2qQqkrlnZU2sa3maDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/9f3LTtjq6EemvoxXe6dgis5uZ3rYa9b5jHj4KdhyVBwlyld9VIMHANyX5/pgTXDxxephll8+ESM5Uau4ZbnGLxF1HDYSyeKWEcbSEQqi2nSnD6ov/PFTb/mrS+ZaHuyzssoTRK9UopmwMOFag3oWshirsfXq9QOq5r544tRTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZqyNv6S; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZqyNv6S"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso1259238c88.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777058319; x=1777663119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NsjhhZdX0yxy3kgINItwDji3KGNUTwxF928253yyINA=;
        b=oZqyNv6Saw2P8WkXhAfhkkQEvJvRtnFuOod/+TNOshIqn1tGk+hu6mMVVVrEvZcH3E
         QqGEgw7xgmcRcg4CGAkPFI4PN7qk8tvvOCU8xI7mHthQP6fBBBt3k15Qy6lKn+sETuhE
         48XElsXsmqI12UYFVZnYgVR15RDkSSCJsCO6ThGBFW69W7G8IV9n7a/OkYDzWr9IzhaN
         yxpgeFOPlwGlhgY6QCochBfXehLUwGvkHkeboObqqok+8IFePCEGAwJMDqFcrSQj2Z+9
         JaenZPofulJDn7ry1tolLf212LTKO5PXmq5WM4itCS5GX/y8suJgzw/O+JVwz3Oredwi
         joMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777058319; x=1777663119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsjhhZdX0yxy3kgINItwDji3KGNUTwxF928253yyINA=;
        b=fQ2+wTtSdr48ccs3yYpIe7YucSAk4IGZgv1PTD5s8tTkyNsFilI1LUtTTNWqnsIC/m
         U6qnM6HJDmgTJBlE+PwIzUaOGsOnW+04PtoodWNqtLQsbBLa2NXGQTMmmvOByB8SmOPF
         B2Vw5DNgCGquOq1XVOtglVdlu68nOAJDhD97isjZaQ3MmgOEZT9en1rFGfPw8cyhXarm
         3vYp+FuPYFQe1ZYAdyAMPdSSdAMxxnmL+uL8vc9jLx6jUpSyXbzeknlbnqvLobUaT3ar
         ogMuxwzrvXRuDR+NSEqbI4iv0FgjbjtQlpb6GGlDYm65f5+q/QyR0eKLCa/aKDHndeas
         PWPw==
X-Forwarded-Encrypted: i=1; AFNElJ96Tz+7qBS1vei/ReDo+iC3S57aZ8GDE7L6J2k81G59mQi8bv5UzNu+D6Ta/M/QlGEL/tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJmNZPZuy4C7lnVKT9OxkjYkRAWkmHa53HCSvGCmZu21k5KZC
	fesW6RyRlayUWnM0WsLPtEYWV52GKk7Qz776YidVg2i+wEUVkYTA4v33
X-Gm-Gg: AeBDiesEtsM3ex3UYeVc873iB+Fr8DVkLIGZZ3SgdBCgpnMG7CYs5YkWqMWAE4rPDfk
	DiHByb29ITaIkVGzTgodW/6I8xXiZZIEbZmvg2KnDQWGl1z5VmqdQpYVxJR0fdP8tcNYaqb0/MQ
	Ii8aYDMcBS+pIuREkNc1FR09Dyjm51EzUkuf7dGqn3FG3uk4GRgza48R7NKRKxqF2bIjTO5aj2W
	HpCjodfniP0m1i37fMhjTznTu4Sv536oV1pkKqcwofu4jVRiqvrigZO8NpKMZwgRdXHrjjs/p93
	Jr19BiATX3Cj2J9J4G5oFWs0DRCuD17EYoF413yc/lNS2RomimKBulOBh2x4/QxA/XIuiKT0BQE
	GuQe1YoBFe2zjwPZEc7/T/PLcDFnydcDHmQZQElkdfmtMl3+VejohUlTOma5sv8YN8Fr8z8AzOl
	6Kab9c57T7SCUYOcNmU6HmUgv1jnItsS8uz16RIzuLACL4pYJVupZwPXr4sAfjqezAsx33UY2by
	UidKesjrkCScvzwxSMn
X-Received: by 2002:a05:7022:383:b0:12b:ebb9:1c18 with SMTP id a92af1059eb24-12c73fa739fmr19364941c88.31.1777058318879;
        Fri, 24 Apr 2026 12:18:38 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12db8684f90sm15312204c88.13.2026.04.24.12.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:18:38 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Xinyu Ma <mmmxny@gmail.com>
Subject: [PATCH bpf] bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()
Date: Fri, 24 Apr 2026 12:16:04 -0700
Message-ID: <20260424191602.1522411-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the scatterlist ring is full or nearly full, bpf_msg_push_data()
enters a copy fallback path and computes copy + len for the page
allocation size. Since len comes from BPF with arg3_type = ARG_ANYTHING
and both are u32, a crafted len can wrap the sum to a small value,
causing an undersized allocation followed by an out-of-bounds memcpy.

 BUG: unable to handle page fault for address: ffffed104089a402
 Oops: Oops: 0000 [#1] SMP KASAN NOPTI
 Call Trace:
  __asan_memcpy (mm/kasan/shadow.c:105)
  bpf_msg_push_data (net/core/filter.c:2852 net/core/filter.c:2788)
  bpf_prog_9ed8b5711920a7d7+0x2e/0x36
  sk_psock_msg_verdict (net/core/skmsg.c:934)
  tcp_bpf_sendmsg (net/ipv4/tcp_bpf.c:421 net/ipv4/tcp_bpf.c:584)
  __sys_sendto (net/socket.c:2206)
  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Add an overflow check before the allocation.

Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Tested-by: Xiang Mei <xmei5@asu.edu>
Tested-by: Xinyu Ma <mmmxny@gmail.com>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index bc96c18df4e0..4f5a00ade2d3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2820,6 +2820,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	if (!space || (space == 1 && start != offset))
 		copy = msg->sg.data[i].length;
 
+	if (unlikely(copy + len < copy))
+		return -EINVAL;
+
 	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
 			   get_order(copy + len));
 	if (unlikely(!page))
-- 
2.43.0

