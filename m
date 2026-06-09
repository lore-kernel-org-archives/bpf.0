Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F7481668
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030383; cv=none; b=QKunFdmY+iXX/j6bHTJRX4GMjOyhHwCFEXvHD01KK6J1GuamxRsaNFF9romX+ULe1JcWrxsiuXO69IYqtjZ8nhOSHPbHsJxZK7SB6Rm5howyUmH0nmG7DmlDYg0B5q6z5llQwBmkcrlTQUJMSGVIkz7Inea0YQwWy48yySMwdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030383; c=relaxed/simple;
	bh=T35csNRp44bHur/yLsWKZYVmWYj1MSMEmQcrTkBCMFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7I7CmXCyVeDswOmcb/65wZBcF8HGbehjPHnL532TZGbzJGGnA93z16q96XPblrA0ffVNeIM0w8ZR6ql0q8OjFp7CXF8aLv59A040B9njJid4YlNBfoZTewcHzWbmilR9kMsrCB7OnvXzz5TTzBHHpKHMPTgUge7nY4uThqei6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfNDjV5J; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfNDjV5J"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36b8d414666so3374014a91.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781030381; x=1781635181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kgBJaGA+2PRCOgDDMrQ8yVdOjKxw4/VzWOqWrrWZF+g=;
        b=gfNDjV5JXZviWYwxsEV54l/jbQECYy5PAWTgR7JsSxxwGIdrt43h4MJjAX3xoVP1KY
         +OMI776kL5zrbd1NDxoJCYTVvUvBYFdJ1d/ahYlyQKBi1aYDkBSLvVs09S6cpybUaD42
         8LtuBhfvTygtxk4ToigBa9gcuCQmpbjxWzKu31vHcTV1SPCkKjSAn+byO1GBmOw8EEih
         XB4IrWANiq/sRR7WSXacgW7NrlqvzXzwVU2HwzoHOPloRTjUdx38IkR+caaGqNaj+TFi
         O6P90SmfOJOaLeP25EZS5Q48yO3BLlHyTrSRuEMHqbfvC3pgR7oTrTLezQmLwRxrg4t2
         01mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781030381; x=1781635181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgBJaGA+2PRCOgDDMrQ8yVdOjKxw4/VzWOqWrrWZF+g=;
        b=WjyrMO6QTrJTiQuBqeA4KW3+YGW4ket2A1LNHQdc0+ci492MYZySy/R3pbnyAFe3hv
         AACXmkvxjA9XIKA3Xqn5RxY0Mcx0IahkUTrtKs11b7ZOCdqvHwh0cpL9f776xPmRUj7X
         5pE4wxj7c7wor3vxPcWMUkPNsxzNq93OFmQVViLc73VZ8W3UGQ02qD0Nk5FlFD/aK6Aq
         f9/DyqMJflxXvBOEAOZZt5lqzelgjJcnTqGECMWfyojW4ix4n7OHQUop+UNyC0+V4lCJ
         X/ZHAZZ5osLwdk4BFFur4dVHiB/1/gDC+isPv7dhURJ+GdbSOeIKNx3tcwNt14KkDdvT
         mizA==
X-Forwarded-Encrypted: i=1; AFNElJ+Gy1m0x3pNffI+i77oW3J1kNJTdhuP6l50DGrPcC3q3E68BDBUjkUc8nEsOrKCGBDheg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9MV3gwEZjqni2jUXf08m3YmuMiUkj3juiYDQxlXNPwk71lZa
	YViZxuIdfq5yMGaisKa6xw4iUi/iRtRVSA/2vlvzuKYawM752a2pTu6z
X-Gm-Gg: Acq92OEbwCYi33Za3PJXTeBUwVh609NuAiLrR7IUqt6yi7ASLG+RpWMPKOqzVoeOtyv
	ynW5YU9oAa42wi7h6m5JkuecAEFVmoSjHRorr90hDbJvKzDldQIr2RMUUQ0wv+1ExqSnRrSmu5O
	uv9GJWhQ9uPiN598L9oPk0YzFnVGa5FgPrqo4LzeHfO94B8Xjt5k/VAawPwKSmqXGf0bb4ZunTx
	3YPygcbDrqY1B6Jeh3C/XCMgHk3HOXW7l+n0a9TXqOAijsLVmZzTgvayfiYdo1FZCp6KFzhfSdE
	8dwiTzX4gCs774OPX9UigQaT19AgFCgAo3aa3op0XdZlJP3Ggv6Thu6ihfiJ9UWQbCIH5M8SUa/
	7ICADCDnB+EsKsoEAPrg/rMzi0v7K6KskAGb2aVFSybIIs+NioI/JCUrMCpt4LqeJuqmV3Z8fGL
	88ZiEVefi/5URs28nssIpwyW1ex+LtqDpwvb2S+UWQ8kfI0+FZa/4J3+ysKT0tUDr5iKmTe3hq3
	Bn/SwSmI9Y=
X-Received: by 2002:a17:90b:570d:b0:36a:f612:e695 with SMTP id 98e67ed59e1d1-375211ae4c4mr4508510a91.17.1781030381081;
        Tue, 09 Jun 2026 11:39:41 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f70a28c0esm20486626a91.12.2026.06.09.11.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:39:40 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Zijian Zhang <zijianzhang@bytedance.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
Date: Tue,  9 Jun 2026 18:39:26 +0000
Message-ID: <20260609183927.4021802-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

start and len are u32, so

	u64 last = start + len;

evaluates start + len in 32-bit and wraps before storing it in last.
The bounds check

	if (start >= offset + l || last > msg->sg.size)
		return -EINVAL;

can then be passed with an out-of-range start/len, after which the pop
loop runs off the end of the scatterlist and sk_msg_shift_left() calls
put_page() on the empty msg->sg.end slot:

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:sk_msg_shift_left net/core/filter.c:2957 [inline]
  RIP: 0010:____bpf_msg_pop_data net/core/filter.c:3103 [inline]
  RIP: 0010:bpf_msg_pop_data+0x753/0x1a10 net/core/filter.c:2984
  Call Trace:
   <TASK>
   bpf_prog_4cc92c278f4d5d56+0x1b1/0x1e8
   bpf_prog_run_pin_on_cpu+0x107/0x320 include/linux/filter.h:746
   sk_psock_msg_verdict+0x357/0x7f0 net/core/skmsg.c:934
   tcp_bpf_send_verdict net/ipv4/tcp_bpf.c:420 [inline]
   tcp_bpf_sendmsg+0x766/0x1ae0 net/ipv4/tcp_bpf.c:583
   __sock_sendmsg+0x153/0x1c0 net/socket.c:802
   __sys_sendto+0x326/0x430 net/socket.c:2265
   __x64_sys_sendto+0xe3/0x100 net/socket.c:2268
   do_syscall_64+0x14c/0x480
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 80439767e0ee..d6d2fc589218 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2974,7 +2974,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	   u32, len, u64, flags)
 {
 	u32 i = 0, l = 0, space, offset = 0;
-	u64 last = start + len;
+	u64 last = (u64)start + len;
 	int pop;
 
 	if (unlikely(flags))
-- 
2.43.0

