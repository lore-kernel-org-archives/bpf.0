Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502320;
	b=3PUxg7omg1ZaXrPZU9Un91rNaVXjrlyweo5HLRR39OCgb0TQnFOFyDYgx8cUJgJMIHuu
	 5U7n3BL/zbUNBRTJ+IE/u93gLErsaow+RgV/8c1mwElCsmg4koPn4gV6js5YVrFZe53eR
	 8ud4Z5VMh8RF13O1tGn+ZrDg9yCg+AemIsvd9f/OXGDcZdA30TLhGsusH/wgvUpC9gC3u
	 jRc9KwgbLmJYxFD3k1Xf+DasWJg9UTBvcL+fmYbakV5Meytf4HtJJBoub5VdUTnX12D7A
	 R9T1X2A7asrZ9bP/w3rW5DEh2dcqcJAk1knIQhIm44FB2LASfIn+tow6qA0F3QXhdMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xmR1fTzPduma1h7eGEOnR+T2/uxtZcsNjvdFX9db6DA=;
	b=uMNOXWoVeMaUAnwF8PdZmcpgQmdQ6obPUWbCW2w/C+FvhZiNy7EV2tqTjwcjZK9iUdAF
	 5qZF5jyWi7D/3RAeEG9IwpvpOwBM0t6YEte8jshKHFnLASSSsFyI0rWi+tLahkliRsMWW
	 oUkpZL7XcnqC2REpwLAKqg3M4tFalkKDXm6hZ/cJo9wh4gr3UZrbDpbrIZpTPWuXPPV1v
	 hNwSq3pVtZk9nVW7yU+bKs+BdLafGMnVTZUvLxO1t4XGDcincd/EMlFVUFs64nREcwAB7
	 ghBCf4n5qxG37aquZ3w6l9T3JssYKbxs7p1coTOmmDVCDgYrJxkT53Zj1xelQl9+Wmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MaeXrmhb;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6D606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE6D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MaeXrmhb
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso1183394a91.3
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502319; x=1794107119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xmR1fTzPduma1h7eGEOnR+T2/uxtZcsNjvdFX9db6DA=;
        b=MaeXrmhblkQM0EaAaLQdMvKg9VACtcDfPH2Nd8Lx5CIZJnDjgoix60fmSvHcUFL8wD
         9yDK4W0s8WrSC9+SAnWp8r5zgYpwpdNXDw+1p2yyEo3vQmfV0Bj0Km6Upho5qt9gT98j
         VBsPQAfYkgKlXQ4XqXzTCkbOF/iSlsMokrXzSZFjL2vTo5be3hvm/SrBCgv66RTKK1yF
         +6CO3TAfZ1lQo31/cpzC7ekiWZgcfacmI8GmMW+37DAAxT3BZJsnkvU7tfFqbXNk2N/7
         p3bRMcZWN7U/2mDNNaZAalpCeUgXwtZCWJy9bEGY71AV/TvDznN1l/k7lrJRjxG6CQOS
         xw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502319; x=1794107119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xmR1fTzPduma1h7eGEOnR+T2/uxtZcsNjvdFX9db6DA=;
        b=jsKa6ACXW1uqNOjAXUErqktaptfuQdGFAt4f3tB0qy9j2JPP4FOyACgiyhtbStsK9Q
         W+S/1t7LBVVnXQcGpSEBl7cXMpwWHPJdxidwM1oxwB7EJgvtIYbDf8G1zu0HGQRnl30N
         Vm7O01iC7cgzEHyb/+sgRiGXzCRVV+K0ssvF2zKslpBF4L+MCKc/Rs3OK7h40EGwWyDO
         B4DtPImHNFvtn+0GT3GSkMkViqMVEeSWEyGE6K6Lh7qhnGkqtchUeBLkopcwm0KYzSPC
         dNqaigpj2tob5wxecKfRPy6touFzKAMh/MtZkX2b2OT/fHw6XzlXmW/ePKIfi4NZ+EG5
         4oTA==
X-Gm-Message-State: APuU4Z9hBmZvyMW/AJzlSTH0by5Mky/dNjaUM/k9h5puoYtKyPbjt7X4
	yO7AiL9DHsHph8pJwX1+1kr/yRsirhH+007S55i8Doy7NeqgJJh0nHXVhuyRbw==
X-Gm-Gg: AYBFou1u7o4uiEACNvwXnYxnOWz+bJQFikIA0hGuqAE7LmrviDzGEA8iAkC35g1iX8m
	m9ANB4k5exPbrkHF7JS1WeOGkGQxFH+axibcUidBrt28vMEU/Vi3RvH7idDPWglHnfpQX1IfeGc
	i+6FE0uuFCsARCDINo+nGV0dH+pm6eQ9TwQmMhCdxma/fL5W+9cBzAaNtlM9/kTAnMZTYA0jV5N
	ADqnRHk3/9nnshlCEcr/LfjHfx99EoFVL0zmTzpNdcFtD1//x/JpOLhepThOVeL98J4QBcVjVZ9
	Z9PBU96YeYlyVuKhTsX2yxsboD7NMPDMk9BIKt4bAh66VhPqINCnjAHqtck5j9BtIbgJVlF2wbQ
	TGBA+UrqVE1tIse5m35GN6wZnBG6vtrXrDoZTDlJoXM7/zQNzjuni1I3ub8End9B8aPMxG9wWHT
	cVC0FuriexpFNTOTAaUyZg3PFRENK63KcTOOneU41hpr7OK0eJ7HwBBVTe5w/TZe/6Oi0Gt2UuO
	I6ZscvBBgaA6g8V1p97ybKsk6P1/dqeNa8SC4NYzAqInJSf1s1LdXnuBYYv19WMX47R+SuwRnWj
	LLfuMC//CQ27s+rDi4vmRyCd2QIy17OqXycWguJR7KKWlPonxEeac7x4vvbyLq2m+JJUQaboiPV
	fi+rZ3RwJj4Y+nnzJWb3vANl30w6Zb3IfqIT2N4yFRxjMpy8RJCMz6xKP9BQYrNgeE7pWX8tNpI
	wWwg4o3u17gSr0KWskKas=
X-Received: by 2002:a17:90b:1a88:b0:3ae:3f20:7056 with SMTP id 98e67ed59e1d1-3ae89746c9cmr6016548a91.31.1793502318647;
        Sat, 31 Oct 2026 20:05:18 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85e4ff4csm5519097a91.1.2026.10.31.20.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:05:18 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 01/14] libbpf: Make arena 4 Gbyte when max_entries is not set
Date: Sun,  1 Nov 2026 03:04:57 +0000
Message-ID: <20261101030511.1578690-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
References: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
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

The default is in libbpf and not in the kernel, because it is easier to
change there. For example, a smaller default can be better when the kernel
allocates page tables only for the pages that an arena can have.

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

