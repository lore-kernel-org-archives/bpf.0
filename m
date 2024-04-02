Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F939AD5
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043066; cv=none; b=cdvevwnBqnWbNEBoWW/L8UShtot6NayEtgLySGrnX+Jk8wQFPvOrYWX7EKw5CUqDqrUEJH/WknCgZYDOUELUHXxeVOwmzVFPE8gXyhVUUC4G970DarxncGWf0u+khpmdpxZ+co+R0BBls5SqCWPBAGEgmVjtM64/e7U6tphGa3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043066; c=relaxed/simple;
	bh=YSIQVU8uMVDWEFMAGJWNOqrvDkrVgk/wDO3mSM/idBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goESNUSFyKxc67G8MF86Hh/cIzKYytbGU0z8QBIE+g/w2h6orGTFGcPfhwbk0laA+xDTZkETY6/s3MzU+BOaoNJwvEKOKL2dHTT0/bLtoSUqZlV7pIe+yJnLSW9DcNBtrOF7W/2ffAYH02PpqtedynFyV92tzxqec5v9D18Qlno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=B3JDoEdB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="B3JDoEdB"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so5485620a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1712043059; x=1712647859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwHz+LMpbeIvERJGdCU9Ke3M456sDuvdJVqWt1f7Txo=;
        b=B3JDoEdBelDfBAYU3ReTy4STlmFX34uEtNGoKdKA5FnvD/4c8VKoG4nXBak16urKDP
         Mf3/9TpMyKGOb8dw8qvH/++MmxrsebdojA5rtpHcS2CSIDR5KlygDgg+AhurLLi69/rI
         MKpjN+3ncSRSSM4moPGNCxoIkOWeO/gDzt8JJCWQVAnpH0DCcQmfH2kYPI9G+m3JAwAQ
         XFE6+jliB7543+5ymaHv5HQP2tMS/aOyeGzZm787e/PxqzWZVokJpy0Bp02y77KZtgA6
         I2aLhydh+X01xxvVoo84SzcOo2+7J+5Xmeoe3dn6IYD5g5iT5YpyaxSxgWKiRO+wawmX
         jCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712043059; x=1712647859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwHz+LMpbeIvERJGdCU9Ke3M456sDuvdJVqWt1f7Txo=;
        b=Gh/8scZAYi5nIpqCwzDa5Q/hXeL2s/Y+KbOaroQFHYz3x37e1RH01PFU5/+eiIeR4i
         Hi4AX/wZYicfqJqyMeROEAxsPxCYEIYHjB4ddr9whzYtBJ1TCjDcTH9cZFkL9C/omZSR
         2U6YX+89B3Qx5k6he0q8oWZAPCY0mENTF7VLNdGYtpEz/1ZA11t93UR3arCtmSsPCygM
         +W4SpkBIvxLgsVD1uqWThGiY7+v7bbarpWonkHg6ttnLbVK63hOxydfwUEm93l+tSRFW
         KUuDA0o17TgU0uIbZ/0usuFBqfIdYQdeDULeGEBk67Kadu26WwIp244c4cBER1nY+PKK
         MHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlT7Ye2xRXG4qKepzkq8qOKiPz5e3iC9am/cLAECNEQXE+H/tjinMbYqNKp4onO5776D+rL/f/vNiRCHjv9D1Y0Zy6
X-Gm-Message-State: AOJu0YxzDX9OtD3RmhuC+7z+9Hpz5d6e2AZdRE0JW9pTAwoeUbPKxEiT
	30Rg4inRFhtquvPz1uscntCspY/XqZDhebYpE5lpO/Bkp7KoZVp5+KpvYZ1ExAc=
X-Google-Smtp-Source: AGHT+IGTaBxKvNIyZXTm2H9pMwK7UvJisocuMQxZ4gUXAQ67e8MlTZi72kKOtJ9AFDJ5HqY/kjeWiw==
X-Received: by 2002:a05:6402:50ca:b0:56c:3644:9945 with SMTP id h10-20020a05640250ca00b0056c36449945mr10636067edb.7.1712043059292;
        Tue, 02 Apr 2024 00:30:59 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id u22-20020aa7d556000000b0056c63ba1387sm5130096edr.86.2024.04.02.00.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 00:30:58 -0700 (PDT)
Date: Tue, 2 Apr 2024 07:32:55 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next] bpf: add a verbose message if map limit is
 reached
Message-ID: <Zgu0p8dnQmstDidp@zh-lab-node-5>
References: <20240401100132.167226-1-aspsk@isovalent.com>
 <660b6441860a3_801520892@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <660b6441860a3_801520892@john.notmuch>

On Mon, Apr 01, 2024 at 06:49:53PM -0700, John Fastabend wrote:
> Anton Protopopov wrote:
> > When more than 64 maps are used by a program and its subprograms the
> > verifier returns -E2BIG. Add a verbose message which highlights the
> > source of the error and also print the actual limit.
> > 
> > v1 -> v2:
> >   * make the message more clear (Alexey)
> > 
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >  kernel/bpf/verifier.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index edb650667f44..559526191ae7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -18348,6 +18348,8 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
> >  			}
> >  
> >  			if (env->used_map_cnt >= MAX_USED_MAPS) {
> > +				verbose(env, "The total number of maps per program is reached the limit of %u\n",
> > +					MAX_USED_MAPS);
> >  				fdput(f);
> >  				return -E2BIG;
> >  			}
> > -- 
> > 2.34.1
> > 
> > 
> 
> LGTM thanks.
> 
> Acked-by: John Fastabend <john.fastabend@gmail.com>

Thanks. I will actually send yet another version, hopefully
the last, with 'has reached' instead of 'is reached'
