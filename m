Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646B443AB7
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593909; cv=none; b=egxxuqeemnpsiOAGLCCkyyIFPqdmSryZlVO4DVlUPsVGQkFs+a5WpKVHlUuW6wDqDy6StXS/twMKhXfRqH3tNTCKPP5yJ1X0MjKuVGczNECScnFJQJ5h2UqrAFtcAv9OtXWu3WN8qX70yahRZkhm+qH9MQXF03CFljUUQ1Qp0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593909; c=relaxed/simple;
	bh=kEPDtvI9KB51gSQNB80wVjTqoX84Q7Z02NSxHCitI+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uo7MmTILsAJM/wTmJ4F65UExbVqfmNpdDqAW8QoO8wUTP7TSCWksDn0N+QbusaoR9r7Ih++rmdpyQG2ISpqWd0CHl8TG9Ow80782HUmOR3n9NlLjlE2dYAK43qpcJel3oepmyTKJU7hbUJoZPaSR9iYgX760wvwpk4U9PBXt2AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vA9iaYSh; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vA9iaYSh"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kEPDtvI9KB51gSQNB80wVjTqoX84Q7Z02NSxHCitI+w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789593890; v=1; x=1790198690;
 b=vA9iaYSh2erpQerQZUVLiyE/Ql4J3xa7BJ5259vis2ActsVMZx9KdfJXHtkQuMqpHStSZA4k
 2Vuo8S7PJjb9EZlrAsfaILamd8SsYy1xOkLBX0uzXTjjLo0p4Gk6bkLmnCKHPVJYlSku4llOZnp
 BALZPrLMFwsSgVHWs00V9xlw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3f3f538203a15285;
	Wed, 16 Sep 2026 21:24:50 +0000
X-Mizu-Trace-ID: 3f3f538203a15285
X-Migadu-Flow: FLOW_OUT
Message-ID: <76ca0a2e-dd9a-41c9-90e4-5fd3c9171172@linux.dev>
Date: Wed, 16 Sep 2026 14:24:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of
 bpf_reg_state->id [NFC]
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-2-vineet.gupta@linux.dev>
 <DLDKB6BTHVXE.PFK87O3QY1J5@gmail.com>
 <f575fe19-a5a0-4f43-b1bd-cdec2c6e9830@linux.dev>
 <DLH1MDZPU5G0.228555JR34D3N@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <DLH1MDZPU5G0.228555JR34D3N@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/16/26 2:02 PM, Alexei Starovoitov wrote:
> On Tue Sep 15, 2026 at 1:17 AM UTC, Vineet Gupta wrote:
>> Back when I started, keeping it NFC made more sense. But with all the
>> nuances discovered in the process, I'm inclined to drop the NFC stance
> What is NFC ?

non functional change aka refactoring.
Like I said when I started I wanted to keep the id / flag breakout 
purely non functional. But given that splitting it does change one thing 
(mentioned below) - I'm dropping NFC attribution.

>> and make functional changes - there's at least one which is the
>> following accepted pre-series and now rejected.
>>
>>         old {r2.id=A+delta32}         vs cur {r2.id=B+delta64}
> that's a red flag, no? The refactoring patch shouldn't have
> any changes to selftest and veristat numbers?
> Unless I'm missing it again.

Yes understood except that it is no longer refactoring.

Thx
-Vineet
