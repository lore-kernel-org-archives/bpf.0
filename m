Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491749;
	b=xvnOYRZTqW0XTNlBM7wYQk+Lqi4SrVM2ZW37LwKaBOi2vvHfgO6dFf9IOSRp/QXTqLFx
	 p9GpDi1Uz+GFuXfqCt5YlfeKH5owe+OnxHdUKuEqJD5mPGlcXR0AGl+ijsAaECJQflkZt
	 CYWnHTaGQf4Jkn8gIWeGTTWObnFTMoHJwVinkCFzLbHLUpCa7klBAibf5DtrmXHgooCvQ
	 cBmGfDxdFYgYi+7RIkrGxyXHUqPQuj7iIcKFhF6SMBwHx1H5tGmxLTgCnT4Xj5iHb9YVi
	 jpTtKZILuvBzRezB9M+EJowBGaK2GtpwPcctbkj3BBlV7B+7wg/Y6ii//cvpREDcAGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=S/F+MCw7bR6+e+AVQ1jkNmq1hmwkFF7J17ST4v25tIY=;
	b=A4yrY2ZFeHXjP60OqYZ+9a6urUFTjojwKqDhN/32RUPTnWR4Hfx0jF6uhP1kY3Yn/lyi
	 RxtXBZul7eQA2cU2dnZtfRz8DuwZ71aUhZnUt8ZiKvAUc2hSbz9ogv5IC3IgpVG3ulvyh
	 2SzmhbxsDt1ma9vSInAn2BjRylyI5gRgQvqLLeJ/8RmFwKdki7mk8gw2okVvjtv9dvgEC
	 a1bFpALYs49Vl4eXdNC9e0OMYVgu29TY+fiydfhG8856zkJksSkttP+C5WkmKynXftNBx
	 eARIkslBakLc9fu2nkKqJsH4VQ8tOA6aXvzi/MA9WySLqrNWGuKxqWm3pTu6ACbacMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sM8DjqUp;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A741A606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 03:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A741A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sM8DjqUp
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so2025514b3a.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 19:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795491748; x=1796096548; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S/F+MCw7bR6+e+AVQ1jkNmq1hmwkFF7J17ST4v25tIY=;
        b=sM8DjqUpPjrUveXjBFI44W75N4yMd77IwfvFPmztqoSFwCm+AIvmAaWkqlIDo78S3f
         XWUWdHeLQf1pqkfegkTPM7T38bJHayJukaV9c+iZd4FJpnwcZSypDbRGsowjzTMqQ9Wx
         opfBgxF0L4oDgb7B4fBKRrz1YkgCLPG8hpmSxftHYRWd/OUpgQfm81H1EPVICw6mU5l1
         qZCTlT7H6Ac5YKaG5ZONE8nq5T9NbRZ6SDIsrf/jspiapcRkA8qrhFy/cMLqLxPcY6I+
         dZPrWCzWk76rLM7+TEm9/HOKaI+0X1tknMhUrkOXjpxaU7FpavrZuXVJFkDyVw2+41Ty
         c5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795491748; x=1796096548;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/F+MCw7bR6+e+AVQ1jkNmq1hmwkFF7J17ST4v25tIY=;
        b=EcSPXqfqfOLfIxwAnfwQFC55V7sZgrbIXflx5f8Ze8gKq9csyCUkcXJumdmxd5Kc1R
         zIfcQNQQ9fI7km0ctvWQ8I4tEL0XonuDVsEnVR9Ga960FMB0EAj4F25TI7BEE/xmNIHm
         d+PTWTORMHZz7Or3KBEn+ZxwxT38cuLGyAQ/xsZ5IZTbVnxEqImFlTUgQ9PYA7QJL78N
         fcrOv3RJXyVbENyzK7bGZH/UWACFuRo/IXKquxji+yTXpod+5YWne484TXX9uOCfN7al
         RjltrfF+lA0Ek2syQKOkN6kROQ5q9+T/185sotQMqj7pnaY0J6p47wcuW4nxZ9+QVhO9
         Zivg==
X-Forwarded-Encrypted: i=1; AL+hErEnl4vlUG8XH0WmuTGx/XpQqggIZuoXLhTVM+2Zzy/JOW1qoqj6W/cyO7Kr3jRB9CgJtIc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jN5UljkgNIFFVgPn+A4H1BdiqEoxuhAsTqvynPpHdEl+KK5Os
	kBTLac+bAnqn1AL2YeZXzh1pr400B2wqWW3NykuRtmXhf3etsRCg0q6o
X-Gm-Gg: AZFdTZeutiGVxYKPmoCPRje0i+0SN9+7OwaygQTakjMKECxzv9aVKMTAToDY+xfu2Yy
	vTFF7A3QxPtSuqR3qplKAdkw62N+RM0/on9WEZhJUCnYjI6T4PJuu5o/K8ppfg7OUJPyEkJWibt
	OSj4NmBdJcPynQQK3YmsKQX23nGH3IJuLPmwYEW/UhsqvXBbEQqhOgNC4bPcsgF8foJUJKSuzpB
	vEHh/J6Q6jtwNzZf8QJdhG18CeW/2gdio1bSN5N+SXxYCoPWyea2PgBBo3gCvPYeACot7kye+wr
	GB81HhX7kX/y9br0WbB0b0n+N6kWxzTyjPkdRc7xRmloo08+5+2T0n+OKauSWOVR7ePhdyXX/Mv
	yp0RVP/3WHaja869BCu247RAHVWIXK3UePlKhoa6cpcYqXiAaesJTeBceJlFkXkG0N5h4lFUmOT
	M6OGDn/5yZalJkks7SPZ0Ls18ke7Qqb0iI/Ua2/MN1Bbkj9tQ83lSQSuNnS+jzCq65PI0EdxePu
	t4Ox6IirheDJlFWO7G2Np79q47lpf3x8vZl7Um40HdDnxV7leenMopmxrxBMvWDSHDqd57RBKGS
	996n0jBCOFG+ylejtnK26WnAg4FkCTR/mB7KCg7CCs/aBVbIEPOhuSkT68/pD7GVNZGIqrkF9VP
	Dgcavn9KRhl+jH8dPGRfj7dyV9avFsf0l1CinVfKlqTveTYQnzsALlNK/
X-Received: by 2002:a05:6a21:4d8e:b0:3fa:10b3:c8f1 with SMTP id adf61e73a8af0-4014d25ddfbmr11385972637.41.1795491747709;
        Mon, 23 Nov 2026 19:42:27 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde9bb05981sm1025698a12.26.2026.11.23.19.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 19:42:27 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 03:42:26 +0000
Message-Id: <DN34PDK3NDWW.7JWY08DGJX89@gmail.com>
To: "Tobias Philipp" <tphilipp@gmail.com>, <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Daniel Mack" <daniel@zonque.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Ensure 8-byte alignment for lpm_trie map
 values
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261119155317.11469-1-tphilipp@gmail.com>
References: <20261119155317.11469-1-tphilipp@gmail.com>
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

On Thu, Nov 19, 2026 at 07:53 AM Tobias Philipp <tphilipp@gmail.com> wrote:
> In particular, for an IPv4 LPM trie (key_size = 8, data_size = 4), the
> map value base address is always 4-byte aligned (4 mod 8, and either 4
> or 12 mod 16). The verifier accepts 8-byte atomic operations

Only on 64-bit. On 32-bit that value is aligned today and this patch
breaks it. The node comes from bpf_mem_cache_alloc():

	return !ret ? NULL : ret + LLIST_NODE_SZ;

LLIST_NODE_SZ is sizeof(struct llist_node). That's 4 bytes on 32-bit.
Offsets from the kmalloc() pointer for data_size == 4:

                        64-bit        32-bit
  --------------------  ------------  ------------
  node                  8             4
  node->data            32            20
  value today           36, 4 mod 8   24, 0 mod 8
  value with the patch  40, 0 mod 8   28, 4 mod 8

arm32 JIT doesn't support BPF_ATOMIC, so the interpreter calls
atomic64_add(). That's ldrexd on ARMv7. do_alignment() doesn't fix it up.
So a 64-bit atomic add on that value is fine today.
With the patch it's an oops.

> A standalone reproducer is available on request.

Pls add a _small_ selftest and target bpf-next.

> -	u8				data[];
> +	u8				data[] __aligned(8);

This changes nothing. data is at offset 24 or 16 already.
The node itself is misaligned. BPF_F_NO_PREALLOC hash and rhash have
the same bug on 32-bit.

> -	return found->data + trie->data_size;
> +	return found->data + round_up(trie->data_size, 8);

dev_map_lookup_elem() has the same problem on arm64.
It returns &obj->val:

  offset 48   unsigned int idx;
  offset 52   struct bpf_devmap_val val;

The map is read-only, but the verifier accepts a 64-bit load-acquire.
The JIT emits ldar. It faults without FEAT_LSE2.

pw-bot: cr
