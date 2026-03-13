Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667983DDDB0
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426729; cv=none; b=BK71AXADvObpT2M/key94EtBhSGEDZK64edCHUqilyef4dnlEp+HZSheK6yiYdeojPtCzXyQQ6jfhsrvRQfEq8xU0qf91oCxQT1OZ4WtBUG4eBEa+Jqdy4sS9OW2KKl706d1vBvL6x/Yutc60xlTigFvpIsB33jv/Nr4dtJ9UM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426729; c=relaxed/simple;
	bh=AaQFuMvnjyDfkeAZUTpVvS2snrH40JPIo9mAFraFUFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYdMh7EgpcmhZ4KuYWC+Sa6KOEQ24ob3FX9dME648TPABFI6/VRiiiD8tFxQ7+j7dhncVtIridY7p2TKUqQFsbzDm1ik+CX5TNGir8p5urezDMCuT8I8i5i33G0VUpKPWVo7Z6NJUJigEeYPITr9C0Yi3lQlid/9WlUGeLrr8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZCXF5YQk; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZCXF5YQk"
Message-ID: <a370fae9-ffcd-4713-a2a8-1b9df5c51da9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773426714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fk82VMnZFWi3o0UqGB57eiM3JaDB+xZIyM+NQYIb1U=;
	b=ZCXF5YQklKw/C3uYEzHN1YytSfaJbBQzUiaPNwM8A9W5Hf1eEbkk/fERJHg1jpEWwli4nv
	9YwwGQk4M7aVGQvKERRrcwFHf8FSBhziGkqbzQ952NWE+WsnZ1wYFXAZZ+YqxjFqX3KPwQ
	bRX7914VpPsVOqB57hn4aTq+zcr3IbY=
Date: Fri, 13 Mar 2026 11:31:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] clsact: Fix use-after-free in init/destroy rollback
 asymmetry
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 jhs@mojatatu.com, Keenan Dong <keenanat2000@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260313065531.98639-1-daniel@iogearbox.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260313065531.98639-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/12/26 11:55 PM, Daniel Borkmann wrote:
> Fix a use-after-free in the clsact qdisc upon init/destroy rollback asymmetry.
> The latter is achieved by first fully initializing a clsact instance, and
> then in a second step having a replacement failure for the new clsact qdisc
> instance. clsact_init() initializes ingress first and then takes care of the
> egress part. This can fail midway, for example, via tcf_block_get_ext(). Upon
> failure, the kernel will trigger the clsact_destroy() callback.
> 
> Commit 1cb6f0bae504 ("bpf: Fix too early release of tcx_entry") details the
> way how the transition is happening. If tcf_block_get_ext on the q->ingress_block
> ends up failing, we took the tcx_miniq_inc reference count on the ingress
> side, but not yet on the egress side. clsact_destroy() tests whether the
> {ingress,egress}_entry was non-NULL. However, even in midway failure on the
> replacement, both are in fact non-NULL with a valid egress_entry from the
> previous clsact instance.
> 
> What we really need to test for is whether the qdisc instance-specific ingress
> or egress side previously got initialized. This adds a small helper for checking
> the miniq initialization called mini_qdisc_pair_inited, and utilizes that upon
> clsact_destroy() in order to fix the use-after-free scenario. Convert the
> ingress_destroy() side as well so both are consistent to each other.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

