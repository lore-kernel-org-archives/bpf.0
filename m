Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8533054C7
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 05:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154714; cv=none; b=YBtz0blTXFqkPMu2kDoMwLU3tc/8WGFK3zENORBfNcIIOpY0mFr95CugU4HbVI2tZiIgFDq/ZdfS/h6RTfc66EV1zSQQovxUepYfO19qyAd0n8dLSI1MQNYNkVzkmONJ981Y5xdNV1vZUP6Lih4vkfj5VuNdJdAd5nOaocfg4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154714; c=relaxed/simple;
	bh=IHkpllnRQZDcX0DTmTn+wvaxGkGt2WE2obabk4MTrVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hk/rDAyghvyReErgEgky7oNsF52ua9cgTNRD7zJLy0WCNkfJq00AVIi7CO6Avm/vrNKeaQf1Rkmy91PoCai4afdjelbPNRYTpx9FBQ+NOeHvXc+yHh/i8rwcUKtTVBdqg8KoFuNpDlsL5CXKq+MaaCvWpi93zs8L9NyscoQmbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cWxPq+qE; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cWxPq+qE"
Message-ID: <6ba1e89f-e235-4d53-b447-0d42c05a9860@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781154705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwtNPA9q+tRge9tQLpq9BQpy+zcaLUJLjfPb1GzOIqQ=;
	b=cWxPq+qElJb7FfLH4KmOH/hobLAQRmI9YftKZEVprnRbWlMOnVzKsYNsS8L4YRn73U5i24
	UgPtYY13gmNS0hcyKAZUw1Y5fcWqqnHkNuuLkM2X23V7w+DDySNFfRc3WGUZ0Z12yEnl/w
	T8EobDOO3Wsy42MZAcoFDHMncq/ZVJc=
Date: Thu, 11 Jun 2026 13:11:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: Add tests to verify
 verifier log for global percpu data
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260608145113.65857-8-leon.hwang@linux.dev>
 <20260608152227.E39071F00893@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260608152227.E39071F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 23:22, sashiko-bot@kernel.org wrote:
[...]
> 
> Could RUN_TESTS() be used directly here without wrapping it in
> test__start_subtest()?
> 

Will call test_global_percpu_data_verifier_log() without
test__start_subtest().

Thanks,
Leon

