Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056F379C49
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486537; cv=none; b=E33HW9sV7x2lUKbu8mO+s8Hw3rI7koVd1v7NESHCexaZJ2QWw4TR+YGNyr9Zyt6SxPVMMuEoloF3E3EEfPsqrQwYTRxfGaLPtoTEdFArBm0TywZ5KyBtBsSRVucNxMheQ9aWROwSuOGule8iEy/xgSLRlQefub1uaWMkG9hcBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486537; c=relaxed/simple;
	bh=W9StKkQ0/yj07eWoElZiv+n2VxDoLxnR18N0r893Esc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=S/hbe7yUcI549HgaHkQLZrTVuS46sukEvfojKP+rSJzjRH1zUQ+ilczO9gvxHajp/vo1In+w3gIXFObHTU9o9hkUkqud9g0rzft2XsZqMBdreYg0lYa07S3jRKO3oZnBSl+aYFpJ8GLmonh7bXS2Q/yMy6zFRulpUfBtx304egk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BPvNDeEl; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BPvNDeEl"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782486531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9StKkQ0/yj07eWoElZiv+n2VxDoLxnR18N0r893Esc=;
	b=BPvNDeElvRZEMwzggouWII2tofymA3pxu+5JfmGwK7CJp2impsOKKN+WsSGMrtCbjeGBPp
	NozIkXctwbMzmWJYZfWlevw7VPXWSaOnPydN+auEoQa0orwMQ/6weJ5g1FizLIV7FLvrOU
	M1Cmc9YYM8i84hgILpAHMIQo3kf7m7E=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jun 2026 15:08:42 +0000
Message-Id: <DJJ2QJQQ73CM.2WHKW4AT6QT1D@linux.dev>
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
 <akpm@linux-foundation.org>, "lorenzo.stoakes@oracle.com"
 <lorenzo.stoakes@oracle.com>, "vbabka@kernel.org" <vbabka@kernel.org>,
 "rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com"
 <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org"
 <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
 <martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
 "song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev"
 <yonghong.song@linux.dev>, "john.fastabend@gmail.com"
 <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
 <jolsa@kernel.org>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "jannh@google.com" <jannh@google.com>, "pfalcato@suse.de"
 <pfalcato@suse.de>, "skhan@linuxfoundation.org"
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Lorenzo Stoakes" <ljs@kernel.org>, "Kalyazin,
 Nikita" <kalyazin@amazon.co.uk>
References: <20260410151746.61150-1-kalyazin@amazon.com>
 <20260410151746.61150-2-kalyazin@amazon.com> <aeeDvpDnGnY5n69n@lucifer>
 <DJJ23EXF55VK.1EGQZS511HFB6@linux.dev>
 <f7a40359-a210-4711-acba-677e9c1d565c@kernel.org>
In-Reply-To: <f7a40359-a210-4711-acba-677e9c1d565c@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri Jun 26, 2026 at 2:58 PM UTC, David Hildenbrand (Arm) wrote:
> On 6/26/26 16:38, Brendan Jackman wrote:
>> On Tue Apr 21, 2026 at 2:43 PM UTC, Lorenzo Stoakes wrote:
>>> On Fri, Apr 10, 2026 at 03:17:58PM +0000, Kalyazin, Nikita wrote:
>>>> From: Nikita Kalyazin <nikita.kalyazin@linux.dev>
>>>>
>>>> Let's convert set_direct_map_*() to take an address instead of a page =
to
>>>> prepare for adding helpers that operate on folios; it will be more
>>>> efficient to convert from a folio directly to an address without going
>>>> through a page first.
>>=20
>> Why is this more efficient? Isn't it a purely compile-time conversion?
>>=20
>> Indeed in the current implementation folio_address() is
>> page_address(&folio->page) so it still goes through a page anyway, no?
>>=20
>> I might be missing context here about how this will look in the
>> memdesc future.
>
> Good question. page_address() is really only complicated for highmem. For
> non-highmem stuff it's simply derived from the page pfn.
>
> I suspect going page -> pfn will remain as efficient as it currently is (=
with
> vmemmap). For odd cases (SPARSEMEM without VMEMMAP) going through folio->=
pfn [1]
> might be slighty faster.
>
> [1] https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

Ah sorry I raced with you and replied to myself:

https://lore.kernel.org/all/DJJ2NKKPRANG.188CUADJO2CKK@linux.dev/

The above makes me realise that if we really do want to avoid needing a
struct page here, the "right" thing would be to make this API accept a
PFN.

The problem would be that our favourite programming language we use
doesn't know the difference between `unsigned long addr` and `unsigned
long pfn`... but I thiiiiink its unlikely those bugs will be latent,
I've made that mistake a few times and my computer usually let me know
about it.

Still, I'm not really convinced we need to change anything here yet
(modulo fuzziness about memdesc etc).

