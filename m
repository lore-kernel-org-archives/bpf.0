Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21923BED06
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022984; cv=none; b=W75P3bil1c7esCkp2Jjs4iH39qqAB3FuT1Uxkws6a5xOJaQuZSGkE4ggvzFynFXHpzSyh+nwMkfGTU2BcUI14vxEj4VlirpKKNHec/MKqS4co/TlTZj9UolOaGelAICNZFN/rkudZU2rpUu8M/BSVk6Q9tg4j7i6xIiWzC57Uik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022984; c=relaxed/simple;
	bh=oVxXvNlK+2x3E33IMRV6GjfD0zx1nEbsNx5xYHuYv2w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=TX6idVVnlckJVMkPyMceyu17eKv+bmJxMuh+xq45kyIqQkbfhhfFy69MXXUzBtzg3dvkNy0m3ePgWUYRBgXsBYEB7IDMmxZourjBuhoLhu4FuzpiaSGDPI/I+pRbeAw3tHOf3IRZM5DI63f1ZMMuaTMmwRMKyPBx9aG1P17p1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=XeQ5AIDi; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="XeQ5AIDi"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137335bc3caso7097413c88.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781022982; x=1781627782; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Zm66UDgugDuJh+suaGoWf+oPueZ1pKYv/n0XCt6RiE=;
        b=XeQ5AIDiFHtmODUR12yVSegTZDC6+2LTuwQS/yAuk5g/SAHha0Il8F90wJ/geXl95B
         vMWVKK7PsGjDAzKSRKX1Yx+d/BVJqc0Iumf5Jsec5f2FVpi0wbiGXvL7T799z9uDHs/Y
         nCKUPhEcnNjwQS9Fh0t7ra2HqLz35VTEV1sJgGoiWWT3nT7BE/Shk2pz8Fy0XawiMKa8
         ebeDmFY06BgotWJ2SI1Zu/4ZQmB1w09FjMACltvSTw3yWaqD6n/swVVz1gyHkUmMcO8o
         7dXel3SCd7sybYdXP51Km8JhqZgFs/dv9vIXAaUhqXFFdDed/dSsX8J51NCNSeKlRYw4
         q40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022982; x=1781627782;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Zm66UDgugDuJh+suaGoWf+oPueZ1pKYv/n0XCt6RiE=;
        b=JCsEEKj2Cw5yxLYdbRlKmpT3oFDe+Ks7UmV/O3+bMI6YLSaDCGK7t3Rdo2uzWQVooR
         Dv8iZoasfOWVCqRv8x+YT73a2VXpEMbmr3ea6nks5hqHxCS1ap+bj/HJ8lKPVihECoMT
         6ujI+6OVKxpQhTkKtkcSGYrqtqWkPNi/67oOF+iGHBTIlktZfhdD5NMrd9+Cws6P1ryX
         EOgjhX2u1RI92+aXec9PHXAP/bf5gTDyoZDYjeERDbFTYzqsd/2UKk6U8MgbDgP909YL
         4FjxbU5NauyEO+26vfX8BIQ0SaBwJvXWN3lkIE3pxtLbHKwLep+/6BN47mriK18ixzLB
         8A0g==
X-Forwarded-Encrypted: i=1; AFNElJ8tTVSaAgSGeeKQwEvonEveH3ZfjMxIT2sCf7pBgKmyjXKKx+QJYYf6R805E8GVKVaFqYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8yJlCMiafdA7nP2XhCtCEDDEBPhmsCCNeiGEPSasACeC3txY
	5A3b3TVN9vVSHUXuJq9ztJQ07iHZSlhhXqlGUpdeFX/s7NHCBgqFqezbytdQeeqM6MU=
X-Gm-Gg: Acq92OFEiYU0HI0duzLQbhB3iqtkyj9mkYwLUy5E5FS8VoesztUTxFdbWe9yZV+SVKY
	1/MrKAR2g5f/y7SIF9u2CwCHSngFXYB3S/8YSYLDTgDvP0mzMZdrV0KTbDFTzNAMOiyiSzw3z/n
	WOaIGdW3SVURQrkUQokP8mNjgUe9mzHAMqAPCBhqg+cXZxteadvhjFZIymtIsWhZLlcQQaXocep
	Q9e6d1OQ/iIWUcQaRgnxgDD8LTw5tNXgd0as2rNL2KwzNrC7ET2RSdCIBcr2EJZL9qtK+hV3VBu
	BTN20vioR/0kcOSWuzZOWytX08lNKnloRV1HFNa5nzLeZh+sxeAcdIqwwvyGS0IEXEO5S1ksqTN
	UwsnP8sHos5ijqu+D0M/v//qh7Qc1F6cb6VZ1KRpCg4ngbCD8DAeIfMjqTK+k2RYBAItfVs38GU
	JsQ0NuQhxG7BoDBus=
X-Received: by 2002:a05:7022:ef18:b0:134:cf34:b8e0 with SMTP id a92af1059eb24-13806660872mr11361311c88.9.1781022981682;
        Tue, 09 Jun 2026 09:36:21 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::3297])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f554f732sm15063231c88.12.2026.06.09.09.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 12:36:18 -0400
Message-Id: <DJ4NYD3BBJ3A.3TEL5PAOUE579@etsalapatis.com>
Subject: Re: [PATCH bpf v2 1/2] bpf, lpm_trie: Allow access from sleepable
 BPF programs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vlad Poenaru" <vlad.wing@gmail.com>, <bpf@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260529174233.2954240-1-vlad.wing@gmail.com>
 <20260609135558.193287-1-vlad.wing@gmail.com>
 <20260609135558.193287-2-vlad.wing@gmail.com>
In-Reply-To: <20260609135558.193287-2-vlad.wing@gmail.com>

On Tue Jun 9, 2026 at 9:55 AM EDT, Vlad Poenaru wrote:
> trie_lookup_elem() annotates its rcu_dereference_check() walks with
> only rcu_read_lock_bh_held().  Because rcu_dereference_check(p, c)
> resolves to "c || rcu_read_lock_held()", this passes for XDP/NAPI and
> classic RCU readers but fails for sleepable BPF programs, which enter
> via __bpf_prog_enter_sleepable() and hold only rcu_read_lock_trace().
>
> trie_update_elem() and trie_delete_elem() have the same problem in a
> different form: they walk the trie with plain rcu_dereference(), which
> asserts rcu_read_lock_held() unconditionally.  Both are reachable from
> sleepable BPF programs via the bpf_map_update_elem / bpf_map_delete_elem
> helpers, and from the syscall path under classic rcu_read_lock().  In
> the writer paths the trie is actually protected by trie->lock (an
> rqspinlock taken across the walk); we never relied on the RCU read-side
> lock to keep nodes alive there.
>
> A sleepable LSM hook that ends up touching an LPM trie therefore
> triggers lockdep on debug kernels:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>   WARNING: suspicious RCU usage
>   7.1.0-... Tainted: G            E
>   -----------------------------
>   kernel/bpf/lpm_trie.c:249 suspicious rcu_dereference_check() usage!
>   1 lock held by net_tests/540:
>    #0: (rcu_tasks_trace_srcu_struct){....}-{0:0},
>        at: __bpf_prog_enter_sleepable+0x26/0x280
>   Call Trace:
>    dump_stack_lvl
>    lockdep_rcu_suspicious
>    trie_lookup_elem
>    bpf_prog_..._enforce_security_socket_connect
>    bpf_trampoline_...
>    security_socket_connect
>    __sys_connect
>    do_syscall_64
>
> This is lockdep-only -- no UAF, since Tasks Trace RCU does serialize
> against the trie's reclaim path -- but it spams the console once per
> distinct callsite on every debug kernel running a sleepable BPF LSM
> that touches an LPM trie, which is increasingly common.
>
> For the lookup path, switch the rcu_dereference_check() annotation
> from rcu_read_lock_bh_held() to bpf_rcu_lock_held(), which accepts all
> three contexts (classic, BH, Tasks Trace).  Other map types already
> follow this convention.
>
> For trie_update_elem() and trie_delete_elem(), annotate the walks as
> rcu_dereference_protected(*p, 1) -- matching trie_free() in the same
> file -- since trie->lock is held across the walk.  rqspinlock has no
> lockdep_map, so the predicate degenerates to '1' rather than
> lockdep_is_held(&trie->lock); the protection is real but not
> machine-verifiable.  trie_get_next_key() also uses bare
> rcu_dereference() but is reachable only from the BPF syscall, which
> holds classic rcu_read_lock() before dispatching, so it is left
> untouched.
>
> Fixes: 694cea395fde ("bpf: Allow RCU-protected lookups to happen from bh =
context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/lpm_trie.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 0f57608b385d..4d6f25db9ba1 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -246,7 +246,7 @@ static void *trie_lookup_elem(struct bpf_map *map, vo=
id *_key)
> =20
>  	/* Start walking the trie from the root node ... */
> =20
> -	for (node =3D rcu_dereference_check(trie->root, rcu_read_lock_bh_held()=
);
> +	for (node =3D rcu_dereference_check(trie->root, bpf_rcu_lock_held());
>  	     node;) {
>  		unsigned int next_bit;
>  		size_t matchlen;
> @@ -280,7 +280,7 @@ static void *trie_lookup_elem(struct bpf_map *map, vo=
id *_key)
>  		 */
>  		next_bit =3D extract_bit(key->data, node->prefixlen);
>  		node =3D rcu_dereference_check(node->child[next_bit],
> -					     rcu_read_lock_bh_held());
> +					     bpf_rcu_lock_held());
>  	}
> =20
>  	if (!found)
> @@ -359,7 +359,7 @@ static long trie_update_elem(struct bpf_map *map,
>  	 */
>  	slot =3D &trie->root;
> =20
> -	while ((node =3D rcu_dereference(*slot))) {
> +	while ((node =3D rcu_dereference_protected(*slot, 1))) {
>  		matchlen =3D longest_prefix_match(trie, node, key);
> =20
>  		if (node->prefixlen !=3D matchlen ||
> @@ -482,7 +482,7 @@ static long trie_delete_elem(struct bpf_map *map, voi=
d *_key)
>  	trim =3D &trie->root;
>  	trim2 =3D trim;
>  	parent =3D NULL;
> -	while ((node =3D rcu_dereference(*trim))) {
> +	while ((node =3D rcu_dereference_protected(*trim, 1))) {
>  		matchlen =3D longest_prefix_match(trie, node, key);
> =20
>  		if (node->prefixlen !=3D matchlen ||

