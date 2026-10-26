Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983833;
	b=0m1Lgi5FrZhYby46qHFyaf2vf9mMykjwa6F2JEKSu6rYA+5O25F+ZejME1OqZbUApfm5
	 k5FbYnrz9hjeKyZFUxFbvDRAZFqxtHu5J2NzVOV5reDuuSKoNS4rchjGeddSgMc93ANSm
	 jM7wDZsb95Wke39nEYu3WirQCbjIV4FgyNwYUMLfmkckTa4yIuj1n4WKzr0ROE0NoAHLp
	 AYIIonTKk+B5QOI0rjnLaqu+QK6vTfUY0Hx0enG1LvWBZ/OmzMMu+5JIMr7TQpiKbRU95
	 2VxYGHanuCida9up0bBHdaVsNgrQbWyhE8V3eUuSALfIep5nesK7/oueJ2FaT+qTzfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M9IerTIsRhuyAoZKFkpZsTZatqR/8/M8tgwwPUFvyzs=;
	b=bfzBvsP2ebn+q7eHMIuCqEqetnoHD7h/VJOoSvzX8BT2yF0kieMKZSM9W2ibwQQQLrDw
	 IgmZxadI3C2/zfaHqaS207yBZyw2w3vJRCrfeu2IPF0eEMAKaXixd6Fk9wY4AUaLqH2s4
	 2QMaZauyopwuPgs0yPiMEeG/9KHm9Xw5z4TB2XydhkdQewx4Z99aILfcAW9nk6mVpEY6g
	 qVzybxdSE7dqKPwQshGFIMJMniMa/h1eFa+i+5UcQEVaNy5dZ9C5FH6+NwZoXEcqeXJBJ
	 zWhemLcHVaGReyxDrwKrHvn7zPoJI54hIb2t7OvSX5iZXKP5KjspQ+3/V4zDMrbdi5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G8H2mzp1;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB3606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06DB3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G8H2mzp1
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8b20a899fso14492165ad.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983832; x=1793588632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M9IerTIsRhuyAoZKFkpZsTZatqR/8/M8tgwwPUFvyzs=;
        b=G8H2mzp1C7art3JszEb391ZVZhHykEoaIbP4faiFz8v9FQwPZmCzkcjjzA8ICiL6np
         SJLdaa89IKEFmAW+tOfb3613pJSvz0EectnwSzBgP+JAPlA4k04nH15/aqrlwUwNh6lj
         yQmcKxLZTH8RDXXLEqt7zOjJifBtAqEQ+3v0k6c58DhOnIs0IwPF1JF9uPViej9tf9Su
         pJON/0GJRCDKUh9nci2alg3gRKE1USuBUrG+03cuESjV9j0+sG2SvnHfIi0LWPW47Uji
         t7zqjNalSZFO8nML17AQBEyN595BPlwu4CiKG6Jdjb8T2UqoYoCjFejArqRuryEUPd/9
         P6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983832; x=1793588632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M9IerTIsRhuyAoZKFkpZsTZatqR/8/M8tgwwPUFvyzs=;
        b=dLwUP7lsvP0xRtGbvtNL08cL4LYejH+CDWL5Ct+/d5TX30QEMmDdHd0CbSB8IrwRbV
         g0synapUrz8h0Fj9VdUlC64zKhPgEvETfranIsxG7JGFPUXv6coQ8hN2XMWdl0xinIql
         ae+sqTsMcP+K4BRB/j+lT3Uft031XkVWDR8Sj04yxUo2WNGeofrI2W+O27l6hjkbLg0V
         9El36BCUncVeKLaCOfLEAcWotG/SMsT7eCLOb2P1sDtq6y6mJMQ8S0lqaW5OK9Dfg4wo
         wGdB6tjAFsYqMGDrF850/X+TUmjK+5luEgfclXYscLk0avZteTcMLe+rQO0Egxw8RK4M
         jbrQ==
X-Gm-Message-State: AFq9FYK7ivLDyDK4AIhDtK+cJe56dXzIpcNuM3wUWK/SdLdQrsv1zQyN
	KbpD0pIsC15YkOB5ZfASyasaP2bEhpkE0humx3xCdLLbvM+FC1QX5kgJLokuxw==
X-Gm-Gg: AYBFou2YRyxcJKRYl7Fal2LQZRp5+8CM7hfgCcZMqr4Id3A99IGkn+wIQwCChvnNlv5
	0A4hWC45xqXy54gJQ1p9i6dapcismD0uznNWB5lDFkGVaa+OuAyBSkLgfAd1eCWJGoCzYp4b7yP
	joYa4AMH2TC/N09VVI+TOToklpx3tYGE55YwSLCZCdZVVMktRVJb2UgSiYiinXbllqSElQV8dAz
	x+BUinCMFPIJ5BSbxd+BIYTkR4Yi2am+hAxhS/zpdPJf6ZPibuXZS8oZlowIjjcFYWCezEP/h2p
	fMtdNWO+ksLaHBTcIniHzBaojP9DuK1a/kQ08RO8gOJoBNkkpzYogF3/uhe9o1H8JjuHRu/Vafp
	hWnPVtXFeFkQkSjb826V3AC1wv0FuJz+5pN9mHVvCtOKmcG1nwXOCb553ZdGOcBhXhvlI8q+g56
	9IVJYoreLYbk5tYneA52UwSkDC/iS6xdIOaoOkIE8aNlOEvgMlTWShcDzEJJI6YlvDOzuGxlmpJ
	SpD1KAGsj9gjx4qPTUqSgiicKAKmX9vnDjhMODuPGrFlpI6bv48rBZ/p7K93mmhmiah/FTzZzSN
	W9wt6Ca5dx+vgC2OXDG14APzmcDcZ8H/4Ij9epbR7CYkCtRTM3hyQafh8sh0UwxABFrFUGjybcg
	TMoAtCgE16Xo0wmeXj+fIZ0VZ
X-Received: by 2002:a17:903:2983:b0:2e9:cd03:b432 with SMTP id d9443c01a7336-2ea9c8fba40mr46036165ad.60.1792983832251;
        Sun, 25 Oct 2026 20:03:52 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1982d2sm11160915ad.41.2026.10.25.20.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:03:51 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 42/81] bpf: Allow BPF_MAX_SUBPROGS targets of a read from a table of functions
Date: Mon, 26 Oct 2026 02:59:03 +0000
Message-ID: <20261026025943.404450-43-alexei.starovoitov@gmail.com>
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

'tbl[i]()' loads a pointer from a table of functions in .rodata. When i is
not a constant, the verifier continues with one state for each pointer that
the load can give. It rejects a load that can give more than 64 pointers.

Rust needs more. In one prog of rust-bpf, fmt() of a trait object has 245
implementations.

The limit of 64 is arbitrary. Raise it to BPF_MAX_SUBPROGS. A table that
contains each function one time cannot have more entries. The array of
targets is now too large for the kernel stack, thus allocate it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f5aa77e4ecc..e179514c3b59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7104,7 +7104,7 @@ static void mark_reg_func_ptr(struct bpf_verifier_env *env, struct bpf_reg_state
 }
 
 /* a read from a table of functions branches into that many states at most */
-#define BPF_MAX_FUNC_PTR_TARGETS 64
+#define BPF_MAX_FUNC_PTR_TARGETS BPF_MAX_SUBPROGS
 /* and that many pointers at most are next to what is read at variable offset */
 #define BPF_MAX_FUNC_PTR_RANGE 4096
 
@@ -7150,17 +7150,20 @@ static int check_func_ptr_read(struct bpf_verifier_env *env, struct bpf_reg_stat
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_map *map = reg->map_ptr;
 	struct bpf_verifier_state *branch;
-	int subprog, targets[BPF_MAX_FUNC_PTR_TARGETS];
+	u16 *targets __free(kfree) = NULL;
 	struct bpf_func_ptr *ptrs;
 	u32 i, cnt, n = 0;
 	u64 o, lo, hi;
-	int err;
+	int err, subprog;
 
 	ptrs = bpf_map_range_func_ptrs(env, map, min_off, max_off - min_off + size, &cnt);
 	if (!ptrs)
 		return -ENOENT;
 	if (cnt > BPF_MAX_FUNC_PTR_RANGE)
 		goto overlap;
+	targets = kmalloc_array(BPF_MAX_FUNC_PTR_TARGETS, sizeof(*targets), GFP_KERNEL_ACCOUNT);
+	if (!targets)
+		return -ENOMEM;
 
 	for (i = 0; i < cnt; i++) {
 		/* the offsets at which the read overlaps with the pointer */
-- 
2.55.0

