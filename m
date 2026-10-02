Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E702F8BC3;
	Fri,  2 Oct 2026 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905554; cv=none; b=longzds7psQxA9o5suJjNl3AASvxcBhntT95txhHQY2W0pCHIR8ZKMV3CHXCAq47MMs6LVosBF2kVSPyJtu8ZJ/yzDe506rGMqlrwsIUG625I2vkMF3cauKpW9K5AjnXPE7BcwiqVs/k7BvXkQZDZ2YL6vcT8UqmvhhOBCY3Iwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905554; c=relaxed/simple;
	bh=8SexsDSeBvx3yEcROsN8o7Ee1kQOmA/geC55ijz7bdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAUilmIMknutYD+R8NdR67vMUjTLawR4APZe7s9pUjoYgyDQsgenID1MQ5TAkoc5O+dbntcm1qXs2L4VFWFBfKD2Q0BgQu43CPAGVEu2rVhD/AJKLY1uxfx36X+yXGeMm9uPAhPc4wzsfsOxnJtLbd8Ogg3KcLrGDJ+F6PSroiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBF+OsRF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBF+OsRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADDD1F000FF;
	Fri,  2 Oct 2026 01:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790905552;
	bh=8SexsDSeBvx3yEcROsN8o7Ee1kQOmA/geC55ijz7bdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YBF+OsRFua6RR5TjWTjFbFWZHDlHe6elY9A/7t0tu+YUixmbyMtpUX2+ZMvCUsW+1
	 4O580i32udHHAsW8N5UAk0yyC+dZ2abO1509tPa9+epsztrg565xudt/Z9kE3rGAva
	 r0BkCvKR8WgxwzfsUUwB4jiQvK7ZvuB2KRSNQWk1D4xJpg8Edz86OqqGPYUpHwYQKE
	 mWCBfB3RQ1+L4NPS12aqcu71Mz1dsuyy1JZGh2u/6RCoybSW5oJMYkP3qDoVzc/aXL
	 QsSG3gqZdLKDJR+lG53NojWrYKB4pvsZ1At/fYayPlHhPyRo3t/YB4dIhgBqJqj1kV
	 dwqgyiQjIMyaQ==
Date: Thu, 1 Oct 2026 18:45:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, Stanislav
 Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 00/15] Gated tracepoints for skb lifecycle
 (free+clone)
Message-ID: <20261001184551.314c7a0e@kernel.org>
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 13:40:17 +0200 Jakub Sitnicki wrote:
> Subject: [PATCH net-next 00/15] Gated tracepoints for skb lifecycle (free+clone)

is this expected not to build on top of net-next?
