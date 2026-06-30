Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABBC43CEF5
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831266; cv=none; b=cwMH19yM+LkVygCMvbHsA54ffuKCX6cq+VySWhMiLAPODHAJjvzmVxXYbB9aI5aIgjPBBmLDr6iqYLXCJbH+40stfvBiFWti7NCgPH6Ew8tDw6hV3fhfZKIyGSSaNDGDmEEaAD3goDWUkd06zPqfGd8jaGOSvqM/vCgAAGE80NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831266; c=relaxed/simple;
	bh=mvMluMulz8TsazPI0k8zL2aMZtsqN5Gi7GN9fqtNkKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DrIomC7hnagJxNa28ffwFT9kMVAuIfuv4gSiQ4YW0Z54miJfXkCfpa4kZ+T5xWCE2FwOx6yNHqISSAi23hEB3K7XNc/XhLZAlTNTziodmkNvgB4iE873DnxNZzrIeJnyfg/2u2xFEetFAEPX2QW/mhQP70Wdbfq30oGlGDN3z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo5H2nrT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo5H2nrT"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37d46e0d246so2134822a91.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782831264; x=1783436064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=px0Wcp6VhD6xZWRvmlTtSAYT6tdeg+tqH+zTVPz9ZEg=;
        b=Zo5H2nrTXqjMYGMdJPP50uZUExrQFXD75XRkt7ocVE6oac4J4tN2zkkf9h8s5ty3oK
         xcKO3yH5g6VpqT92aZgPdQ81KxtbW4Mc86s9h75HzFqRZkmIgX7HZLdyqWf9kaDI+QRy
         kslQlRdZIQY3AKaPbViHeYasYakmEJEpXzy+LAFPMXfLVgDphgMbu53cncAWEbPLiV6p
         3zBglHAqZA9vq2XSUBos1c+YGOixmSDBe6USxnDxmsq99x4wOSbjTrCXvBdMxnUF4zyg
         B8W8uXwQN+YJoMIW65UdV8fZQ39SMHU16WOSJW8apPnUwg1YxFLg0ePJLOOZBYNjUsMp
         CzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782831264; x=1783436064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=px0Wcp6VhD6xZWRvmlTtSAYT6tdeg+tqH+zTVPz9ZEg=;
        b=b7PqOwJedO1c50lV0akvobQuV/YkPPSpf9XRHiqcubaR+qbQ4fZeLK67JT0yeY0z93
         kxO+cckHkKw6LwtIBHnJw7hWAmf5uaEryZUC7EF27/59OYtVEe9TsJK27Ek9EV+2iaxu
         hZEBDL119kJUjnpccqXwfNbM5WDo7LSZBWO1x0lRaNZnNwKioK4H+K1f1uVpY3UqlkQZ
         atPs0dKRsVrElO4wdf0ptcnXeE1iJVoM8OMUSsgT0Ft/M86WqZgNJcsH+nR2Oa6EMguZ
         1CVAkcSCaK+LFmJGLCPv/yK44oHvHfL4XdOsUvArYPLjnDu2tETyWDsosEnhdqxcrT6h
         VR1w==
X-Forwarded-Encrypted: i=1; AHgh+Ro7no8OYJvxKOHhUbzXGrM1baNXpKX4D/if9YHeWgH7v6QiM0700AJscslWiagrxRP9KP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8X4TVTi8tsFh6jbzMbytrB7k0ZoLhWQVWSLteg/k8RIk3hD8v
	iJIwMiJDuprS7YvzwxPpuT0yQNx7OQ5OFef6KuBSBxvygRlZvDquC9jSjlHug5vV
X-Gm-Gg: AfdE7cmK1ghOMLaTwjpXcH51lLF74POaYWmkpYqPzf02eJeKX2gcRHDJ+yKGQS7Qaj3
	SQhH3601LRVnemu0dCb3Iu6VjFMYvMTpWa/2RpGLRtGuJw5RbpVQbjDjfWyu0Hb+h4Bxo4OIiAK
	2pk6ISrJW5CXZIcCK17WhHDLIyoXSnzNI9WdWaxcTb4htULd69cve/Loc2NpS0KMLRk6XIb+xJu
	sol/WG4qyNMKZK4v60NWAxu5TsyLaqCxvGtnJBDB3lEHwqOB3581zwcR7qkODMItz7cdwf0dvZi
	4NNvNjfzMIOPfnz24enYy0nEcDmlY/6CGdotILN2/M3byVq0tSDLdARAnCqZmcaUejqMAepIKT7
	2RVs+KUbf68izIyBb0A6DqjPnjcvTy3wYtYdf8juNQEwYkl3MBfc2HmTum7WRC+sqSPhzhWUU1M
	ZpOK61JGxaHEPX8d47EUG0mSr8FlYx6wiGq8pPJUwHfNFt3Hjqtt8iK3jcquajyA==
X-Received: by 2002:a17:90b:3c08:b0:368:78da:803 with SMTP id 98e67ed59e1d1-38052583a4emr2912925a91.12.1782831264127;
        Tue, 30 Jun 2026 07:54:24 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095b684basm20122a91.1.2026.06.30.07.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:54:23 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/2] bpf, sockmap: disallow sockmap mutation from tc, xdp, socket_filter and flow_dissector
Date: Tue, 30 Jun 2026 14:54:04 +0000
Message-ID: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tc, xdp, socket_filter or flow_dissector program updating or deleting
a sockmap deadlocks on stab->lock vs sk_callback_lock and has no reason
to. Patch 1 disallows it in may_update_sockmap(); patch 2 drops the
selftests that exercised it.

v4:
 - also drop BPF_PROG_TYPE_SOCKET_FILTER (John Fastabend)

v3:
 - https://lore.kernel.org/all/20260629172704.1302218-1-rhkrqnwk98@gmail.com/

v2:
 - https://lore.kernel.org/all/20260620034632.2308-1-rhkrqnwk98@gmail.com/

v1:
 - https://lore.kernel.org/all/20260616091153.2966617-1-rhkrqnwk98@gmail.com/

Sechang Lim (2):
  bpf, sockmap: disallow update and delete from tc, xdp, socket_filter
    and flow_dissector
  selftests/bpf: drop tc/xdp/flow_dissector/socket_filter sockmap
    mutation tests

 kernel/bpf/verifier.c                         |  5 --
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 13 -----
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 52 -------------------
 .../bpf/progs/freplace_cls_redirect.c         | 34 ------------
 .../selftests/bpf/progs/test_sockmap_update.c | 48 -----------------
 .../bpf/progs/verifier_sockmap_mutate.c       | 12 ++---
 6 files changed, 6 insertions(+), 158 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_update.c

-- 
2.43.0

