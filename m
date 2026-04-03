Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82406246BD5
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 03:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775188425; cv=none; b=Yo0OYz67jJw72rUMSTW4yaO9g7w0T022ieKr1wA3c72VWVmkS1H4Th39SmfL95D56VgsIeBt57joujjCmWvIce0Ojw+xRKTo2EAVifiE4/2nS/QAZh2PSeS+TFfJU7twyoyX9QyjGe7M7Ylo7bg5LhGCQ2gQLfNY4JVkb9U1jEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775188425; c=relaxed/simple;
	bh=N4SmTuz3DU6z4/MVQXzEFEwaGIJ+N5J6Ot60DlplkY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPe2P15dVq3gTgwDeqK1kItt8uApzAxXJe72lxxQJnh+6JcEKjtt7F93gy6ocCcgMINLaRbbaWmH6OXc2Hk8+dlacLKQU2iXqIbVDjokh9DOxFlzu0LT9xp4fHOWKl8dUd4L1yHg08rn8DLwCrk1m0Z2BTaRONUILp+DsS4YlDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jgcj+MNf; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jgcj+MNf"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82ce49785a0so683266b3a.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 20:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775188424; x=1775793224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ViHUAGpIAJaDEqoPOflqffJ5ZJrQIDNM5cMtZmtn8a8=;
        b=Jgcj+MNfeL2ZJSwyKbB4yTs2lzVlfR+gBsK7+aKiAWNd94ttSNA9Y898tjDPcCeb6S
         5Ygi/ITCeOifnVzadtxfycBqTBcB3Km1QWVVRXjUSdvx8E1JMZRrwNGZujJR4G6KCD6Y
         eg8+F75CPHMssTcaKCkQZgkRhwwoT2/dl4x/UgYWLzmF0DncqbVy21l82ts4Rpgb+Ki9
         JeFXfoWmi99aBsYNnN0NG7+r0OPpP/le5XsYwy61rnL0YiT6yMpuxQYtr8Z5Nn7wwmtH
         gTRS19jEOKjQZgvqMB6MHvTmPXraCAl5BnhYCDN1tYzJ4lbZocPSMqom+nDsmNAPTz2j
         giBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775188424; x=1775793224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViHUAGpIAJaDEqoPOflqffJ5ZJrQIDNM5cMtZmtn8a8=;
        b=VlhogAKNV8D/wO2wm4HvrYUsYihLYKECWFZ6JUxyp1qJ1vE5VHoPYdlyfBisLtrHWE
         X/rqUYKasrMhpOXVY8jR9M5tDofF+BGVrYXa1UnljMhNzrSk/Tf2yNVr8DDWOM7LbQS/
         je8AHzQi01OyPoSo9pmbSVwi6Dvd2bjhmGwChb0B2VjW3sx9E4II969VufBOYaMOCFZm
         8Uiud9OlakWnbf77YszHimw7IxXJwrgLecYh3SIHvjHkmCY0LzkMZ+9rWaODZhpyfsSl
         oTe2RfJBQOkkttJVcmRJw1ULmusC5RAPogfIV3JgaM8F/z8JuwRGZw5nJoa4rVBpmGem
         ZVgA==
X-Forwarded-Encrypted: i=1; AJvYcCXroWvQb3F/2x02SFKmmClVbH2FB305C7ghy1KGTz62DPX9dnS6FnuV0emyGUmjDgvcfsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzriOU/TcZeFc9dbXoD4mKKsMWOJ9P5W03q8l/NGIvW+D7bgDfC
	8HWePAtlv41gFoDO4qBHfSTvWcbE+QHf2k2jKp8OE6bjqwlQMm7ohEwA
X-Gm-Gg: ATEYQzxUXcnXoSIQxsMNE3uPCZEAqMwAQC1M4tKP+3TOphXBIqD33274sjWVgMXYGlp
	Z4nXYuMHLuW6LolavtLlPomc1KbN0XftVBuBhmj7HISlMiCVlXe20uVrceF3H6xqXWuTnq9aWyR
	CEzJPS3E6np3mhijtsRsy5CmBsaJLyd/bf5Dyp8wP2rAsJP6Ya1/xjPRPxFqgggmBxfZs4kWmlj
	s66YD6BMHsuz1t1wKwWeEGrF1fRhfRppObeYdfGxnOnZXfWy7dfddKwggrT33Pg9dB3DhlzECDe
	Jc7d3R90F5jq59Ub2UVMUxX0fQ28nBAZ0KOxjo2XncfXTenX6CYvpiX0I+H8p2bAC34EmTb6aBx
	pob1uRjtu12c0OZBcmSXOWLrgH8feq+7Z1ycChyyn+V8neIWJl+77rqBE5lGn8PzXFww10uuO1F
	+t/qQ++60opDQ9FMLyaj1Af9HcMyRLrQtgGTXzoIT6DwpNWzmQod3OpR1TRHUqzEL0qGIvBTWC5
	K/d8d/2edsf
X-Received: by 2002:a05:6a00:414b:b0:823:1d05:1660 with SMTP id d2e1a72fcca58-82d0dbd3061mr1777793b3a.52.1775188423771;
        Thu, 02 Apr 2026 20:53:43 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c41225sm4752110b3a.28.2026.04.02.20.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 20:53:43 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf] bpf: reject negative CO-RE accessor indices in bpf_core_parse_spec()
Date: Fri,  3 Apr 2026 11:51:12 +0800
Message-ID: <20260403035111.4031084-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
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
upper bound and always pass for negative values. When -1 reaches
btf_member_bit_offset() it gets cast to u32 0xffffffff, producing an
out-of-bounds read far past the members array.

A crafted BPF program with a negative CO-RE accessor on any struct that
exists in vmlinux BTF (e.g. task_struct) crashes the kernel during
BPF_PROG_LOAD:

 BUG: unable to handle page fault for address: ffffed11818b6626
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 7f74e067 P4D 7f74e067 PUD 0
 Oops: Oops: 0000 [#1] SMP KASAN NOPTI
 CPU: 0 UID: 0 PID: 85 Comm: poc Not tainted 7.0.0-rc6 #18 PREEMPT(full)
 Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 RIP: 0010:bpf_core_parse_spec (tools/lib/bpf/relo_core.c:348)
 RAX: 00000000ffffffff RBX: ffff88800c5b3128 RCX: 0000000000000000
 Call Trace:
  <TASK>
  bpf_core_calc_relo_insn (tools/lib/bpf/relo_core.c:1319)
  bpf_core_apply (kernel/bpf/btf.c:9507)
  bpf_check (kernel/bpf/verifier.c:26031)
  bpf_prog_load (kernel/bpf/syscall.c:3089)
  __sys_bpf (kernel/bpf/syscall.c:6228)
  __x64_sys_bpf (kernel/bpf/syscall.c:6339)
  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
  </TASK>

CO-RE accessor indices are inherently non-negative (field index, array
index, or enumerator index), so reject them after parsing.

Fixes: ddc7c3042614 ("libbpf: implement BPF CO-RE offset relocation algorithm")
Reported-by: Xiang Mei <xmei5@asu.edu>
igned-off-by: Weiming Shi <bestswngs@gmail.com>
---
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

