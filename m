Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022894;
	b=tRVpyd5gDwmNbp5jFDl56fISNzmSGakU9kUpG5q04pOpqwAfyrBtXKexJV3s1cs2g+lF
	 JYgDK3tsmjM34iJ+WUm6OHykq8ZXk2p6noK0bcuG7TUa0Hle9ywk/Rf+gNfX4j6QFnJpw
	 OgP45OzSgwKeWVXbdyC+LepCGiaGJf796QGWLW6CXmFM3piZ8qVry40r+eKIcQ3uKH2JL
	 0qhLcd8bQECcttboluWaQ4l4NUJCYB8DJAtxpQJvzzysxvPtwi116abZ7gD50JS2iP2sY
	 sACNgDSfJpE8uVw5PaW6b7xxpfrRLGAAFvqtBGjaKrbwNfuoVnmtjOOqAVkknxVofjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vVqsDKq+IateAeQjTGq3ovtOBLwcp1pUpF9ZdLgni1A=;
	b=bf2oeU9ah0IYgPmfiSCMdQndP3j/tQyodRaLOea+FVWCajDrlPjlNHMYQYhGERfXGRJR
	 fyI8mGmm35XKfkLigrVGi6hRAfGUnkh35FEB0FxvpykJD3UrlEZTwJ/9tFhU7fxMEp4uf
	 Gh6IpOIHpfTArU6i70cDUHgqDOFIwlZbrfNhTmPW2tDPU8RSkY8WECxk37r+BqMKqfOxs
	 +CdioBuVZZb7fg1fZhKCoe5dA1S2JIAlR5WOfjoW02ac2GfrGrdC1v1f33PLryB0cjZDe
	 9xa2PlexAMtYyU8Rgq5gYXP9Qvbmnlxf8VnpVLJBQu+HZTW8cKogTlPpq25TMH8xzBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hzv9CkBO;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44780606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44780606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hzv9CkBO
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso522025a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022893; x=1794627693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vVqsDKq+IateAeQjTGq3ovtOBLwcp1pUpF9ZdLgni1A=;
        b=hzv9CkBOBNgzOS3ymH0Jf5boG0wiYPl75NuujbfUmQo+RePu92PI15TkGEdJeNgh8F
         3JMwjcdVx35KTbQ7ZmPpg36AaSPQMsymKtOmYYSl6afKstzXILzO/kOofoQImvQBPlxb
         xSalbm6PsHz0BZIh84Kvs1lIS4kWZhNNZXV7lhlr7NVecCF/zFgylozP9EDpwFCOfIsM
         DW/MVmdL0+uMlOpxUF9xmwcKG4xXaWVYV71PuuRE5Y6mS9EnCGTwaOC+FKC/7CiunQNi
         dbVqSHCWUR5a6GwKB4YUZqaa1d28E8pCjVpWtG9CidiTqJ19MNMW3ttwq8iDDbkBciV5
         QFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022893; x=1794627693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vVqsDKq+IateAeQjTGq3ovtOBLwcp1pUpF9ZdLgni1A=;
        b=x8mzFuh15f9AGi1QoAhhHi4So9FhvM5DX8HECgOATq1kYxffn9Q6vxqFDNf2OLosCQ
         W+Cqsfb7miS1qWu65BVBoMr18BPcrAIgtAJaH1Tt37gijZQ5tnOjhhCgCj+357EtVuC+
         BtMrVwqMmvsSCaEusBoWdiMv/i/DHRQErCCm8nqzQ4JgxTLCVmS7E0nlHv7IamyID/Xu
         jJdIGjkG46Q5fuT2QhvUa9A7i4LhPDKqqW+JWb2S7g/RtwEdYh15ufBn71CbljuWSrgD
         vLwJ3fvgmhZPj7zIHyoResTqfRILjtTj1rmaY2LJr8DOZKOzRPtg33D6b0QaxJDd+hWV
         PDdw==
X-Gm-Message-State: APuU4Z9B5ZGDsSNkYHQ0lwHkaw1VGOd4kVUgd705CY5jE+n7mGbBP5r8
	cjAs1b1vmi87HjczpTFbBfqunp28mbAE8hf2G+FjNpIyz40xnvj5dsbbgJ+LMQ==
X-Gm-Gg: AYBFou1BpFOlWRF/HYX1IZWSx2mPWfASuyuVr+D23DR1JEbXfcfjJk0cQrq13mE+z8y
	8ba7OWE8g9rNps9e1BUBW/zWPzf3x3rodCCyI09rlkTnuPn8x2d/pbzlZpkaHQ2lDLqjoEBlqIA
	Hg68IfBB0XBrRd1hP1WkYWIfwDWGhpz/xzJQAD0iBGa5xmAz9WU8oyJKJZX4rJyCDLihlM21+5Y
	I7QUGKMexVqUmlp1d1gO8Sc0W/NiW+9ZoYTdctnUSeAb3xNUvkC+wgaZJ0K6pbkioQ52mw/1ei+
	ELb8nyH5XzxGZ+FRCsptwDe1D5ub9CJrl8JxIqU4ERsTiE+LlEdfmVoqeSDy3U9OHfRITTXXzeI
	BqSU58k/6joGtITMb9tCDHNW5x6C3+2bYwyUXu1CNHqc5+Y5u7JeOVYoUdHcG8wpX0dEL3uN4iP
	Y6nrrBssDgjJ0fPZXGvCfEb5wNfTnEL1fgFnaPuzBn7N4WXCPvSwXfMinjPfZZqRzK46bvyH0nR
	OaeaajDsJN316lfl6wuViHWusr1CsRBdl6J4LGJsj4DNXay8pmkG7m9QWr4Qnpzxmle1wlyENdw
	pqefzaHg4/2NSls0mqQWHLverhkWPUBUWS984fHyQ5KanTw7sZHIbpyq3OTPt/SW+aCm2BN7Gii
	9aJfhEKfDEMz4CjWO4uj/9CTJ4iMX74G+JTXWS9/mNgnE/WxwnRk7BZiN3csaqkDrS1RpBFceHh
	/xDlsLLbeXm89I1Rs9Qpy3
X-Received: by 2002:a17:90b:5107:b0:3ad:8a14:bc73 with SMTP id 98e67ed59e1d1-3b0db6e8f4fmr4136381a91.50.1794022893503;
        Fri, 06 Nov 2026 19:41:33 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc23b547sm1267041a91.0.2026.11.06.19.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:41:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 35/46] bpf: Allow tail calls and LD_ABS in subprogs that return void
Date: Sat,  7 Nov 2026 03:37:43 +0000
Message-ID: <20261107033758.1547725-36-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

  static __noinline int subprog_tail(struct __sk_buff *skb)
  {
          bpf_tail_call_static(skb, &jmp_table, 0);
          return 0;
  }

LLVM 23 writes the signature that a function has after optimization
into BTF. The callers know the constant, nobody reads r0, the function
returns 'void' there, and the prog is rejected before the first insn is
looked at:

  tail_call is only allowed in functions that return 'int'.

Commit be1d838b88e4 ("selftests/bpf: Keep int return type for tailcall
subprogs") hides the constant from the compiler with barrier_var() and
__sink(). Without them 6 progs of tailcall_bpf2bpf2.c,
tailcall_bpf2bpf_hierarchy[123].c, tailcall_callback.c and
tracing_stack_arg_tailcall_tgt.c are rejected. Everybody else who has
a tail call in a subprog has to find the same trick.

The rule is from commit 09b28d76eac4 ("bpf: Add abnormal return
checks."). A tail call that is taken and LD_ABS that fails return to
the caller with a number in r0. The verifier did not look at that
return, so the type of the function had to promise a number.
Now it does look: check_helper_call() goes back to the caller with an
unknown r0, check_ld_abs() with 0, and r0 is not set behind the call of
a global function that returns void. A caller that reads r0 is checked
with what is there:

  call void_subprog_tail_call      ; r0 = 1 if the tail call is not taken
  if r0 == 1 goto +1
  r0 = r9                          ; R9 !read_ok

So let 'void' through. A function that returns a pointer or a struct is
refused as before.

Two tests of verifier_ld_ind pin the rule for void. They load now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/check_btf.c                           | 10 +++++++---
 .../selftests/bpf/progs/verifier_ld_ind.c        | 16 ++++++++--------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 4c1ed842f661..8a3f2421331e 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -183,15 +183,19 @@ static int check_btf_func(struct bpf_verifier_env *env,
 		/* Already checked func_proto */
 		func_proto = btf_type_by_id(btf, type->type);
 
+		/*
+		 * LD_ABS that fails and a tail call that is taken return to the caller
+		 * with a number in r0, whatever the type is. 'void' says nothing about r0.
+		 */
 		ret_type = btf_type_skip_modifiers(btf, func_proto->type, NULL);
-		scalar_return =
+		scalar_return = btf_type_is_void(ret_type) ||
 			btf_type_is_small_int(ret_type) || btf_is_any_enum(ret_type);
 		if (i && !scalar_return && env->subprog_info[i].has_ld_abs) {
-			verbose(env, "LD_ABS is only allowed in functions that return 'int'.\n");
+			verbose(env, "LD_ABS is only allowed in functions that return 'int' or 'void'.\n");
 			goto err_free;
 		}
 		if (i && !scalar_return && env->subprog_info[i].has_tail_call) {
-			verbose(env, "tail_call is only allowed in functions that return 'int'.\n");
+			verbose(env, "tail_call is only allowed in functions that return 'int' or 'void'.\n");
 			goto err_free;
 		}
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_ld_ind.c b/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
index 32989f981fb6..b31a5e558409 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ld_ind.c
@@ -291,8 +291,8 @@ int ld_ind_global_subprog_ok(struct __sk_buff *skb)
 }
 
 /*
- * ld_{abs,ind} in subprogs require scalar (int) return type in BTF.
- * A test with void return must be rejected.
+ * ld_{abs,ind} in subprogs require scalar (int) or void return type in BTF.
+ * The failure return is modeled for a void subprog too.
  */
 __naked __noinline __used
 static void ldabs_void_subprog(void)
@@ -308,9 +308,9 @@ static void ldabs_void_subprog(void)
 }
 
 SEC("socket")
-__description("ld_abs: reject void return subprog")
-__failure __msg("LD_ABS is only allowed in functions that return 'int'")
-__naked void ld_abs_void_subprog_reject(void)
+__description("ld_abs: void return subprog")
+__success
+__naked void ld_abs_void_subprog(void)
 {
 	asm volatile (
 	"call ldabs_void_subprog;"
@@ -334,9 +334,9 @@ static void ldind_void_subprog(void)
 }
 
 SEC("socket")
-__description("ld_ind: reject void return subprog")
-__failure __msg("LD_ABS is only allowed in functions that return 'int'")
-__naked void ld_ind_void_subprog_reject(void)
+__description("ld_ind: void return subprog")
+__success
+__naked void ld_ind_void_subprog(void)
 {
 	asm volatile (
 	"call ldind_void_subprog;"
-- 
2.55.0

