Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533932;
	b=R5aBabC/OxNLdy0AAKEmE40TGCIAbXDC0xLuWpIL+a/sEG3yQaweB8xK4nv+o8mInKN0
	 x8yYJPEVGPbiSOp+nNSX48IxA6kSQYHRs3QtcEJT+CAG+utXKqB+Ge2/YyQUWsaU6Qsr7
	 Ip09wyI+l5ZpM4aM/U8xBKizME1P9iMsIcu/LfQWC5zM0DTT29CxGks8eYDU1wZdZ3mXX
	 1BSE1s0/38zkUJVFn/Irc7uAzTaeXl063WSdKvPoAf0viRGoVXNrQq/hKPDFF4G2wnZi4
	 9jGFJaQFmdqT2cR+N1Dp+GlWTDoksqG4MuV9RX/Xn7SlNtzFwjYZO1qoFfgZxRofElA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533932;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=btHphTAK6ohuPbBz+dF6c5OB060P3Vypyg9wmHrMU9M=;
	b=p67tJ4sxGPR0SyAvKZhUycrRR9v9a0RrZB+btMSTDCL2q2VW4E6khskgZL3rlVco1tJY
	 La4VFYoYuhudVDTmj5UCOYZK4qwcpE3jyZxTqCTV4EZ4pai9w02kD5j2/WPNyaZF1QcIe
	 1kw4waL3zWQVgyxtAE7BgSgYsSN+EEfubYlzOTMyd+KEfo54E1uVqkaU8TjMytd1s6Wbb
	 pWeQsZJ1VFh41ygDcnL5QXEPCPnpTmPymauBiw974IvacK/xspA9apVQgJa51vqN6DSG+
	 /rknRFxg542O2t8XqaVTVjqyHMWMrREobw8LNxdfepP4wKYPVgLY/6cMlTYr1l6Oo0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="h2Q/EGjZ";
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80D606A31E;
	Tue, 24 Nov 2026 15:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A80D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h2Q/EGjZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795533932; x=1827069932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VoZnG4/Zmf85feJ91RzB+8Y7XiJQJA34orV55heIZhA=;
  b=h2Q/EGjZaAp4pCAR6vwQqkORrFTqMvjLmXMwG98Mj5lHmGLfSPikrKKZ
   UOyl/B4yJuWimH/fpNpIBmnLEL0KNqC7p0ElAr6q0eMIOzmJOyz1o+F73
   YNh1VXG/fTAzcQ0160E1f/XdfudIdH/IP0CGqzpFEE8oeOoMBQ2gmzYjg
   xoWhwUxhBERS19S9o1B1yoSFFVW+/2axBcTmJNwZJm0VxBeYJp/QcnNB8
   7vwamF9odt8YLFZ/AV3djXBHqRehrSjGdlUU9/0kgkfZhtoEb4EUoB1zS
   1WFfqWjw6f7FHlrd4HYY7takSTmdnFJvzHA+zoIB4UBHnEZdHzOwAczti
   Q==;
X-CSE-ConnectionGUID: J6ljxaLLRwaCATPGyv7eig==
X-CSE-MsgGUID: y1ytumulQLGdKO9tYsiQhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4431081"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4431081"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 07:25:31 -0800
X-CSE-ConnectionGUID: FgZA4N8EQtW0+VpBoyKjxQ==
X-CSE-MsgGUID: ST24igQJSUSuqdRCulpDoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11793927"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 07:25:29 -0800
Message-ID: <077779c3-aac7-49c5-8887-0d4266caa2d6@intel.com>
Date: Tue, 24 Nov 2026 07:25:27 -0800
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
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, bpf@vger.kernel.org,
 Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 kkd@meta.com, kernel-team@meta.com, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
 <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local>
 <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
 <a08e55c4-26dd-4502-9cca-b063387a0e06@intel.com>
 <CAP01T77AiqVjyTJbHYqXe2v_h+PYzFEe3DeVTc1nyZVnzOfd5w@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAP01T77AiqVjyTJbHYqXe2v_h+PYzFEe3DeVTc1nyZVnzOfd5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/26 09:23, Kumar Kartikeya Dwivedi wrote:
> It would be equivalent of doing copy_from_kernel_nofault() in the
> normal kernel.

... and running afoul a userspace address. So, no, it's not equivalent.
These accesses are more wild than anything else we have in the kernel.

So I kinda reject this bit of the reasoning that's been presented quite
frequently.

>> Also, can you talk a bit about the code generation on the BPF side here?
>> Are the instructions covered by the exception table handler all pure MOV's?
> 
> That is correct. Each extable entry covers a single load into a
> register. mov for 4 and 8 byte loads, movzx for 1 and 2 byte loads, and
> movsx/movsxd for the sign-extending ones. On a fault, ex_handler_bpf()
> zeroes the destination register and skips the instruction.

I think that's also important to call out in the changelogs. Because the
"zero the register" behavior doesn't necessarily work for the whole ISA.

This all makes me really nervous.

Do we at least require that these super specialized programs have the
bpf_prog_info->gpl_compatible bit set?
