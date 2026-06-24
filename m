Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74243288C30
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302096; cv=none; b=om664v9E5kVLZ6z7lZQNqMfblfuDLS6pBfAWx4VYHZm8T5hcLD5mZrG1K+/lGJuO9sJfLwxDdXgrW9SCqK/3aokIt1iexzt9hBpkIJLlcZGEu3lBBq3UeY2sM4yjp8psbhH5AeExOpqp4SbuzBhdcdHzP+kX5bdDdnyBCB09HYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302096; c=relaxed/simple;
	bh=TMWGjgzhMSCfw5zila1yJHv6X+TiVrsYoTVEXvWsB08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZTYwJgCImwuLjM3MVNgJPnIp2KYYyUPTZUZbbeQYT0S6mcZHFFjtR+d5on8n9cZPh2K3H06b2IaCAZXbmKov9Olp9YMei8KwAGnunpNITc8VnQO+NXJHjfVYlCYjbHIWfXC/1djNWHylys+acLGHpDIDq8W8eEKTkUNkQTScx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6FK7+8v; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6FK7+8v"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c88cc025f54so470089a12.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 04:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782302095; x=1782906895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8Vn96XVnW2krHp7V5/fKbqoj2TgGkav7pxGg+ctypU=;
        b=s6FK7+8vdlP/evJWM8aQW2cyHOMsflq8dKm8WwRbi+F7V8VLeElkpZxFrPZBVC6pqW
         Bs3+6AGNzUCzjWFhm7z3y4mKcDT4SkInzd+tYK1tPxdwOy/Oh12ASZQRtlWFSR9HOJII
         ZW3rkC6prJLPzeeKTmOj5q2ZJ58oKJSS4SYVphU7HGrcuriGpgTZtTsa7gGGOmL9x9Yp
         gtCI92QTrZn9ic5MvuqW2Uz3GeTuR4J0lo09dNXZBFDE6ztKrAA5gE9I/KCbUvh2sbN6
         FGVV4FOKOWT8R9UW6aed3gndS+nfCvR84R+MrFMG7PgHeeNbCOHnsjaZvD7zPRX+leM4
         DDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782302095; x=1782906895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8Vn96XVnW2krHp7V5/fKbqoj2TgGkav7pxGg+ctypU=;
        b=mavU+JzBY+CDZZuQb+2SBaXMf74ebPpFfXrn/VIz8ab6u8uaEAeaQDJtPXHpStJxhX
         eM9+otx3puMplt3bePfjNkqmM/NDp+0Uk/HTgvcOt2kTQL+bUPQJvIMyu6kOs+ju6BB+
         3a2/0NZK5Me7vGM/pWfbMUpjJJEW52zX1JqvL/Mm4NRRgjpfzUoP7B91aLTTsLLNkQy0
         6+fDecknoV2iXIM4FOOyZrivd+BlE3CjjLGDIPZKzJTXWflJ75JlD5SnlCH0ncqZJ3s3
         yprtZi6gJrnh925GTqFxrIFJIvwVcd5E/lxLEBbihJv5yqp9D8JI05KGgu1tYO2UJT/g
         hqdg==
X-Forwarded-Encrypted: i=1; AFNElJ91WtlnxOzoKgzQhtrgl1JpsrcXIfcibkyZ15NPUfcBa5N8gcGqOdbl9HofVm1lD3fKp8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBnTj2xxefFa9WoLgnoxK6s7eK6yDWQLtXCeRWklKqMDyA0/K
	d1AJ7hKK7rL9y9ScbQsBmVCV7dzhPmqgX5BsP1/H5Yo+deXe04vBoKJB
X-Gm-Gg: AfdE7cnzX/RrY61JWlnzQ2QaLcglSlZRom0Ylwl5l5HixWbjoNsPtyyL75ZI7Fa4iYP
	e0z1HAoQNiUjJMVQPVask6br9HJujoApzlrK55ESMFPFQC+lVbwGfiIUs081W+XKbBMQUqPqgEE
	06smY7huSwcoblyIpIXMVwc+5EajIEGSENRN0b9ZjoDe7qIMfDVvda5l0eZ6EuGIVUpiWSzZ9Su
	5K2FTaf9HcHwBD0SKZ5mVWmUb4sn7JLbHHEVecU/yVibVz/+cXOMbSf4QvfWIKc7/qAzYtzUPj1
	XgBr0iarzUX0naxrkTlC595ocPzMtsjOzfbdArm02itN9XsfizXoeV91E1ntjhbRRAi1cV4KoIL
	aUhBdoeCDg3eO9cJu/Px52GWSODVe/osJ1ogVZnBrk/23ujk7g+imeM9KjcqVgx1KgKK5E3B3AY
	z54gw9gEDC8SdsD4xj0dwYWYp8ENdtvztwsXeKrZMIrhZquiCUnwndmb5s4tIy
X-Received: by 2002:a05:6a20:b7a7:b0:3b3:f46:1ef3 with SMTP id adf61e73a8af0-3bd15239141mr9670702637.41.1782302094539;
        Wed, 24 Jun 2026 04:54:54 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc563c168sm12708560a12.20.2026.06.24.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 04:54:54 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: toke@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	yatsenko@meta.com,
	leon.hwang@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	rongtao@cestc.cn,
	eyal.birger@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
Date: Wed, 24 Jun 2026 17:24:42 +0530
Message-ID: <20260624115442.4112419-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <87pl1gcmgf.fsf@toke.dk>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com> <20260624030530.3342884-2-avinash.duduskar@gmail.com> <87pl1gcmgf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > +	if (flags & BPF_FIB_LOOKUP_VLAN)
> > +		return -EINVAL;
> > +
>
> This is fine, but we should probably reject the input flag as well in
> the next patch (for symmetry).

I dug into this and I don't think the two are symmetric. The egress
reject is right for exactly the reason you gave: in tc you can redirect
to the VLAN device directly, so reducing the egress to the physical
parent is only needed for XDP. But that is a transmit argument, and
VLAN_INPUT never touches the egress or redirect side. It only sets the
lookup's ingress (flowi_iif), which picks the iif policy rule and the VRF
table, and there is no XDP-only constraint there for the symmetry to
mirror.

tc also has a real user for it. In __netif_receive_skb_core() the tcx
ingress hook runs before vlan_do_receive() demuxes the frame, so a clsact
program on the physical port sees a tagged frame with skb->dev still the
physical device and the tag in skb->vlan_tci. That is exactly the
physical-ifindex-plus-tag input VLAN_INPUT takes, and it wants the
subinterface-scoped answer. The 2/3 selftest already runs the VLAN_INPUT
cases on the tc path, including the VRF-table-selection ones, and they
pass, so this isn't a theoretical tc path.

So I would keep VLAN_INPUT allowed on both. If you would rather hold a
uniform "both VLAN flags are XDP-only" line under the same
restrict-now-relax-later rule as the TBID and OUTPUT combos, I will add
the reject, but unlike the egress case it removes a working tc path
rather than one tc cannot use. Happy either way, just let me know.

Thanks for the review.

-Avinash
