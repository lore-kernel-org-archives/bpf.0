Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3B630DD3C
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098286; cv=none; b=h6nREHxv/0Ond+K+9aTcFdbHYDqT9ox2Ux9KoWQ8fcoWr3IH2r+Pi3dGMXwpN+uZWeJpnpbr4b4Tvg29Kvphe+xCn2ytPukPkoKKgk/3c1HS6V+IwOYtYX80xw7N5LJCKZXi87dpXsLVsj0SWcQVzbzSR9Fk/x5G9IVJjplmr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098286; c=relaxed/simple;
	bh=LsirsLNtt39wTKZPA+YTGKYfOI/MUdjDa3ENx9IOl/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHCOcjiNDEJ8LshfJBDY0HzhEogCSajtXo71/wA81kQdRLr6LPS9gJMkwnJVUSF4dYIVRJt//N8zlke0KwwjP0s9kM6qE3dUfaWjtbCgyYXKuTU7Cm54RY9QAVnCgBujjzkdl24E++Jr62RT0YUoVoBlY75T6zTgS6DKUr3+9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DA0Gv6nh; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DA0Gv6nh"
Message-ID: <ba80e1ba-a290-47d6-8f61-9bcb63a996ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776098283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWD2CmAX77KCX9SDFhxRCe+HNXaaKB/BBPC6P69rvJo=;
	b=DA0Gv6nhocj7o+h/3+4qNSYLo6g/GMxw4+hOV5jrKXg6j60eMD5k0VlZ+E0YrMH65y/pET
	glrP5bmLhdHJco3yJGxSWZw3IymN8j5QvFXWyTSfdNX/SggflP5spQ3+px8hSIDPoTWu8Z
	xarnkU5vq6GIbq1Jc4C4DeDfuLvlP8U=
Date: Mon, 13 Apr 2026 09:37:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 12/18] bpf: Reject stack arguments if tail
 call reachable
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260412050010.266625-1-yonghong.song@linux.dev>
 <f163dcbf46e9511eba14b22ed10467984bda3bf07a3d1bd6cd27ae14eadc2056@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <f163dcbf46e9511eba14b22ed10467984bda3bf07a3d1bd6cd27ae14eadc2056@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/11/26 10:43 PM, bot+bpf-ci@kernel.org wrote:
>> Tailcalls are been deprecated. So reject stack arguments
>> if tail call is in the way.
> The commit message has a grammar issue ("are been" should probably
> be "have been" or "are being"), but more importantly, is the claim
> that tail calls are deprecated accurate?
>
> Looking at the mailing list discussion on the v1 series, Alexei's
> guidance was "let's disallow mixing 6+ args and tailcalls" due to
> stack frame layout incompatibility, not because tail calls are being
> deprecated.
>
> Could the commit message more precisely describe the actual
> reason for the restriction?  Something along the lines of "tail
> calls and stack arguments require incompatible stack frame
> handling" would better explain to future readers why the
> combination is rejected.

Okay. Will update the commit message.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635

