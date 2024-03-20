Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F43EA62
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710937437; cv=none; b=u5gdarnLFbUsdmy3cgD6q1FWZ7CMZkMwUNuSjYPe7R0E5+Oj515le9XT++yQy6jKxMdWjtr2SW/OSq0KFCRHcsGcYD3QikxdZxtnp0/4reSZHOcgLQ8x3PTwjyBzyBCnhX5dbpDXpVeZqpgqmC64ldy+uejTi6B/6sudV2Z/rxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710937437; c=relaxed/simple;
	bh=256hIVOWqKGNs0clZdEecQjT2nDPiAh+uHQB0f0lp0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEJ5XSZSYneH1Z7r08pri+gZRx5YarEJr3AH7Y3nCN0J+lGlfxjWeBCKB/tFAi86NCDoERQ2jl1tcq1NIrpN/8S5keBXtB9yWOZf+joLfi/oGoS8TDrTHXgpI/Mt6w5+DnqeSKAxOO9CLbiFWUYrMqsVfGIYWxgeWccUS9Rnsvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NSUiLflQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NSUiLflQ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41400a9844aso5103405e9.0
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710937433; x=1711542233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=256hIVOWqKGNs0clZdEecQjT2nDPiAh+uHQB0f0lp0s=;
        b=NSUiLflQsFZrJcTy9HNt0D+03APSNlTLySOzRCr8/z2df6InbuxCojYJqk9QBWxlVD
         1TfM4ipK4kasMHBrNmQAKQW8o2MdNQPEoZecWJGCUFyMBdyCpUEzdFa5CeCCo6dDcSxX
         JpmU4mwSmSNKXGhZ0rFP0O3wlPwJrri9aN5L4N7qLPhtSurYDoaVlUBGAppPahKDNstu
         ENtke0L9J4A29aWIPAnlyZMWrt/NgfyDmW0tdYU48vaIF1vuZCFsfZR64CS1QE2f22xQ
         JD0S0MIF+TmebuIIVrvcYBWjQSsF1cn7/k7c8UeLHPaJE2EUIJS+fVrucMO6+yfr3yct
         ulLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710937433; x=1711542233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=256hIVOWqKGNs0clZdEecQjT2nDPiAh+uHQB0f0lp0s=;
        b=rrRNC4WJpsO4gIBkIul323+ScR5ynNqOBs18qEwG7EmUxdNEkTdy7cjPTw+DfgWkV7
         uV9zUt8/z7B5Qs4ccpcovIedJGQOd3vJVyKXlUO6hypgPkYDbyaOwHrH7B7IRcsuAhWF
         P4FV4Fs3bf1I8j63t0Wg3ZhHUoIsa1z7he3F1KKVbJ8xTgpB199TiRok5itGodeZR/Wu
         OLfqm32XUJKLQJnlEkvvMZwFoFCCrV509aXr7cTQvGr1STFT9qRixo3PSopNbsX8ruxh
         rHwjk3T5CHpb6FMdzbh8GVmAd45L/Blsem1bD+pvX+/HptGkf1EovPauD1glh3Q7Je0Z
         M1sg==
X-Forwarded-Encrypted: i=1; AJvYcCWWueJvt71PynYs2H259MR3LVt5axUAZuCYb8zD3OXA2nRF+uvGG7Ix7BDZFKqReEPDNf1IMe+n3gmDIT35FcD3TwVO
X-Gm-Message-State: AOJu0YwcjvRx1iV6W3OLAizUOF47PF2qlP6E7zsXFhpkBC/JyE8glxVy
	uBBAizIyzL3hpiaUiAsPPt9DfPnYfRVAsm1QFkzkKHQco7mpRhsEqo0WC3/jc9A=
X-Google-Smtp-Source: AGHT+IEeP+QulfChhn2oDlevD/cXp00IH9MWfPkU71hEwGa+tm6JDBn0nfQzXtMpTmqHCqJzlI6TMw==
X-Received: by 2002:a7b:cbd0:0:b0:414:6467:d8e9 with SMTP id n16-20020a7bcbd0000000b004146467d8e9mr2347163wmi.17.1710937433216;
        Wed, 20 Mar 2024 05:23:53 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id z20-20020a05600c0a1400b004146c80ade5sm1725802wmp.12.2024.03.20.05.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 05:23:52 -0700 (PDT)
Date: Wed, 20 Mar 2024 13:23:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael  S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Message-ID: <ZfrVVGUG5rGZxjRx@nanopsycho>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <Zfgq8k2Q-olYWiuw@nanopsycho>
 <1710762818.1520293-1-xuanzhuo@linux.alibaba.com>
 <ZfgxSug4sekWGyNd@nanopsycho>
 <316ea06417279a45d2d54bf4cc4afd2d775b419a.camel@redhat.com>
 <1710921861.9268863-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710921861.9268863-1-xuanzhuo@linux.alibaba.com>

Wed, Mar 20, 2024 at 09:04:21AM CET, xuanzhuo@linux.alibaba.com wrote:
>On Tue, 19 Mar 2024 11:12:23 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
>> On Mon, 2024-03-18 at 13:19 +0100, Jiri Pirko wrote:
>> > Mon, Mar 18, 2024 at 12:53:38PM CET, xuanzhuo@linux.alibaba.com wrote:
>> > > On Mon, 18 Mar 2024 12:52:18 +0100, Jiri Pirko <jiri@resnulli.us> wrote:
>> > > > Mon, Mar 18, 2024 at 12:05:53PM CET, xuanzhuo@linux.alibaba.com wrote:
>> > > > > As the spec:
>> > > > >
>> > > > > https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>> > > > >
>> > > > > The virtio net supports to get device stats.
>> > > > >
>> > > > > Please review.
>> > > >
>> > > > net-next is closed. Please resubmit next week.
>> > >
>> > >
>> > > For review.
>> >
>> > RFC, or wait.
>>
>> @Xuan, please note that you received exactly the same feedback on your
>> previous submission, a few days ago. While I do understand the legit
>> interest in reviews, ignoring explicit feedback tend to bring no
>> feedback at all.
>
>Sorry.
>
>I have a question regarding the workflow for feature discussions. If we
>consistently engage in discussions about a particular feature, this may result
>in the submission of multiple patch sets. In light of this, should we modify the
>usage of "PATCH" or "RFC" in our submissions depending on whether the merge

No, just wait 2 weeks, simple.


>window is open or closed? This causes the title of our patch sets to keep
>changing.
>
>Or I miss something.
>
>
>Thanks.
>
>
>>
>> Paolo
>>
