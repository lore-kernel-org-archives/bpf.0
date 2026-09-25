Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E032D8385
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 01:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790300512; cv=none; b=FQneCL13kdey5/fV3YdAqsFXc3O3hC17werZRANcE0o/Eg4/XKnWvxsiMokgsUNz1WdfTEgnkSNQgDT+Wd1SI9DiWtYJFgAJbMdVm9V1SFJK411UKEaSAAXoadiCvrrVwHdjivz33ZVgJF8eykH2Yw1D4WPby3yppKSaJIjPoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790300512; c=relaxed/simple;
	bh=HthLM1PNuMxWBTXS0+87vYoHdZV1BdbX8Mxz0swEQZM=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=faDiqwvsA9oAZn6lA8Zc2kdHoBkc+blpOGazmEvoKQCkzbvS+tDArh0d7tAEEWlVtVJkjtTprvDHOMB+x/dTMHK9kA9GWLKNCAK7e1oXfSkt/+KGMQIsZY/p3Yj/kdRhUvTd58J5QihizNztrWkWqxjMurPTG/9/8Ns/PlNjYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi5uHPAP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi5uHPAP"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2dd68a16955so10234995ad.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790300510; x=1790905310; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Puu4CDfvezT3ht6t8GsmQo1t/a87HCIDmLSfwmKbMYM=;
        b=Xi5uHPAP+nnuCFNFZsW870C369kbysRQcixIRh1hW4RsNqpF6chI/hJM7uSBfmYo/x
         bK9S+uB4JRnXgrNy3D6Wk2gfh2nv4vnq3mQSrdL4YNkIxXdjn8HySX/tt3IbyoWtxuRI
         bswVkFCXkcIqbnCqTGNd+WgvbxV0r6kX+IpHbAV2m/Vw1aH+5v6vxZMx3V9fMGZWLx6j
         oPE00kYJCtvEQgbbG5Yz3OXsMmaCFJA1OHrjk2JgNO8i6xMJOVEzTzgJxvmLutmgiFJS
         YTIWzwihROFf211McJ5dtO/yHBp+8W/i79kS2+CgtItOxztxPJpqBO6S66XBW1QKxLrX
         6H2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790300510; x=1790905310;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Puu4CDfvezT3ht6t8GsmQo1t/a87HCIDmLSfwmKbMYM=;
        b=Fxe2zeGqi/cP9bS/CSdLlyB6U0fYRqqh4b0vZmSS2mXavp7a1641QktSUvv+7E9bJj
         9C37Mp4z2Y57te1WY4rWKj7YxLZ7+G+WE5dRPQftLzlclLV6bLlX6IoNztVrI2vuooht
         dMGtmo2IhBjnjumvYVwShnKRlpKWGFIpi5+kCR7RV/b60hdiIy9tIB8m/O+5fKCQyI8o
         GPuY/lGlduvPjQEA7ne6dtMd8Sikn0U/8VgN4E56n2hKcw12lyTb8w1SVjpMnQWzK4Ba
         qNdI2QkRlR6D2sQ8+BUzJ1ohtewpAv4Kw+S3aftTHAFbJK0/MBe6wkeg1HoN1A5CiuWh
         TUmA==
X-Forwarded-Encrypted: i=1; AKwUvBx/JjVm8etB/IwwASWxNo0Tncq/6+DZZweyhlUJyjco6DvgkzC9xxB6XROJelS5QyR2MWc=@vger.kernel.org
X-Gm-Message-State: AFuF++nJrZdnT4mYaSi4yq+B/FlHO0vEV21OKzKwELjhulCiuGwAs+al
	Az6M+l394l1jBCaJmrM/nTNDyjyheqDsK//OC1+VGcySzvPRDPZR4Bo6
X-Gm-Gg: AYBFou3XOkX3y7nQfjSIMGYF9wRY5gUltch6NWjwCNF9k7Q7aGPgQ7ZJQ5CHkLqoeHK
	9tNkC/Q+UHvuLQRiO34VxBoOPxm0GW1yiWDaDUOfHciNVTcT7Dk+dMlB28QyBbKzL5yqpwOFnNn
	hnGkXyn9kb7HOXisGRjJXsjyfX7D/5CEDowJWg1F0wAh9HfUxMSQ0nHOMpk8cTBKG8AbYyDgE0a
	8xyjk6Isx9PtMr7cPal+/vFCNl0EOXy+N6JgWvJqJ7R/Id7cVhNz6l91/gzJbi3usV3Yq/AetcQ
	kkAk2Y8rcLMqT03A93AD9c9+ZhBn9s0ag7FvNfXMkckGoBMfBfkli2ns39HTOnVOsdt6aLM6Djf
	e4pzG408tLfPqMcEh1PjcvImfMsrTLSk+TEZUiS+HHIZVC6DyMPxh8O7+H+wHac5DXSr1dW8xf1
	8CG87dbUnOh36PT8ADx9jUMmLlUl58HxHgpEMK/yvD4M21ByrRO6fEXLZgVQgzThD3H662Bh+dg
	3v49euvZZ8+dy5hJn6GoQu5KTVPC8QAvdcXoKvai301WyTp2WRUqhp4M6PIY5LQN+Pvfb5TOaF5
	ofQ=
X-Received: by 2002:a17:903:19cd:b0:2d7:5da6:2af4 with SMTP id d9443c01a7336-2df7dea6233mr27180655ad.4.1790300509668;
        Thu, 24 Sep 2026 18:41:49 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913ff226sm2784535ad.34.2026.09.24.18.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 18:41:49 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 01:41:48 +0000
Message-Id: <DLO0KBIOE5JY.3DY4JTZOWT5IU@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Yonghong Song" <yonghong.song@linux.dev>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Eric Dumazet" <edumazet@google.com>, "Neal Cardwell"
 <ncardwell@google.com>, "Willem de Bruijn" <willemb@google.com>, "Tenzin
 Ukyab" <ukyab@berkeley.edu>, =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@meta.com>, "Kuniyuki Iwashima" <kuni1840@gmail.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ameryhung@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce
 bpf_tcp_ops.{enqueue,dequeue}_rcvq().
In-Reply-To: <CAAVpQUBGSahLGEqGQCD2_0Ro2e-=59W7mhVyxOnoFU==LAK9tw@mail.gmail.com>
References: <20260923213719.224838-1-kuniyu@google.com> <20260923213719.224838-4-kuniyu@google.com> <DLNYI40PF2Q3.1KYC8MHZU2VJ@gmail.com> <CAAVpQUBGSahLGEqGQCD2_0Ro2e-=59W7mhVyxOnoFU==LAK9tw@mail.gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 05:39 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>> can we drop the flag ?
>> hdr_opt_len() is called for every tx skb without per-socket opt-in.
>
> Oh, I assumed bpf_tcp_ops keeps the same behaviour.

bpf_tcp_ops were moved out of BPF_SOCK_OPS_TEST_FLAG() guards on
purpose. None of the existing members has per-socket opt-in.
hdr_opt_len() runs for every tx skb, rtt() for every rtt sample.
See the log of commit 3bb54768fe3e
("bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops"):
"A per-member/per-cgroup gate could be added later if the extra
fast-path work proves measurable."

> We have a bpf prog to turn the hook on (from cgroup_skb/ingress),
> only when ingress rate exceeds the allocated capacity, to signal that
> via a custom TCP option and turn the hook off from the hook itself.
> (and I planned to post another patch for that)

That should work today without another patch and without the flag.
cgroup_skb/ingress prog does
  bpf_sk_storage_get(&map, sk, 0, BPF_SK_STORAGE_GET_F_CREATE);
when the rate is exceeded. hdr_opt_len() and write_hdr_opt() do
  bpf_sk_storage_get(&map, sk, 0, 0);
and return when it's NULL. write_hdr_opt() calls
bpf_sk_storage_delete() after the option went out.
cg_skb_func_proto() has both helpers and get_func_proto() in
bpf_tcp_ops.c allows them in every member.
egress_read_sock_fields() in test_sock_fields.c does the cgroup_skb
part.

> Anyway, is it because calling bpf prog is not very expensive
> or per-prog switch is preferable to per-socket flag ?

The switch is still per socket. It's sk_storage instead of a bit in
tcp_sock, so every prog has its own.

While such new flag is per socket, but it's one for all progs.

And you want to take the last bit of u8 bpf_sock_ops_cb_flags...

As far as the cost. A socket that didn't opt in pays for an indirect
call into the prog and for bpf_sk_storage_get() that finds nothing,
but only in cgroups where bpf_tcp_ops with enqueue_rcvq is attached.
The members that are not set are NULL and bpf_tcp_ops_call() skips
them. That's what hdr_opt_len() costs on tx.

I don't remember what Amery measured, but worth benchmarking
for your case.

>> The prog in patch 8 already returns when the socket has no
>> sk_storage.
>
> Yes, but this is only for bpf verifier.

tcp_init_autolowat_cb() can be the only place that passes
BPF_SK_STORAGE_GET_F_CREATE.
So for a socket that didn't do setsockopt(BPF_TCP_AUTOLOWAT)
other cbs will return NULL on lookup.

tcp_disable_autolowat() will do:
  bpf_sk_storage_delete(&tcp_autolowat_map, sk);
  bpf_tcp_ops_set_rcvlowat(sk, 1);

> Just an idea, would it make sense to add a kfunc to move bpf_tcp_ops
> callback to a shadow pointer by allocating sizeof(bpf_tcp_ops) * 2 ?

Doesn't look right to me.

Amery,
please share your thoughts here.

