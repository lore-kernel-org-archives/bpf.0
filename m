Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795072725;
	b=l8tsefQQBrN1x3YKXJ7DJ5Pg5o7rL6pPTTwtyENzTVXc5PNOTVtSiPY2bN+5KM+0liHh
	 YInUEWdiHsntlcSAnRImQ7W0TfGhWbFgLxHF+J0MECJXYTVRNr3g4ycrs0wd1X5gQAGZS
	 JaHs/8wGRm4xFAM9ha3rW4U4xxjnEmCwCXn3pPj85I+emCIoFIHBDjMYVIi2KQ6XGfLqe
	 ZUfSLl4NpnEWIEjS3Zk4Fa+MmG5eogxz0GMJk65Jx7VLxGtNiZA3DHphLXmRzs+DlGQGn
	 57TRQ7bJY37y1U0jxK6j62tBGAaxsKB4JewAzKdSAEEtZ3Fi/K4O2jh6+MfLMjacttw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=NsJb7bPA9D+bcQDpZCNr8K9FWLxPII4RzY6xFEDpZMg=;
	b=sBuNHVHUF0vIeC36KlG8navw/RtDSdz4MF/RDbJMbfJdprIzzP+tKqRHn5h7PC5UVhGp
	 s23Fjp6fA5nMmz5dC5Vj80V7BnRRV0xhbD4t6TwvQkFd35bBGUtRSjGScLYKiRQKO1+1T
	 0Hnx5EtLnX603yV7Hzow0Nsx7D0wdiBeTOYWRMWDmK8Fq7111vXtrOJjwaw05MacVR5Zu
	 mIcmbQ0FdV/lsLxuAxWIBroMPlIYwesvaaFHfpVZRR4JOOH3Va6W+9d0Eojgske2aumqR
	 uXyowdBOZb3/RDVOIfrMPpAyKWKb/Gwgno/4Aat3AOfNyoz6kNMM94ArxWZnDA+2L7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KphD5oCr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC85606A324
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 07:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADC85606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KphD5oCr
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91f0b9f0b1cso18667216d6.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 23:18:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795072724; cv=none;
        d=google.com; s=arc-20260327;
        b=GLPQ3Nh5Ts2O6Xiq1Ou5dz6kQpeVK0C2QFQQAClhlKTNU5hgpp3YrAsGRjDrdpTl9W
         5AexCTsmA+xlG2Vgw17uE0voKOUlYPLrTHqjFQs6kIrtG8uapY2y/b57tK9lAkJrFIuD
         2lCXtQvB5KEzXWJr/EvZFWJHCXm/ONRg01t8DCSOsKrSsWq1MWRzuXAWlwiFwEHFRONw
         4qfmO2Gk/U+Q4xglhZE8WfScbITuu8oGuI1jOq38HU+GN5HkIPQmtgAXmOyDjBySa67+
         32yAsQMvAG6kYJWd3NqO+YUQca1V5CbaMPsuqWj2eXYtfyolSt4BbZI40Lppshi5Fero
         CHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NsJb7bPA9D+bcQDpZCNr8K9FWLxPII4RzY6xFEDpZMg=;
        fh=BH+vjRqLy0Rt9OcZjrFKDmwOgbUiWVM1Q9yiJOPqgxw=;
        b=LEZcObc/EL7ibML2sMRRzys0VofCYPj2x0s2zGnb7JlyYQVDYJru4WCUF9vljDEk+G
         6czMu6THgFhNyQM1IQHIin2IGWxOVjEALP/TnAv4ttKup47nqAUPXSKVi3x96/hCxk73
         SOBEcRv5jN0NNN/jAaZk6N8QuRyawJQy0Gg/djTLEvH5hub8kgP/M4uWkao4O8/JrRKB
         TAqHgQj3lBuoBueK8wtFOV4Hj28XpB1KheSQQyYKgQJVqbxnFtkhupLOo51qUprEPmlw
         IxgBJ+/PyZnomllAVG2Pf7ygmmi6k3F+UWW2vkR42j483EDuK7XnVpL3fBB0UkHZA7Gt
         hRmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072724; x=1795677524; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NsJb7bPA9D+bcQDpZCNr8K9FWLxPII4RzY6xFEDpZMg=;
        b=KphD5oCrMuV3XxBZ/4Uo8wpR1VqAMYTe1d6PYhEfk8Z2AjS8RTVh5JTsTOTbDJHXdt
         cvS6Wxl+Fa3mNTKQv603ZqlDs9gJC+cPKU8GUYrrNyGbQbSKMlVwr5lrso0p+qTAtkeV
         2mSS46hBY2MoSsvnwHBpVlxtaJ9DouL8x1psaWlgaIVGTZMi14CSdhaTTiZE8hRY43jQ
         jx0GNs+SUl5UwU+O6//4zxQCtrGtZQ8bFZ4A3phgpUrXl9wFc6Utf7X2UdW+WiqXytzD
         CCuQVotSJzBtHOHwK/X90C9c2qT5NInZ8SARaLOzqkNgTdikr9WEcUD/L8GLAYV9b5Ml
         +XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072724; x=1795677524;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NsJb7bPA9D+bcQDpZCNr8K9FWLxPII4RzY6xFEDpZMg=;
        b=c9Ddy/M7LyV9k9bE3xJ1FkN1i+tkaloppUM7UtV2Lg9I8IaE96xziOvGWkVVDBrXe8
         +cYtCrsP8haPZkgde0p3XoazZZv3QBULKZ7J7P1ZE0fM0xq5E0inoYVF8BUSZKiS+tkU
         YDczYJ1A241UJ4TqIMxacl69X2JV+8p7RotsI2yt5ui3+kFsMSdUaWvH8AEXR4kisxp4
         Ec7kRLVMw63WBasQMyOuzLRkobDMww4j37TJaHmkbwkD9Kl9JiOhw1Z1QeqUTVjqGtwv
         HINgBp7vOMhL9VLEQx5uL1w8cOYS+Y8d8Jxi6Z0DYEjuGqN68WlV2nsXRXBYsrG7NZzx
         w0Yg==
X-Gm-Message-State: APuU4Z9JpiU60FGdWnQRVyhnnt/6eyeNVueywACTkcDN5uSRxXXITlKQ
	F998juFs9TJ+TTHfhw0xpkiVujiK8OZD8XnTK7Y5RKL12vlqfts6LQ15aiZqL1piICz//fLcK3d
	TWaSF7nqPhIzNNayU5YZ8TTiKD+cxBMIxpDfvMhrbszF1
X-Gm-Gg: AZFdTZdd8OFiGkidVL8503fzIZhF1r2f5j2QiSRqoVYGpLgmWJYcBh92rSD1lBp1GxW
	tMMbitrIhdTMB38xdzeF7CT/JHIpeKk/DJGrFyCP7+yvWJ1/z4UA2H1BOXVI1t7sYdVpb9a34uJ
	MpWgVK1h/KxMF7+3jVvLV2Xv8Nw28vacp/seoxVuNnq9iqXppvaeJ/TQ54b5fadT5cak26X4WsC
	C166Z2X2+H+TosNbSJWLy5ApGN7RbCWqSTiS7uHxzzLDrGoK9SFIQSHjYElFOtA15N9lRmbUubI
	ZDPYf751sx3C59FfhuHkvjm/02uLn22ngc9VND0qf585Ct2ZLDS0LUukARdjWG/ML4Lvlww32yl
	6dd55c9wChDcKbNBvHncB8CYdduqaiXpxwbhr0al4AbefySR90uiLf9eddnxOEJwPhtBlYqALeK
	CntKlzOKL1QzOz4H/QqA==
X-Received: by 2002:a05:6214:2484:b0:91f:10b6:2743 with SMTP id
 6a1803df08f44-92114f68851mr74072936d6.36.1795072723595; Wed, 18 Nov 2026
 23:18:43 -0800 (PST)
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
Date: Thu, 19 Nov 2026 02:18:29 -0500
X-Gm-Features: Aa3M54pxDoYxauvJoi_1hEHlnijhpNFabeXJ38e3q8jAEIPpcdRwokeVm9U0kZs
Message-ID: <CAMcAce-ytH2Xt_0+1fKXzxy+a8fi0Md-4SSoLZ1RQxKQoLq-tw@mail.gmail.com>
Subject: [PATCH bpf v2 1/3] bpf: Replace DECLARE_EVENT_CLASS names in raw_tp_null_args[]
To: bpf@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org, linux-nfs@vger.kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, stable@vger.kernel.org
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
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
v1 -> v2:
  - Correct sender identity and Signed-off-by with real legal name per DCO.
  - Remove drafting notes.
  - No functional code changes.

 kernel/bpf/btf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a123456..b234567 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6605,10 +6605,13 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "bcache_journal_entry_close", 0x20 },
  { "bch2_journal_entry_close", 0x20 },
  { "fsnotify_bump_event_seq", 0x20 },
- { "nfs4_inode_callback_event", 0x200 },
- { "nfs4_inode_stateid_callback_event", 0x200 },
+ { "nfs4_cb_getattr", 0x200 },
+ { "nfs4_cb_recall", 0x200 },
  { "nilfs2_transaction_entry", 0x4 },
- { "iptfs_ingress_postq_event", 0x1000 },
+ { "iptfs_first_dequeue", 0x1000 },
+ { "iptfs_first_fragmenting", 0x1000 },
+ { "iptfs_first_final_fragment", 0x1000 },
+ { "iptfs_first_toobig", 0x1000 },
 };

 static bool is_raw_tp_null_arg(const struct bpf_raw_tp_null_args *entry,
-- 
2.43.0
