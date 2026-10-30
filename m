Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361148;
	b=DvH1ouUh/A8RsGj4FPR1c1fYcT7ULvxqBmkHWsGXR146r52LuAwPh2wGUkR+MrHtRylS
	 T0tE/kYPchbF1OEeFPvWCGGN48cCV4B0Qu6XUjbL7xRe5hgWckK9JbyZ5/zuhqlYMQIAW
	 CZKEOXa1FEcc0HdWjJjuT5MJwAQdz3hfFiXsPUqeDqGAhLso8JufUhpTAlfX99uvqVROJ
	 hHqCUW14BGmpPGMg1NfRfb7+9bk8NCZcGRjhCoXS+7TCMswNpNTrPy50ecsgsYgLofiRn
	 ToPcf2JmgrHE7lk0Zfq401DJOJBAHYaHKfyPRO07R41j6gBZPiu4qV2hp1jEmFWLksQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=xlFJ7GxYpC5EWMxIsQaH4NQ1xOX2nqD7BFPSqffaoss=;
	b=4r1g3hvzxohaZ3VxHY4wiyYnHNoe4Yy3KfgOGSF7QFxAMXpxMW8QMTimdCZnHJJzbwCp
	 RMHR8Om/zb2ZMJlAnwSCacNTzdxEeNyHfuWsGjQOZdAkCDEMIrxvv7LFK4eMWGEobYPou
	 Zyff40YYiL2GWTdw83IKIgL6JGdQqlw8ClxNtAXfPd5z6EN5q2yrEpKMc82m8KijYGRXC
	 BKuPhm/rn6BnbXamzWLa5BP/s4naWYyM0u2+2Lf++vniv/IytmGguVfrLVTlBR6jOpBrK
	 au5ZR9xQT0qlT0yizoikfnS6F9G5Drl57A416lh4lcph+m1hz2reiPKtbAe1wxxltjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tn3+2EVE;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98965606A31C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98965606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tn3+2EVE
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-15943c9c005so1060566c88.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361147; x=1793965947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xlFJ7GxYpC5EWMxIsQaH4NQ1xOX2nqD7BFPSqffaoss=;
        b=tn3+2EVE9VsxwlCaUiZdSdLVlwb/v0LnryO6LnbLY8j3QiEm6249BpnLNTY/KWFTdt
         66/QA3JH0cBHo6rKkhoE2LBCdyA/1rhThK85SvImlToRzwA99LWFZRP02smBQOva3oZh
         qxsrSiPZ9AehYWd4zQwLTCnAWEmJY+iQYFHkxMyqq/X1rPn6iFv6Hur0GfWkg1OKQQJv
         q0UlblrOJX+EinwDNmE3Au0C73k6pONf8AlMXmXWBIYVzPdVS+5u8PMQPfvgtlUgNkdl
         nUTAm8kvFYudk85w+QJdyBX13wAMGyXsist3Qpp4hI/f5yrGgOn7U3GIaASV8uxrj/jE
         bAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361147; x=1793965947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlFJ7GxYpC5EWMxIsQaH4NQ1xOX2nqD7BFPSqffaoss=;
        b=J1FGWAW7L7Dld9x7GroF6geACEh7dOP5EmL8WasPe+azt9XRfyg/r1m07Sz6QokPV4
         WpPAjGkM0XUB+CBqDe1p3RSrbO4+UR6KyOx+u/xgrNtMN5u6TZx2lbKx2joiDPI93jEs
         AYUB/6WMSBBH8KCT1ahIt6I8wSdUd7bIFIyKYYgirk8id8CSvmdpruqu5LgqsbZ77QfL
         mH4UKES1MaTWxhDdR4Prcsr5F3R3vPUT8sJstOg+uv2dXLH6HesiHW/sadV3BmgOnIfF
         zGIKbaBH2WXVDrGX5IDHM+C4+kguELmMKL5LrUF9oz2apKtjFhS/IunFMPExUZCpTqW7
         bMSg==
X-Gm-Message-State: AFq9FYJ6Jd7egGHIzgX7eMFm6PKmRLX/YEt2bMedXu5XxWazrBjm58gh
	UXOCzxVeThgsEx2GW8JgVPYmBPf49Z4FbxvDIwXLFRzuzNfuF10JP7i1
X-Gm-Gg: AYBFou0EVopNuBsjTH2uDFekuShOvCMU5Whu3A37zfk4X8rugnBRIKwcm+yKElkEFkO
	zaYgNkcmCDwnFCXBQKJpYNZtjobzEKOFJxpTBVXOtqg1oa/smX8lOfE0yOcxYp7UsN3L1c4cWh4
	WGAuXvcsq/acMSmehREP1mbY27pKSHW7fjm/n2W9xvLhwgwHEnEPt7umiuR6di6CQsJT0y/p9k3
	/3SWQl4m63ywT+YfJYUuJRp1N6Njoz+XUleZqDP/l6NODN/Zl5FHOY+NB6MuuWDytPp9yqeMni2
	Lc7CRVw5gKDzTMkAnOr5mnMLbXCAh0Voef8BMePA+FLX5VZc5s1vpxCpoVm+Zyx7m/IkG8XfD8M
	Q38KXc7oCTdbqtNzl+g2Hg4V2YPhAiY6UkC1XWtw2fSrnGoIS5mgyxELWhpNvk7UxLsYy8rtVjX
	/h4LpUTaaO+OovWJQiyG0+hOLrAtw4TwrTVGMOk+n8fLt6grtEob1djf05hCiWlkecyPM+TDvFB
	JSOzHFftFBY4rN/P8MaPeVV4SxlEjoWW+RQFgzZLbG4fpefG76CrjoGlByxJSwiPbFYMbdWGCDX
	Ktqd1WOb0gBHzhCMu/B27kmtBcbs1WFO2xjMQy9m9B0kwQ==
X-Received: by 2002:a05:701b:230f:b0:1ac:d029:70b5 with SMTP id a92af1059eb24-1acd029740cmr1979637c88.33.1793361147478;
        Fri, 30 Oct 2026 04:52:27 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:52:27 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:51:50 -0400
Subject: [PATCH bpf-next v2 05/22] bpf: Expand a backward may_goto to gotol
 when patches push it out of range
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-bpf-verifier-patch-batch-v2-5-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

may_goto_expand() turns may_goto into a conditional jump with a 16-bit
offset, or into gotol when the offset of may_goto doesn't fit in 16
bits.

bpf_do_misc_fixups() picks the jump from the offset of may_goto in the
unpatched program. When the patches queued between a backward may_goto
and its target push the offset out of the 16-bit range, the commit
fails with -ERANGE, as bpf_patch_insn_data() did before when applying
those patches.

Add the growth of the patches queued between a backward may_goto and
its target to its offset, and use gotol when the result doesn't fit in
16 bits.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 kernel/bpf/fixups.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index c9963d8d81356..1d281428acbb3 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1968,16 +1968,21 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
  * may_goto when it is zero, then the tail that updates the count.
  * Use gotol when the target is too far for 16-bit offset of a conditional jump.
  */
-static int may_goto_expand(struct bpf_insn *insn_buf, int off, int stack_off,
-			   const struct bpf_insn *tail, int tail_cnt)
+/*
+ * 'off' is the offset of may_goto, 'reach' how far it jumps once the patches
+ * in between are applied, which decides whether a 16-bit jump will do.
+ */
+static int may_goto_expand(struct bpf_insn *insn_buf, int off, int reach,
+			   int stack_off, const struct bpf_insn *tail, int tail_cnt)
 {
 	int cnt = 0;
 
 	/* Forward jump has to step over the tail */
 	off = off >= 0 ? off + tail_cnt : off - 1;
+	reach = reach >= 0 ? reach + tail_cnt : reach - 1;
 
 	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
-	if (off == (s16)off) {
+	if (reach == (s16)reach) {
 		insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, off);
 	} else {
 		insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 1);
@@ -1987,6 +1992,23 @@ static int may_goto_expand(struct bpf_insn *insn_buf, int off, int stack_off,
 	return cnt + tail_cnt;
 }
 
+/* The offset of may_goto at 'idx' once the patches queued in front are applied. */
+static int may_goto_off(struct bpf_verifier_env *env, const struct bpf_insn *insn,
+			u32 idx)
+{
+	struct bpf_patch_list *pl = &env->patch_list;
+	u32 tgt = idx + insn->off + 1;
+	int off = insn->off;
+	u32 k = pl->cnt;
+
+	if (off >= 0)
+		return off;
+	/* all queued patches are in front of idx */
+	while (k > 0 && pl->patches[k - 1].off >= tgt)
+		off -= pl->patches[--k].len - 1;
+	return off;
+}
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
@@ -2281,8 +2303,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			 * after subtraction, rinse and repeat.
 			 */
 			stack_depth_extra = 16;
-			cnt = may_goto_expand(insn_buf, insn->off, stack_off_cnt,
-					      tail, ARRAY_SIZE(tail));
+			cnt = may_goto_expand(insn_buf, insn->off,
+					      may_goto_off(env, insn, i + delta),
+					      stack_off_cnt, tail, ARRAY_SIZE(tail));
 
 			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
 			if (IS_ERR(insn))
@@ -2296,8 +2319,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			};
 
 			stack_depth_extra = 8;
-			cnt = may_goto_expand(insn_buf, insn->off, stack_off,
-					      tail, ARRAY_SIZE(tail));
+			cnt = may_goto_expand(insn_buf, insn->off,
+					      may_goto_off(env, insn, i + delta),
+					      stack_off, tail, ARRAY_SIZE(tail));
 
 			insn = bpf_patch_list_add(env, i + delta, insn_buf, cnt);
 			if (IS_ERR(insn))

-- 
2.43.0

