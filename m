Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5C9405F7;
	Mon, 21 Sep 2026 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993870; cv=none; b=eP/wUuNrMPY8+oH5kKtsOBZc5hBp2sTgi+AuYLKdPhzIUxOKTjAC2OhMHSbHhlQKMpOUi3fkeOzY1XXL9Qvg4jSvQKG5UhmNvgp3bLvtdbM4iCld8lvsCNpArN8K3c8FsV5nUmkwbMMmL69tFgqnIlHYw3Cn04R33uhVnPzKiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993870; c=relaxed/simple;
	bh=2GSXX5XmH8VuwmtxYG7eRluM0wThRoGn/CwWDmJu8Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdvaHseb77uAn7In5N9mPx4am3wcn9guWhTSG74uiUcHE7TzqMIBuTj2Npg/LSqnR0G8tWHYRQ6N53ec1j4+iCrKwFiTvG5vx6ynXI0XGdVy/lfNtVsi9zCO2g240pP1OpqjAwNQsQTTo2mkYcivC6c+BfIKxMRlrwHZ0taYKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9TTRNCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9TTRNCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52811F000FF;
	Mon, 21 Sep 2026 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789993869;
	bh=uI0NeLBIOre8Pi8roeB/IqcCUiWO4vKdO4LKY/yER6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j9TTRNCks2amDA/ldheuyNJFjzhpNAlOe51gw6qoW+gdRu3aJMff3Oy9FPwlshCa1
	 69c2VJHRC3xFwSnTD5U503/odaMMqX1f4DUjF7vbajNXeLHn8gg+JnDUCdAXg4Wvzp
	 HqQNYlYyBq9gQ/jmwFeXoU9RyxVNMbKxZlZ8pwRmEINFEap0gM5JrWR4MXj72S7Dh8
	 l7LJwa2u7JQl/l6VteaAvk5hpFGJtiCjrSXK2QqS7WvcUIUNjBwl9xeztTmBL0Et/m
	 gHHlSc61qFwAuBy0j0KqeVu9DzqdCbr+WDiWlU+719ryRHH4TqcKt+0nCzjyXN4En8
	 77/Rm0AwOzTLA==
Date: Mon, 21 Sep 2026 13:31:04 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvneta: rely on napi_build_skb() in
 mvneta_swbm_build_skb()
Message-ID: <20260921123104.GM13925@horms.kernel.org>
References: <20260917-mvneta-napi-poll-v1-1-fb57604932d3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-mvneta-napi-poll-v1-1-fb57604932d3@oss.qualcomm.com>

On Thu, Sep 17, 2026 at 03:22:29PM +0200, Lorenzo Bianconi wrote:
> mvneta_swbm_build_skb() is only invoked from mvneta_poll(), the NAPI
> poll routine, so it always runs in NAPI context. Use napi_build_skb()
> instead of build_skb() to source the skb head from the per-CPU NAPI
> cache, avoiding a per-packet kmem_cache_alloc() of the skb head.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

