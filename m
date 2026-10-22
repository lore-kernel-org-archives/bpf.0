Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658254;
	b=vQ1/GvNR+bqRUaVbfNoZLMuCjmrFaoChD8WaRuViM1ke/PJYDH2wiWQou2kXGOwDMQtx
	 QLbQbwfDDHLYG8b5owuxjn14bsVGi4yQG1oTgFzfBp346Q9rpv7VmgEJo24oc9k9o93eU
	 bUaEETn+gh4SMg5m3r7wbvIRYH02WwE0epC1T4kSQwI2TVL9fslUFhzbMUW/C6CBuR2e2
	 Gax82TC1CtXymZ6ukOMTffjdxf4a1GQLSxCbPHWDJOGsS5dEIBydeZFgQwSY1HMVFC+OJ
	 Og20W1WfOekRZsMFrr5DrfJo7VeLqT9DMBRztoQ5YRGNdzedABe6O8DeK7kAbHI7EJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658254;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=nf2rf64lDODkFU/Sz05if+EIMuT32Ufsqi9npDTFSh0=;
	b=GXwJFChrDIjJT4/1a1W/pkWTom/obWy681ta9P4Jg8GEWjwn1G3eP97IHvwNqx9mneKY
	 ZZrAZf4s3WLotOM9/xaotrjQGkzd7sp0xpxmO6NW7p1E9d9S5vZ3zXygSb+Y4ERitml7H
	 pilFlGO+jnqCVoBvAJ1hqnRTPZZTOZHWuDu5lbimQ/5jGcIcrAED11IzJu3KrX/zzs0M2
	 nVilepMFb4ZtRhXRNyX9LUARDa6ERelgfN3BQcaBT97X1fz1vbRCCeEjIXaMtFx0s78Pv
	 faQ/GQHlklnYtgT9m0HTY9dmT+tADosqI3QtBUHw/+4hY6SFC2NT3zLz15XFYRXzpiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcVH9IiN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B6D606A31A;
	Thu, 22 Oct 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BcVH9IiN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341E21F000C1;
	Thu, 22 Oct 2026 08:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792658253;
	bh=nf2rf64lDODkFU/Sz05if+EIMuT32Ufsqi9npDTFSh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BcVH9IiNbDgqpzPXwBJHCK6no7/QUMtf4LHBsuCP/cllkNCeh8N3X0OoDLjJcK/Ww
	 Q4kKEKLJokhPnxRlzpcUvQKVyy4d46q21CzIBA0LjKCBbgH3Pl75rdu4706KH+ht/G
	 XsgijaL0I+c+1LK0aR9MKe5tuB3YoeLmaUFH71aeLgOGWBr2WZgfczJyWkEVaBP5lv
	 /2ExxU1hyDhkO9xSCgbzTVCF4kB+Q2HWKZtCoTsul5Rpp4TzQosS+i4VMorS9Fr5m1
	 +NWqOsuSU+pXPpAt7TVJAOTOrH78mbH80bYwMq/chA7kwhoAJIuqkhcVuSEnH8pOsK
	 0q1fZ2a3WXDSw==
Message-ID: <2bedd979-cb7c-496b-b96c-da58add5e27d@kernel.org>
Date: Thu, 22 Oct 2026 09:37:30 +0100
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
Subject: Re: [PATCH bpf-next v9 1/2] bpftool: Add recursive map dumping
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org, skokovmaksimevg@gmail.com
References: <20260926014208.24773-2-hi@tychen.cc>
 <3acbe829-06f0-4df4-b57c-a8c7b802ec96@kernel.org>
 <179061597606.1293644.6733910074393293547@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <179061597606.1293644.6733910074393293547@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-29 02:19 UTC+0900 ~ Tianyi Chen <hi@tychen.cc>
> Hi Quentin,
> 
>> We'll need to fix these, but this should be a
>> different patch or series. You're welcome to go at it if you want, I'll
>> send a patch otherwise, just let me know.
> 
> I've taken care of this in a separate two-patch series:
> https://lore.kernel.org/r/cover.1790615923.git.hi@tychen.cc
> 
> It clears info and resets len before each query in do_show(),
> do_show_subset(), maps_have_btf(), and the existing do_dump() loop.
> The four regression subtests fail before the fix and pass after it.
> 
>> I would maybe move this
>> memset() (the hunk above) to that dedicated patch.
> 
> Done. The resets in the two new recursive-only loops stay with the
> recursive implementation.
> 
>> You still have a conflict with Maxim's series on patch 2 though, both of
>> you picked the same test file name. Maybe use
>> bpftool_map_dump_recursive.c instead?
> 
> Done locally, including renaming the test entry point. I tested against
> Maxim's complete v4 series, keeping his tests intact: all 21 focused
> subtests pass in an x86-64 VM.
> 
> Thanks for the Ack. I'll carry it forward and wait for the prerequisites
> to land before rebasing and resending the recursive series.

Hi Tianyi, Maxim's patch set was merged last week, so could you please
rebase and repost this series, too?

Thanks,
Quentin
