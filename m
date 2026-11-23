Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795468212;
	b=r0u0a2s0L88YvPFMkyU4/SNG+BM8k5bw7NXyUy+rvHfgJ7609FESNB/0QTFQdrkoKwYU
	 lLrJWE8zTuOSACaflzawZUwPtjsBQKUFRujxhVfzDSA6SWGWsO/U7NaMFX1M7aDcLCKjC
	 d3lX9WBktUCeaxoNO+rgm6sAC6FLBKvTPEotfxgZHTKl4mDOj7Mdd4uXeH9flYRuSPWNh
	 A3LKzhoQ12Vxvu8msZ3gSiiZR++5+4b0yQb3p1DCpmopoGGOB4sBWdiVStUwi78gNImEG
	 VqHsG/8qf19a6NcopjYj8nIEdx5bh+fbv6IrqlXxp2zeHRZELPcNgCBMy76oAhfnwPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FkFupnOVJ01TJ277CJauG6Yuwd78xHj7FKn66yy/ozg=;
	b=EAI28Rl6TXQCBIlkQRACt/Cjt6lw7kNWCDk3hCSePfpxB3ovjznAPsLlz6XktYWszQPY
	 b1DWR5jdim8ArtEMmephU4I1x0jK3LlLeBJpFBVwli+7GvF5RfYe892SQ14DAnrSJMyY/
	 TBMFRYfsQtEx05mf534UWMcPBDbGqVCkvo6cgOCiZbOvnJsxpokfLMG8usJf8En3eUlVS
	 kvN6pI2CgIwntIkSZVbaywmcigPjI2LUpIZGUyF15Kx1KVlZteQfJBxSJ+TVCqdafyn3u
	 Rzl/YofuH0XHJt9o+5qDqWgZUt728IEW6i6kE6iT06El1liaPiwQ+7GzbIBnyL/FaYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t3g7GyJt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A4606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 961A4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t3g7GyJt
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a5024b3c28so2844574f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 13:10:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795468210; cv=none;
        d=google.com; s=arc-20260327;
        b=NUJT0u8weO3ehOanr41xE2zs6o4aDusUlzcZlf/ADIPu/S5bzAhtiJG6fvJh0eTGhb
         qHLAdKSCHEANtHXwCaDHPixk5vfpFVmOQ+ZpUgofeCKcPI8Bmq+qLN5XOvcjlq0GQ3rh
         D428nca5JoVCXhfgKdD2HHUyzIcnCtI1QDIkMbGxrvi9HLb7HoFA0U6/ARxlKtxa5s+2
         n9if1GLH4CtFhjjFfjOfJAitlbidObdfnWVc5KprPoW5zsqNy5Yl5KjXnuI5qxzTDKJU
         GLho14JlNHLKL4aa6pKk8DZkNWS4JCkw4WEUG+YtKHJ3E82/iIAX9HsQKvdHi+H6hkrQ
         T1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FkFupnOVJ01TJ277CJauG6Yuwd78xHj7FKn66yy/ozg=;
        fh=ATZoYp62shOE6H/1mxmwnMqBhbMxCUVYyPI/f2z4p6s=;
        b=nfoO7liv6T7y+toSs7paJIXWQM8tqtIyYSWlpcdhIvm2ytjAr5Mf09dhX9hj9UK9T3
         u1+9HKWa5WRR9Gvxye6gjnda4xTsFprMBsf5tTrXoLegpFipyPsLErSA8TLxgavcnqCt
         dWiWm/d6xM2RDMHOIKiaUhGAEbwfZi79uDXooFXnS70z4gc5DOcW7PEQrtxZe6h8djQX
         6jl4/64MJciRoqctaHohs+UKwya0U9DpeW76lg0U37p4gSiD/zTZM01c6Ac0LEEllwkm
         +T/iLTCmftftgP7cGjE4MHi75kk7NJROK8LhhvzxMQaYNPWJDA1yeOYUSGKVNr3BnNH0
         LDJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468210; x=1796073010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FkFupnOVJ01TJ277CJauG6Yuwd78xHj7FKn66yy/ozg=;
        b=t3g7GyJtwhMX1x8ZL2WFJs29JilYgfE3oPg9GqJkzW2/a4hDdWwN4YQdsKtMPUSl+Y
         WormZIi1f9MdGg5PjupY517vwh0L/HpexfzxdTpr3GHl6Aj6Uavpt+gpqQQRHGzcvjSn
         Wfy3dktyucN/aHAt2prqYst70ld+UQEKAJG1782o8GC6dMflbYVIJsE4BLnv7olMa82C
         GFzGC2RbfloewJ+m6VA/ZlmZFkPrNS1WaKYQ+kujghH7Behun2suuF5AO7PASYMSJ9iz
         eNj/kOE0b3YfwcqBCCumdV1v6z+Wg51J0MJfSwpkjmYBtZxIvR1S4cQkzrQk9+stmfYg
         /X1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468210; x=1796073010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FkFupnOVJ01TJ277CJauG6Yuwd78xHj7FKn66yy/ozg=;
        b=nVa5KumPKPZ3tiIV7qHVhsP/lCEXmU2idpDTybiYAZ5rnW6krT3hw0Ce8B6HxZI3fz
         5C1ikZ6f2kDewpFDcWQYkZjjYEgvk6+QPpOR0Zh7IYz1GtVIkrqW84QbNHIkba5ANdYe
         9uguoQFqOLg5//Si1Na6ka5sauDKflaisGbCMDHZwjAlc5B4leJ//Ww00ww5XkRE1nMq
         y9q24umo+0APlgyPFQXUIvj7bCdwXi9ea1OQgGjYaIOGSdYUviQ5uxw6DyQ5t5LT+Wkd
         GJNCGPQLdm5VAiDLM9dFvRC7MbPE8KNTlH58IpzaJ1KG+JZqgBPXyZfRGuCCcBMGhaQF
         ucog==
X-Forwarded-Encrypted: i=1; AL+hErEqXZ4ZSiLkDc5KBR/AhSgFjp6SZ3Y7u9n4y/jzesPhxdhQI7GTdlKb+U6EvPMghdEtghE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CN46Qu/+vir7SPlQyErruiXDvrZ/b4FLvmELGoq9L+wXPUF0Y
	Ok5lMqn+doDPgq6e7uk+p7fAJIsmktvqD3fTT+b8lQoYEmpFX+gpBk8JQ10N2S89Phg6VZFwxOe
	m6qEGQ/7Sv/2IBWCc1WzB41aUFyaB0ZbT5g==
X-Gm-Gg: AZFdTZe4R3/2fn9sj0ahMOfq6M0LFDIrOf6FH34Dl8wwAlb6ZAYTl6tLEWFmbivyC+u
	COclVngb1sU+mb9qW5WTh+RH10ML7k/Udvkw34vPHhc8mTlQte5wrPcu2nspeCj480HRYFdiDHj
	oFafE7agx/OW2m+LzceFss4fu7LZPOwy+d6cibAIbSWr0JFoxO0IPv84MZXPyYqbEm+TYAnUZXo
	PmCc7UVSsPCQunbaLsnS3RujpZpHpThTswPbFiHiP06lJzC6+xx87As9dl4H1jfPmSrYdngOnns
	D0qRGdxpMWljdSTDrA/CrHFKHLJrND3tBUUBYdgD9RyfAty52FxW3TueRH6I+MdCmRSQ2uJKSla
	GN0VYcLE1XwmwyHlZanwxncHceKq1g1PM5poFHOqAAbMXC6RKZ66oGAbWdihq0JGZf55pWTzKwe
	bbRG/bcfldeS0HPmaPPjINxRieCG2sfCJ64VA01z7afObYNtpmrzbOEg==
X-Received: by 2002:a05:6000:2903:b0:491:c392:1f31 with SMTP id
 ffacd0b85a97d-4aa5ab788d1mr32985157f8f.28.1795468209755; Mon, 23 Nov 2026
 13:10:09 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com> <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
In-Reply-To: <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 23 Nov 2026 13:09:33 -0800
X-Gm-Features: Aa3M54rzlNA1FR82U1PdfiFY5TW0gboojcKZPxdPIZcmX7lagtS1GzjDMw4zL4w
Message-ID: <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Paul Greenwalt <paul.greenwalt@intel.com>, Alice Michael <alice.michael@intel.com>, 
	Eric Joyner <eric.joyner@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	tianyi.gao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 12:35=E2=80=AFPM Tianyi Gao <tianyi@cloudflare.com>=
 wrote:
>
> On Mon, 2026-11-23 at 10:49 -0800, Alexander H Duyck wrote:
> > I'm not sure this is the best fix for this. If we are needing all NICs
> > that support CHECKSUM_COMPLETE *and* XDP to report CHECKSUM_NONE in the
> > event of a frame being modified by XDP it really feels like we should
> > probably look at moving this further up the stack.
>
> Thanks for the review, Alex.
>
> IMHO we should first make sure XDP programs do not cause "hw csum
> failure" in current kernels. Whatever an XDP program does, it should
> not be able to trigger a hw csum failure. It's not an uncommon use
> case, e.g., Katran from Meta [3] and Cloudflare's load balancer. And
> existing selftests already do it (test_xdp_native_adjst_head_* and
> test_xdp_native_adjst_tail_* in
> tools/testing/selftests/drivers/net/xdp.py).

That is exactly my point though. What we have is a divergence between
a number of the existing drivers in how they handle these things. As a
result the behavior is currently different depending on which NIC is
in use.

For example, one recent one I saw was an issue on the Tx side where an
outgoing XDP program was modifying the frame and actually not updating
the pseudoheader checksum. As a result it was breaking Tx checksum
offloads for NICs that were using the HW_CSUM that used that checksum
header. We could have fixed it by forcing all the drivers to
recalculate the pseudo-header checksum, but instead we pushed back on
the program that was making that change.

> > Also even if we go the multiple driver fix route I wonder if we
> > shouldn't look at adding a new XDP return type to indicate that we are
> > passing a modified frame
>
> IMHO that is for net-next. There we can add optimizations, such as a
> way to keep CHECKSUM_COMPLETE for programs that do not change the
> frame, potentially after [1] or [2] is accepted.

The point is you are fixing things for your use case, but anybody who
is using the CHECKSUM_COMPLETE to compute the checksum on the frames
and using XDP without changing the frames will see this as a
significant performance regression.
