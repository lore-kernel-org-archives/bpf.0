Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755450;
	b=cikzoXPpjhE6kIMgqE8JpdvXEKNwGut5KBIBn6+/tyoTxTsXUfUZx7zHVNwl4Wai7LOA
	 Y88aQKw5lLEJHOh+SG/BJDSqH8e3eK8o/tGqWF4gg5msNgv8zll+MS5z+g+ed9/V978me
	 lUp4QPWLx2JpPgpaCnh+QcL8GwWokt1TE4I9W+STuVSgSATcGMfrS46ieEgpws44xNlkD
	 IJF19tJlytIYF/HR1sNC4crt38lwxme1qLy49DXgBCrW6g3v7PN3m56POSkdSJXpOCIsx
	 FRDbWXDfRphAYtGyUr+8p2daCCbLw/9frzOyQ2mhA/2jUidN1APqFuVHfyeDR4cti0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J0YyvRP12zwM07GeokY3R8XZVav3TgqgAeE9pvObTMM=;
	b=r5juRv5tcnAfVSKm/ijYRe61rUJsX0AruUzmGiVNjs+1gLc6HHFdLb3fPy5h14TIivyb
	 EJDC602/Bj0pd6sBA8Hw9cqZgO8L+Peu1zqOxvSRojUag7uiCa30wzxr9qlLaSZGyRiT6
	 eytUENq4nfsnUHW5CHaWCR2DZ1fDVusNJqXf7pxHlS2rH9fd5H3hB4P9xtcL4fJH7jiin
	 CxeXsJUpIjEW8czt1f2BaLL27J5AVrs1MQErZpGo/qDVltfxzb27lNFBRtJ9P9jU0fN/Y
	 P0zJnBK8OEWb1EhN2UfDT8LBYKeIjjIFYB1i1eyNjMIAFlMQTNzplr/tx7sE93rEseg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KVV/ijWM";
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B08606A331
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04B08606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KVV/ijWM
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so36770b3a.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755449; x=1794360249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J0YyvRP12zwM07GeokY3R8XZVav3TgqgAeE9pvObTMM=;
        b=KVV/ijWMR3RE257Zkl0wT51eKQNk1b61mdi5LFg/08xh4PASQGa8hhr62lXau5dcVX
         u3v7eB/UuMcT2/aVeEaCzd+u38nze8mW2FDb1wFeOn5KbzMl/zzFeFn4S5uKFq4TzDnC
         xsA2wF0ZkIbWB484VzFp/89k+McQVrNglin0i/QdFPTJK2JOAuqGQfsk3aCQUov6+peG
         KAfX5tPjcT4Vn2iLx0px1ImRHhFmPI8Qy62S3VEPYngn21O77YfVBORZB1ZFSiKje1g3
         aGtCqdSy3b8bghG6m2ppO8Y9K7UAOA52D+qrSYGhxc7+2dMCkQHtMm0xGWt+mOwfRSSk
         NXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755449; x=1794360249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J0YyvRP12zwM07GeokY3R8XZVav3TgqgAeE9pvObTMM=;
        b=pmyVaGaw+aWM9JIqUQfoW5rIZVmJcbdKx28TWlDvbvxoOiqidUPgwfDCG2NxSvAqhW
         opX1GvN7+e4yQ5W1Xo6tzPzY7aYp6KcaG75BA+S0DFiPjP/rEKRimtpgI8o5OK2YMnlm
         Zpra3Lz5/E8U8Ar/0k6Mr3pvAVxwXvXQrTJoy3g2R/TMh/+03zrT4KaqqhNtKY3I37zd
         CAQ/5ANwuhPIVznUUqAYjZOq/hbkDAdN5oa3kmIMvPPHPkrX81WodASRYwg3/bFqXt1W
         7a1mIL8WK8aM3j3WU/eU2ZEVjpbFbwgIKTaLQRcA/OwOWyEFQLhTDGPeN1/LJ7ezrIkW
         rYnA==
X-Gm-Message-State: APuU4Z/LOU4hpE5WMdw06bIVJrBH94MT+uB5NZJyUUIvharZGw2kHftQ
	RSqVItjnWpPKgve/j41Xdub9oVWRTTq4IZPcuLTCFgv7JyTK+DuKwgvH5JgL7w==
X-Gm-Gg: AYBFou2qDIZgWVN3NpqK1OSlkaQpOd3D/KlU4/qxymDdPDhdqiDK7E3s+Y7fuaDE+sl
	NKVZOhvC/GIgDVvWCRGXVmzOpKzC7sVPAdwYZi8C4Ym/eOIwMQvsGorCa41svd8fRUqN//EmTpy
	8o3VFTXra/oEv5AVIqRPJENNpiFGQFpFIOtLxkEs/YtU1hwl6jmll9ruRPX1mDGKfrui/6oiRxE
	vvPLGXpCJfgk1Bdgffqh7Nm9rleYDj/livZlHruKSVmRXWp6VAXq6hOtjNoexQg6NbbrE32pR76
	x1OWjVtZjvXx2fOjISf4L+CdpUb18ozOp9UJSV+JhEh8A9neyU6mXGQ7YbEC7wUBq/jgsPxPGjZ
	ZXyN2RkyqcN3JuR/OSFb6SVJyvVXqxyRV5xVzvXG5/86iovqemx7f/rbhakP29MdpI1kQ3dT7s5
	YiH25r4ppL2S+Ofx3ILmX8wBEgccJuUwFo4w15xZZ/QE0FImda6hybwdHEzuMeKzEcI3yNqFfMN
	vwgPUDv9pO0Hx1NCjjPcCyTgOVKSuFSqiDRhL2I2qDWC3DyeBnk+ig/KC7yvUi3PwMqOYJ4jI9g
	ruJITZiBkVGKpbLv5HhT+bRgn9iYBMSho40N2JJWWU/yzz04gdk9vdstTBg6Yk9sQNaWa3Io/Fo
	IYy+sGeGes/wlzQxkpR5wpCfV1arcQXDwXKWlMnzx4SWNjgyO6P7wMjEs3H7lRnpUK1bJEq62Tw
	==
X-Received: by 2002:a05:6a00:e86:b0:886:490b:f1d2 with SMTP id d2e1a72fcca58-8a9bf1489f7mr9131430b3a.23.1793755449168;
        Tue, 03 Nov 2026 17:24:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09bc405d8sm205744b3a.52.2026.11.03.17.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:24:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 01/14] libbpf: Make arena 4 Gbyte when max_entries is not set
Date: Wed,  4 Nov 2026 01:23:47 +0000
Message-ID: <20261104012401.1354861-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
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

max_entries of an arena is its size in pages. The kernel rejects 0. Thus
each prog must select a number, and the same number is a different size on
a kernel with a different page size.

A small arena is not cheaper than a large one. For each arena the kernel
reserves 4 Gbyte of kernel addresses and allocates the page tables for all
of them: 8 Mbyte with pages of 4 Kbyte. max_entries changes neither. After
that only allocated pages use memory.

When max_entries is not set, make the arena 4 Gbyte, which is the maximum.
libbpf calculates max_entries from the page size.

The default is in libbpf. There it also works on the kernels that reject 0,
and it is easier to change. For example, a smaller default can be better
when the kernel allocates page tables only for the pages that an arena can
have. A kernel that accepts 0 is a separate change. libbpf needs the
default with it too.

libbpf maps the full arena into the process that loads the object. Thus
VmSize of this process grows by 4 Gbyte. If the process called
mlockall(MCL_FUTURE), the kernel populates all these pages.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 02e75b183ed0..76d22a739e00 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -552,6 +552,12 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+/*
+ * The size of the arena map when max_entries is not set: the largest one.
+ * It's in bytes: max_entries of arena is in pages and the size of a page
+ * depends on the kernel. What an empty arena costs doesn't depend on its size.
+ */
+#define ARENA_DEFAULT_SZ (1ULL << 32)
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -3165,6 +3171,8 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 			return -EINVAL;
 		}
 		obj->arena_map_idx = i;
+		if (!map->def.max_entries)
+			map->def.max_entries = ARENA_DEFAULT_SZ / sysconf(_SC_PAGE_SIZE);
 
 		if (obj->efile.arena_data) {
 			err = init_arena_map_data(obj, map, obj->efile.arena_data->d_buf,
-- 
2.55.0

