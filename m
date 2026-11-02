Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793599172;
	b=WcOv7DcQd/vziglYH5jFzLyeIemJqRA6A148eYrzBSzEoZiKkofKafqpjw5crltEP1L7
	 OIG5Yegfbe+j9dG9LgNwx2IJ/ngQ/2OkL1PGi19XXcL5lmId42NJEHiNWfq4dYF2FeEAy
	 w5s6ZSpSWqreUExfWYHRd6bdNn5aAhRbsotzLEcx5GzFsxiyXdZV6U1lim5vPv0NlfQw1
	 VtMGonK+IxPlzdLVi9ZpD6UgcpkBoevXWxPQbwdQ4nfZfDLNhoHb1Bug9PWeRRA5vL8Tt
	 GmT9gW4bGmj1A86sOk1MnLQs+OsoQwrCJQqjyo/65iWeT2HkNIx4lxqwHWiGVstBoKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793599172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uEG4y+uDdeatRYNX0XhH9I87Gd5zifsbDCdQuU96RRk=;
	b=BdIb3EUGpR8ZF/JL9kF7skcVKXX/qU2GA0h6o9q4e0i/A55oAN/I41x682tlzBAw64hU
	 HdXHZWm+f+4c/G+2MfS9oVJlfmWZ2Vk2ikXT9BsvOHhoDYgfFjI9YOpIJKGdsAb1zGD0y
	 hmacSuuQfKCJx1PFq8KMmvlx6QWl8AZZDH5a5T+J6m7gfmW+OVR/po2XNvdYf6uSGCGQd
	 3scfoaNiIUewPQvyCzXNpbgxoPj+Aw7IukvsSpWTzjh7kkEAANev7GK41Nt7B+mHJmQna
	 /v6Z2Oa/NQrEv68tNL/LLvfaWwUYq2oPAqJP0RE6ZVaqpLtANqNQvweOCyn5cfaqoDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NjHW9y3Y;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE59606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 05:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDE59606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NjHW9y3Y
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc758830601so1537545a12.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 21:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793599171; x=1794203971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uEG4y+uDdeatRYNX0XhH9I87Gd5zifsbDCdQuU96RRk=;
        b=NjHW9y3YZkHp+p8V7rnZcwHqO5I0+EL9L+eXfiBk3+kTS30HnnYKu795pWUkwmvvQi
         ltjV/0RvJYAFmwpeU25xblBvrpiaEplnyz2dzKav1j0CPJ0G0K0w4DXvQH8MYfcE7L97
         gtJcKeBNPnTBhjBMZFh2A6RzAyTuNCDfHaDPNkQY5pCiavvtjtR6VPDVebe2Msc3dBVX
         KGCS9n9l85CbPJzZ6jGw2IOdLyDUllwhvRnXg8U2Oa7ZYpUdUw+HwobkWZ9VqmlmtJaL
         emqAI5W8hvCMRMKDTuvFct/aEQvS8M3OwUU9hopU91OWtRIxxk5/f6T85n5U6bUXoMW2
         JBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793599171; x=1794203971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uEG4y+uDdeatRYNX0XhH9I87Gd5zifsbDCdQuU96RRk=;
        b=dkdcVAUkasJhmOxd0m/djbJgGwUN6z1X3M7xW5aDwJ211W2Dv33Fqfazsh3jgZynko
         +khKwu2gkDEdH2Qy2wUYmS6MRXvER/zn93VfIOTWJcmwDgv62ssC8uvcQGIG2cH/x/ge
         xqf2e7xuCIxHquucYdGDMXfjRmd1wNMgZtY1pzMo0eWd96oyb1ZTpagCKL/75A0QPhBd
         A7b1CrtjcDW7m5FllT07kfhjso+pUSe/s+xaPz0eHPXfNAN57UeYv3BIpJ4t17KBzZJI
         Vmk+YL393hAuTq+9+76BWDSyTHmljx6Sp5p6HQe3kJStS+QOAjud8/HV2zKjtCMeDsZp
         qZkQ==
X-Gm-Message-State: APuU4Z9odD370pEmHNMOyPscdsEknJ+UXtSOMx3uZyYf75NIXbl3sYBc
	m1tpc+iyYVbbUEFVswnTnX1Fe1lN9LaQsX2p+vKuUkumEtUb98DgtZ0yJlC7Tg==
X-Gm-Gg: AYBFou2FQc0nEbAcP4a+qtyJnxS0ZrBHmYJU6++vFAKPO5XMxczHy9jh4FmzzKevZ58
	qiI+RaS4ZlT09UDvgVV+tRGU7ZsC3nLjvzIJoLo3nA+2bGE1TYt1S8Liy6TroK3GBmUTGVzrZbJ
	tC7JM9FIQf237c7uxeB134DDqB3+oIYDAamGtBz3RkV57KdJlQxdMK+kxepYtiVEG1N2ro+eZ8C
	RZfh4E26aIjaJhOl9KbV05NK+TDKt0HbI4USyzFc5vaBuCTIjV4Ha/n6+KVOUDC/hPoT1iYHz87
	1SzFJpWeuYKV0UMJeuM+jwkNl72D3d44iZXKz2FSpGULhSt/46xTkQx2nVJvtqLXD6LREwhZska
	7MqgaPenICdXc62I8M/MlEqn+j1YWOtuS7JHnigJTVYxw+1kX0/bbEXV6TWaXPb+9iJbIyMWwad
	AuQxM/QMHRHXqmBKJPLbZ6S9uH/6BRW+eOCRnoVPAqeIkwgXhVVRJ2xGJsoK4L1rLLIdGQDmOwX
	TPs9ub79/laKVf/ksPUdV9RiL+fIE7QesBEDGau1KawZu9b7ceITkzDz+BRVIOoqjmyWTngHKlH
	zBNY72msPXEIeBQUBgsH9L8ctfPLbuAMMh7ogCOY2K3UJoDxksoj4u+cgL1xVogNzIU+HZuz6CH
	GU9fdc+QDrnVnk/Skaw0nYFmNsnJ96BeMbs19TiYExPg+QXG5Z5VL3ImDM0NjgwEuP0PNezW/UA
	==
X-Received: by 2002:a17:90a:ec90:b0:3a8:10e2:ad08 with SMTP id 98e67ed59e1d1-3ae8982cdc6mr7802764a91.48.1793599171143;
        Sun, 01 Nov 2026 21:59:31 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aec233ba08sm2893979a91.0.2026.11.01.21.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:59:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 2/4] selftests/bpf: Test the join of fp+0 with a value that is not a pointer to stack
Date: Mon,  2 Nov 2026 05:59:11 +0000
Message-ID: <20261102055913.3598414-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102055913.3598414-1-alexei.starovoitov@gmail.com>
References: <20261102055913.3598414-1-alexei.starovoitov@gmail.com>
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

A register is r10 on one path and a pointer to a map value on the other
path. A store through it is not a certain write to the stack.

join_of_r10_and_map_value is a valid prog. It reads the slots after the
stores. The join has one branch for "pointer to stack joins other value"
and one branch for the reverse order. The prog has one register for each
order, and it checks in the log that it takes both branches. Without the
fix the slots are dead in front of the stores, and the verifier rejects
the read:

  reading from stack off -8+0 size 8, slot poisoned by dead code elimination

In join_of_r10_and_map_value_hidden_store the slot holds a pointer to the
counter of a loop. Without the fix the pointer is lost, and scalar
evolution does not see the store through it. The prog loads, and it
accesses a map value out of bounds.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_live_stack.c | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 5f9b11a81260..b5ae4f0d4dc5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2565,6 +2565,86 @@ __naked void stack_or_non_stack_write(void)
 	: __clobber_all);
 }
 
+/* @insns start with fp-8 = 0 and r0 = pointer to map value */
+#define WITH_MAP_VALUE(insns)						\
+	asm volatile (							\
+	"*(u64 *)(r10 - 8) = 0;"					\
+	"r1 = %[array_map_8b] ll;"					\
+	"r2 = r10;"							\
+	"r2 += -8;"							\
+	"call %[bpf_map_lookup_elem];"					\
+	"if r0 == 0 goto 9f;"						\
+	insns								\
+"9:"									\
+	"exit;"								\
+	:								\
+	: __imm(bpf_map_lookup_elem),					\
+	  __imm_addr(array_map_8b)					\
+	: __clobber_all)
+
+/*
+ * r1 and r2 are r10 or a pointer to map value, joined in both orders. The stores through them
+ * are not certain writes to fp-8 and fp-16: both slots are live before the stores.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("r1: fp0+0 + _ => fp0 ?")
+__msg("r2: _ + fp0+0 => fp0 ?")
+__naked void join_of_r10_and_map_value(void)
+{
+	WITH_MAP_VALUE(
+	"*(u64 *)(r10 - 16) = 0;"
+	"r1 = r10;"
+	"r2 = r0;"
+	"r2 += 16;"
+	"r3 = *(u64 *)(r0 + 0);"
+	"if r3 == 0 goto 1f;"
+	"r1 = r0;"
+	"r1 += 8;"
+	"r2 = r10;"
+"1:"
+	"*(u64 *)(r1 - 8) = 42;"
+	"*(u64 *)(r2 - 16) = 42;"
+	"r0 = *(u64 *)(r10 - 8);"
+	"r1 = *(u64 *)(r10 - 16);");
+}
+
+/* The counter in fp-8 is the offset in the map value r9. The store through r8 can change it. */
+#define LOOP_WITH_STORE_THROUGH_R8					\
+"8:"									\
+	"r1 = *(u64 *)(r10 - 8);"					\
+	"r2 = r9;"							\
+	"r2 += r1;"							\
+	"r0 = *(u8 *)(r2 + 0);"						\
+	"r1 += 1;"							\
+	"*(u64 *)(r10 - 8) = r1;"					\
+	"*(u64 *)(r8 + 0) = 4096;"					\
+	"if r1 < 8 goto 8b;"
+
+/*
+ * r7 is r10 or a pointer to map value. The store through r7 is not a certain write to fp-16:
+ * fp-16 can still hold &fp[-8], and then the store through r8 changes the counter of the loop.
+ */
+SEC("socket")
+__failure __msg("invalid access to map value, value_size=8 off=4096 size=1")
+__naked void join_of_r10_and_map_value_hidden_store(void)
+{
+	WITH_MAP_VALUE(
+	"r9 = r0;"
+	"r7 = r10;"
+	"r1 = *(u64 *)(r9 + 0);"
+	"if r1 == 0 goto 1f;"
+	"r7 = r9;"
+	"r7 += 16;"
+"1:"
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"*(u64 *)(r7 - 16) = r9;"
+	"r8 = *(u64 *)(r10 - 16);"
+	LOOP_WITH_STORE_THROUGH_R8);
+}
+
 SEC("socket")
 __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
-- 
2.55.0

