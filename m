Received: from mta1.migadu.com (out-49.mta1.migadu.com [95.215.58.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD9E39CD1B
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 03:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133092; cv=none; b=iPTi/PNkUaSXrU+exviaxtD889Q409F7ZtiYM+S7GSH35HGgLoDV2Z6BsWn+k9vg7c1sKa5IkByj6LpdFzCV+vvV+iaAEpOGc7nWWhBRPjmQCvHgdjRFuGXnRHoEh9nrUor+gebCPSrgO2eGpBS9pfn7HJrCaGcSPyMt6rOTcb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133092; c=relaxed/simple;
	bh=3d9vEREwhkYG0VPT1a2znsZKy1Khtu/cvPVX6WSOkp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R432iFE60446FFBgaCsCmQtfdOWbXszYCaTGC5lsFSyLUlvnVDzuDAP3RnuOBO+pGiKLX3RX90pO0Taqwf/Y1zUvQcmL5PYdbBg8GBaUyxjU3vZfmJM26vM2XTXxiDto8zjjWvH5Mo8mvghvKwLGvaV4ywgHFIwmbmS83dMthbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fu2oV4zG; arc=none smtp.client-ip=95.215.58.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fu2oV4zG"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3d9vEREwhkYG0VPT1a2znsZKy1Khtu/cvPVX6WSOkp4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790133088; v=1; x=1790737888;
 b=fu2oV4zGSmsoeuMHeUQLal9LBUFTdZeVVJtPSYYs9/0DNJF9L95MygOacPo+tvHiB2j5F1k0
 OlHb8KmI7UpKWYdmSxzcZuasIB4U7aSdpCcc/wK0k4ZIEZq4vEIiPyMnaluWFXPG1RhybDyLsm9
 iFCXlUfHUELtsesYd1kQcCc4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6d1a1ea2c0a25ae9;
	Wed, 23 Sep 2026 03:11:28 +0000
X-Mizu-Trace-ID: 6d1a1ea2c0a25ae9
X-Migadu-Flow: FLOW_OUT
Message-ID: <3392c8d1-8c36-4f22-b47c-331ae8173648@linux.dev>
Date: Tue, 22 Sep 2026 20:11:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 07/20] bpf: Refuse exception cleanup shapes
 bpf_throw() cannot dispatch
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210109.1719713-1-yonghong.song@linux.dev>
 <d87ccb2d98acc167a80ce894a844abb29ee433a9.camel@gmail.com>
 <73a766ca-8198-4677-8c29-29fac8489f73@linux.dev>
 <dfcab4681d89c91a8e2c7fabb80f362dbfb2f9a7.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <dfcab4681d89c91a8e2c7fabb80f362dbfb2f9a7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/22/26 2:43 PM, Eduard Zingerman wrote:
> On Mon, 2026-09-21 at 20:45 -0700, Yonghong Song wrote:
>
> ...
>
>>> Why is it necessary to hand-roll a CFG traversal and a separate pass
>>> for this check? Given that bpf verifier state already maintains
>>> `unwinding' flag, the instructions properties can be checked from
>>> do_check_insn(), e.g.:
>>> - bpf_throw()               -- reject if unwinding
>>> - call to a throwing global -- reject if unwinding
>>> - bpf_unwind_resume()       -- require unwinding and the pad-owning frame
>>> - BPF_EXIT                  -- reject in the pad-owning frame, allow in callees
>>> - LD_{ABS,IND}              -- reject if unwinding
>>>
>>> I think that would take much less code, wdyt?

This indeed reduces amount of codes by more than 2/3 for this patch.

>> This is a good idea. Let me try. Thanks!
> Also, regarding the tail calls. It appears that the following chain
> can call bpf_throw from a landing pad:
>
>    bpf_throw() -> landing pad -> global procedure call -> tail call -> bpf_throw()
>
> would this work as expected?

Yes, it works. tail_call itself is the terminator as it is the main prog,
bpf_throw() won't cross main prog boundary.



