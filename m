Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546616;
	b=fW/Xspj4rnMIHGhx6inEFPUgrqk0YM+k3io8OyH1y8UzUsdpL3chSkrrSjjTF7UfHU2t
	 QvU8vkk1K+9FDUBSRYO9mCD7Qjzbv45TGzU8WvNjtUKBin23QqLSvOjXYAi9/GdxDR3k1
	 rIB2zIPZnge7OPUP0/kmvrG4s0dNaV+fulcQqXG6Y+WVd5KMjHgkWl+pylwkww4z3BZId
	 jubbK4xAwyITdUVVzvLolzNt6R/B92rul3Kt+WSaH3cB93ALsjOo5pfGbDtHWuowyt/ud
	 r07yJF26sGv8VBeaP/p4ROZeBPpbl0ako9qD33CpiSZW4dOwnKpqRAMuuAGPIhPu+fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3iQVCS1aoo6lbMf9eY8wjB5AOxvcLiLUEZoVQHtgSIo=;
	b=G9yp0y411qstlRCYS4Unw1A0qemo7FOXL1ki0tCzFX54pFJZDmh2p/ZDsB8fXVLsMMI+
	 KSOe0cgJYVKqmiMI3k/QuesRK16LW56pxtmo2eRru0Msxs3TvUQWfZgjtKxJnAgRm3Aql
	 T5ZKtqXxrvWSbpwyJvhFto3mJ65T0E7Kpf/Ksl/oUZhw0u8Pc+AFvW6nOJDlkGXYESXJ9
	 8R7kG9JcF/bwhhwOt4asMxw5sYnFqYNlGR/sNOLwOCfw3d5h/C/iqDECWlflGhQ2o6OjC
	 kyoekODJAnXB0cAF1w2xO4FccUYGW/D6nmNBO8wdtEk09dNWDyp6RY8CcEHoT6iMcBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OqWMvfVB;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C28606A327
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C28606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OqWMvfVB
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso218726a91.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546616; x=1795151416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3iQVCS1aoo6lbMf9eY8wjB5AOxvcLiLUEZoVQHtgSIo=;
        b=OqWMvfVBhMVcS+FQg1PBPiSacArxVBQ/ofIUFAxzNhyzD6Phgdd0omXAqlmWb7gk6f
         JeENC2X4Sa6mPsE747lBmZuv+1ERpOl1dPJsyaF5MgZIV+9YXx+J+G+7ShCebkhhqwTF
         YV/0Dn2wMdYPj795BlkIwmCMJibctigih2cTR8mfXQ2SssPGQcSu6HHCABQeMzWau5kI
         r88ECXZZmAGHTzaJKeRFzlkFXmwbcPbX99xA18XmO7Y1eIyG8b9Jj9ab5W09TH7MxZ0Z
         AjMl1Re/K01lSYffuJD8JpoelF91EVwjC/sOPNh03v4MUXZR/JZbqbjNnngvHKJEqiLv
         KtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546616; x=1795151416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3iQVCS1aoo6lbMf9eY8wjB5AOxvcLiLUEZoVQHtgSIo=;
        b=ryfP2QEZp8+lBL1YXLntzTjEknXXkeXnuecZNkxiMhWcHATEaScyzKHqvGvZ/l2hPW
         ceTJaOvPwNBIEWUAVA/byDLKShR6MHpyLtuL+6l3e8sBtR3hsX4/4OKVB2Xs+akaA1zu
         Q4yh8WLn4ultRlfEdm2+TIzHHSQp5UN5BDQy90Xxp8pPkU+zno9GgEg5BlrJzsZIdiYj
         n7GIWlWXMs43yP5m25VGpH3g9YSHQVbR+5DGpLtvAWw25JIs33lIoGhR1LoY+SHk3PeM
         YlzENno6YWiE4zm2oMt71ay9UWMNvdqwQFv8hsIESR2PDavsD3PfZQVdopU+iAKw64RV
         wLGg==
X-Gm-Message-State: APuU4Z9Irq0qr3kqSsjY3qKmTIP/KNcB/bR7N6k89OJ3jSj0DDUUwybA
	PIGmaH8oyoOj5bEkbjlnxmnuSewHjwqMk7KWq2Wa9MoAEeDBPWxyBd1CPWgcog==
X-Gm-Gg: AYBFou2SZj3573WtGsjnSUR0oB+8y+CN53ciNY0ayl8v737NsY78k0pdsthhLBjBVe5
	kqvGjLEFZnxfhmqFkqZywcVeyON7mEhrvL4FJ+OQrCIlvJ6Aa9XLVzNHdOnSNzbX5WqHw8c/sAj
	dpiNI5UBOtzESd/yKoVkQ4cW/CG3phmY2tQtv1nSleszUKiOYSsnq7hvD6Aj7kt5hoNdVunD1K0
	xVOhUeAJ7qOFEkEHKVNsEcHkPHN2nNvZoYN7ipZyxDeUFylzlW1GdrPf4kYsY7HXb+GXsQdfN0W
	LA2Khxcq/vdBFkijyrZenpRzT4tdQjCQOb/1fcy+C6gQqoVPofvBLHZuxcKgg3CZHlkr1T5Otho
	C9b+jltXUPLnxrQKInnOUZ7aWY/Vd/V7mrY2ugTOXo651zrMzBAPkJ1szm17ZAGh5hvMfkxhIh3
	p6FHk3xHQEhDsXy/emqeyRQunNhlUeXBsC2k/8cNVYixdG/ut+pd49y4VJLboltqEAOHrSm07Em
	wf0isxpw2UFxDJXMzBe+Be8b4v5kP+oK2FOjl5EBuVmfAlFjnjPaItx0d2DalUsF9yW5PlQRdxX
	nUPzwdnQjmAzTYG9gDDjpWPBa8y7qr2PhBSdaMdNC6wXxQcwoKi2Y96ugPjRYtzW/8joSlgcl4E
	3GMSpCRBKzU4qLsHMzk1TYEBeZGWPeJoBrgZSadJhHevVocJv7CYbsxHnAr0DLKfBpWIZctpWMw
	==
X-Received: by 2002:a17:90b:3c4e:b0:3a7:b260:9ced with SMTP id 98e67ed59e1d1-3b1b0b87f83mr1086685a91.58.1794546615550;
        Thu, 12 Nov 2026 21:10:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce556dsm7686226a91.6.2026.11.12.21.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:10:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v2 bpf-next 12/13] bpf: Treat the type of an untrusted pointer as a hint
Date: Fri, 13 Nov 2026 05:09:00 +0000
Message-ID: <20261113050901.1399091-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
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

A prog that guards a kernel function wants to read what the function
reads, in the words of the function:

	SEC("fmod_ret/tcp_ack")
	int BPF_PROG(guard, struct sock *sk, const struct sk_buff *skb,
		     int flag, int ret)
	{
		if (tcp_sk(sk)->snd_una == seq)

	dev = container_of(skb->dev->dev_list.next, struct net_device,
			   dev_list);
	if (dev->ifindex == idx)

tcp_sk() is a cast to the struct around struct sock, container_of()
subtracts an offset. The verifier says:

  access beyond struct sock at off 2544 size 4
  R2 is ptr_list_head invalid negative access: off=-120

and the prog falls back to bpf_core_cast() or bpf_probe_read_kernel().

These checks guard nothing. A load through an untrusted pointer is
BPF_PROBE_MEM, whatever the address. bpf_rdonly_cast(p, 0) and the load
of a 'u8 *' member give PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED, which
has no bounds at all. The type of PTR_TO_BTF_ID | PTR_UNTRUSTED only says
what a load gives.

	the walk of the type finds    the load gives
	a member                      a number or a pointer, as before
	nothing: past the end,        a number
	negative offset, a part of
	a pointer, a variable offset
	that matches no array

The number is not a pointer: tcp_sk(sk)->out_of_order_queue.rb_node can
be tested, not followed.

Stores, atomics, helpers, __user and __percpu arguments are refused as
before. Trusted and RCU pointers are checked as before.

Five tests took an untrusted pointer to see an error of the walk. They
load now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 19 +++++++++++++++++++
 .../selftests/bpf/progs/map_kptr_fail.c       |  2 +-
 .../bpf/progs/verifier_btf_array_access.c     |  6 ++----
 .../bpf/progs/verifier_btf_flex_array.c       |  2 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |  3 +--
 5 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 960231ec591e..7d8449baca4c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6844,6 +6844,24 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
+	/*
+	 * The type of an untrusted pointer is a hint. A load through the
+	 * pointer is a BPF_PROBE_MEM load, whatever the address. Where the
+	 * type describes the bytes, the result has the type of the member.
+	 * Elsewhere the result is a number, as it is for
+	 * PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED.
+	 */
+	if (atype == BPF_READ && value_regno >= 0 && (reg->type & PTR_UNTRUSTED) &&
+	    !(reg->type & (MEM_USER | MEM_PERCPU))) {
+		ret = SCALAR_VALUE;
+		if (!check_add_overflow(reg_smin(reg), off, &min_off) && min_off >= 0)
+			ret = btf_struct_access(NULL, reg, off, size, atype, &btf_id, &flag,
+						&field_name);
+		if (ret < 0)
+			ret = SCALAR_VALUE;
+		goto loaded;
+	}
+
 	if (check_add_overflow(reg_smin(reg), off, &min_off)) {
 		verbose(env,
 			"%s is ptr_%s access, offset computation overflows: register's minimal offset is %lld, instruction offset is %d\n",
@@ -6926,6 +6944,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (ret < 0)
 		return ret;
 
+loaded:
 	if (ret == PTR_TO_ARENA)
 		return check_arena_member_load(env, regs, value_regno, flag, tname, field_name);
 
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index ac4003bfb8b0..4553d41c6ebb 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -164,7 +164,7 @@ int marked_as_untrusted_or_null(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("access beyond struct prog_test_ref_kfunc at off 32 size 4")
+__success
 int correct_btf_id_check_size(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *p;
diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
index 9dc2c9a5f8b7..5accc0279c37 100644
--- a/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
@@ -482,8 +482,7 @@ int flex_array_field(void *ctx)
  * not match.
  */
 SEC("syscall")
-__failure
-__msg("invalid variable offset access into struct vring_used")
+__success
 int flex_array_unaligned_step(void *ctx)
 {
 	unsigned long i = bpf_get_prandom_u32();
@@ -511,8 +510,7 @@ int flex_array_unaligned_step(void *ctx)
  * The flexible-tail exemption must not apply to that fixed array.
  */
 SEC("syscall")
-__failure
-__msg("invalid variable offset access into struct unix_address")
+__success
 int flex_array_inner_array_out_of_bounds(void *ctx)
 {
 	unsigned long i = bpf_get_prandom_u32();
diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_flex_array.c b/tools/testing/selftests/bpf/progs/verifier_btf_flex_array.c
index 59b84261f622..63a9f6372a8b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_btf_flex_array.c
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_flex_array.c
@@ -26,7 +26,7 @@ struct {
 
 SEC("syscall")
 __description("btf walk into flexible array of zero-sized elements")
-__failure __msg("access beyond struct test_flex_batch at off 4 size 1")
+__success
 int stash_and_peek(void *ctx)
 {
 	struct test_flex_batch *b, *old;
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
index 345cecc722a3..d6a6a58c73c4 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -219,8 +219,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_kptr = { 1 },
-	.result = REJECT,
-	.errstr = "access beyond struct prog_test_ref_kfunc at off 32 size 8",
+	.result = ACCEPT,
 },
 {
 	"map_kptr: unref: inherit PTR_UNTRUSTED on struct walk",
-- 
2.55.0

