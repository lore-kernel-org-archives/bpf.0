Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E03A75A6
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079176; cv=none; b=PfRiI/iGcPjyxlpWEBzf5LMJ9hBgETGYjrtGE/kB1hMZRtpO9iIdx6OR13FaB9jWcBsWtCWWKIOHBoCWeAtUzUkRzkN4Kzj2ID2nyitmYeZhAM0WCvD/vDH4viAYd1fBfRBWRaBWTFa57RCodQWewXqP4IZHKF9/Ia0DMfpkreI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079176; c=relaxed/simple;
	bh=S+x69YITbLsuF4gVxjJS4UgkTpaYc+6Eg485Y1Iqkk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdjnFZHtP+92yUvH/LDngj7JFxHC6puvcNr+kvuNJ7+5RH8IxmsE/YrGanhQibYVdmkL2LdubXwmJQsEnZ9fS0KcXP9zF4xOx7NCS3sxKzvK+3YUbJRwEZs8i1lB6iIVeO9C82kpq5RSjlB0gY3JMiyTI3kT2rOaSJGz2uhDVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sLnfHf+n; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLnfHf+n"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso4529717a91.0
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079174; x=1781683974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIUSMLxfpzLCylhoWJxQMNLsTqrlPijUzWqPL+Fw5Mg=;
        b=sLnfHf+nJSm/B29AV4fPqP4QJmrgEFdH3RVz+RxI+c1XuCVxGXSWqBWCkMbuQqOkCK
         6jgHDUUkyl02a1ZcXqDFfuQQS93y1DQ+7/e4j1+2jIE2gzT679Y3JCBM6FDwZQQEiQdt
         UXgTtj225cuL410JSEC4S+QpVZr1y/OypHWNIh8oLFQiDZtuEQr2mKr9x7z90XZmPCWd
         sicylnOb0t4fB+M7mOqCqCszSvDINSXuUOF2xWHW11EbZzECGisLFIUYXTZcMt9CYVJ+
         mmlErGGc+o5wll4Sm8OBmAmppuwtVlgzzVyncpIVBZU/CtYzy/SzI/d9W20S/swYlfn4
         VbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079174; x=1781683974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KIUSMLxfpzLCylhoWJxQMNLsTqrlPijUzWqPL+Fw5Mg=;
        b=r8BMOPShcpKkg6BibfPwW28SmuBo9R0HnfUf3of5A09gzTF5HvGlq5y62tjFpcPwO+
         mST36knnziw3YS0MeUYDcGXZe1gQN0NI1eD3pRkIVFggbiTInf/Yi7j1aIS1MNXaa5DN
         niOJe41/Xsk13Q7tzfATeEMrIykEz+H8zP9N8IGHl4Hs1QUQ/0R0lb7q2ZF9hE6tbOG9
         v9iwfsBRWNxnfj//mq9ZGWW/20x4u4JYMqZt+k7K9+qX50mjyuRklDoqFncG50cc7ofS
         J5EkJZq+ksglVETOF3dXLnGuQ0+c8lGtnWqTvx/4zuLxUpp1DSD7IVCE7M1vne7rT2cZ
         0TSA==
X-Forwarded-Encrypted: i=1; AFNElJ+pToJjJy7aaoMePDpmbUgPB/9SC+9ERs1CrH5QhRzfnDPBDvUWGjFlRPVxSG5xfSjwVlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQfRdyhFJXcdNlUwPiNgP7Z0VCgAeQrI9332avuhuELk0ND9f6
	VcscgpWQnp6yPhXTVQnLMzlVR071Vi4tEzK31IMRxaPJ2DMQCZJOBIEo
X-Gm-Gg: Acq92OFtUaK2kjDOESl6i41lsrVnwjhID9hE0v0VVtdh4lunhmf8GP6rHmY21sfricc
	Qc8eUrgFF8h39X0wQjtdEEZ465/ZY5v+ckulJqXUtBaYT/VvaE/emd6H4lHvfCPTgGCqTTAcAZC
	amDVGM0I8meaLSmc7jOhxUgKKxZqXLDBLfVGQva8v7Gz6PEXTsmqFdhWg6rjddB4n0llnLbSZfK
	x89GFDNjHzMQ1DwQnWtMo9jaVq4JL1cxlL6sjviN7P1dexIN5U+Km61Z0Ylij0bZq3qQJlpQxUB
	i4/reh1g1tz16OmrJyYkNlAc4OBKOqydFgI/vhqE8Ak/Dqwkhh8QIaURrEi2eLpMQdIW/3G7Txe
	2ZrHRm31Q0vclI4U95OguWx0/83Kl50TiNjNcLu2lOv12Uv8A5t/IQzi2adMx2Y7m+bmYnkGnL5
	VJuWlfEPSNimqtpXi+byB1GFt/CHwC/kNXsxxMLASXdt5EJVdzvtcux1F03YrLMbC8r3H1PYV9c
	UqDJnb+z9I=
X-Received: by 2002:a17:90b:4c85:b0:36d:f28a:c5ee with SMTP id 98e67ed59e1d1-370f0f459eamr25027703a91.25.1781079174299;
        Wed, 10 Jun 2026 01:12:54 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37645c1aeb5sm1241003a91.2.2026.06.10.01.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:12:53 -0700 (PDT)
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
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <cwang@multikernel.io>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
Date: Wed, 10 Jun 2026 08:11:53 +0000
Message-ID: <20260610081218.506709-2-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610081218.506709-1-rhkrqnwk98@gmail.com>
References: <20260610081218.506709-1-rhkrqnwk98@gmail.com>
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

Widen the addition with a (u64) cast so the bound is evaluated in
64-bit and a len near U32_MAX no longer wraps below msg->sg.size.

While here, change pop from int to u32. It counts bytes against the
unsigned scatterlist lengths and can never be negative, so the signed
type only invites sign-confusion in the pop loop.

Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 80439767e0ee..9cdfec2ca11e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2974,8 +2974,8 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	   u32, len, u64, flags)
 {
 	u32 i = 0, l = 0, space, offset = 0;
-	u64 last = start + len;
-	int pop;
+	u64 last = (u64)start + len;
+	u32 pop;
 
 	if (unlikely(flags))
 		return -EINVAL;
-- 
2.43.0

