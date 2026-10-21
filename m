Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601113;
	b=BjQ5p4rhVB3aXemAFJ/WpaMCV89GwheB9cnrqYEgySnuL8b/ASPZG2z+QY4hdZ4QDfYv
	 yYb7f4Zm67TZIQKynCetPSl/tNgPi8ZQR8fOgyRej7Oalh28APZ/Zh+h6sTvriTMaFETm
	 U04ohFJtQmGhaTwaY8IO9JjOBZ0I4UQ9KEmIe2ux0zx2GxAH2MEc4cJfRQZvYS/FmFQfE
	 lOj7594HAcN/7FBfPcZT7A4feJCAY38Vr4xKzhQSr0ISzgzN7L/VTwpMBakmvefjQU9SW
	 Kg7363E2gVy2BlioE8q+sRwy3r3Zmpl1vko6H2r2U0sMXoQuMr2G0kmTAA8WahA6hLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=Y299WPPaxWRE9ha0hJbAEz/L7is2XLFDnYowFbrmq1A=;
	b=evssgtFkKxfnYJs8fckrqcwpPi/P/W3jXM50pilDn2FjzZrupD9kG/sw3C4X7nX/qJxZ
	 lMJZmKMrmWQXyXzwqm0Vc/e0BLddbtIqj9sX/YeTSixZl91ffFzsEyuX31t1plvowX4v3
	 Av7EI+0fQZ0HVjrKEeartA1meHQlrikwzqdpr6g4+ZZVUc4aO4tLEC/ts2M3Eve3AZ4MK
	 /9UEHl2uNY2kQLMShdHWCTFfFWt5VJ7ZOS5ZpGEyjvFu5Vm8bf5V/U6b7zXcNUhmy+wh5
	 BeF3Yyjcr/KB2d+EzC7Y9f0CrRD3HJbUVn531sEEdbwGL7ys52GD0+O9HWt8kLnvxUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nMsOImcV;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890E606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0890E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nMsOImcV
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so521118a12.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792601112; x=1793205912; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y299WPPaxWRE9ha0hJbAEz/L7is2XLFDnYowFbrmq1A=;
        b=nMsOImcVkm/FZH/V0VjYQmpbt2YaIMt0P0dxfSN1jZ6h6rCtW5BuNgoERp+DqxUTeK
         W+y1TT8vcfcIem851lDwk5ixlioQhKsY4qlqP9HRAG/eaigUSRGZZRM0jjLYKlbu6mC7
         M843aU6fyX0neTfZUimBqUV1d7r+HTOx8ZnvbXphOsMblz0e+5aLp+7tf7hvs5VrjFRq
         4LA50+/PSvpFa4rN+8mADRHkfFuL9UMG0XRjJUpkxCz9JGYLd23ruh9jBpegPycYFugE
         XeqEvtNBYYb7ZnjoezBOTEQJOHKvnasTinHSYHr3GrApogq8luAek1jMLoGP4VLGQldm
         NW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601112; x=1793205912;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y299WPPaxWRE9ha0hJbAEz/L7is2XLFDnYowFbrmq1A=;
        b=IFJ/WCNrabZpVFz4wuMLBrKFZgQXt4kg1W4Ia9lWHs0Xwf0HIRoKohrN7P9YihNZJp
         71cCMaPWBxbVzKJCQu/m2lmnniUm49uYRYnFDVKg6xH+sPkU/8NIQnrw1imZ9FLQGsyY
         RPZuap8VVQpk/K+MnA4fC+tfskcACAoAxzOPq3pigR90857PK1cKe8O546Py777fG8v8
         /F5zPgkyUb1yl8RmuxY6xgQq1gSS7VQ0SlPe57QEUesryftIgsOMEYjI/9PhXwb0jxyk
         oevAHGgBMi4cD+09sQDqDbN2BUjtyLL+A+c2BLs3oS630pPjbPFDtvnC9LD38rd143HC
         ZvAw==
X-Forwarded-Encrypted: i=1; AKwUvBwqy+zu8furAJGdTkO2X5gz+zpFEAunBRrWQn0N1VZUgR2C8EuS36rrZ0EobESMYf5ozFA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTZXVauVQ71BVeNPRf64P01Yc0quHU18epHvFXKIJaccs1kJFp
	Vhm6Zky4p7s8SAXCVV8gSE5rF//adjXQu+GXaGO9WLeMTqsULiDEzuiR
X-Gm-Gg: AYBFou3jcrCBQONbh2mPrxZK7Tj0c1w9WBaZ5wXHOd1vx+bR6MnuJ55/3rLiGPONhQd
	g2tmSae6/uTry6M2PbSzya5h8NLeP9IYOHnRIYkVZtsA/0uj7uHLvgO6kp7rVcEbXQT/oJAfHXt
	vTvb9F2bsIbqfYw21bTd6Cf/PKmrN33Ybps9IJ3J7bec0Ru11FL0yIT7FBp2+/v7y3P79iM8kwq
	x39pPlxC9KH+UZIIZrdUAOLZvsCG6bcKYS0cjIBNnl2VwErwyPsYDhNqI/39MmywOtbjcr6eZXT
	XNylrEzP4sfgavYdnaPIVjTtpL9Lo4MUpAkFdLA/LFuMPLdeOY6Iw1Wke1pjB/rs3jAtRCwe36B
	jIiBi+SjeJi4UZNltP2mIPjTUq6PNhhWtEqjBOf/8YSGkhL9Z4eDNNu8+SvpZavZUH2ypdBNiIA
	grxQ4E/1pDNdy/YvrcbpY+jkZ2NSQ8t1Wit4wmkeIXhlEl8YTw0bcryddlcMPJATdw7NMyzEFqt
	F9wtSx1wcjMaFt+Bwy6DLGqSX5nYvAqB6uKgDMzaq5L8/7sih38RqtZ+02CNu6ZET6q8WzJKew4
	VoZ28d2QUvL0+7fe2iVwxzzjVJQYefEDO5Djy2jIsRJpqnZCiMIxQovfYVE7
X-Received: by 2002:a17:90b:17c5:b0:3ac:adce:60be with SMTP id 98e67ed59e1d1-3ad86f44ed6mr2508283a91.21.1792601112182;
        Wed, 21 Oct 2026 09:45:12 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b8645bf7sm265815a12.28.2026.10.21.09.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:45:11 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 16:45:10 +0000
Message-Id: <DMAO25C5MTPO.1PS8C0R1D0KP2@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, sockmap: use READ_ONCE/WRITE_ONCE for
 saved_data_ready in the verdict path
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Dudu Lu" <phx0fer@gmail.com>, <john.fastabend@gmail.com>,
 <jakub@cloudflare.com>, <jiayuan.chen@linux.dev>
In-Reply-To: <20261021155629.68813-1-phx0fer@gmail.com>
References: <20261021155629.68813-1-phx0fer@gmail.com>
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

On Wed, Oct 21, 2026 at 08:56 AM Dudu Lu <phx0fer@gmail.com> wrote:
> sk_psock_stop_strp() uses WRITE_ONCE for the same field.  sock_map_link()
> / sock_map_unref() touch the same psock from another CPU without the
> lock, so KCSAN reports the race:
>
>   BUG: KCSAN: data-race in sock_map_link / sock_map_unref
>   BUG: KCSAN: data-race in sk_psock_start_verdict / sock_map_unref

sashiko is right. KCSAN will print both with this patch applied.

pw-bot: cr
