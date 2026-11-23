Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394761;
	b=hEypgSXFkFLUFJ5HET3DRUj0goJ6WT/AtO1hMIGy5hoP/ITaCg6AE7Bfu1K6whkTfSzJ
	 iRyA4+h84nGxn11jim021Dc3uz1hE4k7i7qk+ZoMwOnw2SEdxvuVsKnvq4VHJ/Wu8ikln
	 v8NghoE53dJ2bg6r1O6ekSfji1PT6sj7wGRB/yiCHoGGPdWBRdGIKo4FO4qpugmSygIg4
	 Y6K08pHzEpVrcQQ06TaEFrmosnCOxBo8brXroNpnSqz3yAe2Qo4n4FpMv+aKw9yw6S1J5
	 j0VDJInKIGJ42xBXfnTeGlbEyrnssFWWaUlEE5eTLOGfj3qQTPAsjgQHKlnc6MKf52w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=TlGQ+s1w0re2RtxBjjhAHjiKtshlusVceD/sHg+v24E=;
	b=AZCbZ9UQL0OTASP6Hk6qWPc0aI8kIIgqz5fCnIsGjxrkNRflb3UlEWlJNW7rBdmdjWfQ
	 ekxrtUGJo78h1yMqPRw7HrXSNHH5NiT1bmXrUmKynTXZaA3gNlI5jXF1rSHut77F1r1Mn
	 DSPLTvm5UR7/3hEBMFFgORpxXtAENauGOa4l7bOde0vFgIuDxDBW81ohjslFrCipr6dG1
	 dfZ8/OFBVzeNcxTbt7BnlrGRhLq1vZDuPVjyB1RjgZxg0zgA4/Hq74jbZz+ZYkk06/ugi
	 R0tQeIsZ3US79NqhCQDlTj0OoPd8fps+nFSZM4gPaSpDJgnX9wtte2/T5PDh4krSmmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xjQNwyU6;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF39606A327
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 00:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CF39606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xjQNwyU6
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f03920c4a0so16556285ad.3
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 16:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795394761; x=1795999561; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TlGQ+s1w0re2RtxBjjhAHjiKtshlusVceD/sHg+v24E=;
        b=xjQNwyU6MYR+Sv9DqBxkCsB1ojg0HIKyMipAx4s6KRT5IYdJvl+GnVSxTRanDwlO4b
         OjsHRhZlksxkgGyYo9uQR4xnsH9smwEzvZB0U0xWIc7WLxA20JEVyHvBNfOB3Q6RKyJl
         W3Omp6JWwiCVAkQ9a9ECTstSvDMsiW2opPGebxfCTT5SlPd+dIB1fYQxZJhDwkFAzhym
         zUVWh9jYqyhJ1lPaR/5BHmGuhw1iLZ2Ep7uY5F2lH9rP296aefHI8qNbvrd9S8rKbf0P
         oiX4dY0ljie0g+etEjHvsK3G0VGKqx3XN4ZOcK3unI0mprBibWrDrY0Vx0uR0JHB3rXt
         eoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795394761; x=1795999561;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TlGQ+s1w0re2RtxBjjhAHjiKtshlusVceD/sHg+v24E=;
        b=2oZ3jb9guE26Q0Lqq0NB2zjKqDXJ2n8XNJXWwrst+0Va3YGDOB1v55EHIb/OtzGIkC
         ngF0BCho3VQQO1SAuDRHlPgpx2OUR6kYYzuqhS1GxB8OrPGzqhwTuzzeRsrMHyDBztAI
         YyDEG3cC0K9jzPr3lPpl1Z0buKuVAEtRjsS0USWqbOS/DbofXv2oUQvYAxgx5e04Tl0y
         cVFOyfLIGUU1B6S4HaeZQw5827HP88WofxnxQozJhSrt3at4su11HUE8KiinsgeZlII+
         wlEFyIalIoF6wUJJTcaIOXGHMOMJIUP8k/76N8kC1nj4wi/0tkLnhLY4khfSR099HhRY
         qf0g==
X-Forwarded-Encrypted: i=1; AL+hErGWMqJJ0U22RP/wytsRjBJONRC6GJ+jG5dRvLtr2/VOrfkMDyQNeLNxe2TUjpcENPP6rfA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+StnNcseM3Q5+3gNZFaJTVS9x5y/wKcwCEIzvcpaNAlakucStK
	neGP/GPAWVHK10TH1ZWmqMbw3PqiHey9mqG2f8p41EYHEP9xbWw4qzGa
X-Gm-Gg: AZFdTZcdtLxALC6iUtrS1dUqKqXEiDp7t4MKqVG8jk9PXsV8PzRMWnYv0N43GyGmaEo
	EwKzfpxsnno7BVh7Ib4z/u11SOv0/k9f0RY/g/lv9ze7wit9Yo4uhnvx8McCrUPMlzqqHX5+24g
	U3W+TceLcQcKqsIXLZftn4oF+fKZBJ5EBJTU/rJAT/PAcgPKdfwOKAXF8qYLItAvCIrbx5v/s/h
	XFNuz2rWQv2HrQ9VcvCXuoi3kUHXkwIuN0tN84GlX91ED8PwdJIkTlupAIyzz0s3ntinxgxlAym
	UOWBtv41tNCC3s5vdVLyKtxBqBmEaydzD00Q4oJVDinpSHjhjxMhcEujliowOt1cR6SakgtEHs7
	D1F7seRlpDET49+hnpykVC7lh2C1CwythEr9ryoOGJLJEvKa91KAvxp5kEBGBT4FlmRkOyJx+sr
	R6c39A7Zazihv1OwTlgWUavhswF+fzBV+qzvFwVVtQYrbq735EsuVW/O54czbcsaMfO/h+r6hcd
	8Y28iuYyNhCbbzelXTCNiy6bVDsbVAU7QXYIasCPsxM7mHYIROUZTZqKY1JmFanBlc3PNYKsHmZ
	BXhsrOcYqyX2joVo2Ydv9ntX9fuw0y81+mY15Pez/k6dd+XmVT7L9EqeGvP6PBJizvRMJ1DixlT
	zqm6oJLUI8bO6igPbO8lC9iWaCVDu3fbDZsA=
X-Received: by 2002:a17:90b:1802:b0:3b1:64d3:f308 with SMTP id 98e67ed59e1d1-3b41c955a0bmr8991155a91.43.1795394760621;
        Sun, 22 Nov 2026 16:46:00 -0800 (PST)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad48786sm15174661a91.9.2026.11.22.16.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 16:46:00 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 00:45:59 +0000
Message-Id: <DN26BQ6CGT3J.2WZ83RCCF7HDD@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "Willem de Bruijn" <willemb@google.com>,
 "Neal Cardwell" <ncardwell@google.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 "Sechang Lim" <rhkrqnwk98@gmail.com>, "Mattia Meleleo"
 <mattia.meleleo@coralogix.com>, "Michal Luczaj" <mhal@rbox.co>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf 00/11] fix misc sockmap issues
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261121103222.88209-1-jiayuan.chen@linux.dev>
References: <20261121103222.88209-1-jiayuan.chen@linux.dev>
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

On Sat, Nov 21, 2026 at 02:30 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> This series fixes misc issues in sockmap. Most of them are old.

Jiayuan,
thanks for the follow up,
but the fixes are way too heavy. bots are correct.
The patches introduce more bugs than the fix.
Pls ask your bot to think of absolultely minimal fixes that do not
introduce new states.

pw-bot: cr
