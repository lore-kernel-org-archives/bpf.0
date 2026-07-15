Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE9437A4AF
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124724; cv=none; b=NqvV+5A+KHFbBfY7LzXDC6QcPIGMwcz7kgoM0bms4vImot3S2X6Jys3pNvMEGsOnTeY4mvjx/wmzXJNWUrFFcMc98026hcg2Kpijd/sga0mrpWJEDVtOL8foBKE+P4gunu6Js7MQV7U5kIIcSbmgI+G3fVF8AqS+oQ6bipxgxM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124724; c=relaxed/simple;
	bh=ndIKSrxKmnZE3dqZBVKJ4gJkM4iILtOVd8tk7yAm7Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpHsMHhwxAJ96ZW6/wQkn+a3M7tyXqR3PB/eL0sUiNrhRNAk786nAQNzzlWAd/5mbteydx/QRDv2LCAqdykOZcAYmhxyb8IUZ1H2uDz0Lbf/nM3G4l+OUwVloOGjqfmAqIUwfEX5u1p618Z4jZix6fOBFjhGtWLj+W9KDi+ZirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DPSNM8JO; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DPSNM8JO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784124720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4+xmeri9B7yuLUBZttyuZ0Ke5OCWdR2oNJkXqmaxfk=;
	b=DPSNM8JOVEdpxg0EF4Tq11QjLxM5d/2/uVeFOpNT9ZYfLNsobbfDndEtQUId18Qwo4aYJ0
	Tle3VH6+jqBI9URw+OPE3XkUegM5E3VYfzbri3+whCjuuA9TMP6BeMacK3aI6mSeIJyuvb
	ru1z70D1zwaCl/zH/EDJYjbYLDbmpZQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v2 1/3] bpf: Disallow interpreter fallback for arena-related insns
Date: Wed, 15 Jul 2026 22:11:20 +0800
Message-ID: <20260715141122.15783-2-leon.hwang@linux.dev>
In-Reply-To: <20260715141122.15783-1-leon.hwang@linux.dev>
References: <20260715141122.15783-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since the interpreter does not support the arena-related insns,
interpreter fallback should not be allowed for these insns in
core.c::__bpf_prog_select_runtime().

Currently, when the interpreter executes the arena ST/LDX/STX insns,
it would hit the BUG_ON() in ___bpf_prog_run() at run time.

[    2.579196] BPF interpreter: unknown opcode a2 (imm: 0x0)
[    2.579998] ------------[ cut here ]------------
[    2.580652] kernel BUG at kernel/bpf/core.c:2349!
[    2.581314] Oops: invalid opcode: 0000 [#1] SMP PTI

Set jit_required as true when arena map is used in the prog to disallow
interpreter fallback for arena-related insns.

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de816063ae63..3849d3d00e15 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17873,6 +17873,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			return -EOPNOTSUPP;
 		}
 		env->prog->aux->arena = (void *)map;
+		env->prog->jit_required = true;
 		if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
 			verbose(env, "arena's user address must be set via map_extra or mmap()\n");
 			return -EINVAL;
-- 
2.55.0

