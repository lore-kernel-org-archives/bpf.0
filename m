Received: from mta0.migadu.com (out-78.mta0.migadu.com [91.218.175.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A818B3644A0
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741553; cv=none; b=UqiR0O1XboZd4PUDaSJwXIfcwfH+lFp6cToR30TXqsvs89ztNe2qxO9Mh00fI0UM9MuSfKZhteXparnKhp8Uv8fSzlSYG/RkLujUCs/mLMF0xnHEW1HfKTdiHQpeh8rlo3Gmw3R3qgjhCh8TLyrUb5lV/VbXwJncrQQyRdEr7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741553; c=relaxed/simple;
	bh=5ZodmMk5mazCcATEXU3st4ZtMCZZcl1LFNQi48kL3+c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uRucFzLUJdZF7vYiWEpUv1NWLSWqjSCr4vBSI6ioxtmXnVlv3m7m9uVTLEbXc8A01noA4Zjs80YGR5mZ7Uh8p8fCN4x76ReweikY1JoLe5xitf6cwsHdNlgGThuxlZxPsaFp4/32rDXOQiARSzyTzXiSJZn6abuKWP6rixXFSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PYu/GgZM; arc=none smtp.client-ip=91.218.175.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PYu/GgZM"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5ZodmMk5mazCcATEXU3st4ZtMCZZcl1LFNQi48kL3+c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790741547; v=1; x=1791346347;
 b=PYu/GgZMgwf+zGVE73akS7yXt8XSpHZNCejIo9dd2plrDMWESpHBCre9+PiYLVq4Q0F90Pj9
 gXV0fjeX584jfu7u2Cv2ohpTnldq1OM3HwmUj//2hSttdgSDODPFQPuEByTiWu524C3x7wK6zLS
 wzQBPvzaMMUN9tYRdOi/4vC4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8e53c0bfa2c49de2;
	Wed, 30 Sep 2026 04:12:17 +0000
X-Mizu-Trace-ID: 8e53c0bfa2c49de2
X-Migadu-Flow: FLOW_OUT
Message-ID: <693c4abd-e074-463d-a859-ac8033982c81@linux.dev>
Date: Wed, 30 Sep 2026 12:09:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, josef@toxicopanda.com, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 linux-kselftest@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>,
 ameryhung@gmail.com, alexei.starovoitov@gmail.com
Subject: Re: [RFC PATCH v7 0/4] blk-iocost: BPF struct_ops cost model
To: Tejun Heo <tj@kernel.org>
References: <20260924054549.2271705-1-cui.tao@linux.dev>
 <6f80eca83c87b60398110c3a6d735aec@kernel.org>
 <4f1571a1-7e56-4264-aa7f-8dce32931ddb@linux.dev>
 <44f02289433805946d1e3272f626a925@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <44f02289433805946d1e3272f626a925@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Tejun.

在 2026/9/30 00:27, Tejun Heo 写道:
> Hello, Tao.
> 
> On Tue, 29 Sep 2026 21:39:00 +0800, Tao Cui wrote:
>> To make sure I understood correctly: attaching switches the active
>> model to the attached BPF model, while model=linear and model=bpf
>> only switch between the attached model and the builtin model without
>> affecting the attachment itself.  The attachment survives enable=0,
>> and only .unreg removes it.  Please shout if I still got that wrong.
> 
> Yes, except that removing the device also removes the attachment, as
> ioc_rqos_exit() ejects the model.
> 

Thanks for confirming.  I had left out the device removal case in
the summary.  v8 keeps the attachment independent from controller state
and model selection; only .unreg and device removal (where
ioc_rqos_exit() ejects the model) remove the attachment.

Thanks.
Tao> Thanks.
> 
> --
> tejun

