Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555993BFE34
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311955; cv=none; b=os8Is6k3ggqoaqSluRztZq4MxBurFicb6jXRW65xk0Pr7sLpXlmfCgOWr7JjJR4Un250VHlsE63vgBTPWK7lH65WUudlsA5Qm+JQVJSaQ2BzESZP8B12ucGpBE8aDNRREwcaA2hufm611E/+XcCXzcgYzrCv9/oodKTEIMqCHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311955; c=relaxed/simple;
	bh=oJKg+sWU08019AgYZ3mLYhBvl4jR2MRhBkXkAFvkC1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q51qpUxFjaQGtmqrgFMjkpKCsN1MAStNwbv+znqRLIJFUhi84zBEABnCQCRRqmjBVcggbkHsK9LBGyZwAflgkbnu1TR8YIFvalNr4VCQvlaLDY0ts/956lvpYDfbAu7YZO1qtkspWjOeE8dih6TxCu9o9da+lGy2IKVo3C7vtYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WcRSDCud; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WcRSDCud"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69f7af97316so1023999a12.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785311951; x=1785916751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BSu7JL8uetpoTT8PchWK8VOr9P/UrPvyuqFyAo+g8/A=;
        b=WcRSDCudtq5vhvlWKkN4slemiGg4Kr1keB6tQZxE6pEZ0KZsXWljNxNL0qkyVEz6Ms
         EGP7ra+hCGWL5+dWBtmZKAcbw+OHRU5P31AQupQb6WQghKGH/VzVO6ubW2CWiqjiEiZR
         Acilgofi5mBU4gipmvpg4Z/5UUB5cFEUQjYnKC4EEHsUyvEFCEe/nOHMProhHTAbLrsj
         lDz2BEqy+L22di7txcvji5KxfXsjyGJIc9S5SnizseyU11LBA/MM6sbONfoiPHo+nqdH
         ELZftCgfD1JAo94qTy+/Ac8C6YdUKPyHhqGIocrXeum7q2VNHEhmaEdJeo130c3dZAZD
         vBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311951; x=1785916751;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSu7JL8uetpoTT8PchWK8VOr9P/UrPvyuqFyAo+g8/A=;
        b=lQevpdn7blHiqzfIvD8XbZVQj+rwt4OvyQDzm6e7ZRf0L5In8VKAAcIYp3445E2qZl
         6RpK595I0+c+/lprnU2uEzAXbBqGcK2qVlCtV6iamVrWjD1ea0oTjNz0lVvzTT0a51Cr
         bELE4syJIZTiiSY2QQE0U4r9BbUwJR9QNyY4Aqh9RSVsFwL8YlDdv8E4aZgCajlabwZG
         TG54sN06gnSnx1I4JecJqQG+wRB5HyCJB40Gcbf7usLm1LKIAV/YvoFzSs9xEzkNQyvI
         Jo7V1dCJjwX6bAx3L7PjH6aMSRn87OOe0Ueu/VivPSysfQ0FjDHVQi/aYPnWCNpZJj7V
         JhxQ==
X-Gm-Message-State: AOJu0Ywq0rPCY0MlOCzQq9JeeveqSNLntkmDZdtFFYr4LDRfKgn2MevA
	ylchI9TLPD6LKRQXPjvOP/DbVbcz9gQk1vmwA8FZ6YZKp7ZHzXHr1sypf+iBrEULRDo=
X-Gm-Gg: AR+sD11eh3vptBtBW7oiYOvlI/gLkblRT3UjTFm2LOVDl410vgOrTW8XDKFmS19TBgq
	uzcruMoaupExcCkj4vwcnaYYVyj1OY5XRFQOMZMhUdLP+GVE0X+8nCSRfIYIDUlS6kRXviY2OMm
	bpQEa+5qwCk1vsFacwxiUicY8n9cn6tHbp54ru+viQoDIgrhNwSt3TcR/ninrTg+z8nvtedTwI6
	R/yiR2nOxKqSz9BFS5Fx2q6q5kaBrf4H041Vn81rBGz39V+bO9/bdGgx/Pv6H41eDC04kQbjNnn
	0Se8tG7DhoUT8iDAOd+1pQMpG1oJ3Kl5VGUlsmHGwiF7xRBJD5u6sfpGRStQGAPzHKmK/UC7f8d
	S0+yUpaS7pUmi1CSJsFGWs/mq8WzOVk1YWxVkSilFTz66cfa69U6MJ0leqQjV3l+wxcibxvCAod
	ZC69GjUjHUASuaJ8u4rh3wUcjOW11Ty4pc0TTDt3wPGZbGEb1miO0R7f8ndhl5DQeN6QkoeIpLq
	jCVCmT9SrDm7+F+JBg=
X-Received: by 2002:a17:907:843:b0:c15:b68a:5e16 with SMTP id a640c23a62f3a-c1f724ea439mr293651866b.60.1785311951475;
        Wed, 29 Jul 2026 00:59:11 -0700 (PDT)
Received: from u94a (27-53-97-170.adsl.fetnet.net. [27.53.97.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc821asm7390775ad.41.2026.07.29.00.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:59:10 -0700 (PDT)
Date: Wed, 29 Jul 2026 15:59:02 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Vinicius Sampaio <vldsampaio@pm.me>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, 
	shenghaoyuan0928@163.com
Subject: Re: [PATCH bpf-next 2/2] bpf: Avoid redundant min()/max() in cnum
 signed bounds
Message-ID: <ammvMH-I4088A3AX@u94a>
References: <20260728015601.1567098-1-vldsampaio@pm.me>
 <20260728015601.1567098-3-vldsampaio@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728015601.1567098-3-vldsampaio@pm.me>

On Tue, Jul 28, 2026 at 01:57:18AM +0000, Vinicius Sampaio wrote:
> This patch simplifies the smin() and smax() calculation by removing the
> integer min and max calculation on the non-overflowing branch. This is a
> valid simplification because when the arc does not cross the signed
> ST_MAX/ST_MIN boundary, the signed order of the endpoints is preserved,
> so base is the signed minimum and base + size is the signed maximum.
> Therefore, the min()/max() calls are redundant.
[...]
> --- a/kernel/bpf/cnum_defs.h
> +++ b/kernel/bpf/cnum_defs.h
> @@ -44,6 +44,9 @@ static inline bool FN(urange_overflow)(struct cnum_t cnum)
>   * cnum{T}_umin / cnum{T}_umax query an unsigned range represented by this cnum.
>   * If cnum represents a range crossing the UT_MAX/0 boundary, the unbound range
>   * [0..UT_MAX] is returned.
> + *
> + * The empty cnum doesn't produce any meaningful value, so you should avoid
> + * calling cnum{T}_umin / cnum{T}_umax with it.
>   */
>  ut FN(umin)(struct cnum_t cnum)
>  {
> @@ -67,19 +70,18 @@ static inline bool FN(srange_overflow)(struct cnum_t cnum)
>   * cnum{T}_smin / cnum{T}_smax query a signed range represented by this cnum.
>   * If cnum represents a range crossing the ST_MAX/ST_MIN boundary, the unbound range
>   * [ST_MIN..ST_MAX] is returned.
> + *
> + * The empty cnum doesn't produce any meaningful value, so you should avoid
> + * calling cnum{T}_smin / cnum{T}_smax with it.

Nit: if we are adding these it would perhaps be helpful to add similar
comment to {u,s}range_overflow as well. AFAICT
{u,s}{min,max,range_overflow} should be the only cnum function that is
not expected to take on an empty cnum.

Thought I'd prefer something along the lines of

  caller should ensure !is_empty(cnum) holds when calling

>   */
>  st FN(smin)(struct cnum_t cnum)
>  {
> -	return FN(srange_overflow)(cnum)
> -	       ? ST_MIN
> -	       : min((st)cnum.base, (st)(cnum.base + cnum.size));
> +	return FN(srange_overflow)(cnum) ? ST_MIN : (st)cnum.base;
>  }
>  
>  st FN(smax)(struct cnum_t cnum)
>  {
> -	return FN(srange_overflow)(cnum)
> -	       ? ST_MAX
> -	       : max((st)cnum.base, (st)(cnum.base + cnum.size));
> +	return FN(srange_overflow)(cnum) ? ST_MAX : (st)(cnum.base + cnum.size);
>  }

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
