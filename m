Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795072843;
	b=4GIVdatXxuc7JZArYHaw/jAOs8t2e85MJVm39L62iEG4gTG+3VMcB5h+Mts9KeOarwjB
	 DvTVJaPZsQVzHmzJmT+5Bxy3SkVeKCRC/elknhLBnCuVtuNGaGLg909qHtXg5XcVPheTH
	 Hq5jMvPgPZ+o0DiM7211Usm9lZl9pB+k4H8S+ieYSIaUziqmTodeyxLiujY2BUnvs7HHZ
	 GZsPHcUYK9/IyUq729WIRyVNfLXMGef7N+rpY8vPOG4mFQhv8RB9r1a08Gh762BnLvhQE
	 +Mcl2895GG+sEy0DPL2qiCyYbRIe5GcdzS9LClr0DH7DxInNjrEAuqPuYaN7MrHcltQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=3lF3ame2k0Qlq5DDaiC3kZk755RYfgn7652S/tZaZ34=;
	b=rwLx49iBd1rEp2NwyZDUQLZ7+vawphHda2xtAmoSLPOMvZmTyrGbTAgpqk+IMQDdyfeT
	 +xGCIQygd37aruTY+sQpr7AsxBIWZpept7++jruXJTxw1y8ms8HkIaCX2RjGm0/QJxuUu
	 G75hZqzwVjaSYoUP1BrEkVD2dFtHCZtw1WsvKBBT3V0H6QAAcGAxxOK/z+LsB+KLq/Vxp
	 My05LToPTh6xrzAjSN0LIu9w9fId9gWgOj+qie+Qd1mxiHyIVJk4niidybXukK9zRdKzz
	 1O71KdWJlcmnxtJxLpgbR+sTpyptq9pFG1NkszOX0CDvY0H3zqmzE5FSnGuMHBCe2Ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Gf/6VXN6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29362606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 07:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29362606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gf/6VXN6
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-94961d90b79so262243085a.3
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 23:20:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795072842; cv=none;
        d=google.com; s=arc-20260327;
        b=NCSnnLLORyeLx3YEqCmHhHhh00Td2GIh9rNmEP4JO+GyvY2tb2aFrKC5UKZxRR3hZ4
         6vNrDOjfG2UTTGcjRqhMmfYMQ3jWIgrrh2fb9Tqs1bDSkHIgWCPbn5EzrrNcHIgyTgQa
         lvuurmsjTaj/XueqHRUmrvvL8klKp+rwDmHYLeTxcxqAte5uFPCQmh/OwITkirlsWtZO
         URsRHpT73V+SGyiYyDWD3nCe+cNUgmAagyCtE883YBp5iZKgO3F4G44it9c5H2Rhl1Vo
         ykIAXQ8QO93ZeQ1MRTGoiwm4+QGPT9gIxtn0w4q4CK4kFVj14yOvHptuD3vvK8tx6PP8
         USzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3lF3ame2k0Qlq5DDaiC3kZk755RYfgn7652S/tZaZ34=;
        fh=D5+yd6vJMUvfAp5gnUcHRvIopiYH+v7Nmcr5kof6lik=;
        b=TTt8/l/DQD4q4qXKR1fMlD3mHcewgBvz65hHWzr+ndFmVDHVAt7nXl7VkoLj1PwbDD
         k7OoRfkPDFnvDKR1Q9XeALeblZsV3Fv4E5fOiV8oc8VA1g+6R2R47RuGVHHltGYflRza
         Ht2cfn7Q3kZwREwYUvQvCNRKyyRfgOjREDaxGKQClO3uMNUDnUgAEfnDU3Uey0m/JKOr
         +4vKrVYoQdqTJNJ7dv2bzxVUulDjltHk7MRAt6LJBzj50eHMhpzylhXArR8skD/3aw3X
         5n6P8SL790X/8SqT5JYBszQMWK/MiuNDSyfZLGjD9apNJI1TkLE7Loa7WarGMbd4hPtl
         p16Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072842; x=1795677642; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lF3ame2k0Qlq5DDaiC3kZk755RYfgn7652S/tZaZ34=;
        b=Gf/6VXN6vKTfzF5IRK/PaOVmORNq5ZETohNcqZx/uOl4ChwjAVa8FOfjTrDEmgjZ7Q
         07IuhTNq3ucjzj/KdUxLJHCl3gGj3aIHrQRd2OU1xoMlCXqFIhbR1UgLIcb7ZKIF7+6V
         EmDMCSFCXq2d5xEkkQorr25I7QTF1mShKSPYfaVbAsEOVA2n3s66cAGOAnAEm6E0LNQ3
         DftjKttKMEBya8nsQHm+FuFxEvRt/VYmPPz07Fo7b3fmnFh255l+LJBKHaxonhY8wPgi
         o4DPJ/y5zHHheyow0GQyqyE0CqdL/TQcKcubv8ngSe084UYz3hTI0ijqfPRYHn85ztyW
         gKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072842; x=1795677642;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3lF3ame2k0Qlq5DDaiC3kZk755RYfgn7652S/tZaZ34=;
        b=LsjT4pWw4xOfFDojR3I2APz14YY3nlP2JhphADTb160sUgX5OBktKT1yqOu79Qlydr
         5LRPxFk6muys6sfI3ePlKQ2zhwH7Q0DAQRsLfGcwA38Z9E88J/hLwBtMaHgw9hhIauu8
         p+K1ok/qDMThuh/vEwbN18hpDnmCI/Ipnx8JLsIRkk0mIMhfw5Ruqoc53gG/BE0hLL8m
         zy4WQ99RyfPDRxxcOPGJXc68DAvWijYbWGSNt4s3e2n63fTzF2EOBeIAGf3RM1nlBUQp
         kBGAuzQRtiisjXnvBdhPEYwJvZHwHIW/Pssw5sUyLHjzY6RbmchawXAE2lPzQOwdGk7x
         y59w==
X-Gm-Message-State: APuU4Z8fRrBW5PTNHtI1qM4R8SsJyHkwE30Ta/G1zu0hzkn9AD2ifcgu
	Xs3zCJW7URaN7vbhCZnM4jYhOQiQYh1IaxESVHHUOugJW6HZI7NIn3epHU1bcJmcpAlRkCp35Xh
	b14KreBac30utom2aXoHgmuqeBRVQ3rX0AgpxVNLxnNj+
X-Gm-Gg: AZFdTZeavHVAf+FpzAuppjjrDmyqzyP+sC9xYRxEDlgYlbkqDx6Hx9ohfpFyTo2NTnz
	DdrWFAtTaiED0kBVDQ7e6wJ4zgTc7Vw9jm2izIB0x4rfkbVJQZRtstiRQmU3zU3p5qViGUOBD+N
	eEbKBF/YKqwxEtDWd6DBxDC032HK3AxYoGjRaMbtIWINnYbU/zivrZagZ3mjPHig76naOTRqFvl
	GeSEpL04rZik2nsljT/WQsGFcz+9wvoxRdtyqByl++ir+Ej03yp0tbpbEg9VJrSGMH1XLlQHzEH
	H+eiNeSs7tsG90A/6Th+QxTvPcrab1ISWxb+omVE263Z4ibJNynfOhWnrHB98PZ2oTi3X/iHQTk
	fyvsWlQ+jms+BB4Lod4ddgRrNfKRhAHI3ZV+XJgq0NIhIVvRlFRaMuyAJHv+Q9t5AhqASqqTj9B
	B+tog/s90ttpkxWsXOI4E=
X-Received: by 2002:a05:6214:4015:b0:91f:2135:3ade with SMTP id
 6a1803df08f44-92114e00a13mr83187596d6.22.1795072842111; Wed, 18 Nov 2026
 23:20:42 -0800 (PST)
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
Date: Thu, 19 Nov 2026 02:20:29 -0500
X-Gm-Features: Aa3M54q-mZ4P5PGu6GGOD9RruuTh8D4C8_LYaREl-xwIG6PxH9jKICc7mqXhR5w
Message-ID: <CAMcAce9XkYo7gPHMnmRX5EY2dNYO+ECuUF3RkPLnoGHgh8P7tw@mail.gmail.com>
Subject: [PATCH bpf v2 2/3] bpf: Fix missing raw_tp_null_args masks for NFS
 and pNFS
To: bpf@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org, linux-nfs@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Several NFS client and pNFS layout driver tracepoints pass literal NULL
or conditionally NULL pointers for struct inode, rpc_task, or struct
pnfs_layout_hdr:

  1. nfs4_xdr_badoperation (fs/nfs/nfs4xdr.c:981) passes NULL for arg 2
     (const struct rpc_task *task) when decoding compound replies outside
     RPC task context.
  2. nfs4_set_delegation (fs/nfs/delegation.c:380) passes NULL for arg 1
     (const struct inode *inode) when stateid refers to an unlinked file.
  3. pnfs_update_layout (fs/nfs/pnfs.c:1980) passes NULL for arg 4
     (const struct pnfs_layout_hdr *lo) during first-time allocation.

Add mask entries to raw_tp_null_args[] so the verifier marks these
arguments as PTR_MAYBE_NULL instead of assuming non-null pointers.
Verified on x86_64 7.4.0-rc3 and 6.12.118 LTS.

Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
v1 -> v2:
  - Correct sender identity and Signed-off-by with real legal name per DCO.
  - Remove drafting notes.
  - No functional code changes.

 kernel/bpf/btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b234567..c345678 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6607,6 +6607,9 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "fsnotify_bump_event_seq", 0x20 },
  { "nfs4_cb_getattr", 0x200 },
  { "nfs4_cb_recall", 0x200 },
+ { "nfs4_xdr_badoperation", 0x200 },
+ { "nfs4_set_delegation", 0x20 },
+ { "pnfs_update_layout", 0x1000 },
  { "nilfs2_transaction_entry", 0x4 },
  { "iptfs_first_dequeue", 0x1000 },
  { "iptfs_first_fragmenting", 0x1000 },
-- 
2.43.0
