Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C87372B37
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010532; cv=pass; b=LEi32Y7bHOQnsmhriOb68plOvY87Eonj1oLOBFWhOQloOogJBUqnNn2hc0JpdaqdhWFKvh+3MoKmAdGYMc/VPN7p9EqdrUGKoQ5lAdtuorL0cI37VUdprcmsBTTEv02pPP4K5ng4hF0yFDyA5GQ2FawkcN5MaufPOmvkS2dPNQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010532; c=relaxed/simple;
	bh=u9n4JVY9RdPcNlmLZKT6GPjwYVgNicrco7a2vIQlBOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtmWJ6rDkETQVYMVYgjbu3NfZmG+it530viJKIVLkiAPlElniNgAGVeltIbv3MLaHeAgc1JXgNUVL9IESv+JsCwBxrYnKGlH6Rp99Jl/4CgBeWZiBNhUxJuWfvs6xgimlC3O4KtAu6W9QTdyc8Xv3ucDOKiMxIjHRw/BT4fvImw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=081gLGuq; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="081gLGuq"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5033b64256dso451041cf.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 01:08:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772010528; cv=none;
        d=google.com; s=arc-20240605;
        b=FMFmc4zamgENZWy4pwBlAsJ5N6NWe1cz0nD2e18rYuN1aEzyR8sPhXGWRQYA4oWN/K
         6unXveWYNjIIrFPU0Zkx6KX2lRTjOTsH07f9p1jLPxg1NqB0+dUraxVDDiE9ukSqL4gG
         djSXVegi9RX91VdQtGfGm8ZnDoPgrFQV6mZ6TntrfP/RKwTDdR4oj4Qt0ENisHzxtFv4
         +6UdHyOLtxpqwkA91yC+JkTgD2jNU/QH3VRFb5WNApFPXhLqQKwriqutAtUCTiCqRTrK
         2qnUH0GGhLcxaXTH6yc2AcXmmjqHV9lJifUZUusZ8s3YNg0CKuOE0mbomB6C9bEUFh5m
         INxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tI2iJ1ArOwMQLi1r27+ri+dBH9j4tPIlA/AmAUUgYn8=;
        fh=EoaIuLgrfKAnhkFBBAQWdwHmgppyKcqfLw3A6ZmoTFw=;
        b=ktxuaNT76XMTy12voRYwrx4vc3l6JVQmDujl14M+2bKAML+Pn9oVtzmuhlCd00RDEQ
         0eokYANr+DiQMwjRSktDeBV/vn8RKcxkqRpfhUiPn6E3WdTpHI23fzrAwWUC6ZHpm0qn
         o6pkZeH0HevxDOt076nOEJTvN4hfKOiBQHdFEZrv1gPCW815Apt7d6mUUeicXn8NtBmU
         JdcPdk26qPLZu3bUOILdfVWhrhhWu0fYW2fhbWY0NWtYmwpkpd9Fv8tM1XLs/5YhAPIO
         If8oeQbFdo8fdKdEvGSt5xpstn+kUGU0aArQ1afwDoPedcJ5bLG/QMw2KAd6IMeJLB1y
         25DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772010528; x=1772615328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tI2iJ1ArOwMQLi1r27+ri+dBH9j4tPIlA/AmAUUgYn8=;
        b=081gLGuqyTDk+U2MdZsX5ZtbnfTihY1KATnPjbmZxNcB0AQc07XrHimz7N0WROiwiX
         4pA4Z8iHqTwlg8SQjs7gbYKVuhOquizML1BbVXIvLb/vJ0pgM8n5q6mf07Q0vnRh9BcN
         WJ3zv41PpDD0+VUnhkgsaB2Z2Y8Ia/9JiPNR0n0BtmObt0wfPQkeY23TkBuFyIe9BcAj
         WUMdZoJtN/QmcTQdbgU79bY30P+NbVKkw8DymCseLQaIXkamaxNH4GWTlPt9yuJHs5GK
         AVBoxZhi6j5PGnJ69Cd2zUeQPe9SirAQbEYDH0U16mfx3vQ2Gr7VQxO5Phq4t4BktVvn
         1iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772010528; x=1772615328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI2iJ1ArOwMQLi1r27+ri+dBH9j4tPIlA/AmAUUgYn8=;
        b=b6KiFv3ZekOY8AAoQ89B59hy/yR8+/bMRC6apntSSuWbrsgF6Icxvrxm4/YO2UQ4Wc
         Jd88o7XOM1L9sHiwWs6O3N0VeJ+67BNNj9qSxii5mkB5r1QsmWFg1tC3NYq76pY1CQU6
         fptzLQ6lXK63d4Bnn3V7wASMj5xoxmqui/0w+cphfOrTQSb+kgaPo/R/mY0glXDvElbt
         B9ORq63NcgURLQ+UabbHk8Txl517Bt1qegTT3uuoREj6mc4DnCijA+BzOxUqeSnca4zF
         NtTfQC2VYVF3ELr3Di59ujwCPsDkFmg3Twe6faUfMXLdXMrUSaLS7SvM2DnHArmdABSi
         varA==
X-Forwarded-Encrypted: i=1; AJvYcCU1+i/YUmyljHi8XG8zAT84asFRK7UJbz0rYJCqLPpbog4zx3Xp9Hnk11K/rDrbWlBczRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGB25Wrc2TeytHkvYm++a2NbLYlluZXBwLEdihv0Nfhu4Zf8e5
	Qe8zUxm6llhykvlrbBdAPZo8fY0ijUOByVHAUqVwFEgft0F74vn4C+iLbG9QP4av9JFKT1+d1PN
	yg2uB2myxQaqgHUzIt2QGE7ms5k3ZKFiSqloUKpT/
X-Gm-Gg: ATEYQzym4UeRSKUPcFSpkqnObXomyhk3FeUYW2urvi/K4FER008GdYgKhb5l8mtFxzU
	XsDPoRRPkGWGt0ZrlPkmhGc6P8S+bGzS6n9VR78LnIlfIafcFxRNoVfDoUWYt3i5wJg4/JRJE9M
	bb1ejkmwm81vHZJMAYfuE00fGhWKrHiaRbmXWgdMgORS6nZN7QQUdF1jJyxB8uYCx6SP8kRBRcZ
	a20yG/iuLALzxfbBUpSUg62gBoJLH7hzAUuVDkIDgUMraWiFNcjS7oMtulDyujSlcSvYoyKIy5Q
	Ti9uzRev
X-Received: by 2002:a05:622a:1a9f:b0:506:9852:75ec with SMTP id
 d75a77b69052e-5073a334f20mr8026821cf.9.1772010527804; Wed, 25 Feb 2026
 01:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224093128.1926610-1-tabba@google.com> <c402e95a-26d3-47eb-8249-52ece97989d3@huaweicloud.com>
In-Reply-To: <c402e95a-26d3-47eb-8249-52ece97989d3@huaweicloud.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 25 Feb 2026 09:08:10 +0000
X-Gm-Features: AaiRm510X2gqm2-MN-A22TluFAjjJklw4_yeZOloyf2aIbrtJF9L9Fud9P58kS0
Message-ID: <CA+EHjTyXWqnr4Cu_cZyxDCVNCxto9pJN0WS18S_ri824oQhwug@mail.gmail.com>
Subject: Re: [PATCH] arm64: bpf: Fix UBSAN misaligned access in BPF JIT
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jean-Philippe Brucker <jpb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Xu,

On Wed, 25 Feb 2026 at 01:43, Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>
> On 2/24/2026 5:31 PM, Fuad Tabba wrote:
> > struct bpf_plt contains a u64 'target' field. The BPF JIT allocator
> > was using an alignment of 4 bytes (sizeof(u32)), which could lead
> > to the 'target' field being misaligned in the JIT buffer.
> >
> > Increase the alignment requirement to 8 bytes (sizeof(u64)) in
> > bpf_jit_binary_pack_alloc() to guarantee proper alignment for
> > struct bpf_plt.
> >
> > Fixes: b2ad54e1533e9 ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
> > Signed-off-by: Fuad Tabba <tabba@google.com>
> > ---
> >   arch/arm64/net/bpf_jit_comp.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > index 356d33c7a4ae..adf84962d579 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -2119,7 +2119,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >       extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
> >       image_size = extable_offset + extable_size;
> >       ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
> > -                                           sizeof(u32), &header, &image_ptr,
> > +                                           sizeof(u64), &header, &image_ptr,
> >                                             jit_fill_hole);
> >       if (!ro_header) {
> >               prog = orig_prog;
>
> Good catch. build_plt pads NOP instructions to ensure a 64-bit relative offset for
> plt target, but it misses the alignment check for image base itself.
>
> Acked-by: Xu Kuohai <xukuohai@huaweicloud.com>
>
> nit: Add check for base alignment in build_plt, or a comment to clarify?

Thanks for the having a look and for the Ack.

You're right that build_plt() assumes 64-bit alignment when
calculating the NOP padding. However, Will pointed out, over-aligning
the entire JIT buffer just to satisfy the C standard is somewhat
heavy-handed. I didn't actually run into a functional bug. The issue
is that UBSAN complains because we violate the standard's alignment
rules.
I'll dropping the allocator change in favor of marking struct bpf_plt
as __packed.

Thanks again,
/fiad
