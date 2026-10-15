Received: from mta1.migadu.com (out-245.mta1.migadu.com [95.215.58.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD353D6493
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079162; cv=none; b=H0jZ+bK+a+HJSAaUbEKDReWgbMJCm7Q5QYagq/aswMs880YPHM+W0zPbBpnSi19UN6asLPq9Ae90K7115xWhNH+Fgjcx2vQhv+9f9gEWS3hkAc9fXo1daTNupmEVrhQQHAqXeNU9O6IV2fBbjsRAPOYMHDA3BQ9FdIloPtm3QaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079162; c=relaxed/simple;
	bh=POooulujnIkLHWEyPmLNc//oQqLDg4iHcaq7ZUi7onw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GRHG+7qVg5cBwSorvyIHgHPQFXnUS98aEzevlbKm5qT0GLo1hlsRiM+WPdMTU23myAxWpjLkof4dyjHfevKA1HqAtIX+Prz5EOZj4vSkZawpg/23DG2zcraU8aI89Mr5c/jqfD12tMnIniP7GJMD7NJ105I7azNtsM3BS+P6Op8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qrBNjyln; arc=none smtp.client-ip=95.215.58.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qrBNjyln"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=POooulujnIkLHWEyPmLNc//oQqLDg4iHcaq7ZUi7onw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792079147; v=1; x=1792683947;
 b=qrBNjylneTTsj9cWh5m/wsxAXeIaXWCxKX/8LaPtfawJfKtDlwG2amGCUQeTdgm5PwyPq6av
 haMlvvif3qq0Xwd0FfQgPHBiRtd1GWczfdtPX8x82nBTuN0bouh/6qrc/643G2T8peTNxuFiTYc
 lRexhRmWzcRVeGtyMV3iSG+4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a8122fc183ca982b;
	Thu, 15 Oct 2026 15:45:31 +0000
X-Mizu-Trace-ID: a8122fc183ca982b
X-Migadu-Flow: FLOW_OUT
Message-ID: <9562d352-61f6-43c3-8ed3-3dc89140d317@linux.dev>
Date: Thu, 15 Oct 2026 08:45:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 19/26] libbpf: Add cleanup_info to
 bpf_prog_load_opts
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
References: <20261015040143.854070-1-yonghong.song@linux.dev>
 <20261015040321.864586-1-yonghong.song@linux.dev>
 <sashiko-outbox-172238@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-172238@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/26 9:13 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] bpf: multi-line comment style violation in bpf_prog_load_opts
> --
>
> commit 7622c492adc459370a78a700a25047031969a083
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> libbpf: Add cleanup_info to bpf_prog_load_opts
>
> This commit expands bpf_prog_load_opts to include an exception cleanup
> table. It adds cleanup_info_cnt, cleanup_info, and cleanup_info_rec_size
> fields, which are then passed to the kernel via bpf_prog_load.
>
> [ ... ]
>
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index 826d9cc9ab65d..64699e0e4e1a8 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
>> @@ -128,9 +128,17 @@ struct bpf_prog_load_opts {
>>   
>>   	/* if set, provides the length of fd_array */
>>   	__u32 fd_array_cnt;
>> +
>> +	/* exception cleanup table: cleanup_info_cnt records of
>> +	 * cleanup_info_rec_size bytes each (struct bpf_cleanup_info),
>> +	 * holding instruction indices into insns
>> +	 */
> [Severity: Low]
> This isn't a bug, but does this multi-line comment follow the preferred
> BPF subsystem style? The subsystem guidelines strictly require that the
> opening /* for multi-line comments be placed on its own line.
>
> Could this be formatted as follows to match the standard?
>
> /*
>   * exception cleanup table: cleanup_info_cnt records of
>   * cleanup_info_rec_size bytes each (struct bpf_cleanup_info),
>   * holding instruction indices into insns
>   */

This is a format issue. Can be a follow up or as is.

>
>> +	__u32 cleanup_info_cnt;
>> +	const void *cleanup_info;
>> +	__u32 cleanup_info_rec_size;
>>   	size_t :0;
>>   };

