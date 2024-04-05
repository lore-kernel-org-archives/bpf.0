Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A7173340
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346227; cv=none; b=mBIdXjp5Rui9xvLDxrBR7k+JE7ZWK3BBkYz4/SGwruQ7zjp7DFK1Djf97QopN6u79ASdrqAXRzXcfh/YL8ssMdJsrY5umtvqvRSRF38yBBw+NdWU/d4cwG8xtqDasx1dNFee+IpHdDneFMvASnkRynxia28aVH9uQWOXrMTxqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346227; c=relaxed/simple;
	bh=qzokeEy+8Yqfkgk6NuTu77aROxbfH73ZZVeMKnRzvaU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ia0yzggicZc0pOsZ5uBoymfqWXyWWyXYwKI3Lw63H3kE8eteT+jAGEpI2ZBvWjmcMhtUxtzQAKUVr+LMOZ3kNBULV64tf8MCIil3QWTxF7m88H/PBC4+vOGls4lNjvT00G7vB9cfibqcZnOKWCftPyor6r/RuIe/Kvegw6Y3K+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKyFsk4R; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKyFsk4R"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a2e5d86254so1420002a91.1
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712346225; x=1712951025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XSJroq0LGvxsPzeyw4upgpxRnAU+2JOA5LA4G7ztVA=;
        b=lKyFsk4R/M0j3lS2x0U71/cH6bEPjQd7iIdq3Xih2I/50UN0NbbLo95llDy/Y/z8Ft
         xgjXlLu7dQcg9BGpO8rPNAoGhhVvWQywy3mIaFHsvuWamViAMjkthTeRLQestNOOBEtP
         uNO3IpGgN5Uy5JKrZYkm9a6bo5SvcTWG3CCB9uZtgHIZqTNMDO4FCRZBA+YzddmhlVkb
         jn6e5p7auE3brHuL0n9BTzibS9B9tccsja2oAGB9EuinjvAXSpn4AjUxKV1tt861eTDA
         gv6xpusqKg5aht3VhThO3FBhVMmaqaOH8AcZBUjQOzIvjms5w0npeoVLYmRQ34mcWkcv
         ofog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712346225; x=1712951025;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5XSJroq0LGvxsPzeyw4upgpxRnAU+2JOA5LA4G7ztVA=;
        b=crctfaHZxGoXhY71gcCKyTpH8GwMQt3nq1emjwXu6XOGXAr/97Zz2pt62w/qPPwAKZ
         vZq/yV6BaH76PnSpRZOQJat7qDmMZE46O/u/qbWasrOD+iRvvwetS+Rj1GQWTRhGMsN+
         HGCfNsABDhUxuz3b1xwiN4PY3wUYJ6pj3mLiL9dRDzgiT4JbhgdybC1sKkyYE9NBvurk
         u4/QtfDkPQRvqq0Pl0azthXDybrnTYnAGuRBZ7J6XqAY5fevQVDEHmRSS0SC1sqGMBuF
         Gm6yii2hQgxyZjqNwHM7FyCbGfMzwbwzZ52ou4pWPd+nxQbWpTYyS3+sXUFOw0tnR/EA
         qw3A==
X-Forwarded-Encrypted: i=1; AJvYcCUnbeStFDSwpnw70fNRxwlm3VLn1Vrr0wHNd521fLtoXKCmVm0Q/5d48jcVd3TPxW8JoQqKmRlWcyQ4mo2JayXbLRqn
X-Gm-Message-State: AOJu0YwicS2lX4MllQ61DOZgi2f1HegTrCQCxjWB7eZjl0GNUOb9B3P/
	0zvQP960OdYM421VzuqJwFt6DBUh8FEU6yK1YC0DRw4KRSvkLcCV
X-Google-Smtp-Source: AGHT+IHZcYtPjwxNCzR5A5bkAu3wWPrjZ9+QowEjf/Mi7EqGNi1F9XB1zmXUvE4pA2a179zO1KoAkA==
X-Received: by 2002:a17:90b:10d:b0:2a2:e384:c8cd with SMTP id p13-20020a17090b010d00b002a2e384c8cdmr4730095pjz.20.1712346224716;
        Fri, 05 Apr 2024 12:43:44 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id iq16-20020a17090afb5000b002a49ff7c1f2sm60330pjb.56.2024.04.05.12.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 12:43:44 -0700 (PDT)
Date: Fri, 05 Apr 2024 12:43:43 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 kernel-team@fb.com, 
 Martin KaFai Lau <martin.lau@kernel.org>
Message-ID: <6610546f51fff_60c8a2088c@john.notmuch>
In-Reply-To: <71218766-13fe-48c9-a24d-b897d7c428fd@linux.dev>
References: <20240404025305.2210999-1-yonghong.song@linux.dev>
 <20240404025310.2211688-1-yonghong.song@linux.dev>
 <66101695d69a7_5803020833@john.notmuch>
 <c9db2abb-2391-415b-ba71-db80dc42cc54@linux.dev>
 <6610258cb977b_5a9cb20838@john.notmuch>
 <71218766-13fe-48c9-a24d-b897d7c428fd@linux.dev>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yonghong Song wrote:
> 
> On 4/5/24 9:23 AM, John Fastabend wrote:
> > Yonghong Song wrote:
> >> On 4/5/24 8:19 AM, John Fastabend wrote:
> >>> Yonghong Song wrote:
> >>>> Add bpf_link support for sk_msg and sk_skb programs. We have an
> >>>> internal request to support bpf_link for sk_msg programs so user
> >>>> space can have a uniform handling with bpf_link based libbpf
> >>>> APIs. Using bpf_link based libbpf API also has a benefit which
> >>>> makes system robust by decoupling prog life cycle and
> >>>> attachment life cycle.
> >>>>
> >>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >>>> ---
> >>>>    include/linux/bpf.h            |   6 +
> >>>>    include/linux/skmsg.h          |   4 +
> >>>>    include/uapi/linux/bpf.h       |   5 +
> >>>>    kernel/bpf/syscall.c           |   4 +
> >>>>    net/core/sock_map.c            | 268 ++++++++++++++++++++++++++++++++-
> >>>>    tools/include/uapi/linux/bpf.h |   5 +
> >>>>    6 files changed, 284 insertions(+), 8 deletions(-)
> >>>>
> >>> LGTM one question below.
> >>>
> >>>> +/* Handle the following two cases:
> >>>> + * case 1: link != NULL, prog != NULL, old != NULL
> >>>> + * case 2: link != NULL, prog != NULL, old == NULL
> >>>> + */
> >>>> +static int sock_map_link_update_prog(struct bpf_link *link,
> >>>> +				     struct bpf_prog *prog,
> >>>> +				     struct bpf_prog *old)
> >>>> +{
> >>>> +	const struct sockmap_link *sockmap_link = container_of(link, struct sockmap_link, link);
> >>>> +	struct bpf_prog **pprog;
> >>>> +	struct bpf_link **plink;
> >>>> +	int ret = 0;
> >>>> +
> >>>> +	mutex_lock(&sockmap_mutex);
> >>>> +
> >>>> +	/* If old prog is not NULL, ensure old prog is the same as link->prog. */
> >>>> +	if (old && link->prog != old) {
> >>>> +		ret = -EINVAL;
> >>>> +		goto out;
> >>>> +	}
> >>>> +	/* Ensure link->prog has the same type/attach_type as the new prog. */
> >>>> +	if (link->prog->type != prog->type ||
> >>>> +	    link->prog->expected_attach_type != prog->expected_attach_type) {
> >>>> +		ret = -EINVAL;
> >>>> +		goto out;
> >>>> +	}
> >>>> +
> >>>> +	ret = sock_map_prog_lookup(sockmap_link->map, &pprog,
> >>>> +				   sockmap_link->attach_type);
> >>>> +	if (ret)
> >>>> +		goto out;
> >>>> +
> >>>> +	/* Ensure the same link between the one in map and the passed-in. */
> >>>> +	ret = sock_map_link_lookup(sockmap_link->map, &plink, link, false,
> >>>> +				   sockmap_link->attach_type);
> >>>> +	if (ret)
> >>>> +		goto out;
> >>>> +
> >>>> +	if (old) {
> >>>> +		ret = psock_replace_prog(pprog, prog, old);
> >>>> +		goto out;
> >>>> +	}
> >>>> +
> >>>> +	psock_set_prog(pprog, prog);
> >>>> +
> >>>> +out:
> >>>> +	if (!ret) {
> >>>> +		bpf_prog_inc(prog);
> >>>> +		old = xchg(&link->prog, prog);
> >>>> +		bpf_prog_put(old);
> >>> Need to check old? I don't think we can clal bpf_prog_put on null?
> >>>
> >>>     if (old)
> >>>        bpf_prog_put(old)
> >> The 'old' here represents the *old* link->prog program and
> >> link->prog should not be NULL at this point.
> > Ah ok. Maybe instead of using the input old var make it
> > explicit?
> >
> >      if (!ret) {
> >         struct bpf_prog *old_link;
> >
> >         bpf_prog_inc(prog);
> >         old_link = xchg(&link->prog, prog);
> >         bpf_prog_put(old)
> >      }
> >
> > Is a bit more obious to me at least. Up to you I have a slight preference
> > for the explicit more verbose above.
> 
> Regarding naming convention, yes, it is hard. My above code similar to
> kernel/bpf/net_namespace.c:
> 
> static int bpf_netns_link_update_prog(struct bpf_link *link,
>                                        struct bpf_prog *new_prog,
>                                        struct bpf_prog *old_prog)
> {
>          struct bpf_netns_link *net_link =
>                  container_of(link, struct bpf_netns_link, link);
>          enum netns_bpf_attach_type type = net_link->netns_type;
>          struct bpf_prog_array *run_array;
>          struct net *net;
>          int idx, ret;
>          
>          if (old_prog && old_prog != link->prog)
>                  return -EPERM;
> 	...
> 	old_prog = xchg(&link->prog, new_prog);
>          bpf_prog_put(old_prog);
> 	...
> }
> 
> The 'old_prog' is reused in the above.
> 
> I am okay to change
> 	old = xchg(&link->prog, prog);
> to
> 	old_link_prog = xchg(&link->prog, prog);
> 
> in next revision (if requested or additional changes needed)
> or as a followup.

I'm good with this series as is LGTM. We can do a follow up if we want.
Although the xchg is exactly one line above so I'm not sure its even necessary.

> 
> >
> > Otherwise for the series.
> >
> > Reviewed-by: John Fastabend <john.fastabend@gmail.com>


