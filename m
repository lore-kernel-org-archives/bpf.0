Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793500709;
	b=qlL7SWnJlfX8Ik1WmTtz4cwEC7x7NIMy7u+yu54VY1zYQ8Lz7O6LTZA2lL3yJv4HBOl0
	 YEk/s3d9F5yOh8LYbmNWlpjlOW9Ed4onFxPaU/cfuzGbuX6BgJLk38ygooG+8ZFCIkBcW
	 w1CgNSpQqAhk+2D28xhQZthNSZuTddQwaozakjVBlrfYzpsSpTdS6rkITMXa5IgUxpuKP
	 JPVtRCT/3I4o3oYTM8Csba3HAnrINC3qoEHuOqUrmBbiBc7MzX/5PJtgpeRl+KLTSXpE0
	 ajKyzvGhwLViOhkQXi0agl6cQshMSoqHe8U/xb+dYK6vU5NNMGdSqF6R9YHTwYVi1fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793500709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
	b=3/kdDZPkpFdKWHVk0f9NsFsQ0Bzto8EjQODk6cHyjK0/Ww8ZMwa7c/HzysOHAeKGk/St
	 GFyp5CbvX+wldyDqaDH9eIUea05Li8AXkRhYkkP/FC8rLa16g+a+QannTtXhlGzCANT0G
	 erR1mlZ72T4RhnhphGjz29zf+2ufHHMXvvN80WW60pi95K7CtNxNIec8agUls0hZK1qwh
	 Uwu3ykbF4BZ17wbB4KfgH/Tbt8J0zQWfo6FirxKCEZwlIF6aIkyuh+8WQgLST1uWw4SBm
	 90WUmyY9NZp9nviL4J51edRRxJKx7LaoLi3D8ibsEoDQdRwHKl7n6OeA03HfI7S6ckQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ez0Ef6Wk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4282606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 02:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4282606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ez0Ef6Wk
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be4fea434bso2449660e87.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 19:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793500707; cv=none;
        d=google.com; s=arc-20260327;
        b=FeixMZ9xp9gOdhNoZhu08UpfR2FlXZkAEQERuNCPscWvzlSBi19prfM9RwXNja8oPV
         sVAzNaKMUXnQhLjannyDg727JbgPXH7fcu8b+WxG6zhqCWDsfud46y4FKpTch+nXPjjR
         GcHRAs1Mi94mGPdhRoaj5VVLEWJIPebqHzS2kxnbzr9wHZreSOxI2LJkiBauH7k9qJLp
         P64OymE1RZGL8sfG6WwUaltdlXrywS4pJmohCpvKdOoH0tXTUnZrpBZMbOkkTu2uUJNn
         x6qHNba86fjF7MqOGCD+c5BUYjkZVqDYPVd/7znwjavXCnQvShgizpXOBOBgDVWooZo/
         werQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
        fh=hVG/wmtSFfk4WAoq7HiZw7pN6rQEbXaKtPXkZp3d1U0=;
        b=ir2Qsy6TdcNS6aQVDBHXS7nlKXZ9tNMeB8JB7p7O2WjnFHvfjEkHQC9+fzQ8vCL8Qx
         bkMKptiMxFoPCS4TOAKse6qSY5lt5dW84/Ppmg4jJnXCYpx+AThZJhVGbsLM1pV7GOcB
         2waMAwKv4wcpIP6Cy/VQVHqDoKApZ6db5iVAZj4krPGKCNGiUhifQW9QZYk98DWXTgvQ
         x42ZjUgZ+Nfta1I9B3tEFyO/36xeGboheAV7vdvIqlYiwYkjtlu7Fr64YKlUppC83ca7
         FNArXJwFDnx6wIQz1jfo9vfLu3TcySC5XxxPkb+UyZc8L6OzT9MLxRCZF1cORx/fDRuc
         HgAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793500707; x=1794105507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
        b=Ez0Ef6WkIyFnPfzu27thZzh22hC+1ma+rA5JcQudoseX3D8VYdwroGF3YKNx/ccGTi
         DSIg1lM3aZijUOTRaXDEOXa9pywWQUCX2fdMXHk5SSz2l9UU9tUsEvuZxYzooTvjMF88
         3rWQw5CgIdyOPb+EHWR04DSMTRgKdZPC8Qep/ba89p9VLNqBWpQpGhZpjzxDkrihMMB6
         4kM0tYzQyptUuvPthx2qjt/0JeMUNaT+Q33aIGbPBCaZgFVii3iCFf55n3MavyqL1QMs
         aeMu747SSY5helzpAXtMPtVXj/V6fnR8Yz62qiv00z8QMZi5MyDRTclRiwsKVo98Jlsb
         yHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793500707; x=1794105507;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IypvIEaCfHpiWS3R2dq6ogvfOiiT9ZVprPilvXJ430M=;
        b=ceZO4Q3MKNH+kzs7mGHGAyl7acW5WCMLj31HAZDwHbzilx4XaQYFMpuppyP7m0dhPw
         znjWR7s5qyWIBJe4gXpFI7aj0bXUgs+rt9WzBOqC/7cRhJ8yGE4tvdmQy3ok2VTkC9I+
         7UwByFceoncP7OnP7oxrP7e05je/tnlgLgQRLrRPoqxFwzbDtwevH2BYdcz/WYvkkAw7
         /48zxY0nj8xvb7DDfN1bMdrfJwDHhOJAQeuVYhIc4qxm562Abt+LPg+3+pXZpuP35OLS
         Wl+H3uGw1eMHQhDeSO59agD9EVb31zTzhyxUO/oJYNG9n9OUKcaYE5dni2u0cLJKlWyd
         1Xhw==
X-Forwarded-Encrypted: i=1; AKwUvBx8rj09stCAvIKzbVezfk46Rn7O2axP9up6F5DKY/CmEbbTeiw9rjRK5ITlz7TPavLm67M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmsmE39eG4UP9Wy0LoG/wNtXBUKCWpIgnlQhBDg3NcRSTD63XP
	8iIGqamvVcfHOKdBCmCJgsjSs5Bv5fkVJMq2uiSj2F9jfjM2tVXNJ15Kr+C07bONaGAiGTTzM1D
	3quLaP7QNak+TU+C+b+Ky3pckghTvTrQ=
X-Gm-Gg: AYBFou2edpAaVAzekM8jojDFlK/qw9U8B5i3NwyXT3Q38kDZiKNveIXWn3W15nmtXLT
	pXlyFeDo2+tiaxjNoEGzvOfxwvJ+WrK5yXsA1nzkFnIkco75YQsWC/Do5YEa4Fap7b+m/3aXlMi
	Dt8ckRot1tuHhvjU72AywAGXHNtfMgwQ2Dlk5yLCMICax/u4t9wqzQaPBrhW5C2LfvwW4AfEORl
	3JQ6UowtrPr697rdw0o4L8XIVBZ+tJbvSuc8ETlO6gCE4A2ORy5ozqNFuPVCiNGOMkPkB+djW1l
	nfy/evagUvqT50HwhmWiAn23R5UouNZIm2DC4d/2LDhJ0jrxutg9ykWNZiv9jzeAAjAAJzzxAXA
	QocXjWjAo2nHGozP7pABcPR9y1iq0l+6pt/6Kb+gZ75Xsw6eIvNpzt2QGfc3f05OyjprGJ/8oiW
	4/E/8ysea9uEkwVcXei6KrCsd5qU69FRbtSijHpNahC6Wzi9WXU7A=
X-Received: by 2002:a05:6512:a96:b0:5bf:c9c7:eae0 with SMTP id
 2adb3069b0e04-5bfd9564f18mr1864662e87.4.1793500706846; Sat, 31 Oct 2026
 19:38:26 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
In-Reply-To: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 1 Nov 2026 10:37:49 +0800
X-Gm-Features: AclHuK-w2Xb5r-XGPIWLPa0peqPZ35FQ_khofZikgGeMh4wAdy4AzH-tS50Oovk
Message-ID: <CAL+tcoB=SG5WT0VrkhuPp_5VYtFHWDFhWMCNM421WzoU4z9=9A@mail.gmail.com>
Subject: Re: [PATCH bpf v2] xsk: Do not free ZC Rx buffer when the Rx ring is full
To: marcin.knap@vecima.com
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, jtollet@cisco.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
	Ratheesh Kannoth <rkannoth@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 4:16=E2=80=AFPM Marcin Knap via B4 Relay
<devnull+marcin.knap.vecima.com@kernel.org> wrote:
>
> From: Marcin Knap <marcin.knap@vecima.com>
>
> When an XDP program redirects a zero-copy buffer to an XSK and the
> socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
> -ENOBUFS to xdp_do_redirect().
>
> A failed xdp_do_redirect() leaves the buffer owned by the caller, and
> most drivers rely on that: mlx5e treats the failure as XDP_DROP and
> releases the buffer when the Rx WQE is refilled, while i40e, ice,
> ixgbe, igb, igc, stmmac, idpf and others free it themselves. The
> buffer is therefore freed twice. It gets reused for another Rx
> descriptor, the second free puts an in-use buffer back on the pool
> free list, and the same UMEM frame is later handed to user space
> twice. ixgbe and igb keep the buffer in the ring on their need_wakeup
> -ENOBUFS (XDP_EXIT) path and run it through XDP again on the next poll,
> after the core has freed it.
>
> Leave the buffer with the caller on both the single-buffer and the
> multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
> do. A few drivers relied on the core freeing the buffer, so make them
> free it:
>
> - i40e and ice consume the descriptor on XDP_EXIT without freeing it.
> - gve DQO counts the redirect error without freeing the buffer.
> - octeontx2 returns false on a failed redirect, so the caller goes on
>   to build an skb from the already freed buffer. Free the buffer and
>   report it as consumed instead.
>
> Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
> zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
> with the Rx ring. With this change no duplicate frames were seen with
> striding RQ on or off.
>
> Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
> Signed-off-by: Marcin Knap <marcin.knap@vecima.com>

Agreed with Bjorn the contract can be documented as a follow-up patch.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason
