Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B79382F1C
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579816; cv=none; b=cQIYlGJQXsHVSZvMbYvIkDbAN6DbHYrujZ8ykqDRux4bIjfZui+UnbqGHCEFyoj4cEdG3QgsK8TfocYZ40qYpH/53PRwUDcxQYFQCUr4KU47kDWNe2REq0mkhefw3VUzqNVBWb4sNod6yOtexnPavxoyOYixy+bgmYizKnhx9as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579816; c=relaxed/simple;
	bh=FZQhMW+hukoHO4+DjAi4HHyzYmDgFnICV2PzArRalG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnTU4KOrheHLR7wDriJOEmOGEQoGz5QGmjcdxCFJBbw28jHJbGOFXejkfzpvfjE9q4soJG/FHPDY1VmOQaMGzJI/Ie2y81JXmplgUM4OfV4Ip5DNSYPlGAiqptbb7xocIezsx3HIidU5JcADhrijoXw27IyBD4tjmTdlhO3L4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZT0Aii5; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZT0Aii5"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1077335a91.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 10:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789579809; x=1790184609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JHlHzMstDqT3XMPtfUZ92aKs1ScQR4MfhSy0wYYDEWM=;
        b=XZT0Aii5o0I/1WNeJWYcXQxUOCxgrrU5RU0hlcPXdITBKryfwVzk5ldhGEwcDwu8Oy
         XvH/PWCFtmjdaQYbCOTTFEnZlpCrN3Ba97ismT8NwaLLoha0I/bFrsE4JGkcAqEYKsx9
         EBrgB/K5I7Ob8JQzc1LYwuTyAnD0ZM3ilalR3shJFvam+nWjuSJrAatHxzfjJALNNYdL
         1MsCHGoPL+KtuBQfrLBalj6Sq3uiY/3qpPSn6daocFzbcfg5Bm+4B/D+vkTI7T9LOAPS
         iZCgixqpir7sQ27DczcFhyoQmu8jAZEuLSNFRpmpKvBFPJ6otvFHaEQ6kBzqQ53CJEsg
         ZhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789579809; x=1790184609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JHlHzMstDqT3XMPtfUZ92aKs1ScQR4MfhSy0wYYDEWM=;
        b=l2nRiWAyHmhQWEjIKnRePQHSHXsXjWnvDxWa/FAjivukxcPw6dom+dvfCyUL4Ep22G
         34Uqzc9nL/cgDbuhMg734ZsmyZAizcu/WDJFAhIG4atV76JQxJOeI3toGecdhYTHvxy7
         PCBmiDKXJwRaBC0fKsPmFBco4HPY+lrGQfg9xLm0COsf/0oyEsclnqiT/N0U1hjhGXHH
         GhpMPA7mgIg36lBwerOoP8dv+IBgNR3lYBA1455t1Ye7ciMrbP0C1s43MwBd5Q+vjHiE
         C2n6U6vmxRA9J4CiUavCpyRNky4Tt8ka25u4zXCYwy1BpSMSWJ9t9w4xm6DGRd2O67ea
         Ti5w==
X-Gm-Message-State: AFuF++n4b1DXLhxxmb0iOEU0QfhWBP33eRgzfjwkzwzogqbUhUMNb8V0
	X9puV9XmMzePS/l7jbS2BYG8TEWWNd+HFCze3g6A8G/KidwXpvAFvvRe
X-Gm-Gg: AYBFou27CEp5AhUgnPn3M81EflvOZPvtB1kvz+brotXtEjc8LS4eGPAe3/5ytbUTrFm
	uaoDElKtxroC7WG5a+PIIaGRmgonyqAOL2E3LmaR57DRMpEj7hKaWWM17WZ+cufAYy2uvhBNHGv
	xRiP+qenVs+TyLZMNhCI2l9QEWgb25NBoU/vhtgOEt/Zxqd2z1J6pHL26xhzuAPW0bMHqtcfUm5
	8uqHaCgKLxifdwcO2gvKLkTSOGTEAcaYQBzJ6+R6HIh4uwixNNEUKMs6GrtAtUdMku/BpelZGrL
	AROtdNZiWO4m1tdNAQg65jvjIirDQu9se4FmHv4a9YASywr/cUru3OGtDFVIfI4Fdfr1FHkdLS8
	a3gGDEIQWH4buaVvHhu4wsynvmWkvhqnEbNwpzZyQRmfOnE4ThDqNJ108Cly+hccldi+BNlo2QC
	qdkAJX/fbdB3edGfqPPoUSvdhsev1k+2vqQ9AYazHrIraBRLRpVD6nrljiNcSDb1qO8h2afIo7K
	6LJpQCpUbHbavuNOQ/Fiq3RQO8BgBwY
X-Received: by 2002:a17:90b:582c:b0:39d:f18c:1ad1 with SMTP id 98e67ed59e1d1-39e1e2501e6mr10293395a91.3.1789579809367;
        Wed, 16 Sep 2026 10:30:09 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35d9d261sm451834a91.1.2026.09.16.10.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:30:08 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
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
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	co+e4b67bb653c9bb8b@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf] bpf: reject dev-bound programs on unregistering devices
Date: Thu, 17 Sep 2026 01:29:45 +0800
Message-ID: <20260916172944.1337289-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_prog_dev_bound_init() takes a reference to the target netdev with
dev_get_by_index(), then initializes the BPF offload state later under
bpf_devs_lock. If unregister_netdevice_many_notify() runs in between,
bpf_dev_bound_netdev_unregister() can observe that no bound-only ondev
exists yet and return. The loader can then create a new bound-only ondev
for a device whose unregister path has already passed the BPF cleanup
point, leaving prog->aux->offload->netdev dangling after dev_put().

Reject new dev-bound state once the device has left NETREG_REGISTERED.
The unregister path sets NETREG_UNREGISTERING before BPF cleanup, and
both initialization and cleanup hold bpf_devs_lock, so no ondev can be
created after cleanup has passed.

The race was reproduced without kernel source instrumentation by using a
tracing BPF fexit program to signal and widen the interval immediately
after dev_get_by_index() returns. KASAN reported:

  BUG: KASAN: slab-use-after-free in bpf_dev_bound_resolve_kfunc (kernel/bpf/offload.c:846)
  Read of size 8
  bpf_dev_bound_resolve_kfunc (kernel/bpf/offload.c:846)
  bpf_fixup_kfunc_call (kernel/bpf/verifier.c:20595)
  bpf_do_misc_fixups (kernel/bpf/fixups.c:1888)
  bpf_check (kernel/bpf/verifier.c:21201)
  bpf_prog_load (kernel/bpf/syscall.c:3133)
  __sys_bpf (kernel/bpf/syscall.c:6367)

The object was freed concurrently through:

  netdev_run_todo (net/core/dev.c:11818)
  rtnl_dellink (net/core/rtnetlink.c:3702)

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Reported-by: <co+e4b67bb653c9bb8b@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Please queue this fix for stable kernels.

 kernel/bpf/offload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0d6f5569588c3..5e05517d06c7c 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -182,6 +182,9 @@ static int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *n
 	struct bpf_prog_offload *offload;
 	int err;
 
+	if (READ_ONCE(netdev->reg_state) != NETREG_REGISTERED)
+		return -ENODEV;
+
 	offload = kzalloc_obj(*offload, GFP_USER);
 	if (!offload)
 		return -ENOMEM;
-- 
2.55.0

