Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A153D523F
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224429; cv=none; b=QniCtBi/K5GYjQosimlssYmpRJ84ThazBOQncOjihhAMjbVtSHe1oGWhhWAzGeQssyWrlKvjoeYE85ATUax/qADtErfr9nYdGKRzeQDGibs5c51hWnXShtxClmr36TfYzPoonBBEWYrPvp6VZdkri2wvdmePwJatw0ZqFot+MEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224429; c=relaxed/simple;
	bh=MT4fK22X8mUANNVbcNGCtSJF4SKarslaaspPCfEh8VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ch5t2LMpx/Nnnk5Wi/Z/QNIh+k+ezF0FAP33K64mzD6unK2w5t6KyjNuvGyQex36iATeYO6DiEXt7CWZhL2tUVOETRBG8tiR3ZtXbjwkiPNJ7QxRjJnCEHoafQPrOk7XKd0JixJ+hSo8r7IF/oeAYG8b9jDHpiP1mh+DuvHAbVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BBx31Igt; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BBx31Igt"
Message-ID: <cd99eba7-ac03-4b53-a79c-a6206abbddb6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772224425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpRkbLFpzq0Sxq6Rdes1QhO7p/qfB9BnMJ+iX1gkXic=;
	b=BBx31Igta956B8+z03ug1dNP9ae4/LU0YWR/bAnhUWOyK9Rt0j3f2b3bM+Fndb47q7spVw
	cgXI5xOAANH4gIyRjC5zeB1JyiVD5BJMV5xmMhb7PcPsVx6vNbMYFVa6Pr9mt4Jch25JRr
	MdrkccIbuR7Gk+0mMpmTkL9YhMo0lv0=
Date: Fri, 27 Feb 2026 12:33:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpf: fix: Race condition in
 bpf_trampoline_unlink_cgroup_shim
To: xulang@uniontech.com
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, dddddd@hust.edu.cn, dzm91@hust.edu.cn,
 hust-os-kernel-patches@googlegroups.com, kaiyanm@hust.edu.cn,
 sdf@fomichev.me, andrii@kernel.org, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
References: <B97C43D716882A74+20260225065459.2609916-1-xulang@uniontech.com>
 <37aef2457aa50ca719b97ed4f945c6b22c219398d87296c72bcd69a678986ece@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <37aef2457aa50ca719b97ed4f945c6b22c219398d87296c72bcd69a678986ece@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

> 
>> +			/* Reusing existing shim attached by the other program. */
>> +			mutex_unlock(&tr->mutex);
>> +			bpf_trampoline_put(tr); /* bpf_trampoline_get above */
>> +			return 0;
>> +		}
>>   	}
> 
> This commit fixes a use-after-free introduced by commit 69fd337a975c
> ("bpf: per-cgroup lsm flavor"), which added the bpf_link_inc() call
> that could resurrect a zero-refcount link.
> 
> Should this include a Fixes: tag?
> 
> Suggested:
> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")

On top of the Fixes tag, please add bpf to the subject, e.g. "[PATCH bpf 
v3] bpf: Fix race condition...". Please also use the 
FirstName[[:space:]]LastName <email> format in the "Signed-off-by". For 
example: Lang Xu <xulang@uniontech.com>. Understood that there are 
different name formatting but the reviewers can't possibly know all of 
them, so it is useful to write it in a way that most people in the list 
can understand.

