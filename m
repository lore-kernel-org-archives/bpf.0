Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3673148CF
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076310; cv=none; b=O0MjRyzy3PHXB9L3sRs8OF6uKeZ9IV7N8yjyY4dLRW1bqQzpfb5FmmRWMPcfkGlZnQrZjgAs8kXDVMfx/oFlt1tvZR51Jpy2WrcDC9Bf2PB2FqS43JQJXJSOOeiXg+RnXNMqcLPAFX1gKPtRMQabZKkq9IiSFKlqZ7Bh+Ag4Ud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076310; c=relaxed/simple;
	bh=Jo3VIua1FtaYJziuukEKbPeWM86Y7gnJcmDBuGaDVIc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aGNSzaN1wkTs3wCxR38j+0OSyYpgop2X3S/SQbBV4oxKkRgXs1ApnBbuSIDwBwhNCA3TunKJBCSfJWytvXug42f4GkjvvNmUi4C/CuIYpgHQQ/rX+R+uBNdge+vtkKlZDpzyy/DhZ+i3A3sW6JllpBRy1+nPWVmGiFX0jFkd8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ca+49Mgr; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ca+49Mgr"
Message-ID: <83857e44-ddaf-42a6-a7a4-7875567c2f14@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776076306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61BNHN3NugbiJHgpQNmDPlFSCcJEwC1Ysvi4rYF1EIA=;
	b=ca+49MgrY/wtuy4zjylV42+9CfV9QzZyzISdIlwBnFmA1lf0oi9870sFPgmQH1gGzMvkuL
	0ESvfM8Tk0Z7z+LFqBGGr7OZQduqSEyMdSmm9Ep5FSh7vStLS9RVHKbjqwX0wbuTHUKhLA
	q/1d59+zu/iVu5c2GTHBwPIpEKKQ4l8=
Date: Mon, 13 Apr 2026 18:31:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: btf: reject division by zero in btf_struct_walk for
 zero-size flex array elements
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
To: bot+bpf-ci@kernel.org, phx0fer@gmail.com, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260413085033.71952-1-phx0fer@gmail.com>
 <b33a500484e976977e6b56d0e1fbc6053c8f2723247eb5d890fe4b2be7242fc1@mail.kernel.org>
 <a9392088-c13c-48b7-af34-57294a440a52@linux.dev>
In-Reply-To: <a9392088-c13c-48b7-af34-57294a440a52@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/4/26 18:23, Leon Hwang wrote:
> Hi Dudu,
> 
> The "btf:" in the subject should be dropped. "bpf:" is enough.
> 

And the target tree should be specified when respin:
[PATCH bpf v2] bpf: ...

That said, it is a BUG to be fixed on bpf tree. Thereafter, ci bot will
run tests based on bpf tree.

Thanks,
Leon

