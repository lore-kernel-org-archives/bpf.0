Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406783B0AF0
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022004; cv=none; b=O27//9CcjU31Iz7d7IMdRawUz6eawCJaYTK3/Tu+d73JMs2r1iwWJJ5ioovgs/iBoO330miyckZMKaT9J6MCAQktzZ2lAFtji9+9mVxEwt8BGHFUD6m6toe0/cNw2LAu0tOeqhAEsN0r119mHN331EZ+EwjxbzwIy/kJsJPk+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022004; c=relaxed/simple;
	bh=jsh+j7mdV7bUaWi/mOg0+ehvxQXKi2xt/TV5N9LSKbA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=gE4GGAnbiR8W0kl5BZZfX/cIimPpekGb3428zJfNYA/iPvdEw3oUOwN4k0AgDvPgB9zeSU4ReQRWf8/HEOTJz657907RBAGhqBANsBL3/l64fsE1nnWt25aL9n0Dspa3tReDa8iXp4xoXvOvioa/1Y19vMMqmudPqscJQJiWREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=PCLYtuA7; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="PCLYtuA7"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-306f36df4feso3752177eec.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781022002; x=1781626802; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCfH3ntzyc8thzIJSax7tUmLwbg8LIrjztkpC02J1dk=;
        b=PCLYtuA7Bc515ucaQKup1WSSlw0aS44BfIZ7tEEGvWlTSPo8o4oJ4aHG6HhSMziyGb
         4rHjghRuMgWk0vCM2qQdrtdI8L8cKxB+OMny3c8y/GbhjOF/Jdj6PAfGGsw9Iq2FVHhx
         B5KpP/vvNK012LU5EWfJiKwHhAkj9PfGszRHeCFG8JMfAcdAlnwBAhdL5+MV/CVCRA1v
         TxwoUuAYEU5jSh/IN0JILBuSlDGQh7xiulPQ7KgUkulxNMTDtp8BKciRpTGrIE9a2PoP
         jUxVbdp/SmRSgxe0Y/vX+lLsnffgYHAuLr6jRirg7fIX9hlIn1rtgE11ODlqpC/h/ajG
         lLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022002; x=1781626802;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCfH3ntzyc8thzIJSax7tUmLwbg8LIrjztkpC02J1dk=;
        b=knaWCfKBsAIEEfVT9+w2x7zm3A9d6fXvwVMwA8ifkwbf9RQaQiZ3Y6GLSLgj54S0Rf
         HmC9hcyM4DDxJIyo54HwmcAeL91JWqI3gNAPrB782NI4V9486bYK9SS/yWqWOB4w+Ohf
         CUoH9pmBJcoOBif4jKPgQvl+BFwhP11QqUYsq96XjlzeO0ddO7iEeTDrXh1iD63DkyPI
         M/Zd3AXitv2ruFYE073iIFLCM7vva1ooBNhZnzxVwM/BeHMUH1a9VcFVwNyJwhhzE4St
         FG7MDG6hONSm+XotYvlV0ph9gmxMuJqclUN5pZ/DsPArL4sgBvraOCbkg2BhhWQHgBvx
         WhqA==
X-Forwarded-Encrypted: i=1; AFNElJ9nHBBLsY1XSz685pnMwwNAbj1jvRrKCKvMQpVhNJwB+JAc5uIQFyS+RgEqmLJ34C5jZi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGzULZTGzXv01hL2eiVjHWzCI0jTnK7yJXROBlM11M8ZsvWcFs
	cLeBWinoZ4djaNqCfu4hs20iPKImxpnBBd0FMfAokhD5MMBG6GiQ8Xlsb9x1/20419xGZB77amm
	buL1nnT/QJw==
X-Gm-Gg: Acq92OEsx8L+77E+X0vXlVYTMkEuoQR7PPMsZwhMzrDtfsb9iUR1hClxJGMJny87mug
	xwtC9he/lYBmvrxlIrhyOB/eiyeZZp2fxNlFJq1Y+CouNELQG4B0kA9pnkgF7PZpgWdwpqha9R/
	yIDbisZLXW8euAWIgYWzKxAu2epBgVlwpOipRnFu2CLyL/Tt5rC3cX9960+ipCGp4rehp7zi7Jn
	qnPyAPTCWLWPDlhuEZyiCuk9GmoY/EOvSmHIaxTLUWSPkAypwO9RXMAx2siPeJE5ZB6GCHtyetC
	WIqpYLUOerl+aQ1LZIebxGhVSFXYQYd2/3L6cVBqra5r2Ix4YaCD+hcXUNs0V2RgQrJ7I4LQWSI
	JPmmgPKYlFpZ7TEvA651+iEE3BmulY391MX88Muxffc3h7djDPQ2ce93mWi/GoiX9RK19TReuFj
	srjoiKm/UOezBxyLpYRePaU9+i2w==
X-Received: by 2002:a05:7300:a8e:b0:2c1:82c2:bc31 with SMTP id 5a478bee46e88-3077ffb4ba1mr6947474eec.10.1781022002220;
        Tue, 09 Jun 2026 09:20:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::3297])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df349d8sm21801108eec.22.2026.06.09.09.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 12:19:59 -0400
Message-Id: <DJ4NLVDJKPGA.2BFAROFHZPLO5@etsalapatis.com>
Subject: Re: [PATCH bpf v2 2/2] bpf, lpm_trie: Allow sleepable programs to
 use LPM trie maps directly
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vlad Poenaru" <vlad.wing@gmail.com>, <bpf@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260529174233.2954240-1-vlad.wing@gmail.com>
 <20260609135558.193287-1-vlad.wing@gmail.com>
 <20260609135558.193287-3-vlad.wing@gmail.com>
In-Reply-To: <20260609135558.193287-3-vlad.wing@gmail.com>

On Tue Jun 9, 2026 at 9:55 AM EDT, Vlad Poenaru wrote:
> The previous change relaxed the rcu_dereference annotations in
> lpm_trie.c so the trie walks no longer trip lockdep when reached from a
> sleepable BPF program holding only rcu_read_lock_trace().  By itself
> that only helps tries reached as the inner map of a map-of-maps, or
> from the classic-RCU syscall path: a sleepable program that references
> an LPM trie directly is still rejected at load time by
> check_map_prog_compatibility(), whose sleepable whitelist omits
> BPF_MAP_TYPE_LPM_TRIE:
>
>   Sleepable programs can only use array, hash, ringbuf and local storage =
maps
>
> LPM trie nodes are allocated from a bpf_mem_alloc (trie->ma) and freed
> with bpf_mem_cache_free_rcu(), which chains a regular RCU grace period
> into a Tasks Trace grace period before the node -- and the value
> embedded in it that trie_lookup_elem() returns to the program -- is
> released.  That is the same reclaim discipline BPF_MAP_TYPE_HASH relies
> on for sleepable access, so a value handed to a sleepable reader cannot
> be freed while the program is still running under rcu_read_lock_trace().
> The writer paths take trie->lock across the walk and never relied on the
> RCU read-side lock to keep nodes alive.
>
> Add BPF_MAP_TYPE_LPM_TRIE to the sleepable map whitelist so these
> programs can use LPM tries directly.
>
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/verifier.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4..71c1e59e4df4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18122,6 +18122,7 @@ static int check_map_prog_compatibility(struct bp=
f_verifier_env *env,
>  		case BPF_MAP_TYPE_PERCPU_HASH:
>  		case BPF_MAP_TYPE_PERCPU_ARRAY:
>  		case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> +		case BPF_MAP_TYPE_LPM_TRIE:
>  		case BPF_MAP_TYPE_ARRAY_OF_MAPS:
>  		case BPF_MAP_TYPE_HASH_OF_MAPS:
>  		case BPF_MAP_TYPE_RINGBUF:

