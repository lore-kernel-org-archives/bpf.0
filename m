Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1353A5443
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082370; cv=none; b=dOmhvjeV73zKBeuaDwf0kz0OvUhJgU+RJ+CJ2R8n+WZsQtd5XgMTFp33pJ1+p4Wl9I5tqNu2yaUU3n7R1zaOCGj4lvtu1qbo1aSxL1ZFfDvoLTk0TzAIs6/CiHBKMwq5jbHuuBlLFba4krUiuRflVT2Vq7GWo0OUsMDzSIpYsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082370; c=relaxed/simple;
	bh=jkWZTD4QRHZiQqpe6ALyI6kMoPn3g9Suq0ijNAkRndY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=HobTXk4IkX3G8QpQJTRldz4ZGF0J0ziyEXDErRe1R21zpLObf3oFw8Mrs3LkYX23BwzqpTilcUMxtC40Lz6gKwxuniRLDYaBno4XJlZ/KxTYpC6wZmKhjbVISxwG9CeAoYqsqjmZh8HrMKoG/t47DZG0r2Pxy+iH0ewhz84MZzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=X4t+REnQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="X4t+REnQ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36931e4f5e8so12980255a91.2
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780082368; x=1780687168; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/gCygVuvCix+pnQ33/MTL/P0DmU8fAWMpRNiF7Wi6A=;
        b=X4t+REnQGDH0cMNf6c4pG9G3Nin9oq66m+t7oExqOmaPUFpBqWIusRD1BUR+I4vjwx
         zd22YtofKieKZ2H5uqFB5hb+2uVVQDP7nc/00FEPr1yOzLsDbqkfNY/Mi4b/jf0CfH3f
         FNSQ/joJed7m0IYYdn+9wz1ZQj6ldx30+c5RKztQnu52gbByqiTLUTjfdseWwcJf15PY
         t3KH83PcDb6xbt9Do1ZG6yBW8cdaYb49amdAaTsHogZ2ceg5uV8sdoB7hDfDA1U3sZ4c
         cNCSSitU4TEozLsQH2qCPAk3uyvdc43nIR4apmnLENcnmr6NDAShRKcOoW0RG2CcMD4Y
         JAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780082368; x=1780687168;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/gCygVuvCix+pnQ33/MTL/P0DmU8fAWMpRNiF7Wi6A=;
        b=GTRGtpLM0vW6mSPYGe2776VWTbwD6M70/mLUhzDyUgAZasGisqtu/l55LpCblqA4D4
         XCVN6ND1jpOakqY+dzCkG27sTOSxW4qUI4ScCLtpswInkya3JnNtIv2x0ZIbAVa6PlOQ
         89BYvGc27eg5kdc1zSgmrwbVrVMIG63piPZIIzZtxYsRk6FKuObORE1LsVX1RIwCHtWa
         EM5LvmkQrYcVcAfIuiJJlpNZiAYiB2HZPS1NhTetL67hqfU8Pi+7oqIsTjaUXMm5IOlI
         dU2HFxuqfQBWME7tN1WYjF5nrEyJN2cD3OPTG6N2pGmrKhFn34guxBUJAOKBknROJtZ4
         5/7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8jWnCbOoeo/FGEv2YmdR1C0D6OK2c1jRtGN47W/zytsC0ULUYRuFUQI4E9C2QhT3BLgIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2UBs3XKMVWPasfA8/3oEuqUdsWsAVdm5jn1nc+CrqIxkr1zR
	lu2rSwFZQciv75Ax1pCtBMrkYES6pTNrI+ZOgGfuUWVLlyolCiCJSKTBYliCobjZIBE=
X-Gm-Gg: Acq92OH2GgRNKTZPgVLFr6CvhcuVcJmg6cDI/0Y0sXxdPZZbC7B9GonY27kfr3Q2jdv
	aLBuEQ3P8enavFYDJFNbukn0+RKiYbJCFrsh62qe1wcYTvtP1NVkn+HpnOiGYzh+PK7lDHSpT5M
	58EmDYMZ16IhFRD9fb6dLnby3ok3KtxrwpRitsnLegOa4TDPsIdWUQkYfr901Po2VgvriIQSqNx
	TlJRmyMbIc7GPiU27GMUr2ONXs5IkiO5OAIDxx4Bt/nOeRM1uCNNB2pYF3vQvhF9uKELiRDWLje
	q3/P4gc1S+qu+Xg2ZFrTW9W/+NsLUjBJ2vsGOFdW+u2by7J4/HaZpzAyhLmTLbRWo1rpeU/DYap
	d07AOAF6W9qxV34FPq1hO801pLBpzwp0KlHGA6zD7Bw9HVLDYDw9DVbbbIvmvp/94p8CLxU+8iA
	GyB0dcuMeu8p6vWNQxE8NHK4LR0QCDaYb9p1g=
X-Received: by 2002:a17:90b:278f:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-36c4ff364dbmr495717a91.10.1780082367780;
        Fri, 29 May 2026 12:19:27 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc6a34dabsm2787591a91.12.2026.05.29.12.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 12:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 15:19:26 -0400
Message-Id: <DIVEJ9TWTA69.N0GC1B4XBPTZ@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vlad Poenaru" <vlad.wing@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, <bpf@vger.kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, lpm_trie: Allow lookups from sleepable BPF
 programs
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260529174233.2954240-1-vlad.wing@gmail.com>
In-Reply-To: <20260529174233.2954240-1-vlad.wing@gmail.com>

On Fri May 29, 2026 at 1:42 PM EDT, Vlad Poenaru wrote:
> trie_lookup_elem() annotates its rcu_dereference_check() walks with
> only rcu_read_lock_bh_held(). Because rcu_dereference_check(p, c)
> resolves to "c || rcu_read_lock_held()", this passes for XDP/NAPI and
> classic RCU readers but fails for sleepable BPF programs, which enter
> via __bpf_prog_enter_sleepable() and hold only rcu_read_lock_trace().
>
> A sleepable LSM hook that ends up doing bpf_map_lookup_elem() on an LPM
> trie therefore triggers lockdep on debug kernels:
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
> that does map lookups on an LPM trie, which is increasingly common.
>
> Other map types already use the bpf_rcu_lock_held() helper, which
> accepts all three contexts (classic, BH, Tasks Trace). Use it here as
> well, matching the established convention.
>
> Fixes: 694cea395fde ("bpf: Allow RCU-protected lookups to happen from bh =
context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/lpm_trie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 0f57608b385d..ac36063cb7e6 100644
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

