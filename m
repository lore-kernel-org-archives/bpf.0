Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68584B04AC;
	Tue, 18 Aug 2026 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787017075; cv=none; b=DaRHibaw2P483KOe+XPPw5zQMxaNuHer0utexLc2DXyDRDeqzAjKlWYyYofFlK0fg11EC+GKdlhm2mpJboGAQu6785Xr53RdLCC+yjHdV4MdBpIFjBdAsmBrBwcfkiAeEMxhWfxnVDwoHK+yd66O4qkGRnYFOyeqDrMM+hGx+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787017075; c=relaxed/simple;
	bh=68wEIrEc2mO8W/zLisk++aU4naC/wTungkYMr9fuw7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRwLpukxxtmEfUpriLTZBMbEZR/jnlIgiSQcOrrDgZZPsZ+kcpxWgmN3uEt2CbvbUW48YIIgGeyGaNc14QIEKQ+rxsC8zkVt5LPCV+htobeFsblNizAzxt35kIHsQaFlNoi+bKyLZ/74voR7qfiaQ0DpnAqDvHB7hiuiqQQeHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REuTGDCe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REuTGDCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E5A1F000E9;
	Tue, 18 Aug 2026 01:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017074;
	bh=O8PZv102x5nCjcErLYeZm5V143EPSrEVepgjz+xowFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=REuTGDCeqv1VrUlfdns446P7CvNGUQopElYoSkwAJnxDc1ukI8hN3NIgsz49shBDe
	 /qUjrz3I0fqQobgmM8tg7JtVWtja8aFvMZkxsEBohmCI2g2K8tk7d2iaQ+yt7e4AGj
	 YRNN9Jad9SB3G7GQQpNBGhnOhHQXnQM51xeQGz5nNralyFDwhKpAviyfRI1fVQuRr8
	 Z8NjHDQMFVsq1YxOjA4Tv2+3OlrERiZiFFG861VSyIuG5G/4ruMNExss5Nh36X8HCk
	 LeiNlWdaiFvfKdOUlEyUKYT1M9hC4Us1fLkyVfHyzKpzf6MZ0QcFiqBPchf2RLwMQb
	 b/8XhHHyzXMsw==
Date: Mon, 17 Aug 2026 18:37:53 -0700
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
Subject: Re: [PATCH net-next 00/14] skb extension for BPF metadata
Message-ID: <20260817183753.2c959dd8@kernel.org>
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 10:14:01 +0200 Jakub Sitnicki wrote:
> [I realize net-next closes soon. Posting only to collect more feedback.]
> 
> Please see the RFC cover letter for the overview [1].
> I will focus here just on the latest developments.

FWIW this looks fairly straightforward now. But since you're fine with
waiting until after the MW I'm not going to argue.. ;)
-- 
pw-bot: defer
