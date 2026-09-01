Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0C71F3B87;
	Tue,  1 Sep 2026 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788220964; cv=none; b=SyxwPtG8pyCp1gbIHXePNtwONnpyl5vlXXzuO+FT6+VLHLdK8Q487tZ2JU1tOeWgvr1Lxri1rFGFlbj7pn0xryquMPIlRrdmurMCLofqYHJEMRtAeWmLi1NHYOw9/An6y94cNMHYYmNIcODspyRk+JCZ7Jg+ailazlzIgcQpGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788220964; c=relaxed/simple;
	bh=1GtKzM6qFHLf7HmMqIjTxlSn1WlimaOcx44Jj0JLnb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jp1bEaa3oF76jWSp2nvE2oHdej9odXTJzCtYWKWUCGS8ybRFX+Qe4C9uxujViU2ou74+wD8FX1hhbCn3tIHQjWa6DqDJKQ6YwY+5dNhZN6s010S9meYoDQu0P6f+DWiwGJPQjInUTr/d/a2tN4EDOVQhqIou5cvE/Pd87FABnF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEg9Cb8A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEg9Cb8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8A71F000E9;
	Tue,  1 Sep 2026 00:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788220963;
	bh=YnzbNAseVqr204CF4Z+LlJ/iqoanfz70mhWy+yE/JjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AEg9Cb8AF36/9DSl9SXHjdq+05r0oEFQTFJTnpBR9Ako6QxDYdSxmBQIXoO1czHxn
	 rK5cW3p5x4p5Us5xICh0N/hOnXefRrk71H41PWZzp9r4FLO27X44MZeY9W/7PP6Rq3
	 WRtN0CJs3/xhKYiJ+UrZtj4tGjrPiAxuNsKUyjAoZdESUlv8JGpqFEWPp3x/vlqrFJ
	 vi/gHeFakNQ50oU586KPieC27ev2z/JAtSpVTbTFWiEtmoStAp6bz9g7hzRB6Yrx8R
	 weesyaGqf+t3qNkf+teL/CUjOkZNSHoOXB6bJG/SPH9Y0ayaAyZoOTcrXLqy2NXBCB
	 +lXsMLzCq1mVQ==
Date: Mon, 31 Aug 2026 17:02:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Subject: Re: [PATCH net] xsk: set network header on skb at generic transmit
Message-ID: <20260831170241.42be3376@kernel.org>
In-Reply-To: <20260826012052.51028-1-kerneljasonxing@gmail.com>
References: <20260826012052.51028-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 09:20:52 +0800 Jason Xing wrote:
> Fix this by calling skb_reset_network_header() in the common path to
> cover both the copy and the zerocopy cases, so that network_header
> points at skb->data and skb_network_offset() returns 0.

But you're setting it to start of the frame so most likely L2.
AF_PACKET seems to probe to find the true network header.
IDK. At the very least the commit message should be explaining
why the fix is right instead of the slop explaining the path
that triggers the crash.
-- 
pw-bot: cr
