Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC650128E
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166808; cv=none; b=ASYZ9bCEa1WjTbW3BJ0elmy6LJNDpB5fNhxSKkiq6OHOdz0Zf7/9VQAzHx/7zqoByFz7lT8vDmYbrsC+W8rxSzlFay67K94VP5L5dR25vbYfmBIR2K2k0hVsQPHhvB0OnttPjYNu/UHE4+6Sk2FAHAJA+l68Hn6worrclomrLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166808; c=relaxed/simple;
	bh=Sp+kvynA1LD3S5bZccoXo6BpOy+Css26i58fO0Uh0kM=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=ioPHGsJ/P8gEX6nzbfD//aPZOhIimfrn//8nrlUAA+TgOIrMCAUX7rlK8+SKNtOzO/xA8dlq0BU74XjQ6kDOZBwQFtzVIxwubq5A7NryGEdGCvgWPEN0plHDoo7DiAEiIix51RTG3tZapNZ65T58UlxBD3vDbN5suOr66M25pq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klkfNhQT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klkfNhQT"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8917c712f32so42676b3a.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166806; x=1792771606; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KOH4IRDD54/m9IGgKIfn5Mrlm3KQxG//txDjDyh2SCE=;
        b=klkfNhQTqY0mre0ukR8CRc024N2sOFMEo4cOFwHVFqa19JoeTpJPnn8d586F6TRk41
         NN6uYKxDJiclpge/NdYHyuyyPGiSO6+yFJ67gjCEZmOHRQyrnZIBd3B2+AXiUYkQYh7E
         d9jVW8EdSszl9M0wlmABK7R8Tr5D3gXxjmzaB5FAi7XMAhyTdmoAGDJEfaWsYEfms7QP
         3TsV/X/fKZL0OoyFGKC3Qg38nbv8Wa1OT/Nd/Ecq0vHcmDpC3nvkqSiDR1KLWL8YzFLa
         K90VVrYYrXorR3P1c0gA8peEgp4gAL/EepgRqdDyb9rON1z/gsdndvl9oUEr8nZjF7Si
         QXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166806; x=1792771606;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KOH4IRDD54/m9IGgKIfn5Mrlm3KQxG//txDjDyh2SCE=;
        b=g7qd6oSGDQmzNCRnWMyzjy7uCBTf2/fpzTbW7ihjE85bzcIGXmSlDSuxvnb7GbVUb5
         /FoA+CCFCJoevA3t+r7KNsXinlsXEb/yp+GRwwbbHwcuCjIf52q64sP4u3pMwsuJqNgN
         A9hpxPHv0bIazPyLcLEivIGwkRVWfO0IvHgG5c/FBOJQRrhCcaGHYGtAImwDiWPj/Pgm
         mI+BMjh4NCgPZUIUKVW/AsnKNSREnG5iDdWa8YNpnODvTpIuF9twdS+OBvMbgL4kCgaP
         k/M9dMa5ALPuhq2hOYRtGYNHoLdhIomYOMQFedo2S6n+R4R6+QqHzPtrQ523YrczskSJ
         ybQg==
X-Gm-Message-State: AFq9FYKAPVNJG+eIjaAGvrHWeuHhhxcVvvZqjy/ZzA2Mp2xCJF9YSPu8
	m+XMESiB2pxKeqLbO3lF7vaIeEXZrpEdwauHhMvavK+3W3VSwJ1uDs7b
X-Gm-Gg: AYBFou3ao+6QdldPgvYd+lBQ1W9EwOJnn/gKYG6SqiBcSU3MAb01w11OgVOlGMLLEHB
	7e6r6xi3gSOIM1uBg7ZdXf76/iwByrL81biUwxvKikaoIFxv4B+8GnTDWlVJYodRHN6c+Pz/PIU
	ePNV0JI0i3HOrIcys+rKhwOSCY5kj43vRUhqgfY4j7nKjMjaLmbn1wokunhSWwYsKxXukUmIphw
	BJ84Zv5XMYAAwLl3npqnpS4LCUoqn8itHOKXNramZ8G5EdbjbEf/elQYL2Uaeq/REFF1JBQbLYX
	kyKG/lvxd8Nad+80PDTG3H6+3DM+BKKp3koBVjW/1bHAT1WrxITM5mACYxc0x8TNbkoqnF49fAl
	XlAEnZ67WRquOWmPgfxVlyfZaOD0BE1d5lD8RUhfYV9tUIG9N7rVTNmUAYN3EYEFHdeTUSfXfW7
	3vbyBAKcstGWRvPLMr10N5tGK5fXnmtXzRihoSgnGS4a6HP3c/NYjrPlqaZWZS2r45gBQXcSQhJ
	X8hgS3SctUfjzWiHmpcwL1Yce51O5RUxiPsf4x+X2o+DSAosffIRhZvdE+CiFGkVBKqQqO2y93T
	/AU=
X-Received: by 2002:a05:6a00:4c12:b0:89f:9fdb:a99c with SMTP id d2e1a72fcca58-8a04cc1ff03mr12344b3a.55.1792166805807;
        Fri, 16 Oct 2026 09:06:45 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89fd010b47fsm950512b3a.31.2026.10.16.09.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 09:06:45 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 16:06:44 +0000
Message-Id: <DM6E405GXJXY.1PEDGW93RMMYO@gmail.com>
To: <nicholasfvelten@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <syzbot+1ea4f564bf6f1f3d1dc4@syzkaller.appspotmail.com>
Subject: Re: [PATCH bpf-next] bpf: Annotate data races on bpf_lru_node type
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261013-fix-lru-node-type-kcsan-v1-1-0b743f5af2f3@gmail.com>
References: <20261013-fix-lru-node-type-kcsan-v1-1-0b743f5af2f3@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Oct 13, 2026 at 11:00 PM Nicholas Velten via B4 Relay <devnull+nicholasfvelten.gmail.com@kernel.org> wrote:
> Both races are benign: the type is a single byte, the sanity check only

[...]

> Fixes: 3a08c2fd7634 ("bpf: LRU List")

It's not a fix. There is nothing to backport. Drop the tag.

> @@ -298,7 +298,7 @@ static void bpf_lru_list_push_free(struct bpf_lru_list *l,
>  {
>  	unsigned long flags;
>
> -	if (WARN_ON_ONCE(IS_LOCAL_LIST_TYPE(node->type)))
> +	if (WARN_ON_ONCE(IS_LOCAL_LIST_TYPE(READ_ONCE(node->type))))
>  		return;

__bpf_lru_node_move() called few lines below does the same
WARN_ON_ONCE(IS_LOCAL_LIST_TYPE(node->type)) under l->lock.
Remove this check instead of annotating it.

> @@ -357,7 +357,7 @@ static void __local_list_add_pending(struct bpf_lru *lru,
>  {
>  	*(u32 *)((void *)node + lru->hash_offset) = hash;
>  	node->cpu = cpu;
> -	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
> +	WRITE_ONCE(node->type, BPF_LRU_LOCAL_LIST_T_PENDING);

The node in push_free is not in the htab anymore, so del_from_htab()
fails and shrink or steal cannot take it.
Only flush and rotate can change its type, which is
__bpf_lru_node_move_in() and __bpf_lru_node_move().
Here and in the other three places the node has one owner and
nobody is reading its type. No need for WRITE_ONCE.

pw-bot: cr
