Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793235449;
	b=edyzBDdBjTsdXdOhXBMwkEq4O74Ub0D43DpnwCcrGzJa2LLINWrtkt01jBW3y97HNqe0
	 wQgHKvonltSbL8s8aiMmWREyPAer/BOIzXUbcKZaRpHymAtMVczCsr2MbpHAVwU3i0p0F
	 z3870YFEnAK3WP2oRM68H1d5mxqq909dathjQ9iYQPs9e7ceqEmIwGTMFemev4sVTvwdA
	 6mtys8D9+ooeSoY6rbPidZZ+SstoiXgmoFGKHKUGh0cntBvkLfH5kttTcvbYvoz50Db+q
	 /Skz3qVWlxcdCV4tBbhwrRlQYp78ssjSI/0DHmfiXhZsayHXLa0qXdNtUk0x78l4VZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7J+7+g+5VWEDw2Zd4xGN6XnKVHp00xXiXlbf36J0yUo=;
	b=WC8XW0bk2Lm+sZ7wna0Rfsc/CeXvn3/fyYFUCwRqAjsxRMsyl5/YcEYe8aMs9BrDShFp
	 1goyxXRKLLZKO7i0WiVkE/lzI5Wr3ExMEIpZr0qAxmPIKmTV0RVWDbGMKyiof3xJWkgpj
	 MIWIsW6P1oFkpLQsIh9YqGkIDCeqpCpA7GeM9ovxaWnVdFul1woX2EcjyngbdYd6YjXOY
	 575THyk++AZnP3hlbrCXHzB+7DKtmPatoHXoL73N6yPAFAE/x8cfDFYPTIwY5KV2UimWc
	 fXrq3dRzmcvgyG1N3WRgIOjn6asWn2TzjOEqXxILVaXCATb0TdY/gsSwe/csiUaUwdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d3UCSt2j;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F59606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 00:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F59606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d3UCSt2j
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so112947a91.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 17:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793235448; x=1793840248; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7J+7+g+5VWEDw2Zd4xGN6XnKVHp00xXiXlbf36J0yUo=;
        b=d3UCSt2jBrT7hLjDHuBVsCII4wqn6rz3b6O3kWrP3ZgMrxHMUkBd0EgHmeY+ck/Jaw
         cRmsv15aJA9rehCjcNv9XS1pUQusex53iFfmIXJoFG1nku8AOSPwXYZQg6iexFNQgypa
         dPsSknHK8rcPX8BKzcuc7ke4dS9PgIjn7x9fMZT7Ifra8mkovaXkC7+O8fwh8sEtSLCG
         MztpBPoKaK9g37HZZo6HgU3B5f3titVI+PLbbboe29zyZ/wgPXzQKkspyxICae+B4Y2X
         d8PkgfH3ZSCLDGOzdy6CDL6/YIzpHCvP0t0hNYQzwIhGRX+a5yJnTPhVQpB7tHZgKQbI
         zyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793235448; x=1793840248;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7J+7+g+5VWEDw2Zd4xGN6XnKVHp00xXiXlbf36J0yUo=;
        b=hRFXWr+NQLsD3quiai9egoFPbmnTAv6YOuRUGDMdVBz+qbEDPfdsZqxVVVz9Y/IxkT
         IMYdbQp12CpL18dnRKdsq4/fOxhMhyV9IpANvb2OwFgJYe3mn8WfBzbOlbfBvFuIgpn0
         Jnp+p0YWS6T6131ZaP/6BNIaPy4Ye6UvNA7NToCY7typ4RYT7iaG5fRJMxUp29d1ZcRY
         HTdwA+yhXxonmVx+q9hA/4BIz8sTXWhzdl7Zz2wVdbhPfIVs2av6PoOM8aNFu8ANiUbF
         anUyq77mR+IpbEx5yOmofUcLo7OkMkPdBZIV6YWuo+JT6odnWvP4absIOpf1JTNZI4RJ
         cs0g==
X-Gm-Message-State: AFq9FYJvYbRIt/ELrVSLz7NpWIpfw0kTb7aKBxMGjwz5Jl0ckfQKy4lB
	wtcmyAzCUZ9SnFyGEB+PHkjrWPcL63N8+7s3H2R5IIIAWNhLkboWESKt
X-Gm-Gg: AYBFou1xGJcCA4xbd0gzBx+6aAY9sgkFCUZh5boknEiRnP0U2SEja0LQg7ht+Dx7mKg
	NtQrPhsPbc+Wex+1kcmgHxi74Ts/UkIbM7E8TEX1Mg+Z4bd6hj6aFiIMyn4a7zRqWGf/fzlhWYp
	JQ/TxGwi7grglsn7c8rfK1V6sNpPUfgAfVDw/uvS4Jc5Hxq+pNVp3LgJBH3YPCiqOrt5Ll34OaY
	jEToeMHh37vcgKNCU7TgTWhIFeSXcGsetw0Uo9ryrw6T5OXWtw5jMp/++b4ROz8kmzebA3lqGg+
	RRu99tUCBMj8qj5UpzpRqEB5aFzZ9X5d8iHtXe2zHM0VgJClUCheyGx1rzJbgnGEN3xas3mWiEw
	gUJ0+XRgY+xWGhkz0nW+CZxIYD/b+438qPUbxkFZxixuWsH/aAf2UIahEOUWEHb//XRD5EcH0xY
	pUXeKGqoT8c3OmfVSdROiqbo0si+iYhNJXonu1TrOWPo0jFSYb8A8bSgBmhbMw7lKNj5NmaJAy2
	06fpRhBB0kOGImJvHchb/LrIfKcEUHqEvRPu23mYIKYx+lRQUWTG8zRKZsbFHwKG78TybDYUvwU
	OiXo4mOzy5paFvwoaCe7pNuyzY7TfRFjF6vovK6odXT1alHKQiWPAIglrDuoeipdZZNGi8zcepR
	1GXkOc16ikO5FIgWdHxwXIEkfq57zdnxAqQ==
X-Received: by 2002:a17:90b:3a4e:b0:3a7:cffb:8b8c with SMTP id 98e67ed59e1d1-3ae6ed98243mr671386a91.43.1793235448281;
        Wed, 28 Oct 2026 17:57:28 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7fe923sm1576388a91.8.2026.10.28.17.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 17:57:27 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 00:57:27 +0000
Message-Id: <DMGWWVV2IBAQ.3QRLUR9VWT508@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>
Subject: Re: [PATCH bpf 26/81] bpf: Support BPF_REG_ARENA_SP in the verifier
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <CAP01T75Edpdne_VV_0XAKEw-ijCh5ShXJQq1MQKpKVf9fRQzUg@mail.gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com> <20261026025943.404450-27-alexei.starovoitov@gmail.com> <CAP01T76dRouzrPOZS8AQ4TMnJ0GzyRm8cPJ8RYUTu01bQgf2Xw@mail.gmail.com> <DMF694XH2TJO.P59A31VE6GWP@gmail.com> <CAP01T75HAHkP4bzdGzeazN4n_FNd5w1Pckd3GBN68V0n1PNe_w@mail.gmail.com> <DMFUDQAC6N4S.1CNBGYKG58DMR@gmail.com> <CAP01T74C4bBZntDNLrCxe02prWiF3pnUfYMFTUU6-44O0zbnPA@mail.gmail.com> <DMG76G7GIPN7.HQJKZIE5J8R6@gmail.com> <CAP01T75pOz8Nj_YG13quoVeniq6908sY5og4RadfM9-tz5j7PQ@mail.gmail.com> <DMGPC9G5ZT9O.2NN1B6B3K7STH@gmail.com> <CAP01T75Edpdne_VV_0XAKEw-ijCh5ShXJQq1MQKpKVf9fRQzUg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 28, 2026 at 05:07 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> I was not making a proposal. I don't even understand half the changes
> yet, 

let me try to explain stack-in-arena motivation.
Consider this code:

  struct Node<'a> { val: u32, next: Option<&'a Node<'a>> }

  static IN_RODATA: Node = Node { val: 3, next: None };

  fn sum(mut node: Option<&Node>) -> u32 {
      let mut sum = 0;
      while let Some(n) = node { sum += n.val; node = n.next; }
      sum
  }

  let heap = Box::new(Node { val: 20, next: Some(&IN_RODATA) });
  let local = Node { val: 100, next: Some(&*heap) };
  sum(Some(&local));

sum() reads the three nodes with the same two insns:

     local            heap          IN_RODATA
  +---------+      +---------+      +---------+
  | next  --+----->| next  --+----->| None    |
  | 100     |      | 20      |      | 3       |
  +---------+      +---------+      +---------+
       ^                ^                ^
       +----------------+----------------+
                        |
          w0 = *(u32 *)(r1 + 8)      n.val
          r1 = *(u64 *)(r1 + 0)      n.next

A rust reference doesn't say where the Node is.
It can be on stack, in heap, in rodata.
These two insns have to work for three different areas.

Hence the decision:

  step  memory               where  why
  ----  -------------------  -----  ---------------------------------------
  1     heap                 arena  The prog allocates it and links it with
                                    plain pointers.
  2     .data .bss .rodata   arena  heap.next is a load from arena, so it's
                                    a number. A number can be an address in
                                    arena and nothing else.
  3     address-taken local  arena  r1 is &local, then heap.next. One insn
                                    has one form in JIT.
  4     the rest of the      r10    The verifier doesn't track arena, and
        stack                       user space writes to it.


Decisions for .rodata:

  data                      where         
  ------------------------  ------------- 
  statics of Rust           arena         
                                          
  tables of functions       read-only map 
                                          
  strings for helpers and   read-only map 
  kfuncs                                  

The price: .rodata in arena is writable, and its values are not
constants for the verifier.

If .rodata stay as bpf array then above 2 insns won't work.

LLVM tldr:

  what      clang for C today     with the flag, for Rust
  --------  --------------------  -----------------------------------------
  statics   __arena variables:    statics: .addr_space.1 and
            .addr_space.1         .bss.addr_space.1
  locals    r10                   r10 or r12
  casts     by type: __arena      by origin: one cast for each pointer that
            pointers              doesn't come from the kernel

I hope it helps.
