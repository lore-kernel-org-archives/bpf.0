Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794690308;
	b=iEiZn5TEzVD2IehwHrG9C5Ob9qduo8bm4Mr2+rdDM4LT0u1Om5oo2qNjOy2lDs/jDdNO
	 pe3aRDqKbfpg3Z8xh4VI70KC+VhHXV6lmEYs94gUTQBGBOmALrgY7/50db2Lu8Yx7pxd7
	 O4bhMuNwgRwykcueLX3WPIefyfl0KDvnP4cB3alddVtvFdDoMZ82oissglSU9JWNkT2w3
	 1VXeq2xhieZIsRM51HTrFccoqZJbXLW0jAhvh3xUnuKGMGbdsTfW6S7dExwQpTRxL+QfX
	 VYt3E7Ps7IwypfGB7WfseDQphIIzlNMumZALuRwRZzJZmo88jwHWV+M/UllQavn4BOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794690308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=S6r9JliYuLkU6bNVnsHUex3XuU8S/UM2soCRpJowQjE=;
	b=iCOUJFO0IG44iOHoVkaHQjTVcafZ057kHvm6we0YGUy/AZ0SSa6JDm8N29asZAymz7U/
	 IAXaoi5vzjT9QgUZbvhVj5yWu6EJdWVK9+7bheaYx8Q7PZJ6ULs/ex2OJ7nJsMXWCzJvH
	 t7JnYOboUo50KY22ysBYQwoJ/n6GROKR77v55htnmNI2/X9GpQQB9dSiw3CvqDNANe6si
	 WJvXjI7/FdRyAqiK3gVJbgFCyaOrk1/LCkIHTma+gv+oK6fRYE3nrJwF34m4MLfQnbeg7
	 8BWuC4lXTtcs+cKYNOghJtoDP8Cb1k1ep0X5Z30kSzXYdSex0otuxUiC7XL0Shx5aRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Fb5v+9t5;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F532606A329
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 21:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F532606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Fb5v+9t5
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b70880c0a4so2782850a12.2
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 13:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794690307; x=1795295107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S6r9JliYuLkU6bNVnsHUex3XuU8S/UM2soCRpJowQjE=;
        b=Fb5v+9t5HQpH99lBDL6eSyXCd561d6T4RIG3tul3obk+hV+lLvqwx2E/a53VBrruzj
         C7QdCNRUNH/J3utrvpe2c/geGqZ5Sl8S8ROXMNSnD6HIxac1Ng+Ry9w9h6KKx9WqPGRk
         nL5/soLI9m/NrOZQjEKC8IeWYL9z0hSTP62ueEx8glDPxYjodiB5UKN/us3YZ/pjLuiy
         jR7DawCFm/DODgpczCGYTo42aYB6PExJBlNnAUTnFQ1VK90sXBu/fB3nC7A4lv4SEGbL
         FCfXgTsCZXAhHYy7HOtrxslAD9W2+jbfWDGJdsvIuv9xo7so5tZou4C9uFbhXQelwj4a
         ryLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794690307; x=1795295107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S6r9JliYuLkU6bNVnsHUex3XuU8S/UM2soCRpJowQjE=;
        b=LBMlx0dqBCUJgg0OTNyyph9Wb8Rx0wGOw5K3q/OlgHI5AGRVv1NHGFuOZfyAI6kb1r
         zKEd3LGM0Ho5mLsxK6G7Bs4Fvf/BF+6B9cy8NpoROEit//jf5VuSU4JokTj7k82glMX3
         yIMlXckF9euvGEGQzQEjiTh7eKEyViEY3lziWYQRTs4tjJYMAJqk8dhLBQwB89czFvZS
         6cJRgC338nvbjsoKKtqu9Y7KkOj1NxWiUzCQUt7xmDmvVJrmdqfW9gmiM9YDUdPG98lb
         Ho2riEkpnkrqYfPTtijvqyCI2g/9Fs2K4pZEL4iJVHW7NKlEZEfvEL6D6cww2uDzKjrJ
         ASHw==
X-Forwarded-Encrypted: i=1; AL+hErE8EdkaXO9s0t1lHS9W9EuBMaaGUbP6vZklb6lkh0L2fzwMYM4BNPFrNgmlmCx8IrONlP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZxFqnpmE1dnTNcRPnLK0TjI7G3W/g4s/lK6XtryjBgyT/wutn
	w3XwjRxdc4C8YhSdBQ7WOrsUavdZ6AvGeHa9cIzLXm1o+eG9i6DKObhkmlQwJPAiPg==
X-Gm-Gg: AYBFou3ZOPBF7wXw0AIpZ8B3V9ybTlocO0YC/9hKNk1m+dkhjH8fhSPrW6j28IKZ+JT
	LNxlSs5yDW8CeQFCW1GEoMDdtKhIpJRYGoUr54vzQTbk6sSpD8R7nR6aJAbPVz6f+frB53PsMIe
	w3tjiCGFQkDzS08ntA9AJ3eIKTX1X0tEzU0G9iPagKU0QV7EsvI2HoZCq/QsDS9umIPTkPt0liF
	J3ZtHNDtRw0q/utz2Nf1Us4QZ71sx8NCoX05prz5JTs4Kv5lawKJsWT7/32aKoARtWHOjqaSZsS
	XXqX/fNDxgOjeMb3+YenS+y0dTTpRYW8MwP10yy/wfFgXcJH9djINaQTb+zfQ7tO8yWgMmi2Y8k
	LAQFUxxAaM7wqaHkx9krW4QrzjvgkjMYu9Tvx+ialYjKVRKER8zw+p+QBO1upL176CUAxBbLoNC
	TL0VAcVyfi0Lk9rbrs5IafyK0XvuhLW2VY5dw0ZgZUQGJwOiaq/Xypi1UO4/+02OOqze+GEsr5d
	C6JUNQGMsziIfcxjxAVNuZ275l2lVrB+W+l+OzXfGR2uvJf/JdoBX14eIodh3CZPZdLV935Hpu3
	jxWzqwF3BSntay7jUQy/56cveA4DT/q51gEHtm6/P0kwLauvfXNymQfinWrwbSwRyYdKcosPnwS
	wedDKovr8g5d7aAV5PutDh3zWRtv+lSU0aqKqyVGAZ2Zd0cbDDDVh81fv+qJleIZsB6IjLw9RIA
	PIbbD12wWqCHbwrHE4FTpo18K8psmaCL2R/2v0kD6PrEeQ0lM1F8QN3+XLtOHPTen1Q/33lICGi
	y6ynEsFJpO968K4/zKi3gX6TilqO8PKMW3gnOyAoD6//WdcdZxkA1DNBarWRahuAbUuN3bejMCh
	fvNwYnUrQ5J+Pd8fI6siw++L
X-Received: by 2002:a05:6402:42c7:b0:6b7:eda4:e136 with SMTP id 4fb4d7f45d1cf-6b7eda4e281mr1321653a12.41.1794690306618;
        Sat, 14 Nov 2026 13:05:06 -0800 (PST)
Received: from Desktop.fritz.box ([185.181.130.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c2361280sm2705836a12.10.2026.11.14.13.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 13:05:05 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	kuniyu@google.com,
	richardbgobert@gmail.com,
	willemb@google.com,
	ecree.xilinx@gmail.com,
	linux-net-drivers@amd.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	corbet@lwn.net,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net: keep the TCP fixed-ID flags on the header they describe
Date: Sat, 14 Nov 2026 22:05:02 +0100
Message-ID: <20261114210502.787195-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179468119953.2168702.10813567320493574993@kernel.org>
References: <cover.1794139176.git.julius@bairaktaris.de> <179468119953.2168702.10813567320493574993@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 14 Nov 2026 18:33:19 +0000, netdev-bot+sinfo@kernel.org wrote:
> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.

Reported by the hosted Sashiko AI review of v2 2/3 of my "ipmr: forward
GSO multicast packets" series:
https://lore.kernel.org/netdev/179182559332.434549.18294510093742639467@kernel.org/
I then reproduced it with the selftest in patch 2: on net, 6 of its 18
cases fail in 2 of 2 runs.

Julius
