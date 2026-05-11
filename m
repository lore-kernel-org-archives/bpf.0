Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F240FDA0
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514826; cv=none; b=hZigSnewWrNlADzIq65Tubntqt63ry/yTuOKtQouu3p+7gFoOFGzvYUkYyPdFvuSBWWB0A9N4Wc//rDZo0LH5mKhMvqORYJ2qrZCTXik0dQrvn/3PHYKxv6zpRdZzsdoV/PjkREOrMTjenviq8jZmwtIAxCdX2zBiSBEnJwdVV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514826; c=relaxed/simple;
	bh=Vpl4AB81t3kTVUM/aLTW/IzGnBwitnH7nW9im2LJ4wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UCSf5qZCV/+7W8ulwyQi/YVow6Hgtsrt2gKyK7qht1PFBvDCO9ZNFyciAFZP24PWS5DL6Gx39fhZCawzy2JTKWzfk/ox+kRUe+eh+ehsqC8IHJgD8xthYhHxZAJMhIkB0YmadxxduT9siubT8zOYmThxQHZ0JkfYHqgVC0We8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wXrOGy6m; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wXrOGy6m"
Message-ID: <ec18cff8-a760-4bcb-b5bc-604924ff81ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778514821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgghiOn4QL0DknihM2I3g7BaZIG+PGQeD3IeU8ln93Y=;
	b=wXrOGy6mRb9K95gLTegolwNdbg3O2LcWihJMgdswQf8GSgm3XwUmYkzu70tR71hinphf6+
	brk4GOTTvAIAgv1h3uWgpZUKI6Y3HygU8RwN6BCG7oZKjvzOYUm4c5BJiez+hu3ag6sCJH
	htFJoylLxbC9xYa5Cl+fPk5YXNA3Jv8=
Date: Mon, 11 May 2026 23:53:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [QUESTION] BPF_SK_SKB_STREAM_PARSER cannot observe strparser
 orig_offset?
To: "Cristian Morales Vega (cmorve)" <cmorve@cisco.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <SA1PR11MB68483E0B4C78DA91FF8DCE7AC0382@SA1PR11MB6848.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <SA1PR11MB68483E0B4C78DA91FF8DCE7AC0382@SA1PR11MB6848.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/11/26 10:49 PM, Cristian Morales Vega (cmorve) wrote:
> I am trying to use BPF_SK_SKB_STREAM_VERDICT in an old kernel (I don't have control over the version), so I need to also use BPF_SK_SKB_STREAM_PARSER. I though to just do "return skb->len;" in it, as a no-op, since I don't really have an use for the parser.

Since v5.18 BPF_SK_SKB_STREAM_VERDICT can be used without 
BPF_SK_SKB_STREAM_PARSER.

Which kernel version you use now?

>
> So far so good. But I can see that, from time to time, __strp_recv() receives a non-zero orig_offset as "first skb" (i.e. strp->skb_head is null). In such a case, I should not be returning skb->len but "skb->len - orig_offset" (i.e. orig_len), right? Otherwise I would enter
>
> 		extra = (ssize_t)(stm->accum_len + cand_len) -
> 			stm->strp.full_len;
>
> 		if (extra < 0) {
> 			/* Message not complete yet. */
>
> But AFAICT BPF_SK_SKB_STREAM_PARSER doesn't have access to that offset. It seems it had it until e0dc3b93bd7bcff8c3813d1df43e0908499c7cf0 (which was backported), but not any more?
>
> Is my understanding correct? If not, what am I missing? And, if yes, there is any solution?


If you just return skb->len only in your parser , the 'issue' should not 
happen.
