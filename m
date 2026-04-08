Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4801C4317D
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671644; cv=none; b=Z6yKeS/SIGlIj3XndyY8iFsqxFyCCO8iNP7j/YGl1L+tuSKdtAEsxUVSxTGAU2EYdJPcdOvpcsTk2NRpId/ru4pDZJaBjTe0NbPJo23ekI07bkj3X5nBQZ8RjTw566GUPpz1fNdAfE++unsgT9nz36djQZj+Trrv+S+wnvnqHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671644; c=relaxed/simple;
	bh=JqOd4WPsK3Odr7d7+31BrNcERTvOcY5ilMCZQQydlvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBLQ47H0vevPdMcshr11I0FBeCFMgUOXl5Cxi5hmJSMn7F0jXm5FzQRgIdkn704CnAURiOgx55LwmLJbQB8WelPc9xoFr8Os+c/yVY1j28wpvQ//HkCCa81NL4Heq1nf47Tvy6J0zSmpgbNMEak7rs3FWRZ4i1k46C5O/UQ8LYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OjTfA13h; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OjTfA13h"
Message-ID: <309e8f9d-519c-4540-84e5-4fc5ebd2915a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775671640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JqOd4WPsK3Odr7d7+31BrNcERTvOcY5ilMCZQQydlvA=;
	b=OjTfA13hCljXZKdimQqIN28X4XoZrs7dAvVkJiXUIxEEprZsP1evYMfJ8pxHzwijb+yS6K
	Wr0+a3CFA8idunrEn5vK9eShhF8hDz6sxjtGDCmvI91y2uyRvPp9LkIOAanfT/n5GDeExh
	QXqzoRQAvh3/L2v3k7bzlGdbvWOG6sU=
Date: Wed, 8 Apr 2026 11:07:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 05/11] bpf: Support stack arguments for kfunc
 calls
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard <eddyz87@gmail.com>, Chris Mason <clm@meta.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20260405172611.1336162-1-yonghong.song@linux.dev>
 <adcc0eb54109467ffa3e970608a73ba0b39230928555d09663cd771441c010dd@mail.kernel.org>
 <2701e70f-826c-4e85-a577-e6358401b44f@linux.dev>
 <CAADnVQLY2Ff-mVG4a8cVvmJ=HYPWQR6-NZWYz0-NnrLaVpb_BQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLY2Ff-mVG4a8cVvmJ=HYPWQR6-NZWYz0-NnrLaVpb_BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/8/26 8:05 AM, Alexei Starovoitov wrote:
> On Tue, Apr 7, 2026 at 9:53 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> In the next revision, I will discard this patch and implement it properly.
>> In most cases, for related functions w.r.t. stack argument validation,
>> I will ensure functions has parameters like (reg_state, regno, argno).
>> If the argument is a stack argument, regno will be -1 (not a register).
>> In cases where argno is not really available, argno will be -1. But in
>> any case, at least one of them is positive. The verification log will
>> print out message properly. If regno is non-negative, log 'regno' is needed.
>> Otherwise, log 'argno'.
> that also sounds quite hacky.
> Just pass two reg_states for reg and for next reg,
> and argno of the first reg. That's it.
> argno is always valid for printing and argno+1 is also correct number.
> Both reg and next_reg are also always valid pointers
> that get_kfunc_arg_reg() returned.

I will give a try. In most cases, only one reg_state is needed. But
there are a few cases (e.g. KF_ARG_PTR_TO_MEM_SIZE), two reg_states
are needed.


