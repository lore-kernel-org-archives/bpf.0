Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926A50B8CE;
	Tue, 29 Sep 2026 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677754; cv=none; b=Sm7tdr4auuQnpqIOEWVgjdMl35nfz+7pFGA721EdYQZEAAoxKXnKpEtsJLXMAZ/SdK+g75GYT7lPZ23Lv8T0RRLv+pY+d/5VV3YBA/q+nrlSfgSSDPUkOMyVfWAFAzwFhAoR3HVLOLTqxTIRDGklQ7L0ZdANn69LHb68GM7ZNzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677754; c=relaxed/simple;
	bh=H5wX94s2oDINK3YFOU1sKfVcXT9FRIyBh1zoeWhH2CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwFZtV6xaeXUJnFq0dcS9fFSu9Pqk8cHG9dfMP2hbnWcgeDuNZhoga/1YVFfWBwTmAnVdCc8MzJmMUBlzoxQUdBcwG1WSJFIi4rXo5vnfP4TGm3PXZX6esUnvZyV8jm7zu6p4vr8cuj9jAkbtp0j5Hn0elBkZyl8NuEbaUxKdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAqSTGC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAqSTGC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE4B1F000FF;
	Tue, 29 Sep 2026 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790677738;
	bh=SSKVRPg7XZZZGk4/celz91xWOAhOskM6XGleeZ0ma1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DAqSTGC149c5G8H80inhNpYUG5KixTHs2jjsk89B9TsmYG2IL6epylvL/jqNNpOP+
	 LCeesbA9mc0f2TIZTylXXfHWxkip+jyL7iseivnS3jOqIaCujHl8LyABHD2RzZNYWE
	 WV7P71+YUvd01tq9iQGHrS00cvmTvlORa9GYtt9ErGFQ4H7EOEEAd5jLZHJ4X8hMDQ
	 DlOfGMc8SIyxuLS7zFHew4PJFCg2v16jFkOFnTHlqv0QIGSJc1VPy2vTnubod/BKDN
	 p8TsEq/PSRbqMKmY89iPJyIi9HpNi4pTT6L5+beOdSw4MhXie3C+M8o4UY2Km2fG/o
	 TPfvWv5VJs18g==
Message-ID: <ac6f56cb-dc79-4c44-899c-138394565fbc@kernel.org>
Date: Tue, 29 Sep 2026 11:28:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Check bpftool map info across
 mixed BTF maps
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org, skokovmaksimevg@gmail.com
References: <cover.1790615923.git.hi@tychen.cc>
 <cea9cb26c3267c22da2101a0e3d075e2633a2e61.1790615923.git.hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <cea9cb26c3267c22da2101a0e3d075e2633a2e61.1790615923.git.hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-29 02:13 UTC+0900 ~ Tianyi Chen <hi@tychen.cc>
> Create a typed map followed by a smaller untyped map with the same name.
> Check that full and named listings do not report BTF for the untyped map,
> JSON dumps match independently dumped contents, and plain dumps use raw
> output when the selected maps do not all have BTF.
> 
> These cover the separate info-query loops in map show and map dump
> without requiring recursive dumping.


Not sure why we'd mention recursive dumping at all in the commit logs
for this patch (can we please drop this sentence when applying?).

Looks good otherwise, thanks.

Acked-by: Quentin Monnet <qmo@kernel.org>


> 
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>
