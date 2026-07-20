Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3113CA48C
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579471; cv=none; b=bOTNU/6tjL/EMhddwOQYz9mdKh+8jLyQyOQUUea06OsajnOnp3jrgFYlAtEyBlQU4ymele9nfvap1sMzmI65NMb1aoGcYjCHwfTJ8LWPx+lR6fyLND4xWGraLp6diPzCdeQoXDc2yjf0+lm0ABBXKZKxVfhrJumK98ORcYixBzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579471; c=relaxed/simple;
	bh=7Rh9K/aMUgrUkaTFrCF6H0sgp3ex8gQh4yF3iV3opCE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peL7jpJUDJ+RMwT0Gy4uAMjodky4nM3t+7GoL38/HDADjjt5umVXnBKn1wIaZ1z7SgDvqrt66HL2g+txSgM/AVZjmGPyoxw6X6+yzp5ozNkPmPtAnRKSSu5HT8zx3wN5xkdTweOXImiXLRsnJT27cJ+nXzwIs91Ji6/vf2MFL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgF4zhAV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgF4zhAV"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f7872abb6so655684f8f.3
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 13:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579467; x=1785184267; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HCoN88NAevl2MQDJ7m5oXovQm6Rv4VDkCN88nmuIeQ8=;
        b=bgF4zhAVbPpvF7Aev6MKBRrfStncA9HjmnRck1uwq328jM0rm+Keb2cb3FbvSR5r0u
         JAQTxnwOOEoHn59Rw4IARynwWJ5Dakz5QtzHq5DoUu/LdnJz9iXyRd/UPT/3u/+b4iSS
         J9eBsKqYRwIaMMTBXhmT5XIiJcjzrmVd0WRBKE+iTobPTxaQQgray3dxtUeM95chY6N/
         pb4PEZkqnBUgh4kMcx3lgFpBOrI1XFA1FO01JV/SFcUaJW7/aTeAUqFu1z3aRHSYppIa
         cOBXQEYGuuI0BXhYTkW6tiN4pXtpiFWdNs+zdoZGtsBPYNwSxXTadKEhVmqL9bkbIe47
         bqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579467; x=1785184267;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HCoN88NAevl2MQDJ7m5oXovQm6Rv4VDkCN88nmuIeQ8=;
        b=Pe7I3hGd0QDQw80xcj8Cdc+nTy9somjnVqj4tvnm3AqsUElu8jS73puOHvoYNb28KN
         fQddIlt0HXv6Mursl+5qLWBh2kVw/ljFgCsP9iurHoEYiyHBpLXLAneU+XKbw7r1DHXd
         UsrsLsvQzj0M1hEDwn5ItLnhM3uG3Mr+Q3u9qfVeXZYz6IYLDMz2BVc1g1sj3Rsl0pVw
         9U8d4SJ/jgDHTz5oC6rQAA+zxO+AJhyaVpyxFrg6gLRwjGMGcnZnHXxggxcQltKBof6g
         SIkiaFAnCHBSXUAjIe8YctgbSUvEnblRJ4ZCnOSrZJ6a4ZM+q7AeZV/XCsqvW1hygpnT
         8pQA==
X-Gm-Message-State: AOJu0YyW6zMgewRsvK/V1t2+cjxIycFDinW2B0pZnDZYneL1wNUE3f14
	wIJv92WfePl4lnvhqBpkrYSwcSHxminaCuPmrqcbQ9wZ/PuKILEniNw8
X-Gm-Gg: AR+sD10/NFg4WH0tU1eiRZI/nLmJNm+ZDPVWaqI2HE9zLVUvjz2Wz4j1dGUZDRPEVTp
	vLS1RDndUm0wsAYuOSWRPhQpICRp4q3oUaOf77jYGz0ibkeQbvXjBeOn0/id1VJl1ssTjB85PUH
	BUJtUE0KGMY72Wltvy2BRSZoKKsaUP/QS1s0Ib3w71DoUoZJcVsI9WNLhXh95nE1ehSLmP6iHD6
	AvaHYs9eY7bpL/wVOvmMvtUhSBmcXwjTrg1sOpiZ/pixX2XvW92yiixDY6ocmJJXKddXb5KqUpS
	igazTaktRKy95BRWUhsJntBoEJWwIpEangUchO9YOBMFSDWtLLZADarFp+tku29rkArvWOw5DL2
	Mrfu3E4gXk+iZXv4JaRtA4KkFRWFLblzCtdUpzZmPgUksYnu0smNWOD+yyY1VtKO6sQ==
X-Received: by 2002:a05:6000:41f8:b0:472:8c12:b93a with SMTP id ffacd0b85a97d-47f62318cdfmr18135543f8f.28.1784579466837;
        Mon, 20 Jul 2026 13:31:06 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63edcf8dsm35417470f8f.27.2026.07.20.13.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:31:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 Jul 2026 22:31:04 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/9] bpf: Factor stackid_new_bucket from
 __bpf_get_stackid
Message-ID: <al6FiPN_p5EVMrob@krava>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-4-jolsa@kernel.org>
 <20260720090141.54DC81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720090141.54DC81F000E9@smtp.kernel.org>

On Mon, Jul 20, 2026 at 09:01:40AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The newly introduced `stackid_new_bucket` function accepts `trace` and `flags` parameters which are completely unused within its body.
> --
> 
> --- Patch [3]: [PATCH bpf-next 3/9] bpf: Factor stackid_new_bucket from __bpf_get_stackid ---
> commit cee0ea77a9c1144b54fb0472b1788623044b5650
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> bpf: Factor stackid_new_bucket from __bpf_get_stackid
> 
> This commit factors out the bucket allocation and initialization logic
> from __bpf_get_stackid into a new stackid_new_bucket helper function.
> 
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index 7bc2a966e3e81..48a2e28f0c68a 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -559,31 +559,53 @@ static int stackid_fastpath(struct stackid *stackid, struct bpf_map *map,
> >  	return -ENOENT;
> >  }
> >  
> > +static struct stack_map_bucket *
> > +stackid_new_bucket(struct stackid *stackid, struct bpf_map *map,
> > +		   struct perf_callchain_entry *trace, u64 flags)
> 
> [Severity: Low]
> Are the trace and flags parameters needed here?
> 
> Looking at the implementation of stackid_new_bucket() below, neither trace
> nor flags are used anywhere in the function body. Could they be removed
> from the function signature to clean up the API?

right, will remove

jirka

> 
> > +{
> > +	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
> > +	struct bpf_stack_build_id *id_offs;
> > +	struct stack_map_bucket *bucket;
> > +	u32 i;
> > +
> > +	bucket = (struct stack_map_bucket *) pcpu_freelist_pop(&smap->freelist);
> > +	if (unlikely(!bucket))
> > +		return NULL;
> > +
> > +	if (stack_map_use_build_id(map)) {
> > +		id_offs = (struct bpf_stack_build_id *)bucket->data;
> > +		for (i = 0; i < stackid->nr; i++)
> > +			id_offs[i].ip = stackid->ips[i];
> > +	} else {
> > +		memcpy(bucket->data, stackid->ips, stackid->len);
> > +	}
> > +
> > +	bucket->hash = stackid->hash;
> > +	bucket->nr = stackid->nr;
> > +	return bucket;
> > +}
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260720085351.655075-1-jolsa@kernel.org?part=3
