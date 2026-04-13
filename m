Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D73B38B7
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075849; cv=none; b=bsAc4YWQMIjkgYPuXFM2pkzlN1qxX7ZoAY5Vnsof0m9SOCsQOQq9p2NBUEPfdc+Tt/eRwE77lVRnL68pryX6bXa3YORij7Wr9U2KUHSQhDECl60TcgY0EGKYrdHJtvycsMkTgD3SaI9LPXwI2iT29T43064wbga++n+wdMrYAqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075849; c=relaxed/simple;
	bh=rvhDlVkS/F0a3togyIfRJfsd2icU3DKuckGja6fdFNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEknx5ifSh/WyxCkjSlz0R3fjMcgwbx9HJ/z+vozvCRDPhP2ybxV+h/99SY1GfcoNbkBwTro7Jl+OTCgqcsRG8V5xGY7cQeI+QTxjOEM9zoPP0ZK329VfHW9kEyvuXWGYYPj24Qj7edHqUfXjWlfPkvDkTYopjp4or62j3hHojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GGN0Mikc; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GGN0Mikc"
Message-ID: <a9392088-c13c-48b7-af34-57294a440a52@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776075846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwjTPoMayqzTfWmI5xGmoy7XJbmczUxu7+9TUoyTkgE=;
	b=GGN0MikcZsoE/OZigKYFLP2eNZJvUw2iKZHr5Qd2+0YdYnTZNfU8TKq5P0RmuY3KuRHvLQ
	TYQObCITUfZ6fM5rJCXjEYyLX3tadkVTkbKF5PnyVdmZGl1S2Gaj0FysSWsDS/BQltKJZs
	w5Kb0maIijccJk+alHW/mO69QTe4LnE=
Date: Mon, 13 Apr 2026 18:23:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: btf: reject division by zero in btf_struct_walk for
 zero-size flex array elements
Content-Language: en-US
To: bot+bpf-ci@kernel.org, phx0fer@gmail.com, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260413085033.71952-1-phx0fer@gmail.com>
 <b33a500484e976977e6b56d0e1fbc6053c8f2723247eb5d890fe4b2be7242fc1@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <b33a500484e976977e6b56d0e1fbc6053c8f2723247eb5d890fe4b2be7242fc1@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Dudu,

The "btf:" in the subject should be dropped. "bpf:" is enough.

BTW, a selftest is required to verify the change. If it is a BUG, the
selftest should reproduce it without the fix.

On 13/4/26 17:26, bot+bpf-ci@kernel.org wrote:
>> Fixes: 1dc92851849c ("bpf: kernel side support for BTF Var and DataSec")
[...]
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index a62d78581207..2365d9b1ef27 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7152,6 +7152,13 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>>  		if (!btf_type_is_struct(t))
>>  			goto error;
>>
>> +		/* Zero-size element type (e.g., empty struct) would cause
>> +		 * division by zero below. Reject the access.
>> +		 */
> 
> This isn't a bug, but the BPF subsystem uses the style where the
> opening /* is on its own line for multi-line comments:
> 
>     /*
>      * Zero-size element type (e.g., empty struct) would cause
>      * division by zero below. Reject the access.
>      */
> 

AI review of the comment style is correct.

Thanks,
Leon

>> [...]
