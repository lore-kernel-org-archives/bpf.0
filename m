Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57D341AAE
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772743068; cv=none; b=ijiaqxOQ64CZ1/OEaYK3P8CgqliGyVKNg8LuulWOmEmNljVl5oWZwHu9KGX2yG+5C6KOWmttSM6tZmc7YK+sAqvl/D1sINjRs5j/uU2l1gGADFIVq+nQSZYQK/Xz8b1I4rJHUafImCW+CIot4ukQACmFvkoD/ILpcjUufnJiSCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772743068; c=relaxed/simple;
	bh=/IwkILeodrC7NqQRZGEPw4de+F6+xh13MTvPYfB4lc4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sdG5Jwa5ofTbGeIlKyASiJqVnvMDrsL5NsV8UG6HcldGzQ5OmMTEvYoSm45tFHoaEn09r+tf0n+5/bGJZ3wVx2qTohA8nxigJiMpZeoYvWo3hJogORFxq/22uFAcbhEkYRtV2Sb6zbQeky7uws7gV8YWdEsF7sJ8aan4cZ3wB5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pw4LhyZ7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pw4LhyZ7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806bf39419so70024335e9.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 12:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772743065; x=1773347865; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DLvaD3bMLmlM8cbx20j2adun/7v1LedrEMbUl53cJ0=;
        b=Pw4LhyZ7b+6dYkOLrNzD849/78TJTcIepsj7NTaKsFFi7SVD/eDemmCztTHsFmbZDZ
         /2hMcqsgUnyv/ypxC5Jg5Be6n1eU8eYJkncLM+M/r2eh4OTFfiqGaZrnyMFuJLfKd8kK
         Pdi/3+WC5Ehw/aSwvL06NAhHy30BygSuMzjB+25mlVoo8jeGtb9ZveH55eFu/BB7Md/X
         q6RBx1hISW5Z7MqEnWO0+t6fO/bX+b5ycDkOnOwntc3VvGfCgJpmoUmvyhp2eYleXVwV
         x/WIJkyuXQmBWEtS70DLF/DauhXbkxzaEJ/EVB2fy4inu1jvp5ZGLh5pLP18oN/ZYr7u
         NI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772743065; x=1773347865;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DLvaD3bMLmlM8cbx20j2adun/7v1LedrEMbUl53cJ0=;
        b=oWRXfSoWlSlh4bHiypGAbaeTwvc3On00jSfvZF1UNqoJ7si58+TpLWYUqpeOWRWpzG
         qfuc6+9ZPyGoLMk+ZRh/lPtPkOFgaf935yeTUcjB6Az/P/A6WjL+Im/ZGDwqvLFwwniW
         U5MNx31uFUQ8iFQgDHYGxYWwZtfecUdip4apDevXVrn0yzFDoKR1wjlXI9c/wz+PCEWT
         0x1ASvWuXLg6TukXpBmjDdLv3gsfcPZEIFasyFjGYXcsNPpoURHoD/3rdrIn2pfD5SD7
         JoTxpbGl9lUcYm+zcdlakcukGrn2ixfDzTrCejFe3rEX8koa7FbxULxXyVj1i4l69EJD
         Bb/g==
X-Forwarded-Encrypted: i=1; AJvYcCVB66nzi8mQOz8l90sCQ4aCkotkyumqygDXpBE1MYiAOemSd8z20/oisF6GVlZ+iWloeOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy53RWQ5W5ezsjKzKzfrDPvh2Z1I7/WailzdMJfYTnmZN+FpIxK
	C3+gj4TNmMCTNqbCGmlKUoNIob/VoFybP1S2CAF5tLHPg/oK7chjGptFv5jQErWPPWM=
X-Gm-Gg: ATEYQzz8EwpppDJgeY+9/7soUkfclMxCU0Dyyl8BTVj+/8KSNLzvrE00L4vk0LRF2nr
	efVg7ckg92FkwXH23M0EC5z7mUdccHvE7s7RB/rZ5d7GUStmE+dWwSYvDC8uR9RXYifRfbzuMue
	uTxAUOub/8X8gSElyNrMfsepgYsjYy4RAY2VF8HlTYRHSDCzqUVq2Z3p/JmU6Z35mYT+VGViz/I
	Z371Vu9TnWt4caIeECqwVck9LgRFxljPyHoalV63Tcnaqp24SXWeoyfNNw5eutzUyplkcPmiw5/
	8wsIq9F7G2CB4ZNyyYU4wAbR2I3R0m/ziQ3llA34GyqCQ6IQPhFnJ+05v6Dh9ZJmCCWc/KvLUsq
	pLwfjMPHsqWKy0kL0wWH1FJ/yZQ8E2R08IjypAngvgk0NN6SLMCyOHENX1MNyq6sKWItUNbNBQ3
	Zbz03S5q05Ehr5C+mlqEPb
X-Received: by 2002:a05:600c:c0c2:b0:477:a53c:8ca1 with SMTP id 5b1f17b1804b1-4851eea2243mr63708215e9.14.1772743065569;
        Thu, 05 Mar 2026 12:37:45 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df63d6695sm22209647241.1.2026.03.05.12.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:37:44 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH net v2 0/3] {net,bpf}: nd_tbl fixes for when ipv6.disable=1
Date: Thu, 05 Mar 2026 17:37:38 -0300
Message-Id: <20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJLpqWkC/3WO3Q6CMAyFX4X02urWGEWvfA9DyDaKLJFhViQaw
 rtbuPfy/Hw9nUE4Rxa4FjNknqLEIamgXQGhc+nBGBvVQIZOhqjExCOmph79s27jhwUDlzY4y8a
 3BIq9Mm+BUnfQNlRqeieMPrsUuvWa2ofexbT2uyjjkL/bB5PdqP9jk0WD5MnR+di0F+9v8hbeh
 6GHalmWHzNHunnPAAAA
X-Change-ID: 20260228-net-nd_tbl_fixes-ce81ca1e0bf2
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1772743062; l=786;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=/IwkILeodrC7NqQRZGEPw4de+F6+xh13MTvPYfB4lc4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QC1kJhNcsubZdQMCXSAkTlfiuEIhWDdOuspkzh75jnCLWRWp9DC6ZFiGNyqhldy7B5M2aEPrMuS
 XAiBCfdnedgw=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
Changes in v2:
- Used ipv6_mod_enabled() helper, guarded by unlikely().
- Link to v1: https://lore.kernel.org/r/20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com

---
Ricardo B. Marlière (3):
      bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is disabled
      bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is disabled
      net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled

 drivers/net/bonding/bond_main.c | 3 +++
 net/core/filter.c               | 7 +++++++
 2 files changed, 10 insertions(+)
---
base-commit: b824c3e16c1904bf80df489e293d1e3cbf98896d
change-id: 20260228-net-nd_tbl_fixes-ce81ca1e0bf2

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>

