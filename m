Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED893279DCA
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299943; cv=none; b=ElrsvMXgVnBEAxJJODpXAXbUUhnlqXEn7+yRf1pawsORwc0fEO74U3teMtsZQMQpY+in/Zp4y6A8Mx1m+COeIbXEeLfi2pcSdUSeGcXmHZZQ3nCEuPTgpmbJn6PoBxL1NsGjUAbpUpAKGmQdjp+a7CypB1CgM5+Gqa6yFGI7nAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299943; c=relaxed/simple;
	bh=JsKO2kLHjVQxR/IxgPt8nD8IBx0qTuKaDg2MkQDwqj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbkD+tyGAxqPi9ZAViwWRhkF3pF9Ks/x8GyXMz55qONURKlhsFR59VAdbUktU1vBE1DFbiD/p9v2cIkdb71+eiO61sFVxUZYfWugulO9nLQ593wVr14fWd8+iRi6t9GBaQWKccBDqa2ikioWcd9HMq7F+nDwJMlOk+ezWYWiK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=onPtwnhR; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="onPtwnhR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JsKO2kLHjVQxR/IxgPt8nD8IBx0qTuKaDg2MkQDwqj4=; b=onPtwnhRpBuWG24r/TDgzkg0NR
	61wQrOBtoXKyLbTSe2P1bPo4ciDQafm/aTq1KTwF2tBZuXHe+lXNDDN0q1YmAkextI+OksnfwjT38
	zqjC5Va4esHpcoqVt/Maeqh3wBxnT1hULhgnaLcSi/icB1CPWrQ817wwM0k7enAxEEYJIYR5juIfI
	KzESkac68GV8zVqkDx0F/N3n8gVF+sPWqTxVCvmCXrphMlE8bebgi9EDP3o5wC9KSkZtLSKS6du4f
	gqXZdvlCcOCo2AH5E79EhvPP4OntpTJhLOev6qzTenN6T7oH8seN3btkaMwFYDcrnnwP0x6HW0Jon
	UD0rGzTA==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:32626 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1wHMu4-0000000B3NR-1n0a;
	Mon, 27 Apr 2026 16:25:40 +0200
Date: Mon, 27 Apr 2026 16:25:38 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: "Xavier Brouckaert (xabrouck)" <xabrouck@cisco.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"security@kernel.org" <security@kernel.org>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Kees Cook <kees@kernel.org>
Subject: Re: BPF: writable uprobe pt_regs context bypasses lockdown=integrity
Message-ID: <ae9xx6WBG-3HyEHT@archlinux>
References: <DM6PR11MB4722C282C0F20BB23F54A87ADB362@DM6PR11MB4722.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4722C282C0F20BB23F54A87ADB362@DM6PR11MB4722.namprd11.prod.outlook.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi, thanks for your report.

For information, Xiu in CC and I are the new Lockdown maintainers for a few
months now.

Honestly, I'm not found of `LOCKDOWN_BPF_WRITE_USER` being handled by Lockdown.
Lockdown original goal is creating a bright line between uid-0 and ring-0. In
other words, uid-0 should not be able to obtain write/and some read primitives
to kernel mode.

Fighting against userspace processes taking control over other userspace
processes should be handled by another security mechanism. Moreover, as you
said, this kind of behavior can already be obtained through multiple ways,
using ptrace as an example.

Honestly I'd like to recenter Lockdown to its original purpose and move the
`LOCKDOWN_BPF_WRITE_USER` thing elsewhere. IMHO, it matches well with YAMA.
Kees, do you have any thought on this ?

Best regards,

Nicolas
