Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069200;
	b=sLDGHXOGG/CgFZ64uq9xEllksPTZH2tHpK2Edns2AyB9QnxiBerIWbYKZIr35OwPrFCw
	 RIbrLwcEmKqJh5AWUrTDCUoimoic27Txp1v2w1Na9UD3SbGdwVPfFNcQ6TA6ZJvcJlPzz
	 Zg6/n4qidsSuWtqS8ciUPtU4hG1igN1Fx/VgGEpRKU2ZX9HgjLyYlal2f6tBOIO85+6e7
	 4WAaC2PgA6ideLW5vBAzwSYb/LzzWfc99jPVGWzIV/VWPkpm713jRl6yGpqdAcNcUHkOd
	 Z2l1pUcrcKLA251SSFkFSd7/83qOSsUbq4ftSydqbHcqkuziLE44RxPNZgv/DXvOxuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=xoCndVwrvCSfCd0BaHKCqL9ELaacWGRyWSDCytAWBDI=;
	b=3sqshCJHSDqKeGz5b1jXs+0uMK1aH3e0RCad/sLsSBkmRixepgWwLDIdR7a203GbkL3I
	 GqZvMh4OcSQBLmwNH1/mGeao2S+kTnM9lpurAfpp4e5pra8MMPuKh9xMncDoSPLocfvXK
	 zJfy7aA+FrWyB5fO6JRgM244B3T4szyD+qyc/LupHrZtVcuyWxPEa6tR6RuOsHgTi1vz9
	 +yVIaawj1Ih5QepAscqKdv5lNPoH9HohDdCxGznRbvJXxHNfa6K4xnFuG33T6Trr5o0Fw
	 onYY6UblPlfq0pKQmmSjdn8za0IwqDJMdXbYxRj5zmKn2M3rN3axDAjuDcsvmntK28A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UT7r6HIM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130D2606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 130D2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UT7r6HIM
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso19677706d6.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 22:19:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795069199; cv=none;
        d=google.com; s=arc-20260327;
        b=Q1OhKp2mFXHj35Ve6rsE6DwO3ioekScF9Ti1SQNjuXdWLxWhcrTR8OE/SmPMvQw9tc
         L+dwTD8kLP0i2fsig/npQ/suIuT+0SZ9krMpIVYmOSC3OQ+ffdbRjMJuwmEwyRaR2Ogn
         inPnPJliNM8lOfntUJtCygHf/wMBXMT/j41Zg5QC6awsnEWbNuLlA2w/8xaLFoIYPh1g
         vesW8sEa9C9roJYsqPmmPQ7ZD8tDgsRVPyVoxJv/aTS+41eWxJnaBi2TkA0ziCDzuHkA
         lkVtja5wAE8g+WYBwRm/NrzJhy7IwEYUCY8yqHWEqSVWsOPtDc2ozoqhbxLbDwXJWB6S
         JsHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xoCndVwrvCSfCd0BaHKCqL9ELaacWGRyWSDCytAWBDI=;
        fh=8W/r0CnnlB1OBU5V+CPinxP0lccBAW6JlZ+1QiwmImg=;
        b=rhGbrzJcMPyudlNTEwS6pm1e9Mx0lnZIu8JgwSsDORRy3XuuIKV2Kygd77Nj6zGkm2
         VtcqJDWYQzWjcH5aVP3e9FE9xxGv+Pfa2jUM5jHMO4lW7F3okpmU07IU+rYw/KruAfD8
         P4cTRIFJcNTuepdm+B47TPkq4LzRrnHMNlwDRubhucLlegYxltC8FVa2jm4K5p5Oex72
         12KjD6IUeBrDICQh5x8hzpYSHxM+8CTbFsMJJ1mu0Ka4rNl8rHVGUK3d+4StwzfmsiLE
         s/H7IUDnqCLZEWpuYu7Q+k7J9q8GB20kVKJoW8POejVugyRRi/uhsOYIP9nHaLqVfyIL
         xgQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069199; x=1795673999; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xoCndVwrvCSfCd0BaHKCqL9ELaacWGRyWSDCytAWBDI=;
        b=UT7r6HIMP8x6DmYZaQezLkvtfE9jNe8QAZNjoZ+BDLGzqxB4OhFh83dq2c2fciCrs0
         7fuwCWV8wQqIvxi9O3MUE0IR/oZMWHzvUTGYfc1aN+Z//8i+lhbV8PKSw89euW0ZQk+H
         8q5pGCTpngISoL3G/Cb+omZLqqhIVPdvAFuv6b2+g7FV5AWky6L+uVa71XJbPqKri9I1
         dZXoe+f8xzF4CDQJKfgEocHcqWxhEpQOfdD3u1P1GtLbiAv6i41ol3ck/rANGAfP9rnU
         Gug2I0Kyk+h0n1UkYk86LPFEZ1RNs0GugUbSr7SGaIIAhH6643rg0QYLZACAQp2am9Bp
         BvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069199; x=1795673999;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xoCndVwrvCSfCd0BaHKCqL9ELaacWGRyWSDCytAWBDI=;
        b=hWn8ni8WeEH0zBONT85rIwkt0OunLrI1mcE9+XvKdxcclZfwA9wRhn8iAHv8YggucT
         7Ni7MzpYrhNOL+8q2Ph/KkuJ5FIP6rCaPMcoqk6ll2FbJn+6/nhco0rb5suoBncEYai6
         hjvUexT6Kul68H6/+1BW9SzkoG605yx3CS1ROSq5Z/FfYEVEGsfK9OwbTQCFfm6eU5nH
         7mTxiHYhZb7ZepwQCGbZG8lo0SBia8OQ8OaoFzBtQilchIVKjb8S9Clv13h2WI2TStGA
         bwuFZiI2jiA3fwFVYeHKWmUNkKxChj709Ab0GVCpCJktLm+Z9bVlDU4dPRNi10rxma03
         cPag==
X-Gm-Message-State: APuU4Z9CjHoS9S7aPw/6zoYSbuQGZhbNuVjdwaqSc+2uHnkBZNmYlB8Y
	JNA75COARbbvs9qtFQYVclGklrI70pZCILO+9omL/EHIbBYPHPd5Oxpg5CWr6eXtmkCIc/GNYfy
	65U3GmXZuz4CjWm3eJEkAqdukBUhD01qu3unraix3zDkN
X-Gm-Gg: AZFdTZcDsGr5I0mG7Jsooy+f3hFHi8+OaeGf5ubvU8b4CSY4T7QWhThbtt8jTPfX7vH
	fQSHC7fv/AiuRw2wQXDzgnLRNb0/ELhEfMbJZOqK6uQeKZ2uWU49xKi7IPK+yNTnb5nr2/gD5p3
	EkD5W0bFFw53E7e84YKpgz1vhRapqrVTIXvAkMpZtmieDoGO6AsFsK8e0LzaMCYvQWkcnyCZJEk
	VfnxbSf+Df8YAcJO0BlRj/kI0pCwOwNf3jiP/6dTjvJeNMrT40b3yLYRtPo5OYhvb1M677iYKdX
	BdehWC85ZRWWwfCHGMEsO7U2o/xPRIYUoEbkUbkN1ziKXn3mgmCEBti7Olv+mLURihivpL2w/hI
	0Q46J1/u8KQBYM3cOUHFvmwXHsM+yJ1QIn6+E8VQk2xfRObN6qnl5tY55WyptT86LHUDpZaSlJY
	RblfACV88MF4alN7X+Mw==
X-Received: by 2002:a05:6214:21e3:b0:91c:7a3f:f548 with SMTP id
 6a1803df08f44-92114f7d496mr80145356d6.49.1795069198906; Wed, 18 Nov 2026
 22:19:58 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 01:19:46 -0500
X-Gm-Features: Aa3M54oxphJvWdfM-fUHq_7nMxHgG-ail465DDEoF5yzwUuPEfq0cOpWCDpLL0o
Message-ID: <CAMcAce-4z6mGO70Bb32quoTj0aRmVERxPKCfb2VpY_w3wHjaRQ@mail.gmail.com>
Subject: [PATCH bpf 1/3] bpf: Replace DECLARE_EVENT_CLASS names in raw_tp_null_args[]
To: bpf@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org, linux-nfs@vger.kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, ast@kernel.org, 
	daniel@iogearbox.net, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

btf_ctx_access() strips the "btf_trace_" prefix from attach_btf_id
and matches tname with strcmp(tname, raw_tp_null_args[i].func). Because
each attachable tracepoint typedef corresponds to a DEFINE_EVENT() name
rather than its DECLARE_EVENT_CLASS() template, three existing entries
in raw_tp_null_args[] never match any program:

  1. "nfs4_inode_callback_event" and "nfs4_inode_stateid_callback_event"
     are DECLARE_EVENT_CLASS templates in fs/nfs/nfs4trace.h whose
     DEFINE_EVENT instances are nfs4_cb_getattr (:1455) and
     nfs4_cb_recall (:1518). fs/nfs/callback_proc.c:50,106 pass literal
     NULL for arg 2 (const struct inode *inode), and TP_fast_assign
     (:1424, :1481) checks !IS_ERR_OR_NULL(inode). Keeping 0x200
     (0x2ULL << (2 * 4)) sets ptr_err_raw_tp = true so btf_ctx_access()
     assigns SCALAR_VALUE to ctx[2], rejecting any pointer dereference
     even under if (inode) and matching existing raw_tp_null_args[]
     0x2-nibble convention (0x300 yields the identical SCALAR_VALUE).

  2. "iptfs_ingress_postq_event" is the DECLARE_EVENT_CLASS template in
     net/xfrm/trace_iptfs.h:108 whose DEFINE_EVENT instances (:130-148)
     are iptfs_first_dequeue, iptfs_first_fragmenting,
     iptfs_first_final_fragment, and iptfs_first_toobig.
     net/xfrm/xfrm_iptfs.c:2025 and :2051 pass literal NULL for arg 3
     (struct iphdr *iph), requiring mask 0x1000 (PTR_MAYBE_NULL).

Replace these dead template names with their DEFINE_EVENT tracepoints.
Verified in QEMU on x86_64 7.4.0-rc3 (iptfs_first_{fragmenting,
final_fragment} and nfs4_cb_{getattr,recall} flip from LOADED to
REJECTED) and 6.12.118 (nfs4_cb_{getattr,recall} flip from LOADED to
REJECTED; iptfs_first_* absent in 6.12).

Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
Cc: stable@vger.kernel.org # 6.12+ (nfs4_cb_*)
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/bpf/btf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7e866bf..0044156 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7403,8 +7403,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  /* nfs4 */
  { "nfs4_setup_sequence", 0x1 },
  { "pnfs_update_layout", 0x10000 },
- { "nfs4_inode_callback_event", 0x200 },
- { "nfs4_inode_stateid_callback_event", 0x200 },
+ { "nfs4_cb_getattr", 0x200 },
+ { "nfs4_cb_recall", 0x200 },
  /* nfs from pnfs_layout_event */
  { "pnfs_mds_fallback_pg_init_read", 0x10000 },
  { "pnfs_mds_fallback_pg_init_write", 0x10000 },
@@ -7441,8 +7441,11 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "btree_path_free", 0x100 },
  /* hfi1_tx */
  { "hfi1_sdma_progress", 0x1000 },
- /* iptfs */
- { "iptfs_ingress_postq_event", 0x1000 },
+ /* iptfs from iptfs_ingress_postq_event */
+ { "iptfs_first_dequeue", 0x1000 },
+ { "iptfs_first_fragmenting", 0x1000 },
+ { "iptfs_first_final_fragment", 0x1000 },
+ { "iptfs_first_toobig", 0x1000 },
  /* neigh */
  { "neigh_update", 0x10 },
  /* snd_firewire_lib */
