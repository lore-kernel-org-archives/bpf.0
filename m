Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4B468C11;
	Mon, 21 Sep 2026 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982608; cv=none; b=KBnZaV4UFjopHRqYPwfDvSkE1AtM1E2I/aMTyxYw84fyC4FY89P7UQ/eHaUbko/nYDeBmxmF8o3H5bUpcLsH0J8KLgOkK7Uo8cb5VZcvJeu2VwIcsdVjH9CHiFKbu5YawDDbFO4jp8UW93TeX0rc1WRgCneCal5/cp0MoSpWDvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982608; c=relaxed/simple;
	bh=0GCgDTrahHxYdOlKMe5DzW2ZMKBCwbFRqOYTKzT8K0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikX+CUPVYy3zzaCvaKjz2GeUp+OmjS7GEtuZXFHMYowWI/cNME1hD5dcr93GS1KmvZqzlgULDgh6DaI+BqXkMqZEj2R5pGgpzZ6buRmDnKheBRpozEpcortIXHyae/jfG0TE+dWIC5D3GwzEjGW+Itov6XpqxwM+0mK5FYkI+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTdkgfsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTdkgfsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495821F00893;
	Mon, 21 Sep 2026 09:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982607;
	bh=lgcRpVT/EUgwTLpBjhgsD85e5m8lHmeUn6T4yaa2HiM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oTdkgfsW4QqLuxjgzfF2IbF/Z/Fou35z0k60eVDVffdFe+NT2pGcKlOEfrkU2Sniw
	 PWui1AOxGcRfIjBCSkWoAZ583R4WeonNsDWCjo3jq7rvMidex7E+8HxN+fXCP1XZB/
	 oDuXLvy3F9bC6o4P4Cnryx2WAWVN/t6f8fgE3tqYYxGZIhIik9quaD8ZKo5KArt5mv
	 /QbbQ7KHLlGT93dK9ZFklc7kwI/qSkORYqzg6dm6teqGOWL8Af5Zy9Qp5BP1BZLAYa
	 Q49obE8+EK8J5b6CvDUby8VQfdIullyqpandi+ZpQU0O65O4MJteMaBzH/k5oTrgg0
	 bsMiFj2x4ubkA==
Message-ID: <e04ee6bf-70f9-40d6-83c6-1b7a48996b34@kernel.org>
Date: Mon, 21 Sep 2026 10:23:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/2] bpftool: Read ring buffer maps with
 event_pipe
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260921073556.99421-1-hi@tychen.cc>
 <20260921073556.99421-2-hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260921073556.99421-2-hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-21 16:35 UTC+0900 ~ Tianyi Chen <hi@tychen.cc>
> map event_pipe only accepts perf event arrays, leaving no built-in way
> to inspect records produced through the BPF ring buffer API. Extend it
> to consume queued and live BPF_MAP_TYPE_RINGBUF records in plain or
> JSON output, retaining the existing perf event array path.
> 
> Ring buffers have a shared consumer position and no implicit CPU or
> timestamp. Document that this command consumes records rather than
> observing them passively, and reject perf-only CPU/index selectors.
> 
> A producer can keep ring_buffer__poll() busy after a stop signal, so
> return -EINTR from the record callback when stopping. Keep stdio out of
> the shared signal handler and preserve callback output errors.
> 
> Link: https://github.com/libbpf/bpftool/issues/54
> 
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>

Tested-by: Quentin Monnet <qmo@kernel.org>
