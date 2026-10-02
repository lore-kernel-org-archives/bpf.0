Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AEA497395
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945276; cv=none; b=bzWhwP24mO09ZlS4cX6h68AUV0/IWrrBbrmUIsX/9XffhWEEFeWLWLpKTyM4gFBDW7C7KRW7lCOwMwkxY24R5l2W+/jxhhXGWun09nj82QaagdBSaJVzwPuUDTT0ao0/V9723mYtasqODhlWP7CEZFxRLwhmVS8dPV9Scp+XkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945276; c=relaxed/simple;
	bh=EaOdzo9YU8oavY1QTzxygnaMq8oMJfxQPY9WaI6D3LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBjOGaD4IOe4wkgFLzraMfSJ2xJ0+IdKV5C+EsPIApZbLfgzAfQWSmsKGmlhyYXlHdbepHCeeiVs8TolPhbyxWibwF2ILjwAf1TpCwJvhoJNdC6SEHsa6G/fNIajCp1NFojQPqsCB1tvhPQliMRlHyWU20T0fl9JZ396Jys53hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4mGp9bY; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4mGp9bY"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a4c8262465so3032302a91.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945275; x=1791550075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DQ5QKVjHzxMwXEocrjUP4F9tL0XlyEJnUrzJJy7fQPI=;
        b=R4mGp9bYb0btbw/tEgb5K29X6Dj7WhvzYWMREdon6bzzzcx6Fz2nEe1oB96EwU4d6d
         EPWo1YBVjjbQH2X8E7V9d2qjWwVDcuIv3YOIaJdA6ONv5WDSDuzXz0wPcvuDsHoJ8R9y
         p43CsssoSd2/W+phS6YIDwHDpYl1YXmHnoT+5Bb62r2ycQ3uewb+YD/TuWLjqE6tgU6a
         8aVBdCzPIINCEWkwGlWfTBjUO9DCw1nG2YpafUDIoyy2L+1VkBetvC41HZTYgS0Tx+98
         cfjifP/JfrwaHLFcayWv46wkg0h1BNmHraTbH5VTgr2OlENVBOlF8rXiEbVGBXg0YyJx
         Itpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945275; x=1791550075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DQ5QKVjHzxMwXEocrjUP4F9tL0XlyEJnUrzJJy7fQPI=;
        b=Dh2/QdPlg0GdHYf/6CSF29Sq1DjJ+0GgS+T60X9NWatCFmCiEDUJVBBi9w4C3yLWYh
         K0G/gVdNqmlMZ6MaFUKmgDBMzYR7LdGl7UgOYqzBlMbZVtFf7y7wuuEL+bONufj88Gt3
         q/wyYhR8mM0OoC5vcu+Him3ZL1Ttkdt9PpGZdOw09vyqtrYHHh1/fpwSEV9mxScXb9Bt
         7HOE6/Y+oCHyI2kj/LjOyUF95Jaf52YEQYKUS2/CeKPnwpPUMocr3BzntgXCwEnvDIOB
         o2ig7477NNT1m4L9xKkLcrFChTZAUe1siqvSw1fYSp4WZgyp5YfO9TIQgNkfYyPWzN7w
         U7PQ==
X-Gm-Message-State: AFq9FYLLDfKw2Lub/SjWu9mZIPqUYhzpnOzX1Ip3GEV0OpIlw5bjSAWp
	t3HrziFcc3TehsI9Yy3T/UYsHaRvg059uRy688HmkUVAUzLPqpInDGgrYGL6N51ICHM=
X-Gm-Gg: AYBFou3O7L82KD4hxgexs03eUjk65wXKPZcYFsJ7TdEb6AFxFiHqWKZlhOmxTN95rPW
	+DEby1fOGmx5TsyzO+cXHp+uWm4/F7kZRj8gUrPWeiZQ/ZbiCmpLOBoeRjVqisu9h7KXNqvYM4k
	I8TP6MMsqMGS+9CHwZxFGZgCaAIiPSd/bLhrJhxF7VB+q5tQ763OvNBwEyoPxGBhfzGtOTJqsgm
	28JYTlTuOgCVTgEuAFDw+U/ToeGIxG/nNEWd6WCrID6pith2T6PFZOq56Krc6lQhcjBz2qGVuT4
	ccL1lPjMldOT5X3ed7rWB9K8gQNa0sZbTAWvT1N2Uz0w1SVT7w79ii+z7Ci3k+yAMOzvnRT/1HM
	+ZR/tBXA4sfyU6JMDgl3GcF2hiUMYaL705p/Mey7NgcBhDL4wVLeaPjLQtICl4PukHcuBspTfhC
	BwDgDYSwJlxVcA7e00z6vblu/sAusXQs5TEtKcbkqwmPeTcp0uD344jLwQDY8cqiadgdjB7YVER
	JwENEXl5ydd7nGXDPofyxBFyn9OgatuOvjkHsdgdSj8jaSU514v1WUPs0P89pOE5/e93RMhTz4m
	9j2F+zqFgbjp4/EbqCVfGO4n5ctMu42yN2vQquNckOa0YBnQ4r9tV9Q=
X-Received: by 2002:a17:90b:1d04:b0:39e:6a7f:1dcd with SMTP id 98e67ed59e1d1-3a6ce80818amr2450407a91.41.1790945274863;
        Fri, 02 Oct 2026 05:47:54 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f471b16asm9150953a91.9.2026.10.02.05.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:54 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 13/15] libbpf: Keep format strings of bpf_printk() in .rodata.str
Date: Fri,  2 Oct 2026 12:47:12 +0000
Message-ID: <20261002124714.180012-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_printk(), BPF_SNPRINTF(), BPF_SEQ_PRINTF() and bpf_stream_printk()
copy the format into a static const array, which the compiler puts into
.rodata. When global data of the object is in arena .rodata is there
too and the helper doesn't take the format:

  R1 type=scalar expected=fp, pkt, pkt_meta, map_key, map_value, mem,
  ringbuf_mem, buf, trusted_ptr_, ctx

String literals are in .rodata.str1.1, which libbpf keeps in a read-only
map. No compiler flag moves a named array there. Put the arrays into
.rodata.str with a section attribute.

An object that uses the macros gets one more map, .rodata.str.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 9d160b5b9c0e..b37b727ef216 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -248,13 +248,21 @@ enum libbpf_tristate {
 #define ___bpf_fill(arr, args...) \
 	___bpf_apply(___bpf_fill, ___bpf_narg(args))(arr, 0, args)
 
+/*
+ * Format strings are in a section of their own. When global data of the object
+ * is in arena (the object has .arena.data section) libbpf keeps .rodata.str*
+ * sections in read-only maps, which is where helpers and kfuncs take strings
+ * from.
+ */
+#define ___bpf_fmt_sec __attribute__((section(".rodata.str")))
+
 /*
  * BPF_SEQ_PRINTF to wrap bpf_seq_printf to-be-printed values
  * in a structure.
  */
 #define BPF_SEQ_PRINTF(seq, fmt, args...)			\
 ({								\
-	static const char ___fmt[] = fmt;			\
+	static const char ___fmt[] ___bpf_fmt_sec = fmt;	\
 	unsigned long long ___param[___bpf_narg(args)];		\
 								\
 	_Pragma("GCC diagnostic push")				\
@@ -272,7 +280,7 @@ enum libbpf_tristate {
  */
 #define BPF_SNPRINTF(out, out_size, fmt, args...)		\
 ({								\
-	static const char ___fmt[] = fmt;			\
+	static const char ___fmt[] ___bpf_fmt_sec = fmt;	\
 	unsigned long long ___param[___bpf_narg(args)];		\
 								\
 	_Pragma("GCC diagnostic push")				\
@@ -287,7 +295,7 @@ enum libbpf_tristate {
 #ifdef BPF_NO_GLOBAL_DATA
 #define BPF_PRINTK_FMT_MOD
 #else
-#define BPF_PRINTK_FMT_MOD static const
+#define BPF_PRINTK_FMT_MOD static const ___bpf_fmt_sec
 #endif
 
 #define __bpf_printk(fmt, ...)				\
@@ -303,7 +311,7 @@ enum libbpf_tristate {
  */
 #define __bpf_vprintk(fmt, args...)				\
 ({								\
-	static const char ___fmt[] = fmt;			\
+	static const char ___fmt[] ___bpf_fmt_sec = fmt;	\
 	unsigned long long ___param[___bpf_narg(args)];		\
 								\
 	_Pragma("GCC diagnostic push")				\
@@ -317,7 +325,7 @@ enum libbpf_tristate {
 
 #define bpf_stream_printk(stream_id, fmt, args...)					\
 ({											\
-	static const char ___fmt[] = fmt;						\
+	static const char ___fmt[] ___bpf_fmt_sec = fmt;				\
 	unsigned long long ___param[___bpf_narg(args)];					\
 											\
 	_Pragma("GCC diagnostic push")							\
-- 
2.55.0

