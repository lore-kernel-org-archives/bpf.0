Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760727FB34
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215050; cv=none; b=Up0EU+YxI0nvlzDCQlAjUhy4OR52j2g5E9fDFCZgpbr1N9GL5zIxUdCmCKkvmDkIJ1Nprf5oWgxdjWGbD56p1l2Ohxl8U68FI2UvQZyhsHUCoFc6INJHUpu62LZ0gEomoyp/Z86PiL+1Nvy+kN6aLuIHFfwuFluXLqwG2WK1GvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215050; c=relaxed/simple;
	bh=LmKeXqHw18VR7/jucWH91E422/D7VjkEFL7phCLgvCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2KCcnJ23Cq+FVwy/wQmvF9mEpc+sDShf23TFEs+bUGaWApcvHW9dLCrpQCwozgjF0hAQLas3OH1/biC1d4tKlLWAxgmEEuRWDV38tfSULm4NxaJX/pVHrgT17E1ZLceYpSmAitr0PeYicmFRmFbjDKS6rk6dyI6gAeqGTp3wLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/Y6FvR3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/Y6FvR3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7629AC4CEF7;
	Wed,  4 Feb 2026 14:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770215049;
	bh=LmKeXqHw18VR7/jucWH91E422/D7VjkEFL7phCLgvCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r/Y6FvR3JTdquwtbVz2yPTqkUic8/MR9/9WLUU/Zoiu96/TGQ0cY/V8aYyUzthp9r
	 25e1gjJr5n28wQXZYuuTAFwfNo4OvHqSDZIuL/hQlvb9tlcFm5FjFUxZhWEojQXmCk
	 Qu6ykp5ucbb7olnhoGJ9NWM+3qQjsIS04u4PmbZOA0WyykqYJ0qEhl1xage2feXl+T
	 ZI8IqfUXH9I7nVrmkuJ5QJpS9oMRQU83o6067y/UGem6eTE8A6Gb8R9rNPXEw0f1va
	 yNwO1jwxws1Z6DHFyQJckNIuUHxLqH3r5u8IWqBAaGCdiex38HbTySfeljvXMC0dOT
	 yrCiIixv72IPQ==
Message-ID: <26fe285f-2504-4ee8-8889-1451bcd64c9b@kernel.org>
Date: Wed, 4 Feb 2026 14:24:06 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm
 dependency
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260128233425.374535-1-mykyta.yatsenko5@gmail.com>
 <2b6f4cd9-ff0f-4a91-90ef-8d8e6812f80f@kernel.org>
 <CAEf4BzY16OkoUQZ-Vaywb0oAL=UGY=8FVcBWLVM8oe=-bQ=4xg@mail.gmail.com>
 <1d4546ca-8849-464d-9080-ef77602134c7@kernel.org>
 <CAEf4BzZ2cxBfCBsTHDPHRqtbWmmN8ksYCOA_ScNiyAcTHdfZTw@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAEf4BzZ2cxBfCBsTHDPHRqtbWmmN8ksYCOA_ScNiyAcTHdfZTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-02-03 17:17 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>

>> But if really you want to do this, at least let's do it fully and give
>> more control for the disassembler dependencies: I think it shouldn't be
>> just LLVM in this case, there should be a way to opt-out from libbfd as
>> well, which was problematic for other reasons in the first place, and
>> probably some mechanism to tell whether to use libbfd or LLVM for the
>> disassembler when the two are available on the machine.
> 
> Yeah, absolutely, that makes sense. Mykyta, do you mind looking in
> what's the most sensible way to do what Quentin asks? Should we just
> have NO_LLVM and NO_BFD switches and take them both into account. If
> LLVM or BFD is not explicitly opted-out-from then we'll just prefere
> LLVM over BFD?


I'd be OK with that

Quentin
