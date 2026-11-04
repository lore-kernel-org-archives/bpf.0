Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752176;
	b=1TaWec4Yfn7+zKh30lHHCMmRY/rMT+PqLv1W0Hv/tpGOqo+Gr1+XEeeVHoXhUGDiID1a
	 X49l3fJUe4e4vnxALR9mzuOcP9WCefqlF+yyht0FWYcApouaYLQfF8JT6OPoEQyOFxG10
	 g9fkG/q0adlGdBXM0WeWREx7VTVnao/9UDTc1npzJHDoI7aVTj3XqEp0t7HLdAKu1g+Wj
	 QLbA76pEH8ynU2qyHcUG2Tae14ZuoIBqZmLuBwzI3Y7UuVrQ1rNZZ7opUkzGle4tQ0g7s
	 i7R8FHaP2zLio7K67X053LIgFwPYMdWv3pc/tOKhsXXgGMBJwxY2pk6aCWsQ7Poojpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/eXhEqhme6RLyDy1UKx6O3gu8VaW7aGNyJfDtIx+o0Y=;
	b=mpwggt/A+4mrrmq6Gx4DT0T48T5PE2E/BcNGhoqIpvwgpiKXyKzUT5kBqVaLQNm3eJpj
	 y8D5zlGufY4bOc8LeV7d0aaDuFkWMTdxdfr0EbYlj+OrXKJNrGVHawSe+tpoQkjhlTSXA
	 AqtY/vSXXcG8yY+jE8zSXABMvgC4682Htykga4OCRZMPgivYq5LU3YO3uGVB/Fj6bEjTA
	 dTN3ctch08NX6nTFY4b4Nprs+sleHBYIVbHyxhEGC5dP+v6ApoDaeetN56h3JbM/P7vL1
	 2cLupDBZwehh5ndx6dAwYRsdIcYBXuu6YYxNEYqjFQvssnbfeRZdzJ7aw2y2CJuPaVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nfqyj3ib;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABA1606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 00:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AABA1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nfqyj3ib
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so151031b3a.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 16:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752175; x=1794356975; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/eXhEqhme6RLyDy1UKx6O3gu8VaW7aGNyJfDtIx+o0Y=;
        b=Nfqyj3ib/rCzof5QIGoG/Lqq9chSKO/bVoOr8RIHzuC/3AET4vx2vpR30emtjAd+vf
         YGXUIDIdr2sdIMnE0Ch+jMQMWPcaRlv6ROgC4/6W2OXClOfOijo4vezZ1GGrN3atAfTN
         tk4bTILohXkHLL9HoS6c7OZ1nj4qMbgXlVlKc7SHjRh+UVBeLs1Jzkw86INEsQH962Ub
         i8XCw5R8km/duPnPnDd6NZRB7icYJ/PqYnfVKiR5PF8OrFUg/SVdiNtmPNAjBgXs/52i
         gQoZbnQOSXtI2ABFQHCh/CCzKJQeQrg8To85JZJrSkijjSKf84krBmPjbrv3cmz6ty1U
         255g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752175; x=1794356975;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eXhEqhme6RLyDy1UKx6O3gu8VaW7aGNyJfDtIx+o0Y=;
        b=QzkeExVwrAlJVXnU6gXp6t2uDU7wrkDLjqDbASGgkcjPCwdLkxZwgqUBcStE+78d+R
         TkAWXg0ytek2UXOFPWcS5ks9uXblZLSkC4CoMWfpDZt4Ufhx1emU9ttFL4iYnDTjPkvN
         GcHd9/h2Vpkx+NfHUMrUE2KwNp7HdHUiyXjKqE3zP9do64PrK9/BUxX+v18UWcCFaGl0
         RnykTTGVdFqgCN3hXyhmTbvrg1h9XsmvhsOATuXOONALeToJz2MsizpjzIHwxe/8X4Sc
         ZE7x9GcuIxEPSfWpEQzXR0yNh/MUNNVgSG7o9MtUFz3b43HSAvzjwvGBkkVayKZQJLtM
         l01g==
X-Gm-Message-State: APuU4Z/9+U2XI51Vl3yBeGPWIuWIqVEWP7cqNOTyYvWDjQUljTt6h0Un
	Sz9ZJI1/NizbouNv/HrZInoBthwhYG7AV+XwaeihLtjUa0prLiebghe2
X-Gm-Gg: AYBFou2EV563udA7Zubbt0KUSvh1C56e0gGBnfrq9oDWTik1N1YC3G2ud+0QOdlmBFY
	1ILx1wlYwsIyR5m0Ud4vSEunInLNWFs7KwaB6XQ49pdcbsox1CUxFU2Dxh6/4deyOhUjkSsSez8
	6ZUd8oI5xtqk8sy/IB3EuUkYxV0wl27lzl0ETwwyeIIHE5O47ED8jEK8RbDsGtOsF1QithJZWZJ
	YDZUlrFQnw5uTEvRwrfk8LQRk4m88qTT6ZpZ8TGHYx+A0Tba8yjHCJBZ9VSgMgxirOgaK0s2vcf
	y27+K5ZZed+xBEPzGTdj/+vjT538wmZMlpiED/0LaTBmUdgi7LMNscA+f91OphWdMECoyujDZkQ
	XR1b6h5BX6Ts0N+NAfthlsErooNOWlNFJjRmV1fuLEV7JO28KH5yFgjqarU7W2VgsY/Exv3x1SB
	e+T/zyewr1Ayoh33BqMjf62CUCxdW6r0FbkTRh5PsbDLUSb/7EPCv4i9lW8jT/+vM2eVQ2fnhqN
	ou3x7m0kCxi+gXfAnnM3wtf494KrN6lVxvPwrFeYuB8x/SVldA4cx1RgsMEThzEKzqnOPBpsy2r
	56o+6YPMMbR5h812S58jaN+z4VD6Jc4RmVnY1JJ4dq8XxWUmiU/tDC0dHJqASDKUuwQb2afyBi3
	56pg5+SgCR6gGQeFIo3iTu9vOA+ENgeEFCg==
X-Received: by 2002:a05:6a00:4c15:b0:89d:e6e2:b2a6 with SMTP id d2e1a72fcca58-8a9bd4e6f67mr10982582b3a.45.1793752174633;
        Tue, 03 Nov 2026 16:29:34 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7cbe56sm180227b3a.10.2026.11.03.16.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:29:34 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:29:33 +0000
Message-Id: <DMM02SF04UK0.3RQNDSDPR2SGW@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an
 egress redirect before each send
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179374188061.488855.10389706003415159913@kernel.org>
References: <20261102072112.4160195-8-alexei.starovoitov@gmail.com> <179374188061.488855.10389706003415159913@kernel.org>
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

On Tue, Nov 03, 2026 at 01:38 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
> This isn't a bug introduced by this patch, but the comment mentions
> unaccepted children as redirect targets. Can tcp_bpf_push_locked() hold
> the lock of such a child while the listener tears it down?

yeah. It's an old bug, not from this patch, and not only in sockmap.
inet_csk_listen_stop() takes only the BH lock of the child.
tcp_abort() calls lock_sock() on such a child too. See
commit dbd62ad55a4c ("tcp: avoid double destroy in tcp_abort() of an
unaccepted child").

> After that, the retry check here returns -EPIPE. So the window exists only
> at this commit, or in a backport that takes this patch without the next
> one.
>
> Could the series be reordered so that fix lands first?

No need. The window is there without this patch too.
This patch doesn't add it, and patch 8 closes it.
Both patches have Fixes: 4f738adba30a.

> This is a pre-existing issue, but it is related to the sleep above. Is a
> redirect sender that sleeps in sk_stream_wait_memory() on the target woken
> at all when the target's owner closes it?

It isn't. It's an old bug, not from this patch.
The sleep is interruptible. A signal or SO_SNDTIMEO of the target ends it.
