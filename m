Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C2E3C2D
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785953906; cv=none; b=AHehIX7W6UlaHZkf0Tb/QBHIQf91zvHKu0tXnDQslcBYhThA76wg0EhVaGT/xAmit+7Cc9eaAp3BOSmKnA9W8DogL89jEzOXTapEuujieJqLrCGEnjVMduixKVRYX365zzKp0+s40ahmax6P9jd0+Awuj7jmmUrWWDgjI5nPhWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785953906; c=relaxed/simple;
	bh=3GrNYYxlJ9bGcWZzC2nseUlIYsY3k/C5QqTcAWQYxOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BDw9vit2j099nH3hPDrlorpshA3JJD3/OzRuHnua40GX5b0hKiawm/WfdF62HjcRKEVD3HirXTR0T9hlp71j7YoHwYNloB7j9WFw812IbsAySnKroIvvfL6wUTwXY8AMzc/xY7OrJld8doKSuon6bStsihxDazJzE7TWqkBb9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo7/EjF/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo7/EjF/"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84830c774a0so1489830b3a.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 11:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785953905; x=1786558705; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QF9jgbKnqfsalrA1agcpM6DaIjv48jIFJdnJbpVwMm4=;
        b=Mo7/EjF/NmG9rrpwz2vyaAX5DQXwal6sTy1/B97bSr4b18NF3dJyuwLrcGAFRUi458
         f8SVJoQe3xgiR7G32kmmcRdVExONENs0dJIlmjV+AyY6IrclyhjwHsG56S9yXv56xth/
         qLskLP+7I1w8+/10PLWnMU9K2Y//g5NdmmKE5DWX1Oyp81V0hOmz34FDUzFDl/k906Ng
         fHLQP5KPQ2ETmC/hoGZJeuTDtq8HFdgkx+V+qZsPurphcuTWcIInWMTh+nPytOB6cF12
         FfpBXapRlnjFNWiVkk1HfuMEOso6v3+W45N+82UqY6oLt7klCiYPbQngWpuK1aysp4i/
         5Z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785953905; x=1786558705;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QF9jgbKnqfsalrA1agcpM6DaIjv48jIFJdnJbpVwMm4=;
        b=kSVZ1RU873CH3WZctDg1+2GxHCZOPgUZjxlIPEja6atcAtIXUjWuzZIX2QotJXbiMJ
         5/OjiYoXWQMqwH7f/0cslzsCV8OIMIw297AWBTckNy1YfDsn/AjZA1FpsXzIUiuyei8l
         yomhJx5LC65lMXzg8W79BmIv6gwrDPQzAjs7E/JGtK+dY60NRE7RhpdcX26uOY8m9JB+
         o0cfn+GfdY/3Od06WEYc6buprS6So113vKOJxfc4xGu8NiybaRc2bRLrvp2tIzmRnoyN
         KapD4gy1IbbRpuT34ttLxKyo/YLqFL/kFsmoZ+/+iWJEFGx96UWP4Cm4kz2u2L5JDVSe
         59Yw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7MESa1Cg4LB5NSFJNQDgprEz2iNHnwSmEGGdgsoNokPjr9Vutt1uY3MQPcz7nApjvOfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxbd2Hk7huKlgQPrO9BHVwsQa/D51VTIxUYJDcJAXfJDMJbMIc
	WjmnkRubP7L3U0CcPG/Rv7a7c3sBWj30PZPYRaoPXX344bFq8JCxFnuO
X-Gm-Gg: AR+sD11S+15386Ip+k4wTv8rLOuBU+HIdToTu0CFUatBXNpFQ2bNbvSw0QEKIyYegU9
	vzZuQzHDbgjsUabzWoaMMwPMtAT+2GLRIzlTFF3okQypfpvZxB0ffjkemKqknVjxe8bpizl9c6j
	f16LWG8kc1qFgHQh9o9lXopj4UcYaIatrUkHkcuttbVeBJNN3DGfR2jOARS9y8aF1e8ARuiHklS
	gJIlLV+YSvUqY3X2IkFPGhbWzvq2jqOjBV5wnseUAj2atRDD+SlODWTBUx1b0a5ba5UC9JqrTMX
	6ea6T3Sba5tZmFS62jljJjpZnBcYxCRscJd8VoAIJQjy8uwXCjoQa5vku71p0B0nJEHBku4iO/b
	uoTo/p2wn/td2xsbGRKc7jZ84ton8qEdoavp+T7HAcnX8+TynzTOszAos7INEAKTyV1dvH4r3Ii
	v4BQU0VKdKANpygrvAj30yV/fhQTGYdyzQdEO9KDIvdtUOh8go04UYp++zxV11I7dygDaDYIvEs
	jv9HWquTczqgdtkiLyxiTCfiiQPQ8Imm/teZwkU8mCn7A==
X-Received: by 2002:a05:6a21:1b85:b0:3c8:d3a4:7b40 with SMTP id adf61e73a8af0-3cb85ded978mr11422458637.2.1785953904653;
        Wed, 05 Aug 2026 11:18:24 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9442:4c04:9302:a907? ([2620:10d:c090:500::5:6ebe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158676f579sm17133310eec.20.2026.08.05.11.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:18:23 -0700 (PDT)
Message-ID: <952a9aa9e0e8d0e8bbcf54dda79b1b88ff48e1ff.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 2/6] bpf: Propagate async callback
 instructions to scheduling subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 05 Aug 2026 11:18:21 -0700
In-Reply-To: <20260805011517.1717238-3-memxor@gmail.com>
References: <20260805011517.1717238-1-memxor@gmail.com>
	 <20260805011517.1717238-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 03:15 +0200, Kumar Kartikeya Dwivedi wrote:

...

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 9de45ade473b..42fa464c520f 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -447,6 +447,8 @@ static_assert(MAX_BPF_STACK / 8 <=3D (1 << 6));
>  struct bpf_verifier_state {
>  	/* call stack tracking */
>  	struct bpf_func_state *frame[MAX_CALL_FRAMES];
> +	u32 async_stats_subprog_ids[MAX_CALL_FRAMES];
> +	u32 async_stats_subprog_cnt;

One async callback can call another async callback, e.g. see program
'test1' in progs/timer.c. Meaning that this array is not really bound
by MAX_CALL_FRAMES and the code below may overflow it.

Overall, it seems that having an alternative full call stack solely
for the purpose of accounting is an overkill. I'd just show async
subprograms as their own roots, tbh. On the other hand, same
subprogram can be called both as an async and as a regular subprogram :)
so the idea of a separate spine is not w/o it's merit.
If we decide to stick with it, maybe pick a better name?
'verification_call_stack' or something like this?

If we decide to go with this separate call stack, would it be possible
to adapt the code in a way that only this call stack is used for
accounting? (e.g. is filled on regular subprogram calls etc).

Another option is to build an implicit call graph in env while
verifying and count only self instructions and counters on edges.
Then propagate the data over the graph in post-order traversal
(subprog_topo_order is already computed). I think I like this idea
the most.

...

> @@ -2293,6 +2298,12 @@ static struct bpf_verifier_state *push_async_cb(st=
ruct bpf_verifier_env *env,
>  			0 /* frameno within this callchain */,
>  			subprog /* subprog number within this prog */);
>  	elem->st.frame[0] =3D frame;
> +	cnt =3D env->cur_state->async_stats_subprog_cnt;
> +	memcpy(elem->st.async_stats_subprog_ids, env->cur_state->async_stats_su=
bprog_ids,
> +	       cnt * sizeof(elem->st.async_stats_subprog_ids[0]));
> +	for (i =3D 0; i <=3D env->cur_state->curframe; i++)
> +		elem->st.async_stats_subprog_ids[cnt++] =3D env->cur_state->frame[i]->=
subprogno;
> +	elem->st.async_stats_subprog_cnt =3D cnt;
>  	return &elem->st;
>  }

...
