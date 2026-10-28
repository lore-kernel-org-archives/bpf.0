Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218627;
	b=x66r62ZTFX8xAEq3QajMq7H3nLTRtQwFDDFwVtdi6uknfGtSbm6aTt+EulviS0yYb641
	 za9prRCVus9zMdUjKuFYY/dh1m2GxP8sjAt0JJLd9MQNCara7w5iUL8iOkOKSglawm+J/
	 d3KbIxn30aHvZnTNeBJ0PHKTov81rDN5KD2TgF3FIYehRuSJAsPjRETFMYQh2HZy0BvF+
	 QdUC7/dosdJPi8TOZh1ttYCXMls7SsCcXfBZ+qWNGY8yOT92z+4IlaRA73CPM9c71i1nB
	 2+IAn3Aip7cSIZfScrV3nm5ItYeDmKTUtbPQVUJO+VM2RLOa9M+plmrtuq5dzZbcA7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dSMkn2sWOTz70cexfrd27F1/JjDZDTCWFfIcPofUanw=;
	b=kdkFCBLLwYD9fQ/JTltJzS1T6HMqcwd24tGLUwm5DnqFbx8rSfuwSkltCFkK+5QF/3qf
	 qtKLYDX3Kul2uzVHbwGw/ZOYVVvPeKlfEjkEst+aZTzXKn9pGXlWNmG21yAH1gt66hU5b
	 LY1coNXo0izbEv1l1Jd48WJx70B+utguGus4QDyr/RGQ13BhvOSxafC25YMg4Gc0EP+bG
	 AJJXvr0t5t50WSQKNEc1616Lv4Kmx4FgqSlsfaFkWAovAggaQdnIkBs6E2oMxjCRlRftJ
	 OyOdGbqoLrzzfQOJWrrgqyZwofqOSiVh7jfjocD6lOR+2fHBV7M7vbW33iAgfcsG+yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PxB5Fgln;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890DF606A31C
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 20:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 890DF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PxB5Fgln
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso604107a12.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 13:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793218627; x=1793823427; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dSMkn2sWOTz70cexfrd27F1/JjDZDTCWFfIcPofUanw=;
        b=PxB5FglnjcjBtlTnc90j6ue1sLL2lmdBBRbRYKdrbAoflG9djxBOajiA3NJCHMQ7yd
         cha4F9zflIvORV32Vi/41qnpMIfu/penj9YMib8NJF++lrFm72knsguYtfFkotDSno8n
         Oze6K+YhjkPvRcq0iTgEGIojmAUaR+ym7x8TJQTcwPOZR6ZfvU9/ukw8Awy9/x8K8lct
         Koz/RHlAwAFkGTTVEPeV0KuVH6qC0+IyS5h8b6ZNnfcug0zJtqv8+I/rXtaedYFAVeNV
         rJEFjYhh+UksyYoUhnNyAmX9Lg7sXBMDvEhFgmQmO9vFZ0qu3wWInXzw5FdWL2OJLCdH
         5FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218627; x=1793823427;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dSMkn2sWOTz70cexfrd27F1/JjDZDTCWFfIcPofUanw=;
        b=K4hkGzFDnevzObXga7mA3pm9uIYmbQ0gzaCKGScfEAWTFimbeCcRY/y/jjvoDtWI0L
         siqk+6I4e4+ho5+xMkJuSnODISAoAjr/ThIUKx4uWzbFxND5kB1PqO7u97xAOwNJMRvy
         BMYQ1rAAI8CEvVfs+My9dpWmavtZCLk5oxa6y8AcU1TtBRrtlue+Ex9Q254rcnnhD22o
         Qc2XpPDX1b8SdLKdNBSNPRJ/hZ3VenLvPRPvyrUAOtVaI/7yBLeRLtm1MOVe2dzFCbw+
         XmXvxLNKqKGcMHViZTrKSA8LyNkYdkGoC5AOs6tPuIOk3q+Gv9i4xs/BTctW2VBwGHyP
         IJKg==
X-Gm-Message-State: AFq9FYKMCN2UXnpUinIqN8aXJOgvL7zp57YD6yXLofAfEfxnva7G+3Dk
	2LK3VWYKJa0EKgmMQ5ByFRL9HBQikPPGiY7nNuk8fazgU5tLf8VwRpzx
X-Gm-Gg: AYBFou3N6m7TY5K+08i+xUl29ELV85HJyzBwuZA+SEfFD+1XzfCq1SONKyI/9wL1Z72
	MGpFTqOoQnzqEXuh+9/bj4s/JcgoKBO+3KmstQe6CYNWvP1b00n29GXzWZEwKKDEv6KubR1TWp/
	wZSvi/RnfBESWP18ORbX9sW8Go6G1g0em5oIM3t9fh9HAR5phDkfZmysFlbv7dxfxmTJ0Wef8lw
	2xLqDCGZOHb31NlcYmZzLI3mrTn5EYPNv3LhVt8yN/UF2ioNWCHIhaKSC7Cny/OiCrpIVQ8NmbC
	JM7TzW07iWGPY2iK5E0Jn6mmAuohTY9GiLn2ALJYRvNIY1czJG+ZpvteAXefnFfDe6DGxwj7Udp
	heXNRxp/hibiWAmBfK5IEsavansEK3aweomNoT4rfPS2QytoVnx99lNKtwh78w6JI77IDIszY3c
	HiHHrg6lxQAifTUfFmS+pmhC/jUoGJYD24OznKkX7cb4+YtLVua7ZTJ/3Hbf63HbhVHKip06qUN
	7M+vIp1Ey7hsJYcDfoZ4hLcKbhzLbEzW2LNOxQd46Ou+794Ky/7u33d0/rWUtq4pdsvghaECgAb
	C5IngSAWNtzslaTTzX1tOHIGN7nuXquC7KwLQDofyqFIl3MSmw1q2JfITSmurpwA8aNniZa8Y2n
	XqrcOrqm7Z0a1b+aIPRpFg855T8cORticSw==
X-Received: by 2002:a17:90b:224f:b0:3ac:a7ee:6760 with SMTP id 98e67ed59e1d1-3ae57f637d9mr2382708a91.23.1793218626767;
        Wed, 28 Oct 2026 13:17:06 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6f01e8a5sm324003a91.0.2026.10.28.13.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 13:17:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 20:17:04 +0000
Message-Id: <DMGQY7IH5Q3F.4QQNA0FDUWY6@gmail.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [RFC PATCH bpf-next v1 00/11] Unwinding for synchronous
 callbacks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <CAP01T76uO4ULjNOQ217jXTLWtP5XT0rvB7PZxt8MJcoc==GBEw@mail.gmail.com>
References: <cover.1793147364.git.memxor@gmail.com> <DMG7KVUM9TV8.3QO4MU310J4CU@gmail.com> <CAP01T76uO4ULjNOQ217jXTLWtP5XT0rvB7PZxt8MJcoc==GBEw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 28, 2026 at 03:20 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> On Wed, 28 Oct 2026 at 06:06, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> I feel that you're too attached to bpf_throw concept.
>> The code was quite intrusive earlier and it is still today.
>> I told my agents that bpf_throw is a dead end. sorry.
>> I really think it's not a kernel job to solve it.
>
> Huh? This set is about making unwind_goto / unwind_exit work.

Sorry. Mixed it up.
I meant it in the "Eliminate spill overhead for bpf_throw()" thread.
I don't see the point doing any work for bpf_throw().
imo it's mainly in the way of any verifier work.
I'd rather delete all the bpf_throw related code and make it nop.
It didn't get any traction.
Originally it was a mechanism to enable bpf_assert() which in turn
was an idea to stop fighting the verifier.
That didn't materialize.
So when I see the title "Eliminate spill overhead for bpf_throw"
it makes me react the way I did... in the wrong thread :(
