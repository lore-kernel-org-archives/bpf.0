Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6B24E534B
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365900; cv=none; b=pABhMG/fbPhqMqm3ULNlqodf+WqLmCpvSMNNxsjO9Uii9Tg+gsJCmaTQitGR8jCXIBj2DSt2umYJZ5DoYFzrGhsa4+x4YlX28OxjWUpseny9Umqor5EYBog6jLfC7JpfQiKLQ8jYgXLbWngKqpEnl4S38Djf98+MTVQi2d/2uNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365900; c=relaxed/simple;
	bh=Y6XLez4bx8jf7oVVRkIynG6FSaoMuruJLTjDxk8GpOQ=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=EFHxBiASb6R1Q37B5MzQZK5wdRpi5MfO9z/mUQfG00j53QzvkPjlgIdhwzK7WN0ZSRYKwDGTWr7jLDlOipEldKknPRtTVHZ/oYNxUuNtt+w83XsoGmqHGIoFGthoMqCuCFQXTcU2DFJp776imUfnZGouIlbPpqM5/dqGBXEl3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qiiwvOi6; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiiwvOi6"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469f204f6so662231b3a.2
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790365898; x=1790970698; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y6XLez4bx8jf7oVVRkIynG6FSaoMuruJLTjDxk8GpOQ=;
        b=qiiwvOi6jzS0NI+LPVGohZWQ6BcYCCmp+UkqYgUZJ2b46W5j1uJJAyQQp79O7q+qlN
         MqaTAcgUVWRAAxINyW/uEXFgMg/Taw8z+C4kdaMiboI1AhBwotmJV0PaelCCLUaySJs+
         c7ya/xUtbI6W+jf3jSpDGdI6rfyGupCelQ4XD4nmlOCQFXcFilKDPBRDbJzF6M8EwYK1
         8zPaR8JDmlxQb3o3UYOUpWYGOED8kZhpFKDm3s96ihTrCKo5wcg0pEoCPJDmoBs0q40F
         p+oQda2rq8HL3FDxXCjQSrmT/A8Kac+qOFF2F9AM+g0WAilWm24myagMQFhnHSo6AgV8
         Snlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790365898; x=1790970698;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y6XLez4bx8jf7oVVRkIynG6FSaoMuruJLTjDxk8GpOQ=;
        b=YseQh4cQevNtfvh2AFMayawmytpIZUpn3hNKjRzKqkth7q/yQw0pnEvCYK3tq6LEOB
         wh2eV7ZaU6cwfzb0ZLM1UexbI1Pf5sym7j/tzexLZKXda+4rKWiIxMHbyYEa0P2+aqnx
         3UDYLL8ZUm/QIFf5YT0nArmLfYw7dyfXRhHUusdHXhqxbgQZje3bzUjJo/TxJ9oy0xPx
         6bHCljvDv7NUVNPmJXNcTkpujFM3D5KbGwJdKyGmNI5+8Q9r70fni+0mRQqFHcjYqEWk
         TcQ0Lap/eHJ7llWIfnim8UyvR/ksoCtlCFCopxbnxG5DtvT4BrvQw6CxG7D/qTftyHDP
         8qtA==
X-Forwarded-Encrypted: i=1; AKwUvBxyhi2+ya9v6jsC7VOa3TQBYj8PpCYOuTrh2QrglKr0Tvz3171quovuMPRLKTaIlW8nr44=@vger.kernel.org
X-Gm-Message-State: AFuF++lMnHytmE+XuW66sizSWNKEOgK6FoUmgXefwJ6BO7Iq7WAmc9ER
	ZfMw7wW3FpbWQ0pxkQbcbVJ9dWLbB/VQDVF1ikmOURvNWJ8NjpuSlajv
X-Gm-Gg: AYBFou0pSsyZjXV7Tp82aJ5FyB4I1eRYbCBTkNxgVZ52ecOlHvMsTlqw9YBSkV0ZCL0
	AtULPUM9PAmrAMXvUrKJaOFBoLbBsU9UkfX/4UmXPtQgu5bOJ4BFFzS9f8XnAGbN+YP3jbpFTj2
	IyTjZTTkjGEvla9W5c1TaiDvWBTxk9oCsB3Omp6OlNpIqLZXnwBvtidvy9bxnkSn5fzVbTmLTPF
	4l+ojpCeWrxPwbBA+6OrZ5xQqcoP59WT0qjAwyjd89IoZhtez87hEWVvEaDIZF2W5B6Bm5gETvK
	Rp5TZFo0EBRzHiPPDCAv+Js7YIzzncQQveJIwoC/AUwxTqE0h91P7vExEDG2jXWg3gGx9YqZwqO
	FKIaeL3HgtUNJt1MzIQD8QIL1eoaH8sNxo/qwBWu5eUxnZ+3N5nYuh+XqZ03m8o1lMx/fFp7ZBm
	nqRTWgcKEnlXWXMh4KLJw4uYvHsF56QNi9VnlTGc+Fyvabzuf4MZYRwWq/rdhRbK2Y7AnSew3RW
	6oa2TvncQgJr5m4/6ZFtqgO8B7W1X2ealURZ42sxBPPyWfkNc1ddYHGwK5EAtBGU96prDjEI45h
	CN8=
X-Received: by 2002:a05:6a00:7599:b0:880:47cb:ef05 with SMTP id d2e1a72fcca58-88047cbf251mr1668896b3a.46.1790365898275;
        Fri, 25 Sep 2026 12:51:38 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea19030bsm1668470b3a.11.2026.09.25.12.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 12:51:37 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 19:51:37 +0000
Message-Id: <DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Jakub Sitnicki" <jakub@cloudflare.com>, "Daniel Zahka"
 <daniel.zahka@gmail.com>, <netdev@vger.kernel.org>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, <bpf@vger.kernel.org>,
 <kernel-team@cloudflare.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Florian Westphal"
 <fw@strlen.de>, "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
In-Reply-To: <20260925121849.2ac5150b@kernel.org>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com> <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com> <DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com> <DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com> <20260925121849.2ac5150b@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 12:18 PM Jakub Kicinski <kuba@kernel.org> wrote:
> Instead of improving the existing infra we're adding more BPF-specific
> glue and another bit to the skb. Matter of perspective I suppose :/

skb_ext version needs a bit too. SKB_EXT_BPF is the 8th id, so it takes
the last bit of u8 active_extensions.
skbuff_ext_cache object is sized for all ids, so it also grows by
BPF_SKB_EXT_SIZE for xfrm, mptcp, psp whether bpf is used or not.

As I said earlier skb_ext is fine from bpf pov. If it can be made as
cheap as bit + tracepoint I don't mind it at all.
Which part of skb_ext would you improve?
