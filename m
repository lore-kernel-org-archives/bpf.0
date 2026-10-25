Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792899824;
	b=mICWNClIGDvh21E2aOZwf7nybiwYaTqAPaYN5x2N6ZQe3ooVzC2i+c7M8UzxkRf+8bmk
	 4o+YaLy9iiqIzge55HoukJB2idXdvW+SgIajHlntZ+bQ9ntStEZjJAiroKZfHMPHOtKdn
	 htSF7y01h9Gngun6VwYJnvE2jnZJCzDFsfE5Ifl/2q2jlv2FnPjQsXC2/Iozs5VFGhjxU
	 pk48xCWnVM4JfCoT4ptB2akYwc/cnBMaeXL/a4wDSyrQk8GlwNuuqv9PO2m8Ng/Y5NsdF
	 p8LFUmEezDbFvK7Rrc4lFZw/6th9yKD+k5zL6VizbmJZuW5FjANwTLOz97bH2cj6tqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792899824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X5OzgRH/1V88QEQk/qEsTmnI1GvbJFJUj713/504BL8=;
	b=GSgoioKqHxI0zCvytSHLYQlck82ElNcALecabeAqBE9UPED/8ywoPmxqxQgGOMl/VGI3
	 cUNpxnEEPxufUShs4pVy+b6CRdwRdsBXhH/3gcPYu/mmmCUNXvdbMJ9Swzzz5tyuJxzYT
	 VUIJnjT9H6YQgb1KxmZVKVvsMm+aBfaY7aWaUKYIsRNYUspWxxjuAM2uVugMTviDiJRR7
	 7KYrKwF/ZlZXCRDwx3MuHE48ektvtflyI0aG+9oWxTjgEXporRcQwffbdQYn88mMWm/1l
	 lmVe6r+7naLpH4ltFxfmobmYxA56o7l4bmAwJIWeltE4SSiiyATR2rtolEN599wURsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N16Ofwvg;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0973606A31B
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 03:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0973606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N16Ofwvg
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3ad6011ecebso398559a91.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 20:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792899823; x=1793504623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X5OzgRH/1V88QEQk/qEsTmnI1GvbJFJUj713/504BL8=;
        b=N16OfwvgmmwPMQDqB+lHEvh+zA08Sn8PNtt5nWqyL4kj7TtV6iahTavuqONDGHEBo/
         RbSbWLe6FJVOTZLHiZQ0tDMURGZNbWXtKXDEae4HcuG2plbenNgJtSS2v6cdqU2WtUL9
         YYglL+PJCqLn5YnHaGVSlXt2KnAVwsCFXsftv+ms8kseuiFbCPnK789lW2sPaYYBKPBb
         gwXEL60ec6G5RrZxvpg5OvyrB/P/MYw1uybQcbtxl4Vl51pcgBMPsHtuYhwi2DAWgEJ+
         wt4qF2p3+n35tCoC7KB+/hjlGuuEURHSl+X7QhLGUYRbHduh095EC8e+aAq9BVn7lXFr
         3l/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792899823; x=1793504623;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X5OzgRH/1V88QEQk/qEsTmnI1GvbJFJUj713/504BL8=;
        b=eU35pOQRmsgkh8VWXB+yYaxOoEHilitMfDG4nUtBMTQjg//ECTJoIAvPOTve7VCehS
         o+GzucegKEHcd/DjWkIwKraFho+ZcwTeOeX0mUaLT5gVs6BUBYF0kUyRDPBOaEtl2uDU
         ppMw0tCa12OZnx3PRI6OkXwvgMFZFWGxs63Dg1VjclofcPrtXzeUwlQ2jR4XS+bmgRJZ
         V8wq7ni91O2ShpovrxyC0Qgb/GJY+4dz/qIxAevWuZvm7DiYEzB/f4kmn7Yap/BdpzgH
         1vNMpYXtP/IgI+dIEnXOsFf1E4hwzYUsE246kTEzeAV3czb/QBR48TrSTDPJsmj3pPED
         pdMg==
X-Forwarded-Encrypted: i=1; AKwUvBwMfpV+fQxRm4EW84BIdz5Tcuvl2e1TJoLPalXWMzeyU78PdxXoez4aROSC0NEWKwLMA/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcqjxmxZBTLym0rIFgA75PHaqQwzdRRmXDUIP6u3HXjHOt8v8u
	CwxEJWOclJFqsv6a8PZ0SsP7KjMy8meiJ0LhHIyZzXDuw/fKLnyN8XSz
X-Gm-Gg: AYBFou3eGxwBt/OcTcvfCWhbzlLg7OqxuJn6G7TA8q2Z/mKZVVONeFP5J5tMsjLfmmV
	NFcFugmqdHlsyleXWDf0l3DmipPAdxeS3NXaYjM8BzkH/oIEETzjs11y/qPZWDsjP93+H/RXLDh
	kd36y9v1vN16ybTbmIRVBoLE1KaDX9wY/TqSYtZhRYoC8vUur7vj8mYAiPStChJhqzIhydjXpe3
	gIPjItG/tTPdpOHDVfvu21LOe36Hgfq+ezfvNm4aF1HwbEsjX/mhjsGSlQ6IZTh/sz4VdozokGl
	n8FQJGFE0jkcDPR4DiV74tMljt64DERnmYI+jR2Jiq7UZYTgpc15tLqjvOfEowlfXusuEpN9BEf
	5iKblEJg6gP5H56NUJ4QOaxkjT1gfuzLCzbDWfrLwBEbQTzWZo1LovmcIGjcAj0hr0tqT0iniVN
	NDf0lt8MjZeDxEmszLxLTPOoxKmz6ACt1W9GM2fskMNflmGsAeEp1HlCH9SYkUeO+HnqmRKtpAF
	fmfYbjwlPz9INNSgBaBOR3Jt1pXEQXclwojNOnWSC/+PbsjTv7DKNBuejIz/qI35Q9Oo41ojXwp
	050wWEvzrg9uUI/VRqjuk5uH/UqGuY2bPBrXQHkuiQ==
X-Received: by 2002:a17:90b:2e8c:b0:3ac:c005:cf07 with SMTP id 98e67ed59e1d1-3adead4c1aemr3019182a91.42.1792899823172;
        Sat, 24 Oct 2026 20:43:43 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2000:332b:d93b:afb8:5ea6:9575])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebaca727sm4265968a91.3.2026.10.24.20.43.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 20:43:41 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Rongzheng Wang <testwrzwrz@gmail.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
Date: Sun, 25 Oct 2026 11:43:27 +0800
Message-Id: <20261025034327.95300-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAL+tcoBQHudeQC+B0J0mwqbh1CH82XQWfQrtyXqVMF3ybopr3w@mail.gmail.com>
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com> <20261024141157.59301-2-testwrzwrz@gmail.com> <CAL+tcoBQHudeQC+B0J0mwqbh1CH82XQWfQrtyXqVMF3ybopr3w@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jason,

Sorry for the noise. I posted v2 too quickly and incorrectly threaded it
under the v1 patch. I should have waited and replied to your review here
first. I will hold off on any further revision until this discussion settles.

You are right that I did not answer your questions directly. The cover letter
only summarizes the drop behavior:

> On a checksum failure the packet is now dropped after the descriptors have
> been consumed. Metadata validation makes this path unreachable in the
> current copy-mode implementation; keeping the defensive drop avoids a
> retry path for an skb that is no longer complete.

Let me expand on the two points you asked about.

Drop vs retry: in v2 the checksum is calculated after xskq_cons_release().
At that point the descriptors for the completed packet have already been
consumed, so returning an error and retrying the same skb is not safe. Drop
is intentional for this failure path.

skb_checksum_help() error cases: based on the current XDP_COPY path, I do not
see a reachable error. The skb is not GSO, the fragments are readable kernel
pages, the skb is not cloned or shared, and the metadata validation has
already checked the checksum range. If you think I missed an error case,
please point it out; otherwise I would keep the defensive drop.

I also applied your literal-else and unlikely suggestions, and split/reused
the selftest as 2/2.

Thanks,
Rongzheng
