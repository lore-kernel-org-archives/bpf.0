Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C407C345736
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919371; cv=none; b=U5WuGkh48HEnLMZG5JhRJncmCr0K/mKyX+AlHJyldn4rn7tz6NPwy+Yy+wjJdM2/5peOZnnWMZbXS6NPg8vMVhkOWIwHfcxxppVucNZhzx8dr1sJBfHWUuUbfeYU4I8lPEJE3wVfYCUhB2yt/T1QwigoLFnKOVDhh/4dw7YB6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919371; c=relaxed/simple;
	bh=1uC8JRwme8mfW6A/ztGvS6a/Wr9hlCg7l4ImC4V84Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDEhBZ3A5SNfU8DsiUx4+fm91rH19qUQ2k6a+Ma68elaohTsWByb/FU19ElT5VEqJjgN5ItEun4UHUtVCBRiIGBURjdKvtsxmLby1EhMfrAJWXf3J/csqUOZ53cMzifStyU7PIKfF2tcvY1/fXY3JgHfLCSAK7R0f1uT35P+qeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=HwZZTNO5; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="HwZZTNO5"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1931C82D2E;
	Fri, 02 Oct 2026 07:36:08 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TSD6NQUV5X3l; Fri,  2 Oct 2026 07:36:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790919367; bh=1uC8JRwme8mfW6A/ztGvS6a/Wr9hlCg7l4ImC4V84Ug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HwZZTNO5DTdxDgC5jSrMJ7yWxjaNhsV3vpU0PEVSUPbN7l4iQY0r6fkc14FC74kRd
	 EZjoOgTWeSTVWBfMvCB179R71j4aHHrbuFl2d1QfoQhq6aRZogjuVLKk07is040EiC
	 PiDSZPWiX5PpqZ/uHc6V86Cg6SpD5Zd9Qwpbf+cywBZ9GRgdy54ADaKJkyUuvIgDRv
	 dUnCd7fqVFqEWA0SJ0zYk4CKlFQVqLJj9po9duRsur0wPQTiqzO0bewMmOtpHB7IeO
	 nZPVlvJghZi0sMqkECnCEWOvldXD7bmCGPnymlJIsNGaR7W4/wxbUVI4e6Dsopavp5
	 rsqKmqF8EOTIQ==
Message-ID: <ce867a52-b008-4ee2-93ca-52a9443d3a9d@disroot.org>
Date: Fri, 2 Oct 2026 06:36:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests/bpf: add test for percpu map flags
 combination
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev
References: <20260930135753.1063495-1-maghasi@disroot.org>
 <20260930135753.1063495-3-maghasi@disroot.org>
 <9d233b9f-4eb4-4550-8dfa-f56b2b6492ad@linux.dev>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <9d233b9f-4eb4-4550-8dfa-f56b2b6492ad@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/2026 16:17, Leon Hwang wrote:
> On 2026/9/30 21:57, Masoud Aghasi wrote:
>> Add tests to exercise usage of a combination of flags for
>> percpu hash map updates.
>>
>> Before the fix, these tests fail to respect user flags combination of
>> (BPF_F_CPU | BPF_EXIST). With the fix applied these tests pass.
> 
> I think combinations of (BPF_F_CPU, BPF_F_ALL_CPUS) and (BPF_EXIST,
> BPF_NOEXIST) should be covered for all per-CPU map types where applicable.
> 
> Thanks,
> Leon
> 
>> [...]
> 

Thanks.
I will add full test coverage for these to v3.
