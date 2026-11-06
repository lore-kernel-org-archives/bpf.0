Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937262;
	b=utanYebqvRThwH7tdSVCugSuDdDwpal1hLXxTajU1GzSKJ9GSnRsxmPsj6VmQvDDfiDM
	 F3aX/hWtmPPVJDeD8THNZhhtisQFgg9YFfDCoI7aSnRP/JjpcWd5U3uuS/i5UAwFq743q
	 hkUjIVB+Ez0pYs0jLJIqy6F5P7x8OuBgP8XV1LumMWfldPqE/FGkNHKgjF36C5dYsJvB8
	 1AeMiwESMhcD4dVEH9CQ9E+MQwzry3yghwFPPnjcioK4pSUzECwddvIdsuLVts51TUtZD
	 RxMh5h8k9XN2HhMEzlnrlEY/Klb4oHGTjVk8/A7SYI2/ekqXgZ7gnI3jmq0CsAdAOmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K8XlO7Z2TIKLNft26mUYqmF8LUcyor+5X6I9Eqo6pUg=;
	b=1wK6FxSl1Dpd5YgfWASVorrNyEZH6grPou42CTAFgrmhj99hABw7VM3tR9Jl4OOK2opq
	 fPVpVa3d0Wd7ZD0GmK1FdSyER4289uciKmlx5tdoyRSD/1tgbpdP1KItxCl//coMVswcX
	 k9YN/TjdlNdux4Pb6Of5UAvpitPNisMbim9Z/ryfxv/dmqa7zv6CVzYBHQQazcP4bOkt2
	 k/HaDB5iEr3WbEvthkvxhOHtIxRfVwyj1pfiyKx0Q9alsHXU7hiHsEbbi05EzFAoCaVAu
	 EDxsG/P8M1U7HezOVfucYTjIF7HJ7Z3LWFbqSvM8ps0f2w/VqWvswKEBxfEO3fg11lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NjxF4fEN;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BCB606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43BCB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NjxF4fEN
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso105509a91.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937262; x=1794542062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K8XlO7Z2TIKLNft26mUYqmF8LUcyor+5X6I9Eqo6pUg=;
        b=NjxF4fENLxFO0tAmdy3brLo/eHsDNx4TONT94rgqI5db2m0z0wK1leuzAR+JvEdtnC
         AcIn94yMCe0gLK9BpadNyphDh5DeQ8+o1HNHLAnNFgjHEBRhOjZi1/HrGHVheXrFL2Qq
         hn8BgFka1RExDnCsgpYBbBDCfK+Y3hByfJ1IiXPfSJKHsFW3vSaOCnRIhqFJwRIw0qe4
         hjChxXKQLil5tg96BGii8oiwcEtRwNl3N7qelKKUfnaeCeJrDyQNo8vb81oxwyIxRMpx
         Rxv97+deekKMy+/LnPyWiEtd8+rSC8VHAD6jAmVqYVziJY9VOXIXHzPrw08N8b9cpFGH
         DPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937262; x=1794542062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K8XlO7Z2TIKLNft26mUYqmF8LUcyor+5X6I9Eqo6pUg=;
        b=MUPNgzYduByfsdLh9PE/T/Q7S5o8Xck4m7yJbnz9ORHqVgqAaQNv+har0D2sidV5em
         R83toXGUJTYNytZFeNMVXRlNTu3s0nJPWJjliX5/JdYTLKKOB3mG9qTkSs11qYr1TwRP
         owe+IiYAAPIzNaW4DXZdflEXqLMvecCHn0I511lsYMx4/w87j1kwBm0QaDnspQpKOix7
         au0g5V1RevVRWosDuOQXpKevgVDzhVoH210P12v6wPwqAsPFAHuvfJmgNz89WuGfdT5f
         NE4RtexQMWebI0tiWZtVeBI91hJ6JZhJ9wKSaEH1zTxqgSK+H+4o0llwbVnMtXVxl5SD
         umjw==
X-Gm-Message-State: APuU4Z/0Q7YejmLkVN+ExCoiyAG0rAiySE3KhNdAYlQwhul72g509DEu
	yZN8ZAgFkK86TA0w6ZkyT28i17wMJhDJDayLGLuY7kSc4l96DzEmCD67iJp6xg==
X-Gm-Gg: AYBFou25Y0Jwkpx+2fANHeXqdOKLKu0qkxKM/vfSeMZpL23tM00Huex3a83Z4GQfHp3
	IREu62z8hsIZ8WyzA6dAElhuZZHSeCAX9iFM2tNGXP7Sng0Xxd7zqO0N22svqeP23lr5Pw0zckP
	iEi9tKbsNddNpQaq7AEadJCwnBjcNvcvcYCg2TbfQ2Kvb2NhIuCYs8iLvbzo49nn3fCuOzBJQzm
	q6d/QNq7Tb3jWhxgREBBQvrUtLo7xFLfGXpe/RdZ98jQ0zk04VHoR86cyLixBK9c5JaeZ6VfgMh
	kJziZqztSDAMBYEt01UZe3a15q/1/hiZKaFLsBODrBW2Q2Orp8y5L24PcdzSu8jY7UbS6zkiJDy
	2YxZQUruN8NUIR2IyfcwWmWSntkPMGeSnUgY/BOxd8vZ+5xpRzy8LF5/boIV2RXsPqhaCxJXaAW
	4Lnip41UBb4lJaP2sosiRZ9mE692964eN93upSfqbgtSnqFfE/TaEhjKptjsD4TQ+gGppKzEBgh
	E37gISNyg9JCAIp7CQbb9F9H3lECngmTAafpIhkP6FSpUMS8/wi5F61nXp6Kado9KayzYGaE2OM
	pUGIxnXugmkAFAC11Y1eXBQiXboZyGMS+IqyXfUSDXjvm1RTj7Z5WGlsSVwGY9dV63cH5e5W+WO
	65RM8ecQR6uLta4upISeFs6ReLIfRwhzgJfy2FkXjAvz8mShEozH7YTchszIQtaJ9o6AYC0j5XA
	==
X-Received: by 2002:a17:90b:1dcd:b0:3ab:f38:2b41 with SMTP id 98e67ed59e1d1-3b0db703cdemr1157276a91.39.1793937261356;
        Thu, 05 Nov 2026 19:54:21 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0e4ee855csm14067a91.4.2026.11.05.19.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:54:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 32/45] bpf: Keep the frames of the caller for a subprog that loads data_end
Date: Fri,  6 Nov 2026 03:50:56 +0000
Message-ID: <20261106035111.3315285-33-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

  static __noinline bool has(struct xdp_md *ctx, void *p, u32 n)
  {
          return p + n <= (void *)(long)ctx->data_end;
  }

  void *p = (void *)(long)ctx->data;

  if (!has(ctx, p, 14))
          return XDP_DROP;
  return *(char *)(p + 13) ? XDP_PASS : XDP_DROP;

has() checks how much of the packet is there, for its caller. A static
subprog that is verified on its own has no registers of the caller, so
the range that the compare finds does not get to r6 of the caller:

  invalid access to packet, off=13 size=1, R6(id=0,off=13,r=0)

The prog loaded before static subprogs were verified on their own. It still
loads if data_end is an argument of has(): arg_needs_caller() keeps the
frames of the caller for such a call.

Do the same for a call that passes a pointer to the packet to a subprog
that loads data_end from the context. bpf_flow_compute_kinds() asks
is_valid_access() about each load through the context, and notes it in
bpf_subprog_info.loads_pkt_end.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 2 ++
 kernel/bpf/flow.c            | 2 ++
 kernel/bpf/verifier.c        | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 78a787aaba44..4c0939d91fde 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1020,6 +1020,8 @@ struct bpf_subprog_info {
 	bool stack_args_from_code: 1;
 	/* it releases what its caller holds, so it's verified in the context of such caller */
 	bool releases_inherited: 1;
+	/* it loads the end of the packet from the context */
+	bool loads_pkt_end: 1;
 	/* a call of it was verified on its own: its insns are not in insns_total of the caller */
 	bool on_its_own: 1;
 	/* it can leave with unwind_exit: it has one, or unwind_goto follows every call of it */
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index 51c7cce57b49..a14490511a25 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -714,6 +714,8 @@ static enum flow_kind flow_loaded_kind(struct bpf_verifier_env *env, const struc
 		env->ops->is_valid_access(insn->off, size, BPF_READ, env->prog, &info);
 	/* it notes what the prog reads, and this is a question */
 	env->prog->tstamp_type_access = tstamp;
+	if (valid && info.reg_type == PTR_TO_PACKET_END)
+		bpf_find_containing_subprog(env, insn - env->prog->insnsi)->loads_pkt_end = true;
 	/*
 	 * Only the context has pointers that are shorter than a register. A base that nothing is
 	 * known about can be the context: it came out of a struct, or only some paths have it.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2a0d5a280a1a..1fa37faa8e69 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11602,7 +11602,8 @@ static bool arg_needs_caller(const struct bpf_verifier_state *state,
 	if (reg_is_pkt_pointer(reg) && reg->id)
 		return true;
 	/* it checks how much of the packet is there, for the caller */
-	if (reg->type == PTR_TO_PACKET_END && !sub->recursive)
+	if ((reg->type == PTR_TO_PACKET_END ||
+	     (reg->type == PTR_TO_PACKET && sub->loads_pkt_end)) && !sub->recursive)
 		return true;
 	/* or whether there is something to point to */
 	return type_may_be_null(reg->type) && !sub->recursive;
-- 
2.55.0

