Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660528;
	b=vpYhNpwXq7SKQiQ4B+6aCntGAoRaoB9YHDz+dInwZJuAVkuj2BXvxSSkmKLxTdJ/SAtX
	 oYdZtiyjGMcbOXXllhdeabie/F5Wx9hVCrL/cQPmhKdZVgzmLMrKJ4NOWHNYT9mx5SHrt
	 XZvxYnm8o08cL9OXzTN1WWCe27kgxsVVet83CMf8TSaT4uRnRX+elU+H3/d0X/qpMZrAt
	 jlrCf2YuEnVFUIjdOC3eDLBTxJ/2XSCCrQzpBkVes7UE5pyWAJJ0TZSNNo7TEKyUJQM0i
	 RhlxOtu4z1lORzlgbXMGs7U7l8B0rctHovUV0raYx9NU8Lt+8BjD4hs2cjgeLG5EhVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=oj9na0DVBDJtudsZfLncNdoZFNBIlfRdys75ekuhQE0=;
	b=uh+lQCWf9d1E9u3xr3GfTPGJzXnmGFCtGhvfRULcihVF+0Is4ou6PHfQEuazR96NPl4S
	 qgD4jzSKWll0qhB3eUN5MXKH9FFSxibNpMRdLQ8ptY2YBk9ROlphzWgnYAAlc2N9NnU6j
	 4roiU7wEae8GGRsKol3yFeULAI6hWDUxY2/R0de8Vu0JYsoZetX2LaaCO1f0QWp8RHrIo
	 kR/U/+tbFIVYMI9+LPyi7N7jkCd4MC1tZplMx23bhROdasRQ1Acf19ln+dXkMF9b3SiBL
	 lT7/KGJcDjkSS2NzsJotAAgS7r5pvQAjisMXPBr17cW9/DPniVDjpoo6yw+hv2QtmCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hfdQ4MEg;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ADD606A327
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 12:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3ADD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hfdQ4MEg
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3791619605cso3901696eec.0
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 04:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794660527; x=1795265327; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oj9na0DVBDJtudsZfLncNdoZFNBIlfRdys75ekuhQE0=;
        b=hfdQ4MEgT0OcBrLyehsxdWw84F9f/5GCZOQqj2amNoCkIYk8eWe4OKfIVS90luZGXt
         +w/W2fyscAdro0HxNBsyigoZJIrRGzXg03K1Mo8dxCrZC4w8CGZS2xfzGWaBhwAm5mVk
         NW9ftwwqSBkSSsjMNvgDMIhiul3oQrsB+42SceuIquIJOa4ZqlCYZaQeS1AhPT8JvuJM
         fvEJUs1wlk5l94qcRHzVFdToMuLJiYoxPlCBMhG9PaEMS5r3Oi1Ill5pmV3vFOeccr+T
         dFkvGNuB1f/E/cW8/naZzkiklTu/PeY8pE6qPMyPo6w04yPmfMmYvzqmq8nP6EiRDgVw
         APpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794660527; x=1795265327;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oj9na0DVBDJtudsZfLncNdoZFNBIlfRdys75ekuhQE0=;
        b=GvNE9qTy8NFUgLfXC6+JGM2+FIpPHz5XLruEkBXVG49HaXAUkiULt+NI/jYTpkW2rm
         NnY2HlQv8VWQ05VrSpSo8luJIE3R17tsW4loiYtv6UJShcno7dOekvOy8WkNMHzTUHYU
         P7ZtC5+2Nh20YC9334ud3hsY7iLPS5S/YKHMJE+EeutQP031YAznvmTeWm/mkSDY7zob
         pe8Nwnl5vKCcT51pJzhpT0VmER28chno33xisems2zyhYWpKel2dBFoyn5zAomsJha9H
         xA2Q/FkHFxZxUqrK1g7iECLwT5I1oCFUG3omY92g+xsAg3+LGErdWJGrpd/kb5PZ16WT
         dOig==
X-Forwarded-Encrypted: i=1; AL+hErFQSKpaQgQBbbz4QAVX+EigWmbFKxufJ9IdBOi/kwXIlWNslw594KGIRB1DJoYO+qm4AXk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/n1vZb21yz6gh5cIcsbNhgQQQ3erBDZkERptH4jU6YakgvgtCw
	9m+fh6p6yN+S7Qmiz5XdCrkRov9hevcB1WIgdtmN0qyHc2/fQlC4xwM2
X-Gm-Gg: AYBFou11hlkTOAsrJTBCCy4SERHr81KJcUfPJloAMEdffG0o53aBQVTjfBBZw4X7X85
	qAKecu3Wv9Nxsg/rCQo6gu2F8vD/MPvCCy7t8kaHqchZ+C3aw+yw01JbKQ1IlYkAjiVE+HAHiZS
	avlohRhWEllwh6IVOWKh4cKQSGD81CT1yyfkz40cc/KliJEgLHs9t74vcXq3v2mwRMzj7fxpjXF
	MLzM6pv5v3T5z04eYe70xulkQBks5Pk1pUuYXYOzwiNfBghGP6jnjU3oqKiAw4ufVSkivIxsNl1
	OSaNhwoYlcJBQRmVf9TOJ+nUq53U5/D360lrDCquCuRUrNTxFmw/Z4Rb+ymUlTsO6Z114ZuurWy
	ptwInmozrLb2T4YWCKIFy81h7/qwat8oCrIrk/Oi2dz8WiUIXTa0BrvTh8gx40M78vqbqIBIt6K
	bVhSjg/JMdxWTwyVESKE9NXdzTOq0v+I48kiDVPWDczLyzNY9nsvkT6EnLCt6tbUItY6QQoVQ/c
	cPbU1BeB7hwoXEWrvI5DgtOphwW/WwbRSO8iiwFCCwpl5hDfGKywPYylmiPB7DVzXbOE1LDHSLl
	YVywCsVoa1klr+k58tnfZR4zT1o=
X-Received: by 2002:a05:7301:da0f:b0:36c:a42d:9bc9 with SMTP id 5a478bee46e88-37966961442mr5196237eec.25.1794660526823;
        Sat, 14 Nov 2026 04:48:46 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379569b8389sm28530823eec.25.2026.11.14.04.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:48:46 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Naveen N Rao <naveen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Abhishek Dubey <adubey@linux.ibm.com>, Dan Carpenter <error27@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] powerpc32/bpf: return false from bpf_jit_supports_fsession() on ppc32
In-Reply-To: <20261003184226.76740-1-kmehltretter@gmail.com>
Date: Sat, 14 Nov 2026 18:06:33 +0530
Message-ID: <cxs78u9a.ritesh.list@gmail.com>
References: <20261003184226.76740-1-kmehltretter@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Karl Mehltretter <kmehltretter@gmail.com> writes:

> bpf_jit_supports_fsession() returns bool. Commit 92258b5bf1ec
> ("powerpc32/bpf: Add fsession support") made it return -EOPNOTSUPP on
> ppc32 until fsession is validated there. The negative value converts to
> true, so the verifier does not reject fsession programs on ppc32. Such a
> program loads, and only attaching it fails because
> __arch_prepare_bpf_trampoline() returns -EOPNOTSUPP on ppc32.
>
> Return false instead. The load then fails with "JIT does not support
> fsession". Tested with a ppc32 kernel on QEMU g3beige.
>

Fair enough.

> Fixes: 92258b5bf1ec ("powerpc32/bpf: Add fsession support")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202608010958.cYfBCQAC-lkp@intel.com/
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  arch/powerpc/net/bpf_jit_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sorry, I guess, this must have falled through the cracks.
Should mostly get queued for next -rc release.

LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

