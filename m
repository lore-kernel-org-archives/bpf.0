Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA13B8D41;
	Fri, 26 Jun 2026 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499398; cv=none; b=kSo/ugP8tXZZ5Oo/oEbxTj7AuuhhsrZTgy0e7foA4hGgh8+joLWUpskCf7sqOFSkufg7wfGJCpdMvru5si3jy38EpWzHX19fcLzOcc/BPQQwthrwBIlRDUFOxLmrajqTX5GENz+ClcXr072VC8yhWtUks8K6Ob2Qc3EK0Ze2iW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499398; c=relaxed/simple;
	bh=0ezK9nb6wN4qDm7eVfl3gFFuWiuh/XD1Fu96JdsDZY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9FbvZVgPOWEW/CsPMWIoY2DzszFr9m/lI2oI67cGRGhWuziYT+k4UvXNhi/HkDTT8k+kpcy1luQh95mFj+xs02s/v3ba3ihp5tDeT94hlt6CcrvOI7++gQiWA0VSM0adjtpzD/85IArG+bVmYmNG1DaenioSQNk/D/chDRZoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDbCGXSR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDbCGXSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2161F00A3A;
	Fri, 26 Jun 2026 18:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782499396;
	bh=bsCkJeKP215VVn4x62ogxT2jAVvGPVAbWkkJgMSjygg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oDbCGXSRBXF015PBJJ47oyGZODdxVI5GhKNF77fm5HPXN3tN0yGYT2tPsMBv98RUw
	 IrKtGhY8ICJm1moDVc7o7PkHsmT0e8F4sFJEwZgq3+Rkj8QJscKWCFqAkb2dksIT15
	 EHgrw/lbVrjAGOfeRbr3BbeDp49bdg8HrQBGQLjmtbOb8PGcL4Z9xDcInHIU53JCjV
	 feJ6uI8++3QKNEspTbK9nPq2WoNi/ocBHH6TbhXsPDCiQeJP/Wolaz19iNj1jRXihf
	 rAfG/TkPX5q4L4CbsH1M/0mLEpUelAZ8/L+AXGifF2kbsW3QksmyGNGb7pZyQVVOH/
	 x0Fob9R8LsGSA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Fri, 26 Jun 2026 21:42:32 +0300
Subject: [PATCH bpf-next 5/5] x86/bpf: enable EXECMEM_ROX_CACHE for BPF
 allocations
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-execmem-x86-rox-bpf-v0-v1-5-45a0b0ed4fe9@kernel.org>
References: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
In-Reply-To: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
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
X-Mailer: b4 0.15.2

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

