Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984033;
	b=Edf6L+kBlvJ/FRM+xo9EUH1G/24Y/hOnjbdjy+IceUsOnQxhj5B5lZ8SBIXZDMCyqeiD
	 nwpHITyRVEarw5XVHdImAeDiIiQGWUuC7rwhZngSmgo+A5lCtoyUC82opjtVLGhi+yBNd
	 E/a0WuPgfl84Ks38RlAITAZq0avhpAhItMVDUiSsI1UhUtb2pEpz46Ov4xReAEX7q5y7r
	 DrUVZFgEBk/MpWuoRZiahSo+Sv3kAxpqmzZ3fw0Xk9KsZZWdRZpIrRuKIJkkI3G5bWf/D
	 vIzT95oWmTaxLEjvDRH7KbMgLcF69N3yfDSmudQFM0OLvDJ2MQuB2bsH/hDjBoOz8hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+g0b4qfKP7oF+S4jHHIGmbg1Y40sfiaQvlXl2ZUMQzM=;
	b=lGlTdX5GiD6IXJ3y1Qp8sz5D1SEWDb9dc+cI0U7KOcg/o/zdwh2XxV8WJHQpEzra9zm9
	 dyDh9kW8f2KQ/+JAXJCzsCfAARNS602Ypfqz/TN5xFrCGvWdTFs7s5AdvFQeo4UNalOix
	 gM/jYHkzKRrFiGRkcVUZm0otSvJUDPyZQUFDG+YxSMSPD/4Q5b3aQe4uBbpQjUvg8NHsw
	 VuHle7zLSKbJNc5qQmCBd1kD3BUxI3UT8reakQN6nGd7ihumq0ARxN1PAbngaILalAOI0
	 I3gbTywyWGeFm95bnBo3h5aBYpsRT5aPTF1CuWGgZ1p/XjeFJYOBdhEmxIWx1dAcQ5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ohI+bk6A;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B4606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D05B4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ohI+bk6A
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso1283933a12.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792984032; x=1793588832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+g0b4qfKP7oF+S4jHHIGmbg1Y40sfiaQvlXl2ZUMQzM=;
        b=ohI+bk6APp6FLG8T3n0nEMkhH6iKy2SUAZQpnjlY44pfLQWLA8NEWgHvJzZGjnKQC3
         0OedlsGGgYMVAfVDRsj0/gNT5CahITmojhmuPhNUHGUS/SzmHDwsub2qN+jwm4bO7xJG
         dxNxQIajI8hKBFfNJB5+y/cMNOPlWGACpkcSTdOZxj6BMcTg4v6/K9MRLZ3Yq7O2eWAb
         qOu6cce/1z2RWF7RsWZh64c4hryKgJzowQNsBK9tykd7iX5AYhqX1up3+1IlnLm+23ZZ
         wHN4WPiL2yNmFihwrxq3l+wMYNlnAuNvVdVP4Nikm5JpE+xkuz0LUo5BJcuT7I/6EvSV
         Uo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984032; x=1793588832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+g0b4qfKP7oF+S4jHHIGmbg1Y40sfiaQvlXl2ZUMQzM=;
        b=P6JQGNCBIor5CKvcaUIr7XE5O2ReG0w6BKP7iwCxhfaEx+EiEwe/uC4uTQo6u4ZGhf
         beaQA9kYnHFaUidWkanNU6sOR2cBFAGc7qGMJ/Ry15r0QtvKcVVluooM8sasNOT02ltj
         cds5DaTN37O0pqs3Nu5VMYG8OtthMt8JX1B1c7BCbjQv72vLflC8RNZUhuy73zr00SHb
         2+SYTXsfjVjyy1oaEDqTnCi24qXDK9IQNl2Vgtl4dl0fWxtd6IDXau20Jqk+H9LdRfCW
         fP9jdEZ3WSnFXJPWCWAytstcpQfZIoHs7BoawKPZQZQogfwD5AHzE4u0annhp800D4T+
         mbkA==
X-Gm-Message-State: AFq9FYKR5asUutNqUpbypmpj+89Jwq3ShMmLrzuzT6AhIxz3tfnSvPoP
	wix8wvQpzkWrXAZdtslh4vSMiUvDqsqFd5LpiPoNbkZ2rfvbxEejZDVYoDvmOw==
X-Gm-Gg: AYBFou04hpylz4B61ZSEavJaLQKbqIOuT1NQ4uqWeQ//ippnPG+Ygpg8VhmsfzOnXGs
	gAW2odCyo/PbgdKtUEFsPqjtK3hMetmqh1DtnK9Op5ZqSws3+ubQcoZZzxudxRVMLs8dJdwH/CY
	VU/QIpicOV4jpa+XgnujzYLOYU2GzXm9FF0S/UufQmx7nC6rqbR1/6mm64CNC+LDFuDl9g68RuO
	pRBJFXdpAecn5JTaGFmlBvU0/4443HIaikb9XoSFxNQMvBPldZ7czBNrdO1T4T6n1nvCQcBYk6C
	erMK57I2bq2j5TQx4b2GlfrlzQe+t6SXBfFKF1fJtHTonzJ1GPoYu38O/csWY4hV5EVFJA8/Zuk
	Ac7CcHD3qtrwpMBl2IVLEE5OaNtmeZvkPu1VzfcSnoAzUOhnt0S/St9650aQ3QZxd+iKzObq4/5
	DiqNkDqMcME+It4HXFBEo418m1Iw1xOnBK8w0t5RVHKF3/5rnF4r3QI2xUmGAlUkzwqkvoIH/B+
	ahQOA6xd/x1sufpTNUoSF6fVy/FufPOSnLbhxuhasiTexsiKWnZc2lFBV/2JzelzzfRTKJdmNMK
	dKEXtisV0751iH3nYx7hKG9M55yzGBFKztdLiCO8VPXVWKcH/3HyqD4hJSxbVoWUCKVc5EB8oli
	W4CzSLmM2mCjS9Himr5EzSshD
X-Received: by 2002:a17:90b:3846:b0:3ac:945c:7f69 with SMTP id 98e67ed59e1d1-3adeb162362mr4626149a91.66.1792984031788;
        Sun, 25 Oct 2026 20:07:11 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21026sm932810a12.6.2026.10.25.20.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:07:11 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 76/81] selftests/bpf: Adjust tests of unprivileged progs
Date: Mon, 26 Oct 2026 02:59:37 +0000
Message-ID: <20261026025943.404450-77-alexei.starovoitov@gmail.com>
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

For an unprivileged prog the verifier masks 'ptr += scalar' against
speculative execution. Each insn has one limit for the mask. Thus the
verifier rejected a prog in which two paths get to the insn with different
scalars:

     r1 = 3
     goto 2f
  1: r1 = 5
  2: r1 += r0            ; r0 is a pointer to a map value

  R1 tried to add from different maps, paths or scalars

Now the verifier joins the two states before the insn. r1 is [3, 5], and
the insn gets one limit. The verifier verifies the subsequent code for this
range. 5 progs of verifier_value_ptr_arith.c load.

5 other progs have two errors. The verifier rejects them as before, but the
order of verification is different, and it finds the other error first.
Expect that message.

3 progs of verifier_array_access.c expected mark_precise lines. The log
does not have these lines.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_array_access.c   | 14 +++++---------
 .../bpf/progs/verifier_bounds_deduction.c         |  2 +-
 .../selftests/bpf/progs/verifier_map_ret_val.c    |  2 +-
 .../selftests/bpf/progs/verifier_value_or_null.c  |  2 +-
 .../bpf/progs/verifier_value_ptr_arith.c          | 15 +++++----------
 5 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 0a187ff725cc..d7f16878648a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
@@ -248,7 +248,7 @@ l0_%=:	exit;						\
 SEC("socket")
 __description("invalid map access into an array with no floor check")
 __failure __msg("R0 unbounded memory access")
-__failure_unpriv __msg_unpriv("R0 leaks addr")
+__failure_unpriv __msg_unpriv("R0 unbounded memory access")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void array_with_no_floor_check(void)
 {
@@ -280,7 +280,7 @@ l0_%=:	exit;						\
 SEC("socket")
 __description("invalid map access into an array with a invalid max check")
 __failure __msg("invalid access to map value, value_size=48 off=44 size=8")
-__failure_unpriv __msg_unpriv("R0 leaks addr")
+__failure_unpriv __msg_unpriv("R0 max value is outside of the allowed memory range")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void with_a_invalid_max_check_1(void)
 {
@@ -541,8 +541,7 @@ l0_%=:	exit;						\
 
 SEC("socket")
 __description("valid map access into an array using constant without nullness")
-__success __retval(4) __log_level(2)
-__msg("mark_precise: frame0: regs= stack=-8 before {{[0-9]}}: ({{[a-f0-9]+}}) *(u32 *)(r10 -8) = {{(1|r[0-9])}}")
+__success __retval(4)
 unsigned int an_array_with_a_constant_no_nullness(void)
 {
 	/* Need 8-byte alignment for spill tracking */
@@ -557,9 +556,7 @@ unsigned int an_array_with_a_constant_no_nullness(void)
 
 SEC("socket")
 __description("valid multiple map access into an array using constant without nullness")
-__success __retval(8) __log_level(2)
-__msg("mark_precise: frame0: regs= stack=-8 before {{[0-9]}}: ({{[a-f0-9]+}}) *(u32 *)(r10 -16) = {{(0|r[0-9])}}")
-__msg("mark_precise: frame0: regs= stack=-8 before {{[0-9]}}: ({{[a-f0-9]+}}) *(u32 *)(r10 -8) = {{(1|r[0-9])}}")
+__success __retval(8)
 unsigned int multiple_array_with_a_constant_no_nullness(void)
 {
 	__u32 __attribute__((aligned(8))) key = 1;
@@ -595,8 +592,7 @@ unsigned int an_array_with_a_32bit_constant_0_no_nullness(void)
 
 SEC("socket")
 __description("valid map access into a pcpu array using constant without nullness")
-__success __retval(4) __log_level(2)
-__msg("mark_precise: frame0: regs= stack=-8 before {{[0-9]}}: ({{[a-f0-9]+}}) *(u32 *)(r10 -8) = {{(1|r[0-9])}}")
+__success __retval(4)
 unsigned int a_pcpu_array_with_a_constant_no_nullness(void)
 {
 	__u32 __attribute__((aligned(8))) key = 1;
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
index 260a6df264e3..eddbb4f906ee 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
@@ -102,7 +102,7 @@ l0_%=:	r0 -= r1;					\
 SEC("socket")
 __description("check deducing bounds from const, 7")
 __failure __msg("dereference of modified ctx ptr")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__msg_unpriv("math between ctx pointer and register with unbounded min value is not allowed")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void deducing_bounds_from_const_7(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ret_val.c b/tools/testing/selftests/bpf/progs/verifier_map_ret_val.c
index 1639628b832d..2b65ab508596 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ret_val.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ret_val.c
@@ -83,7 +83,7 @@ l0_%=:	exit;						\
 SEC("socket")
 __description("sometimes access memory with incorrect alignment")
 __failure __msg("R0 invalid mem access")
-__msg_unpriv("R0 leaks addr")
+__msg_unpriv("R0 invalid mem access")
 __flag(BPF_F_STRICT_ALIGNMENT)
 __naked void access_memory_with_incorrect_alignment_2(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_or_null.c b/tools/testing/selftests/bpf/progs/verifier_value_or_null.c
index 8ff668a242eb..2a5bdac24925 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_or_null.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_or_null.c
@@ -183,7 +183,7 @@ l1_%=:	exit;						\
 SEC("socket")
 __description("invalid map access from else condition")
 __failure __msg("R0 unbounded memory access")
-__failure_unpriv __msg_unpriv("R0 leaks addr")
+__failure_unpriv __msg_unpriv("R0 unbounded memory access")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void map_access_from_else_condition(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index b3b701b44550..2355915766e3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -41,8 +41,7 @@ struct {
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs const")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
 __naked void value_ptr_unknown_vs_const(void)
 {
@@ -79,8 +78,7 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr const vs unknown")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
 __naked void value_ptr_const_vs_unknown(void)
 {
@@ -117,8 +115,7 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr const vs const (ne)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
 __naked void ptr_const_vs_const_ne(void)
 {
@@ -225,8 +222,7 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs unknown (lt)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
 __naked void ptr_unknown_vs_unknown_lt(void)
 {
@@ -270,8 +266,7 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs unknown (gt)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
 __naked void ptr_unknown_vs_unknown_gt(void)
 {
-- 
2.55.0

