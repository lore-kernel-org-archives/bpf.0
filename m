Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4E3B9DAE;
	Thu, 16 Jul 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188344; cv=none; b=cqZigA++LP3wkpGdHCwwjbnhZ4msQ4ZSpiITjanh8PgbXtDnHp7tdKoIG891ORiwv4A3pyZd4vCFyac4Xj3bFhd3HE+LAPUq2mBH/t+SuvI6PWDLoTYLysINqMVxqXJ3eg4CqENEbLQMZ4Nuld4u0NxgvLOanP4kzEI2Mc4rhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188344; c=relaxed/simple;
	bh=0ezK9nb6wN4qDm7eVfl3gFFuWiuh/XD1Fu96JdsDZY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sjKiaCTKEDxKOiT829sOUpfnDcPoFo5me/wSsJPsrnVRHs7QLyvbv6Qrfps26U98k1GUyEK2Lz8JIyZuOeeiI/hJ8fiynBDpj2168x4WdUHEnY+I1V/HVL3zEbzbTKURGe98IsLosJ6Xg1xFoL001IMqyECPl6/l0eg1UBWCfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLqo7RJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLqo7RJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42F81F000E9;
	Thu, 16 Jul 2026 07:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188331;
	bh=bsCkJeKP215VVn4x62ogxT2jAVvGPVAbWkkJgMSjygg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FLqo7RJtwC07gO35hWIR42JynRXwkaCrCzlN46P8eQEPNFxltJM2mrr1Pb63xqMFT
	 ytcILU7+Yprwnf045Mo/px5ocK+HMSav8TpxQ+lNpOWSH5zCW3le8Da6YaLV34/vVx
	 vDBPSRoJWWJ4JEpJEigG08SphOPRB0AsCPzxmGnDMMlZqwYd63C+WkQ1UAdKziHwZm
	 QpsDvaIKo9BmRR//qVs6G7hiAqNZ5OoRFlGm3r4pkACKPbaPDWFKGSGb8uXGHc0Eb9
	 47DgLmaEJFzHyBmZR+wcCvLoDC6NouCT7l0oP92cAQK9daeAqUC/5NggniwJXCFKrF
	 6GWWJcoQZLUUw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 16 Jul 2026 10:51:39 +0300
Subject: [PATCH bpf-next v3 5/5] x86/bpf: enable EXECMEM_ROX_CACHE for BPF
 allocations
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-execmem-x86-rox-bpf-v0-v3-5-4e76158c01c5@kernel.org>
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
In-Reply-To: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
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

