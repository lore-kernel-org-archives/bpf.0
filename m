Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B5B3CCFC4
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699721; cv=none; b=kQeZt14gua/z/IaQHvRC1SBxvSoVQ++p7kPccArRuzzH48I23hzmi8GwQV74AhEICzenL76aKqN2Exjl/SsqAa52i9I8KdzBLQg4bxrR4zfIpDoGF4UkrXlULPODoVO83hNQwROKwgNSs/qtyvjvb8f9QgdT0HOSJM7LpBDskjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699721; c=relaxed/simple;
	bh=IxiUNfi8hOSowpcbPiuOC6Zu7GZZQksuwSK9n3EsJF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3NXK9OVqJmMfMQ1VC5bhkc13lBAY2K7mVwuvPy5+0sLyfyChKyXkshVFWDvr5mocLlniXMODXi2KRhb5UKWlpkkI7vd3MJxRQR2C2NudJELPJOG6TWGNOgXJLOzbWXBgLKlZVE/07drcy/FeTeuOWOiideeoIk4eU2P4VU9tDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWjVFpmU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWjVFpmU"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-88d48da248eso673518b3a.1
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 23:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791699720; x=1792304520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5RetILKqN45djyCKKQSpHx0n/NkrGcaNQp/CPxCU/jY=;
        b=NWjVFpmUcMQLRFEvquLiHfrKnUKjnbnm69N4IPq2Od3EWJ63C+qlWnmzk/kSqhgvIH
         WOK5K3OdQrJwQcO/T3kPucQ0KE+/1yL/2Ad9S+wg6kF+BtQxMWL+/uxm1+8bQRgzzWLg
         LxTNes2bWXMrBMvZhreJ6dVd696nab3MZ/i9gwHSuIzGDUW17xE85AB/Kvh76a7LmWzY
         ta7XO7jn4Y8pqhGl4jmeCPjTwuxpqsxlSi8QWxzMroxgdEG2WKuiq2TtduT3HtqozZf6
         EZCa7ee0QuUfUnP3huQV+YdKva21uanCo7sw0myGksh7aFAXwkWO1x7wGfju7LjitUSM
         7V9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791699720; x=1792304520;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5RetILKqN45djyCKKQSpHx0n/NkrGcaNQp/CPxCU/jY=;
        b=Dl6v+vH9ADABpZrvTTtMJIjbRj4DHopK41VXGyRjlcDNDlAGhAUWy7j9Ds0NlVi+y8
         0mp1lCSZ3PgeVCdeG7Hc+i8c2ElVWfZhSJ93KiXtVvaMKHtYr0gsYTvZwQpZjrQOAZp9
         xyASSD+3Mo+6dhxXg+zEyFV3RY/SA/z+YqAhdW0XbKYUHZp0qXOzoTEbF63V7L11zmS7
         5nWTNomPMjzseGEzIYau8+/XNuX01ib3TKd8i1xR+gqrT2vw7fvHnqxfUG0MJig0Ehij
         6jIYXyg+u8AmFZxbSUrZsxQNQK+2wXh3Byh3Kn+NNDKF1NYDH1FV8kRxe9XSDiDLG07t
         vFCQ==
X-Gm-Message-State: AFq9FYI16KSOYzo5S/1AsG+ERMv5UEgL7Obg2gwHe1VlZGe0VbsaI0T4
	Z3KVpt7L4pevVhd35caCvnPnTuIWoSuKYzULH6pn5kWqsjwWS0Bi8IsVUO1F4Q==
X-Gm-Gg: AYBFou11S8f2t86ec/G0SslQNqWyy84sQ2sz1eIRp3vxjnPIvpnkeXpsfpLx/yHBKm3
	ch6Sd3oth3dTBclr1LXkAhgLhJ/5aW8LS6u6sWMOr1RFx3pvGe9iajj3JaB5MSZ4mtp3gsttFR2
	IzJSdrMRGulPeYrjCiesOJOoSTMSQ9dI90hcJICaSLeSOe/Y5nxXG4wSxOWp18Ov73PODcoWL5w
	sAjNwCmObNhiw58A32IHjKzM22HJBb9JfUn1qt1NBuNEr2rh0Yw2k2prfSkQ77ADRrcYe5vfEpJ
	bphEgQzZs8LlWaVJGbGYu1G/rhTI0u731wFT/4o9agZ2kQcwxXn4sYP4jolB4CedYP6FgrlNy5e
	Jpynwyzdm2actaqEFxiHKTVPk9B7XXh4DKA+uyU/FmTM1W1ANyNEJQXU2Trqa0NKjgXTliVtEwB
	aqwDaclksyyUmhsAcxO8qLB+PPscVPNd1Ok21ULqTAkxFpIVrcdudauyY5Ql7SbQwOYWmgZ73SN
	dZNFeEwx2CXtyE=
X-Received: by 2002:a05:6a00:4146:b0:899:9111:e29a with SMTP id d2e1a72fcca58-8999111e5c0mr1883762b3a.4.1791699719776;
        Sat, 10 Oct 2026 23:21:59 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c31071absm2854341b3a.15.2026.10.10.23.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:21:59 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 6/9] selftests/bpf: stack effects of scalar/dynptr global subprog params
Date: Sat, 10 Oct 2026 23:21:40 -0700
Message-ID: <20261010-scev-minimal-v3-followups-v1-6-6000e95ef993@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Verify that a frame pointer derived value does not induce stack
liveness effects, when passed as a scalar argument of a
global function.

Verify that a stack-based dynptr passed to a global function marks
live only corresponding 16 bytes.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c      | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 3d88cb28b8fe..d2fdc65c84c5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -182,6 +182,62 @@ __naked void global_callee_arg(void)
 	::: __clobber_all);
 }
 
+__noinline int global_int_arg(int x)
+{
+	return 0;
+}
+
+SEC("socket")
+__success __log_level(2)
+__msg("stack use/def subprog#0 global_noop_int_arg (d0,cs0):")
+__msg_next("  0: (bf) r1 = r10{{$}}")
+__msg_next("  1: (07) r1 += -8{{$}}")
+__msg_next("  2: (1f) r1 -= r10{{$}}")
+__msg_next("  3: (85) call pc+1{{$}}")
+__msg_next("  4: (95) exit")
+__naked void global_noop_int_arg(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"r1 -= r10;"		/* This is a scalar now. */
+	"call global_int_arg;"	/* And should not be tracked as stack effect. */
+	"exit;"
+	::: __clobber_all);
+}
+
+static char global_dynptr_buf[8];
+
+__noinline int global_noop_dynptr_arg(struct bpf_dynptr *p)
+{
+	return 0;
+}
+
+SEC("socket")
+__success __log_level(2)
+/* A global dynptr argument may read/write only its 16 bytes, with no definite write. */
+__msg("stack use/def subprog#0 global_callee_dynptr_arg (d0,cs0):")
+__msg("  7: (bf) r1 = r10{{$}}")
+__msg_next("  8: (07) r1 += -32{{$}}")
+__msg_next("  9: (85) call pc+1{{ +}}; use: fp0-24 fp0-32 may_def: fp0-24 fp0-32{{$}}")
+__msg_next(" 10: (95) exit{{$}}")
+__naked void global_callee_dynptr_arg(void)
+{
+	asm volatile (
+	"r1 = %[global_dynptr_buf] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"r4 = r10;"
+	"r4 += -32;"
+	"call %[bpf_dynptr_from_mem];"
+	"r1 = r10;"
+	"r1 += -32;"
+	"call global_noop_dynptr_arg;"
+	"exit;"
+	:: __imm_addr(global_dynptr_buf), __imm(bpf_dynptr_from_mem)
+	: __clobber_all);
+}
+
 struct task_struct { int pid; };
 
 __noinline int global_noop_btf_arg(struct task_struct *p __arg_untrusted)

-- 
2.53.0
