Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937E23E35F
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195223; cv=none; b=kqpOahk/aIVhKZ3Gkf2HH/+XOS5skRiw4tBddgXT+O8UtQhXwcFRQGyFidPAs4R45CO79ALiUwVsoJ+2ZxUrBxW/3vyXg3/HqthtS2RdROb6iRsDe/E1SmLi4fdI0d5YoKdWLM1A0DCGgBppEA26UfcCguB40ZiFzKYrt5+8p4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195223; c=relaxed/simple;
	bh=9gNEEHZWeZPGUz7Bg1RzDIw7ae4vY/3fiqNwShzMwS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpOLnU4y9J5hNs73UJ7hLf9jTRi79hIgvEL0BKOjdn7EW9nYXXfNhxRcSnPKu+aqFvawwEK+IHi9c3dFjSvzVicevBTQdh19CSlEP/XzdXHCYO+Vt2KNlkdRUVhGVk49upZfcQ/Ixz15vdPwecbaroY3fS+6eSR7uVF8WZN2ZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LmgNKyPP; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LmgNKyPP"
Message-ID: <6b57f6c0-cd9c-43e0-b5dc-daa9fdef84bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769195210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gNEEHZWeZPGUz7Bg1RzDIw7ae4vY/3fiqNwShzMwS0=;
	b=LmgNKyPPH/Rt0ClhsttMn9HrWmQod5akBoDGLLnRE6s0xCPhDSrXRnHUjK4ZRSQd1E1z/H
	pqKBvtfUoRUJ5laTTHCLxfu5xDebhYYw93y7ZHpDb1mBwUT1CaetFDb8anRBVTIrrNns3y
	iixAfNAd1okpHrvQ4svw0s14UhsblRQ=
Date: Fri, 23 Jan 2026 11:06:44 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 dwarves 3/5] test: add gcc true signature test
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
 andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
 dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-4-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260123172650.4062362-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/23/26 9:26 AM, Alan Maguire wrote:
> Use Yonghong's true signature test program to verify signatures
> differ for function "foo" with optimized-out parameter.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Tested and it works fine to me.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

