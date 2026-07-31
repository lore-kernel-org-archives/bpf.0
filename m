Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1117993
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 00:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785457100; cv=none; b=oSrKNsRNqo10GcpUsa4D0pR04fyw4JrbyUz/39iAHzrBCiEANvdJLMyh9aUApIKWejwn4DSrSThslMG9a6DtO9kzMuMd6fwK948af75KHXRGzbeRmFY0xdB4+bYR5e6MtPWGzklerf5jgR51Jx9pPsYZ8jhUBDzKPLwK1Sl9e24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785457100; c=relaxed/simple;
	bh=d71qq8IeroOX81lWUMlvZ1oPsNcK1R28/HBOYSVyITg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eGDLOAbtYXu4htFWqJAPIOlwne0taDKsXndPY8ilFxdC3+QWUr1IRlLe3rBpbu9bP1s0Z4hyNCJEnhwZ3aSn+bbGS5QEMjgORiH1NGJWUZ1afsui8SBCDkrKGN29Nxxa73XbJ4ye08/C0CbFJ2lSF/0H27iG0DEz9Ngf9wo5Z+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqJ7RSC3; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqJ7RSC3"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6ab04bbcc11so117869eaf.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 17:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785457098; x=1786061898; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pgfjfo9Gag5kWKb0bLxwyUihgIZfRY7YyhtakKFQe0M=;
        b=DqJ7RSC3BvBdxHU4KFiOMByCqPOKjRMq5BkFdfihot3h6VILPlLrAAy17Vj9Pzw7tr
         ML+iSsULjXMuiiphnX1PcQ6xQHuaPeNbRc0rYCe6n20ROZ2Z8iMPnGs7Wt4TQOUkDo+C
         pMzhbKy4KKxwJ9GAbyW9llkRKg1ogLJoLlc6MOQ8XSgdX2TNFBlcZUPN2TNtJA935CJ6
         5QrUX63jf6uMJaWzziZeVscD0HKhjVVh3xdM5AkWcK9IsL6ikkjCy+aZzyIySjQTVH72
         xxFKsJiTpI9NKTRQ5emlyxYpBLbKnq7bPbfYXJxKriWWI746GAn737anMFKTVLn3YdiK
         PTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785457098; x=1786061898;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pgfjfo9Gag5kWKb0bLxwyUihgIZfRY7YyhtakKFQe0M=;
        b=CeHFNqVP1uSpTJzidz3j989PH3qK7Tb/BBZspwJ9jslWPrnAhsftNCAySgrZS3bz3M
         X1sGjeSSOM6kYghxl2OLLZhet3ayr+gwL315dkg5e+SpLDZXe5akBjSiMl2AfbUm1GOJ
         A2ueRtdE+fNVJ+WNUr2PCG8pthuKv7FvelOp5q0EeeKJFritl+k74HcHXVr1dlJi3qm7
         otgV+aGaLoOnUtcnEHm5XzrPsnEW5iyQ4pRo3ASPAJ/CPdGZFNWzj442ZkP4NASh9fgw
         feyvJlox2fP8GlASp4jrPkO1bGkgq8rYGI87T8lKs83hpLbVpFR6tJPe10KuLQcwAXGi
         mKZA==
X-Gm-Message-State: AOJu0Yxumqy5cQEWwJyH9ZfLcUcMeR9ytNO1Gc87C7UaxxuSh0t1CBQN
	TEVdcTDeIfJhsDhGecSW3HiYhLUnE4JGxieyH0VOIKBpxPYoFCOalv6c
X-Gm-Gg: AR+sD12+ywJJMyHoWvwIjyt8YReoHpoVIncVdnzjoEgrwM6/lTpExgca71XSRqW6rdf
	SkMDwki4a9+SBceegWMUu6alBT0gZ/ePlrkurminYb9DCA2XZXnDFVMv61GRamRf3XSVcZYOJHK
	tjVD24k/tL/+Qdod8W25o9gGr0baomkafO8t9WgMNECz4CbcShvU80F9FRt8QDmBoqiFvYP6ztZ
	aB+er4SYv6KNfZ6769j6kuaVNOFGNTsPws75v8oropW2IGK1NHBSZy98WysSxyqfiXDejhqXoUZ
	9A39cBTQD3WWWCrQ3ME0N0Ujvfj9rxSPlgyY9gryfXQr37e3AtGURNa9NYONgNDAk+69aePrhIW
	mtcgS3eZAEPTFTa+sV1onwDgY28RxcFCt/WiqLCcY8+xE27gLcxyYoGtRXzS3tQHmofDq2eCxMi
	oZlvrkq0Kqm0WU4no5fxhiTSAwQwt5ZN/n66W6y9OFHCXF6ETdb80=
X-Received: by 2002:a05:6820:1523:b0:6aa:e844:fb2c with SMTP id 006d021491bc7-6acbbcfa05bmr3160087eaf.7.1785457097970;
        Thu, 30 Jul 2026 17:18:17 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458c29d51f9sm3579066fac.16.2026.07.30.17.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 17:18:17 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 30 Jul 2026 17:17:39 -0700
Subject: [PATCH v2] tracing: Make per-template BTF id lists file-local
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-b4-fix_btf_tracefs-v2-1-6b66da8dc103@meta.com>
X-B4-Tracking: v=1; b=H4sIAKLpa2oC/33NQQ6DIBBA0auQWUsDtNSGVe/RGAMyU2ehGCDGx
 nj3ph6g2794f4eCmbGAEztkXLlwmsEJ0wgYRj+/UXIEJ8Aoc1ftVclwk8RbHyr1NfsBqUiKnqK
 3FIMN0AhYMhJvJ/rqGgEjl5ry53ys+lf/cquWWlrSKrTmQVbjc8LqL0OaoDuO4wu4ngrAswAAA
 A==
X-Change-ID: 20260730-b4-fix_btf_tracefs-fdafda5fdb5b
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, rostedt@goodmis.org, 
 linux-trace-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, broonie@kernel.org, 
 Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785457095; l=5490;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=hmaukBcIfLOTdQ4K7uDmftM8WKS7YD5n5UlweCXdDHA=;
 b=fVM3/kxj79XdSqH8qx+eMR/f7HOKUIFDiHVoL+xBuLTybZOgRdF1P2TPVOY1vX7O/gHQfHFUr
 vEcDxPBp1iWD7LLCR9VEiKsuoy75N8lKZUUuYzQztWx6g8gpRSWPu++
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

DECLARE_EVENT_CLASS emitted __bpf_trace_btf_ids_<call> through
BTF_ID_LIST_GLOBAL, i.e. a global symbol named after the event class.
The class name is not unique across the kernel, so the symbol
multiply-defines whenever two translation units instantiate the same
class.

Switch to the file-local BTF_ID_LIST: the list is reached
only through the event_class_<call>.btf_ids pointer, initialised in the
same unit, so tracefs readers never reference the symbol by name and
resolve_btfids still fills the now-local .BTF_ids entries.

The handcrafted syscall classes are the one cross-unit consumer: give
them their own local BTF_ID_LIST rather than importing the generated
sys_{enter,exit} lists.

Fixes: eadc0725ab8d3 ("tracing: Expose tracepoint BTF ids via tracefs")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/ff58b01c-3f5e-4d55-be82-609d2faaf12e@sirena.org.uk/
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v2:
- Emit the per-class BTF id list only under CONFIG_DEBUG_INFO_BTF;
  without BTF the ids are unresolved and BTF_ID_LIST falls back to a
  128-entry (512-byte) per-class stub, adding hundreds of KB of BSS
  across the ~1000 event classes (reported in review of v1).
- Link to v1: https://patch.msgid.link/20260730-b4-fix_btf_tracefs-v1-1-5f10b728f51e@meta.com
---
Changes in v2:
- Emit the per-class BTF id list only under CONFIG_DEBUG_INFO_BTF;
without BTF the ids are unresolved and BTF_ID_LIST falls back to a
128-entry stub.
- Remove verbose comments (Andrii)
- Link to v1: https://patch.msgid.link/20260730-b4-fix_btf_tracefs-v1-1-5f10b728f51e@meta.com
---
 include/trace/trace_events.h  |  7 +++----
 kernel/trace/trace_syscalls.c | 27 ++++++++++++++-------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 09ad57ac4b73..93011f800d0f 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -398,7 +398,7 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #define _TRACE_PERF_INIT(call)
 #endif /* CONFIG_PERF_EVENTS */
 
-#ifdef CONFIG_BPF_EVENTS
+#if defined(CONFIG_BPF_EVENTS) && defined(CONFIG_DEBUG_INFO_BTF)
 /*
  * Per-template BTF id list, populated at link time by resolve_btfids:
  *   [0] FUNC   __bpf_trace_<call>     (the BPF dispatcher)
@@ -406,8 +406,7 @@ static inline notrace int trace_event_get_offsets_##call(		\
  * Exposed via the events/<sys>/<name>/btf_ids tracefs file.
  */
 #define _TRACE_BTF_IDS_DECLARE(call)					\
-	extern u32 __bpf_trace_btf_ids_##call[];			\
-	BTF_ID_LIST_GLOBAL(__bpf_trace_btf_ids_##call, 2)		\
+	BTF_ID_LIST(__bpf_trace_btf_ids_##call)				\
 	BTF_ID(func,   __bpf_trace_##call)				\
 	BTF_ID(struct, trace_event_raw_##call)
 
@@ -417,7 +416,7 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #else
 #define _TRACE_BTF_IDS_DECLARE(call)
 #define _TRACE_BTF_IDS_INIT(call)
-#endif /* CONFIG_BPF_EVENTS */
+#endif /* CONFIG_BPF_EVENTS && CONFIG_DEBUG_INFO_BTF */
 
 #include "stages/stage6_event_callback.h"
 
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 48ef1a93e576..e35744049e3f 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -9,6 +9,7 @@
 #include <linux/ftrace.h>
 #include <linux/perf_event.h>
 #include <linux/xarray.h>
+#include <linux/btf_ids.h>
 #include <asm/syscall.h>
 
 #include "trace_output.h"
@@ -1303,15 +1304,15 @@ struct trace_event_functions exit_syscall_print_funcs = {
 	.trace		= print_syscall_exit,
 };
 
-#ifdef CONFIG_BPF_EVENTS
-/*
- * BTF id lists generated by DECLARE_EVENT_CLASS for the sys_enter and
- * sys_exit tracepoints. The auto-generated event_class_sys_{enter,exit}
- * is unused (per-syscall events share the handcrafted classes below),
- * but the id lists themselves are global and reusable.
- */
-extern u32 __bpf_trace_btf_ids_sys_enter[];
-extern u32 __bpf_trace_btf_ids_sys_exit[];
+#if defined(CONFIG_BPF_EVENTS) && defined(CONFIG_DEBUG_INFO_BTF)
+/* BTF id lists for the shared sys_enter/sys_exit dispatcher tracepoints. */
+BTF_ID_LIST(syscall_enter_btf_ids)
+BTF_ID(func,   __bpf_trace_sys_enter)
+BTF_ID(struct, trace_event_raw_sys_enter)
+
+BTF_ID_LIST(syscall_exit_btf_ids)
+BTF_ID(func,   __bpf_trace_sys_exit)
+BTF_ID(struct, trace_event_raw_sys_exit)
 #endif
 
 struct trace_event_class __refdata event_class_syscall_enter = {
@@ -1320,8 +1321,8 @@ struct trace_event_class __refdata event_class_syscall_enter = {
 	.fields_array	= syscall_enter_fields_array,
 	.get_fields	= syscall_get_enter_fields,
 	.raw_init	= init_syscall_trace,
-#ifdef CONFIG_BPF_EVENTS
-	.btf_ids	= __bpf_trace_btf_ids_sys_enter,
+#if defined(CONFIG_BPF_EVENTS) && defined(CONFIG_DEBUG_INFO_BTF)
+	.btf_ids	= syscall_enter_btf_ids,
 #endif
 };
 
@@ -1335,8 +1336,8 @@ struct trace_event_class __refdata event_class_syscall_exit = {
 	},
 	.fields		= LIST_HEAD_INIT(event_class_syscall_exit.fields),
 	.raw_init	= init_syscall_trace,
-#ifdef CONFIG_BPF_EVENTS
-	.btf_ids	= __bpf_trace_btf_ids_sys_exit,
+#if defined(CONFIG_BPF_EVENTS) && defined(CONFIG_DEBUG_INFO_BTF)
+	.btf_ids	= syscall_exit_btf_ids,
 #endif
 };
 

---
base-commit: eadc0725ab8d38c05148fce49f8d5c6a0e01f062
change-id: 20260730-b4-fix_btf_tracefs-fdafda5fdb5b

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

