Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484390;
	b=KfFTmr3rShIJt59G6Fn9eQJxvUYWvSo6g1I8EsPtLcJgyGf0nWQjk6pPQzuQwtLF8Tlz
	 BBL9S7HNGZEDabMhUM1pjpAjdhr+Ev9xsYVKghaG2TcAf4W/TE/asKU8sakUAgGHHHneN
	 3clTgVeuIWahs0XfLHlh1+RyKVz96KVlTGWl32OSPKgHWe888RTu67kHMJKjcB9PiusM3
	 OLLqsruaP6MPGgv08JLCiryIKv1ZVLtwwaGZzx6H2lvF35K0f56MV9zkCVur3+LwSgLgx
	 7jYZK8qMQsE3qD7WQr6obHxKOC+sGXOSySQc3ddQJfX2lV+v6lQ2lHww9GuV3eNk7WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t8no3k53FLtCMOXsw9rIrQVgyXUFsfn7EybWGDkPpEk=;
	b=NvcwSo+X6ZAE991IUx27LYOE6PoAa6kjlTYIpqDwXLXhJqEzu2egKiizflBx1m1PyejK
	 Ludson6QdaQJndpAqg3Z/OSC6SPcL3Y0d7ZQz3RdED2woX+A3iGuM/Nj/c6Ehw/pBAGLG
	 Jo7M2yf7+d/8Shr67KtIMjaMqsD7I0BrE5Lfi8C9w8j+C6zSQYMJFQvIIw1rO+ld43i3v
	 6FBlgTmNP2rTAm4oPIpe230+rtMj50LEAXd3DMi/ZKJV42IVosKeJL6YT7iwh/0ecwd/1
	 bi2aJBhAxIGBQMVn8yiDiHoEReSI27peh0YOgQ1y4gTSpwzvcAZRs2VzARtFphTEu6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CvWGiI3e;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7BF606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE7BF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CvWGiI3e
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so1167312a91.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 15:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793484389; x=1794089189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8no3k53FLtCMOXsw9rIrQVgyXUFsfn7EybWGDkPpEk=;
        b=CvWGiI3e37I9xm0n86sQ9P6TbVFHXDOxVuc/W4jRsFaUdq728sy1YN5i9mDWcjsHqg
         rcmo/hz36bnuBayQj73bpiqTU3rESLUlM6L7f5cCa1+u7IfZ44cUBBg3WxRaRiQQV6Bn
         F4HbtAQtLSSwktJb0ayAeO3VhgwRpZqDkEs8r2Z/JX93M0nsid7o1cD7zH4cbUqr9B8X
         B8CHy63Vv13y8S3U1ohPk+Hc/aRRn/YTYe+BuhyqlLuMbuwSiASLvjeVxiSRbBZXe94q
         qaf1tvy+kDUH7hzisHkFH9WpK70ZBbIxGjrxTO6F7ThsA4d9LoAkYFGJMlysyNVMXvay
         58og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793484389; x=1794089189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t8no3k53FLtCMOXsw9rIrQVgyXUFsfn7EybWGDkPpEk=;
        b=QaLqZIb2oxUxDHRs25BQz0WsMnb11/APq14+eMZipdacLgNyVV4xoi2lePj42o742x
         Yk2hJvvrmkcXaI7XKqtey0XjLllN+CGlg2HWlVRXxRj5dMW43HlRzcWoucNoLsNV7tL5
         T6dBNHKGLgkKNvNaZTLY2guiSmO7uJJsRLFKwXQkVcs0fAIAcZEBbCxxfzRScknZPv/t
         7JEZQuQw9RK4fjjGJgHjUZf7YVH7OXWi2vw2PCTM/2yIoBeNdYt94K78cjv1J9McTGC7
         hZGuO+KEAlXIXDmGk3+5AdcqaKwYTrRz/9vRBaCIjWrvCtLaE9RviD3BvFr0nIhnAORh
         HqfQ==
X-Gm-Message-State: AFq9FYI/mLYtmjmuuRX2rXBHVJX8uSJJukSBZwBZnnoFXJxMb8A9q8cQ
	BjhuV1OsDXL5oKOYwskZ6nxvn8Ac8wd1wFhJWWxxpfJgQWjusXbf0Ld4Y+4+AA==
X-Gm-Gg: AYBFou2LUqXtKvxTYez38n3dyIqNMFy4bOmhrsUxC44c/aAsR0bW3nZDwOec0r40foy
	6AY2QUH96B+s8Yku85FMEM6X0zNK2smjs3a9/uBgttgPIKHyOA9SBMQoyEjkgxU3gvU7kWS5k6t
	2dbwzeM8icW6K/H5YJf6TFr/h9Zeky027uOjn5nI7xE9xiaDeDcL1X9FWyY/UN0biQC/u9xsr9x
	nVrkefNPIZPUlP9BdEpyt0MLt9lUZ6feY7i0koSSnS82HtaUQw0kVuwYZ+CDnLIXAFZEbZ4rwE4
	Ep/7Us1DvreCdGD/ssjMkkesbIt1lOiRaIx4CVSjO8bHiJ1ZsRRR/tCIXshbbAzfmHtdyiW+toV
	3SfTVrLqRysGr/xjYnxrRi/2kxyiEvrIvLdHLtdaHFT+FsG9abyPMhVG2pn1EdMK8+28PeilTHC
	3LCS3InqdOUr8d5oBjR8xw+mdrELKaZLyv4YwTcbx9inyurIe0mTApVqsiTwkqFR/t0Ux6gx0Fz
	h6mjiGR2r8LYSOKvTOTUnj7o/KD1rqtg4EHJZ7e5wKQQ58b6Ubf1s+ls21isS03pwQwzx+3n/go
	Frsgocn8xr5gz9R2Way+CnONhaf7j7KnN9P268a97yZXbBWhrrCc1aH1DY8zZxVmAXow1VMVGgm
	+cyAcoRmbOibCEPGDygz5MSKNNxmzde16sx0mBf8kkGN2Kt2JlMVGFo2mfY12OVkthz+lrALikA
	==
X-Received: by 2002:a17:90b:43:b0:3a7:e126:4980 with SMTP id 98e67ed59e1d1-3ae8979de24mr4916813a91.43.1793484388908;
        Sat, 31 Oct 2026 15:06:28 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e944ba9sm13065075a91.8.2026.10.31.15.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 15:06:28 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test the join of fp+0 with a value that is not a pointer to stack
Date: Sat, 31 Oct 2026 22:06:15 +0000
Message-ID: <20261031220615.804426-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031220615.804426-1-alexei.starovoitov@gmail.com>
References: <20261031220615.804426-1-alexei.starovoitov@gmail.com>
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

r7 is r10 on one path and a pointer to a map value on the other path.
A store through r7 is not a certain write to the stack. Thus the pointer
that is spilled in that slot stays known, scalar evolution sees the store
through it to the counter of the loop, and the verifier rejects the access
to the map value.

The join has one branch for "pointer to stack joins other value" and one
branch for the reverse order. The path that reaches the join first selects
the branch. There is one test for each order, and each test checks in the
log that it takes its branch.

The third test is a valid prog. It reads the slot after the store. When
the store counts as a certain write, the slot is dead in front of the
store, and the verifier rejects the read:

  reading from stack off -8+0 size 8, slot poisoned by dead code elimination

Without "bpf: Fix the join of fp+0 with a value that is not a pointer to
stack" the first two progs load, and the third prog does not load.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_live_stack.c |  29 +++++
 .../selftests/bpf/progs/verifier_scev.c       | 111 ++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 5f9b11a81260..1fc9984e8e22 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -133,6 +133,35 @@ __naked void must_write_not_same_type(void)
 	: __clobber_all);
 }
 
+/*
+ * r1 is r10 or a pointer to map value. The store at r1 - 8 is not a certain write to fp-8:
+ * fp-8 is live in front of the store.
+ */
+SEC("socket")
+__success
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void must_write_r10_or_map_value(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[map] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"r1 = r10;"
+	"if r0 == 0 goto 1f;"
+	"r1 = r0;"
+	"r1 += 8;"
+"1:"
+	"*(u64 *)(r1 - 8) = 42;"
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map)
+	: __clobber_all);
+}
+
 SEC("socket")
 __log_level(2)
 /* Callee writes fp[0]-8: the def is summarized as may_def at the call site */
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index fa01a616af9d..22ebda8818fb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3936,4 +3936,115 @@ __naked void clamp_pkt_pointer_keeps_range_of_entry(void)
 	: __clobber_all);
 }
 
+/*
+ * r7 is r10 on one path and a pointer to map value on the other path. The store at r7 - 8 is not
+ * a certain store to fp-8: fp-8 still can hold &fp[-24], and the store through r8 changes fp-24.
+ */
+SEC("xdp")
+__failure __log_level(2)
+__msg("r7: fp0+0 + _ => fp0 ?")
+__msg("invalid access to map value, value_size=8 off=4096 size=1")
+__naked void join_of_r10_and_map_value(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u32 *)(r10 - 4) = r1;"
+	"r1 = %[small_map] ll;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 3f;"
+	"r9 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	"r7 = r10;"
+	"if r6 == 0 goto 1f;"
+	"r7 = r9;"
+	"r7 += 8;"
+"1:"
+	"r1 = r10;"
+	"r1 += -24;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r0 = 0;"
+	"*(u64 *)(r7 - 8) = r0;"
+	"if r6 == 0 goto 3f;"
+	"r8 = *(u64 *)(r10 - 8);"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 24) = r1;"
+	"r6 = 0;"
+"2:"
+	"r1 = *(u64 *)(r10 - 24);"
+	"r2 = r9;"
+	"r2 += r1;"
+	"r0 = *(u8 *)(r2 + 0);"
+	"r1 += 1;"
+	"*(u64 *)(r10 - 24) = r1;"
+	"r3 = 4096;"
+	"*(u64 *)(r8 + 0) = r3;"
+	"r6 += 1;"
+	"if r6 < 8 goto 2b;"
+"3:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(small_map),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* The same. The path with the pointer to map value reaches the join first. */
+SEC("xdp")
+__failure __log_level(2)
+__msg("r7: _ + fp0+0 => fp0 ?")
+__msg("invalid access to map value, value_size=8 off=4096 size=1")
+__naked void join_of_map_value_and_r10(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u32 *)(r10 - 4) = r1;"
+	"r1 = %[small_map] ll;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 3f;"
+	"r9 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	"r7 = r9;"
+	"r7 += 8;"
+	"if r6 != 0 goto 1f;"
+	"r7 = r10;"
+"1:"
+	"r1 = r10;"
+	"r1 += -24;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r0 = 0;"
+	"*(u64 *)(r7 - 8) = r0;"
+	"if r6 == 0 goto 3f;"
+	"r8 = *(u64 *)(r10 - 8);"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 24) = r1;"
+	"r6 = 0;"
+"2:"
+	"r1 = *(u64 *)(r10 - 24);"
+	"r2 = r9;"
+	"r2 += r1;"
+	"r0 = *(u8 *)(r2 + 0);"
+	"r1 += 1;"
+	"*(u64 *)(r10 - 24) = r1;"
+	"r3 = 4096;"
+	"*(u64 *)(r8 + 0) = r3;"
+	"r6 += 1;"
+	"if r6 < 8 goto 2b;"
+"3:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(small_map),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

