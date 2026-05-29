Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51BB40149A
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780078319; cv=none; b=acMeBx9C2rKQDZamX2eNPX9HGcIEAeKIWTllJq/66CSe70B0RrilzvWTlIBtlG4eW9liOF3uYkazcCnJAuoyySgj/c3VbwRSf2CU3OnUTa3+9Q6DAYrVCG4fp+dY5ycT5T4U6c9lbPZU5mY++zNQGpoInNjWZzpCGmf5Y8D32rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780078319; c=relaxed/simple;
	bh=yXeAzLn9NcfhSemxluW6MU0ogcDKqa8DhIlsYmpX0Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVIAL1ukP5pCAlpFpMNi9aGmcykXtkVUjRLcl6fbzsyRj6z9Ss5D5MPSaQNXitODG3DeyL4CusvlzYH5tzqvnE4kIbcjqQNHos2wnzHUQUuqg5cCcrWdxpcdH+5x+k+H4a9xNsmVujYXGVrL4dPWUVoMj7DC4dquuC1CdEODWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TtJ/c8cZ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TtJ/c8cZ"
Message-ID: <2fb9e4df-d906-46e7-8239-79025b628e5b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780078311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MexmIPrUohugpiijFiu328LdXV+dU5AGgrmgQ6bbklE=;
	b=TtJ/c8cZAm3ddlCsH/QZK5aGOBx3JDFTGuIDmAqcakotlyNE55vP8hlJJvJBAW0E9gSrQG
	TsZrvPvmU4NNI02nPKxrGrUpkYThIpQx4bLdK1eSWfd0t5+pATBQlHKpiTah+/UI+M6Od7
	et3RISRV+eVkhU46N5RadQuLWT6EWIg=
Date: Fri, 29 May 2026 11:11:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE Patch v2 1/2] dwarf_loader: Extract
 die__add_btf_type_tag() helper [NFC]
To: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, jose.marchesi@oracle.com,
 David Faust <david.faust@oracle.com>
References: <20260528223616.2035618-1-vineet.gupta@linux.dev>
 <8c8826d1-6534-4aef-8129-5c8da61f731e@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <8c8826d1-6534-4aef-8129-5c8da61f731e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Alan,


On 5/29/26 06:23, Alan Maguire wrote:
> looks good Vineet! One small suggestion:
>
>> +static int die__add_btf_type_tag(struct btf_type_tag_ptr_type **tagp,
>> +				 Dwarf_Die *die, Dwarf_Die *adie,
>> +				 struct cu *cu, struct conf_load *conf)
> maybe just change the function to return the struct btf_type_tag_ptr_type *,
> since consumers just check for non-zero rather than doing anything with the
> error code?

OK will do.

Thx for taking a look.
-Vineet
