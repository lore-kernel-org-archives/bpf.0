Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7D11A6803;
	Tue, 16 Jun 2026 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574666; cv=none; b=OZlIWd6E85Y7oRXhJu7bwtdZKjQNBbDEjfbTglwdDiWpZBEwNXHV52vS9T3PQY6QBKdNyIG2j2TMnCzzT4aVfAfSNHu4hjlylaDqJHNCEfrLdXQ1Zyp8PV7t6ISQ+GqGZm8BSNp+3IvBJRUAZSw82nc0wFprjP34AylSJjAHVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574666; c=relaxed/simple;
	bh=InAN/+DXK/W8cGxVM14K0cOGH19NXi2V+PoPTxMMu+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JE0e4BqAuNgDHazTWiE25c61OiOXKaUKnoKAzX+H56Fd3eIFyHrpd+bm1ZxUxQ66g9E4LFeJNhzNfvwzgkYowTkjWBzGxJrj2sW7U5iqtaFgau85OcR33EUdTzNBazB1fFNszw5TRd31Z9uZFSwqZ1xt61YKCEig41DnSyciaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6GDSa8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6GDSa8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE041F000E9;
	Tue, 16 Jun 2026 01:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574664;
	bh=D+B8b6zPxSJYJnAx76A6cpDHQqIWvpo+XApfG3oadEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K6GDSa8KRhY1gMm3/n1ZAjAbzfA77wCPtlo0jpGzxHWcYOHj+NUBo9O+l5nfY357w
	 kQ+E5OeKqy0NKB/zPdTXarsRj89QO85Fz/JxpaBLXFZnXndD3v2m4s/ul+q36gALaf
	 t0KQeoWPX/TNYXaGvdoQO5poj/bM6j7BhSJkx3qEzJbmK+G3mYUzjgmO1Dt4F5GqoR
	 aWLwL3PBo0TGERjP+Zd1g2UtNPDK5tSu/Z1u1SK30zaWnkTu2IqtsLNbboEgp8nIgk
	 SwhUe3zF6ZsKiiQeLrpqq6qUU8zZSG2Tddy45ynI6NjLGXkiK4ZDN+0B523QWlS7JL
	 ubDpzJeRMq3Gg==
Date: Mon, 15 Jun 2026 18:51:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com, ncardwell@google.com
Cc: chia-yu.chang@nokia-bell-labs.com, jolsa@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, linux-kselftest@vger.kernel.org,
 memxor@gmail.com, shuah@kernel.org, martin.lau@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 horms@kernel.org, dsahern@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 stephen@networkplumber.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, kuniyu@google.com, ij@kernel.org,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
Subject: Re: [PATCH v2 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback for TCP Prague
Message-ID: <20260615185102.5e8de52d@kernel.org>
In-Reply-To: <20260614071756.239686-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260614071756.239686-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 09:17:56 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> This patch replaces existing min_tso_segs() with tso_segs() CC callbak
> for CC algorithm to provides explicit tso segment number of each data
> burst and overrides tcp_tso_autosize().
> 
> No functional change.

Eric, Neal, looks good?

The min rtt thing in tcp_tso_autosize() helps a bit but if the sender
gets congested for a longer stretch min_rtts on new connections are
high and we're back to sending small TSO, keeping the sender overloaded.
Which is to say - I _hope_ this also solves some of Meta's problems :)
