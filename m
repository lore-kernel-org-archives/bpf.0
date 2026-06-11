Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831EE2D780A
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 05:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154607; cv=none; b=KVzgB6wo+UT3P72eKX+HHEI9PLTtNC5BFhnlJKRvIegRXL3Cb3iLpiRr1DslgPYvAwXoTWeFR42ypiBIGnSAwnw3nD/DfotJyR27E6Rv0fgGcBPbzgRCZWsL/UelME31rkHhGeT42526tdCOMjzhV9HqMeWiKJIhh+bwTJ3H2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154607; c=relaxed/simple;
	bh=z/DHXPmt9zCySDr/M0U+2D0wie5JQGoTyWwU4ttjJ4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6EPRa2H6XJH7+xCB60nqq9Y2jh2CshXovb2mVBfgLSmjEitv5R+oHjFTOipDGTvL0X81wNv1G4ucNK696a3QIfAwbzi8tAdGvqLSuFKIU5WLHZ0KigDu9+r/4OLroxm+bozXZTSltBQ0i/bfZdyRXRHlLDs+WiLcZljqL2c3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xDPnlm+J; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xDPnlm+J"
Message-ID: <6b2be62c-bcba-4bfd-9006-613f9134aa3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781154597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6UD8muV8Jcg0AZHQWSeCaLakAseTNRvoqY9r4Xc6FM=;
	b=xDPnlm+JCDWUoUkpH3oIGlJmB9sInKTdczo14RrOGloCLOQbmctrU5pvJpUmqBk4qQeMLO
	BRmITRdG6iNKuiKv+t7Obc5oPv5VBz4xZbCe7kQsY5US0Hs3cRtPvLNnQdwD/zpZCGpYWy
	lGi/ds3f+uf2zvSx3JcP/2qA17EvANQ=
Date: Thu, 11 Jun 2026 13:09:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 5/9] bpftool: Generate skeleton for global
 percpu data
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 qmo@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260608145113.65857-6-leon.hwang@linux.dev>
 <f7c7f1ea3da3115928819d4b4071cde9bda3786ffaf1fd60b06180719d64f625@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <f7c7f1ea3da3115928819d4b4071cde9bda3786ffaf1fd60b06180719d64f625@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 23:29, bot+bpf-ci@kernel.org wrote:
[...]
> 
> Does the generated light skeleton need an explicit mprotect(..., PROT_READ)
> on the .percpu initial value buffer to enforce the read-only constraint
> described in the commit message?
> 
> This was raised on v4 (https://lore.kernel.org/bpf/20260414212650.4F89BC19425@smtp.kernel.org/)
> where the response was that the mprotect(..., PROT_READ) added in patch #4
> should be moved into this patch so it isn't missed. The v5 code here looks
> unchanged from v4, and the mprotect does not appear to have been moved in.
> 
Will add mprotect(..., PROT_READ) for light skeleton.

Thanks,
Leon

