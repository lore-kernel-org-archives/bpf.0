Received: from mta0.migadu.com (out-24.mta0.migadu.com [91.218.175.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5169738DC5B
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492842; cv=none; b=Ifulmz/2YgWztOCiJ4xAVI7LEp7M+bf358SJbY28OVyIvqWMVmJpBlZYBwo984i0rVWoPxUDHeVpOG4kkgEqlFZ5rDJ0eptjm8Vpn4y2D8cFZqq3U4ogsu1Hw/Mpg/a4FDoECP5LBYz+gH4iRO5TDaggr57+sn3dk5FKQZCbk5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492842; c=relaxed/simple;
	bh=UCfOPeXkp6R0OzJhvrLuIKNSK5w1HFIK/p1igY0h6so=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J8QzU3fVQ/dxaw3HkLZDIHaulCbl6f+Lm+Q1sMOm3RSIhhe7o+/PSBXIkm/rjV+S3c5PQ6nQm41C602d2NLAzn3o8Lvcg423zMXddlqIZmmZH5U+aH0UILClxxi417FpbufPzAzOjf95rSVQv6zbSCAlkui8Bt5czkZ9l7ltNJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gKMfNA54; arc=none smtp.client-ip=91.218.175.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gKMfNA54"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UCfOPeXkp6R0OzJhvrLuIKNSK5w1HFIK/p1igY0h6so=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788492839; v=1; x=1789097639;
 b=gKMfNA54zU+0RE7nIWpnAKOD/sbLVMzKOyKa1fPQKu5fxptNSyybv6M36AgWviZ3TSNdMw5O
 +JymGpysYvI0sMwcBow7I3Nd5VgUl9HwEoyXFJ0eUzRP2wax9of73hqHhU/rWfFZNYFQBaCI0p9
 2GyDjSfBTZg4rALboMyfq1+0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9e4d589e8816b580;
	Fri, 04 Sep 2026 03:33:59 +0000
X-Mizu-Trace-ID: 9e4d589e8816b580
X-Migadu-Flow: FLOW_OUT
Message-ID: <070c7aa5-404d-472d-bc63-4f8865f05b0e@linux.dev>
Date: Fri, 4 Sep 2026 09:03:52 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Mailer snafu (was Re: [RFC bpf-next 2/6] bpf: move the linked-scalar
 flags into bpf_reg_state->flags [NFC])
From: Vineet Gupta <vineet.gupta@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
 <20260814231945.3884596-3-vineet.gupta@linux.dev>
 <82363647cb12b75398e34c7d66a9f0c527940c8d.camel@gmail.com>
 <c145728c-80fd-459f-be72-f5e0fcdeaf25@linux.dev>
Content-Language: en-US
In-Reply-To: <c145728c-80fd-459f-be72-f5e0fcdeaf25@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 08:59, Vineet Gupta wrote:

Apologies for the multiple re-sends, this was some mailer snafu at my end.

