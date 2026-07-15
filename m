Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E5372B5E
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124729; cv=none; b=V8uBEvwe2S0GrdF0bA7ohxFW6HMjE/C/OHfaL9i+eov438L1Om9La4kTAiyEbT6Qfv7ZUCYng/8UxUYRu6ckNulzXxzZnIQDUT7/1ihT+IyqYXdoVPgzkMJRG42ZVy53DCMSQf/oZMl9g4EPrFtHcZ6llo1mVRtkxGNg2T4C0qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124729; c=relaxed/simple;
	bh=IUpRML8hO2gj9vmCZMANV/jz26mRY1zTafZXxC6Gh5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fio28uZ0wd3RZgakhTo5MAgiiiwjGQC2k9e00GM1wORIqCp/Q/J7Pzy5WWqBVlxpWFTZP/qQblR0fRC7GbGfxEsl97ZRV+0OhLNfb5eM2brDAQuHUak3CAm3LAIo+z7cXEESKKu4zIZxFfDCnJ9o3E2t4SMRWCIwOMoz4hnvYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eDbRsCO8; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eDbRsCO8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784124725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlDYeaOEO6DzxNGHrEZRQDIYtYqdYOgqvzgHbc9tT1o=;
	b=eDbRsCO8vDaNbi4whUE62g/5CJhbpU1+kF3HthUif5iQW1ENWb38zVktrR9hVSPjqYaUgS
	SJregPcSec/hp9nvUUAw5fcCHZbGTIwAsmorocOJP2oYm3/wkJ0qLXVX2rO7bZ4SvuNoH2
	tjRDTA//UIo5NxoSXh88uNaeFiUlm68=
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
Subject: [PATCH bpf-next v2 2/3] bpf: Disallow interpreter fallback for gotox insn
Date: Wed, 15 Jul 2026 22:11:21 +0800
Message-ID: <20260715141122.15783-3-leon.hwang@linux.dev>
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

The interpreter does not recognize the BPF_JMP|BPF_JA|BPF_X insn, which
is used for insn_array map. Thereafter, it would hit the BUG_ON() in
___bpf_prog_run() at run time.

[    2.563726] BPF interpreter: unknown opcode 0d (imm: 0x0)
[    2.564557] ------------[ cut here ]------------
[    2.565206] kernel BUG at kernel/bpf/core.c:2349!
[    2.565882] Oops: invalid opcode: 0000 [#1] SMP PTI

Set jit_required as true when insn_array map is used in the prog in
order to disallow interpreter fallback for gotox insn in
core.c::__bpf_prog_select_runtime().

Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3849d3d00e15..e2ef7836b7b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17927,6 +17927,7 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 			return err;
 		}
 		env->insn_array_maps[env->insn_array_map_cnt++] = map;
+		env->prog->jit_required = true;
 	}
 
 	return env->used_map_cnt - 1;
-- 
2.55.0

