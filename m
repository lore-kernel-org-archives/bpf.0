Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4330E279DC3
	for <bpf@vger.kernel.org>; Sun,  5 Jul 2026 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783222105; cv=none; b=EWS6QKhfYr87FD2zAvdwYTcLgPPSOwcoaeZX7ylKOXf/xURcgpwfucCjuUsrWKF/XV2QlKc0TyWdXQqK4jY5VhsZ8nI9zregVwoPjYVkEjzUI1z97a1T49hCSsH9OdqaZzekxAuOYyko/2+TUYXSmqwDjM4PTNMbk8NR1wOPRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783222105; c=relaxed/simple;
	bh=Kh85sAaHY/3z568PAyFYsCupQEvAYXv7YtoMdQVufhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8ERitvAIig+BWvRcpzt2Ic3ntTApV/e+s4NDivddJ7QDxtyku/TkjVp9RmxvTYhsIMi844SWYm850D1BBIqIryfDQ7kRj3VIU5Z0YHpoJjN+Z7ABY84hb+j4EtBUm+bffz7BXTabBs+ncBqeOAocQDJj7wGuOJ4cEhM0KsM06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC0uEmRz; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC0uEmRz"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37defb2f231so1155321a91.2
        for <bpf@vger.kernel.org>; Sat, 04 Jul 2026 20:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783222103; x=1783826903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aGAVpUfQaFulsMJsmJqhLyXxHcYUPLV3O7aQk0UJwdw=;
        b=DC0uEmRzV0dmRYfobuuLqEYmm9YNsLFeBCXaYipxNp25ndlvcmyOMoIj58HzjqLJmY
         EHs2WpU8yzOHhT8xd5yAC1lqkETQWRhDCl0160jST1ypaTfPEaISXAKAh9NslsYRAyRQ
         FtOpGX6+0cWatOt1tqQoRNbQUHHWS2fIHKtWdEWmReWLniiLaFcs70+/bfWhZ37QpUY1
         0HaX5tF/oQYYJviRsxvkCpQbOSgz1ZRcON0bRWc6+vCUDwTgT78wQKXmhjcEo82i5/SP
         YIRN+8O8p+y14aQy8Z5DS1kcWEnsTzDimUmrusClOH6dRdZ47lp9ZRRsl/qS5tESWGeY
         smjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783222103; x=1783826903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGAVpUfQaFulsMJsmJqhLyXxHcYUPLV3O7aQk0UJwdw=;
        b=ZCYcjLemSGRAqOPZvqQkmeTjtLYzofYWuerGBmcm0UWlFXu0laL9IOq8FeGI/NtUfV
         D1VSU8/hpk1mG6kjZqBSRvfUMaDf7d1k8z4fqFZh+bzQJ34pCitK6bOp0iPNKofM6OTa
         1+eDmEFS3nio3AX1twbpch1iovmqdBT8jWmp59wd2kwr3QnsKE6Uhdy+SewdZAlXt7wH
         w595J3Ve0LpAdWXNqwByACcyvhmqcfaAYPDI0NzJK/vi9R7RxWD/B1kQ/kpz+gtj1xDI
         Jcdx8PuKCPinjM0C6PrI6F8HzNO1jT1+e4UHzgINjw8A61nM6SmClZ6lRPU5TFkly2WR
         AP+A==
X-Forwarded-Encrypted: i=1; AHgh+RqA5UdOe8hW5bhH9l4Uyr7Xpu3mYBIeJhUsvcjH0zMF5HUyc6gCglSywElCNRSQwJmSinw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4qflfOZWfCkYUzzAwWGPJVr00b45JBGgWy9DpWsKac6whqBgK
	25B4wurh0+zaYQf9+I6V1med8LMgsrGOswApLw/AaPNQHdFwUHL0A9f3
X-Gm-Gg: AfdE7ckyMPH6oPiuRAUi0mnSrtshzA12KtLMoVG/heij84q+blzrGWDu96yQW7RWILb
	9Gde29qFlH1Hkvg3YAUmMsqJOgOMeL4t4DuSS/6+X1WtTNVg6wOBABLlVP+6Rvp3IY/mNws/qkb
	dsQqGDv201yr4Y6k8bpqvvB73BnhkvGOkx/Jqg/kXtNL3oMPgWtLtg/GLs3ZafhovHR+rD+HPCQ
	u4i0e4bWqVLOA88qLugQrjFesdvSrtWUDS5X5q24VgL4f0CbjyUry5FOP3Ek+t/bPaq5D5Cyu+F
	afVkx9XYN0wjOcLXqY1/aJ8B4jOvBNv2A6YFWCOYUNkSDWkJqOyoQpzE1Eg809QVsN9hm0/Rjn2
	BFvyjnecUZS6YL+LsrRAxE8kPrkK/lpwDWPDFNzP9tf8MH+WHIOo/pgvIy7mtTl1C/sTq+2w=
X-Received: by 2002:a17:90b:4d88:b0:37f:d9dc:557 with SMTP id 98e67ed59e1d1-3829d70cc3bmr4850298a91.16.1783222103587;
        Sat, 04 Jul 2026 20:28:23 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127ae6e2bsm3031767a91.2.2026.07.04.20.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 20:28:23 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] libbpf: Check full backing type size for bitfield dump
Date: Sun,  5 Jul 2026 11:26:03 +0800
Message-ID: <20260705032603.275766-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_dump_get_bitfield_value() builds a bitfield value by reading bytes
from the backing integer type. The bounds check added for short data
buffers uses the number of bytes covered by the bitfield itself, but the
read loop consumes the full backing type width.

For narrow bitfields this can leave part of the backing type unchecked.
For example, a one-bit field backed by a four-byte integer only requires
one byte according to the bitfield span calculation, while the value
construction still reads four bytes.

Check the backing type size instead, so the bounds check matches the
actual read range.

Fixes: 5714ca8cba5e ("libbpf: Fix OOB read in btf_dump_get_bitfield_value")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index cc1ba65bb6c5..a49790e356a8 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1771,7 +1771,7 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
 	nr_bytes = (start_bit + bit_sz + 7) / 8;
 
 	/* Bound check */
-	if (data + nr_bytes > d->typed_dump->data_end)
+	if (data + t->size > d->typed_dump->data_end)
 		return -E2BIG;
 
 	/* Maximum supported bitfield size is 64 bits */
-- 
2.43.0

