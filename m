Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61832EE5FD
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770678049; cv=pass; b=ATJVNyhfR2Aq24JJyGLU+SPxOeIWT8W6oPazV2GUN09JTVPezo3jhRzhdaGpmlw2HAyA7U2AOcS52+Wbxn9KbEEssgHz3V5V9z6qlwbuOy7h+ePE9nFYynIptc11kpPtQaUhf/6huxaFmAETJ8ANAnouM4ntm1MFVQSe5rOpaU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770678049; c=relaxed/simple;
	bh=9lWPPpht6PEPxvl7XktSgKubPJ14O2RmyK4nhm8y/Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBL2xN0rj7A7hawAuISx34+qlxQnrhSixIXSkSuO5KnJwGtUvMkWDhmq59J0ln6FzwYOprRQHG1sT1J+WfHNq5RUR08oo8hKGSPB16s0z+IC9frRMCNlJWjrCEt0T7dzbNHjAHtq44sBcKIaHnA9RIlMtxHCYB9tH8wLsnxxny0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbcYBDp5; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbcYBDp5"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43621bf67ceso2115253f8f.2
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 15:00:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770678045; cv=none;
        d=google.com; s=arc-20240605;
        b=OaU5FYGT6oRb5i72i1kliyPO/Xy6n/WYfXovQsSCpklqWhcbR5J/t3H6DATu0MGy3t
         tpn5klbe/6oPNQUp98IWzjkb9gjzUXlQQrZ+2va/Q8ENp4NUpvgozub/+YExK0rRBsVS
         iy+7dBd+A1qUWmGiGH5iHJjJmX1mZQlT5PziEQ+O1CkgwHKcNbhNCVxl98JWC00bOOGJ
         FADIXbMCSKH9tvX3PaZYimuSU9krcMYB8GSDisG2X33zhlY1P9Lwk1yh9JLFItLic0Pg
         lXLRQPpGYMmIV/MzV6rgqrRFxTjLeia5KCcWSyiHc2VtzJuJ7oaHMcKxMrRhyh+HYOZb
         3b7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eUKh+ktP4D5UjlpU51UCVp2mx5vtmlgwv81LOUnstJs=;
        fh=Gl4OEug/7f9/b+PZKQU64x1GaORhMFYDgH+FcgaGXNQ=;
        b=K7KhpXyt5G6gxsVbt8RZagZTr29T3G/mg2qPL3KTZNSp1m94acuDcEBP4QX0t0O9Vh
         fY/2d/jOOAviiTEO9/Fm883qXzpdiiBuK2OMQhmNb2ZM1RPeCpbRunUwSMZFqH/DVqpl
         4fUjVlAwKnvUW/tp0v8OxTV4spXXEHxbENp0XdH4/HD6teoLql0QO8bxXdvjSrEbYlU7
         o+pfHaPuoOuW9x0f51RC5le/RLcPQDKUTcSruDbRnhkgl1ATomjReTdPDEffQzMKyfBM
         q/RVFnLN3wyQVTap2a6jqHb6hCUoq5C/Ut1NgZF1rzNYNW5WzSfW/xXawSAjtbfN6fbb
         qO1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770678045; x=1771282845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUKh+ktP4D5UjlpU51UCVp2mx5vtmlgwv81LOUnstJs=;
        b=UbcYBDp5Y6WV096x6YuhzuXZB+rRFAhRDDTHiP3jxwZZ4lyrx4c6ODsEeZQQrxa6hE
         hojlASsqpYS1ENeWxG1id+4HwOlAyhDoAoS9XxXoC5NeJexd8021/UZU6vLTlSqtsxNY
         ROBXuEEPTNbPPLhX/6FBqFL6XzBpt6VGTGwKLtoGQD5dfqpwfLyIA/g4JG4US46dAf65
         xWfIlC2N0Bjv7KqPiXpEe7LhNrPgVOv1jA0YeT6Obm/iVyTh4KpC/ogiFGxYKTNU36Tn
         urPLHIWXE3K8f+T4yVGD4kF+qRCuMlpv+FxClA2PutZ2bJUROoJUWCrhMT/WVz6Q3G2u
         uTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770678045; x=1771282845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eUKh+ktP4D5UjlpU51UCVp2mx5vtmlgwv81LOUnstJs=;
        b=OAIqYvdz2CwNfHYridU6S6H+cga0PrG4rnbuHtxv1JDpJ4LxGnAIng+482Afzig8Cu
         0NebJ1h/Hg95rT0MXbNH/c90wFGF0yWHBRDhNEfXZLg3ASdlpxN9v5RK3PkFuWI3BJ6e
         4aoU05FI0KZymyO3uJoUaVdQ1LDQOediYYmFpMiQG5+g1AMENZL4GyL4nDk6Bx0NudER
         KvgjSy0YYsIDR4+JMYpMMAOUuFQxDCJg7YoyKde9EE2SYhM9BmoEOO2AniR1FiM5iu5K
         j1Q+uVrSbtA5enC/0Qc7j04RNumQ8k3Kp4+TrCSfdQR6WVKkg/zs6/Lkl7Z0MH940GkP
         k+8w==
X-Forwarded-Encrypted: i=1; AJvYcCVykGxsEt0VTzVvmnFusqz8RJlzhspN8V5mYjZ4FGPsBrX/0BgSe1Gan84vxgc1RzAU1P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKCYY0YSz8vQs7FMwUm9zahB5ViBnV+qf81fXsYXzBJqbtpYv
	p0/hd6PFRvhLGwDyB6StosWaKGFnwoYZcigA7gd4b5nputqrBy/lPsr13NOK+MnWQMBQoszyAQo
	FzzXCnKygAnElDTrfUX1A7zMAmZSfIsU=
X-Gm-Gg: AZuq6aIsPlV23OUywJmD69UJ8TzeT+BPzviHB40rnoJRZOssBIQy4/13aemhSczMagV
	eFSoJXkXZreQNjBVP44DmqloRirXZKe3Jy5JyBt3HCuEgJqlf1wbz6xD/PL7+n68evjYRNgMCEU
	XZDKwcqggnQ8EtQhxUcajIPlhZPq1173UcO+StM4Tu/6Q6w/RuAxOceDQd+obxdmvAx06s4g0CK
	76OoObnnmUuUMM98gR+x3YkTnUzXDMvyNn1XEBcUxFv4PgCXmMPcefzshb8LIFZwC6Vck2TpvGd
	xrxqPh4yRHj0Co0N/LLoohF1kM75yoDqSUqHa8xIEDzmB/Y6JvpLFylDBHYReV9QoNrvSBgW1Gy
	FPcjVtjehAjzYIQ==
X-Received: by 2002:a05:6000:2585:b0:436:1a2e:9f1c with SMTP id
 ffacd0b85a97d-4362937847emr19414201f8f.19.1770678045015; Mon, 09 Feb 2026
 15:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com> <20260207230720.2542943-2-kuniyu@google.com>
In-Reply-To: <20260207230720.2542943-2-kuniyu@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Feb 2026 15:00:33 -0800
X-Gm-Features: AZwV_Qg5AU1ZTDTiqn3vH5Veon_e04vfTf3pMmck8qqfJ6fs_hJwxlUAdfcazLU
Message-ID: <CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 1/2] bpf: Reject access to unix_sk(sk)->peer.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
> bpf_skc_to_unix_sock(). [0]
>
> Accessing unix_sk(sk)->peer is safe only under unix_state_lock(),
> but there are many functions where bpf prog can access the field
> locklessly via fentry/fexit.
>
> unix_dgram_connect() could clear unix_sk(sk)->peer and release
> the last refcnt of the peer sk while a bpf prog is accessing it,
> resulting in use-after-free.
>
> Another problematic scenario is that unix_sk(sk)->peer could
> go away while being passed to bpf_setsockopt() in bpf iter.
>
> To avoid such issues, let's reject access to unix_sk(sk)->peer
> by marking the pointer with PTR_UNTRUSTED.
>
> If needed, we could add a new helper later that uses unix_peer_get()
> and requires bpf_sk_release().
>
> [0]:
> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> Call Trace:
>  dump_stack_lvl+0x5d/0x80
>  print_report+0x170/0x4f3
>  kasan_report+0xe1/0x180
>  bpf_skc_to_unix_sock+0xa4/0xb0
>  bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
>  bpf_trampoline_6442564662+0x47/0xab
>  unix_shutdown+0x9/0x880
>  __sys_shutdown+0xe1/0x160
>  __x64_sys_shutdown+0x52/0x90
>  do_syscall_64+0x6b/0x3a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
> Reported-by: Michal Luczaj <mhal@rbox.co>
> Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79ce6ef6cae0@=
rbox.co/
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  kernel/bpf/verifier.c                         | 18 +++++++++++++
>  .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++++++++++
>  2 files changed, 43 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3135643d5695..b328a1640c82 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf_map *map,=
 int off, int size, u64 *val,
>  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_or=
_null)
>  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
>  #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, __safe_tr=
usted_or_null)
> +#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __safe_untruste=
d)
>
>  /*
>   * Allow list few fields as RCU trusted or full trusted.
> @@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struc=
t) {
>         struct file *vm_file;
>  };
>
> +BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
> +       struct sock *peer;
> +};
> +

That's just one out of many. It's not really a fix,
but a bandaid for one case.
We discussed it in the past and the only way forward is to make
helpers only accept trusted args.
Recently we made KF_TRUSTED_ARGS a default for all kfuncs.
We should do the same for helpers.

pw-bot: cr
