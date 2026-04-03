Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B637BE78
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775213027; cv=none; b=OvutmvThxMNy2SxeWaBM3w/+7F4gM14moh7DMp0hmKCcONY0bzWlJ4ZjulT1g2NNaJneajYhMszJtQZyAGG0piIHgE5Q+DD7fMwk1dl5yaHvvIJFAKi1qoDPsfgvLUwL/XcWo7l6DUJ4MBdb1OpTfqdaYdDR4mJG1f1MC/EizuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775213027; c=relaxed/simple;
	bh=T/MaHZ8T6MQPsamOylU95KLokIHT1HZliwbNn0Ck6Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbdmfT/FIb/2nK33Gu2v0g2dbP7RbNqKn/2NtUw9mDPpbUPpbd24r8JzR5lC+wrKt/c34cXhXdjvgmMBe7KZZcSH+g/tZjQ8gfCuaVZRHimhMeSbh08b3mEhdWmt8xYPDwQlosw1Wkt6gbR+yRUc7rUDAqzmpz5sp9lekgRSG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oYtHPFq/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYtHPFq/"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c76b0cda2aeso682778a12.2
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 03:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775213026; x=1775817826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fFUymxXzMfTj3s15ZN3OExtlbHSECkwdJVg6zv5RFcw=;
        b=oYtHPFq/9Ybeans20wozVd4G/wwU/qhdmdhdL99CFbHd0M03HMr1/HeUPq6MJPDvT2
         8/hmhDt6/X/uRDZHVzPsTlEZ2z4d7CLqwE0T/uk0GTrAAAKXE9FKx6MgQUvUk1x7y1NQ
         RgvB2ZNQToX/swcgHA8eH8hZHqDH6i4h9CmRZhGf31vl18vMcN9lyP6htNBa3WF5Qj29
         xlcJN9mfro3uxUNfi4dsQMUs1pUjUKtjH70w+Ffdx1Rh7ZukLJWAhg2MLaZ434ajfoB+
         wqAsUK8yt6EwnQ6SCFssPUTKo0qEtl04svmNP50zdOvjv3Vp1LK5IFhMgX9GgmDzXM6m
         cj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775213026; x=1775817826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFUymxXzMfTj3s15ZN3OExtlbHSECkwdJVg6zv5RFcw=;
        b=CbFfryIVrLmXzEc5nJdy45GyUcpG4bhCUE020LVs7vmHbhGtRwbIBpE0Hy8L+HCn5U
         wwp3fDWZ7OkD9B9fbO6dD6tpeu86KtxORuwze941diAj1y+QwedkBVRJJGln8oN3ftq6
         HEwHqFwNJfN9DN0a0w3wIcqhg2YVnL23YJ7GXHs+kDRJlwHtb/+GC1zbAG/ukYnxaaGv
         E2yYtdU7LARSmP4CE+KTSlNojTOCcxr/LbJmk+oyZod4s2WBUI5e7fqVAgBS6cXgR7aC
         PWxls+QGc9a0YJZ2tmoHN1ciarmtgU8fK/R8MCdQv/aH2Vt+KaM8tHJgqiYaWqWCaSdW
         l2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0lvwUN+p3qi9yXzEPJTBYpm3b07SD0rfI2J6ivNdbVaRnHBnyrMQniBo+MPv5QQ4rpjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpp3e6JKyvVdGT5WeLhXf0GIXOcWt6YFSA08NEa4h6SSYIfeW+
	ibThwLqMuHQwcV3pHF6Inx58s6h6SNavuCbrXp1CbP/WU2A1isXkiq8G
X-Gm-Gg: ATEYQzxhVmPDBmoshKIPSaDa8CEKxLka1BqYnNknX9iVrwaveQb2bciybvGS+NmvXjy
	QfX9dWgbJ7nRCt7F2wyUFR4HBqBtWKdiFb0iw5tGEApGQdpwRqnhxDxSUettyMRppabYmuSJ4Hs
	V4/O04EAry6/hpD06CKpD21bnBx/1222opQdh/IWbIyrzpG2bnDwhp/JFmb4EW0fvh43OsG/cTr
	30dWRWwDu92K3O+9H1trD6pFuU1jAd+e7KVyu/FeU940Tn+JJ1GbJSNz+YG4gG+82yPn0tgRIr1
	cYFQRHvl0wvFcmSf5IDLsQrAKpgDrnMsv5Y6BuamlP0c/lvlptWsVnadvWF4kJPNzI8QbKUoFxU
	xP90rgSvjlRu9zcJK2nVzkpIHy26TwFdsyfUBJifICXfcRBrj+ykFdfA3knkzLKULSQCpPlVctb
	WI5kdVflH9BRbevfSYDNy5TJoaHla0A+tTk/6tQ4KippaxXIpYg6xCQTuIv0+U1KhvbRY4BEbvj
	3ULzO2yyswN
X-Received: by 2002:a05:6a20:9389:b0:398:c0ba:9cee with SMTP id adf61e73a8af0-39f2eda9f10mr2657781637.8.1775213025598;
        Fri, 03 Apr 2026 03:43:45 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6491157sm4525653a12.9.2026.04.03.03.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:43:44 -0700 (PDT)
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
Subject: [PATCH bpf v2] bpf: reject negative CO-RE accessor indices in bpf_core_parse_spec()
Date: Fri,  3 Apr 2026 18:41:45 +0800
Message-ID: <20260403104144.4132126-2-bestswngs@gmail.com>
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
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
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

