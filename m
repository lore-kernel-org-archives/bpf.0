Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD56D353ED1
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770239679; cv=none; b=nRWoTLVbGhi3v+s1n0VNU80jdGNDXJ1rKElh0bUaZ/gImkx4dXzg2/csj4kzfLXCf1xFHysd/9dVKkXw7PYpm50BXIArrPs1KkuwCiCGIccokGQd7hvrJey5v9B16FcoDx9waqFtiqp+DU69hYWL2lWMgZo7VRUmhnT+KolRNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770239679; c=relaxed/simple;
	bh=vJaBhMWH5pT1jXjbnJkk1Uuz4c1EfZ+roLHnfr47Lhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ht9bvIA4xqsvHnfjROnd1qis6LNC2+qTsUVw3jWAEXX4qcf0sLOOooaonfLLRombo+v589hADbmX5WyQizPekJj4hXUfTEKeSk3dy1woCY2Q1ir08Js+s0lyNYw0EtDoIM5CKFGJpr4OtpMS9p0R9p8ru71BPMFimHUqhiWAxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9Hduqs0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9Hduqs0"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-352ec74a925so283401a91.2
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 13:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770239678; x=1770844478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx+gPwWi4jfbtwZqP36zqhC/LfHvmZ4z4w0gN+mYPes=;
        b=Y9Hduqs04Ni7n6Om2KP29LgY9PAoE+O2reCSyR15azTr4WZzkNYOaR4uTpfd9EmHNA
         eqJZgVMcIjz3WJCejmBLeUq7D/ZXBMl9GIGfO5mUr40TntYPiDe9eJN6a03D9Sb0E3Po
         UyyKdFe5O0N0UIvs9ojPUFfyp5Lh9/+FGXlspxD8Rn/G2LJewnUg/ChXUS2/7Ktlxcdy
         6+uWVFeub1nqas6Cr+2pZWHjR4WfIWt+RWuTmet9eRTpinlW+PkvRQock5Csnv6c+pv5
         0SfnzatAHXycYu8r+cm1PBFOS6P0Pbvw2tTPWvkchd09obeH05S5Acc0FduxIxtkQ6HV
         CdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770239678; x=1770844478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx+gPwWi4jfbtwZqP36zqhC/LfHvmZ4z4w0gN+mYPes=;
        b=R66rfTQ6GPxaegnA0qSsoACublkha/CoZoVJkTJLBDdYFhaSTriTNVyhfDONxQ28oD
         U4HrA4xGcVXaNqWjIbQtKDzSP3eKeM2RvCL1KZktZWObhmROdW4RuW6kVm0kKSd8eDb0
         Ki+/4CUGHrd+Z+jezgyiEVh/OvfER92CQIWODhBfz+g2vJJhkjhJSRWUydfexp5ooezo
         wa2D3UBiVYRj4NAa5tT5G+MLMgSfSauk0uxLMmvJgcy4Em13n0hx/Rc8fW637HURotQU
         t/NYPY+7ZboA+15Rd67IFkBaSLbi2NyEHALtlRKIza490+5Su1CbcsG44FuGUqzT2otH
         PESg==
X-Gm-Message-State: AOJu0YzV7ly0S/8ci2YQs8TJkkGst/dxeuaPI2+5r+79xubTls8JVGGH
	qy6CFu7hq45Pl7srM6HDncxctpw7jIdKxt5vpHxpHf+zRY/u00b3wCWeE3JCYFbedr7utEkTQdQ
	pdv5X2w==
X-Received: from pjps6.prod.google.com ([2002:a17:90a:a106:b0:352:ba61:b351])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dcd:b0:34c:9cf7:60a0
 with SMTP id 98e67ed59e1d1-354870aad58mr3408954a91.5.1770239678292; Wed, 04
 Feb 2026 13:14:38 -0800 (PST)
Date: Wed,  4 Feb 2026 21:09:59 +0000
In-Reply-To: <0f8ec4c7-5de4-4e0b-a50e-cf4f8d59709b@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0f8ec4c7-5de4-4e0b-a50e-cf4f8d59709b@linux.dev>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260204211436.1821958-1-kuniyu@google.com>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto update
From: Kuniyuki Iwashima <kuniyu@google.com>
To: martin.lau@linux.dev
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, jakub@cloudflare.com, 
	john.fastabend@gmail.com, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, mhal@rbox.co, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Wed, 4 Feb 2026 11:34:55 -0800
> On 2/4/26 7:41 AM, Michal Luczaj wrote:
> >>>>>> If the concern is the bpf iterator prog may use a released unix_peer(sk)
> >>>>>> pointer, it should be fine. The unix_peer(sk) pointer is not a trusted
> >>>>>> pointer to the bpf prog, so nothing bad will happen other than
> >>>>>> potentially reading incorrect values.
> 
> I misremembered that following unix->peer would be marked as 
> (PTR_TO_BTF_ID | PTR_UNTRUSTED). I forgot there are some legacy supports 
> on the PTR_TO_BTF_ID (i.e. without PTR_UNTRUSTED marking).
> 
> >>>>>
> >>>>> But if the prog passes a released peer pointer to a bpf helper:
> >>>>>
> >>>>> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
> >>>>> Read of size 1 at addr ffff888110654c92 by task test_progs/1936
> >>>
> >>> hmm... bpf_skc_to_unix_sock is exposed to tracing. bpf_iter is a tracing
> >>> bpf prog.
> >>>
> >>>>
> >>>> Can you cook a patch for this ? probably like below
> >>>
> >>> This can help the bpf_iter but not the other tracing prog such as fentry.
> >>
> >> Oh well ... then bpf_skc_to_unix_sock() can be used even
> >> with SEQ_START_TOKEN at fentry of bpf_iter_unix_seq_show() ??
> 
> It is fine. The type is void.
> 
> >>
> >> How about adding notrace to all af_unix bpf iterator functions ?
> 
> but right, other functions taking [unix_]sock pointer could be audited. 
> I don't know af_unix well enough to assess the blast radius or whether 
> some useful functions may become untraceable.

Considering SOCK_DGRAM, the blast radus is much bigger than
I thought, so I'd avoid this way if possible by modifying
the verifier.


> 
> >>
> >> The procfs iterator holds a spinlock of the hashtable from
> >> ->start/next() to ->stop() to prevent the race with unix_release_sock().
> >>
> >> I think other (non-iterator) functions cannot do such racy
> >> access with tracing prog.
> > 
> > But then there's SOCK_DGRAM where you can drop unix_peer(sk) without
> > releasing sk; see AF_UNSPEC in unix_dgram_connect(). I think Martin is
> > right, we can crash at many fentries.
> > 
> > BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> > Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> > Call Trace:
> >   dump_stack_lvl+0x5d/0x80
> >   print_report+0x170/0x4f3
> >   kasan_report+0xe1/0x180
> >   bpf_skc_to_unix_sock+0xa4/0xb0
> >   bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> >   bpf_trampoline_6442564662+0x47/0xab
> >   unix_shutdown+0x9/0x880
> >   __sys_shutdown+0xe1/0x160
> >   __x64_sys_shutdown+0x52/0x90
> >   do_syscall_64+0x6b/0x3a0
> >   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> This probably is the first case where reading a sk pointer requires a 
> lock. I think it will need to be marked as PTR_UNTRUSTED in the verifier 
> for the unix->peer access, so that it cannot be passed to a helper. 
> There is a BTF_TYPE_SAFE_TRUSTED list. afaik, there is no untrusted one now.

Just skimmed the code, and I guess something like below would
do that ?  and if needed, we could add another helper to fetch
peer with a proper release function ?

---8<---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3135643d5695..ef8b4dd21923 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7177,6 +7177,14 @@ static bool type_is_rcu_or_null(struct bpf_verifier_env *env,
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_rcu_or_null");
 }
 
+static bool type_is_untrusted(struct bpf_verifier_env *env,
+			      struct bpf_reg_state *reg,
+			      const char *field_name, u32 btf_id)
+{
+	/* TODO: return true if field_name and btf_id is unix_sock.peer. */
+	return false;
+}
+
 static bool type_is_trusted(struct bpf_verifier_env *env,
 			    struct bpf_reg_state *reg,
 			    const char *field_name, u32 btf_id)
@@ -7307,7 +7315,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		 * A regular RCU-protected pointer with __rcu tag can also be deemed
 		 * trusted if we are in an RCU CS. Such pointer can be NULL.
 		 */
-		if (type_is_trusted(env, reg, field_name, btf_id)) {
+		if (type_is_untrusted(env, reg, field_name, btf_id)) {
+			flag |= PTR_UNTRUSTED;
+		} else if (type_is_trusted(env, reg, field_name, btf_id)) {
 			flag |= PTR_TRUSTED;
 		} else if (type_is_trusted_or_null(env, reg, field_name, btf_id)) {
 			flag |= PTR_TRUSTED | PTR_MAYBE_NULL;
---8<---
