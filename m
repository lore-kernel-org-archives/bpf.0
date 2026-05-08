Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D23C3A9D8C
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281458; cv=none; b=TpUyW5c3Uyyss6sMfBDszq2vC6hslQ7njxpw6xClebfHCwYyYwMuSmaNoIP+Fd6eiFUd/PsSqw2uBJwsi4IS37LpUbXRUytCpVys+ohqLl1gc6AjAv4fvVRdFpjKSRf50qId6qJ2nmXKv1S3yDI9LgIkrKij6uHym5Xu0C55nmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281458; c=relaxed/simple;
	bh=ZxW9oV4mSQXoLVz0dkwDl3+Ul0CcYs/G+6dWBZAgP8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQ53qAlrzRTHygLxc3WDgvpFj56lX2lN1/0aqdiNK7bKpVvaaCwNnFPoeBbsTjLsy803otB9uHYXwz12wGhEDSVd5UNS6U5jOLVVggXNO+ucawr4PH6UajASXsOOcJ/r06HgIgxna0K1fOOp8AZgTHoRI/XMcUh6eC3TXiDOc7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5uR03Sa; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5uR03Sa"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3664df30f53so698684a91.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 16:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778281456; x=1778886256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReDyhUz1ajWxrkK7iCREC2Yh5oQFngk3yx26HUt19Iw=;
        b=J5uR03Saq/7DsqD3DcGgwq9w+GatCgUDVJYbq158pYcYIJnDN0bJ2i1bzRUR/vA0Jf
         B1bmCNcdzkD2MNziVjVjYMuiD7Wf4NTrBfMpbtKKUcKxaq2oRGzsFC0dj9s0iBNYeipY
         SpMqYjSWW+qwdV0Zawvmkj3QQoYsptMbPNL44ZL6/8ieFaIJ7SwGWiZgdrhbminDYNIN
         Zwmomi2d5E8he8Fh19CKOK/bGtF6DQ/lT8soWsQNwmB2+bE2+r6voNCRQC38ztgsz824
         vI3iRjj5kzGvJ/V/RNG2nqndl8J3jPUsvT6aJP91IrLcF/ZKvVcpu5kBY7WjTepVr+Fe
         itww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281456; x=1778886256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReDyhUz1ajWxrkK7iCREC2Yh5oQFngk3yx26HUt19Iw=;
        b=TIzH45g0S/0Bh4QmvqWu2mejxcBlXZPfbXY4bO8NTJt8jCSGVLGjoll8bxBUsmPw1A
         U3H1XZT5U7q9Na3QF2H/d8oQMMWkQqUaS7mszBIpXUg08yeXBH/TkvgSvi63tpPyovM9
         K8MsP+UTqULqwbLW58gY8oZGBAA+G99XBZtewe4BK1NDknW2y6A5H7NuS8e9h8L2/b9H
         /YfO9wRJAfLMXXKG0MrCfhgWuqEiq7b2hAuu2kVORMOg+pM7WUzQWAzHMeLpVc525DRQ
         C9hJRPE2Pm835913kTXQSroWSbLcgdNZMuEtnuPGyYR3jn7nMRTgwXkTXVkn3RUE+ubM
         96QQ==
X-Gm-Message-State: AOJu0Yx4XIEy58hgOuwH92hjhikr2NjDtgc8/MLB07SX5NWsUpWj6IKA
	G4aaTsHnQsmbJ6otDmK+ouGqmdQOTOne0gmiTQjpNb6Hhp72OygiL3Xg
X-Gm-Gg: Acq92OH6gE9jKDHWc6XUGUsWWVAzo7ymsjcVXFxb8/JQPwGEE3nckoa1hA/eRQ58kVg
	P80UVpKwTQa3kUo3/k07cPrMsxRnbuX/vmT8cwxsgBm0t1jgZc66SOcB3ePAqNDl3zfDmHcG4Ww
	UrU59raR+B3g6FkmFnAT75ozuXezL4RHTWvZWRH3pPayHC0xFaOfQNRZfKbfQ6Wa54VCdLV+cbw
	2cQ2cEM9g+ItSiCTDVVvzKm4QDC7xWNqomnBb2RzaTwk6+6XDE23s7mR6kWik5rdPTSWVaheg3X
	TiosjvK2xrSQimkMc719nqQk4uBaS3k8zVDTPjB2Ge7aLKhHBCul+o/IeNTnob0scNRxMfiP3Ma
	HUgDfC9W3Drszsu10qjrifbbtF/SzoTaKJOVo0SKHx0x3pZtwtk684ucps7cX68dv+g9hhwqjp1
	RYBzYfukIRrh0OQEwFTm2wCR31hO2Pz8XyDIVU0Q==
X-Received: by 2002:a17:90b:254d:b0:35e:57cf:c0ae with SMTP id 98e67ed59e1d1-365ab9c8160mr15448255a91.7.1778281456340;
        Fri, 08 May 2026 16:04:16 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9582:1100::c7c9? ([2604:3d08:9582:1100::c7c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d64de478sm97524a91.13.2026.05.08.16.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 16:04:16 -0700 (PDT)
Message-ID: <da6d4a68-99ef-468d-b175-8c6dd164bfb7@gmail.com>
Date: Fri, 8 May 2026 16:04:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 05/19] unwind_user/sframe: Add support for reading
 .sframe contents
To: Jens Remus <jremus@linux.ibm.com>, Steven Rostedt <rostedt@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev
References: <20260505121718.3572346-6-jremus@linux.ibm.com>
 <20260505185932.C708CC2BCB4@smtp.kernel.org>
 <4e5d51f0-8f4c-4a07-9141-8b26d2c90fc6@linux.ibm.com>
 <20260506110142.7b2943d7@fedora>
 <3158dc1a-26cb-4942-b05e-6c60c092e588@linux.ibm.com>
Content-Language: en-US
From: Indu Bhagat <ibhagatgnu@gmail.com>
In-Reply-To: <3158dc1a-26cb-4942-b05e-6c60c092e588@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-08 02:49, Jens Remus wrote:
> On 5/6/2026 5:01 PM, Steven Rostedt wrote:
>> On Wed, 6 May 2026 16:34:34 +0200
>> Jens Remus <jremus@linux.ibm.com> wrote:
> 
>>>> If a malicious user provides a large fre_len in the header, fres_end
>>>> (calculated as fres_start + shdr.fre_len) could wrap around the 32-bit
>>>> address space. This would bypass the bounds check in sframe_read_header(),
>>>> allowing fres_start and fdes_start to point into kernel memory. Later, when
>>>> __read_fde() and __find_fre() use unsafe_get_user(), this could lead to
>>>> arbitrary kernel memory disclosure.
>>>
>>> SFrame is currently only supported on 64-bit architectures (i.e. x86-64,
>>> arm64, s390 64-bit).  So unsigned long fres_end should always be 64-bit.
>>> Do we need to add the following to the header parsing?
>>>
>>> if (fdes_start >= fdes_end || fres_start >= fres_end) {
>>> 	dbg_sec("inconsistent FDE/FRE start/end address\n");
>>> 	return -EINVAL;
>>> }
>>
>> I guess this wouldn't hurt.
> 
> Reviewing my suggestion again I realize that this check would be
> superfluous.  The existing computation and check already ensures that
> the FDE table is within sframe section, the FRE table is within sframe
> section, and both tables do not overlap:
> 
> 	num_fdes   = shdr.num_fdes;
> 	fdes_start = header_end + shdr.fdes_off;
> 	fdes_end   = fdes_start + (num_fdes * sizeof(struct sframe_fde_v3));
> 
> 	fres_start = header_end + shdr.fres_off;
> 	fres_end   = fres_start + shdr.fre_len;
> 
> 	if (fres_start < fdes_end || fres_end > sec->sframe_end) {
> 		dbg_sec("inconsistent FDE/FRE offsets\n");
> 		return -EINVAL;
> 	}
> 
> - fdes_start and fres_start are computed from header_start and thus must
>    be larger sframe_start
> - fdes_end and fres_end are computed from their fdes_start and
>    fres_start and thus must be larger than sframe_start
> - fres_start < fdes_end ensures that the FDE table and FRE table do not
>    overlap
> - fres_end > sec->sframe_end ensures that fres_end (and fdes_end and both
>    fdes_start and fres_start) are smaller or equal sframe_end
> 


Yes, I too think the existing check you note above suffices.

