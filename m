Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664318;
	b=nzyxijAMp88fCjzQv8OTHnINxyoJv6wB5lAYiFOem/2U19JsTYlVZEu06rmFzthdlV20
	 PeEpUym0qIRLdMsu0TwmuMs/MmfR6fyKSWaC7kqtF5ckOqZ8ywuTGO/pCMQuwqDhpct2p
	 iWNhJc0K3Sfo7mdHhUKUaSvbWR6d3TThNyDxLKzQsdZwLlTBG4yNRHDaj3hC/B3GxucbF
	 javm6x1TiwPHMvlNnKD6uJ6f4ZcT/U38hO8H0uecNyHmXclL35OT857TsErlOVRH+1cVH
	 uUBdgQ/5jMjWf2guGt8+Iqaz1yiagWf/FW19iWrQAOqFxZEk0SBV6SWSYc9daqwL10w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qDM75YKTIdF0pi2YRQIzvneADCHCA5TZ2FNZ6kB6yiM=;
	b=rA9YB7YsE2lOg0IAC0a/FNYiwG68ZBmZWcGtLjFmIliLGe+p+4D7Z5FT88cU3M9Gv+YA
	 kbgCgcgpN2LzomvABb07/N+iezFc4CdKhnjlI9d0/2Xz3MeRwEUqhS8nDaKhL20Z1tCZt
	 ePxbM1A5y78ap9K5Ji4vMwW4cQG0dMzMaGPf6bKwjkRKGNoZu3RTMlaijilcEbK83+BUr
	 DuIfH1qFtrUcCuBHlpw5DOuAon4Oj1439IwsY+MP6w62J2IdZU/EThMnBs0vx5ZNlQBau
	 HL30IGYElcYnRlW8U8stWKRApdHjgZURJTELPAtf/6P90q/WMl+EP93hJ+1TTtpzgSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l/IeU2a/";
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B498606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B498606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/IeU2a/
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso2700457a12.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 19:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795664317; x=1796269117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qDM75YKTIdF0pi2YRQIzvneADCHCA5TZ2FNZ6kB6yiM=;
        b=l/IeU2a/m3hyyRdotnq+CJLcZJBMxpaFSeOXy/Uuv1AMRmDn+OTMYr63Id2gc1lqQy
         ZQPW+Sor1cnduKoaLVK1ZLCBCkQGrcJU5mmplDzY4nj1wZnGZRvabwoZ0IjJsbkFZkOu
         DLPJSivO2oUw+lcbJ3uD6GLaeJE4P3cxd/d8mmhmns37/W6A0RXl0B2L6p04WMqeQFXZ
         mGIS5MigxgDJpENpgRfw/F4rASq6Zq3jRTqvYoEAUmdtUjBphlJIMi6Gu948MoW1Otwu
         gqhgE7ehUYrkracEx1iv7V2a2cPS+8kE33hQGEKxZKBKqFXG/hTOfSUw8LaZLSEL0a7a
         Tdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795664317; x=1796269117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qDM75YKTIdF0pi2YRQIzvneADCHCA5TZ2FNZ6kB6yiM=;
        b=Mo5RhJzh6oOo2dFp6PadtmwlYWRlcXFayUnFbCSINQ/ri/Klg60FI6IK/xUFrjW5zM
         0d2KRHOHNZ8rvuNasptQ9zpHK10jtvdqVJtTI4oIwUbGvx/jipRFecschIuYVySilyGc
         UT5hAZcEZwxOuocCMusD5EOZaSz1gKsqquHRojFCHvp2UEsIxxojZ97LuLQR0LIokcYl
         AkvjoUmSuxldlJxfQNoVXN5ckXTEVsIVUk+k3G47yxRtC8v28qYkD2rpRbzPrBLRtYMR
         OMMtSsxGh63SpbwdUs7A3cND7zbQsCZnGWfz8a9SfoylhX19koTwX0a2XxVlYzaeE0Cm
         SNlA==
X-Gm-Message-State: APuU4Z8/3vSwPz3xOYlyrClHX7yUdm7NsaE1YnSWgvBfooPgiatZgWma
	FYS5xJKKC9hj+hU6uD3TAkiSnrkbvBmYv0oIfaYc27FgtikMA0ZOXwcK3CY1yg==
X-Gm-Gg: AZFdTZcU8fnu4kJDeCXRnJYO0KvYYHdvw2jxWcengPPryNj7FrExDle2ESJuFcxuXT3
	TiT0Fg4ZzXG2ANiC2eRSVWdiC7a48aLprM5nlsAMLWWZWRj3mh/oV6nvl503grn7PIAv9lDly1k
	8++dSgPw2LrfC9PpRQJkhPWimerSenGjAajT0E9LOJEbPWcngdhnQpj/PsRpP606r/9CnN/XQ33
	D8RR4h1+QmEupXDWnko5zydvUSvD2fhSi35XlWbrIFINwY8PPueydXbxg5ymFnDs+nBbsFna+vn
	sDS7+5RCC2osLCC3cyQw5J3E/O/5b/F06OV3lmoA8aJLD58WnL3nJS2GvELvP/EPf1l6KMwvzrS
	sDdBqPopCwS/IS9B953f2sRuD933jCIVcJ4MJr6f9QxWAdFHyA1rm0vH5KaHHZmVr1uwVHWNZ6b
	3AwOrKQx+DYo57PCuQYUfD2NuIitsIj8mxaoW4b2xmHwKm3Ma0nH6Vzd7ZPVEkSWH+jAuqWpNv4
	ZlsXuvLx3IqRBJBgF+Axx4bjUrLotAIr4t+qO6BBpBqFEDRBTLbwepzKeBrHWTag0nYGUh+j/z8
	PpdrRoyo7e091uRLfYSrrNFnRRB9SrnMKuYEwrBwK9N/kgJx0tIM24U8p9yDRq4QQYvO9DXqQUP
	h+al5a0fEXytaCiweLPK/b8YSfzxYhGagiCfupK5C31JViAaN8zacdVDHPFffHYZd5MEzKllRJ2
	0=
X-Received: by 2002:a17:90b:3d92:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3b41c9b2de6mr17153735a91.64.1795664317483;
        Wed, 25 Nov 2026 19:38:37 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcafe0sm32654989a91.16.2026.11.25.19.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:38:37 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luis.gerhorst@fau.de
Subject: [PATCH bpf v2 3/4] bpf: Use get_unaligned() in bpf_map_direct_read()
Date: Thu, 26 Nov 2026 03:38:15 +0000
Message-ID: <20261126033816.4124847-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126033816.4124847-1-alexei.starovoitov@gmail.com>
References: <20261126033816.4124847-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

const_reg_xfer() calls bpf_map_direct_read() before the main pass checks
the alignment of the load. So the offset is not always a multiple of the
size.

Fixes: f1606dd0ac49 ("bpf: Add bpf_compute_const_regs() and bpf_prune_dead_branches() passes")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5929478787d3..36441ed9f0ea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -32,6 +32,7 @@
 #include <linux/cpumask.h>
 #include <linux/cnum.h>
 #include <linux/gcd.h>
+#include <linux/unaligned.h>
 #include <linux/bpf_mem_alloc.h>
 #include <net/xdp.h>
 #include <linux/trace_events.h>
@@ -6386,13 +6387,13 @@ int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 		*val = is_ldsx ? (s64)*(s8 *)ptr : (u64)*(u8 *)ptr;
 		break;
 	case sizeof(u16):
-		*val = is_ldsx ? (s64)*(s16 *)ptr : (u64)*(u16 *)ptr;
+		*val = is_ldsx ? (s64)get_unaligned((s16 *)ptr) : (u64)get_unaligned((u16 *)ptr);
 		break;
 	case sizeof(u32):
-		*val = is_ldsx ? (s64)*(s32 *)ptr : (u64)*(u32 *)ptr;
+		*val = is_ldsx ? (s64)get_unaligned((s32 *)ptr) : (u64)get_unaligned((u32 *)ptr);
 		break;
 	case sizeof(u64):
-		*val = *(u64 *)ptr;
+		*val = get_unaligned((u64 *)ptr);
 		break;
 	default:
 		return -EINVAL;
-- 
2.55.0

