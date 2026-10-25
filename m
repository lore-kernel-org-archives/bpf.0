Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792889846;
	b=SbTnuv8qPYt/hfOyQQpTmCASD6NZzfje4upnpsauEBvteaw38UslB5HvtxPnKv2ZPsDb
	 uXKlggFX6lZP3YBwvRNafeu80xDR7mKEU0m9qKFFwkv+n4Zu7M2avwlbZTuTuBb8MWZa+
	 JKOXFfejS8kcp0Xw1y/RShr6yk1+JBYwpfz455414uu6JbimpwiDTqcBO78JqpFTffsaZ
	 FpQD6w85O2YKhJYnybTm3lBU5QAyYN1jAPeBeSxmEF5udevyS3l5YZ6gFkTNMJwPGD4i4
	 PhNCqKPuYMVc1kdqhAqxVVHPs4a8N+zGGMzKuJ7WcHfrrGYRQHmv/Jz95MxDVacvh4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792889846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=pDZtqYShA9M719qMGZwkbAW0j/mSC/jo/m1vw8SlLFI=;
	b=N2uIO1gw2qSDZNLsVXtVZitmNouAcNJfvI+PWIfmZbVsaLqmYMO+rhZ1EhH/d/H9j8TU
	 NI7HTUg6K3zozkSXuqa3YwCxfy7tPk5EUSPuI+f3FXdRCA/+c5R4rtufWZhEcoZvIPpic
	 PG0U6mVAKOSOwl6CZUFAB/LuQR0fkP+pYeRPgedgdle9qEAcsTIV+MmrT+bztguqJU67T
	 pU1QucH/em3em6I5rksbWx8d74iMJO9s5GwMrpus3WKw66leO11OfStQn4MMT0SsCMqH3
	 hUZQ9zj1dWGr1zEW98/2M0xs8UE8b4zwHcqhFEXrqyzZaThK4cYhxfrEDU+4/B1CZwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="qKsNu/69";
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D2606A31A
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 00:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 136D2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qKsNu/69
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1641557a91.0
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 17:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792889844; x=1793494644; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pDZtqYShA9M719qMGZwkbAW0j/mSC/jo/m1vw8SlLFI=;
        b=qKsNu/6948Hunxjb+ZiPcCoy8vD07ngMxyBeqYhcVGd0kSBlIWIr0A+QkJfC/3XKff
         Nim4mZCvYuRrO1ToKilZoYqvzekm0+zxxszmXCjZzJs+AF54HB9pMmXfNL8GnPdCm+d5
         H5WCH7qEkEXTfH7I8wo6m4eDd4DLloyaaZB/QSV7nZuBZHkxhjmxApW+Dg26xP/s+umN
         NxdWtARZ4S7KlqqoPMTrXgxGhNXqPaR+4JQsVdIzZsmLeZEIPFvGPnquJ9W9hfJNH/ue
         TjPS7NFLMMBVkQ0cLgFP+0KfjGyaYdC+JWWvp4Kf6c/uuZUiOB6OogkvX8bwgxlUs2Fl
         WGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792889844; x=1793494644;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pDZtqYShA9M719qMGZwkbAW0j/mSC/jo/m1vw8SlLFI=;
        b=GSi/77W5zHyxwMPWkvNTtX10LENzg1/QmzfFMMg9du11vspy/DLE01PpnxdOy1sXeF
         U3fhVw03XwWtw+zpKgI65cASXmWoU13HbkJ2SV7oFipkG7dcX2ztTy27IWFIgjJurJ2d
         poeZ/lk9a8VlcbcHGA0OFKXmJ/WWnEXTRixh+FpShxGj73qPZzh8/3XsxQcKPqRCNYYs
         aGS3O9jMYPn1Wk9L5DHiTCdMlSYXw3k/EATtfzHs7DuCNUDQsa8rVE2varfXPcxwIiFs
         8qunynbZvBvsqGDrqgLEgnDvHF89IqP1+w5zRKZahHbfQ5JiQ/ujnsdiMQUmRIyFHBK0
         w8eA==
X-Forwarded-Encrypted: i=1; AKwUvBzY9sxJkmnfT+pJY4D1N+wrDJIdScl/PSoUOQmvwLK1/Lba+rjMZYcmSzvXrSX8F74mUnU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkpbfCmCVermLVycnEGW5FUpFvnOnH+c1TJLTyAZGrlH0dSJHb
	GzvP2zSjRc1OjX/GtaXgI2nHcQcE4mBTmWIcM/ubvNmp6V4XVQlcWUHz
X-Gm-Gg: AYBFou3JoqUzQrFbEVNiUtEun58JLHHPDis6qkTjoZfOYtNyNzRArBdGsyYji5W+8nL
	Lr8OPYH1ceXayotx0hDjtnfc/6Tc+tZ5KSEUBJl6LzbAHa2KFbvo8ib9UyAqM5DAr4ZG6XoLnMI
	oFUSRuVD3TG3u8y4wrDQMDhVVgYdD+jK6vfYjFLm+7dfxVh75dPFkLZAXUDX58v5GVvTE5EJEuP
	4OuZDNk/lsD4LBk/jpG55aCsVRLxDZdvDir3TOCSFaxtk7S+5krxhw0L6kCDALz4dsZObtvkDSM
	2aRJWhIC2P/Rg0/tezRWJBb1Tmj3Sixg3scPLp5N2++qydoIcvUBIuOmu7u9NBzVQD1IjoGsT0R
	6LdnKCicJIviww7MyFrFWC9wmJUAv4ugad0ol3VsDyvKxubHm7J1nD4ob3ArnuNPjF/rluP6WYq
	ygNhIrE8QnqXQwFF87ERr/oaYnmqpWCurZx6+fXd7pC/amh/bOGYahvKAg4M3GrCG7o6WTizqOg
	lKimhVMm7unQdsIVOV/HAUi7NTObSD+njItD85grZhI2J5S+4G7aPbuahAWXh8U9LnfTtM8Ki5Y
	+ahIlLNiDfooFTqryw421E1dlvjbGKO0iLm0fm9OA6By+ik2gMZrk2yGy7WjMw==
X-Received: by 2002:a17:90a:dfcb:b0:3a8:c0cd:57fb with SMTP id 98e67ed59e1d1-3adeae7763bmr2959846a91.42.1792889844176;
        Sat, 24 Oct 2026 17:57:24 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adec0bcb0asm3951459a91.17.2026.10.24.17.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 17:57:23 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Oct 2026 00:57:22 +0000
Message-Id: <DMDIENB8G58I.3IFV81HSBAA8H@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Daniel Rosenberg" <drosen@google.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf 1/3] bpf: Fix bpf_xdp_copy_buf() when the buffer
 overlaps the packet
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ayushman Rout" <ayushmanrout27@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261024092659.76422-2-ayushmanrout27@gmail.com>
References: <20261024092659.76422-1-ayushmanrout27@gmail.com> <20261024092659.76422-2-ayushmanrout27@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Sat, Oct 24, 2026 at 02:26 AM Ayushman Rout <ayushmanrout27@gmail.com> wrote:
> +	for (pass = 0; pass < 2; pass++) {

[...]

> +				bool self = orig >= ptr_buf && orig < ptr_buf + ptr_len;
> +				bool turn = pass == flush;
> +
> +				if (self == turn) {

This is too clever for what it fixes.
Every load, store and bpf_xdp_output() that crosses into a frag now
walks the frags twice, to look for a buf that is on the stack, in a map
or in the perf buffer.

memmove() in bpf_xdp_load_bytes() and bpf_xdp_store_bytes() was a one
liner. This is not.
bpf_dynptr_copy() is there to move bytes within a packet, and it's the
only realistic way to get here with a slice: when one range fits into
a segment and the other one doesn't, it passes the slice of the first
as a buffer to __bpf_dynptr_read() or __bpf_dynptr_write().
With patch 2 the chunk loop copes with any overlap. Use it for every
copy within one packet and leave bpf_xdp_copy_buf() alone.
bpf_dynptr_read() and bpf_dynptr_write() with a slice as a buffer and
a range that crosses into a frag stay as they are. I don't think anyone
needs that.
The read and write tests of patch 3 become bpf_dynptr_copy() tests
where only one of the ranges crosses into frag0.
Something like this instead of patches 1 and 2 (compile tested only):

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1..b74c036 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3291,8 +3291,10 @@ __bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 dst_off,
 {
 	const struct bpf_dynptr_kern *dst = (struct bpf_dynptr_kern *)dst_ptr;
 	const struct bpf_dynptr_kern *src = (struct bpf_dynptr_kern *)src_ptr;
+	bool same = src->data == dst->data;
 	void *src_slice, *dst_slice;
 	char buf[256];
+	bool rev;
 	u64 off;

 	src_slice = bpf_dynptr_slice(src_ptr, src_off, NULL, size);
@@ -3303,25 +3305,31 @@ __bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 dst_off,
 		return 0;
 	}

-	if (src_slice)
+	/* The other range is copied piece by piece. A slice of the same packet
+	 * may overlap with it, so it cannot be the buffer for that.
+	 */
+	if (src_slice && !same)
 		return __bpf_dynptr_write(dst, dst_off, src_slice, size, 0);

-	if (dst_slice)
+	if (dst_slice && !same)
 		return __bpf_dynptr_read(dst_slice, size, src, src_off, 0);

 	if (bpf_dynptr_check_off_len(dst, dst_off, size) ||
 	    bpf_dynptr_check_off_len(src, src_off, size))
 		return -E2BIG;

+	/* like memmove(): from the end if the destination is above the source */
+	rev = same && dst->offset + dst_off > src->offset + src_off;
 	off = 0;
 	while (off < size) {
 		u64 chunk_sz = min_t(u64, sizeof(buf), size - off);
+		u64 pos = rev ? size - off - chunk_sz : off;
 		int err;

-		err = __bpf_dynptr_read(buf, chunk_sz, src, src_off + off, 0);
+		err = __bpf_dynptr_read(buf, chunk_sz, src, src_off + pos, 0);
 		if (err)
 			return err;
-		err = __bpf_dynptr_write(dst, dst_off + off, buf, chunk_sz, 0);
+		err = __bpf_dynptr_write(dst, dst_off + pos, buf, chunk_sz, 0);
 		if (err)
 			return err;


pw-bot: cr
