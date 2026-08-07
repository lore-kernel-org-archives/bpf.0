Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A91F192D8A
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065544; cv=none; b=njTRhVNOotSMb4AeT+LRE4XiX3USKi9zIvdLAgtSz3zhnew85wII/UNqwludpHy+ENuI8xMzXYSzxzF/nIeZJrvRvzyUW8kOIhtixhkSoOfGsmJGZa0qTxJxX22byGVJwZ7c8DGQNkQGd4DuiNGcOD2Z5/nPshCvAWd3HNCd/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065544; c=relaxed/simple;
	bh=0Mu/KQDO1nlE+KvoLmqRCqhwCIAKGPgkPHtByvTHMa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg4j3Vq7sVKxPdx2l7/pD9T2hQ0RywxkndfXaVAfLPADgE0nhLA6S54Nzq0PmyHUPm283rvh0dGeu63MX8eJ3xPqUQvC5PEjwqcSU4bXKix15SVh/fmdj55thEc9r47iueDCVcZL0sspMfBkUZ5ZrFTFYfAd/vpn5JRP/0EuCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ol5X5nRz; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ol5X5nRz"
Date: Thu, 6 Aug 2026 18:18:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786065539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWZTZqhIsmEN7JQt45MqdcH8PIGYNJY5P7d2TgZvBw8=;
	b=Ol5X5nRziZ0zebSd4FdbmNPb99EQQXWFzPAW1WmLDOmUOa9nDYURuDYRSCYRfF/Z7vcS0r
	I9RFXhO8Yfy43wuBsMHEnfeoBsh2rQ4LIsrdiW3qFxPilhUc+Fip7rIlatZru2BW1h/buc
	ctyrYnux8FaOj6+Xxvoz7yHe9oUm4K8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <jp.kobryn@linux.dev>
Cc: roman.gushchin@linux.dev, akpm@linux-foundation.org, 
	linux-mm@kvack.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, mailmap: update email address for JP Kobryn
Message-ID: <anUyXIVVZf3xcBM8@linux.dev>
References: <20260807010226.8995-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807010226.8995-1-jp.kobryn@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 06, 2026 at 06:02:26PM -0700, JP Kobryn wrote:
> Switch to my linux.dev address and add previous one to mailmap.
> 
> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
