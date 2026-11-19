Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795072668;
	b=X0/kF8mcBVu2zI/TBJaCGOgQ74N+JT9YYpk9l5P+cuN4cNlUn0AU8Dj03sPDiG0c/hHU
	 FLoVri6/M+y5t+4IBXVLJ0HojTO8UuCUEp+gXZdMP6a8GK5MK5cQyv9+APodOKgO6uJQe
	 ibP7nCPDgLHb2fezxc8aC0t9VWvshRNpb51c7bkOT3IfyYrvpa+00Q0CCmeY6yHtVhucb
	 cIgXxYivcyMnGdub+fXr2gL1hhgzl7vdjetycx9JQHfJvwvBL3PWQvnppDXvoBqzltsVx
	 d3+1WYXz3N06WUUmvfVE2phcY1VccJoupH2Bl8JSd0HCMmZGjcN11ujIELhRie/pgtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=Y2jI1UcvOAo4JgUGNlIgNsrRQSXtwE1BJJn9AjulaZk=;
	b=vpNpaWMCxvY6v+H0fMMnS5DmHj4tyPIyG6z07ZFTBqO+gO6Kb2qYaBFq/+EwI0ezYc/K
	 86TmlItNJmFlUcMqv+NGqPhzWm3NyDJZv1zgAtbY2O3MEuVT/JHF4nc8ad2+evKMRq6UC
	 V8Y7P1JHtWOgUXoAg9wRKKy+JVr+x0v28cqPxPuPeoc/fX2sMtbWQP7tpwJ1dVQgN7eU1
	 zQdjU7JDQtGfsqWeM6oe6ZX86DtAXyl8Y2oWIjYeEm28N+rs8XXQyG1rGzgRxg+wDl9cq
	 G3GEGWXO9Z+ut8dsPLujvzusi0ILhWu5BvMoPDi5QkcrteqKCDpa4wzuvsL3UbpSeIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="n/Sf+wEg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7691E606A324
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 07:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7691E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n/Sf+wEg
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-92110499585so18358256d6.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 23:17:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795072667; cv=none;
        d=google.com; s=arc-20260327;
        b=iXMEgJSdYihwXp7QC+SPf989TfR21ey5ftOynVX4og4iAuFG7bN4gDGoCiU4QdoYZi
         WOVla6TEe03HhArXmjSgFCNDOqDrvfYhkOd8+upooTf0U/djtFGZdRIfOG/ZM1O0Vk2/
         617N61ED2ja1CKPVUbq7MXNmiTzZuNOSF6/RXZH7I6SPIJ2RDEA8GfgstVvDmQmHLW4+
         JrggUkmEtZigjDFYIC4YEDHsDODn6BfXU7iDgicU9OeJlE3XfPt0xCBkfVPaHtDXVOmp
         erOME5S5mkc7/QJaRpYBayhzOZqXfFT03fs081ghG02BzK/FtivitzlsErFvxJqLXnFX
         Sl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Y2jI1UcvOAo4JgUGNlIgNsrRQSXtwE1BJJn9AjulaZk=;
        fh=v/qBMU4wwadfiVHPQOJnoB8I8DXtsJMiG4gQ2sxzR1Q=;
        b=h8HxFksuNnd+IIpJ7rOlAh2+f3XBs95xFzb8EHwYUl4x+RTJobc20DJjlxVpduCJiJ
         OZDTsgaEXY/n9X64vMsJ9M+3oZDdcoKah0c3+eyVODUZbgMFwyrWmM2g19RdJZTRMc7X
         lAw//f0uaSqNfyRsiMptxyOxkXBjlU7Es2Bd6jjmjDF7mh4A6P9a0+0usJyCVEQBbQx2
         HeSini2zzIOCccaVH0kk8f5AZ3e5s752R0qpJnwpeDPUlRT1yGzfG1nyC7dLwBbghHQ6
         HtJ5rhkpbbPaKk2gMetDeh7LLJAO4lMFdeGgjCzg2uj5seko/klrhiwMtwYc6sDt7Vys
         2CBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072667; x=1795677467; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y2jI1UcvOAo4JgUGNlIgNsrRQSXtwE1BJJn9AjulaZk=;
        b=n/Sf+wEgPISNbMrvTHzlMkwOHpTsjKvZ5pVZsnHdhvqOpu+Kw8ri0ePdTxuNmahNGP
         GJ24w2u8q5mVk6eVwBqHEYNxabqXk2r6Ey7zKqD4qBUGgFeMcM7DqWQEw46WTP2rLUDM
         fqfZ/x0bHOOA0xUf5/fgPfymVRjnKtfZ8Bg+563oVN4ckDSDF0SDCf6wLU1AQd8FbYst
         E8JP9vE3sL/B7XnqU2oEPR5z/0UlHARmli7WvqAQOBfxzi9kmp8VegZhshYNxMKa+pgH
         oarBJeqJgUQIX/1Vg6SAnW7pNGcpgKqkl9lKluAURWLtgMjSpbtP2ZXvM04nwoKmtIE+
         ZVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072667; x=1795677467;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y2jI1UcvOAo4JgUGNlIgNsrRQSXtwE1BJJn9AjulaZk=;
        b=yWKzIhlQFy/h5/ry1i0nURUyy7BN3siwHhKvW6j6S9HLyG4g8rw8aCuHf5PSoG5RDo
         hb3VEm7PWi2QOrvt3ThrlSx2XvB4C6UsJgpxteMDVDLVWmn41bSsKZBLcHSLERBU99gg
         3Bqump/8/hNgz2EQemE2Zmx2AyuSJNaNZYOJy+kf92tKeiEUJr5Md9Iiev0/XBaiRdOR
         H4fUJqVLsWI4KffxcB7IVMOlVZunnHZ5dRrKasPmVWIpiDihRH/B6LhPfq6w/se4E157
         RRkg4c6coZ0kI55T2+vRj3+6YtPVdrb3BuEdbU+tYQ13qxVbQf3DJPVA9F7QO4Ew8owR
         FWrA==
X-Gm-Message-State: APuU4Z+pQ4nytfnazJtjKL9rWHsj/TOHe7yacDL8bUtEnI0g+A25pCYy
	y51vdAAJC2mM9itg/krKLvBoWh8nACMSebccORtKua1mbhzdSSNqydsFp8FAbM1KpSWT5w6KUu+
	L92L6tA+mI5ZP6XAcGq4clgtFpL6VxoUwCSAe8v0CLaNA
X-Gm-Gg: AZFdTZchHcA7zcHKiw95kCSgFSTexB8M/aAePXfR1Py+34G1ficTI5Vlji1pQe+XZ8W
	ZjwnjLSNK2Yuz2vwO5mRqTO2dLA+QaiOeibuzRSaAOLm25cEOzLpuMDqcfrvPXSdhQQ/bI9pqDB
	EEDvUmhffO2uVJ45OmLgDA2A69cyklrhJvaIA5ajqwCtj6N/5rZv9jFgPkq0gkxSQt8nvUPac1W
	+mVnpwHPjKDYSS8dMCSKrMVF/9JeBWXtPqD97nDyleE+NYZAB+FK9v24iagy+aACmMc2ytNGu2d
	h+5HMduChxePHu52Wx18c5moY2hM5JLGuGm94W9zu05JghbRnrNf58x2IJZEAE4J2yGQUVRfvuE
	rQOcQnpweuvLljy2NOfXe/rUOr0UR6OEdz3lGmw82xk782VMBYrrg+UTIvoklc47kgq+JI3QeNs
	P0LMyU9Gxz6bPn5QS1kg==
X-Received: by 2002:a05:6214:2e4a:b0:91f:30f8:73a1 with SMTP id
 6a1803df08f44-92114eaa8cfmr76540806d6.14.1795072667347; Wed, 18 Nov 2026
 23:17:47 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 02:17:35 -0500
X-Gm-Features: Aa3M54ph_TyDcI-889pWLXWFWWHzO94gu2mhuyfToJ4jckzhN230oQX7LcZtCYU
Message-ID: <CAMcAce-i6XG9vterM-Y9+hwnbGYwPgLNLvDZXsMkW2Kit5j88w@mail.gmail.com>
Subject: [PATCH bpf v2] bpf, lsm: Remove bpf_lsm_release_secctx from sleepable_lsm_hooks
To: bpf@vger.kernel.org
Cc: security@kernel.org, kpsingh@kernel.org, matt@bobrowski.net, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

security_release_secctx() invokes release_secctx LSM callbacks
(selinux_release_secctx() and apparmor_release_secctx()), which only
kfree(cp->context) and never sleep. Because the hook is non-blocking,
Netfilter callers legitimately invoke security_release_secctx() under
atomic, RCU, or softirq context:

  1. net/netfilter/nf_conntrack_standalone.c: ct_seq_start() acquires
     rcu_read_lock() and holds it across ct_seq_show() ->
     ct_show_secctx() -> security_release_secctx(&ctx) until ct_seq_stop().
  2. net/netfilter/nfnetlink_queue.c: nfqnl_enqueue_packet() runs under
     rcu_read_lock() in packet RX softirq and calls
     nfqnl_build_packet_message(), which allocates with GFP_ATOMIC and
     calls security_release_secctx(&ctx).
  3. net/netfilter/nf_conntrack_netlink.c: ctnetlink_conntrack_event()
     allocates with GFP_ATOMIC and calls ctnetlink_dump_secctx() ->
     security_release_secctx(&ctx).

Listing BTF_ID(func, bpf_lsm_release_secctx) in sleepable_lsm_hooks
lets BPF_PROG_TYPE_LSM sleepable programs (lsm.s/release_secctx) call
blocking helpers/kfuncs such as bpf_copy_from_user() in atomic/RCU/softirq
context, causing BUG: scheduling while atomic or RCU stalls.

Remove bpf_lsm_release_secctx from sleepable_lsm_hooks. Verified by
line inspection on 7.4.0-rc3 (20eef29b7c84), 6.12.118 (bpf_lsm.c:347),
and 6.6.162 (bpf_lsm.c:337), and live QEMU BPF verifier runs on
x86_64 7.4.0-rc3 and 6.12.118 (lsm.s/release_secctx: LOADED pre-patch ->
REJECTED post-patch with -EINVAL, "bpf_lsm_release_secctx is not
sleepable").

Fixes: 423f16108c9d ("bpf: Augment the set of sleepable LSM hooks")
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
v1 -> v2:
  - Correct sender identity and Signed-off-by with real legal name per DCO.
  - Remove drafting notes.
  - No functional code changes.

 kernel/bpf/bpf_lsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 468e63d..c7d683e 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -368,7 +368,6 @@ BTF_ID(func, bpf_lsm_path_chown)
 BTF_ID(func, bpf_lsm_path_truncate)
 #endif
 BTF_ID(func, bpf_lsm_read_file)
-BTF_ID(func, bpf_lsm_release_secctx)
 #ifdef CONFIG_SECURITY_PATH
 BTF_ID(func, bpf_lsm_sb_alloc_security)
 BTF_ID(func, bpf_lsm_sb_eat_lsm_opts)
-- 
2.43.0
