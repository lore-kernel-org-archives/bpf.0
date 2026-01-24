Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92652580DE
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235659; cv=none; b=Jf6RXjD1K8qbmmZ9FZGdJ21fXv0HwfTc7z+kV+1PzGIMN8o46uQCWO9ojNfY0+EyxC4EPxdFzPgGnMDKqJzMparBUgwAMa/gNY0fV+TkTawNN/zYsYTqgFPiLKjvED59FuWstvfBOF1meBOWDMSoNJySfwd4lSPurBk7QUO57rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235659; c=relaxed/simple;
	bh=K9b/t9XXOnTLdqEXsxRrneyFY/nndVnsOJwQPHo9UMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iq3P4Qaog6a06dN3/FcBj0bukggjxFFJ4DFCG4ibQ5EUa6sfKYH/XokLa39d0lGoFHtUjGHZshs39nNXD/+WXfQ27ERoT8uPVGy5cIC37eOb+lYkuIX2J/f0k1NS5qh/yUDYq0E4KsD2KO6TN5z07bbtZ/6+75KzHdiIrKzC2co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpUgRNGu; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpUgRNGu"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34c3259da34so1689927a91.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 22:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235657; x=1769840457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaR31gnegNovKwQZUAOooLQs9UdrAAfPr7JJtoM3Rv0=;
        b=gpUgRNGuQXt3ZKxIY9oNw/iXv06/d/Zd9CKMYw865VEJKxuRRLgNk9BKzHfdozKfH6
         4S+t7O5Y3Ult/KTWFzJlUFQHHTn3a3SIs0gqH5F9ueYZ214qlYg7ikxVb96UiEOO/R++
         3bBKM9DsWFiw1qFIAM++EzzsY3uDJy7bpK+JylEHk5iIv+0wtWY+CFssYgdkyDMy0Tpd
         IWkRQHBkuDOuNNB8O/HIxRYkSwldg+861NTDEQHJfjUUtddw7zIlE1jc004JSDQawuhN
         eMCOjMGoTg0x6INGmzMEa3Mv58EaKVlPntqkhuaTJrCp2+LIkGHYddZrZeE9qdE+UcMj
         Qykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235657; x=1769840457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uaR31gnegNovKwQZUAOooLQs9UdrAAfPr7JJtoM3Rv0=;
        b=jJ3/chVVK+2tZK6nQxMW33N1he1Mo3K8TzDCCVYHfD2ahCrkdSNvz1nAWTt33mRO64
         Zc60yToFs+8OoGN/lYQz3lkluexTSCNnsb8R68AZPuniO6tn5zv6BmXhfYbILdUQzQ4l
         uVe5R7wTt8zIEnYqU33L41IlFvnWGpqMahGZnmu1MOFVuEKRWXwBfq2LfIR/4mozC86U
         yVBT1pn20bkf3LDRkvRZmZoaLzpxiCeotBvEMP1oCXS90UgPEV2TwDDuG/ArH3j7QGV4
         y868XgosEzQO7nao0o6OTcrSDWqnFgWq+NsOrKPy6lyXHpscl8KYQ3HsEhDdG4EPYhgV
         DW8A==
X-Forwarded-Encrypted: i=1; AJvYcCUGQmfclqklFpQiYNz7uaGngPyonirBiGCHA6X0RroIsLD8C1KUJec8i8YWZkmmS7CIBOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQbkTrSpy69m/TA0W8BWutMalpPKc0Xr3LB6P8S8xgeRk3ZOp
	UWC1V91KRVe8yoZkXvHDhDW2lcqu49yN8aAVmRHhFhaTS7mgkGEi7/QC
X-Gm-Gg: AZuq6aLSv9EhZfxj8rs9LyrojDFUzHQBkCZo4CEOcPzItfhPt2+HqUaA7vNvUXQoE/n
	DFiOFBVPHU+ODpDAMsXJG6XCJysholO0Koso4vij+MEntB8jJguIbf3uNGfd6XDgxQTQuIwQp2A
	sZXdiCcgOsmKWSXbgk4r0SXxI/Bm8HvdLFjB4egmKNQgQh6pINWJfpsCphj/eu3okNWa55SlS/5
	3XE4aR3m2YlrefMwOpLJvpMJfGv/3IaYudX6dkaUx36P2WKH8sJc7yzoZyS+V6/BHOe8NaPGJJm
	tsHRp33ZBgAc76JtANHHiezvpvcAQ3fPFblq8TQXZHKAl35tmKpwdrxEpkT2/K1J63V/xRVVdME
	f16D49NoRXDIlpGTjD8odxnrTzv2ElQJAUGvod2D37TJbq78ggH27I1VfVAn/bF7VvIPwQMemIw
	p84/7RDjAOsnMQ/Lx+YIg=
X-Received: by 2002:a17:90a:c110:b0:340:e4fb:130b with SMTP id 98e67ed59e1d1-3537955a310mr3049399a91.14.1769235657375;
        Fri, 23 Jan 2026 22:20:57 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:20:57 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v13 04/13] bpf: support fsession for bpf_session_is_return
Date: Sat, 24 Jan 2026 14:19:59 +0800
Message-ID: <20260124062008.8657-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If fsession exists, we will use the bit (1 << BPF_TRAMP_IS_RETURN_SHIFT)
in ((u64 *)ctx)[-1] to store the "is_return" flag.

The logic of bpf_session_is_return() for fsession is implemented in the
verifier by inline following code:

  bool bpf_session_is_return(void *ctx)
  {
      return (((u64 *)ctx)[-1] >> BPF_TRAMP_IS_RETURN_SHIFT) & 1;
  }

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v11:
- rename BPF_TRAMP_SHIFT_IS_RETURN to BPF_TRAMP_IS_RETURN_SHIFT

v10:
- fix the wrong description of bpf_session_is_return() in commit log and
  comment
- rename the prefix from BPF_TRAMP_M_ tp BPF_TRAMP_SHIFT_
- remove the definition of BPF_TRAMP_M_NR_ARGS
- use 63 for the shift of BPF_TRAMP_SHIFT_IS_RETURN
- check the program type in bpf_session_filter()

v9:
- remove the definition of bpf_fsession_is_return()

v7:
- reuse the kfunc bpf_session_is_return() instead of introduce new kfunc

v4:
- split out the bpf_fsession_cookie() to another patch

v3:
- merge the bpf_tracing_is_exit and bpf_fsession_cookie into a single
  patch

v2:
- store the session flags after return value, instead of before nr_args
- inline the bpf_tracing_is_exit, as Jiri suggested
---
 include/linux/bpf.h      |  2 ++
 kernel/bpf/verifier.c    | 13 +++++++++++++
 kernel/trace/bpf_trace.c | 39 ++++++++++++++++++++++++++-------------
 3 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 41228b0add52..29eecd79352e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1229,6 +1229,8 @@ enum {
 #endif
 };
 
+#define BPF_TRAMP_IS_RETURN_SHIFT	63
+
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
 	int nr_links;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0fa73d56cb8b..d04aea235a12 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23011,6 +23011,19 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/*
+		 * inline the bpf_session_is_return() for fsession:
+		 *   bool bpf_session_is_return(void *ctx)
+		 *   {
+		 *       return (((u64 *)ctx)[-1] >> BPF_TRAMP_IS_RETURN_SHIFT) & 1;
+		 *   }
+		 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_IS_RETURN_SHIFT);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
+		*cnt = 3;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 13f0a2de33b7..f7baeb8278ca 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1286,7 +1286,8 @@ static bool is_kprobe_multi(const struct bpf_prog *prog)
 
 static inline bool is_kprobe_session(const struct bpf_prog *prog)
 {
-	return prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION;
+	return prog->type == BPF_PROG_TYPE_KPROBE &&
+	       prog->expected_attach_type == BPF_TRACE_KPROBE_SESSION;
 }
 
 static inline bool is_uprobe_multi(const struct bpf_prog *prog)
@@ -1297,7 +1298,14 @@ static inline bool is_uprobe_multi(const struct bpf_prog *prog)
 
 static inline bool is_uprobe_session(const struct bpf_prog *prog)
 {
-	return prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION;
+	return prog->type == BPF_PROG_TYPE_KPROBE &&
+	       prog->expected_attach_type == BPF_TRACE_UPROBE_SESSION;
+}
+
+static inline bool is_trace_fsession(const struct bpf_prog *prog)
+{
+	return prog->type == BPF_PROG_TYPE_TRACING &&
+	       prog->expected_attach_type == BPF_TRACE_FSESSION;
 }
 
 static const struct bpf_func_proto *
@@ -3341,34 +3349,39 @@ __bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
 
 __bpf_kfunc_end_defs();
 
-BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
+BTF_KFUNCS_START(session_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_session_is_return)
 BTF_ID_FLAGS(func, bpf_session_cookie)
-BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
+BTF_KFUNCS_END(session_kfunc_set_ids)
 
-static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
+static int bpf_session_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
+	if (!btf_id_set8_contains(&session_kfunc_set_ids, kfunc_id))
 		return 0;
 
-	if (!is_kprobe_session(prog) && !is_uprobe_session(prog))
+	if (!is_kprobe_session(prog) && !is_uprobe_session(prog) && !is_trace_fsession(prog))
 		return -EACCES;
 
 	return 0;
 }
 
-static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
+static const struct btf_kfunc_id_set bpf_session_kfunc_set = {
 	.owner = THIS_MODULE,
-	.set = &kprobe_multi_kfunc_set_ids,
-	.filter = bpf_kprobe_multi_filter,
+	.set = &session_kfunc_set_ids,
+	.filter = bpf_session_filter,
 };
 
-static int __init bpf_kprobe_multi_kfuncs_init(void)
+static int __init bpf_trace_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	int err = 0;
+
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_session_kfunc_set);
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_session_kfunc_set);
+
+	return err;
 }
 
-late_initcall(bpf_kprobe_multi_kfuncs_init);
+late_initcall(bpf_trace_kfuncs_init);
 
 typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
 
-- 
2.52.0

