Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006946;
	b=RQGcMkrqiPjeervpL7mhYZueAQOt9PA5Z9slyt0HsjJqfurcYinukHqjlsAejd+LqIcj
	 4iiWyKndi84TPITU/qKG8LB6tgbxmw8M/oTZ/fmsWDiTAq9PgX5GTMBWNJj1bNtOql+m6
	 wcDN/jeeJHMJ/wLUQJXKzgcdHSfR902OJMfVu/CKHaD/1sHd7VqOSK7t9aEbDBvoj1OC9
	 c81vPdroKS41RxEXRoqEBfHLKTIWOtDzWlHixKpBqBJLCmt1h0E40yd2kPd6oeKxO2TAR
	 OXoDq5f2LaniaTuM8GWCneWFRVGXuDhE6yEypbzenaLVvwNrz30MmubqGtL3JH0o10A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006946;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=dXui/8xO8TzoZWgwEXa26NkUN9SotSK+Bo9SiHoH5J0=;
	b=ogl/k2CzyMC4Ogi8Eaaf37m7DnO0m0i6jIM/vBF1ZVhzF/JrSRlRUm3eVRuzG4gHGVvJ
	 F1sywHpVhzeSRowqHnORsca1GK5Z4S1M82cgxuK1sCT0XNR/fyYRSy96nY2Q7aWSChQ4m
	 XA6x62BAU7GDrkbaRRKu6MurefVFkihc2TUiudCh/w9Trd4SSUtFbQXIua9wOUFugF4em
	 zbK1SPjU2RTGpbrslctITsSxddptUJMfArholFJQJFLuWBa0kqdXa/8lBIhVV1XZOYLc8
	 w7H8+ir21AU8AlBAQEI4zlOCi1vf8zSIxkIY4VvRHrsxxZc8jKDjtP77IgeftIIYhLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZROzuReZ;
	arc=none smtp.remote-ip=91.218.175.65
Received: from mta0.migadu.com (out-65.mta0.migadu.com [91.218.175.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13149606D803
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 23:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13149606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZROzuReZ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2HSXVN4EFV2hWx917K0BIV2VoorAhwhuo1wptgcdbzc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794006944; v=1; x=1794611744;
 b=ZROzuReZN1Z6oiYZirtXq7h5wqGJCznIO/8uKd2ZlI2eLAekpIBrQOL08/VUQzokyi4TIKoc
 VEQT/YYdz/ncigftQV/JzM04yeBA/LECBpn/LM9vuE4uu/d6npMf/WA1DlgEo9KYxvEmpgPFD7Y
 u2i1lBP2tLf9MoNN75ThC0X8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ac85c30ab44569c5;
	Fri, 06 Nov 2026 23:15:18 +0000
X-Mizu-Trace-ID: ac85c30ab44569c5
X-Migadu-Flow: FLOW_OUT
Message-ID: <3702b4e9-bda9-45c5-8fac-392db6451823@linux.dev>
Date: Fri, 6 Nov 2026 16:15:14 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v1 0/4] bpf: Scope callback arguments to their frame
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Nicholas Carlini <npc@anthropic.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20261106231157.2840635-1-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20261106231157.2840635-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/26 4:11 PM, Ihor Solodrai wrote:
> A callback-calling helper can pass its callback a pointer that is only
> valid for the callback invocation, and the verifier has no way to
> express that lifetime.
> 
> Two helpers need fixing:
> 
>   * bpf_user_ringbuf_drain() passes a CONST_PTR_TO_DYNPTR over a
>     sample it releases as soon as the callback returns. Saving this
>     pointer in callback_ctx leaves it pointing into reused kernel
>     stack and allows arbitrary kernel read and write since v7.3.
> 
>   * bpf_for_each_map_elem() over an array or per-CPU array map passes
>     the address of a u32 held in bpf_for_each_array_elem()'s own frame,
>     leaking four bytes of kernel stack.
> 
> Give the callback frame an id and make it both the id and the
> parent_id of such an argument, so that slices and clones descend from
> it. Invalidate the id and its descendants when the frame is popped.
> 
> ---
> 
> v2->v3:

Sorry, I forgot -v3 when doing git format-patch

Should I resend, or is this fine?

> [...]
