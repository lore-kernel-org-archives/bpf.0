Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D27375F88;
	Sat, 11 Jul 2026 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783763080; cv=none; b=Pcr7IOYcb/nM8i/71ukh6mg0Dc5xkNnnOSlkWFgVpxganSLGOxXSRtV7tRgqVYLUtLzKaSTzT5F4zPgzKHWHQXA8yKAZImc63JkS5mAmghLZ22Ifd9aT6IgQSOhzLWdOPqmrVn34AXnxGiIfpTCT8eQNY9bE9S+YRGk+E0ELaOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783763080; c=relaxed/simple;
	bh=0ezK9nb6wN4qDm7eVfl3gFFuWiuh/XD1Fu96JdsDZY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMWGomYBNFmqhkKOdgpsqzZSqy8QSDDsD6OZXWwlzhwy6SZHJU4N4uyJvq+E/NTOqAZC9smEqEdWEp6rWt2JjD9vLTFT5Zn81o4rU1FH9oy1F5UG7lvdc8++NQ8wfMyylBL3bRhCsc6JEkqFc/GcIr9/a5ZxRqSd9QYhDwG9gDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivx7qeYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivx7qeYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18501F00A3A;
	Sat, 11 Jul 2026 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783763079;
	bh=bsCkJeKP215VVn4x62ogxT2jAVvGPVAbWkkJgMSjygg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ivx7qeYHuE4yUaLhOT2jxikNu88xWVFTLYJwFSzEo/kllyyEkyYsCaZuq1da3Pvmt
	 kuotBeYrVNiQ+Ossk8P0yoMPJCsIexeLgAXNm0jgIiN2FWJ61ssMI1MOexZpYQJxAE
	 AYxpqZNcJ0oOnPJznclbx+4N4ozbbQxc0FH5hDJ7qIRwXlTTWY+WXGS2tTlnP/sXIp
	 YWkylwSUpq8STd/aCcIXKjo5Xdb9UzzeFL8ieHM1ObJOr5xcEX43yFfU9poL+JUHvV
	 eEBY4I4TZC1gREZSEwD/dS0NR/Md9wyqZYPuZkecU+TpsuMxi3UJmIvdXRIKGqTfsc
	 v8hVRJ2SnfabQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 11 Jul 2026 12:43:49 +0300
Subject: [PATCH bpf-next v2 5/5] x86/bpf: enable EXECMEM_ROX_CACHE for BPF
 allocations
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-execmem-x86-rox-bpf-v0-v2-5-bfd956d35119@kernel.org>
References: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
In-Reply-To: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
 Borislav Petkov <bp@alien8.de>, Daniel Borkmann <daniel@iogearbox.net>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Eduard Zingerman <eddyz87@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 "H. Peter Anvin" <hpa@zytor.com>, Yonghong Song <yonghong.song@linux.dev>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
X-Mailer: b4 0.16-dev

BPF core and x86 JIT use text poking and temporary writable buffers and
thus can handle ROX memory.

Enable ROX cache for EXECMEM_BPF when configuration and CPU features allow
that.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index fb67217fddcd..079f8c7e9e3c 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1107,10 +1107,10 @@ struct execmem_info __init *execmem_arch_setup(void)
 				.alignment = MODULE_ALIGN,
 			},
 			[EXECMEM_BPF] = {
-				.flags	= EXECMEM_KASAN_SHADOW,
+				.flags	= flags,
 				.start	= start,
 				.end	= MODULES_END,
-				.pgprot	= PAGE_KERNEL,
+				.pgprot	= pgprot,
 				.alignment = MODULE_ALIGN,
 			},
 			[EXECMEM_MODULE_DATA] = {

-- 
2.53.0

