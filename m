Received: from mta0.migadu.com (out-113.mta0.migadu.com [91.218.175.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9062F7EE8
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867806; cv=none; b=roO2WtXt805XM83n1AdliMOXEguMjPAOnre6/c1At7rNlkVP9UcWVPRN/RKSMMKWxKw3Z94FOUOaYSGw3VNBce8S6BE95Xkx+YGFkb7Wrd1vyaLTT6uSbMpau02zQUxYxDC9J+kUsRUQixQBu12kLft1Yrs6JCiAocKpDDIphug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867806; c=relaxed/simple;
	bh=bms54/ywKnRoTtDYc+SSoJDtK4Ame1iJrvfp7UvWa9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APe2AFB6agvFuEL2LJiBIm+g5vohzxhPf05Gws7oQ0hvE+EprdhQNQt4i+TV9uVfP0du8MKQwqd1yY3FwCotHdfje3ktUt2p4j8g0nRIXtgqPbK1jviGMbW0m0P239Aqkh89damsdLn5PtNQQk82M98kVlEsj8ZAErr+4KjXt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jQVGZYPB; arc=none smtp.client-ip=91.218.175.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jQVGZYPB"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bms54/ywKnRoTtDYc+SSoJDtK4Ame1iJrvfp7UvWa9A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790867802; v=1; x=1791472602;
 b=jQVGZYPBuh4VGEXNiXnoJSjoiHJEArXVs9+v2XzdbJeIln3d84SwHtuk/aIq6FugVO/C8xGp
 5kZ1VzJk8iPLPT6Mu8wj718/3FjvneSIgEJXlREQsxLsvOlBDJh7GJgwvXfyC5jaGlIjHkQY6oj
 X64hhgVmZR44tT6M3ULu9dA8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ea69964f73d1705c;
	Thu, 01 Oct 2026 15:16:42 +0000
X-Mizu-Trace-ID: ea69964f73d1705c
X-Migadu-Flow: FLOW_OUT
Message-ID: <bd1e4297-347f-4f0c-a1aa-9a750e3e353b@linux.dev>
Date: Thu, 1 Oct 2026 23:16:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bpf: Fix incorrect handling of user flags by
 percpu map updates
To: Masoud Aghasi <maghasi@disroot.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev
References: <20260930135753.1063495-1-maghasi@disroot.org>
 <20260930135753.1063495-2-maghasi@disroot.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260930135753.1063495-2-maghasi@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Masoud,

Thanks for the fix.

Pls add target tree in subject, like
[PATCH bpf v3 ...] bpf: ...

On 2026/9/30 21:57, Masoud Aghasi wrote:
> For BPF_MAP_TYPE_PERCPU_HASH map, htab_map_check_update_flags() and
> check_flags() are not considering the possibility of a combination of
> (BPF_NOEXIST, BPF_EXIST) flags with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
> This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect.
> 
> For example, when using (BPF_F_CPU | BPF_EXIST) flag combination
> with bpf_map_update_elem() on a BPF_MAP_TYPE_PERCPU_HASH map, the
> BPF_EXIST flag does not prevent new insertions as expected.
> 
> Also for BPF_MAP_TYPE_PERCPU_ARRAY map, using the (BPF_F_ALL_CPUS |
> BPF_EXIST) flag combination with bpf_map_update_elem() results in an
> incorrect EINVAL error response, even though the flag combination is
> valid.
> 
> This patch fixes the bug by adding proper flag validations and checks.
> 
> Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps")
> Fixes: 8eb76cb03f0f ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps")

I'd like to split this patch into two patches: one for lru_/percpu_hash
maps, another one for percpu_array maps.

Is there similar issue to percpu_cgroup_storage maps?

Thanks,
Leon

> [...]
