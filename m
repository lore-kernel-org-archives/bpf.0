Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BC03F8EC9
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800330; cv=none; b=V5sahfB8hCQS7T0WyRXmGy75BUqY5TsJsGmJEgSzAPZJ8xCbJkJHDluZqMY9cIinzoeWfcE5i5KK+7SkBhlQD6+fVyPb1yZo/Uvj+HHzq+NE7XamsCZyGCyC6a6vluDZfB4vi2QmLM/1rzUiLR7XVnoLyV6fVbu6mRi2FVvwTIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800330; c=relaxed/simple;
	bh=PJrlFgAiuyfnK1/+yuPQLy7EwaiQj66gGELJG7MkhUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUlRQ6T6TVJ5klDU9FScO7DhEnEzJoMjsSFTX6dIegvCyee5htb6ZRKk2wJ7sg9YP2HRDrC7wwGfNYtZGe6P/osDwhDiQVZVNdO0kAgWu1Wn17OGsIdgT2tINv/KqOmwHJD2TZjSwa7qQWRjWRAZrzGTZlpmVK617lUDVYUjVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUVjTT8n; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUVjTT8n"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954df200ddso2818065e9.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784800327; x=1785405127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tWzwSmtqiucIJdON+AGZxd6bPRUb1cQqs4PNYmJoULQ=;
        b=MUVjTT8n0sjO1HgO23tg8OBmx/l1ExTU2km2Cq5202klAStKj12AP5jeHSv4d6MDQP
         H/YPs1cmeCqdUu6nlnBxyMmlSRPYtOwZ69ZdfyxBqbTUCvJ+8SJginCCh4UygVGPjIBI
         YkxsrOtXmZq5dmjl8zWMyhzonXXBKdkItOTsfyG1q+cl/qpXnDYez47UdCKuo4qvEx4+
         MWNz434T32uGRYgTpn3njtWLgT5bD+tBnWTnfVOaoVNyrEXmaZ7PmnObN2kWIkqmWB0e
         CdphJ0VwH6v5MDV8vvctvQ5SJcXPyL9aIjRZ7eLI2WZLM96Ekke1C03mAfS0TLExSxm6
         TzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784800327; x=1785405127;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tWzwSmtqiucIJdON+AGZxd6bPRUb1cQqs4PNYmJoULQ=;
        b=L6OodvveUIgt9eu3W9WDk5STVfyXRCqfNNuDEvATRF+RCkNkUGvloWqDgenLiwLGX2
         BEt9vDqvAhZm/If6qwVCZE95AhM83dx9bOGLwxBoSD2WSRysikk1TLGxECKwjbC9yp0g
         4vgyONoqy0gpfBi7Dt7sfrzVyuS+uzpuK2hoWfhtugcAs2SClS47+JRPL8Vz1qHzWObQ
         x9JNsghTvz2OOz0kyTOppR+iQTELQqQfSUbH3fHz6qx/QVy50Jn6IOLACNaiM467DXN/
         k6xuKCtPtufi48keAFRZy8dw8jVHOxZFKmerf3+iirS+AdNEEfYT4wWsdfzTIS5asc5n
         ivzA==
X-Gm-Message-State: AOJu0YyWKAADbwyzzKm6jvjhtzP7fYI7iixUWRYDawngPujaaC/2+WdK
	7l5QJtbBBx+GxiE2snWbuTGREZ2SPoMSKX9h+cT2EcElDrd4JIbvfPXl
X-Gm-Gg: AR+sD129xrfjOwrezf3oexoAisVPJtYgPRFXLCeBptCKa+Vo7equr/kDfJ/YIPm7xZ2
	7vuRp/1bcn7K0OoporZzae4TmdEv3RiSHDvevMHjjlXl85sgU6zD6vAxgBlnA6E8GNnG9sy3GU9
	HDUsIX+qnZYUAAqbIooS+Rq/gImFkyLYq1ebyCgjAIcD51yv562Zomnav9R53PxEDW1PkFeeufw
	YVkuhLnzFWmVD9QFSxTqqF01ryzNW0e9k8OiVRUbpMYfv7gcFjkbHm8tlWDjCtkIoMpe5pRC0y8
	nRZNkkkKcutHz7CqOaEgk1d0/OcKMcfDlEEa5oah7RUXx6dioIeEBJ64rh5Ft6IhN0pGj5RHo1A
	oX7gFjw63VVsW8z4GDlgDSYham9nG3nAvglRkzodH04JM5aCaJuwhF7c6/pp50gJXuLBV8PNDYN
	WUO42XarJpZsAaOxozPEergP7Vo1xEyuRNAw==
X-Received: by 2002:a05:600c:4f56:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-49573cd0b3emr23809065e9.13.1784800326532;
        Thu, 23 Jul 2026 02:52:06 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f25b6sm127202545e9.2.2026.07.23.02.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:52:06 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:52:04 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	ameryhung@gmail.com, kuniyu@google.com
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Add ksock kfuncs
Message-ID: <amHkRPNLKl8dQomb@gmail.com>
References: <20260722104454.165911-1-mahe.tardy@gmail.com>
 <20260722104454.165911-3-mahe.tardy@gmail.com>
 <amELAv1bgc9DP6WT@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amELAv1bgc9DP6WT@devvm7509.cco0.facebook.com>

On Wed, Jul 22, 2026 at 11:27:32AM -0700, Stanislav Fomichev wrote:
> On 07/22, Mahe Tardy wrote:
> > Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> > sending data. This provides a mechanism for BPF programs to emit
> > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > socket types with IPPROTO_UDP protocol but could be easily extended to
> > SOCK_STREAM and IPPROTO_TCP in the future.
> > 

[...]

> > +
> > +/**
> > + * struct bpf_ksock_addr_opts - BPF kernel socket address parameters
> > + * @family:	Address family: AF_INET or AF_INET6.
> > + * @reserved:	Must be zero. Reserved for future use.
> > + * @port:	Port in host byte order.
> > + * @scope_id:	IPv6 scope ID for scoped AF_INET6 addresses, or zero.
> > + *		Must be zero when family=AF_INET.
> > + * @ipv4_addr:	IPv4 address in network byte order. Used when family=AF_INET.
> > + * @ipv6_addr:	IPv6 address (16 bytes, network byte order). Used when family=AF_INET6.
> > + */
> > +struct bpf_ksock_addr_opts {
> > +	__u8 family;
> > +	__u8 reserved;
> > +	__u16 port;
> > +	__u32 scope_id;
> > +
> > +	union {
> > +		__be32 ipv4_addr;
> > +		__u32 ipv6_addr[4]; /* in6_addr; network order */
> > +	};
> > +};
> 
> Do you add these because of BTF type checking? Can we have something a bit
> more orthodox like:
> 
> union bpf_sockaddr {
> 	struct sockaddr_in sin;
> 	struct sockaddr_in6 sin6;
> };
> 
> ?
> 
> I hope we can just pass these to sock_create and make it do all the input
> checking..

Yeah probably, I didn't think about this too much. I inherited it from
the netpoll tentative where Daniel suggested to take inspiration from
the fib lookup helpers[^1], which made sense for the netpoll call. If we
can simplify this we can get rid of bpf_ksock_parse_addr(). Let me try.

[^1]: https://lore.kernel.org/bpf/4b64ecd8-eade-4676-822e-da73abe2421d@iogearbox.net/
