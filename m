Received: from mta1.migadu.com (out-213.mta1.migadu.com [95.215.58.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04EA3F164C
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355369; cv=none; b=g76RU+BJLS2d06UcR3XzOsbNu9ODnLrKPDOQqDKsDWDCI+iCmMNNQHpVhBuN86uIeBYGgQj9YYzf+yYu4xPdvobNHnBNr0d8qR8pL7pZa6tYiaJGFdj0j3c5R/Kcs9H8L758i+1EKi2gXYZcMEjOiRZxb+JYQmqGVxxyYEZc3OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355369; c=relaxed/simple;
	bh=KKNmnnL96SEADB7zY0qWS7dm5hBrD7nIJMqQ5w20W3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQ0rqXzTxFN7mIaUDPHxmEIaHF9x6/wfXOhVo+Hf2mwHCg/MunEx1io8vyHzUElglQQ6t2HAvHqShSd4519/XH4/XpbjpPaxsa0h0v9jagqPi2yvtcP5vplCM5sCjh/DOGRgzE8Mxk5Mk1a1vHDMMEsWd4orFr2Oll/oDmc3kGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=algsKEHP; arc=none smtp.client-ip=95.215.58.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="algsKEHP"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KKNmnnL96SEADB7zY0qWS7dm5hBrD7nIJMqQ5w20W3U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791355366; v=1; x=1791960166;
 b=algsKEHPgiOuXMh/oC1ZnyrDXErcIy76adfI+xFADGcrTuACM2O1gP0PoBlSg7AE8lAndVas
 EsdBrqk5buCbikPRQ15kcrJZ4iSVa8ahcneYPAiqYhP9+PxFgIMXY2Dkj6wslawklbcBmUksd9r
 FFN9eE4Cah+h8hUgmgLjIJtU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ad030e68e2f67213;
	Wed, 07 Oct 2026 02:43:52 +0000
X-Mizu-Trace-ID: ad030e68e2f67213
X-Migadu-Flow: FLOW_OUT
Message-ID: <3dd7a2a4-149c-4603-81de-e0247d191e9b@linux.dev>
Date: Wed, 7 Oct 2026 10:43:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 2/3] bpf: Fix incorrect handling of user flags by
 percpu hash map updates
To: Masoud Aghasi <maghasi@disroot.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev
References: <20261006084604.780456-1-maghasi@disroot.org>
 <20261006084604.780456-3-maghasi@disroot.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20261006084604.780456-3-maghasi@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/26 16:46, Masoud Aghasi wrote:
> For BPF_MAP_TYPE_PERCPU_HASH and BPF_MAP_TYPE_LRU_PERCPU_HASH maps,
> htab_map_check_update_flags() and check_flags() are not considering
> the possibility of a combination of (BPF_NOEXIST, BPF_EXIST) flags
> with (BPF_F_CPU, BPF_F_ALL_CPUS) flags. This causes the
> (BPF_NOEXIST, BPF_EXIST) flags to lose their effect in some cases.
> 
> For example, when using (BPF_F_CPU | BPF_EXIST) or
> (BPF_F_CPU | BPF_NOEXIST) flag combinations with bpf_map_update_elem()
> on a percpu hash map, the BPF_EXIST flag does not prevent new
> insertions as expected and BPF_NOEXIST flag does not prevent
> modification of existing entries as expected.
> 
> This patch fixes the bug by adding proper flag validations and checks.
> Before this patch, htab_map_check_update_flags() rejected
> (BPF_F_ALL_CPUS | BPF_EXIST) and (BPF_F_ALL_CPUS | BPF_NOEXIST) with
> -EINVAL. After the patch those combinations are accepted.
> 
> This patch also starts returning -EINVAL for (BPF_EXIST | BPF_NOEXIST),
> with or without BPF_F_CPU, which was previously accepted.
> 
> Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps")
> Signed-off-by: Masoud Aghasi <maghasi@disroot.org>

lgtm,

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> [...]

