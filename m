Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76CA3921D6
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 05:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798907; cv=none; b=aK8m/uYlY6tzOwSgR5+dVp7+E8qaA2Mw5V/K4TqUdBwoSBW0tUXnaKrlKZfTYG8qCgX2i3cRXhtms72EEt4YheVJAj5RCEFkmd+glilq0UiRXbXWAhsVfPJmqj7up5Va5V9Npm7gy3J+35QgK+KG0/0Apnm4FhHSXDrkfUvOf18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798907; c=relaxed/simple;
	bh=YKFWyTJLUTxxYVvZplXVHXFI3TQIqth3bMjJoNkBL34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3MS76f/zjLreAQUvLDeiWf2debxdp9nd46H7i+GDSKciCUjvahI4bmT1uMiibuMSSirDM+R+2RTCc2SxMa+pw6I3LHcI/QzmJwnYSJLo9TqfsrMf8V2tp26qDaEHsRzBMEqlGNbuyYQvosKxmfsICFRjSEqORoVSsUWvfO9clE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ih455+Pk; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ih455+Pk"
Message-ID: <96cbecfc-bae6-46ff-90a7-5f4703e1c44c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782798903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=scfsBcrp5sP/p5keaZMjAHWISXs6PJ18eXzmlC0US1g=;
	b=ih455+Pk8YJiLhsEVXp6R6Uljcr2AwZTJzZ/jcYszlHwQAljeB7oc87TkmBaZfb/gdKFLJ
	8+xR84XpJRCioof3RMTOPSAOUkikmcIbdx/6v/jcy5gG179E96v2+yRsCnhWWXoZ/5RbgV
	6Di/7qyzZknt8PxYdsi1YJ10WNLgKSk=
Date: Tue, 30 Jun 2026 13:54:48 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 4/9] libbpf: Add support for global percpu
 data
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260629152406.52582-1-leon.hwang@linux.dev>
 <20260629152406.52582-5-leon.hwang@linux.dev>
 <20260629154055.6DD941F00A3A@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260629154055.6DD941F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/6/26 23:40, sashiko-bot@kernel.org wrote:
[...]
>> @@ -1983,7 +1989,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>>  	}
>>  
>>  	def = &map->def;
>> -	def->type = BPF_MAP_TYPE_ARRAY;
>> +	def->type = is_percpu ? BPF_MAP_TYPE_PERCPU_ARRAY : BPF_MAP_TYPE_ARRAY;
>>  	def->key_size = sizeof(int);
>>  	def->value_size = data_sz;
> 
> [Severity: High]
> This is a pre-existing issue, but could this integer truncation lead to a
> buffer overflow?
> 
> If a user supplies a crafted ELF file with a section (like .data, .rodata,
> or .percpu) larger than 4GB, the 64-bit data_sz is implicitly truncated when
> assigned to the 32-bit def->value_size.
> 
> This results in a smaller mmap allocation based on the truncated value. Later
> in bpf_object__init_internal_map(), memcpy uses the original 64-bit data_sz:
> 
> 	if (data)
> 		memcpy(map->mmaped, data, data_sz);
> 
> Can this overflow the allocated buffer when parsing unverified BPF objects?
> 

Sounds reasonable.

The data_sz value comes from the ELF file and therefore cannot be
trusted, as the section size can be malformed.

For example, readelf -a shows the following for a normal ELF:

  [ 3] .data             PROGBITS         0000000000000000  00000040
       0000000000000004  0000000000000000  WA       0     0     4

The section size can be modified to:

  [ 3] .data             PROGBITS         0000000000000000  00000040
       0000000100000001  0000000000000000  WA       0     0     4

In this case, data_sz would be truncated to 1.

However, in practice, there won't be larger than 4GB section in bpf ELF
file. And, it is meaningless to hack libbpf to corrupt user space memory.

Of course, will post a separate patch for further discussion.

Thanks,
Leon

