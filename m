Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4B30DED0
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777412438; cv=none; b=Iqszz3KQiYMnAOZXDo3EKvv1ethBQQoN3VlsjoaCQ2Wd/tMVhsrmAAHmaGPSH+wXQwzcJfgvx4QJY8l8ExFLB2ouBSLXTYqdQSjYyRZLjwDCV+k0t8839ysOxovUO7mv57ngbEi5w5cB/YGKipoOE64gYW/unsMAvf4losQjZ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777412438; c=relaxed/simple;
	bh=fbYi3QUUQBxlyQJ01NoB2UOdsO5DrCrksD/Fg1aM4Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKMdrDfVSm+ss/OiK4Mz7G6QmXsp5NMkF/jccL55riqLAAstvdspuQHUf7+Zy9buuE4UbltlupQRcs9x68BB7ef0ItckfvSzVR3a/h8iTCZFS6cYQk7YB8sPweWB1UI4nmSDorVNrbmVOAI4hqjXM8/gVqiLkd3v0cEKhri3MCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYuCdVy9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYuCdVy9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891cd41959so102350925e9.3
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 14:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777412436; x=1778017236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OehKOwG7cKXwb7gI5jO4YqYLmS0w0kxoSW4mo5oDqPw=;
        b=eYuCdVy96NKFt8o2hayD2HWr8/uqE5kr+EU2DDmHskBax9llp+xIHM/J02ma8FSSSl
         aycS39rv5XKayoD7udbKz2oL9HEPpMe88PHIOsg+nLVDPGSYeS13FhwN9N2L4hUf9tJa
         h9lL67ydbutulywRBPwEyxAFRklppAcaayT01kijTCwGCFgPn70EZ/IIdhoSvHmR+som
         X5T3gZt4prXoWWoUSS3WNI+IVtc0giIVPT1YO4KGCwMZOneTrbewwE9UtkEb1Tyg3oUw
         6bLcs+P86AX0MycZ4eXDCiboOur1xmGERpC29CbCqLDfKVIloSiMwMu7sIw7FkoHS9mR
         Tm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777412436; x=1778017236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OehKOwG7cKXwb7gI5jO4YqYLmS0w0kxoSW4mo5oDqPw=;
        b=gXdUEQVC3VVxWolNFJIV6zFu31z7YVutjLVD58nAZuzKRqsNRsw2uzU/+wwfS6nA92
         czMOg5RMaOif5rTlTPzkHOn8i3PeioNF0lHeOVg/OR0nCNgMsKspsr25Z2VKqVoM9tat
         in5TNSqqDyXeZcCc7A/VcwnS7z8/b11rg08T+KgsLhIGmguldO944cyyb6A47hjmzMKd
         pzhGXzk7MvXvZ5P0ry5z+sMRxvN3PegeH4uDR+YA1HQJDt9vSsFmVMlB7CxN1W4MVLg4
         0Jl/49qyvJNKK5cq4yQa18GvU0s/cz22Q3iY/AzRTIGdf0NnUnsHoCBlV61VYpxZvxkx
         hOOA==
X-Gm-Message-State: AOJu0Yxt1JMzz587Ptrmu42d6FD9TcI2RPNkkhvMheZM5chdcFftWBZX
	aD4DGATvex/hiC/Ad89YD7jm08stGNrEot80vylGybvQwNPJhY5u83taYCJ6cw==
X-Gm-Gg: AeBDievcCwjiFf7a+vFNfZxHmzPcLYe8fcYsDtlVkD8yw2AxxfFWLeIyCm+W4/kJXME
	pBTyhJydpNJG2cAYIXi9+0z9yweR39TR304Zv8d0IRDQomgGnNJxlqt3DKXYFfwNBPH8TOfluum
	D25wUb4LNDIH4jwFbEF02yfTI++JJqoasoL6SguNZrY57iSZn+diTXKDrg5bNLS1s2NkgiT0Zc5
	V8GU+b2TmZADsNhSCbgBp55y4qKCs4NzvZTJ+YOeuCV4sAwXVCFwFnKY+/DWaiqyh39xOj9nXle
	yWasdfZRLt/gBRqbk902CRx3ZngTQVM4SpJl2ZLYae4SSrBlTf3Xp33OpyZbCXFP2MwdcHcF1aI
	C9N5GHB3O9PBmr9is0faNOyaRCLUOcdsd34tzWbahuxhGbKdGEPKEytfzsWFFrWVD3BoBUJgUn6
	0+p0GDhHhkngY437jyDUcOygPa2h+tQJ+HHBATZHWHGP9xLTZOu31m5l38cBSNEuv1ryu/kYibG
	ZtSQIvSUqY6JxnLKYETH6loqMxiwoiOc3q9iWkQ7OlRccsQ4rtxQm9tGeJZ2VLaI0uC9YeBubE0
	ALOgeSjlc0cUUbOTCMRL1TGoeZlqv7Ij0AFk5MzXIfpDLCdJp9SK4w==
X-Received: by 2002:a05:600c:4fcd:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-48a77aea3ddmr74906185e9.13.1777412435601;
        Tue, 28 Apr 2026 14:40:35 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e004dbd7290f8ae2339.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:4dbd:7290:f8ae:2339])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc11fcbsm14257215e9.3.2026.04.28.14.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 14:40:35 -0700 (PDT)
Date: Tue, 28 Apr 2026 23:40:33 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test insns processed breakdown
Message-ID: <24f2a5b5f8e3041d03d78305ca0e2277f684d588.1777398528.git.paul.chaignon@gmail.com>
References: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777398528.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777398528.git.paul.chaignon@gmail.com>

This patch covers in global subprog selftests the new verifier log with
the breakdown of instructions processed by global subprogs.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v2:
  - Adapted the tests to pass on cpu=v4 and alu32.

 .../bpf/progs/verifier_global_subprogs.c      | 55 ++++++++++++-------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 1e08aff7532e..7092a046c018 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -46,7 +46,7 @@ __noinline long global_dead(void)
 }
 
 SEC("?raw_tp")
-__success __log_level(2)
+__success __log_level(6)
 /* main prog is validated completely first */
 __msg("('global_calls_good_only') is global and assumed valid.")
 /* eventually global_good() is transitively validated as well */
@@ -86,7 +86,8 @@ __noinline int global_unsupp(const int *mem)
 const volatile bool skip_unsupp_global = true;
 
 SEC("?raw_tp")
-__success
+__success __log_level(4)
+__msg("insns processed 5")
 int guarded_unsupp_global_called(void)
 {
 	if (!skip_unsupp_global)
@@ -142,7 +143,7 @@ int anon_user_mem_invalid(void *ctx)
 }
 
 SEC("?tracepoint")
-__success __log_level(2)
+__success __log_level(6)
 __msg("Func#1 ('subprog_user_anon_mem') is safe for any args that match its prototype")
 int anon_user_mem_valid(void *ctx)
 {
@@ -159,7 +160,7 @@ __noinline __weak int subprog_nonnull_ptr_good(int *p1 __arg_nonnull, int *p2 __
 int x = 47;
 
 SEC("?raw_tp")
-__success __log_level(2)
+__success __log_level(6)
 int arg_tag_nonnull_ptr_good(void *ctx)
 {
 	int y = 74;
@@ -186,21 +187,24 @@ __weak int raw_tp_u64_array(u64 *ctx __arg_ctx)
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
@@ -214,7 +218,8 @@ __weak int tp_whatever(struct whatever *ctx __arg_ctx)
 }
 
 SEC("?tp")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 7+5+2")
 int arg_tag_ctx_tp(void *ctx)
 {
 	return subprog_ctx_tag(ctx) + tp_whatever(ctx);
@@ -231,7 +236,8 @@ __weak int kprobe_subprog_typedef(bpf_user_pt_regs_t *ctx __arg_ctx)
 }
 
 SEC("?kprobe")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 12+5+2+2")
 int arg_tag_ctx_kprobe(void *ctx)
 {
 	return subprog_ctx_tag(ctx) +
@@ -266,7 +272,8 @@ __weak int perf_subprog_canonical(struct bpf_perf_event_data *ctx __arg_ctx)
 }
 
 SEC("?perf_event")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 15+5+2+2+2")
 int arg_tag_ctx_perf(void *ctx)
 {
 	return subprog_ctx_tag(ctx) +
@@ -286,7 +293,8 @@ __weak int iter_subprog_typed(struct bpf_iter__task *ctx __arg_ctx)
 }
 
 SEC("?iter/task")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 8+2+2")
 int arg_tag_ctx_iter_task(struct bpf_iter__task *ctx)
 {
 	return (iter_subprog_void(ctx) + iter_subprog_typed(ctx)) & 1;
@@ -305,7 +313,8 @@ __weak int tracing_subprog_u64(u64 *ctx __arg_ctx)
 int acc;
 
 SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 12+2+2")
 int BPF_PROG(arg_tag_ctx_fentry)
 {
 	acc += tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
@@ -313,7 +322,8 @@ int BPF_PROG(arg_tag_ctx_fentry)
 }
 
 SEC("?fexit/" SYS_PREFIX "sys_nanosleep")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 12+2+2")
 int BPF_PROG(arg_tag_ctx_fexit)
 {
 	acc += tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
@@ -321,14 +331,15 @@ int BPF_PROG(arg_tag_ctx_fexit)
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
 int BPF_PROG(arg_tag_ctx_lsm)
 {
 	int ret;
@@ -339,7 +350,8 @@ int BPF_PROG(arg_tag_ctx_lsm)
 }
 
 SEC("?struct_ops/test_1")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 7+2+2")
 int BPF_PROG(arg_tag_ctx_struct_ops)
 {
 	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx);
@@ -351,7 +363,8 @@ struct bpf_dummy_ops dummy_1 = {
 };
 
 SEC("?syscall")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 12+2+2+2")
 int arg_tag_ctx_syscall(void *ctx)
 {
 	return tracing_subprog_void(ctx) + tracing_subprog_u64(ctx) + tp_whatever(ctx);
@@ -369,7 +382,8 @@ __weak int syscall_array_bpf_for(void *ctx __arg_ctx)
 }
 
 SEC("?syscall")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 2+58")
 int arg_tag_ctx_syscall_bpf_for(void *ctx)
 {
 	return syscall_array_bpf_for(ctx);
@@ -394,7 +408,8 @@ struct {
 };
 
 SEC("?syscall")
-__success __log_level(2)
+__success __log_level(6)
+__msg("insns processed 5")
 int arg_tag_ctx_syscall_tailcall(void *ctx)
 {
 	bpf_tail_call(ctx, &syscall_prog_array, 0);
@@ -471,7 +486,7 @@ __weak int subprog_dynptr(struct bpf_dynptr *dptr)
 }
 
 SEC("?xdp")
-__success __log_level(2)
+__success __log_level(6)
 int arg_tag_dynptr(struct xdp_md *ctx)
 {
 	struct bpf_dynptr dptr;
-- 
2.43.0

