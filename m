Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E780332604
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699747; cv=none; b=MOzKJxcr6r/AFx/Q5hCWQrgFRIMRWOiXr3lcOChDzCtB0ih6Mlr5A5PPgd17Rh/QnbEzL0fE4FuFSDKHXBVoWqeLfusOpzjb2uq3iVYKWoRFXsizzccmX7QvnG1ek2LIcCWlQlNX5OgJJdUAgRMs49Ouc1dx7kPZYjs3H5wArFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699747; c=relaxed/simple;
	bh=44qe80/QSt+UsH5belC7Uf4kOLbqbaTN9nU607Wf6AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMGEw9dOFHaCV9GVJjffu3BorXclZxZDh39aJ4bPLv6Tq0KTr+cBFavTRc4TFtDVgX4c3j51dSYFpSYUR/5PVZfU6CyfPD+Jf4vLw+Wta/JL6GEwIzvTJAGpZaOZlMrFX8c6OUz46K6UJ7exZnfrfGXldYTgg0KZiu+nu/a9mEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5KDz3qB; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5KDz3qB"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so2882963a34.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776699745; x=1777304545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hjg0skzP3DdQUa9EcuJqwNG3yFODQ5AzDlPtuY9w8s4=;
        b=N5KDz3qBJkQYY0kuxbJNvJ9VvySCT4ouS3fwGjAYd7EJFwQb495ltujLtOOjgxEnOA
         CkUqIfCoJXk1VRXET0/ntqbAACz6VhsFMuq+dnG0XQxB1sTXMwhM2X1PijFhiwVsoLLy
         8mRTkB+EXPqRZm4uygVlwoxcLitft8nDkJjiFFbDdw4LpGXFysdHCxqUT61pJnYGH+Fp
         alcbsSwhZpPqVx/ETxQp/vm151eN1iCeVZg1+gi/o/OZgM2BXP1tXCLsI+eUIoEh+HqR
         26x2HEBDIs0LFeitMzltn7yeBNNIu2G5PYIO/uOGs3LM5is9MjYboXZFb2RVOIn7E4Jp
         op0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776699745; x=1777304545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hjg0skzP3DdQUa9EcuJqwNG3yFODQ5AzDlPtuY9w8s4=;
        b=XBzM55fMXMKQlwp9nazlP40rp815s+Mu/K9P84cbhaIMs0T+4tUbCQvwYdkE0ajCyD
         5My0opsnyqfAWppu5ecJe7P7P1XovAL/ohIGxTGJKVteYc6ZV88oEdc2t6GAgUcpks/8
         Vg48FR6Z7z6LtyHU55m0xqgqcl33svX2Yvk4kjRRktbLuZpvlAqVJHicEQD+cavx+dhR
         9vb47BEbkV6cAjH2vfVfw1GVfL7FfqGcn7XQW2NgxNjGkrtRpVxPhMSm9ecI8oSm47zs
         8XDlL1mPRksGhMYkHCExcImExf95XpVEXD7lj20OLUbv02CTTAiTz8yo0imJCU6ZtSMh
         PUkA==
X-Forwarded-Encrypted: i=1; AFNElJ9VpEegZv5+K4AMuubb93czR2kAV2Q4ZQ8fO+eauTJ7/6/xNAD36YArCeRhsIcW6hMwjnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtOUuMOin7Jx5F2ciUTVLiTSyh9C+3EUKv3+MiSmo52Q3SfnQx
	eWp4pF+Tv2ONqxtYF6IyhQNJ+3PIsG/fB5y4H8cX5Nh9YQJQuHXxFt0p
X-Gm-Gg: AeBDieveBmU7PnBhi1+yuhD+xWcr36ZLf1HMpyIvyRDDZl9TWSUCG7YLVNWXp3QJsnv
	nqPfXtr06vLMcsNe83d71d5zsf3dCChXwAyS9os+5cFlxIEawoBkzBuLP5fl+bAsnkF1DDWkzeK
	InYMYs9UjCmhANt6yIZipTNtaje4kNRJFywR12YPwvP6WZjzad0n3e6Gbyy5bTmU79DOZkBTBp1
	Mq2NxfIvVnjsVb+IxSKnUXbQwntivqMbFVWo1FpUCndb2DsiDNpD9xs7YaCN4gZi6JModOZJlVH
	chQFbrxmgaR4zWYKjSD7S7CdqBejFgDVw7eea3LYj2HF644S+o7LsYILQif93lfQ8OIGvutELTS
	aSVu8qQEzfvxozlU6krUsJolSBhm1i6SOVfRhXwh9glFOJ9NEBUBakXRY8+bJiwmm2fcDTf+7X8
	FHXkqWZO9gAY707FMFeSWadwZZXSOZ
X-Received: by 2002:a05:6830:6724:b0:7dc:c4ae:a679 with SMTP id 46e09a7af769-7dcc4aeb1c5mr1428895a34.9.1776699745301;
        Mon, 20 Apr 2026 08:42:25 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc892c515sm1707582a34.21.2026.04.20.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:42:24 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:42:23 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 1/4] xsk: avoid skb leak in XDP_TX_METADATA case
Message-ID: <aeZI3ig6w0PhGaVU@devvm17672.vll0.facebook.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
 <20260418045644.28612-2-kerneljasonxing@gmail.com>
 <aeZEjZSsVIdpcbFF@devvm17672.vll0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeZEjZSsVIdpcbFF@devvm17672.vll0.facebook.com>

On 04/20, Stanislav Fomichev wrote:
> On 04/18, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> > 
> > Fix it by explicitly adding kfree_skb() before returning back to its
> > caller.
> > 
> > How to reproduce it in virtio_net:
> > 1. the current skb is the first one (which means no frag and xs->skb is
> >    NULL) and users enable metadata feature.
> > 2. xsk_skb_metadata() returns a error code.
> > 3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
> > 4. there is no chance to free this skb anymore.
> > 
> > Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
> > Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Actually, I take that back.. While looking at patch 2 (which always
confuses me with that -EOVERFLOW handling), looks like we set
skb->destructor in xsk_skb_init_misc? So this kfree will do
xsk_cq_submit_addr_locked? Not sure that's what we want? Should we
move xsk_skb_init_misc to happen after xsk_skb_metadata?
