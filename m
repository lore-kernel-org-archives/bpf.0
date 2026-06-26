Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DECD372058
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486306; cv=none; b=JDZlb1VdvlALpXLPOuvExD+xFXtIpe8AXoWnN2rGCM6rvH0RNXml6PVoLwb8L0k4FswTPIQKxnlhdSJRE1ldP7POsGKA9eKg98RxSOILnhAWPBF/AVYbDDe/7WL1MlFFtX4UXGRhfINSisA458FPxQcDD6m3iSitnNIl844j0rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486306; c=relaxed/simple;
	bh=37AKY9oNqPwRAQHz0jRe1+B9KoQmlJvkkLomE0s6udI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=HyTPJWrnydz0VVgJ/SQsbIdR1xQxyDDi5RiNXdHFjdXazGCwBnLnTMHoHuYcaUHNsJ9OAxV0F4dhVPBQv1cQmHWvdTA6DFYbcR4lGYCNeT7HbK8jFODJwDYZrkv3DwG9md5tqLclTlFBBdFcvzN2o3LIPobIBKqRf1gG/FQjVn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ka0GYafl; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ka0GYafl"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782486297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/3t6es/Sh5NFgNAr92B/NG50RTxtozIvYYF+FgF2iA=;
	b=ka0GYaflSKkPFQ7rFhIGoeEDcZfUQi/jBpWMJl+inaTs6Ay8kTJp9zdbYmSenvlQJh+XR+
	XB172PGZ4cpCqyqeulNT+N+xr0AurrQi4xrcP61whLGk9uJ8pOP+saDL+I6rAvgBdS3Po7
	QQIlkgcah948ts7waig31URzqiuDpu0=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jun 2026 15:04:48 +0000
Message-Id: <DJJ2NKKPRANG.188CUADJO2CKK@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Brendan Jackman" <brendan.jackman@linux.dev>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "kernel@xen0n.name" <kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
 <linux-riscv@lists.infradead.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, "maz@kernel.org"
 <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com"
 <yuzenghui@huawei.com>, "will@kernel.org" <will@kernel.org>,
 "seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "luto@kernel.org" <luto@kernel.org>, "willy@infradead.org"
 <willy@infradead.org>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org"
 <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
 "mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
 <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org"
 <song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
 <kpsingh@kernel.org>, "haoluo@google.com" <haoluo@google.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "jhubbard@nvidia.com"
 <jhubbard@nvidia.com>, "jannh@google.com" <jannh@google.com>,
 "pfalcato@suse.de" <pfalcato@suse.de>, "skhan@linuxfoundation.org"
 <skhan@linuxfoundation.org>, "riel@surriel.com" <riel@surriel.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com"
 <jgross@suse.com>, "yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>, "yosry@kernel.org"
 <yosry@kernel.org>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, "prsampat@amd.com"
 <prsampat@amd.com>, "wu.fei9@sanechips.com.cn" <wu.fei9@sanechips.com.cn>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jthoughton@google.com"
 <jthoughton@google.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
 "alex@ghiti.fr" <alex@ghiti.fr>, "aou@eecs.berkeley.edu"
 <aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org"
 <chenhuacai@kernel.org>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "dev.jain@arm.com" <dev.jain@arm.com>,
 "gor@linux.ibm.com" <gor@linux.ibm.com>, "hca@linux.ibm.com"
 <hca@linux.ibm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pjw@kernel.org" <pjw@kernel.org>, "shijie@os.amperecomputing.com"
 <shijie@os.amperecomputing.com>, "svens@linux.ibm.com"
 <svens@linux.ibm.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com"
 <urezki@gmail.com>, "zhengqi.arch@bytedance.com"
 <zhengqi.arch@bytedance.com>, "pavel@kernel.org" <pavel@kernel.org>,
 "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
 "vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com"
 <jackmanb@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>,
 "Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri, Takahiro"
 <itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>
Subject: Re: [PATCH v12 01/16] set_memory: set_direct_map_* to take address
References: <20260410151746.61150-1-kalyazin@amazon.com>
 <20260410151746.61150-2-kalyazin@amazon.com> <aeeDvpDnGnY5n69n@lucifer>
 <DJJ23EXF55VK.1EGQZS511HFB6@linux.dev>
In-Reply-To: <DJJ23EXF55VK.1EGQZS511HFB6@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri Jun 26, 2026 at 2:38 PM UTC, Brendan Jackman wrote:
> On Tue Apr 21, 2026 at 2:43 PM UTC, Lorenzo Stoakes wrote:
>> On Fri, Apr 10, 2026 at 03:17:58PM +0000, Kalyazin, Nikita wrote:
>>> From: Nikita Kalyazin <nikita.kalyazin@linux.dev>
>>>
>>> Let's convert set_direct_map_*() to take an address instead of a page t=
o
>>> prepare for adding helpers that operate on folios; it will be more
>>> efficient to convert from a folio directly to an address without going
>>> through a page first.
>
> Why is this more efficient? Isn't it a purely compile-time conversion?
>
> Indeed in the current implementation folio_address() is
> page_address(&folio->page) so it still goes through a page anyway, no?
>
> I might be missing context here about how this will look in the
> memdesc future.

Sorry I failed to do the history search here, this was suggested by
Willy during the review here:

https://lore.kernel.org/kvm/aWkN4yzwPtotaTeq@casper.infradead.org/

Matthew Wilcox <willy@infradead.org> wrote:
> The implementation isn't the greatest.  None of the implementations
> of set_direct_map_valid_noflush() actually do anything with the struct
> page; they all call page_address() or page_to_virt() (fundamentally the
> same thing). =20

But IMO the struct page isn't there to carry runtime information, it's a
type hint that this API operates on physical pages. Yes this is already
implied by the name but it also gives us a certain amount of safety
since it avoids unaligned or non-physmap addresses at compile time.

> So converting folio->page->address is a bit inefficient.

... but yeah now I see this comes from Willy I definitely suspect I'm
missing memdesc insight here.=20

> It feels like we should change set_direct_map_valid_noflush() to take a
> const void * and pass either page_address() or folio_address(), depending
> whether the caller has a page or a folio.  What do you think?
