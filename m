Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81566478E5B
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754046; cv=none; b=FaBihz46AesyvfJ3Lt8f516puIR86FsFF9A7sGIeRYJKVZZYBW3EY+HGG9BicxnKttB3dzx4m6azHBAgZD68ZXOpTI9vsmK+3WvtUqE1VvlaX5aMO/QGuQ+QKeZS1ZG0h89twuP0hKZVhfqXV+enqnkZHh3pTL3iTRyVyBVJkHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754046; c=relaxed/simple;
	bh=vmfVuXC1Kci8WIGxW5bjMPz0qeJm5HtuIa4PggV5cAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abP//8TuUUQHabIrFV4A6FF0vfwdu+b4uhRH0ncj8jG+jEoMiKYilAM5WxQV4y3AVYaqEpGzOegnvbkeggMzakSxE9hCIFg1NjHfcoeLem1wdyDkmasYS6qOYIyX959mGdwsWlFw5KdndlRVjnB55cFhDUi5cHzDom3eME5wUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcNUeaGr; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcNUeaGr"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84592b55832so1835675b3a.3
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 10:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782754045; x=1783358845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijO00ApSrJ4JfinG+iOaoegiY2Fv72WhceXqrwbihis=;
        b=mcNUeaGrwHHb6mK4agvncycFBMAzRnpl5U8HcrFILADiR4xjAZunvQLS9JtT91sna+
         ZmTIB6i8TmMEIpPLjQaF4C7CJb55CWm3dOu3CRmVl7qab0OG8tsjiZ499IEQ/DI6Ie2w
         7diXSoyvOQT7vw1ly68lKN56qtxbJXEP+HLUsimUYjbvtGiMmasThZRzX5XSI6n28T2K
         l/dG06PLj85SqUgYDBaCsKDxEbbO3s+TfaTet6eTTPVkUuD3uW5GLsqKdXeYmJyeGi/o
         LUtAlQZcMc+I8x4KTeKrdKe+F1ZAprrP8m8z8pIX4pgbicAh4DezcndQZM1TgQCIBPWK
         juQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754045; x=1783358845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ijO00ApSrJ4JfinG+iOaoegiY2Fv72WhceXqrwbihis=;
        b=AC91wEXaKFg2LQnZtymKRCWEVx8H24W1Q9hjcMD3VLTQ9JNnv7kW+dhZ40HpYqm8h5
         eRH/mFu0QWdlxIWmgaHRYfg1CoTHOuiPqAf174oDsVkIF+f15C/wYx0EtL5/CLpXMlE6
         bO5lVBGWvR+0C8ASc8/j53S3Y7w4I/RpLr056WDurLUtvPrwOmuCP26xo+a7lkklKD2L
         /BYFoR8eQ5dnaeagkyWu+4gbyuGa0N60FGo8lyUIqqB2Ct3vg3wf5Rp+u8IR8deLm8M3
         77rCbeEAnj4nZUHIueUL+vNsb/sD9DUN4lz3stL7cW9ESXVg23hagzdrh4JgZ/sucsDH
         HlAA==
X-Forwarded-Encrypted: i=1; AHgh+RqWGPf1IBO9yyZdnCosUzoXfnO/3lFcQTAJ6qjnj2/s6UbEQ+VbG5/GnN0COof3fdL6hpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1zqLE2vUr47bBUzgqJC0g3w8r1lUrkQCNGDDvygOOHh46gt8
	YfglsVPh7o3TFiL9W7RVs4iVQr2s1KDAXL96yBr+FcT26RFuFmUK3WKk
X-Gm-Gg: AfdE7ckuDq7pEZ+XaqgVmttex5nU1yTM+j+oq2YkfBPVB44tcnOOIAMSLknX2snUi4r
	/JCsFrAEg06GZ68+Gr703xQAW+CBa5419xirZTQHBuKnaMAwJnZPE604Hze0U1zV8FjyCjWlWCQ
	c+dZS2acQkuYJywuBWXmG4eQYQqvq/dXtLsPud9dgjcCnjZz8+Awn0memRiQ03pEcB+FFMGVbVo
	qSYxnks6rhqjPuiAb3Qs3vFYekGHBhP+kE+e6xQ0PlKtWiLPe0ic39ce4Y5Zn+JRcqA2aGzyDlr
	oRBDWx+S7vz0I+Zza8knAprnrHoXmkWYp4Nlh52DL1TbOmdC/Vr7c8ahnql3UoTxaMqV8DXANCP
	cXAjq8wTiQyauOXPXQU1PurCgcPKgguKrN3Mkb+GhM4XuMfoaHzAb6h9srPZSsv1CGktrOpTiPY
	ZBeXcBJz8fBewL8cm66X11IbV647lZTabgAWSBlaSEcz8KM042C7g=
X-Received: by 2002:a05:6a00:809:b0:847:9151:3409 with SMTP id d2e1a72fcca58-8479f28fe73mr310446b3a.55.1782754044625;
        Mon, 29 Jun 2026 10:27:24 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a039f2afsm78542b3a.53.2026.06.29.10.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:27:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/2] bpf, sockmap: disallow update and delete from tc, xdp and flow_dissector
Date: Mon, 29 Jun 2026 17:27:00 +0000
Message-ID: <20260629172704.1302218-2-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
References: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sock_map_update_common() and __sock_map_delete() hold stab->lock and call
sock_map_unref() -> sock_map_del_link(), which takes sk_callback_lock for
write. That gives the order stab->lock -> sk_callback_lock.

The reverse order comes from the SK_SKB stream parser.
sk_psock_strp_data_ready() holds sk_callback_lock for read, and after the
verdict tcp_bpf_strp_read_sock() acks the consumed data inline via
__tcp_cleanup_rbuf(). The ACK goes out egress, where a sched_cls program
deletes from the sockmap and takes stab->lock:

  WARNING: possible circular locking dependency detected
  ------------------------------------------------------
  syz.9.8824 is trying to acquire lock:
  (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
  but task is already holding lock:
  (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173

  -> #1 (clock-AF_INET){++.-}-{3:3}:
         _raw_write_lock_bh
         sock_map_del_link net/core/sock_map.c:167
         sock_map_unref net/core/sock_map.c:184
         sock_map_update_common net/core/sock_map.c:509
         sock_map_update_elem_sys net/core/sock_map.c:588
         map_update_elem kernel/bpf/syscall.c:1805

  -> #0 (&stab->lock){+.-.}-{3:3}:
         _raw_spin_lock_bh
         __sock_map_delete net/core/sock_map.c:421
         sock_map_delete_elem net/core/sock_map.c:452
         bpf_prog_06044d24140080b6
         tcx_run net/core/dev.c:4451
         sch_handle_egress net/core/dev.c:4541
         __dev_queue_xmit net/core/dev.c:4808
         ...
         tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
         strp_data_ready net/strparser/strparser.c:402
         sk_psock_strp_data_ready net/core/skmsg.c:1174
         tcp_data_queue net/ipv4/tcp_input.c:5661

  Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    rlock(clock-AF_INET);
                                 lock(&stab->lock);
                                 lock(clock-AF_INET);
    lock(&stab->lock);

   *** DEADLOCK ***

A tc, xdp or flow_dissector program has no reason to update or delete a
sockmap, and redirect does not go through here. Drop them from
may_update_sockmap() so the verifier rejects it. It also closes the
matching sockhash inversion.

Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/bpf/verifier.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25aea4271cd0..58d766c34626 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8489,11 +8489,7 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 			return true;
 		break;
 	case BPF_PROG_TYPE_SOCKET_FILTER:
-	case BPF_PROG_TYPE_SCHED_CLS:
-	case BPF_PROG_TYPE_SCHED_ACT:
-	case BPF_PROG_TYPE_XDP:
 	case BPF_PROG_TYPE_SK_REUSEPORT:
-	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return true;
 	default:
-- 
2.43.0

