Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681624;
	b=gPFUbJA2cZcN4rsl9hbjKkdwa0umyHhbaTv9CZkO4cYCDAJPBKWXLnKHbBmsg6w60QB5
	 ukrFH4/w24o5pdRdvIRWU8rW9oCAAsckICqXTHn+IP5VizfIFTaNRVWy/qISXS5Y/cLKx
	 M42fxnl2/0ojHHsvZg7jIygDid32ihr5wsfNigB40WE8XSBHkKoyYCcbhECZq/o7E8g20
	 3Y+evQkuQPqUNJ/Bb4sgwEMdKv/mwgDOQnXn5GXduJbcgOqipJBgZZtuZvjo/TmrfaUUY
	 IbRsUZRbiFlP+0XHXtfqosPNfhPZUjQZLjg06cwUstkHArDQylGEESMBrAB+CbJblyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=RDeoDvuqMX5CXuZ8DatSTgljbUzCp6t2qFD5+t+XaFE=;
	b=TEMNzQgvHKQrBC6fa+DnuLhR9CI2hjUJ4j3kSATn+IfOQFz3Tc5uY3pJMDB1JkQZTGtX
	 VY17mBLzjrZk173MfgClkAUUtrA0mlydvWS4kgzUW4aLCRytSWZ5WOKy0gKbZStG/n93f
	 TLLjx+xwP3y/sjpjF+NcbyRJ0d7LkYBYc5hBa3E5A4Ocly91cBS8xWV56RSIiNxFUQ/s0
	 7G+kco8lIGX+3rsE4HOarpyfvP7FTgWafhWx7eVha4+0TIHKTckKt9qHLV5KESnINTCQS
	 MM9osBJA9OVy0xoa9/+v6n17+bLtcfoi8tHElruvWRG1Pid3r9Tg/TreMZTqoO2ZFdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OKQvH0XB;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98277606A337
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 18:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98277606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OKQvH0XB
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so1015371b3a.3
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 10:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794681623; x=1795286423; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RDeoDvuqMX5CXuZ8DatSTgljbUzCp6t2qFD5+t+XaFE=;
        b=OKQvH0XBu++VojD/u+INoAqGc3Ax0Cm7sYdvZeGr3L8gqCisEOw5EBV3aKep+umVWn
         an/nnKbxKy6DYbjRYvgu/fZ2SPbcgI9KPEl1Trd1mckq3R53F/E6Eaq3wvQbeeuu9l0M
         0r3nMj/ruEGEiipnr4mvv1s9NXN36nHgwxKsBDsYSprDn+XISlJ2s9UsbYlL1fZ36+YW
         A/Qnm1iUNoYEqgY3KOs/GSb9tQtZyGLrV2AnfoR1Y7B/pv/QjEJyAnpnTilMgTc+fpPP
         l+S5oKVA1wky3qlKOje4o9/IM6XIqLEcmeKmB1OmFo+lhyEmEARsV93Mfdv+LzfBQJk1
         QToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794681623; x=1795286423;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDeoDvuqMX5CXuZ8DatSTgljbUzCp6t2qFD5+t+XaFE=;
        b=mu8kIGwBD5TqtTgVEX1qrgYY2ywu5cBTAz5JqUrij0R0D/xbPQb1gjBoPOTF1UO7Ho
         9ToGEFiiZ6qu8ZDi+SruhfIImxZl0MlQ04r2S3n+ogJHkRSz2cmnFHe6b4sTkDsmjPI0
         YCk4uFJ6Xqyi02qJAuDbNVQDpVDd3hpNARcL+54Q//27SUTD1B44ICo7UrVD2vhUQusm
         3aVUYZ7J3LBHe0KHs+PyDCneRNlNOvmYBWCbpbFSZ4qYLyoO4xSa82802+kSXkzME24Q
         qk1mQRwliNdp6WYYi2UbDs/9rL3VEWgf+WS9VpCjxAmEyVXbAYThNXW2yQNfD0QtYD99
         AZ0A==
X-Forwarded-Encrypted: i=1; AL+hErGaTOCT/za4YwmZCr6GFs4Q3tuy1qEWgfU9S9EXsRjIC4LjuLdRpsuqJhEunH68few0ODI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9W6SbBMatfQyJWi9Lkp9JFAUlTh5Yi9oxThraWoC61ix7/qx3M
	1pcikqwmnGJ52xTEEmHt50vF77pAWxzJdSL2TCGbRIaxclAkxQ3Ku7CC
X-Gm-Gg: AYBFou0yUqC47ME6fgV7OFVJFdTJoFlM5QmI5S6ThFlegb3rIRVgIZ4R4kZj1ReozjI
	Xl5Wpxd2E3IKgE6gInkmusxoqoZAXxyC+w19GtZ0eWWGrPfaIR9BhonPW0eqUCCNcqDdZShTgMn
	WqWCbToNfMSk7+HDhkU8BMS90eCfsy2KrGw07Zj9FcOv0c5nfXXethMdV7ThzYB9bjtVSB1sbMH
	439v6snUplCRQTNvQvoQH7C3ZzE1Wvlkht1D6x61oONcWYwIchb+99RREm8NdfojyA3fTg8BxoW
	gm/ZzqMolGdl6eusrbTq8usDs6Mf38OJXedC8uVM27GZ82raK5u3QJ9/L+q66nctaucKcay19BZ
	HQRcz1lgXMMCeXwVQOshj8rXNgelF5IgQX+7xA4p6RXpzWtktKTTur6IIoSxDp7kOXQ5N4+0nW7
	DUOd/8eaj795KKuWZqECDf/wEq7KEQpH5KCETDvwIt/KXig9drzNSYZE/MPN5m/dG0pV+EwliOu
	gz5StUt1m4EfqmRGLxuUdxS59ZA4l/o8QJEMnCKtcTICfnelPruhmsa8O1ux7fQia29GtjKxNjv
	wRuC4XhzK3NWYIUUTB9LfBaw0lM+iBPVwZCszu7IuTOAppZT0euzXPrplXERrI8ing6ndTGWIfB
	ajAIRdkaLUzm7i+MOyV4RlTL7tslZgrZpILI=
X-Received: by 2002:a05:6a00:2346:b0:89f:ed3b:df97 with SMTP id d2e1a72fcca58-8beb7150117mr5498543b3a.51.1794681622656;
        Sat, 14 Nov 2026 10:40:22 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed263649esm2256214b3a.45.2026.11.14.10.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 10:40:21 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 18:40:20 +0000
Message-Id: <DMV5JEF4P0Z8.3K0HQK7SWX2S@gmail.com>
Cc: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <andrew+netdev@lunn.ch>,
 <dsahern@kernel.org>, <idosch@nvidia.com>, <ncardwell@google.com>,
 <kuniyu@google.com>, <richardbgobert@gmail.com>, <willemb@google.com>,
 <ecree.xilinx@gmail.com>, <linux-net-drivers@amd.com>, <saeedm@nvidia.com>,
 <tariqt@nvidia.com>, <mbloch@nvidia.com>, <leon@kernel.org>,
 <linux-rdma@vger.kernel.org>, <daniel@iogearbox.net>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <martin.lau@linux.dev>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>, <corbet@lwn.net>,
 <rdunlap@infradead.org>, <skhan@linuxfoundation.org>, <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 0/2] net: keep the TCP fixed-ID flags on the
 header they describe
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Julius Bairaktaris" <julius@bairaktaris.de>, <netdev@vger.kernel.org>
In-Reply-To: <cover.1794139176.git.julius@bairaktaris.de>
References: <cover.1794139176.git.julius@bairaktaris.de>
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

On Sat, Nov 14, 2026 at 10:27 AM Julius Bairaktaris <julius@bairaktaris.de> wrote:
> Patch 1 lets SKB_GSO_TCP_FIXEDID describe the innermost header again and
> replaces the inner flag with SKB_GSO_TCP_FIXEDID_OUTER, as Alexei
> suggested in review of v1. Patch 2 adds a selftest.

Thx. lgtm.
