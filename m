Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983682;
	b=wzhBLjvlH+VD8idByKZcdK+ybKNNFGkRgS87APjq079Ca9DOHNIVegVE364t2IotBnP1
	 3M1XDmrHSeC8u3l6xk3/grs1KAxUQK0uEEo47FMnIAE2MedIiX6I9q7pEhou6AYpgt2gt
	 EgVcipqEAoVy7U9F3PeE+pRBFCaepJUR/d7PRTDikgGOBvFWyIdK2JdOhR7WFFOcacLPt
	 ymGH6MGaUTSVlpUL1yDW2vOKI1ReSKEhFVkP9WL7ZIU7YAcifzDBfmgt5jZsefT/eE8N3
	 H1ZB+P2GOYvGP4EwPTOucj1quabKs4Z4Kx+JQRyccQq2inflYLdDFaMySYOdJZzoxmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EaZnlNNY/6YsTRatBLZkhxEvMGlEZmK9MpEM2ZrpRWU=;
	b=1RmRja/K1HCOuuyxGwO5jvELkC19iktUFzfioGW8sPd43UDLER95kj6kx0AzEtgm2NEk
	 MYZrR9+D+cQ/+jGJwYP5wCt2MBIFiy1tkuRGiFdRZTafXIx/cTd8dKQGlmuU2LNeYRjhI
	 DKvLuOERhWa4DGvOvekErE7eF5EqGNFggVrfcWvHYjEKsTYB1P2GZhHpP8Xqgr9m76use
	 9E1pjHzFyOM4/j37UGVtLywVjFfdJr4D9lsiCgAYaS8QIDbB+hLEDOQdexN6xK4ckNLi/
	 EsAUl/YHVPXBSfhq94zY2ysu4hnTQ57JSaC4bcG0W6JpS8aPvGu3XAIlD884zPDMHuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sSTodq5P;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2962606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2962606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sSTodq5P
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc751eddf25so1223842a12.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983681; x=1793588481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EaZnlNNY/6YsTRatBLZkhxEvMGlEZmK9MpEM2ZrpRWU=;
        b=sSTodq5P1BpQFqQHuEqxa0nTnI2VoqxSKUslDFVMUoXZnPsaOy6FluH7s8pp/H7GpA
         VKGGzIdCKJ/cVz9et98z1x1VZxx5NXolHWer0g8ZtmaTEzBw9TzbjHb7pD2JdgzLgtBV
         D4D4aZBCeQ6JfsF8KaH+lK/yLMOGFs3DU6Ztsd+NaXTGUOUY1CpP76vAkPlIWw0f94bz
         zMesieuJNpOh8nkgxldqC4mXE+Kr56fDQ4C7uk9RVubZ+m6iEMenHGIbUiVcSF1KRZmN
         oah/KNfx9Qx632D6Y4QTeWjYrQDZSiccD1VqZVZPyaIVvggEycWJE36ikBowl8ARPdWC
         ajsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983681; x=1793588481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EaZnlNNY/6YsTRatBLZkhxEvMGlEZmK9MpEM2ZrpRWU=;
        b=Q1EBPyqE5y2PEc1ErtJoVNfhIn1mQQxCSxsk1T5DpG8+rtCjzBYissz71tKF4gCOg/
         g1PTM6iyR1CyZi//d3upUUuqccpqPcK184ouX0wAr9sfZHGouWESA0qVHlr7mo/Rk1FF
         SEK68ZpBuqyVdNPaYbJkpFrYpko+LRd5u+fZ9Yk8F2T6GcLTlwQbOtH58aVX6a2C9OnW
         Ft87vte7DqwhQowY60qS5P8lPmKBINk4pRZQRCyMx22CTkjIPxhHcKm2zeEnxCgemNa8
         PEO90ZOKl+CUVGYXabFemL8UY7BuK/HWg3UihMKwzzNiVn7J/sSSc10E0BNIJ4+8ULZL
         WJaQ==
X-Gm-Message-State: AFq9FYLh/g6F3XYByIWBEuExHL7nTbVmbTAqm8iY3iILpYibsJn5jVCf
	6bqyLfI+btc9FEDwESe8sCwKankozKmNu80AOis2ggTPXuY2BVhH6xtw15ZouA==
X-Gm-Gg: AYBFou2I0b+tZc95/Y3gWwM0isC727z3BPvYo5zP93VOdn8+HIRIZkt1xypsy5UmdRm
	+iES7m0LuscFxc+oGmKCtKMPgp6rAw+flp8qGmitEkSXd9Rm411LeEyEE2qEreYTRIlJLA3pu4E
	VQp8MF+mSvuOYuxW2KpxqTME6O0W2ukZ944Ic27PApBnd7PwWRJw9Q+Tkhw4Cm07sEct6ULDSCg
	1qy5wwLBfCX9pwNnDJexbWqkZ7Fp9I7eYwRz8ryYdhxM0FdzUblJyt+v4ZwLRkzOmOfYZuzosjT
	VN1Kd/KiTgfCzQBXMfURnP0AgZ/1sl8LqM5UG2pCz0717cV1NMcL95cy+ZD95R86Sw8UDFeoQ3U
	9qd6zXYLMC6Wb/dTJmTBB2JwdkMO7D6Hv5LVG7ee7JB1sZvUFwPzjaqjrl6LBfPBzrcaI8ocO0r
	MoDKOFVSHoXLmPmvMY7Mn2utK2Ec8cPTeGfzeHp+zWFlmVxUGA1eTsHSuJZw8eMI/iueGMElsT3
	UXLnoATVhq5C9/HSyDG/e/d5ChEA94IWYA3ogQJlgeNuao2FYKZ7en+Nmht/5Qdtj04BWa/mRx8
	24VEVWOhZFa8TzuSIvKUM7oCTm8uoHuvN3+MzDH7JQDGGKUsrqjKABh33WUzzl9ccyABG46yaX8
	31EggnOrRpyaxw+6oRC3NdwpU
X-Received: by 2002:a17:90b:51cf:b0:3ac:b7b9:6471 with SMTP id 98e67ed59e1d1-3adeb105a0amr4764971a91.65.1792983680721;
        Sun, 25 Oct 2026 20:01:20 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfa82sm6352325a91.8.2026.10.25.20.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:01:20 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 16/81] libbpf: Make arena 1 Gbyte when max_entries is not set
Date: Mon, 26 Oct 2026 02:58:37 +0000
Message-ID: <20261026025943.404450-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

A large arena has almost no cost. The kernel reserves 4 Gbyte of kernel
addresses for each arena, small or large. Only allocated pages use memory.

When max_entries is not set, make the arena 1 Gbyte. libbpf calculates
max_entries from the page size.

libbpf maps the full arena into the process that loads the object. Thus
VmSize of this process grows by 1 Gbyte. If the process called
mlockall(MCL_FUTURE), the kernel populates all these pages.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fb8a1f07c5b6..1d4f04aa35f1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -552,6 +552,12 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+/*
+ * The size of the arena map when max_entries is not set. It's in bytes:
+ * max_entries of arena is in pages and the size of a page depends on
+ * the kernel. Only the pages that are allocated take memory.
+ */
+#define ARENA_DEFAULT_SZ ((size_t)1 << 30)
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -3148,6 +3154,8 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 			return -EINVAL;
 		}
 		obj->arena_map_idx = i;
+		if (!map->def.max_entries)
+			map->def.max_entries = ARENA_DEFAULT_SZ / sysconf(_SC_PAGE_SIZE);
 
 		if (obj->efile.arena_data) {
 			err = init_arena_map_data(obj, map, obj->efile.arena_data->d_buf,
-- 
2.55.0

