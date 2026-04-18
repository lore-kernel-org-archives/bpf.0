Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6DD30DD0A
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776532643; cv=none; b=qQ0SSB+0xl0cmEcSDXr3F9zEGLEOYX/Z+5zbTSsikOkRXXc7p2EbPTXGZH4PLNzCoo4VEUOFkKljB7T6D187JW/Srj+NkYwimEVXS3fOV9mCLuK1qWW5ESZXHNEJOMKvuCb6ia9MaRYDcbxgdyC+oJoU3uH3eA8Px+D+2B51rp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776532643; c=relaxed/simple;
	bh=OJU+8kMZ/coolXSi1sdFj7XAedQjgpC9jeCzTyLS3Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ht/YRf2lfXCb6mEH/3mZTDt8YDYeSjEd1hTH5hwiAYadO54m8fDcWoD+xyf9Rlv3kq2VysG3gIjhJEN3oOjuEWKeZH7ncLoqY0fpdl5oaueObjBLdGsW+fnjuu12jjgpnJ/36Lb8AzZJ4bUsE2i00vVeFq4YfsalF3h07uemGR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RkupZKyP; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RkupZKyP"
Message-ID: <a2ca772c-4e48-46d6-9930-aecd9149018b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776532639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJU+8kMZ/coolXSi1sdFj7XAedQjgpC9jeCzTyLS3Y4=;
	b=RkupZKyP7fm9O2mA608kxVAoyENzMbeF+TZvFf09XaAxvCi/RoAOgQuRRofCGI541UQdxZ
	SKiTf90Ox7MbLuVM3JRJrETsJwd998S4boY/qyjLr/fhWzvfpi0zOb926cYPmcUtugTMxH
	zgZLq9tysCUyANuy2Sq7hTOF3sD9SPk=
Date: Sat, 18 Apr 2026 10:17:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 09/16] bpf: Reject stack arguments in
 non-JITed programs
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260417034744.2630316-1-yonghong.song@linux.dev>
 <9b0ca90ef418abe68516e5570b953bbbee79f418c1550255784baf8422e9e3c0@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9b0ca90ef418abe68516e5570b953bbbee79f418c1550255784baf8422e9e3c0@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/16/26 9:30 PM, bot+bpf-ci@kernel.org wrote:
> commit 6f3447bea13f86a674e917f5f8ef4474cdd3b0bc
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Reject stack arguments in non-JITed programs
>
> The interpreter does not understand the bpf register r11 (BPF_REG_PARAMS)
> used for stack argument addressing. So reject interpreter usage if stack
> arguments are used either in the main program or any subprogram.
>
> This commit fixes a bug but lacks a Fixes: tag.
>
> Suggested: Fixes: 21229535935384b01e3cef3c117233b23b2f3902 ("bpf: Support stack arguments for bpf functions")

I will merge this patch and previous patch ("bpf: Support stack arguments for bpf functions")
to avoid this issue.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24546989054

