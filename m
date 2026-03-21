Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269442D9EE4;
	Sat, 21 Mar 2026 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774058148; cv=none; b=A+pt4ovw5wJLXIDFmevNB+/Xk5VmtgRWIKsAUTPusfTQ3Z19Drrk/sNp1qgmVhLRP7AsNR4Ihn0IpBCk0X0wBkammIq1LS18p35W3E5YBsdvAfHFzoqErJYppkdwwdAoXL8dfqGCuVN5kzmFRTEL7S/VQsniV4XlxCeXinMTVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774058148; c=relaxed/simple;
	bh=cM0+ZgGX5vHD0oyQhJd2/sky+2UeAoWWiS8NB0ZOkmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtJRBaWG4B33BIF/LwML/nLQ94dWCgL9784Qfwr7sfjFH0R5P4E1mJfoUp9ihSCrfL68zRb5z7LFCmAguk1BxVUGwxD0TRrhU0aWDASoeMTI6Jv63QcgGbytaq5xn3trLQ9LZcOTXYtA0YCfIUpdgkOLqVoyiLDH6PCxMiSgYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jggL2d/X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jggL2d/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06456C4CEF7;
	Sat, 21 Mar 2026 01:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774058147;
	bh=cM0+ZgGX5vHD0oyQhJd2/sky+2UeAoWWiS8NB0ZOkmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jggL2d/XiLMB9rUS624D3kAEu7HyRIQK54hnCK4xLvYaEo5iY4K+gQ08sFYOlOPW/
	 sqRhwCC+C+Q7xAzf/ssNoSxuYxAcISn6DJkpvF8wmjGZRBvI+zgMNhf+SSSOQ9Mocf
	 cevwlglhPDqR2Z/Karykdkd/tfttGlPxVnXvnJTwqUwIQtLkG7/BycIlqrh+lck+4f
	 7dghxXI+QXxcsABhrmGueqWi4sDcsyz6hbuRYsamY9MRYSHxrol3KxzEyBHMLww08g
	 n+l85s8Fmssg4YG7EMUtEUlscIcet0UfTSB0EspbD5JM/O96qkfGS6CSKxqXfCAsvg
	 R1fsgAnVW7a7w==
Date: Fri, 20 Mar 2026 18:55:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Jordan Rhee
 <jordanrhee@google.com>
Subject: Re: [PATCH net-next v2] gve: add XDP metadata support for DQ RDA
Message-ID: <20260320185546.6f7e95c0@kernel.org>
In-Reply-To: <20260318192450.3400774-1-joshwash@google.com>
References: <20260318192450.3400774-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 12:24:50 -0700 Joshua Washington wrote:
> Commit 1b42e07af1ee ("gve: Add Rx HWTS metadata to AF_XDP ZC mode")
> exposes support for the XDP RX timestamping metadata operation in the DQ
> RDA mode. While the operation works on its own, the intent was to enable
> XDP metadata support for the queue format as a whole along with it.
> Currently bfp_xdp_adjust_meta fails because meta_valid is set to false.

bfp -> bpf

> This change updates xdp_buff preparation to set meta_valid to true, so
> metadata can be fully used by XDP programs.
> 
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> index 7924dce719e2..48945b4b6766 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -877,7 +877,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
>  				 buf_state->page_info.page_address +
>  				 buf_state->page_info.page_offset,
>  				 buf_state->page_info.pad,
> -				 buf_len, false);
> +				 buf_len, true);
>  		gve_xdp.gve = priv;
>  		gve_xdp.compl_desc = compl_desc;
>  

AI says:

While this allows XDP programs to write custom metadata via
bpf_xdp_adjust_meta(), does the driver correctly propagate this metadata
to the SKB after XDP_PASS?

https://sashiko.dev/#/patchset/20260318192450.3400774-1-joshwash%40google.com
-- 
pw-bot: cr
