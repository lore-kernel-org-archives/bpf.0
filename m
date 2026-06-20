Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF11240D587
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781927208; cv=none; b=rOKS5iA/sHCoqXJE/TvA4HOR57d91z37RE9vGzl7tGvG7MKE1W1SbgoeIyF225KhmQPhGuAmh1/ifDXBAwXA+vMHAy0eMrk1Ife1mFfiCmztJdUVX8H3dP6+f4178lO7h0qh0Lg+iTLTdih04xRj3G/pSxy0k4g63smPqhbagQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781927208; c=relaxed/simple;
	bh=3Qzg76vHOmcgRqXqt8NkpIhXJ5YC4/BNbosdNTyIHSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5REBmiuiZs13/AVrj6wj2S/UHc+A4UiuJ2Y6cdRGxywU/HPehx8e4l/fOc9SVDcqh/3cissAqOeTHRpxqwayIHHDfDgSQBTEiX1sgYHp5Sl4b6ZZTkagne6f1xQ+Uam1owzn7jZPmK7cV5frVPpZ9Fr+nE/mWqV3C9TZtAH/NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDGASgfV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDGASgfV"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8453bcf7276so1494567b3a.2
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781927205; x=1782532005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9lOYVWh4m+fhmrtdr8+YU5CQtPB1bE+eoCFLRPIV28A=;
        b=BDGASgfVwaVIAadGajdTFbnOw9w9ybYWTGU3tTFY2KS8jbmxYiKM4czkVdSbXwR0cR
         BMfAcSI23YWBpiozRViDKmFD3l/nLAXuKxpHEBroxDxtFq+VVHgeXUoCfMWS7Np2OWtx
         vfiO4dBN/IJ9mdePzqxFvsTEEgkyLNQXQZ1nlhMdFHexG3VLG5EEM2XlqcIWPBZPczuH
         tW6OsCCaOQjGlBPFQaJrbozz7KHodH21l+UqLaYMlvyxjnKGwIbgcMV3i2nhMcj5S+fO
         EppJ1M3VoBjSBDXpYVNnhopkAS6k93jL4Fstd2nJzB9x1ti9+XfjmXXYOAZtJq0d/icz
         uJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781927205; x=1782532005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lOYVWh4m+fhmrtdr8+YU5CQtPB1bE+eoCFLRPIV28A=;
        b=rkSyEkqFrCNwsiXModzecoPsbGxDDFF7EZ09Pbt5Og0RKccT3jkMYVmhfkHxGdDIUC
         jc3KgMmnoUt9PrMgvpQL5gCuWzDbS3ihyVi9qDetMqU99Gg7OQwDGFCulqA6FISCFQRP
         H14BIF6iPHyoRqVv3U6udrxWYw6kICC74qU0lcZjUHms+w5HOEZoegJvWjHgEqYEdvLm
         cJNSrhWm2/I0UScJxQBAabBMSfsDQmEJvpB17wgjnrpdxgrgkp21PkKuEzW+wOBkTa2b
         yC7DU6PheOax4ivsWnJQQLkQzliKjf5F9CR0QEPgqOy7SmhCIW93W7MFXeSVaDndETb7
         Ps9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+56rsTplz2X7CAAFEYFcpK6d9M7jTEiKfIZdkuq+djjMRVFT2ZY1OVzsH/uddAYIL6Y2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpWq0eZUZljbTQPyrpIOLb6iKxbh1rYboCITjD8xDvZbf8soi
	hKgIbNEtHH8rS9M+YD4+m3RCHXb/KzWUbcyiKZTqqev/P0PRKRmbXii5
X-Gm-Gg: AfdE7ckG67lP1ToTe2z7SzxvT9J5kMVH2TFwCSxoH9Y/pual4lSg3gr4BEcdfUCClCt
	XVSFcNvi7hxatxRQ/re5ykPx2yL3rSzfFmmSuedLDnZEChKkMcwiZrTQQ5E8cZtAUoXw+8TYUv6
	ogL2bblQJkWRTN0W+YsixJalXvrwuL7qLgSeL22Lj2buECy5svlCBnorVUNvCyuqOeG8V3KEYWm
	ha4IFOSWi/4qt6J5Lf3B25mVa1sC7ovV33raUAa+3lohlm07FDrWekdNr1868UccS0oX67A+bEJ
	Ag/S9eLnobSFQras00YHnj3a/cmb3v5VvoA8x/HxB/IxyrExgoxGxKtdqA5NHdlWzICIfkbJDIY
	OnyABzIl4J6P87LwUuF1oPV12ZX48QkckKT37BMSI14/Fv1gf704OqfF12PZ4NMyaEbsFKL8/Vv
	oc7ZPw6S58gIcK0u7whKRHZtRKrgkzv5n+h6qMoyK3pgAdDa1CNUA=
X-Received: by 2002:a05:6a00:9296:b0:845:286d:4675 with SMTP id d2e1a72fcca58-845507c1c40mr6335507b3a.10.1781927205187;
        Fri, 19 Jun 2026 20:46:45 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ee3dc2sm701458b3a.58.2026.06.19.20.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:46:44 -0700 (PDT)
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
	Lorenz Bauer <lmb@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v2] bpf, sockmap: disallow update and delete from tc, xdp and flow_dissector
Date: Sat, 20 Jun 2026 03:46:23 +0000
Message-ID: <20260620034632.2308-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
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
  7.1.0-rc6 Not tainted
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

Fixes: 0126240f448d ("bpf: sockmap: Allow update from BPF")
Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
 - reject sockmap update/delete from tc, xdp and flow_dissector (John
   Fastabend)
 - fix the changelog (Jiayuan Chen)

v1:
 - https://lore.kernel.org/all/20260616091153.2966617-1-rhkrqnwk98@gmail.com/

 kernel/bpf/verifier.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..94d225521b5a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8766,11 +8766,7 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
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

