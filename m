Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E647646AEF2
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754041; cv=none; b=pt/pb3rm67tUj2qOja33z6GRjnTrirWuE8BsMwY4NnijiK1i1GQEPw6e4Gq+F5SynAOFm3AaZiMrezFlB/wer0Xnf6DNGj1XjBI/VqLstmiust1xT21mFWsqxBfILlpSxESj9QcH8EXc1IVcko68eiDT8sk7I8OVGzKEduVOGB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754041; c=relaxed/simple;
	bh=xOeZ3AAryQQpH7b3QXyw0FJI7Icm4ldkT4ekRB6O/us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AGpezoOm5ZPcTLibiVqA3Ark5V0A5EohdZhjM5Yb4Q0ZY9eS71Eg27bb0OxBmUUAK0+YL21/1TaDs9OuItGxf3Moou6YdkWTc71hLClhikDiRZwjvsyGE/N2OTIcJN6RkO/6TU5bYRKWA83dYLHDWG5Em+ojYkBLNi+/v93S518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsCuMxeC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsCuMxeC"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-845537740ddso2078278b3a.0
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782754039; x=1783358839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc1x3dlPbzBDaS3MpDbrXFa1nZO4qwexshU5OtsKQHE=;
        b=lsCuMxeC/1fyqK7YDIKbQL9XHgNLDq0EK0YYoSNy3wo+w1Dt0vlu9ZwsaQbMteAoS7
         0UdENJrlfdpqSGQ7CsrZkxrMX6I89ZtRo6eGZWBh+uA0D9eaCHeVZQgyq1Mnji8F6LGc
         PRQOFk/P5XC4ktd4J1lJvD0UII8OYVLuxJ0iF0Ki4mbaYuazyE9W9eGu/RIcSCmWq0YS
         21a0Qo1ctaQ1LCIAyUxQAdi3+f9auDCn7dcvMJKtCoUGWpud9xKsSP6g02/Np6YC4mzo
         yZKK+A4uai1jIC8td/ENf4Vbs6Cdm/o1pGzziyVjOX0V9nUwgabb5MLYQ2XNoo24e2ey
         oRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754039; x=1783358839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc1x3dlPbzBDaS3MpDbrXFa1nZO4qwexshU5OtsKQHE=;
        b=QP70orCXDHdCu2pwz1G5c+TkQsDehvJ0z7cfAhnrVLFfg+joUiJiv0ZMIMbsfAzIZg
         JkDVZxlGaIzPXJ0fmlq/GM46dkAhIWKCtXBzqSQtYp6xlIKLtqchs82YvhbJ7tfa3mZ2
         pcTp/3PCKrdkMbxgapnN9TEab0pd/1y9NYlskTjs/JY5RF8smjV2vp07IAzOotrM6Stk
         2oqt10sVnVxtgtmfsjyt+EifkrjuPh0x5cjKuIV7JzFoANJFsBkJiK7SIr+53Zw8ABJ5
         KBf13IBWxgzZQKQvPeS1DFCGvhWvcOdTaIpGQrHeyaiifCMNXir5VWuSMzNN3i3Ez9IM
         4RKw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6G2fjaLu/r+rJJFmfWSlFtNs19myxlr1Bsma9SE4DsTZSJECh5HMfJDudkacHv1O5KMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+fYeTdQLX/ed6zCO5l9TIGAZqmG+oJ9ECU35kzhUveGjwiae
	WcZaO+dXIRx3qii+3bhbUwJ3wa2SEyudyCgY/l2Od447jIPZ3E4wLpeE
X-Gm-Gg: AfdE7cl0rQDvV7KBUfcTpIksqse+MbZ6Q1L+fALcU9RZNZGCx2vbBN4UyzrgdJp0ocU
	emBd0GmFxRea3fyhmMPigpykETo9okluuMB11QhKOwElzCiMe5VosJI0tRCpNOvc5KaoZG3kbQW
	AHrFz+jU0jrURw80RcC7IZl4vmDGBGohv1ri5WmRfqWahkjgnTPmGKou4+Ttz23ftS0JN2hcNLQ
	mmpGufvLdtG6+Gpg2luWYAGpUf17UoHxbM6TV26ehnHJrrgPd1N9dFkwzDf3r3Kj2ylbsDC3CEj
	HpFtN6X5yJVAUI6pn1R2pFRxUNcG/hh2Qbgp5Vu5T0gtX5TuXqc/7zaFOtAaO9xlnAiDYEp0kbQ
	nLyUdmE8lKH8d57W1as4/nnoQ2t6qmMKnvhvwHWRehfR2ADb11wz6GrFKaik6mdcubZD3zoNs5/
	xEBVtEx8NfiKefVGLOvz7ILJldZhWjn5o9sPr6VSlYjlsauWQ3FO8=
X-Received: by 2002:a05:6a00:4fd4:b0:845:d274:c01e with SMTP id d2e1a72fcca58-8479f2d17a2mr333793b3a.55.1782754038787;
        Mon, 29 Jun 2026 10:27:18 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a039f2afsm78542b3a.53.2026.06.29.10.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:27:18 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Lorenz Bauer <lmb@isovalent.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] bpf, sockmap: disallow sockmap mutation from tc, xdp and flow_dissector
Date: Mon, 29 Jun 2026 17:26:59 +0000
Message-ID: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tc, xdp or flow_dissector program updating or deleting a sockmap
deadlocks on stab->lock vs sk_callback_lock and has no reason to. Patch 1
disallows it in may_update_sockmap(); patch 2 drops the selftests that
exercised it.

v3:
 - drop the broken selftests (Jiayuan Chen)
 - drop the Fixes tag and target bpf-next (Jiayuan Chen)

v2:
 - https://lore.kernel.org/all/20260620034632.2308-1-rhkrqnwk98@gmail.com/

v1:
 - https://lore.kernel.org/all/20260616091153.2966617-1-rhkrqnwk98@gmail.com/

Sechang Lim (2):
  bpf, sockmap: disallow update and delete from tc, xdp and
    flow_dissector
  selftests/bpf: drop tc/xdp/flow_dissector sockmap mutation tests

 kernel/bpf/verifier.c                         |  4 --
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 13 -----
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 52 -------------------
 .../bpf/progs/freplace_cls_redirect.c         | 34 ------------
 .../selftests/bpf/progs/test_sockmap_update.c | 48 -----------------
 .../bpf/progs/verifier_sockmap_mutate.c       | 10 ++--
 6 files changed, 5 insertions(+), 156 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_update.c

-- 
2.43.0

