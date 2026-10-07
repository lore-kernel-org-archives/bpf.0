Received: from mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E83F164C
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355365; cv=none; b=FToPGfQuX4WKUDVA6fTlqh8wCitEsuLxwoMii2bfPtzSq9EXxrUvPKBR7q/QiVJlQmsxwFVNMq/q0QoCdgrNbeuSuL0mI/ebTSlh6bDRrj0HVnfq++31WW9pt0pGQWik6nEWU4VANziHAO3tSD3T371uZyzTiDdgatB1NfKS7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355365; c=relaxed/simple;
	bh=m53TrKl3WIT0zHtvG9f1MqQd3kUBsLuNms8zhUYQyPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZAFko2nFv4e5Ohn+AY9hId66xGPHrxIMP/jmpRhMCq6Mvjc6glLEClIzZ4XY/aC0NbUoAoSAEjJ5tBEai2qSCXNi6EQiU7b23vGNIrn1fGWc9iOm7CN/CBJTMs7+1jMZJji3wSdypeM8ew8f3b8SbgxRHp3wkHhH2XDskgukFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ekxi3/GO; arc=none smtp.client-ip=95.215.58.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ekxi3/GO"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m53TrKl3WIT0zHtvG9f1MqQd3kUBsLuNms8zhUYQyPM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791355361; v=1; x=1791960161;
 b=ekxi3/GOR9gh0DMgfBJWtpodJ4LK1rNU6A7WxbhTCsa+qNFIhY1hzNqvfM7BclnrMlZCfGQg
 ftOGLgb32IO9Qpr3Tvpu/GPuXpi7jSv+3pvcYyNRTT2ftA1XwiIAnsjVli9WLse13rGv8h0eJi8
 h3TyfgqoweKln/6Wfn/3+QUI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cdc4b2163e91f45e;
	Wed, 07 Oct 2026 02:43:27 +0000
X-Mizu-Trace-ID: cdc4b2163e91f45e
X-Migadu-Flow: FLOW_OUT
Message-ID: <de8522dd-b626-45d9-a123-005da814f435@linux.dev>
Date: Wed, 7 Oct 2026 10:43:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 1/3] bpf: Fix incorrect handling of user flags in
 bpf_percpu_array_update
To: Masoud Aghasi <maghasi@disroot.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev
References: <20261006084604.780456-1-maghasi@disroot.org>
 <20261006084604.780456-2-maghasi@disroot.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20261006084604.780456-2-maghasi@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/26 16:46, Masoud Aghasi wrote:
> For BPF_MAP_TYPE_PERCPU_ARRAY map, bpf_percpu_array_update()
> is not considering the possibility of a combination of
> (BPF_NOEXIST, BPF_EXIST) flags with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
> This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect
> in some cases.
> 
> For example, using the (BPF_F_ALL_CPUS | BPF_EXIST) flag combination
> with bpf_map_update_elem() results in an incorrect EINVAL error
> response, even though the flag combination is valid.
> 
> This patch fixes the bug by adding proper flag validations and checks.
> Before this patch, bpf_percpu_array_update() rejected
> BPF_F_ALL_CPUS | BPF_EXIST and BPF_F_ALL_CPUS | BPF_NOEXIST with
> -EINVAL. Also the BPF_F_CPU | BPF_NOEXIST were accepted.
> After the patch BPF_F_ALL_CPUS | BPF_EXIST is accepted and
> BPF_F_ALL_CPUS | BPF_NOEXIST and BPF_F_CPU | BPF_NOEXIST
> result in -EEXIST.
> 
> Fixes: 8eb76cb03f0f ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps")
> Signed-off-by: Masoud Aghasi <maghasi@disroot.org>

lgtm,

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> [...]

