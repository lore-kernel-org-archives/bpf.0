Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73030481A97
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782516; cv=none; b=im9WhGSxfmQ2RFFp5LWxfAWJ0tAf+RfOtzdNfs+Wu1IWzW9Cqg+l4kP6XrsZlfdDj1mewdC5LFT+umhGLqFE8xmRlyI6qcH940iL7Oe4Yo6rvc1eqs70XzzSYCdwTclbzEgXHnMkXobZAU8Qg+QsXS0dnZA4vxkxztRmAaVy6zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782516; c=relaxed/simple;
	bh=4mTYBHO1BKwVo359O7O1oHBYX8lTCqfUYOiXLv1KYeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbdPPap4T5zyWGHdGrVg8ZMCWMe+C2f0QWzZkh3i/9HvRVbgQZFYLSnM3RXxSeLYVRmW1Y0GyGcLqehgFGVHHbKh/YK6Bmk8igIP6nFYIJWRxzCLSPnDhWI7xpDskbYDl2azHsp+QdZkrWVm8gGdJS4ay/vusSlK+B0HdL6CHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRghaFNb; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRghaFNb"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f4ea388ba6so3323712a34.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 05:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782513; x=1789387313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3F8xNc6JnbnOhSUa3MmC6YFjLwngFDOoggPy4Vs2zK4=;
        b=dRghaFNbz6i6Gjb99Tfs1JqUMOg9dL47AvMS23hXoIduhnv5piFI0AkiRUWXz4hUog
         /7+m3OYwb9+c5T7GczS3LGGUoFqZDMBY9P4xRx5OKzbcw3eELCKq+JInQ3ZCVXms7C1v
         +NCEHcmHm3cFXYZMFKT1KU8OFz1cP8J+EJhQrsWlI8aGsmMv7HV5Mc4j4tsm5KTuoKfK
         gKb36uwU71T/i0Etlsc7NDR2Q5TonNpG8Z8iYfFrS8VjlHuMZIf+UUlh2T1y5To+F4KY
         FAvaP0vsOkAc4KzsVxwmdCa34C4hlfMB7VjjEMpSgVexUNNLOVIySO7SVK6blQDTER7W
         cTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782513; x=1789387313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3F8xNc6JnbnOhSUa3MmC6YFjLwngFDOoggPy4Vs2zK4=;
        b=SWdGIX/axHqvN6SWiTwp6sJ9DuObTegmeUSshvuqvYvxnX3v1YQd+9HxCdHcmCFkGD
         VmDL3Lbma8x0VhuV3xIiNrCq4Ugjh1qyZKFn8lsBHGJkZhFKyrsV3mGNkzuZknlHJS+3
         JoQcWDTnxK8ylEhfpQLQi3a7c1DW+r3K5cedvlX81jbS/LeeIAlKZXVReZdBdKoA4srn
         8Cj2AahJrjilbZlzObZMAk5eQ4CqUU7nuK0s7VB/Wjmgx6cVqk4yS7jLvGf1wIIZiBN2
         +Cj9QziobtvdLq6QkA+ignzLJfc0vkvxENZbsQvSsHDEZpLIK6IMV/zl44+ekfamtHrI
         WT2Q==
X-Gm-Message-State: AFuF++kuDEfrUgOgaqs6pm3HnV52iuw2XYC/yy4UBTFXhblHr3sRidd0
	qUYsmQY9eAwgDbM41iGvgHWjmsbxV+al0VjW0t2nit/uxV+BxXa/PpgY
X-Gm-Gg: AYBFou2X24PFvM4zCFVLj0OLvUj4m6AJsPM9P4hCoQC/X80OuqYBgcCpImBqJZ027/v
	uy4/B4gUWsty5H0NzWb2gZbFedALGKN1VA6IIGDqrZLyhyJ0VvN8qRoBqVYaQeSPAvU9TxehjIR
	o2nD2WkJ8s991XeejAFU1Gs6FCbLrmixKqOvUzYGWdRw4m1HrSqPMR4m4st6YgqOEM+ySwCjypK
	gl+66l2bxHaDqDYlD9OIXO9gm7lyyVIJa1qXrZCSmL+CukCNUFkyzJi0tl00JD5s2KjXYETW78m
	NyIC9jYhYSe7+GEbktwXWQU3oFbWZKoRf+FxwX93ju12UWISgNlQXcs5NUkK0yz0ppljW8BVIgw
	ffVSOwJZgdi8D65nGWBgkBDzUkis66OlMIxN9eWeNzwIa9KIU+Ofer2gMnptKVMNvjdj3atM+MN
	IsjN4JvuexyDHuyWKLfDCCd/xMdvbidWHxlJkA1+xaQmB7TnVMfgVilmDceoAmZBf0qFFJ/mYPi
	lvwsjHJ7wwgkA==
X-Received: by 2002:a05:6830:4424:b0:7fa:5c49:5243 with SMTP id 46e09a7af769-7fa5c4954c8mr12694235a34.28.1788782507546;
        Mon, 07 Sep 2026 05:01:47 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 6/7] libbpf: Fix typos in comments
Date: Mon,  7 Sep 2026 17:30:42 +0530
Message-ID: <20260907120043.36894-7-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907120043.36894-1-hemanth.selam@gmail.com>
References: <20260907120043.36894-1-hemanth.selam@gmail.com>
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

