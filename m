Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142624A4F19
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002845; cv=none; b=iJhnUzOGvFwfBsEEljNuyxeXff/DjuIBYaLID1gqgSt+NxHlZu4q5sbgNMhsSWLzz6avSryGAcD84IXkYBxP9DEz0h1ISiikXmmnplMKyF3rhUs3Pr+J9sjdnQ3/bmmWAaVmEgG3C3ZQXi6l97PExK6+J2xGZpQKKim0B+nOStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002845; c=relaxed/simple;
	bh=T2xrw/c1E3Ja2rs4a6+7iBlnfLMJOZfExljnlhOIpBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oB0dlkZtVUuO2+JC16aYP/JTeG9iF1XS79Ow0iyZlbt7yUiSCCiL5WKA9WLnc+0E6moNEbmX0RvVd36Jh2l2GOBHGDlbHKWVQ3TjDQBNPH0PXwseFIB6eCvWj9dKy41jA4do5fb9HGgYWKYkQlsX6rwDw15xIkHtlOANvpCWOc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ep+WeM9r; arc=none smtp.client-ip=95.215.58.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ep+WeM9r"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=T2xrw/c1E3Ja2rs4a6+7iBlnfLMJOZfExljnlhOIpBg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790002840; v=1; x=1790607640;
 b=Ep+WeM9rGnW1c1VRFfEvy48Ousx8QV0lGLRts5t9CkmQIvvxvmkdTxjbor/sZTsaaPQ7MnF2
 o8xZHK8UkKPQ1VwOFbSWY2Jinl6tEOisq4+cN6ysP7vUEWY3L8ExZdyoe+VvH+jMCBwlZfLOq54
 p8+Ee/fhYoMRA2c9JCZe/j0E=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 83fd918f1e2ee08b;
	Mon, 21 Sep 2026 15:00:40 +0000
X-Mizu-Trace-ID: 83fd918f1e2ee08b
X-Migadu-Flow: FLOW_OUT
Message-ID: <58c6111a-dd36-4b59-85d6-6ab2576219b8@linux.dev>
Date: Mon, 21 Sep 2026 08:00:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 14/20] libbpf: Add cleanup_info to
 bpf_prog_load_opts
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260920054337.871564-1-yonghong.song@linux.dev>
 <16900372d8d1bf2968c1cc9d6d16790243368ac169064fb9cdd6e90264e63bf9@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <16900372d8d1bf2968c1cc9d6d16790243368ac169064fb9cdd6e90264e63bf9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/19/26 11:31 PM, bot+bpf-ci@kernel.org wrote:
>> Let a caller hand the kernel an exception cleanup table. Extend struct
>> bpf_prog_load_opts with cleanup_info, cleanup_info_cnt and
>> cleanup_info_rec_size, pass them through to BPF_PROG_LOAD, and grow the
>> attr size bpf_prog_load() computes to cover the new fields.
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This isn't a bug, but would it help a future reader if the changelog
> noted that cleanup_info_cnt is the last field of the BPF_PROG_LOAD attr
> struct, so offsetofend() on it covers all three new fields, rather than
> restating the three edits?

Okay, will explicit mention cleanup_info_cnt is the last field.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538

