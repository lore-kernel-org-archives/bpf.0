Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448213;
	b=cQEIWFurU3AvQbHqyFIHTbkQji6wSD9v82NnLRyPMY8C40T1o8zYRHDuCisNAXw8hRew
	 qqUfTTEVkOzqZ+U/mc4zNEdpbcv7JhMqlh0NUliqqxugYyzGHMV9dOl1ZL16iLld1AiAW
	 48CuV2xWgWQJePuUQyg9LaEVkQvnoUVBvvhd3C8vV4jKP16Gu/I04laDyNNxAtFGff1Bp
	 WlWgc6zqjXPK5eihpT3MXnJoot3+mMsRO7A1npkPRZYvsGbqv2ce7bbKq8r30Z72psWty
	 ryaDNbm6fb6f8l0wayIuYEQvjP/xIhpWpcqwOOCyOitCAhunY3Vr/EAr3T49HcbGUZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448213;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=K78eNE+fhVap56bP9RFkcQMuU33yDbFo/P1LLieR5cU=;
	b=a3cF7xmSybCcaGCXiOJaZHFgr4pxdkPa+TAwUGxYlaIsNg3hAOXBtK3dWQUDjE6lZ2b6
	 N9myVw30Tyzrvkad0hqQTNsYw0NYEcM+Qz4j5Fh3PJLT9m0rPhStEaYCzh5XwZeLmcmrf
	 NtRJEcNNb7798iheYGGHubUk3wfjKrYdU9eyH47rCbjGfPuC+tbAb9LWGqtZeE4DFRlkG
	 ixLgR6EYRO9ZcBtmNqRFCqAndyxwQfExa7kLPK/78V21ULp0AGLGqRMHgBY8o6zHe64ZV
	 uYvOHJAeDDRpqu1xDdj0EpWzicbtXbt2JKi4WkF5vTXIN8r8xpX5i9fAfYPkIYA+imQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cnjKZUuP;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E7F606A321;
	Mon, 23 Nov 2026 15:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08E7F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cnjKZUuP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795448213; x=1826984213;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5+EebavlsM89qcdx9Zi7c0Ia7LpQq33PUSBbXwYCd3I=;
  b=cnjKZUuPIuDK4vNZ1KRz9vPG9ZbJ/RWY5+stD8unhJieKcrjrxWxmHgr
   GM/6UQz9K/lqMAw/dzMAhGWmlrk7QAubgeN6jJfj7Ck9s+JOJk5FszhHz
   txiE+WAUGYtg9mvUw58O+ttC5NwOIHhWRNSECnbDZTCTBPQWSNtjlPzQx
   TEYRMCf2TiteakZzH6TiBcUFaCUg8LMBpC1uJBHnitIBWMMb2hZRHTLi2
   CWyDu32qlyHD85Jnk284QhdixdQ7wKIW1c4XFdiYAPP9ltxpparQJXVCw
   CXMoyb5NgnzAZ2Gm/bwQ19eiHg0hLc9WDNW8PYYe6+hxfpLyOqQiBkikJ
   g==;
X-CSE-ConnectionGUID: xK1iYR2zT2qEFtPoEbnrBA==
X-CSE-MsgGUID: dWEP7F4HRq+JkW8Cs9EUWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4302222"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4302222"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 07:36:53 -0800
X-CSE-ConnectionGUID: YXfgXrbRS6a6e/EcM251Ag==
X-CSE-MsgGUID: Nw2kEeu0T/a3pTpqiTbc0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11412355"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.109.217]) ([10.125.109.217])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 07:36:52 -0800
Message-ID: <a08e55c4-26dd-4502-9cca-b063387a0e06@intel.com>
Date: Mon, 23 Nov 2026 07:36:51 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups for
 user address faults under SMAP
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Borislav Petkov <bp@alien8.de>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 kkd@meta.com, kernel-team@meta.com, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
 <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local>
 <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/26 08:23, Kumar Kartikeya Dwivedi wrote:
>   SEC("fentry/tcp_retransmit_skb") <- attaches to the entry of tcp_retransmit_skb()
>   int BPF_PROG(retrans, struct sock *sk)
>   {
>           struct file *f = sk->sk_socket->file;
> 
> This program was written for doing a TCP related investigation. The first load
> of sk is fine, but sk_socket can be NULL (orphaned socket) or stale, so the
> second load becomes a mov with an extable entry. Below is the JITed sequence.

In every other part of the kernel, dereferencing a NULL pointer would be
called a bug. Isn't this just plain buggy code?

I assume the BPF program wants to tolerate these situations because it
can't fully participate in the synchronization mechanisms that the data
structure actually needs. So, it makes what (in the normal kernel) is a
buggy access.

The rest of the story is trying to fix that up.

But I don't quite know how this can be done "safely" in a way that the
fixups end up with good data or NULL. If SMAP isn't in play, can't this
just go reading garbage from userspace?

Also, can you talk a bit about the code generation on the BPF side here?
Are the instructions covered by the exception table handler all pure MOV's?
