Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127815;
	b=yP/Q2c7LeSQYvuI4juqigP0UxhqsPW2Q043AMcb7tMKLWTtYeuCzLl6fobic40AinmMg
	 EnyyKivh2EGQuOulQxcKSXDdS7WsAoJAVI+L1EZlu6IYUKZz2K6tq40BaKH8vnIZhIIwU
	 4o5wWxMh3zjL6/kIQg+sqbWXLr3SYZ7YFeSfC0fb45aaDV1m2FJcQnUezN9n70RAf/CfY
	 UmRKpjACeT0DZhaPisH7DLDTSyHFQN9ImBR61TthJXFTuwxAMDC3p/hlQxQ7aORSF+mtS
	 n1UjcAa8jBQxL+saHRjCqUSFp+BoLKYi3SYQsITAxYAXJPv4GmnR9pyPLkgVdM52gaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=juC6NXaqDeN7SgsCJE1vyHXGNIHQcxz3FSkUSBzEimw=;
	b=tVXdUgKgTz8AY1HtConeTO/jEi6KlUBGk1njfIBtAR8/9kViOlb/Q80n/dBw27Kp1uS8
	 ADOWlrjGXOH0OsFTJdzkCr4+Jh7ds4ITkpUo477UM5GzCabO/rowdlw9G0IoSZjVik+Ed
	 GppKawd4IxEXFo8A94xhIGonRHtvSuyTdvBV66yAZdEYfC8W70pcd5Gv9cghlTY+aN6zY
	 LF3VDLlRWX5QEk/IbBjL0Cfdp+8lbnjSAgXJJ1fAqAuxCgRBPsAYG1wShKoc+EX7DvaHG
	 KiO4rGPTIlrM0NXE3cfGsh9fZcZzy0a7O1+TZPDPHnAeqtEbny8Pkby5VlywysGetHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kFKEmhWR;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446D606A31E
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C446D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kFKEmhWR
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd623dfe420so228598a12.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127814; x=1793732614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=juC6NXaqDeN7SgsCJE1vyHXGNIHQcxz3FSkUSBzEimw=;
        b=kFKEmhWRNu8THVrgwETHH5Cm2fBtQ2ikrIZUupde81OZVD37E3taE1KxD0Ukavlw5t
         0Jz1LwhEKgeXTo9siaRZ3bvcBajaJAXHS93C28FLSlxYBdWhTyPT3rHtk/n8rHeVG2lL
         OhAuDCuTF3+8vY1Bc6/F5tNweY/fksGcU0oxABcHwjNZgF5ZxHl7q1RktxaTBtcwRoMh
         /dZg1nTWOXZmuGMp1mJXE56bAKen45f/sfW4e53hWEcNkQRROjiUhuEW+M3aJoxeIgso
         SVlvRtKvddkkNnHXe+p9mmxhbuO4HJwipYJFoG45V+j4z0pqJn9Ej2ljwjQTJbMWSlsb
         Rq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127814; x=1793732614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=juC6NXaqDeN7SgsCJE1vyHXGNIHQcxz3FSkUSBzEimw=;
        b=JgvMRZmVLwDFUv3BpwYIoYIib5y54k8s1yLE1NlBJLsTwI0xv28r4UtiHuaTbywJj/
         Hg5wVxREBT2VDe0N+9okD58uAxLyyNtN0llS/dq/49pgRTKU6IfDNZGAa5k0uTGiuGFw
         mKJl2HtDVs+ao9ee2Al8ISIqG8RWWGifDqIfeQFE6a1cmTDCo6LUG88AgCV4d151MEIM
         E7CAxWdSw0EKhO2Xo+E3f1J29oIDeKYtjKHA3YwnxMnatX8mtBox1Np11rjUtMT4gGCX
         1mYhVG/fLHgfMClYge4knZC0iq3I5EWP+908/ThmOKnOQN5qalrDcdIXsvh7vjrkc7O/
         PylQ==
X-Gm-Message-State: AFq9FYKXgaOLD1UrPCPf9T9zBTwqfqehk3gqh3J1AID/mlYl6FdT8Brx
	LiMN4qkCZLBme1Psn3JCDkr2w9ZlJ+Bybdk59LO8PSrul0DITc4xMvuGU+B6bg==
X-Gm-Gg: AYBFou3IjTypn2HR7WDE50COp2DplU8JGD8UKS0gHx5GFqknDPw3zkYawkqX2FbKDYd
	li9TEtZs0vdGPFlLRoREbSy/snK3NbKsNPtyT0JX8ojGe5Q6xASCuxGZ8NEsjGI322fIiYNh5y7
	uHzYBQ8lMaWux/Pt862LoKnEMNbAfxEMrx492cjxrV25kiF9UcdKC216qEmlI4dqvDt9lRd68eY
	Er2vzHnRfuipOJdF3qgeqkKE/Hcu427MPijvtc87HXeog4j6tAm50/2ikx2AzNUUHc4SbJ7YH33
	YdX4QKQenztuc8/RrqxfgRZfM2pw+CXRc/81pjpBd4pA8NviNSFBv6S90XnnNX8E7oBqgHecQlw
	cJJroUd3L0rW0QsNOcG3cfEbDccOWXu4jdqiJeqFK/EHFMFStKGFs7mfgKmfLyzP6NvVnVLMHFO
	PUgvMwFngivdGzRlks7aHClrAp09YFzQ71jjwJg5VZLEVaedxOcHnP8d/bx+FFFnKOZDvYbLmpZ
	cH/x0lrr+uShougQMosJlFMZHJpRL44aoWh9kEToxL35nTytnZOtkGjQzWOBwqPDGenZVWFGNZN
	NI3zlba8mrq9YrrKhsCuakHUyPh5GE6z9ie0ztxGwtKfrQJitKu9e3eaJzf4xBxZpQMWsXTPE9s
	MS9JxApcwCajxQtuViN1lH1XT
X-Received: by 2002:a05:6300:49a:b0:3d3:ae50:97c7 with SMTP id adf61e73a8af0-3e90226ce3amr98600637.20.1793127814007;
        Tue, 27 Oct 2026 12:03:34 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdad33b99b2sm1201690a12.26.2026.10.27.12.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:03:33 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 03/19] libbpf: Keep format strings of bpf_printk() in .rodata
Date: Tue, 27 Oct 2026 19:02:58 +0000
Message-ID: <20261027190314.1440199-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The format strings of bpf_printk() moved from .rodata to .rodata.str for
one reason. .arena.data moved .rodata into arena, and helpers cannot read
strings from arena.

.arena.data is removed. Move the strings back to .rodata. As a result, an
object that has its own .rodata has one map less.

This reverts commit 373e1223ff00
("libbpf: Keep format strings of bpf_printk() in .rodata.str"). libbpf
1.8.0 has the strings in .rodata.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index b37b727ef216..9d160b5b9c0e 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -248,21 +248,13 @@ enum libbpf_tristate {
 #define ___bpf_fill(arr, args...) \
 	___bpf_apply(___bpf_fill, ___bpf_narg(args))(arr, 0, args)
 
-/*
- * Format strings are in a section of their own. When global data of the object
- * is in arena (the object has .arena.data section) libbpf keeps .rodata.str*
- * sections in read-only maps, which is where helpers and kfuncs take strings
- * from.
- */
-#define ___bpf_fmt_sec __attribute__((section(".rodata.str")))
-
 /*
  * BPF_SEQ_PRINTF to wrap bpf_seq_printf to-be-printed values
  * in a structure.
  */
 #define BPF_SEQ_PRINTF(seq, fmt, args...)			\
 ({								\
-	static const char ___fmt[] ___bpf_fmt_sec = fmt;	\
+	static const char ___fmt[] = fmt;			\
 	unsigned long long ___param[___bpf_narg(args)];		\
 								\
 	_Pragma("GCC diagnostic push")				\
@@ -280,7 +272,7 @@ enum libbpf_tristate {
  */
 #define BPF_SNPRINTF(out, out_size, fmt, args...)		\
 ({								\
-	static const char ___fmt[] ___bpf_fmt_sec = fmt;	\
+	static const char ___fmt[] = fmt;			\
 	unsigned long long ___param[___bpf_narg(args)];		\
 								\
 	_Pragma("GCC diagnostic push")				\
@@ -295,7 +287,7 @@ enum libbpf_tristate {
 #ifdef BPF_NO_GLOBAL_DATA
 #define BPF_PRINTK_FMT_MOD
 #else
-#define BPF_PRINTK_FMT_MOD static const ___bpf_fmt_sec
+#define BPF_PRINTK_FMT_MOD static const
 #endif
 
 #define __bpf_printk(fmt, ...)				\
@@ -311,7 +303,7 @@ enum libbpf_tristate {
  */
 #define __bpf_vprintk(fmt, args...)				\
 ({								\
-	static const char ___fmt[] ___bpf_fmt_sec = fmt;	\
+	static const char ___fmt[] = fmt;			\
 	unsigned long long ___param[___bpf_narg(args)];		\
 								\
 	_Pragma("GCC diagnostic push")				\
@@ -325,7 +317,7 @@ enum libbpf_tristate {
 
 #define bpf_stream_printk(stream_id, fmt, args...)					\
 ({											\
-	static const char ___fmt[] ___bpf_fmt_sec = fmt;				\
+	static const char ___fmt[] = fmt;						\
 	unsigned long long ___param[___bpf_narg(args)];					\
 											\
 	_Pragma("GCC diagnostic push")							\
-- 
2.55.0

