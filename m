Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786CB34BA44
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599391; cv=none; b=BjL9oap2l+d9Z+7OV17CO8l9ii0nOCRZVP21GW9kLFpNfMQSo8n9PJD27f3MpAzm5WSQF4dx+6lPmOx8b6mhjJlxNeX6+7Ch4OdxKoAnAsHHjS7JuQd924iyYPuvJIbPE6gmQKqFEEi/J6MS9WRIBEtbwGGnd8dsgfR2uZfPER0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599391; c=relaxed/simple;
	bh=GysCtSEUwxM1bD2M448X8hcl02OBDpTE5kWvuWY5+g8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MS7yr3/mBnGXr4U/zF5TOGY07pRwUsizHWv2Xp+MyoHtJUUr7Z09Lj+OgUIiyOGj400wMl2aMNxQRCznFGG+uNfeRmZr87DFhVMLhfVjexpg9L4tl3jenbHQnK289IJVS37HUaNSvLQSLVtCB9FF+wDtxemvsXKeoyLFb8PJqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UVNau8w7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UVNau8w7"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65b94e0a875so3134000a12.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 06:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1771599388; x=1772204188; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pOm+B3wl5yv8LFotdX2uqpI1W2Xd+zVLDreHcYOpvI4=;
        b=UVNau8w7PhuLkNKilAIDPELantgdsMMepGZyguNbTdo+vr4KpcI6hPJbSHNlItgdUz
         Dv0vqkD+zo6GH7vs8MjjopryD2nwY3e9chdLgZiPvRH2kw2N5UJxLMaOnSabtVujied9
         1N+Kp+BEtqV2hrRFKFaT/LEfJ/s5SpTgU1rAZijAJnDdyhXXPz3+z3jP81sXud+GGhCr
         DkPzy1vpgW36d2gTJlbzKPSgVob3jvzaMGUbed2AFmGroNPgTYH8s3tVtrBC5X78pr6e
         mKcQivnk54YEiNUZ9PDBHyPfGelMQ47tGlcLpEllTKIHPfV4rAbUlbRvdBOZslDoLnT9
         fUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771599388; x=1772204188;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOm+B3wl5yv8LFotdX2uqpI1W2Xd+zVLDreHcYOpvI4=;
        b=D0I4GLxJJcn+62ApB4lzn4Ild90UZLfBbu3ExuynIBwfagN/9ikCOke0dIfBtCQxv2
         QvBADCvKyw7yyZiCyAwCJH+fp3ePMYw9eQt3oexBnle77Uj/vyFR8bTOIYvWqi4Yx+qg
         36xSXIOyEZdETfZGCm/noTonMUURev7h/mwSOI7aOWX7sgoQ2pQhqI+l5ruycDf6HLI3
         Ec8IrZhQUISh10bqVv2beEvLCoMuNZBLR5UIwTUfQafFl4C6AgypllEaADjzaO1IBRWt
         pX2yJj9YmWv6IO2YvQaJqr62vnomgGUirtD06MvL2NryEYEyq05jUBYzHvbF3S7aie5g
         WGJw==
X-Gm-Message-State: AOJu0Yw/7XPNlObaODS8ILmIsv6Ku/l5gCLbWEkgTBNTY+w3w0grP7UT
	t+HfcqJVgQiE/a2QE0C8TAj30Tw7SfFSk2argeREh+utrh+TDuZ+KQjspBRx4dd2dLw=
X-Gm-Gg: AZuq6aKAjmbilLYwOtVoZIrp7ysAZSDyYRAZQ+twrp//4wOeLdlHwmrNf9LFnnG0lk6
	MeCcy0vhWwXl2/D1H7G60gj3xTfNS5QIt2iInEk+GGG3wnUjP0g6mlSHdCJ2buXB/iKqwaGO8au
	6P5wPF6uoJNpQaMDko8GDMaUO55ysReVbGIw/XdJjJ4jh9mHXJeTNh3X+NjSV82KCqsM9D/ookz
	5lIj9YmE7L1lnRemQ3BtMsi+n59x0VFCorRoXIL+8jO0Ded4Z+wMe6FhYo7AmJFVOp3gj/uL1nC
	uwenAX8/AfSt/870zaXxIiYphf9DhPi6DR56DwRNxSsw7mfm5rXkvPV5j3yU3i5iGH1QWKTHGiB
	2WOojyXAau+HBv4NkVNMa6HCvZBy798Nb6r8Ycsa//g9vtoRWh+MopPTt8Ownxq0gIAhQLxS6Ro
	Dl820CuZnnWlNKSAXQgv8EtnTgJ8s=
X-Received: by 2002:a05:6402:5210:b0:65b:f20d:763d with SMTP id 4fb4d7f45d1cf-65c769cb5b7mr4681236a12.9.1771599387800;
        Fri, 20 Feb 2026 06:56:27 -0800 (PST)
Received: from cloudflare.com ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad4fa7c7sm5004887a12.31.2026.02.20.06.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 06:56:26 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: [LSF/MM/BPF TOPIC] BPF local storage for every packet
Date: Fri, 20 Feb 2026 15:56:25 +0100
Message-ID: <87ecmffopy.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

In the upcoming days we are going to post an RFC which proposes to
extend the concept of BPF local storage to socket buffers (sk_buff, skb)
as means to attach arbitrary metadata to packets from BPF programs [1]
(slides 41-55).

Design wise, BPF local storage is a great fit for a packet metadata
container, as it that avoids some of the shortcoming of the the XDP
metadata interface:

1. Users interact with storage through BPF maps and can take advantage
   of existing built-in BPF map types, while still being able to
   implement a custom data format,

2. Maps within local storage can have different properties controlled by
   map flags. For example, maps with BPF_F_CLONE set can survive packet
   cloning. Other flags could allow map contents to survive sk_buff
   scrubbing during encapsulation/decapsulation or pass across network
   namespace boundaries.

3. Local storage supports multiple users out of the box - each user
   creates their own map, eliminating the need to coordinate data
   layout,

4. Local storage has its own backing memory, so persisting it across
   network stack layers requires no changes to the network stack.

However, this flexibility comes at a cost. While XDP metadata requires
no allocations [2], an initial write to BPF local storage requires two:
one for bpf_local_storage_elem, and one for bpf_local_storage itself.

We would like to align this work with the needs of other BPF local
storage users (socks, cgroups, tasks, inodes), where allocation overhead
has been a concern as well [2].

Optimization ideas we would like to put up for discussion:
- slimming down bpf_local_storage so it can be embedded as an skb
  extension chunk,
- making the bpf_local_storage cache size configurable,
- allowing bpf_local_storage to be pre-allocated,
- co-allocating bpf_local_storage and bpf_local_storage_elem for the
  single-map case.

Thanks,
-jkbs

[1] https://fosdem.org/2026/schedule/event/DSC9L3-rich-packet-metadata/
[2] Assuming sufficient free headroom in the skb linear buffer.
[3] http://msgid.link/ad835a9b-e544-48d3-b6e2-ffe172fcfa6d@linux.dev
