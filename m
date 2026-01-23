Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0EA3EBF28
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192151; cv=pass; b=CC7mNWkfQx5xDi7s/2tj9MBDGjCBaJm/XDUjKE5uwVpaTOSwrgB8LZsuA7r/Ar7p6VoqEhlC6hCDPy+b/r/RSF44ACIN16TBkTqXyr9M/KffFwhbvo5MhbBqJf16hh/i+0IeIQLz5gtFsyVsafMn77J2gFLvAwlQo+k4x5sunvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192151; c=relaxed/simple;
	bh=ZpWPNz6SSZ5jF0yhZnfYrdJzJ0WwZC45hMJEFSLxLkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fi+7tdg1tKVidaAyWnp1HRyUkf0BIubUjPtYnMnX55IwVsT5vZAxWYA+GWIfH2Bs3Oq8v2N8vPkFTZZXquNEBlwed9oREvibUxOlCX582+zbLemRv7jzKUZ7twB8nbCtSyMFq3b2lC/8kcJcohhUtM4ifpJLkMePojYVDxy7rXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIGyef0Z; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIGyef0Z"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc305882so1534773f8f.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 10:15:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769192148; cv=none;
        d=google.com; s=arc-20240605;
        b=be/cW3g5Bph+CIOtA2ntQOXIGRJ9bIIO9NvHOzZuDYvJPr2K0Ibb5RaFLGeuwav/jL
         p0L8rLxJEjN3V1Hax9X2RqUAiruN0rrC3UxjTgfc4FebT3BCr0Cl+D9Bh57OSYf6kXMZ
         r0b0Mp3zWP7w2ZEtMxOiTqVLmSssGrX2XYkmIce8BmqmaPrOf6XVlWlwW/OIUsNQbZ9u
         zFLjSw8kpwGYpqjnm3qC8L3vFG46vWktM5n5edEaasGQ+ET/2FS5cQ96IJ5goTNpB7It
         kM1mULwgHsjXcOpER0+MQp/Ulk/x3xxzL9KIA5GalQFapNU01L+MhGq27UPaTomT+xvb
         CBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2nG00qw2ruBawht6GJzw6X6qOS/2LLsPM2l8lgx1yM=;
        fh=JQ9vne1S/7FqsgQkyLw/R+uzYwfwkQ4yzv3tvsxBNjs=;
        b=H3BCKUJGqF0wNgk0lH81x1MnkhRykWJQRaMaOMUhW5JvgOQQSTqp12Jvzm//SK9i5N
         B9k56l85OCp5BOggUm2VeXtro7Dy7oG7HO3aRhRu4GHMoqveEZx6bklQFORBDbVTMU7P
         ehRVKbM8hCB6C3C6aUOwM0Gdg0spK2s41nq7niq+1FjSywVcG+KCqZpLWi7X/ycOp0/4
         PM10fjrnH8bcORFRl8fqzvPFGnjbBTYCOWIbMJ36Eh8d23ZaMZ+2HIpn9fba2PbzpcqR
         2bjyz4YykNtCG26Qm2nKrZ8NXIkM8Y32T7x43/z7fetJf6jTtEMFe0JC9FlRA/oaFYVH
         YDvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769192148; x=1769796948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2nG00qw2ruBawht6GJzw6X6qOS/2LLsPM2l8lgx1yM=;
        b=DIGyef0ZHAyEZD4RWCl6LZoxnoGXdvuejXELqOyQSiw2foNOPi9k7q92ZLh9RwAq8p
         YJyq3ExgzHca+1gxYo/fdotRTqzTRQ/wPNlMVtaLrEzhuzC4ey+g5dWnYN4ubgRYHWR8
         sLIY/48rLVXU3u5PaXSiH/aXoZpltjZJqWHQx8V1RrWElIueZeyTejH0j9/P6dGEZvD1
         q2h2sU5hT48wmidAThtnDkcuToaqA/ScNiDMtunhKr6mKW9W6ZH+J9iseKQ/okYxGBGh
         UTJLZgJL4cyPfBQo6opSLE3FGPUjeJHS84A1qoTypboqu4H5hsVcztCRZIAcVC14LEiv
         7Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769192148; x=1769796948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I2nG00qw2ruBawht6GJzw6X6qOS/2LLsPM2l8lgx1yM=;
        b=YOQJQzLUYkp5OBv9W9X2SwGu4iPb+va1XW2lskT9j3bgxA53rOfb7Tm4W+TFfOaBRK
         o4LNSZgIDvAN6Uxg+Bhmji8v157tvKwX5kwsCqSFmGXUC1c2y7Ewe3bADcfMPA4JkTU5
         J7dizfY92BqLj2cW6zx7R9JD22v14p8gc0dAEXm1nQW8ek8oNSARR0gmt5DmySD3o49V
         ErELLujext7EifvGGoHC8d9Ch0wxooZFGWZ1I8lTz+pGgUMQ1LTzrstrQDWO4KOZpW19
         4sH9w/EUauEN3/h6OA2vcIbJQkkEMCTe+E1TKYD2zrdmcrZRcRzF4eUbvZCWlfnUb8YB
         OFGw==
X-Forwarded-Encrypted: i=1; AJvYcCV9ydYlzBBPk0gkKSvIuQKItQ+4+EBRPN1OFmZAfu6BJAIQ0zXr+wlE7+mqCs1dT3k/z14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+WwzjL+zluBw5JveqIPOo+6SUfkBBw1NKNnsvKrDwsFF3FOCt
	m0eE7uygBSF3Kw9qgJaTYt6Bcr5vS7yVy3394VKEzeMjJBIbblq3ykoHKoHWiHeGbYcpQBE/Rpc
	mmVe23bA4FOHlm44JC5L5JUPBu33S5yw=
X-Gm-Gg: AZuq6aLsteEy2IMz/FCLB+QHs5eA0OiCqbFaCBH/jqtJ7lCHFm7EBbiWk31HAY/Olzk
	lBu3CYEPDplyNTuy60nKhuJVCgeFlWEK5JBeKDHWQGmUcjvCUu5YWapXro2tIXRAL9V9+QUPjX3
	N39ckmE7vxrxj/62mQAxzWqlaenkiNupnY8gSky5OmP0fLdWnq5WnrOK18j0thxFrS0TBi78M6A
	QHDz7O/4AT3qKfVWI9scJ4+7FokPFld9Is+KFyfMSPPNsDIwT3EH9EY1yCyuwMTjUg09FlsC9TL
	r2FbRH3+dCvpuFZVCr9KXTHBVMgEjLWpQZQe3CbhPdrxzLrdAdW3A4Qwk3AOpua8CWoP/oB/
X-Received: by 2002:a05:6000:607:b0:435:8f88:7226 with SMTP id
 ffacd0b85a97d-435b15fb134mr7443178f8f.40.1769192147696; Fri, 23 Jan 2026
 10:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz> <20260123-sheaves-for-all-v4-13-041323d506f7@suse.cz>
In-Reply-To: <20260123-sheaves-for-all-v4-13-041323d506f7@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 10:15:35 -0800
X-Gm-Features: AZwV_QjgW82i1crlpndwrb8M8pt69fP2CoWaYroMilL8QIj30Jgt-nfZQ9Vffac
Message-ID: <CAADnVQLEupQB3O1RzFAPoVvg-frojmjFQhisAUcxTJOmkz02nw@mail.gmail.com>
Subject: Re: [PATCH v4 13/22] slab: remove the do_slab_free() fastpath
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>, bpf <bpf@vger.kernel.org>, 
	kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:53=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> We have removed cpu slab usage from allocation paths. Now remove
> do_slab_free() which was freeing objects to the cpu slab when
> the object belonged to it. Instead call __slab_free() directly,
> which was previously the fallback.
>
> This simplifies kfree_nolock() - when freeing to percpu sheaf
> fails, we can call defer_free() directly.
>
> Also remove functions that became unused.
>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Hao Li <hao.li@linux.dev>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

...

> @@ -6557,7 +6429,12 @@ void kfree_nolock(const void *object)
>                         return;
>         }
>
> -       do_slab_free(s, slab, x, x, 0, _RET_IP_);
> +       /*
> +        * __slab_free() can locklessly cmpxchg16 into a slab, but then i=
t might
> +        * need to take spin_lock for further processing.
> +        * Avoid the complexity and simply add to a deferred list.
> +        */
> +       defer_free(s, x);

We'll re-benchmark this when it lands.
The current defer_free() path due to slab !=3D c->slab is causing
spikes in some of the workloads.
I think with sheaves
slab_nid(slab) =3D=3D numa_mem_id() -> free_to_pcs()
path should be exercised a lot more often and fall back to defer_free()
should be rare.
Just leaving a mental note.

Acked-by: Alexei Starovoitov <ast@kernel.org>
