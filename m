Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E702D97A2
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020263; cv=none; b=RGKl7R+jtD7KMQMOHTdP1eW4UelvFtBL6WC7+JBmMi2g5xbNkuwtnrP1ixyifCxbk21WoZWFbOFxp8BbO6t1Q82e3yp9kDJdtVk/9WjPox8+ZK8RiS8nVNSI2zHg05L5w7DnHEHlcNM5pQnBejG9/JjA709Rj45uCdzv/H3bIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020263; c=relaxed/simple;
	bh=ZVUlkxeaMTJXJPPFCVrxJq/9bdSEP7BNcBobtEVeH9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dvd6CXSrsOzyeisKIcoX21reMkiTLH3/ZnJKY/+/YZytAp5tJnSKUQekGjE6xQ6hRH2buAUYWlPLhW6EsImp6YVGc/b1IILP1hMJ2hag5sIByx+fTXw6KsShT5scXwVcBP8SopyWsJlkHje7zgq9CyXiQ8JoROO2uWj56Xi+Wc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ej6dBDyn; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ej6dBDyn"
Message-ID: <44168005-28df-4b5b-96a7-b6b9e7494aed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769020247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CROyEznehMA1RhrDyu6WZuj0lQdIFsoxBRDmxAZdZwc=;
	b=ej6dBDynvxtF6pMKDGFlCnTnkhBJSvcz9eYMbWO5trBMsexpT6IsioTjnJgjrFkbjYOUVg
	s2mx/NdAgUaPr4rzIiPQJiloEgf5Hl0kYB8bERzsp4CPScdKL/xM2R9Lugnx4JhL6LBl2Z
	BYLijy9i6UZaGxJ+gksZMKg/h8bRw1g=
Date: Wed, 21 Jan 2026 10:30:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] scripts/gen-btf.sh: Use CONFIG_SHELL for
 execution
To: Gary Guo <gary@garyguo.net>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260121181617.820300-1-ihor.solodrai@linux.dev>
 <DFUH7UI3MM6F.1B30NTZ5NFSKR@garyguo.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DFUH7UI3MM6F.1B30NTZ5NFSKR@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/21/26 10:24 AM, Gary Guo wrote:
> On Wed Jan 21, 2026 at 6:16 PM GMT, Ihor Solodrai wrote:
>> According to the docs [1], kernel build scripts should be executed via
>> CONFIG_SHELL, which is sh by default.
>>
>> Fixup gen-btf.sh to be runnable with sh, and use CONFIG_SHELL at every
>> invocation site.
>>
>> See relevant discussion for context [2].
>>
>> [1] https://docs.kernel.org/kbuild/makefiles.html#script-invocation
>> [2] https://lore.kernel.org/bpf/CAADnVQ+dxmSNoJAGb6xV89ffUCKXe5CJXovXZt22nv5iYFV5mw@mail.gmail.com/
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> I can indeed build again when applying this on top of linux-next. Thanks.
> 
> Tested-by: Gary Guo <gary@garyguo.net>
> 
> You probably also want to carry some Reported-by, Suggested-by and Fixes tags here.

You're right. This should do it:

Reported-by: Gary Guo <gary@garyguo.net>
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Fixes: 522397d05e7d ("resolve_btfids: Change in-place update with raw binary output")

Alexei, please lmk if I should re-send with tags.

> 
> 
>> [...]
