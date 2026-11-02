Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633305;
	b=yRWIUvSexdp5FtiprssdDseUQkvmHtScgRaCuBie4f1UuqR5j4o58jelphTVa1Zwy/HI
	 gDNvkKSA7tuwhFW5UkZL2/A9iv7wG8fXt5t0YV7dnzmRvug24JiOh68jqy8QlgizJUb40
	 A1V4Z1zEPZvPd2Aj/DnkdMO7pvgH19BttTby/ZUAW676HNvbUd+KB1HTjhSFyMFPmkSNz
	 1mPjHxQbq5NycNeDWdX6Ar/EWE5LO9Ocuvt2CAvz4CD5vNt/jYPIhDj2oZgbeJeuE8kb6
	 6qeeLTdTYbkYIMT2YUgk+o42aspjtscvHKHOu2DcMHS48MV/udWbbq4BKXMXwE3CRxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633305;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6WkRFhtCLZVCf9MxkWKrZd3TCBlxLoJ2vUik3IvzDyQ=;
	b=yPEe3bXICfTuX/G97TmLgvmpHoBD0bhDb1sbp1js0ErrvkrNG/eVjFzxCASCsXv7eYc+
	 onT7FDyM9lvrXbF6f2Z+SrZPnBHBCq7PFher3N1jq413DCPIMAZ4+GTak8xZpOdiSS85k
	 ZQjJxpLuDM2JVyvyuWecNXfpTxdaUo6DjzBRm93l7jLa8r1oQNVSrY/SlrO7ycazyZri0
	 f5uLZwLEdUr2ojHvprUkAK3bT9WoultfsHT0W6Nr3NiX8SYzsITLZeWBax8vCtzc8/Hu7
	 HL6ipjT9PV+KSQx92OEH8Qg7PczVcqcECJelfeWFhu1UoSevnwv3tUG3h98RCpIg0Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/zWX2XG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5806070C91;
	Mon,  2 Nov 2026 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/zWX2XG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785021F00A1C;
	Mon,  2 Nov 2026 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633305;
	bh=6WkRFhtCLZVCf9MxkWKrZd3TCBlxLoJ2vUik3IvzDyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=m/zWX2XG/rSKuFdLED6Lda9izVUMAc9bvJUaKiwtDcsBszEDY7kYNcNCluie4aRZa
	 Ijl/ivjA5oZsQiXZ0my2GvOtkz4c7/BveYGfnizFFLZTRCpSGLQaVzIlwaPlvsqfEp
	 2ceCxjfj8oHEpAbG3Pw6dRiBLofIdbxSd9KCnwVA4VUwtErT8ukxVS7E9+fNHNGuJC
	 WNZ6KoFU1573tc5xzNcN0dqKWn9Hsqs79KfgF7HbvtsWrUFJA0gWxt1aZ0AlvpWBHE
	 gBWdXhcjctqiqp5g58DwwvqTHYLDrIwHOkALqFDbeBC8IakzJ9RsBrfKw4ZTpoC7F0
	 OJ/+QcHVpW8Sw==
Message-ID: <0d7672ae-a856-4f0e-9aa8-52e897bcd4da@kernel.org>
Date: Mon, 2 Nov 2026 16:28:23 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Cover enum signedness and
 legacy name matching
To: Hungyu Lin <dennylin0707@gmail.com>, ast@kernel.org, bpf@vger.kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, yonghong.song@linux.dev,
 eddyz87@gmail.com, ihor.solodrai@linux.dev, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261101103221.51534-1-dennylin0707@gmail.com>
 <20261101103221.51534-4-dennylin0707@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261101103221.51534-4-dennylin0707@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/11/2026 11:32, Hungyu Lin wrote:
> Exercise unsigned enum values with their high bit set and signed
> controls through libbpf's data dumper. Include ordinary enums stored in
> eight bytes and legacy BTF with kflag clear so normalization does not
> lose existing names or match only the low 32 bits of wider data.
> 
> Extend bpftool_map_dump with BTF-backed array maps and check both JSON
> and plain output. Cover narrow unsigned names, signed and unsigned
> numeric fallbacks, legacy enum names, both enumerator orders for
> ambiguous narrow names, and unmatched ENUM64 values.
> 
> Build legacy enum records through the public BTF API and load them into
> the kernel before invoking bpftool. Initialize map data at its actual
> width so the tests also work on big-endian hosts.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Acked-by: Quentin Monnet <qmo@kernel.org>
