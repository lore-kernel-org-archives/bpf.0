Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2B448550A
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519510; cv=none; b=DHwjxjJg1rk/OqzkcTSk9231e+519dXfRv90T+HlqVGpu+1jDSF7h3cTic8TIdnElQv7WwRmkAxDk/OjKa0MXKpqSxlniFIZZXF14TrPeZ2/ZI+j7Cr5iIPfdz5gMgvhgoFMog6nLttw5zLH5faIjjRTpiPq1vG7btcIgFGvAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519510; c=relaxed/simple;
	bh=H+kGce7/92IYW0gKybBpxBRi/udfoG7/CVl4D2Y1ngc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5A8+o4thK+KUZs1fABg4FqKx+LFokTg7frGOeGixabeithFHv+Q6QRdhIzZjskewxu7KDlDmtT/hcsrGRNIVFRCYGkwxnLDyBLqJBOa5azAIWfeAW2pmQdb74gjsPA6H0k5s6jZg+jeJRt71PhjisbGmfYdHLV/24MO7EkX/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOd6wcq1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOd6wcq1"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so1007344a91.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519503; x=1789124303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NWAG7DMfg3NZ1ICvfcjXG9Rse//LFFFDqYUZleB9Y+Q=;
        b=pOd6wcq1iEQHN/0uExc/kwWKSS4bhxAqfxWTPYvMUbFzfd7SD1X0S8VoCjE8zUwdIv
         gbtGSA5tskt8qYkKgZoD09KZ8nP7kNrsE36GbOPIeCCDFJhcCaTEJF2G4UtPPtranSwN
         3XwFdJjs0LW++Yjb/ZJhMtkpOFwTVyGdEBI5rKhvvVN5TQnXqAa0RDWOu4Uzw7kBigDe
         6aPntC7zXBikrJIAz/1wkx3hK4Bw01S+Nw9rci4YaKxnj1HOWpiY2BjEsWZS1Yjylbh3
         wkeEkDB5lq1qqhpICUkSYxOlRDo2S7FiR5A7M1KludEvcHHY/mI+P9x958khmNH6n1m4
         Tu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519503; x=1789124303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NWAG7DMfg3NZ1ICvfcjXG9Rse//LFFFDqYUZleB9Y+Q=;
        b=lPBaDWM1DyZNCqmZNMg69hjTEmffufhnsQMuQUciy1GAWXxwNgAxEO+2GM80tU+nwp
         mDLmiOjaeraOI61gBNPvdTrJzJUwR7BFHHvo/L+oAbxV2LVh+B8Geq/k7df/Gaa/mBpb
         eYb2WE1qV0FKDkVR7MxEN1XXu4yS7VOsoHAGrK1QrRVXg+vbd3hOcdu3dfyp/VolNZEX
         Rz37GqwVLd+9gqSDFiJfxH58s+TkwDYC2/rHuQsMBFdud5EVotovXgel/3ircFGzIeml
         90OwiFEDbtOAWrbBqP5rC8lbkdu0sbYYWyMarrZaETkQagoTidjlJvyZE5+KvXpLfaEV
         rDlw==
X-Forwarded-Encrypted: i=1; AKwUvBzwKPWua4U2clJCxKetlWLbbmmxP8ItbxzbDnXrX74TKMoQyXwqAEWZ7xXRQACM7L5/E7k=@vger.kernel.org
X-Gm-Message-State: AFuF++myQVIjnNLnoHdchqj2CHhIitxZ/7SLR7eEd/OZmAZ6hkyFk7Sw
	G4KqJtBNGrNpA3QTqDR2aIwG5HRMJPOpOCgFob07UOiMB9lDgRWAL+sJ
X-Gm-Gg: AYBFou0V/Zy3CK5qU7ixCAT5TXwW6bCHLDj8abODqZICjhzK0rfH/8sTyhsfCUYJlHK
	vWhtni2eZPT85nIr0lV5zRmQ4E1iMfbyb1fOmpI5IhoHAPSu5q/YXK2oes5Vhlcc+1I1zQFFFP7
	Ap2fZAtXYPIb9lM5AYpimkZaMS4/6TyoE5JP1HNdt3afD8JDfTnr0ctVXp/tF7fgt2eE5pBBh1L
	x1Hx6ZvwA4I6IUFOCpH2oMaZLkN+EEJ0blMTq3YALsY0sXxqJljbl79uEljwfNkEpazZV4+FTsN
	r1QyPf7H/BJD98wHl63FeYCOIesFFfwlqwl2ZBldU6rKadkrfCvbbbBi9pGa8wEKhi03Vi4L6SX
	AzR82+6cBtig/06H5o7+ukXD8GM5K7O73T9Na1c4ZXI+OS2I/NUpd7Dkh/ZC1Sh8c+omDpCUJ2i
	HGWxqBWtiiZVvcUzICWg8q1XJPh9uWBHuxegTG44/uDGygKMz8CtwuNpO/ULaRjCGU+j4e/ztPp
	MVXRApx4rNDlCM=
X-Received: by 2002:a17:90b:2687:b0:395:4290:46e0 with SMTP id 98e67ed59e1d1-39b2609f768mr8668883a91.5.1788519503367;
        Fri, 04 Sep 2026 03:58:23 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b123731sm5523091eec.18.2026.09.04.03.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:58:22 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 6/7] tools/lib: fix typos in comments
Date: Fri,  4 Sep 2026 16:27:36 +0530
Message-ID: <20260904105743.39799-7-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904105743.39799-1-hemanth.selam@gmail.com>
References: <20260904105743.39799-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/lib/bpf/btf.c  | 4 ++--
 tools/lib/bpf/usdt.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8417de92d028..c1745bee37c0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3843,7 +3843,7 @@ static int btf_dedup_remap_types(struct btf_dedup *d);
  * types, in general, can form graphs containing cycles, not just DAGs.
  *
  * While algorithm does deduplication, it also merges and resolves type
- * information (unless disabled throught `struct btf_opts`), whenever possible.
+ * information (unless disabled through `struct btf_opts`), whenever possible.
  * E.g., in the example above with two compilation units having partial type
  * information for structs `A` and `B`, the output of algorithm will emit
  * a single copy of each BTF type that describes structs `A`, `B`, and `S`
@@ -5644,7 +5644,7 @@ static int btf_dedup_resolve_fwds(struct btf_dedup *d)
  *
  * After we established for each type its corresponding canonical representative
  * type, we now can eliminate types that are not canonical and leave only
- * canonical ones layed out sequentially in memory by copying them over
+ * canonical ones laid out sequentially in memory by copying them over
  * duplicates. During compaction btf_dedup->hypot_map array is reused to store
  * a map from original type ID to a new compacted type ID, which will be used
  * during next phase to "fix up" type IDs, referenced from struct/union and
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 2e56e3ab5b6c..c0933580930b 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -144,7 +144,7 @@
  * about. This state has to be maintained per-BPF object and coordinate
  * between different USDT attachments within the same BPF object.
  *
- * Spec ID is the key in spec BPF map, value is the actual USDT spec layed out
+ * Spec ID is the key in spec BPF map, value is the actual USDT spec laid out
  * as struct usdt_spec. Each invocation of BPF program at runtime needs to
  * know its associated spec ID. It gets it either through BPF cookie, which
  * libbpf sets to spec ID during attach time, or, if kernel is too old to
-- 
2.48.1

