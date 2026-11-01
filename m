Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793494990;
	b=1rOXp7u1Epo180HEq+jFhvHyWCedkHu03+ZDnOfNoXKJxTHutX2yv3UpaUK1ly3xmTFn
	 IwcbZHUsbCUH09TK9fd3oXkmq8B5dZnwiilFb7wfwIV1xwZ+MJaZ1FKVvUFqAZc7HgYnN
	 SiTjnIi2qwA1Lmv4xAZNsej1pWTaDtuvAbjBObbPCzCIeMto0dZUs8az11hAYB9JVEBkm
	 Kl9eXDWhjTyvEboJSqT4ae2fwzSmH2L4iTZimrZwo2ZXGjH6kv5GiKozuu93KR56bDBFE
	 VpOiK7XIvp7A95SUvKIpcVxPaXBEq+Cnt61HXn9VZPPeoRk4G4qcVDGQn+ZH3YLLOHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=/U+dm6O7ibLuqp1u5mfZ05KhbMMiFWjnF5fZVcet2uE=;
	b=QXqPqcC56EeHrmAAY1NLNfQtz5WxeTTbMb7zHrhcJwyUFxdaFiAXZr1A+SwoNnBs70Hl
	 uTzveD/OVyKaVSb2rM5JjRcgBWb00hpf+IG3jTaQ+9I7T1viTn03NW2kgVS7Pls0S9Jrj
	 MBNia7K6pdLpUMXsKmOWOeoQtioFjGFEzaEGSFP+e5hmNaITnSc93hFts7zyi6sUlFfKg
	 t84KHyPJI4g7Np1pkuQ8Ju3GaOwT1U2RlI6eKpUOLTCUWH+wCecZ7/8uTzHxdJrag9yHA
	 SUy4nMfKehdXW8gjluIMwTxdCTu6sFTcb+uzXKIyvtHN16xEnnxM/6QXChkaH7rc/bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e80VcSTP;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E0606A31C
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 01:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 186E0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e80VcSTP
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso850715a91.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 18:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793494989; x=1794099789; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/U+dm6O7ibLuqp1u5mfZ05KhbMMiFWjnF5fZVcet2uE=;
        b=e80VcSTPEtt+Rqb+MVQ7zyTHE1DjqfAfg4HaJ1qxZqT47NXqiL0RJkcrMzTz7Jgw2q
         BNgkv1CdagEzyEPK9CqJ3ElM6tP4DsQGcuQN9c5U+5/rElou5PiS0yMPgA+csE0rLTrS
         RRf7Lj6ZW3STr8rwnVdX0snKtXHEC6K260p8EhcOijSK5hOLpVkfSJjm98tpv5UtgdF6
         u7oIy2ErClch2aW+dXVQrAan3ZSNhGsO/4iU9QU944mQr38Kgktm8k/X0n51TyeQXjWN
         iIuJJ2uHNYdOT4SC6ODalg6slpVi5JFxDnEfmx7LtADgEaHhLxR6TWzXfJP4/RPxbg9R
         rkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793494989; x=1794099789;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/U+dm6O7ibLuqp1u5mfZ05KhbMMiFWjnF5fZVcet2uE=;
        b=1aBpMI41Ngc5OOpd8H11lYah4k/u1Ao14zp+/f+LuN/QIezZVteuIulOUl2dgA2ZdX
         8i2BqmOZv/gH4U6OW/rOBUcdcs/UobZ6oOCzrkgU1Fx3OFEw/seldWkhgAJyMNvVG/Zi
         YTAuFEmhdEY/l4mmfn4ijsQSZO8kYu3nBdD4GQHgDR8nuWUuEbqfRJEA5og34kiRD1n0
         iS5ykOK0PMuW0RYFmuKoytZD/jc7YeqpJiLxuL2p9VorEJiQeqt5WBlPrT9xhrJdfgdy
         cym0pYYncR6XsXJDkj2ZFM4YePBHhJbur36F15n98K/RS/vvvA/iCFPuO0SDv1Sy6BZB
         7adA==
X-Forwarded-Encrypted: i=1; AKwUvByAxILxZ7i+bZ0oseIGQKAWB5v3uEG9yzj5OHBt3u1FufNZNWsNYxZy/A7pJLj+0ooJ7mM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mGyCHdXyrPhzA9BCluH7+dq5OvLTXKLbBdWXhy00a1t07q7dZ
	mD/IP5VlsilPhTXCjsv4SA8ebG+HZ1WJjtLmbTwZD0WJRIqt/oJOoS9J
X-Gm-Gg: AYBFou21vh/7G2W5zwN5q5Gr4DFsRrQ0Qqi2T8mVYyCccGseSjL/oJWye6t2oJgZQtO
	Uh7201BbnZ9Z5PghD9GKE6ir5wNhSCnDBqUI/K8cMrHibpOXBEDzN7lsFwwwl2fHV5xBEkJga6M
	K1fP1aEmIvSqYVA5HzoAuaWoqcaczrPE4Ga6pFh9Hq448cCdVS4EDWbZe7Rd+UF13q6Op5gHU6Z
	4+tOCfizLVrJ3p5jFr1B3wXwzXux1GJrmMCT+Hx7Sq+kclZCVi0w0SSORV77fOxBmZKMBc5Fkhb
	T2dEwFI7/Mp7N3MqxIgehhtzq+GL/EuxxtP+dxuFc6FHGhh15CzDbDgfoZzPe/EniSE4o+C/2TF
	XgLrpceFQBXZDCympOxc2DQt8F+CW0AsE/CbXFint0YHKGMQi1dB2UPNZVU0MMRkIVR1sr51swr
	Dy9Vzd4fFVZZnbB3vF1rXBx7feAZ18dnL4UaxNXVjziB1ptRdZZ+byhmmMbg6R6p5l6syZ5Ovrl
	kdEV7iYdot1FTPQJY1du/cQBsPC0Iisr9eZmVsKeHlBWFGmeHuae9sXl/eHKaE/KyYQ60RqRgWT
	44w7+EU03XR+aWQqXRyU3kFFXK4mwhiyZXG88s2xLz92oOVPjNXf/7PgTZFXPW/oKdGwsFZWnR0
	YSweCG/xYEzodYl2TGbmxHI3w4aE61f2sErXcGS6wAEVdEeKaT9y0n4Y=
X-Received: by 2002:a17:90b:17cb:b0:3ac:9ed8:f309 with SMTP id 98e67ed59e1d1-3ae89736030mr5688613a91.29.1793494989295;
        Sat, 31 Oct 2026 18:03:09 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98afe3sm13151497a91.12.2026.10.31.18.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 18:03:08 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 01:03:08 +0000
Message-Id: <DMJGWV96Y5SV.33OTYFHFZQ1WT@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, <david.dai@linux.dev>, "Gavin
 Guo" <gavinguo@igalia.com>, <bpf@vger.kernel.org>,
 <sched-ext@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-dev@igalia.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: libarena: Cache the
 rbtree's leftmost node and count
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Changwoo Min" <changwoo@igalia.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Shuah Khan" <shuah@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
In-Reply-To: <20261028060046.549097-3-changwoo@igalia.com>
References: <20261028060046.549097-1-changwoo@igalia.com> <20261028060046.549097-3-changwoo@igalia.com>
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

On Tue, Oct 27, 2026 at 11:00 PM Changwoo Min <changwoo@igalia.com> wrote:
>  struct rbtree {
> +	/* Writer fields, on a cache line of their own. */
>  	struct rbnode __arena *root;
>  	enum rbtree_alloc alloc;
>  	enum rbtree_insert_mode insert;
> +
> +	/*
> +	 * The leftmost node and the node count on their own cache line.
> +	 * The writer keeps them current, and readers may read them without
> +	 * the writer's lock (see rb_first() and friends).
> +	 */
> +	struct {
> +		struct rbnode __arena *first;
> +		uint64_t nr;
> +	} __attribute__((aligned(RB_CACHELINE_SIZE)));
>  };

That's 16 -> 128 bytes.
Without perf numbers it's a premature optimization.

> +	ret = rbnode_remove(rbtree, node);
> +	if (ret)
> +		return ret;
> +
> +	if (was_first)
> +		rb_set_first(rbtree, next);

In an RB_ALLOC tree rbnode_remove() frees the node and then rebalances
the tree. first points to the freed node all that time:

  CPU 0, holds the lock            CPU 1, no lock
  rb_pop()
    rb_node_remove()
      rbnode_remove()
        rb_node_free(node)
                                   rb_first_key()
                                     first = rbtree->first
                                     first->key    <- use after free
        rebalance
      rb_set_first(next)

buddy_free() poisons the node. A prog built with ASAN gets a report from
rb_first_key().

rb_erase_cached() moves rb_leftmost before rb_erase().
Should it be the same here?
Move rb_next() from patch 3 in front of this patch. Then at the top of
rb_node_remove():

  if (rbtree->first == node)
          rb_set_first(rbtree, rb_next(node));
  WRITE_ONCE(rbtree->nr, rbtree->nr - 1);

and no need for the wrapper, was_first and the rename to rbnode_remove().

Patch 1 looks good.

pw-bot: cr
