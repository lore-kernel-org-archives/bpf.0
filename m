Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84336F433
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846599; cv=none; b=LccHsL0OaOqTCBKXfCAaLq1arCL+RdyfufEvKO3XQn2Xr5y0ZVdKRQVBB35SbsRueFUt7TntX/qMTi4t879I+NJvUpKGExY8kr45a783fr6pXOOKMbAo0zbJPEOjedvIX7cUndHsexAEyyP5wFjFYJ71KHC4UFiY9okt7MyF+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846599; c=relaxed/simple;
	bh=4mTYBHO1BKwVo359O7O1oHBYX8lTCqfUYOiXLv1KYeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxek7TOZBr1of24DvlZkmr4JGzQAvf/kQ5L3ix6yBzRojoPwlcvynoHk9EcGMzEcu5iBt/PnUKDgOvxVS3seS0Q3jkjkPilfG22FK1JknewFMkqlJoc3HyAy6du8clQm/Gy9JCpWsZP7CFkWIw3Z+cgeAHEBbt3CZE2s7GIh9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIDtCTH+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIDtCTH+"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e58034d05so3370682a91.2
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 22:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846596; x=1789451396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3F8xNc6JnbnOhSUa3MmC6YFjLwngFDOoggPy4Vs2zK4=;
        b=PIDtCTH+E4RD56IhSP/YLtkKTjdi3FKE5QdOyY3fwMVkUR2xZvkbVsnv+LsF4P/Qdg
         S/V+0cBb+vaRtWPhl2qVf9AQX2+ZxsWWkuMrlpMA5CzW/cQXNrbsiBqMuIrEeDrNB0My
         Rh7NEFz+DaCe0xbHB4+Nz8DUcD2Y8QSrAuxre+btKic6thGpGCghSfT23sbijnqdkv3m
         OUlruCXKcqQtGhIXWPf5959ijXLxx7xsy5TuF1Tqk6QJCfM88m5+zeKdl5dznMOAmdeE
         7bHs/VhEwDn+xIbF/kntQQ+31X4FfjgN0fIYKdZUPAgkmNIA66bP8DrwVF8tVMu3MXEF
         cuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846596; x=1789451396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3F8xNc6JnbnOhSUa3MmC6YFjLwngFDOoggPy4Vs2zK4=;
        b=CziXU7U1ZkMKBvv4wH7J6MjL86HwCTPiSuBJ///Mb+ZrT7kL2XYdR24o4TWjlMEpI5
         7dZv9fcmQrm3g5LSYeVATFboGGARPqaqdV3DR7/CLD8TCVIIi2niNOU/Sm1ggey7JjAX
         adYdneEtWhvQmcsqIKlnkdN1Yr77mxmPsg9r48kNnMxvTbMySJtH0VKnNqhTd//eMD/1
         zJcIeWL3NPsC87/7U8n0it94Jl6d9kmJrxSVPu5yMGLlupsMF3U+zA9YymfM6n35H8/S
         vateKeE3OnRQEHdB19RuKJPuGKaZJaSdlKoGv/7Nm5bRHSlvbtRR/m7XrhlorQcs6pxm
         QVjA==
X-Gm-Message-State: AFuF++k8lnboJHjyp8z6cQH7MClbVDC9pKzR4dKDHhe0RnHgna8d2uYu
	xgZaIBVfsgmYJcGCoQRMaNeIfCNwZVwRON4/nmDtOLRKS00wNphY7VNs
X-Gm-Gg: AYBFou0mEYflY5w7KE+9+G+u3TsiFHQEjYjvdxVaotsSkpJiLCXKx/PvgJuQQE/0PWJ
	7ikJ+V/WYEH2BjA5AFepBKm/umVx8stpTiGmbVXNMp4sdFNEX8NGlnWXFiNJpL+sodswYWWyuEJ
	ixbDHYF9xvfMW1oXsGFo1rEtBHi3oLbdFm7uR6bQyG1EtJJTzgKYUZlwG+bmrfOhLWTCzMeA1QW
	7XRTOibXAzj8wE2Gkv4RO8OXwq5QKSB8WogFU4pr4Vm3Oy8FFdJv6bIj25GB20aNclZdqqMk9sf
	ZKgP51kmAS5Nlu9zRl8tBJts9anQcepU7xr4vtfgCFWWGexxxTJ1/Tn4Ns8QFKiKVz56rUb2eyg
	4qUpFgC8OK8WwBkrC2Q8QzH0T7ClZBtE2FdIXOSwApA9bydtAOARzr17niYcXVg2AqdoElZI5wA
	Fue8Q/R4eaWW8q1Bw04yUFrBWTfl6pJNdaFOlNd78N9yo/PWq2wGBbqSREYd/O17gl6QNLJAGpJ
	E3XAM2grA00HF/Xqif1bZND
X-Received: by 2002:a17:90b:2e4b:b0:398:a145:5d3d with SMTP id 98e67ed59e1d1-39b26151b89mr41589578a91.6.1788846595925;
        Mon, 07 Sep 2026 22:49:55 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:49:55 -0700 (PDT)
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
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH bpf-next v4 6/7] libbpf: Fix typos in comments
Date: Tue,  8 Sep 2026 11:18:52 +0530
Message-ID: <20260908054853.13820-7-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908054853.13820-1-hemanth.selam@gmail.com>
References: <20260908054853.13820-1-hemanth.selam@gmail.com>
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

The subject changed since v1, from "tools/lib: fix typos in comments":
both files are under tools/lib/bpf/, where the prevailing form is
"libbpf: Fix ...".

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/lib/bpf/btf.c  | 4 ++--
 tools/lib/bpf/usdt.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index c783359977b4..d1c73113e58f 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3847,7 +3847,7 @@ static int btf_dedup_remap_types(struct btf_dedup *d);
  * types, in general, can form graphs containing cycles, not just DAGs.
  *
  * While algorithm does deduplication, it also merges and resolves type
- * information (unless disabled throught `struct btf_opts`), whenever possible.
+ * information (unless disabled through `struct btf_opts`), whenever possible.
  * E.g., in the example above with two compilation units having partial type
  * information for structs `A` and `B`, the output of algorithm will emit
  * a single copy of each BTF type that describes structs `A`, `B`, and `S`
@@ -5648,7 +5648,7 @@ static int btf_dedup_resolve_fwds(struct btf_dedup *d)
  *
  * After we established for each type its corresponding canonical representative
  * type, we now can eliminate types that are not canonical and leave only
- * canonical ones layed out sequentially in memory by copying them over
+ * canonical ones laid out sequentially in memory by copying them over
  * duplicates. During compaction btf_dedup->hypot_map array is reused to store
  * a map from original type ID to a new compacted type ID, which will be used
  * during next phase to "fix up" type IDs, referenced from struct/union and
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index ee9d1b614883..67c60f716c1a 100644
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

