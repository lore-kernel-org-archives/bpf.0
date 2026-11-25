Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579722;
	b=q9mWyQOg8qnbJS+4nKHDRMnIiKYYHAqp32dht1TnUKgLMBuhu0NvqLzzh33W+m7RqlCo
	 Svh8MPrHsxanfKJxlY76dtah4JMaafw8pKwQ9kBzpzlWw5pPOPreaFP3xug5dYYJmeoPm
	 30AvVXfd6Pgvf7q3KftVa/JPBwunfuTFqihQ1PSRBDW5JlyLkY6WEddf1CiLCTHnPa/a4
	 uyvzHMsoL+z8B1vitGdp2aZlyD1MEbBppa+jWqUeLV0++J2sYaK8p3M6qbUxcaVL1rUrt
	 Q/crkSl+A9FKEasiuoDoCGEc6sI7H4b3TbQ8u6tPfeKH4dKDxoxF/pXdyedWT4CD9Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F0LNuxPQ85dXvh9CQor/dnn7IAr6otMWl78EFfasX0Q=;
	b=Qtm/ov8fATLlFdmJdyKQjTf5sYstWPlM1L5BRPfh/dt5B+kXy6OyeQWHAEOu4wRZHbON
	 vP77YXN5ql2+VGt/8tSRp8pGDAK39pMb4LmFswYiKvvbgOPbI7RDXeRhq4dohPkShulnC
	 0EwqNyL6jxUEBreXecx46r7smO41uaBMcUWkKNGsFoUIHvRTh7PfcsGCCdinNmXXE8l4i
	 0Fw6Xzj+jvJaWGWQH8vYyzK5RIIXYe4WdJRzP+RME5s4ZGh1O3CTmwq2kQKso9SzJdbmE
	 tazPVLc9kp7etGLz89mlh7Z6hBWX5PTPEzQJKoO1V8iZwJPJLdX5N0w8v0tQU7qg56Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rsbdf7LY;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A125606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A125606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rsbdf7LY
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b40d23e1adso3617612a91.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795579722; x=1796184522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0LNuxPQ85dXvh9CQor/dnn7IAr6otMWl78EFfasX0Q=;
        b=rsbdf7LYyj4pjxEpTtkhsWp0bg/dznF1KsPEvJTvPgURSF58pKjKsovDObyEZs4H19
         MXXRvrEwwwa/RUF5obWf0Rotk0aL4T22jRU39RMdr4UDHdqHn334fAaz7YkkDBh74PJl
         evE1LGqQXao5aj1ZKV8TMlkrRsrtbEm0kbO7okZOuVpI5KTk4n1nMDMzsfiwekftqmGo
         Xwed4lyvPwUfuLvcLuoEDfoyicBJixjuG3QSG0WHIxV+syj4aY3mex5tcL31R+MTktLB
         1lwPdK1lwL6ccA9GigZEq1j5Jl1MmtNI/f8FReaa4K602WK/X8MnxKfsNAJtCDwl4GD4
         D3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795579722; x=1796184522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0LNuxPQ85dXvh9CQor/dnn7IAr6otMWl78EFfasX0Q=;
        b=GgAXGBzQLaejpbM7qnHmqF6Ycc5eEtylo/tRCEhX+aMYNUi1gIGJcyyNQ5rdT+Udjs
         eYNDbcX7Lk1urZT189Ft7mJy/sG87Dn5+wMnuq8E3y8xAFRtjE1d2I/IGG7tquERDeKG
         z7pzFXK4sd7kh/cMD8GxJoYGBUJXbiXSV62l/9TIFNxMXzKv8c/Nao+CJZbOadCfN2MY
         NXD4xg9oPYOgsJzb8p2gNUPajyJbNkcsLzHBmZL5QD+Nd6YoyHX8Hv1Y+IIcwHFUiost
         tPwxh4YQhN4BIMljbxBzKp08BzsHf+TdcLX0YL+PZNJ83W09HKqSaJbdU0mAVzPRr+jN
         u4mA==
X-Gm-Message-State: APuU4Z9RPdUYNqIV9y63ikC/lmp/gkSmMstScv4fzkDtFiIF7t3dsBgQ
	PZU30n2MYVHPQNnsG1DCXOnEJ6+aLZTK2+vr9uHA7umeVc0osPw081IbzYdyITyg
X-Gm-Gg: AZFdTZeIqpqQHMn6XGDeNFR8rR/iJ8WH5oCh1Pad80SwKeeFEz8VUQ5czXV2ptJIeat
	24OanTAaSZnyIHueFOKAAijyNqjVs0bCdBoP87ybskLozYPb5AgNwMWR2ol9QrUpg0ZH/nuO783
	d9vKlR+Wy7N3Tpszvxohtr/2DrpajFSnUf7J0DedUmQdC5UVESYYkNsWNZTfUjLSFlWcFnI7wpA
	0GR0vRtuTEgcYQQEk16/coUD0qng6A/RRkoqrt85sgzTCF0waZm7XkYfceB7mbON62uRamU7f2Q
	9EhCFr2bhkbJP34N0j1XJUZDY65vi9j5mBOCksDXFeO9aHXeiKVyukpVo8bUgUonL86OSujM+Y7
	opm0XkTMXTcjY8kMqACABVgaBN/SYuYNPK1KnuVxWy3bRPCiBmgDzkKWM3jlr35jY4tMGC8MF5/
	0erTOrpNJD0hwHFegufUYDs1OoCa8XSj0athft9NyltRt1fRDRnLt42ze5nXbnmrypM1iJVnBJO
	jnAhQh985wIi4o2spANE1Vx+P4Z7nGBNV+51Q8S0r+Jt06eIl645N8uByZSAa/oDQiSc3l+YeYC
	gNNHLHmwa66ogpdyjOYEFiQuLOOWH8ujC5tgCMwZ9jIir3M71ZECUcVa9bmpVcqWiYTN+2cheir
	Z6KWqkG+g7/qqyacdFpsx0jVgI7LPR9r5PlGVJiN7jdacqrIibybtotjn1+CqoIzqmkzCHXpXnE
	JTcYFn5T77Pmio8JKiKHpB
X-Received: by 2002:a17:90b:5546:b0:3b4:c66d:2633 with SMTP id 98e67ed59e1d1-3b4c66d280emr5380641a91.62.1795579721681;
        Tue, 24 Nov 2026 20:08:41 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a34asm25127967a91.3.2026.11.24.20.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:08:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luis.gerhorst@fau.de
Subject: [PATCH bpf 3/5] bpf: Use get_unaligned() in bpf_map_direct_read()
Date: Wed, 25 Nov 2026 04:08:18 +0000
Message-ID: <20261125040820.947816-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125040820.947816-1-alexei.starovoitov@gmail.com>
References: <20261125040820.947816-1-alexei.starovoitov@gmail.com>
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
index 219173a46110..13c53df386bc 100644
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
@@ -6379,13 +6380,13 @@ int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
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

