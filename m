Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4835FF6F
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990872; cv=none; b=j5b12HdEF196MfQ9FCOHFmPoKdCeUKnTA4ngq/Jg11gga18GJ6gYLXK76TZsTIBD+vu4UgSH3GXutSdz8H92SeqZs55bYmOCQiC/AOLbc4Dh7V+trYzV0uAMZ4ZkUIOgmO+AHvarqihV5wzkdUunA8NoKaZ/FaZnbsP8fHDEp8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990872; c=relaxed/simple;
	bh=YVfBYevuqTRuy8/kJe3rMnJo0MTaHBWxIX5jfNV0TNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAjgu/SWw0h/HU6J2W+WoJ2vtbr0kOauI1Fv9KMQ6y8cciap4RtYS9H+TDbZSNHx04UFdQFBLZWHO1Ny6Du1U0NV9cxqDGNUEt7n/CFMeyvhoRa1FL/s0WXH0vm5ia1SP/62+1qyQKrMDRpN3m+Sxo8IT1+xWx0kFtVDkiZI8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJH/MiEr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJH/MiEr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770990870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLljjLmcTsDj+jqLCEduc4jVEoNW8uK3HCG44ehIZc0=;
	b=AJH/MiErNSBDPBr02QsKSrwgNwoFF1Z9GEb79m4IuV3pJdOMYOJPXhFjblxze1h5JhBk/L
	Hno879vOQvY2bFjmTlmGHOg+PtdY10q1XX3nYJo38nsihTd9W9sn4JiaOo1pFmxTVMwYp6
	8tmArHph9SDWmtWBl2sVcIlx0NlOadY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-8EnlqqiwOZ29zwr_IGPhXw-1; Fri,
 13 Feb 2026 08:54:27 -0500
X-MC-Unique: 8EnlqqiwOZ29zwr_IGPhXw-1
X-Mimecast-MFC-AGG-ID: 8EnlqqiwOZ29zwr_IGPhXw_1770990866
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A284B19560B7;
	Fri, 13 Feb 2026 13:54:25 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.65.46])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AFAE518003F5;
	Fri, 13 Feb 2026 13:54:20 +0000 (UTC)
Date: Fri, 13 Feb 2026 10:54:18 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH v3 0/5] tools/rtla: Consolidate nr_cpus usage
Message-ID: <aY8qCUe8twZiTM8y@wcosta-thinkpadt14gen4.rmtbr.csb>
References: <20260213115234.430232-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213115234.430232-1-costa.shul@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Feb 13, 2026 at 01:52:29PM +0200, Costa Shulyupin wrote:
> sysconf(_SC_NPROCESSORS_CONF) (via get_nprocs_conf) reflects
> cpu_possible_mask, which is fixed at boot time, so querying it
> repeatedly is unnecessary.
> 
> Replace multiple calls to sysconf(_SC_NPROCESSORS_CONF) with a single
> global nr_cpus variable initialized once at startup.


Reviewed-by: Wander Lairson Costa <wander@redhat.com>

> 
> V3:
> - Remove unneeded cpus parameter from timerlat BPF functions as
>   requested by Wander Costa.
> v2:
> - Add `#pragma once` in timerlat_u.h to avoid redefinition errors with
>   pre-C23 compilers.
> 
> Costa Shulyupin (5):
>   tools/rtla: Consolidate nr_cpus usage across all tools
>   tools/rtla: Remove unneeded nr_cpus arguments
>   tools/rtla: Remove unneeded nr_cpus members
>   tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu
>   tools/rtla: Remove unneeded cpus parameter from timerlat BPF functions
> 
>  tools/tracing/rtla/src/common.c        |  7 ++-
>  tools/tracing/rtla/src/common.h        |  4 +-
>  tools/tracing/rtla/src/osnoise_hist.c  | 26 +++++------
>  tools/tracing/rtla/src/osnoise_top.c   | 16 ++-----
>  tools/tracing/rtla/src/timerlat.c      |  9 ++--
>  tools/tracing/rtla/src/timerlat_aa.c   | 11 ++---
>  tools/tracing/rtla/src/timerlat_bpf.c  | 19 ++++----
>  tools/tracing/rtla/src/timerlat_bpf.h  | 12 ++---
>  tools/tracing/rtla/src/timerlat_hist.c | 62 +++++++++++---------------
>  tools/tracing/rtla/src/timerlat_top.c  | 47 +++++++------------
>  tools/tracing/rtla/src/timerlat_u.c    |  9 ++--
>  tools/tracing/rtla/src/timerlat_u.h    |  1 +
>  tools/tracing/rtla/src/utils.c         | 10 +----
>  13 files changed, 88 insertions(+), 145 deletions(-)
> 
> -- 
> 2.52.0
> 

