Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071050;
	b=pFe+dPX20pYW5+6gfRwKyqMZ7n2BUaRSMFlhPGNhsu2RAvcRUSisoy8vYoHhA/+PGCw+
	 SYKgoNT6P+g6gHpWLoYjC4xW3Pslcz6v++woO9JUdPHJn9X/3gvSYzZiCL/afvmROBiy1
	 giPTemEllBpdGPVvIHqC27jth824PLwCWMPOWmfCJqUG7KZwGs7w9UFm7yIgM5JBsGUI+
	 k726JDvK8rnHhgNjyS8KCX1yxkxV9FbaVX06N1RjNY+M0CXNggQ5uqrcTqksHVzVAP4XZ
	 dP2GiWHGTNyz8P2QyB99UACz+Xl8mekEInon05T82ZR5Z+cXU5yyIQxerZxPG+4d1vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ihA4ZU9Br3oBTtmmN4TVr9IlYGBzz62xotzn6RhGBwk=;
	b=YOA56AWImofHeJqd4DlHu6mK5eGOdfRL1WBDZkhwvdyHjToBKSGYjAo9MBd6hZnrvFTb
	 DSL0T1i+aTruZUAwo41oAFakMEi1xp8aWXpELavnoVHiX8wdzuCGGBgQtcxFPJG/JQuDy
	 OINLsll41HPZPXMxPlpTjOzj3bz3CpgNkDOxKJHsDAWp9aOPWf7XCaSKzCp8UZf7v1KpA
	 XZu1DzCTX7w6hr13nDTIEB0pNS/bWFIvI0LhngzgkGIPqPW4McvfAZ7spr8SLs8UkbUNp
	 v9/PWD1QJ3xBBexZd/PjaCznKaix4bfWGqsEHh+qYUOTrJqL8fbXHjyr3v+fpsIVERQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vzp1PUXT;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1D606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 17:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE1D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vzp1PUXT
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso747540a91.2
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 09:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071049; x=1794675849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ihA4ZU9Br3oBTtmmN4TVr9IlYGBzz62xotzn6RhGBwk=;
        b=vzp1PUXT2Eekck+HbhiwHY+u5Ll+RFgffqaFNpqhyk+uDEcAmPqw35C0IQ64aBOvnI
         NISQQ3mkz2P8Saz0S1SJx+/HilKMHsmseSRRyFDjBhT2de2v9ksszP1nYud89UgP/t4b
         910ZSGZSINun1HiLtjLiZOcfJHr3oZqMimKjyiVtY3ByjuSir4ZN7kzNAF7jY3/U3PU/
         BhaPmbZHCO82Dvk5XOud/ZBD+ljh5wCmzOluBcngdqyiUHn+D+m9Wsf0DDiz1h2f1q9n
         BSDEYGXGTYpRdLh9TcUsnUR/kk8JTfmhHCeZpGRSiVEV1/Uw96Y84PUFeod5Q80WzZGg
         0I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071049; x=1794675849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ihA4ZU9Br3oBTtmmN4TVr9IlYGBzz62xotzn6RhGBwk=;
        b=CYspTN1Ury3Nn1GW17ft+o3K+gM1PxPRGwLqnaI7BfzsF2zKESyBKm8AKSjk8B/DNg
         LUdj5n3lmfmPcHvplSaFlLrHmCDKuK2Q1PSGiUW06iiE7RmLT6WdadcnKb1iPPNdrNoJ
         fIN8OmvBhL4Y3CjKDNqAZSVuHMLF/9Pv4ZGdU58GbK+DB0wzti+OqDUxRSevknr9Otsf
         d1ba+lNHM6QUK88wH+Tp00EpCWilrh7yLNIy3uzTsFuW1ZpxJzOX1ldlG+GexGM2dTP4
         faTlHs1TBrCqpAmyeMoP8ou8x9g0Xmk1eblg+nAC1umvnn96TBVB/KJhSSwbKh+xMTHE
         JruQ==
X-Gm-Message-State: APuU4Z/dDChKVudrX1eMjC47V5nfET9lI7ptbpzsC3j4xjZMcyMoPlZ1
	Tpxb5x/mrNnyP9zeGPnju3vZmifWPLxerF4PUcj7U2j6zkPZjG38xWNpTMAXCw==
X-Gm-Gg: AYBFou0RfbdKSWnxTGQ8CZsxqnO05oKyEvGLItnePVlZPMSlH77YDQFp3Ju14V4+gVx
	bYwBZLjr0vbUOvl2NAfsa7Mgl70d7SF0udJDd01S2T4/Mpas+pPbasRwVZXNBqh4xjyyMe/O16g
	x/DedPX2uZJARU43VAVWpr8yoqL19mUdMb+E4pOVyfrGM/hbfr04lGBE8a0JO91ZQar78eo/X/t
	vZxPx21j12MInwo5cpfNvYwJ4g1m43U+dWemDlfZ1pSsTh563DJko+MqkRZaVgGO0poosLpHDKw
	pwYKOYLTK05icXnIZTB7xpjmkeCoKB2fP9H8z6/HtXEU1ceIEwdTASVVUNv1eLxaUgy3Bs8ZdLX
	yIVfPde60APSKHLR4AOQzvBzMmzvwedH0bK1yF772llXxhLKuvP2NaNXgIaWv/8U0xjF0Sp4ywV
	u6P3Vqlq+DGeLijJXwkvWajfnprFfspWFZBNOccU71Bext5qEqBVa9S+SEm5lkKbiXiPS4/7alU
	pNO+ElPMEWz/8rQ+T+lzPJBU3PAO2kHGIGMAfCQNCyZY9W01o4yfp7yHmcvyUGoFLKP57xDgHQk
	gb3bb4NBjUE7CqIPVI8Rx+cmiTfkjXNGyZ31AHtiqYR5Wgw9hAc4nF7Vme0CMgPXdgZQBmjBl5s
	0CjrjpaEOd7YK+IlXOD8uyB37z89pYhtj1dE4vF7QCR0bpYdL2qQIOCngMURcZOH7tNKWLZPyXg
	==
X-Received: by 2002:a17:90b:1a91:b0:3ae:521e:767f with SMTP id 98e67ed59e1d1-3b0db705cb0mr5430167a91.36.1794071048714;
        Sat, 07 Nov 2026 09:04:08 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105817ce1sm4011234a91.9.2026.11.07.09.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:04:08 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 8/9] bpf: A join must leave the cookie of bpf_throw() alone
Date: Sat,  7 Nov 2026 17:03:05 +0000
Message-ID: <20261107170306.2831028-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
References: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
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

An LSM prog without an exception callback:

  err = policy(file);     /* 1: no rule, 2: audit, 0, -EPERM, -EACCES */
  count(a); count(b); count(c);
  if (err == -EPERM || err == -EACCES)
          bpf_throw(err);
  return 0;

The compiler decides the 'if' where err is set, and keeps a flag. All
paths meet, then the flag is tested. In the join err is [-13, 2]:

  At program exit the register R1 has .. should have been in [-4095, 0]

The prog is valid, and it loaded when the verifier followed each path. It
has the shape of cil_sock4_connect() of Cilium, with bpf_throw() in place
of bpf_set_retval().

Without an exception callback the prog returns the cookie. Thus
check_kfunc_call() compares r1 of bpf_throw() with the range of the prog
type, like r0 at exit. That check is not in check_func_arg() either. Add r1
to bpf_call_checked_arg_regs() by hand, like r1 of bpf_set_retval(). States
in which the flag and the cookie differ are not joined then.

The same table tells whether something looks at a number that a short loop
counts. This prog loads too:

  for (i = 0; i < 3; i++)
          if (hit(i))
                  n++;
  bpf_throw(n);           /* cgroup_skb/egress takes [0, 3] */

Fixes: af6bda3802af ("bpf: Tell which arguments of a call a join must leave alone")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/flow.c     | 4 ++--
 kernel/bpf/verifier.c | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index dc3f2f0afaea..e6d1817ffa57 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -549,8 +549,8 @@ static u16 flow_stack_off_regs(struct bpf_verifier_env *env, int idx)
 
 /*
  * A jump that compares a register with a constant, which may be in the other register.
- * A call does the same: the verifier compares a size, or what bpf_set_retval() takes,
- * with what is allowed. So does the exit of the prog, see flow_compute_need_const().
+ * A call does the same: the verifier compares a size, or what bpf_set_retval() or bpf_throw()
+ * takes, with what is allowed. So does the exit of the prog, see flow_compute_need_const().
  */
 static u16 flow_tested_regs(struct bpf_verifier_env *env, int idx)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 09a44723bb2e..4093411498d6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15614,6 +15614,9 @@ u16 bpf_call_checked_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *ins
 {
 	if (bpf_helper_call(insn) && insn->imm == BPF_FUNC_set_retval)
 		return BIT(BPF_REG_1);
+	/* without an exception callback the prog returns what bpf_throw() takes */
+	if (bpf_is_throw_kfunc(insn) && !env->exception_callback_subprog)
+		return BIT(BPF_REG_1);
 	return call_arg_regs(env, insn, arg_type_is_mem_size);
 }
 
