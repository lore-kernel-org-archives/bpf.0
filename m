Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549910;
	b=l17pjiFs0RlZXw4lggJe3COBwY1bJ0ZO46161cwQYD78dvW+d7w7cjMGti5nMquHBVWv
	 WNfWK7WilkSH6aHkyTBKojll8oiw0kjk7kc7ZZaq+1aCTwV9BqqluHU7m/eQhp0ugqykx
	 xi1gt+pOO1VSZOOVqRgKMME9Z8PQDTWuJbfYzbUDYX89wMEdek35wD3Ty/ilO+UnRzyuI
	 82YQNvFkZ+oTD6xEF+wFcYDxUT9zonM+ZsDiQU6BP1wt5AsnGGe3HMI9iEEBJDdK22ZxC
	 XGC6qKb8XZ2xrJ8MASbWfqv9o9CPri1nYbIK046T2IgzO/CgiZzQJ6ThQwJ/1R9wong==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=0xxfXHhFtKfjkqyqcsfFPM0ROkNnOJpRIbccoi8xK4w=;
	b=OAnNUVLhHaYkLd2SLHNnUziMiRbm6wSGZcd22wkIzn3yTa/YSniAJmjjalEYGiwljwJU
	 lPEcos9opNNGZi/Z9JfKSh+ENl8swSrL+iCe+cMc0daFgzrcOLv6/7SUwFzf/6e6+WIij
	 BiGQY9GKe/e99i2+2cpF3xTzrwJirIUomQZIvq+KF/fCuikarmM6CbgiWrM60GVeHDI89
	 /JLYzDjDBawO81hhqJQYoW6hvaiYLdpTq48wI3cJV5Ui05nsXvuVnKnav72Um4Qjl9r66
	 XNkJGXIcdFjagbbJH1qVcv60E113vZvMfRWBtQ5/+ev3D3c3PgnNCqw9FLk6O++1FLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xllrdZnw;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB8E606A682
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FB8E606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xllrdZnw
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b4cd193b50so761400a91.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 11:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795549909; x=1796154709; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0xxfXHhFtKfjkqyqcsfFPM0ROkNnOJpRIbccoi8xK4w=;
        b=xllrdZnwkm+pubWTFuN1lJ6YR0/wK34LHx9gNIsRUT/z5BSLXFhEqcs8Pxg7EL93ZJ
         3FK3ltGzVVBXgLReBnHIgtnD1QiEdkC7W9LpG5Oe32AoHfpjLdXkXos64FAbJrJpgokl
         PkzdvgHOaisJN16uijwFP/G4klxWvfrr5aoe5QNlfT98XKfaxeos2NFNfZGLS1IIjznK
         0kBkOL5TafhjY0Qr25JTMirxdW03ds8AKxgQRrNBBMznlVc+BXSGUZiCmDSYXlr8f/dJ
         7Vzeobsd8/uy3bk8tYmiZ2EuaMHUCdkWS9yMea6UUcWcFtKT3NztJSkEfhiaQuhyGuv+
         FnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795549909; x=1796154709;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0xxfXHhFtKfjkqyqcsfFPM0ROkNnOJpRIbccoi8xK4w=;
        b=GpcKzZ1kwIEYUZlsat1CmMOdEPtn9Qt0KjMEoyf6hm8ovlBog6iWlWsqNzp74UvLel
         yuOOpj3t4wNC7kdYb0hzSdBiFVKAz1w9mvs9BaFHdlnlHfr2uZFxgcof/QvsnPh8kd/s
         EmCU5aucxglq1YLQe7yLvqZw7UebkB9w9fcjhW1bZJkn6KIyzED4eyIiitX4mbxH374n
         zllqrTrEIpc30gSXN24JCvsQU4Cu5J5sE+6O3JTL7CwYQkF5DavdeMa5P6Rb+UWjlGca
         E0ZaJRJCmQBpDDn2LvYiWFr2U5S+9GnmHEDa2eO+M3sOzBG+FClG17zvI4zcH0+ACTbK
         PyGg==
X-Forwarded-Encrypted: i=1; AL+hErFQUSFeDupBFli2m8Oiso2uehJfxski2WjkkL+I2xIiv9DmLh5nDdnTR1mPclsc6DOvoTc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aosDAdXR+acfo4KcqoXvsKWPuwezy5RJE7ZQ8hMKyJaRUCan/
	rz5k//gppE6btrPIiyAZzHF3n68Zrb7QsFCTMs7Vyk16Y4DhiArPUfQa
X-Gm-Gg: AZFdTZergcD9CPw+o59DCrx9BMFAYoPNarjw5xODqv4XOFZKsqiVz3CS+zZ9M8WcygX
	Hvc9M75IXO1EXfLQAEHbiDoyJTbEW9u2I63iiMunSfmUlV/oMHMN2OZTvzFI4mDXckrWDbxI/Tu
	sJ5AFxzXchHTbkecC8A4uo35VEhfxAawXjkrFCbPssqo/m9GT7JombxJ2Mlq2WNdoADb2B3iM82
	ZJ2BiQZJfzHfhz9cFLPqUGbDJlBwB8kCcH5dboH0j9fQYBezhUJ9YuUz25npBK+rY0jPpO3qLtq
	A3+bNN3VdANNXYP4Wow0YIBqXy8dSmWaRzLEYQrBMTvaR4Fk4vXIjiSujMPdBhA7rpLFY163rAI
	s1jwfkvKTFV9F0VmJhYraJbIpPPu9agwHhhX3BqwP9Rj7cAMhHebe2MAVA3wEKKhc9R38JTisWH
	Tr01c32tvMTY3pQr4tLvxZ+rj7JQFmJ+kIm8GJtDFUEP5y+A77MCht03pavHU5j9rKxO5oWi+SG
	5WDq9VDvhF1oywEfMARwJNCni+xyAPPBQt2S86q4mYjyYRYkrl/ketPAAMRYRbT/7QgOc8DTkEl
	XsaAo1UoLe+li8L2vWxiVFOLeOvnbXyjSHg/jVczc04RkEj7ftFih9plp6HekAGo1Dm0+KZAtQd
	HvE7QdaThPCWj7Ogjsk8HpTknni+c3YMZJQ==
X-Received: by 2002:a17:90b:5847:b0:3b4:6094:2fad with SMTP id 98e67ed59e1d1-3b4609432acmr9064199a91.48.1795549908783;
        Tue, 24 Nov 2026 11:51:48 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm24987505a91.1.2026.11.24.11.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:51:48 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 19:51:48 +0000
Message-Id: <DN3PBKDHWZF3.18F6D49JMJ2AH@gmail.com>
Cc: "Stanislav Fomichev" <sdf@fomichev.me>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Willem de
 Bruijn" <willemb@google.com>, "Simon Horman" <horms@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] xsk: keep the charged page count when pinning a
 umem fails
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kyuwon Cho" <kyuwoncho18@gmail.com>, "Magnus Karlsson"
 <magnus.karlsson@intel.com>, "Maciej Fijalkowski"
 <maciej.fijalkowski@intel.com>
In-Reply-To: <179552079829.1290967.12345053263834529704@gmail.com>
References: <179552079829.1290967.12345053263834529704@gmail.com>
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

On Tue, Nov 24, 2026 at 05:03 AM Kyuwon Cho <kyuwoncho18@gmail.com> wrote:
>  net/xdp/xdp_umem.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

xsk fixes go via net tree.
Pls respin as [PATCH net].

pw-bot: cr
