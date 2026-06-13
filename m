Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF33F7AA9;
	Sat, 13 Jun 2026 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781371250; cv=none; b=TvXTH7ghog3SVS9M0iTmcqxA1uhWEixcq5GMwOP0Ou1G8UDgl521xsVh8PEFW9axHwlr8dZg1yeB3W0vFR85SNGz/fK1BVbM+B2o98KM/vNr+NhwBaJWMmA+17XBODT1UgutbpJNDOyxG8BcKVYWg2s1nb02By4DvQeMNd7E7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781371250; c=relaxed/simple;
	bh=hfk5YAAsiowp1e92uAcaKnJUV1q7hmOhlevtJ1ZDvWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5CDXy6fKTN7VuUG5RM5XGpQ5aXLyLdwMFWh/Ho9Dw7bAHGD1z5+sqhKbwWkDBxvE1Ixjt52xsSODN9tcamWQ7sY/a8VIbEwyMWAAwWxKYTi6hIF9wdN2SG0Pyn5N1aF8AH76rBqRJ1mWYg7SqRWLLv0UfHUEwXBGw5KwS6oGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEvW9C3t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEvW9C3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9681F00A3A;
	Sat, 13 Jun 2026 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781371248;
	bh=FoVaSKJSHc5duMbhcL5wvJ7B8xalCf3jU1lyZ6ND/SI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VEvW9C3tdLdhJJh/2/ibZxdf1mGm7heCaLMrwdHrIywbvu+dnV6V4u/nVczs/Wukd
	 u3ysLU0RmEkYOcuR59h8NK8pqaHsxwSXrngEYSn68PPEAymrCtvbx50bolSeYfJfs4
	 7omFPj/96fEDCpEeHeCHMFsHInUddFbB37DRzU77JAoNwr/BKKRha5I6qo+ShXNP8A
	 ifxdgfwBkuU4cwkjP+FwfEfHhhQoJkJxf/L/fi7rnaV/b/raNg4P+8+02lR0UW9Ga/
	 hpado6xpG1fd2m+xiGMWfmb5Mc2VvTZ0BATxs6+GikkZlsWpz471q4zNIt/gJ6iPb1
	 v0BMPg2l4pe3g==
Date: Sat, 13 Jun 2026 10:20:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Stanislav
 Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
 <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next/net 0/5] bpf: Support RX/TX HW timestamp
 proxy.
Message-ID: <20260613102041.55e3b50e@kernel.org>
In-Reply-To: <20260613010039.1362312-1-kuniyu@google.com>
References: <20260613010039.1362312-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 00:59:57 +0000 Kuniyuki Iwashima wrote:
> When standard socket applications are run on these hosts,
> a userspace proxy is required to mediate traffic between the
> hardware and the applications.
> 
>             +---------+                 +----------------------+
>             |  proxy  |                 |  socket application  |
>             +---------+                 +----------------------+
>               ^     ^                               ^
>   userspace   |     |                               |
>   -----------| |-----------------------------------------------
>              | |    |    +---------------------+    | skb
>              | |    `--->|  virtual interface  |<---'
>   kernel     | |   skb   +---------------------+
>   -----------| |-----------------------------------------------
>               |
>               v
>        +------------+
>        |  hardware  |
>        +------------+

The first patch looks kinda nonsensical but then I saw this diagram.
Looks like you're vibe coding an integration that makes it easier to
treat netdev as a slow path for a user networking stack.
Please tell me if I'm missing anything otherwise add my nack if you
repost.
