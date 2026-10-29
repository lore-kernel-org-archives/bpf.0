Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793232471;
	b=YwqO4XdCwWqxg1NJ7UjpPB6WnuQiRQlCXYhIK/SmCtUK/x+8zp+gWPVwxq5fNPFipRJH
	 NOgEzvqQoOmV9FVIbHXHoYrecJDYobxZXzAFCdQzQDwVwQUIUQ4DfHmjyNEO+mKIKyX44
	 e5NeJIUiVVItq5n78Yo4C5FAXk2u9ceAStcFQiJjNwbPUwb4nAAiQ/M+uVqZTDLtY2asT
	 w1ZoLzQhD4Y5LDxGcQxeNbLyaex1khoJPh5pjIbVAFS0mNvo66IubRW66bv8Ms2sOBuD9
	 p+zF57v8rPiM6/YMMxfqLX0tpmX8Yzqs1IB2J+jkNGaYjV0xshTnCwU7iyhL1zHCKqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=jV+mgBsNZYsyIBg0hQf63DVIP3Xuoq4NMJ5W+xEDT4A=;
	b=wKCX6eb/XiB0CJUzQU3Rf4J+GyahsnS8ZQNK3njlPZPdVLPZE0vzJDLnJXmhLShOMhx8
	 y+asjIgkqxwDQmJnpJLW5LHfDq5OFjizrhK5U0qSsbrp3Tg0D9gAlkg0Zea/Eo/eYa0zU
	 p3i8rxGaShf5cLzP9Qwqm6xHpdDdM6bNMdzT8+xdIsF9LVclFRy6XACjMDJ4qQ2vEDrL3
	 x2kk2xfT6oBCJenL4FWfd9nD5T3KmDK1BR6UAGf4OZuealR0gIk1It6Zh9IIjfLTopuuT
	 b+YWCiPFLfzyPCjIFTKQxPb7SkxHXarSYy8h4qne99jOEChcXVm5JwO7r/5rZhEoeXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yTfHy/M0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.71
Received: from mail-wr2-f7.google.com (mail-wr2-f7.google.com [74.125.225.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB3606A31C
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 00:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFDB3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTfHy/M0
Received: by mail-wr2-f7.google.com with SMTP id ffacd0b85a97d-48df951fd31so597701f8f.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 17:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793232469; cv=none;
        d=google.com; s=arc-20260327;
        b=nhtMgJscW3a/ALtGnhiWXZnzwacOltT3KS9GRAdAVKrjRiMZjjc4eeGR3u0GQ23pC+
         4HPmVuJr3HLfnDjSA8sbPTMOT4WWpaYpC1ufOLUKg6jyDZSNSY9dB305uyDAKoYklf2C
         L+4u0X7SulDngbFRdsjZYG7SoEoLWq2/ILBSF3MAoUf1YZ5FsYc6ftLJVHhIK8hoY0W4
         vaP1l0cbH7mLH5qqUqrmmyYh2etMZq0VdCUPhCWdbyukcaO+Unev3Y1U3dlSPy28JhHn
         QkqKyLBMzBtsaMIc7aq8wuSigtubAi4YlrnV00qr6FD7AEUvwBdeekyr+/+TnPWtf3LV
         mDoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jV+mgBsNZYsyIBg0hQf63DVIP3Xuoq4NMJ5W+xEDT4A=;
        fh=nK4o+E/nKAvNbzKwQovufHGBef//cfTPEviVumPIXzA=;
        b=rt7sH/yY7juVpsJ+pj2j7BZBJ7v3IleEDErTcz+9RWbdnLqzhH73AYS71OCKOiVoRf
         st/QDuqT5d3/rwMz0UjhlQla4BoxxjbB3AW+cmDW6O/ftZoFs3py47vSymlfPqCGYlIF
         rUI81UX5FjrZ9rd3LbM0we65NSdLwn1oETFE2FI7VW7i/2rLZw0CKwmfty+liAvCNKQs
         hgbnUVq0X10TrSGk9aiPB+Li57UHaMA/PfJcnS7OijYbL362V7EZH5Mn471W8wvQtX6I
         o+znGQVwt0S1vXqvxKuKcKne+3Qo9ysu7rGmpqQ3cKzgrGI1F3QlaIzQhPxNl09YVPpo
         H8Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793232469; x=1793837269; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jV+mgBsNZYsyIBg0hQf63DVIP3Xuoq4NMJ5W+xEDT4A=;
        b=yTfHy/M0UDWSQdWOx+mns3OJx+sLVrxjNfLcx3JYZAwU/VXDBTxkrXcSZaDMozVZWv
         3Cfm2xawg4B0owogJ7d3SRl6lz1QMvO0uTW/g5MgzfWnKLUJ8LrePNPOxE/6VXAPlWHL
         4UTFn8R0n8F1cwxgVkVfDFA/HT0VXHAqQVTV2bAtrj5PdzrWhUxGIxEd8wZa58c/JkQg
         +Z3iNYy5VNm5oqrON1pG3nAgiMxhB53dX9r5JuZOiL3SSig8J5/njQlGytiQ+wg4bSmT
         ewoYhAZP0pvVkZi00GsK3qKRLsHGDWvH9xV8vo4650OiHlOR1+wYCGDnrwGJNNzERIgw
         drow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793232469; x=1793837269;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jV+mgBsNZYsyIBg0hQf63DVIP3Xuoq4NMJ5W+xEDT4A=;
        b=QdaaBLQr/6dEKe7rm4pE8oYXHdy73dwMfwO1d3YScsnfCQrRk4Y7vvbRM5z+ng7UcB
         eaIDn3pdx56W7UMFGxrez2HTURWbiMk0gd4jideQ3oEwbC3wjxdls6p+z0wMKTaT4isw
         DictjyvnabTetQ+vG32VQ5Znu78UY819SB/cQKTjXyedRaShSqcrCWDlhGhE1I28uJVu
         V2XfRiFjfjcL0oBO/rOQM2/CXMEwXuKzN4g+VjY/de5GzSZn0tT65wIKmH1u6M5yvKOS
         0ptSj0pXHn8DNLCxvBMorcD9khxcZthlMo0vxIfDdJ6uqZXKjOcyy8iLpfZC10a1jQhs
         teBA==
X-Gm-Message-State: AFq9FYJSFHOgQ/2BXB8B+jpzJNy1VtTlH5owprmuBxBBou6sQV38rzdR
	R3SMZMH8Yj0Fb1trjn6hSpLx00bRWbJwcHnbkvzhVjlEgOaemGYZXtp8JPJ93V5iHOlrsOc4VkW
	vLJOllHgHTDxGvR2uR4MS72VbpnexvAA=
X-Gm-Gg: AYBFou3C3TGIw8hQ4QelFxPWsLuQbGzX1CZjB23ZVufnFrohhScTNq4BuFX1aKaCqwk
	CHm6HlNPPZmsseC5d4dN+ZZOe3ZAEuIX5UUnz4zsvcwEV2RpwMskBaGcz2mEiicLHd7otmX1Kq5
	wT/wFYVmz2x93bhOIu01x8Sq7RndEOpP3oAk8z53GF/x21K9GIF/to6A7OKYy3LPiEmWH3Q5v94
	FC/JU/aMvOm8xCFXKk4QfBAsIsacnlY7onZZ6nYlc7rtwBuh8lWgefSkpFX5TI3N0T0HDlvw1Qi
	6kVhidObf9QOkEyXlvE5sddQkiUxX3iHMxwxd9IvDdRq8LxaN/S0XMRJm5hJ4NTdHu+iG2lGOHw
	04dbv6Q4lRsWgZ7EEO+7Ej3t1+U8JquGHjU/qPsa7RxwT3ILkGwj4wk2noZgwa+o18buMJHDzGx
	u1CFvY1AdpMuxVamXbn23KSUyKgS4pfpCw5VhSFZ8ZtwBjG5o9/cVu1YfeH0cg1TGK5uyt19nkq
	+/14ScOc8/wvHR7
X-Received: by 2002:a05:6000:490c:b0:48d:fdc0:65be with SMTP id
 ffacd0b85a97d-48e5d4680f6mr9298284f8f.38.1793232468993; Wed, 28 Oct 2026
 17:07:48 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <20261026025943.404450-27-alexei.starovoitov@gmail.com> <CAP01T76dRouzrPOZS8AQ4TMnJ0GzyRm8cPJ8RYUTu01bQgf2Xw@mail.gmail.com>
 <DMF694XH2TJO.P59A31VE6GWP@gmail.com> <CAP01T75HAHkP4bzdGzeazN4n_FNd5w1Pckd3GBN68V0n1PNe_w@mail.gmail.com>
 <DMFUDQAC6N4S.1CNBGYKG58DMR@gmail.com> <CAP01T74C4bBZntDNLrCxe02prWiF3pnUfYMFTUU6-44O0zbnPA@mail.gmail.com>
 <DMG76G7GIPN7.HQJKZIE5J8R6@gmail.com> <CAP01T75pOz8Nj_YG13quoVeniq6908sY5og4RadfM9-tz5j7PQ@mail.gmail.com>
 <DMGPC9G5ZT9O.2NN1B6B3K7STH@gmail.com>
In-Reply-To: <DMGPC9G5ZT9O.2NN1B6B3K7STH@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 29 Oct 2026 01:07:11 +0100
X-Gm-Features: AclHuK9jrD75tqkyW84YhoF1TiEtUcfgYfVMx_Nrv-INBbMl4BUak0TXDcQK4ms
Message-ID: <CAP01T75Edpdne_VV_0XAKEw-ijCh5ShXJQq1MQKpKVf9fRQzUg@mail.gmail.com>
Subject: Re: [PATCH bpf 26/81] bpf: Support BPF_REG_ARENA_SP in the verifier
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 at 20:01, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 28, 2026 at 04:00 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > Sigh. This is not a good response. If you do not want to have a
> > discussion, what is the point of posting patches and asking for
> > feedback?
>
> I do want the discussion. That's why parts 2 and 3 were posted for feedback.
>
> Maybe I missed, but so far I didn't hear an alternative proposal.

I was not making a proposal. I don't even understand half the changes
yet, it's a long series (81 minus 16 patches), and I haven't been able
to digest it yet in 3 days. The only thing I was trying to understand
was the motivation for the split stack, and it wasn't (still isn't)
clear to me why it's necessary.

> Only worries and concerns and "there must be some way".
> I expored all ways I could think of and listed some of them in prior email.
> If you have a sketch of not a 'stack in arena' approach, I'm all hears.

I think it will take time to understand and reason about all this.
Decisions on where to place .rodata, how that interacts with the
examples you showed, how the verifier works now, what the compiler is
doing differently...

But if we don't want to wait, and you feel you have already explored
the solution space and all of this seems fine to you, it would be
wasted effort on my part. So we can continue with what you have.
