Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D2374728
	for <bpf@vger.kernel.org>; Sat,  4 Apr 2026 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775319174; cv=none; b=hfw1GY8zo6RuREoyCvx5cLi1CEiqQGtaKdH6J0gphszSIp6a4O9IOSYI0wP7GP6eqA0ZjZPiJYxFBq8ZpC8r3ItoGgVXyQc2P/98UXEvDE90bYYMTIrr14ZHE+/TyEwOGUM9BzhSvG641K/MY0WDFDwsfKc0NFzPfbOHT/S3IeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775319174; c=relaxed/simple;
	bh=rEpzQjxiKBNS+2ah60kayEFeuGx0+EAGNauxeEqHBm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0SD+x8/js1Zau5x20Kv7RS9bST8GHoXoiVaal5H6j3y/kXI5i+YjLZSr4hcz1d2/044exT2JNDXGLZ8qQBGtdE07vyapGxFWhdX5IU3tGC9P/xxTShY0AaADjF6YwAjKGb4H8Ps4It8w2OOpx0kJG5t7PohFSQllUqH2Mm9qbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hc7Fog7O; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc7Fog7O"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82d029fd52eso1467210b3a.2
        for <bpf@vger.kernel.org>; Sat, 04 Apr 2026 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775319173; x=1775923973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6zI9KtlAU159FX1onOk0hd1wMd/vmDiHA5vwrSEHVY=;
        b=hc7Fog7Ob+BYNEU/6yKhCxBqY04WIz1zWu4rdo8TPjTHKY9jZCduLRWODY0x/VlssZ
         4aura5djFn1DgV+4X2FuOx5qTP8T/+SsNud0xjDm5VoEln/4Gxc+EyKxAOfDCQ9Cv6yp
         C8JxTQfoFH6GwWKZHVkW+IQMPNJgIhoKURznt7evHDqUrpQmbLExo7TGN1LOhzRKd9eD
         Y6hSd+Abhd/6bR/qXfanovgMWhRZvEb9bh1raEmFP0JsN83mcrtcRIOOuBVtHolTN1IC
         mNeiNv+XROJs1S5WqOGw+Qyr+/2vPa3u4WmfZuVnJ3WiqMD0ZV3I4OGsWvMDYhXnBLso
         ELHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775319173; x=1775923973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H6zI9KtlAU159FX1onOk0hd1wMd/vmDiHA5vwrSEHVY=;
        b=rhoJ38qukny0zUyHMWZcHqP9XIYYbgH6j+KAw5CuQ+jJykSoYSSA6nv4bOBg6nPy+x
         3NLAkmubKst6IC7ysPDnfVZxys3oBlLC9AdJje07x2Od0Q3cbINcFnq3Gr78o++ZLXW+
         LIHLOjY3c5kP+59N2fVZ1dvYiZuxZvZPCRK7e9HSQpK0RL2eKWWS6i9FIHTdnR8ZOwQV
         oa6HFUtgm+CvJtOvaGG4lhlBc4dIio7nEoZlK8JCzGUOzeoGhv+RUzV/2ca4aDv6zQ15
         gIelTWxQcIGZsF9pwN+nYGpW8b9xWqlh/hXrdKU8kiNIvZLoan1LexsswthXtss6eqRu
         DCRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqmAeATPqbrfeC+OTSPEKfIx/iI6yUMgW2sgQvhIc03ap4E7ZT+KUl6i5L0X4hrj4c+lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSm5yqaCcJnDdDTP6b7wBKosG5mBvnmFySDZdQVH4u1wpvwPOI
	Is2Co7qQEjS9YswjS+lv8F5YaqstMi0yZeNsDb1G8m8nLbYyW3AlPOKO
X-Gm-Gg: AeBDieugunfqL5QB8sdnPR4V/B7TiL0d9AqStYVFT1hS98IMARJPWj5TLQC8MTaEKyF
	/+AxQcWHjY8JpnS4pNafctfrqby2fOxzxoflsTVUQqYKjdr7wuhObLpF58sIk7Mlcd4110IWIug
	iwxr9u3S++mBkS8S1D7erTEWu+qhxC+Ll2hdqeRTZ5mpHrNVmKagsSE80Qww8TazygIJwhu/9rh
	cUjXpRnEp/FMiZuRBJ4wIDvBgJeEuX05zFIsQaJZALj1W581fhg3G6uEoxishFOHyQUr1k+pbxB
	I8tPyPB00wSSW8XzY1BNdgESDV0ZwlKVReyBduBBrwOeJ8fEzD07zTB78fDsYp4twF3A81fv7OU
	YFDyDAT+l3KbhFMsT7+0XG4J3dwRXWrw+ApEnkuV4sLOSnsQGMN1yewKCBZx7YB1aoV6GHgEQ+q
	lhbGzPe60dTcMLBmom6WZLEAr44606TB9ff1qRmgkvac/0gphM232OLbjug7RdUZ4MtRp3f4T5S
	L/qSFZBI5Hn
X-Received: by 2002:a05:6a00:4b56:b0:82c:2647:eeea with SMTP id d2e1a72fcca58-82d0dba1083mr7169398b3a.38.1775319172729;
        Sat, 04 Apr 2026 09:12:52 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b6113dsm8301526b3a.23.2026.04.04.09.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 09:12:52 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v3 1/2] bpf: reject negative CO-RE accessor indices in bpf_core_parse_spec()
Date: Sun,  5 Apr 2026 00:12:20 +0800
Message-ID: <20260404161221.961828-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404161221.961828-1-bestswngs@gmail.com>
References: <20260404161221.961828-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CO-RE accessor strings are colon-separated indices that describe a path
from a root BTF type to a target field, e.g. "0:1:2" walks through
nested struct members. bpf_core_parse_spec() parses each component with
sscanf("%d"), so negative values like -1 are silently accepted.  The
subsequent bounds checks (access_idx >= btf_vlen(t)) only guard the
upper bound and always pass for negative values because C integer
promotion converts the __u16 btf_vlen result to int, making the
comparison (int)(-1) >= (int)(N) false for any positive N.

When -1 reaches btf_member_bit_offset() it gets cast to u32 0xffffffff,
producing an out-of-bounds read far past the members array.  A crafted
BPF program with a negative CO-RE accessor on any struct that exists in
vmlinux BTF (e.g. task_struct) crashes the kernel deterministically
during BPF_PROG_LOAD on any system with CONFIG_DEBUG_INFO_BTF=y
(default on major distributions).  The bug is reachable with CAP_BPF:

 BUG: unable to handle page fault for address: ffffed11818b6626
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 Oops: Oops: 0000 [#1] SMP KASAN NOPTI
 CPU: 0 UID: 0 PID: 85 Comm: poc Not tainted 7.0.0-rc6 #18 PREEMPT(full)
 RIP: 0010:bpf_core_parse_spec (tools/lib/bpf/relo_core.c:354)
 RAX: 00000000ffffffff
 Call Trace:
  <TASK>
  bpf_core_calc_relo_insn (tools/lib/bpf/relo_core.c:1321)
  bpf_core_apply (kernel/bpf/btf.c:9507)
  check_core_relo (kernel/bpf/verifier.c:19475)
  bpf_check (kernel/bpf/verifier.c:26031)
  bpf_prog_load (kernel/bpf/syscall.c:3089)
  __sys_bpf (kernel/bpf/syscall.c:6228)
  </TASK>

CO-RE accessor indices are inherently non-negative (struct member index,
array element index, or enumerator index), so reject them immediately
after parsing.

Fixes: ddc7c3042614 ("libbpf: implement BPF CO-RE offset relocation algorithm")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v3: added selftest 
v2: fix typo Signed-off-by tag (missing leading 'S')

 tools/lib/bpf/relo_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 6eea5edba58a..0ccc8f548cba 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -292,6 +292,8 @@ int bpf_core_parse_spec(const char *prog_name, const struct btf *btf,
 			++spec_str;
 		if (sscanf(spec_str, "%d%n", &access_idx, &parsed_len) != 1)
 			return -EINVAL;
+		if (access_idx < 0)
+			return -EINVAL;
 		if (spec->raw_len == BPF_CORE_SPEC_MAX_LEN)
 			return -E2BIG;
 		spec_str += parsed_len;
-- 
2.43.0

