Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6983E0745;
	Tue, 12 May 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607724; cv=none; b=o157j9FLh1ADVNH9cIgOVnA2viYkDIsmgMFP/eFykVDfYBnPxBTiROFjLW23VILB3r6GwuRWsoaPZaV/2DOPSieNBob2zMwoJxFFA16dXnlOaeekO0Zozqu+r+cZzHrkN/zcw4AkqN9I6K03D04gl/T30Lst+YWO7GwKSteAyBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607724; c=relaxed/simple;
	bh=bHJQQakcgRK9x5Bk1VgmWWyxJeKAlPReOPRvVi4pLCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uEXQCqOvCvoLJx8mQeebq38yCIDTIBRCuDZ5YOGfBcLXX2MVqBMUSwaR0p5YAwGr+LD8DrmC++BnC8WT1eYZPpOXiZaLr+pXKkmrvjcHQsyzrWmHxy0S5I0Hy/KaoojKREz8FIbcZ1+pI1lOUOJCp+1N82CDRNhlF6apvPeSiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gFNwK4FWjz1r6nc;
	Tue, 12 May 2026 19:33:05 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4gFNwJ6FwLz1r6nY;
	Tue, 12 May 2026 19:32:58 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4gFNw94TFrz1qqll;
	Tue, 12 May 2026 19:32:57 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id SDtDtvMBHnpi; Tue, 12 May 2026 19:32:46 +0200 (CEST)
X-Auth-Info: 6VMpQhVO1tb+L6MNEpw/9EhU9iLsKYo0+HVczNGV9hgFjN/Z1rDNQ/qDUeIL76Z3
Received: from igel.home (aftr-82-135-83-211.dynamic.mnet-online.de [82.135.83.211])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue, 12 May 2026 19:32:44 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 206A42C1727; Tue, 12 May 2026 19:32:44 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: geert@linux-m68k.org,  ast@kernel.org,  daniel@iogearbox.net,
  andrii@kernel.org,  eddyz87@gmail.com,  memxor@gmail.com,
  martin.lau@linux.dev,  song@kernel.org,  yonghong.song@linux.dev,
  jolsa@kernel.org,  jserv@ccns.ncku.edu.tw,  eleanor15x@gmail.com,
  marscheng@google.com,  linux-kernel@vger.kernel.org,
  linux-m68k@lists.linux-m68k.org,  bpf@vger.kernel.org,  Daniel Palmer
 <daniel@thingy.jp>
Subject: Re: [PATCH bpf-next v3] m68k, bpf: Add initial BPF JIT compiler
 support
In-Reply-To: <20260511212756.3163955-1-visitorckw@gmail.com> (Kuan-Wei Chiu's
	message of "Mon, 11 May 2026 21:27:56 +0000")
References: <20260511212756.3163955-1-visitorckw@gmail.com>
Date: Tue, 12 May 2026 19:32:44 +0200
Message-ID: <87h5oc4jpf.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mai 11 2026, Kuan-Wei Chiu wrote:

> +
> +			emit_16(ctx, 0x4a80 | d_lo);			/* tst.l d_lo */
> +			emit_16(ctx, 0x6b04);				/* bmi.s .+6 */
> +			emit_16(ctx, 0x7000 | (d_hi << 9));		/* moveq #0, d_hi */
> +			emit_16(ctx, 0x6002);				/* bra.s .+4 */
> +			emit_16(ctx, 0x70ff | (d_hi << 9));		/* moveq #-1, d_hi */

I think this could be "tst.l d_lo; smi d_hi; extb.l d_hi".

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
