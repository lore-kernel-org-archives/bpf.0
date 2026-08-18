Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6336E466;
	Tue, 18 Aug 2026 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787083847; cv=none; b=bhSiOtWj/FW2GvJDP1qoKxUc4h2Mgk2TzE/iwyVGnHbZmgWXimKkL1P+4eFhaS6pJ8o4HiRb2xOOQWX0VDOnS8QrzuPty9au2LIW80oxIWzvweZ0/e5HKlanZbIkJtPgejPkCgQaHJGqwC3+ATDybBTpFQscySUmjxOs6I3ltTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787083847; c=relaxed/simple;
	bh=woT1zsi14to1BWM9P1WvMv8qVMYsV1szojyD7lMbyCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nXzg1kCGWwGGZ+U7xGDfLxe3hSt/nDZX96PbvZ+o/75MKBk41FQPVoa+wQkf0aXYK8V88y97EaGeyO+vCr8VsVxMTagRkcD92AWurE49EddPmylSWUk6JNlESJWowF2vPZJSktjo56LBxNZdJAu9RTihupcrLYvMPvI8TCHe3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=OQsHpuIt; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="OQsHpuIt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=woT1zsi14to1BWM9P1WvMv8qVMYsV1szojyD7lMbyCc=; b=OQsHpu
	ItmETeHPBNCexRGovGmSiK/1fEe9+feHxvUwum1vDTb3CfY+mvvrEAKC/LZb4I/e31JQabE4pAaDF
	S0kdmZIMNZK3/4VsuxvzcdelOKLKBLDZeCADpZ2dmDCGJNdNh840FUZO+GEOtz6Z9GNl8EdMNpsVL
	idS1l/7HJSth11v7TVneHNO9TsAzorxwdVSV+GOD9YZnGvZEF0RMoTzb6YbhkpgWTv5evnZsoac2+
	ff9fINsIRrjiChTD8wo21iXUFag7kAEZdG2uYL8gT41oDNPzUbaEno1Hb/RtC8HFQXeItIQtBVqm1
	vkW6ZUY+u+2Gl9kyKxyXPyuxyiOA==;
Received: from [2601:18c:8100:a0e0:5a47:caff:fe78:8708]
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1wwQ35-00000001X80-2pgq;
	Tue, 18 Aug 2026 20:04:39 +0000
Message-ID: <edcebef940c262a83421666de67e8a07ca93e85d.camel@surriel.com>
Subject: Re: [RFC PATCH 01/57] mm: add pte_folio()
From: Rik van Riel <riel@surriel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Kiryl Shutsemau
	 <kirill@shutemov.name>, akpm@linux-foundation.org, ljs@kernel.org, 
	nico.pache@linux.dev
Cc: baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com, 
	hughd@google.com, lance.yang@linux.dev, liam@infradead.org,
 mhocko@suse.com, 	rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org,
 surenb@google.com, 	usama.arif@linux.dev, vbabka@kernel.org,
 ziy@nvidia.com, usama.anjum@arm.com, 	agordeev@linux.ibm.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kas@kernel.org, jannh@google.com, 
	willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org,
 mhiramat@kernel.org, 	linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Tue, 18 Aug 2026 16:04:39 -0400
In-Reply-To: <c05f7bfb-c84b-4c36-8091-5ec7721a658b@kernel.org>
References: <20260816224609.308019-1-kirill@shutemov.name>
	 <20260816224609.308019-2-kirill@shutemov.name>
	 <905d08d102e56a026a5ad69573c507d2d9becc37.camel@surriel.com>
	 <c05f7bfb-c84b-4c36-8091-5ec7721a658b@kernel.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-18 at 20:13 +0200, David Hildenbrand (Arm) wrote:
> On 8/18/26 18:38, Rik van Riel wrote:
> > On Sun, 2026-08-16 at 23:45 +0100, Kiryl Shutsemau wrote:
> > > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > >=20
> > > Callers that want the folio behind a present PTE spell it out as
> > > page_folio(pte_page(pte)).
> > >=20
> > > Add pte_folio() as the folio companion to pte_page(), and convert
> > > the
> > > callers in fs/proc/task_mmu.c and mm/hugetlb.c.
> > >=20
> > > Preparation for the anonymous collapse engine, which reads the
> > > folio
> > > behind a PTE in several places.
> > >=20
> > > Assisted-by: Claude-Code:claude-opus-5
> > > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> >=20
> > Oh nice, this could clean up some things in the
> > get_user_pages code too, when we get around to
> > tech debt there.
>=20
> We really need the page in GUP code ...

Ugh, indeed. COW can create "holes" in the middle of
a large folio, so even __access_remote_vm() will
continue to need pages.

I guess we'll continue to look up both page and
folio in that code, then :/

--=20
All Rights Reversed.
