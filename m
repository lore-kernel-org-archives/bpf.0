Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519313;
	b=KB0H3wO9EEnDj0w/T9rRxl3tIftNIgXNiLPTM8r4QH2znIcl7uZxAOejDjfiDc7RWWMM
	 ifT/+uaFliEk1uY/DBu6hZxiCeRJ9Cvc5LwJGbEqiObrNaQwIYnG7xu5u/XM6z3Xs+hHC
	 zehg0OakopRcdhw+vMphdkNx4YHsUdXm/tbtCBTNW7BZBRv9dFNTwNv8lp3HbWtM5Vwhi
	 5KNAsrjWN//ZUju4wLoVuqynAYZjCLYjBj+/qI7WN/s8YS3v43ogciUzYeyQrAIemyvgA
	 rsEU4jAqgDAEKdihOsZuTTkJqgZb5UbN9SgF9FiSUaj3J0Nky/dlTu8HIg52sBiFOxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=1Vh8cHWL5Aey2mPQ9u7vC0kBFmfooizMgedRljRNRTc=;
	b=Rcgksb0hSh2kCLlG8IUp5c9ApGORhUoLZVUROaLz7iMgHOCQqsVktigbt19oWVORriC+
	 fJYvm3kWNWGtfXDNiMZ0+CbsgiGhO298rHG2Ou4X18PAifR4Dn8E3L/UN2lXdb/ympJda
	 0eqpp87cca2ha6Jdbxtv34xwLoZn10VdJowsmXWZ4JDUfB61mJ1fMn/wC4NFtAZOMJ7bG
	 hPHeGFlP1nqv2eL0VRWyAJneaopFfINnl2nRsZN3VhD6LPAXsLq4BisBxtKmGtgAyQO8a
	 HNqaqEw7WrnlBfC2qMbfn1AeT+j60HQ1Ox5JdzoJPd9bZ7XqN54p2m2jMhixAr0HrcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IAkvHtsk;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B02D606A320
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B02D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IAkvHtsk
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ff9833fedso10347655e9.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792519311; x=1793124111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Vh8cHWL5Aey2mPQ9u7vC0kBFmfooizMgedRljRNRTc=;
        b=IAkvHtskVrSDrPOfvRy5vyCkc/QMHWKrn13l17AAwQuKkATCBAtnGfzxM+1lAxctpa
         smTWEKaMxOn5fESCpAMtZrH8xUI1b/5nb8zduDZk2NRanXPhJrnA406oOliIlF3lhWkE
         NdF+9uOmv/YymNP2BOsrxhrSb5fbz7mMdbbJua6XZBhdolH/DLOVdhvTqKHRC420PagZ
         o3KErYyu+QA4xrZMTEJGuYojBMnz2V6NdkucmzRtg/utaCfuz422Qn4VO8nJ5qa7fcCX
         HXnQugP9CKs70zDgap98BXf5A+8RHJpPaoJnLFRKJv+sTHJXaF0huqhEMt6cb+YAI+0m
         lfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519311; x=1793124111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Vh8cHWL5Aey2mPQ9u7vC0kBFmfooizMgedRljRNRTc=;
        b=NZgOZkDKNLkk3h2Gb0VNW3KJcPv9/bzhXM+8YZ+6DF0OjschezfPLkrR5AbWfmKF1D
         gtYrJPiJSx2ZggWjYgROazRnw/D3KdyrFLpl6H5x6lYYX+yigZqkXMtiwPo/cjFovCJg
         syagYOFVqkmn3d587pxAafm9LvwXHH72dTuuN8YteddBTHT8W5cqBMjEKv9kLxuvlTdj
         KEWh4QpheKEf4zRgOUWaej4GrEym4By821zUm6GVK455s559l0zAEpnmA3b3nCH79zpJ
         KVuS2F2NOsm+55osN9KzxB54CzmOvxMY0vpbbVlO6Vzt9+8kdfVKuFzP1K60hNIH9neq
         IoYA==
X-Gm-Message-State: AFq9FYIjs9u42vxDq6VCoHwEUSUkXNhvk35h2S+8jJaFedqm6O0pCYbG
	A4IX2ddC4OjcLCkqfJ9x+m/qvPggAmHwsavj9nGUwOYfDIF0pHUnUYINpNbrN8VF
X-Gm-Gg: AYBFou2ID77fYtI/J5G1WX+Ux1IsVQYR/j9ap2US1cb7hzECEKAXURGmYFDY/QQbeBA
	geXTEn2vxOmolDV35JkeN9vFJYtk/yAoWba7xz1jpFusDfHC4EAaNr22kOfHBydf5HLD4nd7KA6
	aLJFNJQ23VvleAtUNgUxzkiaQCQVlAoeYf+ZLd6dWI9m6A+SKtvpXOFNVlWhmuYHu5Ok++yglyy
	iKr4k3kWymOl0b8DAFKaqu7jAlmiJd4Q12VNyRxAaSrzukWqazpBtRkXUW5QR0UzS+SOX2cjCoD
	dBXucoFllojEjRbc+ZyrbHjgbmL+2t1Km/0MUFcwdG0mN6geG/RPmkzTeCIf0d5KeBONLDlWFJt
	5WdMRDgykRoTR8AJ4a7j1AYLgK0a9ovbtABYa2JJ1xoQoy3pARh2zVQzvsihyZ4+hsvSoLHHqcC
	FUpwdLwpg0XLPtDTpACzzgBJxmpo42lhxO5aTLpDpeVJanxAIdI016qETHyoWMlWIL1yj82Z9Qg
	nr0r2VJMv5lzN5ADyye6B7q88qo48hvc6OGf8F6b4qn3G4CbMJbT88EDHdftLVz2oUuqoEL/+JY
	jJce6JzBZJryWoPJfBURu3BvQzZcEkT5p+f4qw==
X-Received: by 2002:a05:600c:3f0c:b0:4a1:e383:6811 with SMTP id 5b1f17b1804b1-4a1e3836c4amr170966615e9.29.1792519311271;
        Tue, 20 Oct 2026 11:01:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc1b227dsm3929905e9.6.2026.10.20.11.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:01:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/6] bpf, x86: Account for the r9 push in exception boundary program
Date: Tue, 20 Oct 2026 20:01:37 +0200
Message-ID: <20261020180147.1769873-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020180147.1769873-1-memxor@gmail.com>
References: <20261020180147.1769873-1-memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892; i=memxor@gmail.com; h=from:subject; bh=CkqVNOYscXku0hkK2YafFryBXO26kcVWQeSmXgWlG54=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIev6iodTmy70Xa6/8OKf4bxMmw1Xu/Z7XzkQH35H9fEtx q0HnloVdZSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAiUmaMDNMthTLaVp+trCg/ qct67cP8X4pM+46bbLTP13p31pbp0kqG/+U+Ms39q3yVPCPdy439JlcFOqVHrGjYnR83NeBpw99 jLAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A program with a private stack pushes r9, which holds the private frame
pointer, around every call. The exception callback of an exception
boundary program resets the stack pointer to the value the boundary frame
had at the call it was thrown from, plus stack_arg_sp_adjust, and pops
the callee-saved registers from there. With a private stack that value
is 8 bytes short, so the registers are restored from the wrong slots and
the program returns to the kernel with corrupted callee-saved registers.
Include the push in stack_arg_sp_adjust.

A tracing program with 64 bytes or more of stack runs on a private
stack, so any such program that calls bpf_throw() is affected. The two
private stack exception selftests run such a program; they pass only
because nothing observes the restored registers after the return into
the kernel. The case was found while reworking how the callback restores
the callee-saved registers.

Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
Cc: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 72a2a0a89e03..ea97e068efda 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2625,7 +2625,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	 */
 	outgoing_rsp = out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8 : 0;
 	if (bpf_prog->aux->exception_boundary)
-		bpf_prog->aux->stack_arg_sp_adjust = outgoing_rsp;
+		/* With a private stack every call site also has r9 pushed. */
+		bpf_prog->aux->stack_arg_sp_adjust = outgoing_rsp + (priv_frame_ptr ? 8 : 0);
 	emit_sub_rsp(&prog, outgoing_rsp);
 
 	if (arena_vm_start)
-- 
2.53.0

