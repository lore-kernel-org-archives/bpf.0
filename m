Received: from mta0.migadu.com (out-103.mta0.migadu.com [91.218.175.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0F47F3D4
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791138370; cv=none; b=GQI4zpeIOnvO7inuW5qnjrh+44uHDQzBbXXNLqXthvGzTEkLgOoWGs21r8dXDtgeoziKpMaaii7o6L6dYmS9l3lAPuAlZEb3n6zzB55n53WVdNZKVVEJtJ7SD1D1+1z0d73HM9diWB8cpdfrGj/PN9gvz6dEqQ+DR2g+i6WOGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791138370; c=relaxed/simple;
	bh=2tq9V7t09dyrpjLnmw4G0F78gQhzL4gy/6Xkk3vijCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adcxODkMcaTeUPpVJ9YkkP84agKA0Ocon3RtKtCAv4BKYS14zQWEXSJMDGBBAymD7nUQnSj0JN1qe5SsYeSMhn3uo1chkLcvG7sW/9ur8d3hydv+LatAwL/mp38QLzU0GYQJ+F1ZZlREqNQvioPDOeS9IQdVIKcCctSzdF5s7SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v4298NCD; arc=none smtp.client-ip=91.218.175.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v4298NCD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2tq9V7t09dyrpjLnmw4G0F78gQhzL4gy/6Xkk3vijCc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791138365; v=1; x=1791743165;
 b=v4298NCDmvXuCwSdaTgk0eeFCRpHZ/jrl89w2xUIcaP0pPbouOucaRfH4H1oQedOX1n3V6rc
 ruMTyVHK1X3ZfUC+DIiv6WTBJN8N1d1YmSFkZqdWhGl1jayfjOVJzMh5gOOPDFUWCsYoASg9EZc
 Bp27LmNNWpsuvbmfFZ+I6eqQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f86a6dc1820010f4;
	Sun, 04 Oct 2026 18:26:05 +0000
X-Mizu-Trace-ID: f86a6dc1820010f4
X-Migadu-Flow: FLOW_OUT
Message-ID: <42bae60f-9c25-4288-b6cf-2df67bc43821@linux.dev>
Date: Sun, 4 Oct 2026 20:26:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 09/22] bpf: Refuse a landing pad that does not
 resume
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133052.1339921-1-yonghong.song@linux.dev>
 <DLV79T0TY8NZ.3KI8QVIB50I4H@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DLV79T0TY8NZ.3KI8QVIB50I4H@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/26 2:25 PM, Alexei Starovoitov wrote:
> On Thu, Oct 01, 2026 at 06:30 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> +	u64 in_cleanup_pad:1; /* reached with a landing pad running */
>> +	u64 outside_cleanup_pad:1; /* reached the other way */
> can we compare in_pad in func_states_equal(), like no_stack_arg_load,
> and drop these two bits, the "runs both inside and outside a landing
> pad" rule and the special case for speculative paths?

Yes, will compare in_pad in func_states_equal(). special case for
speculative path can be removed. I think special case for
speculative path is not needed any more due to in_pad in func_states_equal().

