Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030B3B8D41
	for <bpf@vger.kernel.org>; Sun, 28 Jun 2026 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683911; cv=none; b=czOnBnXJMDfNkIgdsQtkq5shLj9kUP0mYWlToNXk7uzSuq0TnwFTxuWTOZB/X3zmUQthYusriMNkigiIjbhtM+qzxu7/kRbFMD6hNCw9MnmWQrIweDSfhXH+UaZqJ+84h2TZMJ4ghiPr16vL6fT6+q4gax0McvpzhFeuQ1VC9UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683911; c=relaxed/simple;
	bh=7GaW//3vMQKNuds24JBMxJkk7aabcTbCAu6TL+/88D8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q3a81F4foCq0pmGaAhkprCyDZyh2Xm/tMhyIYS3CEKYMyWkI2iAnsBfmuUeGznOHR7LSLDv4HuPZTISh913295aaWfj1wOf8D5I06t1bB6r6jSuhmJ5ypG+REgay2Bjd8M5WUoaRkSqDGMXX73vym5K8Hsoxr6phVtYLh60yc6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=nbrC+46+; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="nbrC+46+"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wdxW8-00Gg0U-5s
	for bpf@vger.kernel.org; Sun, 28 Jun 2026 23:58:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=z/KMx8anaL5w+PXCtnW0sEl6HzMMeODYDN18QctIWPo=; b=nbrC+46+e5sWcxSkVBQHSqNtdr
	xLgZ1nF5vhWFPHrHAmvunZrb5VvYElMy9zPiReogxAXuON9zZ0NjyiS3PBa2SW0P1/vfhXWJlmQST
	VLVQt7e4nnZo+j6c5r0ZAXSFZU+lpEg2tuWOWUUEevjoTHP8Mc/Gp5pxrXo2Hi0CPsXT8w+4s5+CQ
	e+x+LvzV0vnSJBGgGtAsu13ecqi6znE30cMDOT8w6U7wh64xasMb7DW/pkyrVDoyGePeMXiKXiAjQ
	089ebfox6J+5VOIiNg5UUtZ+H2O1Zw02f3PFhULAohEe5IiXfKlblDnh0LV/L6uv2Wbpz1EbBLwGn
	gXn3e0Cw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wdxW7-0005wN-Qx; Sun, 28 Jun 2026 23:58:19 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wdxW5-00DEHl-ED;
	Sun, 28 Jun 2026 23:58:17 +0200
Message-ID: <fec0345d-da0e-434e-8be2-73ab553aa876@rbox.co>
Date: Sun, 28 Jun 2026 23:58:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Fail unbound UDP on sockmap
 update
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
 <20260626-sockmap-lookup-udp-leak-v2-4-7e7e201c951a@rbox.co>
 <20260626204125.C75961F000E9@smtp.kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <20260626204125.C75961F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 22:41, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Will test_sockmap() in tools/testing/selftests/bpf/test_maps.c now silently
> pass if socket() fails to create a file descriptor?
> 
> Because this patch changes the logic to expect an error from
> bpf_map_update_elem() by checking if (!err), if socket() returns -1 due to
> setup failures, bpf_map_update_elem() will fail with an error like -EBADF.
> 
> This would cause the test to erroneously pass without actually testing the
> kernel's behavior for unbound UDP sockets. Does this test need a check to
> ensure the returned udp file descriptor is valid before proceeding with the
> map update?

That's true, will fix.

Michal
