Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983604;
	b=OHoKrMHnWgegtsrvNeTq7BSWgP1yK0sJUc6Hua5ftaRQEPbPNCbnlBT1pFt7WHmSRb5K
	 dHxzdNretJsKhaWpojkBD8QLm9mPKAQwS402ChlL6LkWwph+n38AKJqe4xpe/Z417ZuXF
	 a9J3TRGZ3yqwYdwL6Ise7c34EkazTZGF8xHW9k55FjOnnPvuOTEifMNhg8I4nGm5QxKWl
	 rTOEQnbv2gw4N+rnS6QvqZov7WkDyeSrXfhUa4ibJMh7esZmTGX8+C5XlHCZ6TUoyEDZo
	 RNYrjukywlAWaCS1Wvz8QlJrZ9TpbuzxupZlMIID+IOpOOLBSQn+NFlRoKd7sjhw7iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=juC6NXaqDeN7SgsCJE1vyHXGNIHQcxz3FSkUSBzEimw=;
	b=C3W8MRyoVJpAc8ix3V7nzLkRQiSKdgOloC+5N+0D0lzHTiFNTeF1pILAMNEEuNyFKQTW
	 08dKoREpNxXRGaERRbHZooLF3rNeNJ1vilYjwEZHLpooRIbPdWVyT182Vq5kGlGr3Qiz0
	 6tRaHjxsun5exOajtnmsf6TxTqW6+qh/BRgbZNl878jdgjlK2rso3Gp8yqg2zS7VGaaoW
	 hFj7rqR0+fwi5LBGIbQMeEimDPvcDtvv3nMgdkr0LwEuK0BFxqyCWWp/uORFd7xQDsdgG
	 Tzui1JirTR/ReKChlW06b17s36Uf1j5zxz82yqsHXDzeXsiIVqktVv+l4zlwKNyhi2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="SQ/gXPL/";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681C606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8681C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SQ/gXPL/
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so1773426a91.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983604; x=1793588404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=juC6NXaqDeN7SgsCJE1vyHXGNIHQcxz3FSkUSBzEimw=;
        b=SQ/gXPL/IhZGeEaPdpE1fnIwrfwUr3KrAMljxdxRRVtFgmjLhkn7dl5WDemotasntM
         drJ7dXeCI5UrdDF+mdIETG7PU+iaE15pSf+YYIAMCxznfTyUsawyPFnFAqhwn26xlnWb
         S+3TxDSwtHqGtFZ159gt6F2DUI98Akj/BnqXQNoTlelh+2svnPHr5X0wxqwEeJgww/nv
         EgidardUhExicdKeyke4Bq9XrmDCQioBk0gFOJGAtrzu3Jw8U1crGPZDU0ySO54/gRA+
         c5r6aNS1iCILzkT6PvCmcaprriWSbpEXXiw0Y5aU8K4x0ji4Qn8CHTfWkXEdEqDPzy6T
         CgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983604; x=1793588404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=juC6NXaqDeN7SgsCJE1vyHXGNIHQcxz3FSkUSBzEimw=;
        b=bNjzjzTCkbn179FHXoWLHEQiO2lQjAEm5tKPH+gJjX10OaNX9BqeNktPPObj77RGFb
         IZvCD2KAxZk0aYM2pl1JzuPJM/n7BqY7OzcDvs7HOXFOCFRNVVLsDT+yMTiyQhMaWT6x
         ouXwAx0rhAIB2DjrG0Gap8uV2+nS8ZWTv5mOMptvvkBc7bl/LkN+KtyC6wtQxBTMrGzE
         U9i2e0X7gIvw4WT73npyYqiGRkbzsTgrhcUKP+a4KVuJcBkvkPibmsAy8qFqbKlvkjjS
         4C+t+plefnrtp4vphvo5s3+7pPs4Sx6zRj9MAhCNjKG139zqMrKPUVZQrYIQgnmVkmtK
         0PSQ==
X-Gm-Message-State: AFq9FYJbZTzrWFRyAillLSeQY7LcwWTe7YH2vtCqEmNfclsiSkYD8q5g
	NAkSgsTAOrAt4ySEcddSLGkWwvHPuA87VdSbKApaAq28kuGzE8YrMX6EzIkaHg==
X-Gm-Gg: AYBFou16bcV5A7DuQ1Jbnx5wFWes0ALd9JBkpGNvtcVGPVki8yU/m+NKP+mfq7qsiIx
	mgyXo7ryiR3lCNwm50Wv0M4CclWYqrwyl1tBdoawCmWRNwWq2FCj3LZJxvbDTwUBczEtNYHA3QC
	FK1RkcnlrUbhEMe68i0pM1gMUHrrVOmeYrw6iNEZK68151yxc/d6dwLY3GyGSwjFXSsu1SlqtJA
	998BxnM2J5AIMPbr/LcPb+yBjg5aBFkp22+5ilOyQNpEO2amzkPsVAbNi+s2HWyxFyRCBXC0e/N
	CR2NCfr1ycUnAha8q4/5h0/iI8P6FlL3MvcYez/Hy53bDpAznR7fsuEAhYeY3BG0vv2YAgw8v0v
	MnLKYfNOphKAUZiaaryEIswatgNTNkNib3DqpDmO2Y/1w46FC3klXoP/MRI3Ux2SMmi7QmMtW6u
	OrfmL882nUI5mHTLBquU9qHgqeAxKparA/MU4Of3e4lqeCHSPozvrBUuYMlOR8CbbalS/kbPHKI
	iIcPNCXhUgkLbKO/Xad9T0csAVmwZQBr1EG+hu+Gg08n8TY5Wcujma6+7dgt0kPFgbXXrO7V5MX
	vWoM8IZwHNE0FEWYFmmC14rXNTadEZEMvBw3E/XW2J1U+Tx69xJOqW/r2OinPD6zRt0zJ1E6p6B
	k3q1ajjM4NBsA6znsuHvs3O9DwBYOdVx7SfRWWbmYJEFEvg==
X-Received: by 2002:a17:90b:3f4c:b0:3a8:d71:5fda with SMTP id 98e67ed59e1d1-3adeafc7f8amr4079654a91.63.1792983603741;
        Sun, 25 Oct 2026 20:00:03 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe9078asm6249230a91.10.2026.10.25.20.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:00:03 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 03/81] libbpf: Keep format strings of bpf_printk() in .rodata
Date: Mon, 26 Oct 2026 02:58:24 +0000
Message-ID: <20261026025943.404450-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

