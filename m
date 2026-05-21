Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17833E0740
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371598; cv=none; b=r+pHSk2vh6GnUtQgAlRcwn6kVHpryDRx2uHo7TuFe72ZL0QfkA9xrFwHuS6s5VKYPfIP4pN/1PG21rFfVO27YqeOvbhe+jC34PViEWTAZ55Kbg6tsH5Jg1QSz9p+CPvpuJ33YsU7ah5EP/N5vITtXxmYC26dHfwAuX9keugHUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371598; c=relaxed/simple;
	bh=DOfWH6hLKc3o9vRvYL5MSuCO1dG989HvIXld9/XiNFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pA1bHC+hg+VgM31UD+NU+puCmf4qgI1TCcV8sdjZf2PagHJ07u8S684/B2lxdpR7HC4hh8hOPGst1K7Fz5jMacry4KKgGRkv2nj8/khzITr47EZcAeimHtP4eC7iWp+jqDhZBmhLcWBH91aJ0ABuJ0kZwXvHl0ILlGne91FpWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+6brNlC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+6brNlC"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c828daf83e2so2848223a12.2
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 06:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371597; x=1779976397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4/cZz+D5VB55BisYY3cQwNyjxNuoDjRYz6rglyNSPk=;
        b=Z+6brNlCk8rg9zkj6XMWn5GlJ9sjPv+cecp+klRYajWObFN9dCivmMefFXbsAe94DB
         2nNtlL1jhbbzenp/yZLuK0D6E97BIy3KV2pFO4eG9iFF7f3sm2QggLq8wSSz+Zse11wx
         NteAC5HVtgq+amX3HdvGLB9a7nUddfNg7YABXFQlUzvu8Ajhz7g3Fv4dKbYzDKKHnR+z
         aI5FVbzigvxocHsXxhtK8sfGtXaGNszG72fIE/TP4XRbQDQO6IgNFDnb9bHNjQaP1kiT
         6dmFmlx3NAitTg2uYRotVofLZR2GUbfsv6ofB0zjOJS4qrFe5VCPqKy78UUmR5y3ik0C
         fH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371597; x=1779976397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4/cZz+D5VB55BisYY3cQwNyjxNuoDjRYz6rglyNSPk=;
        b=NNdMkeW2BYDDX5eXJL2OBxHbBkVDsRf2+ABfRVgeWPGi9u82JqD63qF2YR5pI40bBo
         +JfhBAea4qZcyp6TcrTyzCTHkeXf9+Uu7Jcx89Nw+u3oJX//nAdHdKwHc+lOr+oeyd9s
         JuElBTLUk3dXTneroxcVmCq5wCMv5JhE+5oicR7T8HkJf6JOvhkBn2u9H0R4YUPWxg9d
         xIi3g91UbErzKgLXdh3A67GF/Z2POhs3H09h0VVMEdIXNHyMbXOYdx+eSr4HghkFBFvV
         17+poH9m6YtrGD7qLyenhM/Q59ETn0lb3UbPLhykXjI6IbzOhJP6OArCAMSdExW5RyrV
         NK2A==
X-Forwarded-Encrypted: i=1; AFNElJ98WIzh0uRWfpFrcDff6n1TSWUXQtvVjrRnvBvzGCeTsnDDW7lObb3nDNOt9gGY5i1aD1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxObJv5uj2qvdQl1tjhIRv349Go+SOEfM5BGRD5Jip2nfAO1bFh
	7FvIefwQWVeovJ+dddUTUuBAYDsC3Qy9PTpbdP5RLDD+2NInKEegQjfV
X-Gm-Gg: Acq92OE6AWzpDuQbx+B+0cBtc8kfbanzrpi3Cy57MCbqzsVHo8Ff4m+N9vzSvcf9TYV
	zoSN7z7pitI4OkUoFsC2SshI8Bt2nBhOYIbUrmrpvK8C9V2mvnioiv8Gs7GPiYUu30y9tz21e0y
	JzH4d3vSx/IJZ9J6L+TeKgn+n8uzHEuFF3U456MIUnXVF0hLEIbvBmkQYWelNtkj8u4Y+0LC4rU
	6OTaeGyRuEj69+FnSH27O8GpZjLOP84+P2/NrpXpoHluijeQDk4XjoahXocFFRYMMhDJm1bN4Ko
	ZDX7M36LYkPudyLM44COSL9vYj/7o4fG2o65viIYMclKaEkbgdIENOi//flK0pbvk3ItEM+xZbn
	GMjPfOqt2DrPhqdsv748iWyiQGKfUvP8MmZuZsEdDiEBERKI/m8dhtRaORe+ZR5CtmKek+/L8eN
	hFyrPcIbE7yoA4ZnhsrEAnCU97Mn5SBy+58TMJyJ4CGM8aNg+7UhQHJFM/uTB46vN5oVkVRywoO
	viPkmdIICfyC8EtqwYA2Esfn9a1qIc=
X-Received: by 2002:a17:902:db07:b0:2bd:e01d:eb25 with SMTP id d9443c01a7336-2bea308aab8mr32286875ad.32.1779371596913;
        Thu, 21 May 2026 06:53:16 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:16 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 1/6] bpf: Add bpf_ktime_get_real_ns() kfunc
Date: Thu, 21 May 2026 21:52:39 +0800
Message-Id: <20260521135244.40869-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260521135244.40869-1-kerneljasonxing@gmail.com>
References: <20260521135244.40869-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Currently BPF programs can obtain timestamps via bpf_ktime_get_ns(),
which returns CLOCK_MONOTONIC time. However, the skb->tstamp field
populated by the network stack uses ktime_get_real() which is in the
CLOCK_REALTIME domain.

In the series, kernel reports the software/hardware timestamps through
sockopt and then userspace bpf application gets them and calculate the
delta only through an unified time unit.

However, prior to this, when a BPF program tries to measure RX packet
delay by comparing skb->tstamp with bpf_ktime_get_ns(), the result
is incorrect because the two clocks have different epochs.

Introduce a new BPF kfunc bpf_ktime_get_real_ns() that returns the
current CLOCK_REALTIME time. This allows BPF programs to perform
accurate delay calculations without clock domain mismatch issue.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 kernel/bpf/helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2bb60200c266..863645d096ef 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2317,6 +2317,11 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 
 __bpf_kfunc_start_defs();
 
+__bpf_kfunc u64 bpf_ktime_get_real_ns(void)
+{
+	return ktime_get_real_fast_ns();
+}
+
 /**
  * bpf_obj_new() - allocate an object described by program BTF
  * @local_type_id__k: type ID in program BTF
@@ -4859,6 +4864,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
+BTF_ID_FLAGS(func, bpf_ktime_get_real_ns)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.43.7

