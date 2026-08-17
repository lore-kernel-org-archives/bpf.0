Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92923E51DE;
	Mon, 17 Aug 2026 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786961067; cv=none; b=AhFLKPucBiKw//C6f+FrWTq1lbnHoDSSMP/IQxEl93MCu2QzEXrn5gygsG5cbi9e5lo4s2OTUVCRw5jNWPqWFSkeS7coqD9DHVzZAnOzQ1Lvb299rRLZvlKUZLqhvwCvlLQ0FZUi6e+SGvdRtXwkrS/3rBaU7bkCbOyH3+IcERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786961067; c=relaxed/simple;
	bh=utRFfsqxNgiHzfEsceZjMMeKXJiFRk5SPBrN7tPbXzA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Y42Yf5hSVE4nN1OVdqjQ3o9E4y+pn4bScaWmNcHRjv6G2ABi1Twsigi6Jct1b05sQGwF9ToUs8tBNWztPm4b7J5jagIFLB2Cjt4GsnKY0i/O1y/APk/rt0Uqcv10aWFAGWRwzOvZrWuU3wtuWQm+UcF0vypQgtS/Fsxha7wu1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=mzrHBqQn; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="mzrHBqQn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=exQDKl2SwdsXatrY765IdmbPBTJgJTuanbvKk+DmXHg=; b=mzrHBqQnJS0n70TYiDNB1BHP2n
	pe3lWLguqop9VoNIAzNm42fwQiw4/BnwNjL0D8FW4uVz5FdIhtxwSUnIIXMlONNjYgJVnXl9eIweK
	JeqePrPrst7oZCpDVud9jD2uwLAMA/oUHZjzwSpEEXqrCj9r4sz7albkjziHiUDTiEJDDC5nz3BN9
	VxQ4609b/IIKMnjfsdxhVeLamiR8gaFDIr33PxLvIJmV784HiucC9yPA1fy356rIyTm5Jbm5hfRaL
	NTEhomqAdHXUwugP6CbMlJYCW/pIXUo3VK/eoU2Cyy/2fZww8r/BClSXyr0SxzWGoti8Vn/leUUWO
	dhbcpsMQ==;
Received: from [::1] (port=38758 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.99.5)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1wvuCW-00000003HBm-3r0t;
	Mon, 17 Aug 2026 12:04:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 12:04:16 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Pu Lehui <pulehui@huawei.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] bpf: reject stack-argument callback subprograms
In-Reply-To: <8331116a-2a90-4342-a1d2-bd3a97bebb73@huawei.com>
References: <20260816204501.493914-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <8331116a-2a90-4342-a1d2-bd3a97bebb73@huawei.com>
User-Agent: Roundcube Webmail/1.6.17
Message-ID: <ccea81b198d7a1a92ff4b4827465c9b0@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-08-17 04:16, Pu Lehui wrote:
> Just took a look at stack args feature. The limit looks good to me, but 
> it would be better to split the fix and selftest into two separate 
> patches.

Thanks for the feedback.
Do you want me to do the split, or will you do it?

Jérémy
