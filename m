Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670728;
	b=0cKL+pynMr/LjAdXF0F6J9SmoLgGPFSrU99qDG9ZDMfmHPWdG5chBFR4zSfT//fLKPIq
	 1Jbb2lYZoVKqQMvCz8E40b8baJo6r+IBiFYFFIG7fZ6RN8oqWWi9iqnYhDWQ/XxVuPF/q
	 +nNKz4IlAKTNsY2ZWHphGGhE65LpVnweSwaXnmS9E9qGCNxz9snBOH9w//GLAehkLOubk
	 nHvDw1BuRTlIejvy7opbSWTLvtzhjlhFOWYAU0X8i+yLIIp0lJLf86M+JPakiow80ACTY
	 kJg3o44qfBT4DmT+8G/6UT9jaPocmSPCKrNYfFtoha7872OdTCsPVxbK9Q3PqPrcHsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670728;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=BvlhOXWWUN/L06dzJGiCJmHB45x99YGwdoXxYD3mGQ0=;
	b=q/PdWNYTTGHJnOSvJxvz9fTKCa+mzvP3iF59xBNxgh8ACYWaiO6FOEPpWl7oFuWjWBY4
	 hNkdCvDdB/GZWntLy0J+Bh4I12uzFOPK2/qeNVt+aMEkSjyqJXudu+mpmqHEibk/cIAri
	 i6V1rODg/tT3N0Gqf+qjFmcaRd5T4tdISOoqMpxyoKLaGaPV9U7RLup3TnPO3oKNm8OA9
	 kzEl2+fCgkfd4IwmGmYSlSAWXsW7YiooVC7PvoaifvguJzUl1IPapkK6XGy03RVhtBXO3
	 IDb1pD3Kb+Oc5DARYLrBPXB20hxsuOPdg1sNGmGqBYT6XZg8VVWRTQc2REcVTMfftXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DXj/Yis2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E9E606A319;
	Thu, 22 Oct 2026 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXj/Yis2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC731F000C1;
	Thu, 22 Oct 2026 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792670727;
	bh=BvlhOXWWUN/L06dzJGiCJmHB45x99YGwdoXxYD3mGQ0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DXj/Yis2i7vhI5zmDqlK1CRIlRpf0thfdcRZdayh1IsSxseGxBPEQIXkTYnvqnOsn
	 Cjxmf6s5G3ElMTriImzYQziZhoxlNBA76PThv4IXT1YwpjDfyfRsDlYrI3wmlJSrNv
	 WBghf5yi+oAyH7MGB6ZVmkPygrMIHGA12rV/kHyeSbr1W2iA53Y1SDTyCJHot0DUZ7
	 zsxTRB6v3tM/ugBE5CuocO6h6nVECA6D1+zZmv1bcM+PDaQZhkuZmvb/JqRSV1Vnv1
	 eJ8XR0ex12wdnrx7xnZGDQpMhDAv6WG/DmFb1V0gFlNXUy2Kn4zbM+msYYfQQ6h4Yd
	 Z/GOVR3ZmBlHQ==
Content-Type: multipart/mixed; boundary="===============7744310823040091790=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9e67828ba31a6f6e2d7c4b86bfdbba903cfa05cd468b58d4c03558cb8f453f3a@mail.kernel.org>
In-Reply-To: <20261022112312.31563-1-ayushmanrout27@gmail.com>
References: <20261022112312.31563-1-ayushmanrout27@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Use memmove() to load bytes from an skb and an xdp_buff
From: bot+bpf-ci@kernel.org
To: ayushmanrout27@gmail.com,bpf@vger.kernel.org
Cc: ayushmanrout27@gmail.com,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,martin.lau@linux.dev,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,hawk@kernel.org,drosen@google.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 22 Oct 2026 12:05:27 +0000 (UTC)

--===============7744310823040091790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Use memmove() to load bytes from an skb and an xdp_buff

TL;DR: memmove() fix leaves the multi-frag xdp path (bpf_xdp_copy_buf) using
forward memcpy(), so bpf_dynptr_read() into an overlapping rdwr slice may
still corrupt data; the store path looks similar.

> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -4298,7 +4298,7 @@ BPF_CALL_4(bpf_xdp_load_bytes, struct xdp_buff *, xdp, u32, offset,
>  	if (!ptr)
>  		bpf_xdp_copy_buf(xdp, offset, buf, len, false);
>  	else
> -		memcpy(buf, ptr, len);
> +		memmove(buf, ptr, len);
>
>  	return 0;
>  }

The commit message says "A read that spans xdp frags still goes through
bpf_xdp_copy_buf() and is not changed here."

Can the same corruption still happen on that path?

bpf_xdp_copy_buf() copies segment by segment and writes into buf as it goes:

    memcpy(dst, src, copy_len);

For an xdp dynptr, bpf_dynptr_slice_rdwr() with a NULL buffer returns a
direct pointer into whichever frag holds the requested range, so buf can
still be a slice of the same packet.

Consider a linear part of 100 bytes and a 4096 byte frag0:

    dst = bpf_dynptr_slice_rdwr(&ptr, 110, NULL, 64);   /* frag0 + 10 */
    bpf_dynptr_read(dst, 64, &ptr, 90, 0);

    bpf_dynptr_read()
      __bpf_dynptr_read()
        __bpf_xdp_load_bytes()
          bpf_xdp_load_bytes()
            bpf_xdp_pointer(xdp, 90, 64)   /* NULL, since 90 + 64 > 100 */
            bpf_xdp_copy_buf(xdp, 90, dst, 64, false)

The first memcpy() copies linear[90..100) onto frag0[10..20), which
clobbers source bytes that have not been read yet.

The next memcpy() then copies frag0[0..54) onto frag0[20..74), a forward
copy over an overlapping range.

A user-space model of this loop with forward copying returned 44 of 64 bytes
wrong.

The skb side does not look affected, since skb slices are always in the
linear head and skb_copy_bits() copies into a destination below the source.

Would it make sense to make the multi-segment copy overlap safe, for example
by going through a bounce buffer, or else to say in the commit message that
the xdp frag case remains broken?  The store path
(bpf_xdp_store_bytes() -> bpf_xdp_copy_buf(..., true)) has the same shape.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39772397846
--===============7744310823040091790==--
