Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528D35950;
	Thu, 13 Aug 2026 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786579579; cv=none; b=r5bkGbgw5yssSHg2RRuK20qEna2PfvMjOzd9XL3NuMhw2PZMPXzithkIRFnWAD6Hgx3tYIuyPZB8HtdVMyaHAtlkFSZoy2+MGEDw2v504V5eaJ6h55vShOCx7wvNioSGziyHQiLPhYFViLMlkRWIL7VTMH+ynApJjJpmtVRqrCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786579579; c=relaxed/simple;
	bh=uZGSwhkSiiXNgN+Yys2k4ul9+stbiYvdNmZbV16+anE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMc8vtPeeMKjfivbz6CtRbcwR+AJkQfFeBgkIe9DOa1RykjhTani32o3kxv22mYCxMeS1eDgwnTb0AXqjD60oO7+WHNSG4PtcnLDuDgmYx4VlLgWp1BMuGNimwj0Q07gzsPsgWLp33NThtah0ZBj4qSAd1N7lf/WW8xHjeEbAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uGIp9dpv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uGIp9dpv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=WsmI+d5tglbQ0dNASLAQY5C464KSfO8cnSoH1DMERTA=; b=uGIp9dpvQrQ5zuLyV0H6YMuzeF
	1RvrpfTcxeL2s6n/x53wOvWwZJZJ8Xo4Pm57b+0Xb7jOof6RxXnPW84R7QYo0yw51S8ZoxjSe0t0J
	1+xuHWbNfcQxeKlHPwVCRkoNnVF4zzwVu2Uo6Yuu1SdewNU+hN9k8DWT4Is5DgUxiwN/sThMXn0st
	vzlN0zPQ9euOZ9u1zEM/OKC5Nv1SCeG0oqLceE82177JsxnsV/CrFgGXqNUqVqqUktJFybMm+imwM
	nA6zTZ+XLzrD/448V1SRaepnYVl9ujjvyJPb/nuxFmNk5FzEj3UTsP2wBQfxC/clgZ1/s21pQbpMl
	aDf0tVqA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuIxL-0000000HBZz-2PtF;
	Thu, 13 Aug 2026 00:05:59 +0000
Message-ID: <35efe828-dd15-42cb-8639-60eaa07f2527@infradead.org>
Date: Wed, 12 Aug 2026 17:05:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Docs: changes.rst: rename file and references and add
 links
To: Jonathan Corbet <corbet@lwn.net>, Manuel Ebner
 <manuelebnerli@mailbox.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Federico Vaga <federico.vaga@vaga.pv.it>, Akira Yokosawa <akiyks@gmail.com>,
 Daniel Pereira <danielmaraboo@gmail.com>,
 Carlos Bilbao <carlos.bilbao@kernel.org>, Avadhut Naik
 <avadhut.naik@amd.com>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
 Hu Haowen <2023002089@link.tyut.edu.cn>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org, bpf@vger.kernel.org,
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
References: <20260812120805.1631430-3-manuelebnerli@mailbox.org>
 <20260812121603.1633270-2-manuelebnerli@mailbox.org>
 <87o6f7jx8x.fsf@trenco.lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87o6f7jx8x.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/26 6:15 AM, Jonathan Corbet wrote:
> Manuel Ebner <manuelebnerli@mailbox.org> writes:
> 
>> The current name does not reflect the content of the file, the new name
>> does so. With the links legacy references should continue to work.
>>
>> Change name to software-requirements.rst
>> Change names in Doc/translations/*
>> Add link Doc/process/changes.rst to software-version.rst.
>> Add link Doc/Changes to software-version.rst.
>> Add links in Doc/translations/*
>> Change changes.rst to software-version.rst inChange changes.rst to software-version.rst in
>>  Documentation/*
>>  README
>>  samples/bpf/README.rst
>>  scripts/min-tool-version.sh
>>  scripts/ver_linux
>>
>> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
>> ---
>>  Documentation/Changes                         |   2 +-
>>  Documentation/admin-guide/README.rst          |   6 +-
>>  Documentation/doc-guide/sphinx.rst            |   2 +-
>>  Documentation/filesystems/locks.rst           |   2 +-
>>  Documentation/process/changes.rst             | 576 +----------------
>>  Documentation/process/howto.rst               |   2 +-
>>  .../process/software-requirements.rst         | 575 +++++++++++++++++
>>  .../translations/it_IT/process/changes.rst    | 554 +----------------
>>  .../translations/it_IT/process/howto.rst      |   2 +-
>>  .../it_IT/process/software-requirements.rst   | 553 +++++++++++++++++
>>  .../translations/ja_JP/process/howto.rst      |   2 +-
>>  .../translations/ko_KR/process/howto.rst      |   2 +-
>>  .../translations/pt_BR/process/changes.rst    | 577 +-----------------
>>  .../pt_BR/process/software-requirements.rst   | 576 +++++++++++++++++
>>  .../translations/sp_SP/process/howto.rst      |   2 +-
>>  .../translations/zh_CN/admin-guide/README.rst |   6 +-
>>  .../translations/zh_CN/process/howto.rst      |   2 +-
>>  .../translations/zh_TW/admin-guide/README.rst |   6 +-
>>  .../translations/zh_TW/process/howto.rst      |   2 +-
>>  README                                        |   2 +-
>>  samples/bpf/README.rst                        |   2 +-
>>  scripts/min-tool-version.sh                   |   2 +-
>>  scripts/ver_linux                             |   2 +-
>>  23 files changed, 1730 insertions(+), 1727 deletions(-)
>>  mode change 100644 => 120000 Documentation/process/changes.rst
>>  create mode 100644 Documentation/process/software-requirements.rst
>>  mode change 100644 => 120000 Documentation/translations/it_IT/process/changes.rst
>>  create mode 100644 Documentation/translations/it_IT/process/software-requirements.rst
>>  mode change 100644 => 120000 Documentation/translations/pt_BR/process/changes.rst
>>  create mode 100644 Documentation/translations/pt_BR/process/software-requirements.rst
> 
> That is a *lot* of churn just because you don't like the name of the
> file.  The naming is not perfect - it is the result of decades of
> history - but I think we're better to live with it.

Agreed, let's not change the filename.

-- 
~Randy

