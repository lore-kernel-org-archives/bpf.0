Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085CB37CD53
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761490; cv=none; b=Q5dacGUOKCK+P5BjYgC2o90A4pVMih3KLUe1syI6+kP6u06InKggtojt+JERjSvfAxP1JG+L6z82V/K9OjTlnJwal8CFSbjZRB5L8llOjyFXKkE1zlwUNoB8HNG2obkf4ESCk/penDE7S4sEu74E03EltWiNub1QTPPf6fiVBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761490; c=relaxed/simple;
	bh=M6HR8KI0Quz4P9h/V7uP6vZ6XLWK3VeE1/bwnMXUaqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/kKmVUXf6nNbMMTjMCeZUJ97clZ2pSrMK7/mdsBnvMs/AmY1n3qAhpb3+BUGuDXNseERG05y4tv3lOH21CamooPKicBCEBM6rH7J9E+NFrBVqaDk+hJoUtfTCzCky9V2WjsN4d/Y/FFm4IlaL5qCeVSOfTyoWp2G0wfBO5ve0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmOKX9qM; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmOKX9qM"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so8053425e9.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 05:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761486; x=1786366286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IM8AgoNqf9I7+gLgRS39E5rx6rix0RPhZveTU/HgpE8=;
        b=JmOKX9qM48NIP7t0cxH7we+/qewRM8IZEg3fgeAgFjQnUmPVGHlWApkulELGcjE0Fi
         QBpSfDdyZWkgisF5pz1BTw3qM9y2k8whzUw8+7JN11Nmi2SxtI9U7nJl7zCRpuZJ10VE
         QPlPIST3+KcJKDK9Ed9DmPzZku88P2e2nZTgcMWJTWzIJHBRa1jTVpcD72YX4R7d7pqM
         fZSdez/kqF8/zOYjTj1cpYSFfsDuKnW5ijN/+GwUP5sOIJ7WRnky4etzOwKDb0p4pDiO
         H0o+AWm0vCnbVsvWS5J2EMKkKGOba2UwY+MVkKJdxIOSFKCxnpRb3fuTrsRwuWRw1y/U
         I7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761486; x=1786366286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IM8AgoNqf9I7+gLgRS39E5rx6rix0RPhZveTU/HgpE8=;
        b=L/8d9Xg/RiNIBGS5b7sej7nR4l5WdKm4+DEqAGc0pFOkTZUVDddyYQVof1MSWc5nxy
         b3uXzM6Wgyfonc3vgeNQsrxEdXBz4tpJd393gjGbLiOKclfbP5VHAGcM6+A5U9ZcziRQ
         /JntyuFY1CR9uUHty7jsXcKD2781bR6ejFGlv7w5tB1f3qrNV5EpnKPO+3x5UPxpYk5L
         Zb7mv7bdYSnnD93dmpkkvKwcfoUs2/So/cuy0jJ1BUB2r8UKF3R2bFeHO4EWrsRSflAP
         442yGRRh+utihJBn10dhQyB0CWYgU89v5KEJRZ71RnR2OfSCMxP4pm/9c6VvMv76Vobc
         4f6w==
X-Gm-Message-State: AOJu0Yx635nzcL3SjWGWpkLfk8ge1j6am1rr5GC9LSsa6j9XvlNGZ56S
	OXT8wC6bIyRT/FpuaSSVfRNH7N5CmH5t5bKMrd0YG7EViCaZ9ASWaK1ZZpAXuMdJ
X-Gm-Gg: AR+sD12UQlvCAd2zCG7m3SwxL122rk/Lr7X7cV3WDrDsV8YaPU0COfUKNoWGH+p7UCJ
	7juB2hZKgxdF+Qdi5BPdFRO5ZELWzk4Pa7qLo+WajHO/Dqf7EGTBhkZHK8JQ2mDW85htluz/kD+
	29sFZ6zP+92KaMqR3XWHyj92PY1sRWCpVt4gp+VcXhJKcCI/5W+gRb1zIvDpLRBJu+mFa3lxQcu
	EwHOpVOUF0LkNrSbxBNG5+hC7gOnzb/roJYsI+9r8okrIl7Y569zwPvfutx0bbmBqFDqCik/DWM
	IvGJ819aNBBK6JaNRtHTKC280U8nVEHtBZI26tjv4Qab8rn182HbW7bl4WveQA9x7aDxomFQosQ
	ywe5wRvcEc2VlCOn85ANb1533qoUNZ0GB/2fXidBtXIKCSA/7xaaj86yZQDi29P6LrliByOBk/b
	zNg15HB2dBnJVDtMNMF8IrrDeJ7niqwIsaC++R2tYLm/lNGRwtm8FTq2E62C8z5/Fgb6UbyLbLP
	OesiR7QSnzkAilMb/qDmwMVkEDOMYTkDzHolCnmzSgqhJo7kH/ziVsCEh0Cs80ns227DK5s9vf+
	DawDr0ycJGAootnbicb+YTUUVF0=
X-Received: by 2002:a05:600c:4f87:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-4980c66c7d9mr195948715e9.3.1785761485946;
        Mon, 03 Aug 2026 05:51:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498081a12a3sm339756785e9.8.2026.08.03.05.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:51:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 8/9] bpf, x86: Fix stack-passed arguments for indirect trampolines
Date: Mon,  3 Aug 2026 14:51:09 +0200
Message-ID: <20260803125115.2264733-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803125115.2264733-1-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2639; i=memxor@gmail.com; h=from:subject; bh=JxYt56Xrv6g7AYiE51XsPfZqwdApAE5CiFLxLl9cPAs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIaugb8unYhsZhsyF70Sj7jGHvPC5f/Cm72JBv3UpXautv jzwE7brKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQCRRn+p+3X3Jl40UPhUA/7 2eYVWyOtH3GEWtn0n5zad2xRYlDaFIZ/hjNq3rV93fZp0doLZ9jWfTIVeHVkVdOFbx0BBgGnIiw TmAE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

save_args() reads stack-passed arguments relative to rbp assuming two
return addresses sit between the saved rbp and the arguments, which
holds when the trampoline is entered through the fentry call from a
traced function. An indirect trampoline is called through a function
pointer, so only the caller's return address is on the stack and the
arguments start at rbp + 16, not rbp + 24. Every stack-passed argument
of a struct_ops callback with more than six argument slots is read one
slot off.

This has gone unnoticed because no in-tree struct_ops member passes
arguments on the stack. The jmp-entry form already accounts for having
a single return address; treat BPF_TRAMP_F_INDIRECT the same way.

Fixes: 473e3150e30a ("bpf, x86: allow function arguments up to 12 for TRACING")
Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index f70689b27845..4b3e5d8a4a56 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3075,6 +3075,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 {
 	int arg_regs, first_off = 0, nr_regs = 0, nr_stack_slots = 0;
 	bool use_jmp = bpf_trampoline_use_jmp(flags);
+	int stack_args_off = (use_jmp || (flags & BPF_TRAMP_F_INDIRECT)) ? 16 : 24;
 	int i, j, slot = 0;
 
 	/* Store function arguments to stack.
@@ -3106,16 +3107,16 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 			/* copy function arguments from origin stack frame
 			 * into current stack frame.
 			 *
-			 * The starting address of the arguments on-stack
-			 * is:
-			 *   rbp + 8(push rbp) +
-			 *   8(return addr of origin call) +
-			 *   8(return addr of the caller)
-			 * which means: rbp + 24
+			 * The arguments on-stack start above the saved rbp
+			 * and the return addresses: two return addresses
+			 * (origin call and caller) when the trampoline is
+			 * entered through the fentry call, so rbp + 24, and
+			 * a single one when it is entered with a jmp or
+			 * called indirectly, so rbp + 16.
 			 */
 			for (j = 0; j < arg_regs; j++) {
 				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
-					 nr_stack_slots * 8 + 16 + (!use_jmp) * 8);
+					 nr_stack_slots * 8 + stack_args_off);
 				if (aargs && (aargs->slots & BIT(slot)))
 					emit_arena_arg_conv(prog, BPF_REG_0,
 							    aargs->nullable_slots & BIT(slot),
-- 
2.53.0

