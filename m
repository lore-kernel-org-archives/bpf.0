Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219A331A61
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 02:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514174; cv=none; b=an1j/Wi3YZRzCpkXzz05tglY3uIao27CCnGM/+CqTFz3zILNorhxc8vu89wjgup5RYLkunqkLDkk4tbU1DpkfnHb7CnTLCAeraabScvvKtZW2hz6l4SKUJVnwW7/gdn62aTsTdqpzq0x+BXYOezzaSBRjdWHKzx7FkFNzIwFzaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514174; c=relaxed/simple;
	bh=BOXWbgKt5oTWBj9dZM9FXvwRdMUZyFUaZrOkQbeOxJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKuCadA/7AqU5jFrEgHEnibzpbm5yvDBvlW/+m3zLYiV5yon+RYfopX1AUSJ1naldvaAUd9T9luGe/nr9woE+w0gp6JYmrdNC1TzH82jh1v7SohitYF6acXs5TOGyKOI1Y+L+ms8dBM5wGebAc2tDQHoqtStnv1wABxplYFzjIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5HNdPSt; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5HNdPSt"
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6dde2bf34afso1189743eaf.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 19:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791514172; x=1792118972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BkB+18irm/PXSeWD4xBchhhHgHVo7kRSvYTUNV9M/S4=;
        b=a5HNdPStODsnw5LkGOcR3d3vp0OZ3YfS/xJA4pmifig18xuoNzSV/lhcyL3HYrh+Yt
         nWD8z+K3Tqet4Twzc5zWRdRqy0oRXfOrtKZvvrfTMi8XUsi1TFxRh4PhY9+LWRxwlc3g
         QwnT4Z/jD9iGOeabjL0qoVcnbydVeEuNVk/rTWwTzKy3LMVMwbU16UpG/8doZ3+M1J42
         kjfJNZW7FkkWRCaAjtwwrZF7ZWYksUbPeAi3+9q2RnYrZbLLFHtq3BDS3hNgB4dqVriM
         khWErA18PAZnUHTMkgs2GrnLlnBiuXpMGqy8qbJCLeqTpvx02bUZt1lq8ltsF0X+o5g7
         y9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791514172; x=1792118972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BkB+18irm/PXSeWD4xBchhhHgHVo7kRSvYTUNV9M/S4=;
        b=1zTpWJ1lVHhGCYzEcPZBM+8AS9cy9Fuhf0Ao1ODGnMwYpZg/O7MxVxARai0GINopu/
         +7NomPMtShJUTe1Z7lvXDLyI5+/pZ55wz4bF9e75zxWZ/lm33Z/ShED9RJC3InsmEch/
         zpRUiBT289YFV0H5cpsy9HNTncAEyIISKs9sgsHAztujr8VQv4PTtaESp6ffVc7yr7wQ
         3jEqD97+LhbWOEHKwI6zfw3eYw74YG3kae/mSfhTZkgzv1Gfp2G1qTd0k+sgLK3z/kgU
         S8U5YAYMHOu5vj2fLdH7BxcRCOJhqyAvc0CJwGy4gNdhjkwsK79PiO0KzXWjTE5XhNZ7
         ewOg==
X-Gm-Message-State: AFuF++kr7IW0we6v8J/3kf9utOgCX9Uc2dCqu+qsaQEVOfg4rifRqLWR
	QlU7g/2kwpZ8z/YBrXPow+K8zm8veMSpULgyXN11ORf9H//ctO7f+CihUHXSDawUwAY=
X-Gm-Gg: AYBFou3iepVwECCFq7LuFyzEDvb4cZZfjQlYYwSIgS5S4UFfueWaNh6qAbjctyqxOnA
	dGuJW3gK3rlh7siUHflTrzwuGnZLxObNaCBlg/DzcPuGN+BqWJ+rRgZy4mqDmDoRBCgEnhemWBT
	Xfym+hv7xZ0KrZHOjU7OSWwlirT8QsM/Jt+UZIsE1YdH9WOzzmmI1RuUa7rBZ0Q0TFimRQ5S/K7
	a9W7aLUcgBXXDk30yKbcH/kN6q/wmCR8myDAMEc3bUdKKjWhsTF+uV2FO0UVs4ubg5ctJrzX+OH
	1nWLnMDZqlrlGsHPHG+6TK1Wqypmex8rnweJpExT5BhPuQZ9FRsQfOMD+mxk9P5ZOVKustgWifX
	161EAJ+EE6qILbCPKWfx189DKNOP9ujFa8Hqc1pt7sjNU2UZPW7r4U+NTjplrdmLMGadd5hOPcf
	aQ+lhK/wCOv4vX1IqMaj8+1LpjWFcnW0qK0038phPksR/m7UqboVdYLmApy7dog3yCsfApThNww
	R7QK6+l/OIqKPSQFblvI8IP127+h9H2UMToetYakiTTDqfOA4S3VkFMavtaZufzK/4YwPeOM/YI
	LwDk
X-Received: by 2002:a05:6820:c8f:b0:6c9:80d8:a1f3 with SMTP id 006d021491bc7-6ef0eec6e3amr490870eaf.48.1791514172242;
        Thu, 08 Oct 2026 19:49:32 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a865a441sm678374fac.18.2026.10.08.19.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:49:30 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	kkd@meta.com,
	kernel-team@meta.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for user address faults under SMAP
Date: Fri,  9 Oct 2026 04:49:21 +0200
Message-ID: <20261009024925.3169077-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009024925.3169077-1-memxor@gmail.com>
References: <20261009024925.3169077-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3490; h=from:subject; bh=BOXWbgKt5oTWBj9dZM9FXvwRdMUZyFUaZrOkQbeOxJM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetEmEiWQORJs3Ofr0dEdR3bNZ+9P+E/j5FgnLTDNCEW/j0x Tzs6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJG224wMPwQ6Xm7oOne+xzFwr7mU55 QtBee3r3d9+OORcn+J0h73n4wM/SsM9/ucyF19nv3USrE40ZC3p+Ol7ZQ9Zj/QuPnXMNaLBQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

With SMAP enabled, do_user_addr_fault() treats a kernel-mode fault on a
user address with EFLAGS.AC clear as a kernel bug: it does not consult the
exception table and oopses right away. That is correct for ordinary kernel
code, where get_kernel_nofault() and the other nofault accessors never let
a user address reach a faulting instruction.

JITed BPF programs are different. A privileged program may dereference a
pointer the verifier cannot prove valid, and the verifier marks such loads
PROBE_MEM. The JIT attaches an exception table entry to each PROBE_MEM
load, so that a fault on an unmapped kernel address zeroes the destination
register and the program continues. Since a user address would oops
instead, the x86 JIT also emits an address range check in front of every
PROBE_MEM load, which keeps user addresses, the guard page above
TASK_SIZE_MAX and the vsyscall page away from the load. The check
duplicates the fault handler's knowledge of the address space layout, got
the vsyscall page wrong until commit b599d7d26d6a ("bpf, x86: Fix PROBE_MEM
runtime load check"), and costs nine instructions and 32 to 39 bytes of
code per load.

When the faulting instruction belongs to a BPF program, resolve its
exception table entry instead of oopsing, exactly as is done for faults on
kernel addresses. The is_bpf_text_address() lookup sits inside the
unlikely() SMAP branch that currently ends in page_fault_oops(), so no path
that does not oops today executes any additional code, and the oops itself
is unchanged when no entry matches. Non-BPF code keeps the existing
behaviour: a kernel-mode user access without STAC still oopses, extable
entry or not.

The next patch uses this to drop the range check from the JIT when SMAP is
enabled. Nothing changes about which addresses a BPF program may read: a
user address never becomes readable, since SMAP forbids the access, and a
PROBE_MEM load of a kernel address is handled as before. Without SMAP the
JIT keeps its range check and this path is never reached.

Acked-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/mm/fault.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index aa88370ce739..2060e5f35d77 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -20,6 +20,7 @@
 #include <linux/mm_types.h>
 #include <linux/mm.h>			/* find_and_lock_vma() */
 #include <linux/vmalloc.h>
+#include <linux/filter.h>		/* is_bpf_text_address()	*/
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1262,6 +1263,16 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
 		     !(error_code & X86_PF_USER) &&
 		     !(regs->flags & X86_EFLAGS_AC))) {
+		/*
+		 * JITed BPF programs dereference untrusted pointers with loads
+		 * that carry an exception table entry (PROBE_MEM). SMAP makes
+		 * sure such a load cannot read user memory, so resolve the
+		 * fault through the exception table, as for an unmapped kernel
+		 * address, instead of oopsing.
+		 */
+		if (is_bpf_text_address(regs->ip) &&
+		    fixup_exception(regs, X86_TRAP_PF, error_code, address))
+			return;
 		/*
 		 * No extable entry here.  This was a kernel access to an
 		 * invalid pointer.  get_kernel_nofault() will not get here.
-- 
2.53.0-Meta

