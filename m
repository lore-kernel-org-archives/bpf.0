Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842281A682C;
	Fri, 17 Apr 2026 01:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776388263; cv=none; b=fR0Mhefrp+QP66TfOi0zYhU8x5q/QCxGC6YzjSUjOIJfI4PLNYU8qNcKK+fXzrSxJB7yjXiv3e5eykY8i0ZGINZMEQQyrt2DdTyjBuQ9OiV+bjdLut2uoxptVXFK8SJKk8iFBtkaandJhKo2jhnizKF89sMeUjR8GcUe1QgvTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776388263; c=relaxed/simple;
	bh=rexyT2iehtBU3zUQ4xS3C+FH42ieixAKEaurXUl26T8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JsLfF/9Htz0yP+zWq+v05bhkDlcpRtdZimOnS16kVc11RvyaqGoRFd4QNHrmS/QBQfGXrBJ1sXKBIo8NRH4Gcw5SREJSikOI+kfEPXhYsfNMjnAOcqRHDBP/wQVn63a8tFsirDZNxTYOIzcYqmsGt7hXMVuSCQk1y525IFfb6E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=sUBToCGQ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="sUBToCGQ"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1776388258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rexyT2iehtBU3zUQ4xS3C+FH42ieixAKEaurXUl26T8=;
	b=sUBToCGQ1iXmIap+JS4K/AzIK1YlVeuLGoCFhuDd89LlSMm5Isyk01MvFNjFRXiZEABGII
	Zn0sJQZeq0p5aVA87wveRR2iDbnrmpkl2gBF4zquNQUA08NPoMIS+X78YfVBfSaBocmGDO
	FJnjRqtjVwg7zzx0RwG+wMRq08RwJaPJT7YCJ/GmEMW97dYZH1OZDzzDN7RwoSRMUBxfdA
	DH+Z9pMUu43iMmoT4euXm9WHRqImWMQpOTbI1YJg7m8/sPLzA8dlldFITNVEBY2K6dAK8O
	MlRcN1dRVy0YI/9mkry1U4cWJMVLWKsds9ktvHGXPiy/s0DCegWuLUZHy19EPQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 18:10:45 -0700
Message-Id: <DHV12UBOCLQR.1QIPQVFI10VDB@postmarketos.org>
Cc: <craftyguy@postmarketos.org>
Subject: Re: arm64: Supporting DYNAMIC_FTRACE_WITH_CALL_OPS with CLANG_CFI
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Clayton Craft" <craftyguy@postmarketos.org>
To: "Puranjay Mohan" <puranjay12@gmail.com>, <catalin.marinas@arm.com>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <mark.rutland@arm.com>,
 <broonie@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <mb61ph6hsxj94.fsf@gmail.com> <mb61pedcvxdhw.fsf@gmail.com>
In-Reply-To: <mb61pedcvxdhw.fsf@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu Feb 29, 2024 at 11:43 AM PST, Puranjay Mohan wrote:
> puranjay12@gmail.com writes:

> I hacked some patches and tried the above approach:
>
> Here are the patches(RFC) that I created:
>
> LLVM Patch:

Hi Puranjay,

Did this LLVM patch ever make it upstream? I'd like to use CFI together
with BPF LSM on arm64 and wondering what the current state of this
effort is.

Thanks,
Clayton

