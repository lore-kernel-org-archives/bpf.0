Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624640D565
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782058230; cv=none; b=TC9b57GyAd3dgQthkaIMWCuM8SSpFfov2fvxkH12dCHO6liNJl2PuSCUkPxQlAoUcz8laMYtz6JqZ81gZVz/4+338e2lA5qucCcI2n7YeQPgTRLzoDxPonXqt87vqlxwmuoTPRxN0ss4w5yK1NC/ZG8RcyF8salpi2ul9GwmzA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782058230; c=relaxed/simple;
	bh=+6VU7p99M6ObTg22FT6KcWosDZ+oulS9N+8Dk7ltmUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McqukZDPiFxX9MlUNqAwwSS5k03YYJbSLKllA8ihWcuVXdzwVgIPUPnZBZx/+o+dKv4qdUYLeRZWljZa8+nGVJgo1QxnuWXOlxyXw6rUJvuleIMIeYP/0zW0RbAZstIlcpfriSxAt4+Fp70CMmv0lneV+8+RUWldMk73MQw8/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aY6ksSqn; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aY6ksSqn"
Message-ID: <064ad47b-d0e8-4c43-ab05-290bb88326bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782058226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6VU7p99M6ObTg22FT6KcWosDZ+oulS9N+8Dk7ltmUk=;
	b=aY6ksSqnQFLsbHumJGPcyEw6PLZDbFVvgYNHl5Mzmg/BI/imWMfQa404EAbQp8xraECGTL
	JEIrl8uMt4Oi9O67NLgkYsEL3ncOn5uCM6ueFW0YSeA6Teu41SfC2uA9PR1yX5CXLr9a4B
	sjeDB/NIigylpmRylCQRxMA/8nFeMGk=
Date: Sun, 21 Jun 2026 09:09:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Fix BPF_PROG_ASSOC_STRUCT_OPS last field check
Content-Language: en-GB
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>
References: <20260618040934.4113938-1-tweek@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260618040934.4113938-1-tweek@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/17/26 9:09 PM, Thiébaud Weksteen wrote:
> When struct prog_assoc_struct_ops was added,
> BPF_PROG_ASSOC_STRUCT_OPS_LAST_FIELD referenced prog_fd instead of the
> actual last field, flags.
>
> Fixes: b5709f6d26d6 ("bpf: Support associating BPF program with struct_ops")
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>

I think the target should be bpf tree ([PATCH bpf] ...).

Acked-by: Yonghong Song <yonghong.song@linux.dev>

