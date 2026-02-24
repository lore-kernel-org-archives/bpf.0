Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0385636A025
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925492; cv=none; b=Vq/01H7a+sFRmbdrsuN+GHuHxS9JWB3VguIdURI36ERelUCk/u07DMoAI5hJ1Dg0xdqvqBw7qass3VpaZGgZgezhdidqlNHJv7RS9L2WDOlNKDO3jYRHnu+frMcr+X0sP2dYgOstEqSRpNfnK1fhyD0xdqxeSRhU2sIvZzBK178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925492; c=relaxed/simple;
	bh=hrd0NlY9pBKuduf76fdmrPBnyckvVI6lRHdi9c3/5Sg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VESsEyqC/aCCtTHjt1n6ugfRxsHALoY8cf9e+y96I0yel8kcKqWRbpgQccC2+e0K6YQJXr8Qldruad7oMJG1zo6aSH6VWLOVfFJ3SGU74bwagudo7f0jhpeF15sgUfMB+6RxWLzMnUM8c51UnqGVCEjD8y762Y4ClbexSjWM2OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vAJ9whtp; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vAJ9whtp"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4836ff58111so64116945e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 01:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771925489; x=1772530289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=srSVsiV2b/ln5UzP/d6flconP4PG3Pc7vryxNaoWscY=;
        b=vAJ9whtptRWJB+waUZnd2mi57nrf/xMqy7huGNLpB6bd59SbC86qxMsnHZiizGEgyw
         9cOcvDFA5Uxkxmtgl3M2wfS1PV+gZQeX2/8955gyu9IBKtr07OUtGxHIEPADING+Snid
         yI862+L7evmpx5Sl08MeLlclssgiITuy1zlEASRSJQgd5RH61B3HkmlO9qZEYw6DjIyB
         E/tD/ZukxlaYUK/vqfI0p0rs0l3ZatTgG93gW4BNAWh2BIMl1GxqP26gwB0JJE49u5qQ
         fmE+xs1UE3BavYR2dQz1vBzqy03SWPDvnQyytjcwichz+3V+ft0QAttvzBoXP6AVlmYg
         O1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771925489; x=1772530289;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=srSVsiV2b/ln5UzP/d6flconP4PG3Pc7vryxNaoWscY=;
        b=cjuSEeeqov0N8ptKNwS9nm+40P6LU6ccdqpE4RiUlTzrdY/ztaCQ0PnUij3F6Z0jbp
         vCIRL91av4SuewVkCLh8/j9xhZoajssAJceCvf7ysyWzQuITGFW1qeI+aLqbfLefOuaH
         cZNIi0tgt3+TQ70pX1/uKi336YWKpSnkdJWbgpOdbIfS+bL5DC4SIj4OD4Df7fDBgEZQ
         zPUE06lsWDNtHa+ReDF4WlnyatcZ0ioc1NCWFZ5QfSUFVM3LDlXyd2lavLwyxk3ZpXHq
         FvBViA6Sk7aLz7sOEAmbnlcfPvUSxV+Q0r+mXrPhGnrd7n4FOW8hoJG5vkZPMUuXHFQI
         8NkQ==
X-Forwarded-Encrypted: i=1; AJvYcCULG2kjbKoamtsZjz77WYo5Nb5cMlPs0HUzhmHHfStxj+1xTp6crIBFma4Y6zkeakOR+1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8Ki3xludktA0j1KC2uQq20UNdnIaKDCffHaDUFZmVwuW7XFX
	uNzqyoBlJJSQbDLBTHH/gLBJxeHsAFPRg+1EpWoyNtLZyWJUqaoMMWTkL8fldAgk1cuZqeExIf5
	4FQ==
X-Received: from wmdq4.prod.google.com ([2002:a05:600c:304:b0:483:2ac4:5da6])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1e1d:b0:483:456a:514b
 with SMTP id 5b1f17b1804b1-483a95befe5mr191351835e9.12.1771925489179; Tue, 24
 Feb 2026 01:31:29 -0800 (PST)
Date: Tue, 24 Feb 2026 09:31:28 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260224093128.1926610-1-tabba@google.com>
Subject: [PATCH] arm64: bpf: Fix UBSAN misaligned access in BPF JIT
From: Fuad Tabba <tabba@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jean-Philippe Brucker <jpb@kernel.org>, tabba@google.com
Content-Type: text/plain; charset="UTF-8"

struct bpf_plt contains a u64 'target' field. The BPF JIT allocator
was using an alignment of 4 bytes (sizeof(u32)), which could lead
to the 'target' field being misaligned in the JIT buffer.

Increase the alignment requirement to 8 bytes (sizeof(u64)) in
bpf_jit_binary_pack_alloc() to guarantee proper alignment for
struct bpf_plt.

Fixes: b2ad54e1533e9 ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 356d33c7a4ae..adf84962d579 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2119,7 +2119,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
 	image_size = extable_offset + extable_size;
 	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
-					      sizeof(u32), &header, &image_ptr,
+					      sizeof(u64), &header, &image_ptr,
 					      jit_fill_hole);
 	if (!ro_header) {
 		prog = orig_prog;
-- 
2.53.0.371.g1d285c8824-goog

