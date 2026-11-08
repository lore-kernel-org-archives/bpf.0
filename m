Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794176583;
	b=glSS+c3IRUSXlzbc7ML1v4AVOIBuQJSE+Mt9hzOMRLvw3aX2vuEg2F6E+pQyTyCiTMl3
	 ct4kUI7n5ZF8xAQLbvFoLm7i0e4Dc8YlLG15OIzI07qwSdbLXOVX87MYrQfd2nkX49wny
	 F7620VRdbsH4TNyIrJ6RUlo0aO7kEDYSZx88KNc7KzppG/jSr82AoCkfMPwZdB9xYpHYa
	 yHZalrdD5yp2ANhgiFQbdzC9rY4t9Og+whcHSGT9rJ+XyNwsCdgstuVzY3VtsVuurCgdL
	 UIMtqlCpJ0Ok26tiUATcggJBzAedD4lwuKZjalFZ0EPOSzF0Q8lTVEF5QjaTHNLheYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794176583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=F8VrC0NrVnqqzC7QHzYrksb2qPLbsZB4BZ6N/65Bg1s=;
	b=l9PeiqJC4hiSJpBaHC6Patm4hmGnKjwmGlvEgDXqn9XbMCzaor/s9/TamaFxtJ56gVzG
	 Zv0Mamm9NjX7M6oo4987Hb6IqhhcpCfx5DhPabsfErBvRFBC2E/jxEqEYvjrDRql31slM
	 J8ebPhLfEnMdfVSc/WVsQ0mZsuWjomjUjLqkhwFGxiYj07QNqrGIZ0ui9VGk/Y2SGaeaR
	 C7aZyJpgyCrs11ThrFzHnjtPjDIWHFKjSwe0zfQiNMayM1Kz6SaBRSUkZgvk6oLduSbJM
	 YiwzHb3XVSGuh8SyowLjdBvodfOBPF91jW+dgJJMpjHLdoZIBWjOo/I3doNCrSoJ75A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=SfY25uKn;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443DD606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 22:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 443DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=SfY25uKn
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c3fd91337baso51190666b.3
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 14:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794176582; x=1794781382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F8VrC0NrVnqqzC7QHzYrksb2qPLbsZB4BZ6N/65Bg1s=;
        b=SfY25uKn/JBcQ+d70yTpWO8LSHxIsd/H5CYD830kg4drEdlZ0hGlP7YMe0fNbqiIqz
         7siZ0gKKHa94RYOiPYJFCHHXhmOqQ8tUabYy2eJH+GZeV21o7BXukP4wXupvHBYMf/nm
         ZPHT7DuccVIu2E4NqpN592jLlTAjRhvGCml38LdAXXAv14dX2MmQyiHpqwmfY/Q3oaWA
         eaSFpnmKORAPFbl7025cVpX2Ya9GXha1mu34UtmopeXodOBUkw8it+uBjkIe1jIHf3pi
         x3aP6z8T6QbVF6IX2j1UgdJKNme5qt9gd+TVjbEWj4VQWbiWAFeCA/jdj9bQyAv4WywB
         VJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794176582; x=1794781382;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8VrC0NrVnqqzC7QHzYrksb2qPLbsZB4BZ6N/65Bg1s=;
        b=bBjmbkGRljb9hMdVEhM0+Xn+DuyuvC+54vmtF/yFc3s0nZZ8je5/In8FkEL/lD+8Us
         KDtbhyoathXXUxqQtFVH3zfAqzEBiYYQKpi6V7eHsQZfTi2vU+YduwoDiPcLtaArbZfx
         BDbzIXxkzFCjfPBbVrarPRa2hxoopXIhc6BmrobUrwgRi3Z8q04d+aYI1Gsz6AiC6hdM
         s4jw7mQoJJSrA6dPZENBafLJxmSdxdi++qIv1mddOkWkcyzC0ZVT+sLp87B4fnEsw1jd
         anKEFt4sz8mfkuAYmDQK5jAAmxfi4HgIIUq6mcUp7VfmPMkFiYlZ7sYPjj3xOtG2diTU
         sONQ==
X-Forwarded-Encrypted: i=1; AL+hErF8uYkTrlXN5jEyKvRfBl7TbdMsi9M8jhF3K9ce5i1H6NyNbquCMZ6pPFQFjTOtT8caryE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ei/Whdbmi7MlI8Mtfg2B7pWcCSU0vXdcNWMx1swnXAczGKtY0
	JhEs1IDciaefb0edt1x2+6h0u15lKGkrA7iflo1dGGslMWtoekiGS4E7TlnQNjsiGYs=
X-Gm-Gg: AYBFou38iwdwdlKB2msWPkb4dU8Y7oDQf5e+x/pTLJ95E1LXHgiKkd/0BGoR7DQePKa
	QM1to6YSmfmJWih58kmKNqLxltSYnhRhdRMnvdnu/Bg7wDKL+paR83ofB3D7J1Q7s8Q0idy40Sp
	3fx01kuslQsppVK/m8wJWsD8i3A+NWf84qbRRY4eny8yzMN6uMITkyQsvw6+OzOO1UyQCyLcmdy
	/MMztBQ08kTnMjWXjdcHK3DxbJ+SJGbSUcQJ9iOfGOPGZLe0ufrFB5lB+bnhfL55S2zdOPyWD7T
	LWLof9Llg6EMMjWLWdrKn+e2aaC0BatFDXa676GzhA2N0vHoCuGHkgWsfwCgwKsrdLW6o5S7+GM
	DwdxBNh+qQath5Rlg8CR2DdG2x+orBql5apk3qWcaKI85dSHuKx1AlGLxKkDfw9lZDBS384CmC5
	htb8Btm3jEoOyqc998wO1GZTL1HrIL9ZfPzVblIePwuqYssQEr2Kj4p77PqYWvOkEaA7sj2cuGQ
	zRfa9qVRB8sxSediIzKBLgXc2jtpIGWgJ4H/NKXSrzE8Rw9BLBnG4tmA0XE8jGbRD3SmuzVo024
	MfCdRM/x1GhzpoSbzCJWV9cZr9f0ljtk0k06aEb6TjgEwaDbXVKDiwi0PwdCG6M=
X-Received: by 2002:a17:907:1b18:b0:c3f:c856:fb7a with SMTP id a640c23a62f3a-c4d6d166840mr164389566b.3.1794176581779;
        Sun, 08 Nov 2026 14:23:01 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d69f944a1sm91809566b.14.2026.11.08.14.22.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 14:23:00 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: sashiko-bot@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	kernel-team@cloudflare.com
Subject: Re: [PATCH net-next 2/8] net: reserve extra TX headroom for local egress
Date: Sun,  8 Nov 2026 22:22:56 +0000
Message-ID: <20261108222257.16997-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-203545@kernel.org>
References: <cover.1794020868.git.tianyi@cloudflare.com> <4b2f20b9a7bcca58fced690d20916efab55ad31a.1794020868.git.tianyi@cloudflare.com> <sashiko-outbox-203545@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Sun, Nov 08, 2026 at 03:35:12AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This problem wasn't introduced by this patch, but can hr + csum_start
> overflow the u16 skb->csum_start field in xsk_skb_metadata() [1]?

[ ... ]

> When a UMEM is registered with chunk_size equal to PAGE_SIZE on a 64KB
> page kernel (or with a large headroom reservation), desc->len can be up to
> 65536 and hr + csum_start can exceed U16_MAX while still passing the
> desc->len check.  Truncating the sum into skb->csum_start wraps it below
> skb_headroom(skb), making skb_checksum_start_offset() negative and
> triggering skb_dump() and WARN_ONCE() in skb_checksum_help() or passing a
> malformed skb to the driver in validate_xmit_skb().

This is a pre-existing issue, not introduced by this series.

Jason already planned to fix it [2][3], but it has been five months.

Jason, are you still planning to send the fix? If not, I can send it
to net.

[2] https://lore.kernel.org/all/CAL+tcoCp19F2rNxYL_LoGsY5MuBZ6cGKSZsj6D7kvQZcYp0wJg@mail.gmail.com/
[3] https://lore.kernel.org/all/CAL+tcoCgXG5MdPVzXavwMwk=jmPXgcB5aKpLK+TNXMVrsGmS9w@mail.gmail.com/
