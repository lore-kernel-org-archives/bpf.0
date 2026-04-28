Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88BF441037
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388146; cv=none; b=GHTYw0LjQAe0OkKk1KoSBzrRelEHFhP9O8HDTUGnFSE+/ZzzqbQUFqJKeGU1EzkGiCpt+UNvyKU5C8g2lmmZrow+0r70n9I1P76g4DIn6Ugu4/Lr04c+YqHLGj0ea2O2+ibN+6MqhMbDS7JweAL/gLH5Z8S03UyGAPhCSs65HEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388146; c=relaxed/simple;
	bh=PdDWFzw81l0GsH38DkKlqIYdqfQpj1JE8Wpnfq8O5i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tv8W0y1JrONxsA4wYMOKRU0KBbGNmvMWVZNexIlQMQk8xqmg2W5Kx8y/TTOYtSisBrTZRfFzObr1BM/avt35v233xqQ5m6vlhcKrKqV5QdBJfwnAB2JxsDt9UbhUu1y48x0zbI8ub2uo33EdH/uTp3Ms25CR7etXPsXKTZ0wgU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YijnXylv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YijnXylv"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so9448295f8f.2
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388143; x=1777992943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gy+Bj5Jvyjnx/aK2dlrsxvghM8Pu1GdFdW2d4Imv1Ns=;
        b=YijnXylvBDf2KqIlgzJ2/IlbipLqtCJYTZZJv0hGVf7ih3R6OELciteO95jrnLIL5i
         WZSofFSS+PZPv16YMvTGeFnFFqFr4D0Keau7FQgqvr8HXlx3eMqfw8sG2pDeRbcFNLvy
         jjvfGS4lyowpdxmLYzTLSS18N9CEQEnhqdvai49OgL/2kNp5po0Ww/mlf9ig6vcq4l4V
         RkgFoiMAhNQFAOk3SPT5N9aDRKHS0MiCpDbkyIXhVm0iHCWJNh1d5yRGhcFEJS1wC66o
         Mi01ytwjW2KWYweBATmC79IidJxHVzEnT9wZVwA2+O90wClBjRovSvbjYt+4IWmJwijp
         p2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388143; x=1777992943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gy+Bj5Jvyjnx/aK2dlrsxvghM8Pu1GdFdW2d4Imv1Ns=;
        b=T4628x+WVZ6OQ8y1npI3mUooex7MW4MI/HZdGZOHHyoF9tKrlBC0tgcxUlnPL/Ah+h
         w4IPL6Lxg3lctOe03U2hrKIK+mLv4RCe0jjPxKeH1IWQW3sAzIaLHJEJkJ5AzPU9U9gX
         Nv7lf/Fhyz/1vq8SJJvONqQsVzOlmE4tU/3McDc+KFkDZ0XH5hTnNCjKk3fWBHMwkZ4l
         NdCS4K+MBXTzw+9nYhCry7+ns53ytGniPu8j3VRBMPf5jS4l0EuzcZ24LQ8kVvoUlgzb
         RzVNOd+iwftIlS0n7yxaHnE8dHPUZm5ny4hJXGeCizOI7kUfcVewDEgNW7gdO8fMlFhd
         zUeA==
X-Gm-Message-State: AOJu0Yy3Ks4JTUeMS2QY4o0l+5Fv/6FgD+jHfx+RHSVYQhUKgIWPoHvB
	NGLTpk3KDGyrDBG+ASo8DlCZ6nDdC93S7F+zRTwICV1r3D0PR+snAy0F8LUv1Q==
X-Gm-Gg: AeBDieuS0mlQ3sWZl+LizyG03E0z7PmrupshX0v6/yXIp4l+dgiY/q4Azibec4SK3RE
	7CW8cjSrmTxvHC279QvXwrXjJzAQXuBk1o8jXtrIZjTZXp59lPAWMjW4bdxcnLFjVXMQ9qZ+Ulm
	q1nYw+UsjWgjncIuLw0CAJg2rSvMCFW0yVk6P0Ku3ObXGlKRxJoAzBgJQUDE3awQ4zwOGJadHed
	l+eYWnkJR3G7x8qgpVYB+xncQcWrEH43NXytliqvE//dPliFtDHdI1zTK1shtZTy5JGwWfoh1fl
	ed2tcv/C8ym2y49VnCzhnjk2Aux+KXRimsOmeCiUsrHG+YxOBxeQldWeLgnpFNhSl5WZ4aZLsM4
	EyJJOpGJhJvAgm318HQ++8JWtIIU7pWMsEMh7v3yPmYpPUKyZSyJNFfibSkBPTNC54wjHm3Qktv
	1xHgz2ZmL1zosjlDmDTLWRnNYJjWq6y0saeMqfP3s1sXW1BWVG2tzgtT+dQq0+XQOO4jBGqGrIt
	bwFzTQsnWMAc6rPAGI6XXoshQEO0SCzEqitOQpqpQd5jEdIAwt6FKqhMM9ZNK6mKCN7fMIpmvgR
	V/9mPVKWqOFocdP9Qf0e8uvEH36Wuxtg0APHTZ5Edk5/ewuawSbM
X-Received: by 2002:a05:6000:24c3:b0:439:beb9:5a96 with SMTP id ffacd0b85a97d-44649ba1e97mr6455652f8f.31.1777388142755;
        Tue, 28 Apr 2026 07:55:42 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0059b820af0e4d43c8.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:59b8:20af:e4d:43c8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463f4c0a35sm8024311f8f.22.2026.04.28.07.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:55:42 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:55:40 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test insns processed breakdown
Message-ID: <30df9a4d569143e1d23a7c7aefd7dca85a21e2c8.1777388107.git.paul.chaignon@gmail.com>
References: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777388107.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777388107.git.paul.chaignon@gmail.com>

This patch covers in global subprog selftests the new verifier log with
the breakdown of instructions processed by global subprogs.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../bpf/progs/verifier_global_subprogs.c      | 60 ++++++++++++-------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 1e08aff7532e..58faf5485667 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -46,12 +46,13 @@ __noinline long global_dead(void)
 }
 
 SEC("?raw_tp")
-__success __log_level(2)
+__success __log_level(6)
 /* main prog is validated completely first */
 __msg("('global_calls_good_only') is global and assumed valid.")
 /* eventually global_good() is transitively validated as well */
 __msg("Validating global_good() func")
 __msg("('global_good') is safe for any args that match its prototype")
+__msg("insns processed 7+2+5")
 int chained_global_func_calls_success(void)
 {
 	int sum = 0;
@@ -86,7 +87,8 @@ __noinline int global_unsupp(const int *mem)
 const volatile bool skip_unsupp_global = true;
 
 SEC("?raw_tp")
-__success
+__success __log_level(4)
+__msg("insns processed 5")
 int guarded_unsupp_global_called(void)
 {
 	if (!skip_unsupp_global)
@@ -142,8 +144,9 @@ int anon_user_mem_invalid(void *ctx)
 }
 
 SEC("?tracepoint")
-__success __log_level(2)
+__success __log_level(6)
 __msg("Func#1 ('subprog_user_anon_mem') is safe for any args that match its prototype")
+__msg("insns processed 6+5")
 int anon_user_mem_valid(void *ctx)
 {
 	user_struct_t t = { .x = 42 };
@@ -159,7 +162,8 @@ __noinline __weak int subprog_nonnull_ptr_good(int *p1 __arg_nonnull, int *p2 __
 int x = 47;
 
 SEC("?raw_tp")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 7+4")
 int arg_tag_nonnull_ptr_good(void *ctx)
 {
 	int y = 74;
@@ -186,21 +190,24 @@ __weak int raw_tp_u64_array(u64 *ctx __arg_ctx)
 }
 
 SEC("?raw_tp")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 12+5+2+2")
 int arg_tag_ctx_raw_tp(void *ctx)
 {
 	return subprog_ctx_tag(ctx) + raw_tp_canonical(ctx) + raw_tp_u64_array(ctx);
 }
 
 SEC("?raw_tp.w")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 12+5+2+2")
 int arg_tag_ctx_raw_tp_writable(void *ctx)
 {
 	return subprog_ctx_tag(ctx) + raw_tp_canonical(ctx) + raw_tp_u64_array(ctx);
 }
 
 SEC("?tp_btf/sys_enter")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 12+5+2+2")
 int arg_tag_ctx_raw_tp_btf(void *ctx)
 {
 	return subprog_ctx_tag(ctx) + raw_tp_canonical(ctx) + raw_tp_u64_array(ctx);
@@ -214,7 +221,8 @@ __weak int tp_whatever(struct whatever *ctx __arg_ctx)
 }
 
 SEC("?tp")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 7+5+2")
 int arg_tag_ctx_tp(void *ctx)
 {
 	return subprog_ctx_tag(ctx) + tp_whatever(ctx);
@@ -231,7 +239,8 @@ __weak int kprobe_subprog_typedef(bpf_user_pt_regs_t *ctx __arg_ctx)
 }
 
 SEC("?kprobe")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 12+5+2+2")
 int arg_tag_ctx_kprobe(void *ctx)
 {
 	return subprog_ctx_tag(ctx) +
@@ -266,7 +275,8 @@ __weak int perf_subprog_canonical(struct bpf_perf_event_data *ctx __arg_ctx)
 }
 
 SEC("?perf_event")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 15+5+2+2+2")
 int arg_tag_ctx_perf(void *ctx)
 {
 	return subprog_ctx_tag(ctx) +
@@ -286,7 +296,8 @@ __weak int iter_subprog_typed(struct bpf_iter__task *ctx __arg_ctx)
 }
 
 SEC("?iter/task")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 8+2+2")
 int arg_tag_ctx_iter_task(struct bpf_iter__task *ctx)
 {
 	return (iter_subprog_void(ctx) + iter_subprog_typed(ctx)) & 1;
@@ -305,7 +316,8 @@ __weak int tracing_subprog_u64(u64 *ctx __arg_ctx)
 int acc;
 
 SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 12+2+2")
 int BPF_PROG(arg_tag_ctx_fentry)
 {
 	acc += tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
@@ -313,7 +325,8 @@ int BPF_PROG(arg_tag_ctx_fentry)
 }
 
 SEC("?fexit/" SYS_PREFIX "sys_nanosleep")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 12+2+2")
 int BPF_PROG(arg_tag_ctx_fexit)
 {
 	acc += tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
@@ -321,14 +334,16 @@ int BPF_PROG(arg_tag_ctx_fexit)
 }
 
 SEC("?fmod_ret/" SYS_PREFIX "sys_nanosleep")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 7+2+2")
 int BPF_PROG(arg_tag_ctx_fmod_ret)
 {
 	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
 }
 
 SEC("?lsm/bpf")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 11+2+2")
 int BPF_PROG(arg_tag_ctx_lsm)
 {
 	int ret;
@@ -339,7 +354,8 @@ int BPF_PROG(arg_tag_ctx_lsm)
 }
 
 SEC("?struct_ops/test_1")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 7+2+2")
 int BPF_PROG(arg_tag_ctx_struct_ops)
 {
 	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
@@ -351,7 +367,8 @@ struct bpf_dummy_ops dummy_1 = {
 };
 
 SEC("?syscall")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 12+2+2+2")
 int arg_tag_ctx_syscall(void *ctx)
 {
 	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx) + tp_whatever(ctx);
@@ -369,7 +386,8 @@ __weak int syscall_array_bpf_for(void *ctx __arg_ctx)
 }
 
 SEC("?syscall")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 2+58")
 int arg_tag_ctx_syscall_bpf_for(void *ctx)
 {
 	return syscall_array_bpf_for(ctx);
@@ -394,7 +412,8 @@ struct {
 };
 
 SEC("?syscall")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 5")
 int arg_tag_ctx_syscall_tailcall(void *ctx)
 {
 	bpf_tail_call(ctx, &syscall_prog_array, 0);
@@ -471,7 +490,8 @@ __weak int subprog_dynptr(struct bpf_dynptr *dptr)
 }
 
 SEC("?xdp")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 8+27")
 int arg_tag_dynptr(struct xdp_md *ctx)
 {
 	struct bpf_dynptr dptr;
-- 
2.43.0

