Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1F3955EA;
	Fri, 25 Sep 2026 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366105; cv=none; b=hH3oBJ/66NVM558Hh+FNesaG/7D0neMJnHH7pGEPfXS5d7AppHFAoPSt4hpmMZoeN7V/GXjfckpdOq0JSJkSI02Jr9NuH46jL3f4lihcPWnuv0KXMhlq+PTOkGy7rHHnXQfEuGHkKeool6iU0CptEoDmEPbniGq35wZmnxl+8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366105; c=relaxed/simple;
	bh=hKHRq0LhI1zolL4uHSTmSljmnQD+TYC96AymLijR8t8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t46Vdwcuv8930/As8oyFLsa9m2qMMcxbNotxuvWbm0HmZv2lUm6lnNVVkZZCmU41QCTyJ0omVWVnFGEw3AGEfzjIu7KauHR9RQE+6w6LxQpBqu/PwYctykKbcc9MQEybmreZv84Fb2/qqXbHXbsOS86S4ICUHdRyvxmEC2pJXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQwePNuN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQwePNuN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617571F000FF;
	Fri, 25 Sep 2026 19:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790366103;
	bh=bpVmtn0t5O97jPCAVABKpxtYNMzagCrnZQRLZ6EWAwI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aQwePNuN7Hjw08+dF52gRhhrbdolVFjRkv1u/JVA7OwOPOV3Lz+uJzwDcijIH9NSz
	 +q4Q69T80dunW+lG7TiwFAsmVsEKZlN5AfLrUEtUCb/nF+pPJ6u1Ys1DwmlAerVsQG
	 jRa3JkY6HumUrf3Jl0xI0bN8Sl7EI6wrWbZIqgV2fzLG2RsrkjVn15KusXMsTlIc8j
	 riOpgjhRf65IqqJZGrczBWINPOIKOBkrVaHuvgjolb2rVMV+Ii3mcsIFABcf/W6cj2
	 lFDLiign3TY3foJZKn1zf31NrEFAKk0UCYhxUEgqzp4gGL4LieTOqIdxCkCxIBnzBk
	 SXRYkmLgW/DbQ==
Message-ID: <6fc6245b-5497-40dd-a032-53c323467d2f@kernel.org>
Date: Fri, 25 Sep 2026 20:55:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 2/3] bpftool: Update func representation to
 include function signature
To: sashiko-reviews@lists.linux.dev, Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
References: <20260925170854.1240637-1-alan.maguire@oracle.com>
 <20260925170854.1240637-3-alan.maguire@oracle.com>
 <20260925171703.5D9EB1F000FF@smtp.kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260925171703.5D9EB1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-25 17:17 UTC+0000 ~ sashiko-bot@kernel.org
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: btf_locsec_append hides truncation marker due to null byte gap
> --
> 
> commit 6f503008243b4dfc886859b905f8a6fa7b657ef2
> Author: Alan Maguire <alan.maguire@oracle.com>
> 
> bpftool: Update func representation to include function signature
> 
> This commit augments the func= output for LOCSEC entries to include a mapping
> from function signature to where parameters are stored. It addresses a feature
> suggestion to dump LOC_PARAM, LOC_PROTO and LOCSEC more verbosely.
> 
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index e29c8a84e224c..ce4c4036c2796 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
> 
> [ ... ]
> 
>> +static bool btf_locsec_append(char *str, size_t sz, size_t *off,
>> +			      const char *suffix)
>> +{
>> +	size_t len;
>> +
>> +	if (!sz || *off >= sz)
>> +		return false;
>> +
>> +	len = strlen(suffix);
>> +	if (len < sz - *off) {
>> +		memcpy(str + *off, suffix, len + 1);
>> +		*off += len;
>> +		return true;
>> +	}
>> +
>> +	if (sz >= 4) {
>> +		memcpy(str + sz - 4, "...", 4);
>> +	} else if (sz > 1) {
> 
> [Severity: Medium]
> When a string exceeds the buffer size and we hit this fallback path in
> btf_locsec_append(), is there a risk that the truncation marker is hidden?
> 
> The truncation marker ... is unconditionally placed at the very end of the
> buffer (sz - 4). Because the function fails to copy the prefix of the string
> that would fit and does not write over the existing null terminator at *off,
> a gap of null bytes can separate the current end of the string from the
> truncation marker.
> 
> String reading functions like printf or JSON dumpers will terminate at the
> first null byte, which would completely hide the ... marker and discard the
> partial data.
> 
> This would be triggered when bpftool formats a BTF location string (for 
> example, a function signature with many parameters) that cumulatively exceeds
> 1024 characters.

Maybe copy whatever we can from the suffix first, overwrite the end with
the dots after? Something like:

        if (sz >= 4) {
                size_t space_left = sz - 1 - *off;

                if (space_left)
                        memcpy(str + *off, suffix, space_left);
                memcpy(str + sz - 4, "...", 4);
        }
