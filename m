Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB12A3CAA31
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959095; cv=none; b=O3YwnGs90Q8ah9cnQ3YxdgWsVRa5J/OjnnMk0iipS3afiwpqhYVFw8EkcJraTMlnQ/f17DKuY16tDrcDtISIa/yePpGfefV7nMPlZARU7AeXmO0Io59Axwui+ImIDdiljgOf1OYSKtOfSI5n2Xe5tCkN+/97Hm2Wdc2fB+M+KuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959095; c=relaxed/simple;
	bh=IxiUNfi8hOSowpcbPiuOC6Zu7GZZQksuwSK9n3EsJF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hu7lKgjKgTDitEFGC92vVAWleQHDQ3Ax0/7dhbAWSFRvlUCYraltpx6QNIxpLsp2bimWQo/91yb8PoQfRi4g1czGezPHV9WLce+W70ylXytckpXFZaN6DhkzPvLvp6XuYaAHuOaaNjYAUeeh9QYDYx7/ZPUjzjuE2+kt7dGvL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTK3xv7U; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTK3xv7U"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so2208947a12.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 23:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959094; x=1792563894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5RetILKqN45djyCKKQSpHx0n/NkrGcaNQp/CPxCU/jY=;
        b=sTK3xv7UXzczo6PB4iqXyHjg5HHkZOieuZD4YZoUDvadd5VWecSam1uuP+/5l9sKx1
         TGPYVloTjj7dqsiLAwA/qkJYhFvvtM4u+l+j3rmsFc0wN6gHBu4/RXoS2iHp+NSkThwm
         gzOjZYMFJLufmMYY8O/cmHf9xhpZfFhrJzThqjwSrDwrKbiJ6gIEl5dJfLo65ndK0tVO
         Fj8xXt4F9fjuJy9hljAcarXVvvkQx6N5NmwVglArmMzmVK995LbrctfKt0qH3uTJqADv
         UorDw3ZT06Hg/GHXrqOTvChTrJaA0PolcAiWJTd0CmbVCZZFEu2V6I8KDMB8cUQiJf2a
         zFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959094; x=1792563894;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5RetILKqN45djyCKKQSpHx0n/NkrGcaNQp/CPxCU/jY=;
        b=Z29Ex3KKl54XWLx75pZC9j1T7cK/1DPdYiWt2i4sHC8kkCrV2r5Ns01InBTwzv2f1f
         y4UBb5I8iwfTkT4eC4T1wdSCBZnYMO48vZJc/3n2zULqHZjtyBWzDWR9ovS9kyrFapdj
         6JEFQVgeEpx7N4QZUgjS8/rIrIohbTYaClprMr+2Iw45jOPzMcWGw+XolMH5b34lS9X0
         E6bzswFsCAFeRTtJKH6tI0+uxT6+/Iyu+riMDV6zrITxGKpNf/WRqHW1PwKsnpROx7H4
         ygCHzXUF3htiSz3zAR2Nwy0vn4H+IdZ5B7Kp4AKNE5Zgm98jdemq+z0x/R3A9refI/Th
         5KBA==
X-Gm-Message-State: AFq9FYJKBDos0kd//KuK47RmRvn4drvsR4WiTIGhbFUiXIiNjdmZ8LHh
	skYoRewD3N7a0/hUlGn0xwF/8gsxeEHkKEc3BDsAavngW7XkIAZEQFR7Fde51g==
X-Gm-Gg: AYBFou3qddz2dTkqk9uVaoUcjeMUKxrn/PEk3LaudaPoi1SHNKu9YduPv8wmyrXdA9F
	OWKV0YUO11SFsPewZUTOwLUrRCBvlE3cWgwgy82VNHqljSSt2Ew7KJEI+O5XvEQk8TiYJZ5Th1U
	RGxWsMwGtaLLyD6TBayBVSLulHKgRdadiipB1CdPT6U6fcP8/jt+NRXUvUKAvlSBcFXK9o5iFn1
	P41Ytn5P+6SJ4D6fx9iWJk6/ZIfOnfQI293oIUSit1fVlb1gsByWKXbID2tso5Kz6WFmjFObQvF
	abHSkQay+uWbzQqgmvfLDeAjGOHAhbxCX0pj1uvy1CwqO8PPIcTHQRIlunkB5rGrZ9YM3YvcUhO
	0iN7jConVwtSEwKsNVUprW1ZYuPFE5eHhXsVSrh0i4bbi4Dc/ozPrweE2xgeihu+j0PHyJefHaV
	Dh3EZxzscvQ5VFM/AF+etACknhK+kX36isnE59T0ysrrfdQ+wCfCSIkun8Qjay789GsrC0H5zwr
	pOYOud3pSK1i5I=
X-Received: by 2002:a05:6a20:ed02:10b0:3e1:6acf:cc0b with SMTP id adf61e73a8af0-3e16acfd7a2mr7244092637.46.1791959094006;
        Tue, 13 Oct 2026 23:24:54 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e41126sm6614238a12.23.2026.10.13.23.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:24:53 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 4/7] selftests/bpf: stack effects of scalar/dynptr global subprog params
Date: Tue, 13 Oct 2026 23:24:39 -0700
Message-ID: <20261013-scev-minimal-v3-followups-v2-4-6d9d61965486@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
References: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Verify that a frame pointer derived value does not induce stack
liveness effects, when passed as a scalar argument of a
global function.

Verify that a stack-based dynptr passed to a global function marks
live only corresponding 16 bytes.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c      | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 3d88cb28b8fe..d2fdc65c84c5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -182,6 +182,62 @@ __naked void global_callee_arg(void)
 	::: __clobber_all);
 }
 
+__noinline int global_int_arg(int x)
+{
+	return 0;
+}
+
+SEC("socket")
+__success __log_level(2)
+__msg("stack use/def subprog#0 global_noop_int_arg (d0,cs0):")
+__msg_next("  0: (bf) r1 = r10{{$}}")
+__msg_next("  1: (07) r1 += -8{{$}}")
+__msg_next("  2: (1f) r1 -= r10{{$}}")
+__msg_next("  3: (85) call pc+1{{$}}")
+__msg_next("  4: (95) exit")
+__naked void global_noop_int_arg(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"r1 -= r10;"		/* This is a scalar now. */
+	"call global_int_arg;"	/* And should not be tracked as stack effect. */
+	"exit;"
+	::: __clobber_all);
+}
+
+static char global_dynptr_buf[8];
+
+__noinline int global_noop_dynptr_arg(struct bpf_dynptr *p)
+{
+	return 0;
+}
+
+SEC("socket")
+__success __log_level(2)
+/* A global dynptr argument may read/write only its 16 bytes, with no definite write. */
+__msg("stack use/def subprog#0 global_callee_dynptr_arg (d0,cs0):")
+__msg("  7: (bf) r1 = r10{{$}}")
+__msg_next("  8: (07) r1 += -32{{$}}")
+__msg_next("  9: (85) call pc+1{{ +}}; use: fp0-24 fp0-32 may_def: fp0-24 fp0-32{{$}}")
+__msg_next(" 10: (95) exit{{$}}")
+__naked void global_callee_dynptr_arg(void)
+{
+	asm volatile (
+	"r1 = %[global_dynptr_buf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"r4 = r10;"
+	"r4 += -32;"
+	"call %[bpf_dynptr_from_mem];"
+	"r1 = r10;"
+	"r1 += -32;"
+	"call global_noop_dynptr_arg;"
+	"exit;"
+	:: __imm_addr(global_dynptr_buf), __imm(bpf_dynptr_from_mem)
+	: __clobber_all);
+}
+
 struct task_struct { int pid; };
 
 __noinline int global_noop_btf_arg(struct task_struct *p __arg_untrusted)

-- 
2.53.0
