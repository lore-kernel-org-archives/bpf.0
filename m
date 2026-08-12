Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED244CADF;
	Wed, 12 Aug 2026 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540531; cv=none; b=LLe6vJSzP2dD/2EA2mIVpaFDluxMkZF3YkEqFSljOyJV4FE3hYsdYuLcTGv8vaRK1D4ixFuW/4tQdFYM0AUsz8ZivFMbewOt+5pBvrRxO7sn/q26/BmtcIAlk0uz18ResJUhuEsPpLkAFYj+vEEV7mGqmWvYvL2qL6kqbdNBdSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540531; c=relaxed/simple;
	bh=nmHxmY7iTPhC2SO4r0Cu7D2E52TxGJ2ANn9r911bmEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WO1kPiml1TjCrlY8ynWGFUQF1JoMA0LNaksuc1ncHbZaqmow5N7Q64UAcu1zFDdrP3TuRqo8FtXE6nKxWPpMTAVYgJvZIxG+cl3ZmA4HcT8f+i2QENi92LPjY89BsBiWcMSF6rqcGksWDNmHlcvOtES8NcznGAreHSXj1KkA4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YjuSXfVF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YjuSXfVF"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CE493408CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1786540528; bh=JAXHudu46Eg+mqqdpRoOfueFzUFbPVJGGm+AfV0sLmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YjuSXfVFdNZsDUovgWNOnXrDWs1wY3mzRO64lCEOdBzQ4UsRfQncNKg6MQeD84dbH
	 bLkHsiYHrxg688yhBdaz2B2Q68XFUbt6CEC++v0IkcHtNVTga+yEe8MqsyaF4Doazg
	 AN6p2zh75ODIyTnguYSzN3Gphf2DObIsT6Eic8uYtSAfC0aPl0+O7aJrbUa9e6uYsW
	 dcILL/QzRmjIQwFrG1O3taxFeWv03VqKb3B/DUAOVCvasWelTiEfbB4qdrPoAAkdv9
	 rKaxWgR9X9gvKFI3he7IpfLgwKRk3QMn9Vw8YH9rQ3/9MCHkQLGxQ0KwrW5ieAi53E
	 ir/C+ZzHhlVQQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CE493408CC;
	Wed, 12 Aug 2026 13:15:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Manuel Ebner <manuelebnerli@mailbox.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Federico Vaga <federico.vaga@vaga.pv.it>,
 Akira Yokosawa <akiyks@gmail.com>, Daniel Pereira
 <danielmaraboo@gmail.com>, Carlos Bilbao <carlos.bilbao@kernel.org>,
 Avadhut Naik <avadhut.naik@amd.com>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, Hu Haowen
 <2023002089@link.tyut.edu.cn>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?=
 <work@onurozkan.dev>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org,
 bpf@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/5] Docs: changes.rst: rename file and references and
  add links
In-Reply-To: <20260812121603.1633270-2-manuelebnerli@mailbox.org>
References: <20260812120805.1631430-3-manuelebnerli@mailbox.org>
 <20260812121603.1633270-2-manuelebnerli@mailbox.org>
Date: Wed, 12 Aug 2026 07:15:26 -0600
Message-ID: <87o6f7jx8x.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Manuel Ebner <manuelebnerli@mailbox.org> writes:

> The current name does not reflect the content of the file, the new name
> does so. With the links legacy references should continue to work.
>
> Change name to software-requirements.rst
> Change names in Doc/translations/*
> Add link Doc/process/changes.rst to software-version.rst.
> Add link Doc/Changes to software-version.rst.
> Add links in Doc/translations/*
> Change changes.rst to software-version.rst inChange changes.rst to software-version.rst in
>  Documentation/*
>  README
>  samples/bpf/README.rst
>  scripts/min-tool-version.sh
>  scripts/ver_linux
>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
>  Documentation/Changes                         |   2 +-
>  Documentation/admin-guide/README.rst          |   6 +-
>  Documentation/doc-guide/sphinx.rst            |   2 +-
>  Documentation/filesystems/locks.rst           |   2 +-
>  Documentation/process/changes.rst             | 576 +----------------
>  Documentation/process/howto.rst               |   2 +-
>  .../process/software-requirements.rst         | 575 +++++++++++++++++
>  .../translations/it_IT/process/changes.rst    | 554 +----------------
>  .../translations/it_IT/process/howto.rst      |   2 +-
>  .../it_IT/process/software-requirements.rst   | 553 +++++++++++++++++
>  .../translations/ja_JP/process/howto.rst      |   2 +-
>  .../translations/ko_KR/process/howto.rst      |   2 +-
>  .../translations/pt_BR/process/changes.rst    | 577 +-----------------
>  .../pt_BR/process/software-requirements.rst   | 576 +++++++++++++++++
>  .../translations/sp_SP/process/howto.rst      |   2 +-
>  .../translations/zh_CN/admin-guide/README.rst |   6 +-
>  .../translations/zh_CN/process/howto.rst      |   2 +-
>  .../translations/zh_TW/admin-guide/README.rst |   6 +-
>  .../translations/zh_TW/process/howto.rst      |   2 +-
>  README                                        |   2 +-
>  samples/bpf/README.rst                        |   2 +-
>  scripts/min-tool-version.sh                   |   2 +-
>  scripts/ver_linux                             |   2 +-
>  23 files changed, 1730 insertions(+), 1727 deletions(-)
>  mode change 100644 => 120000 Documentation/process/changes.rst
>  create mode 100644 Documentation/process/software-requirements.rst
>  mode change 100644 => 120000 Documentation/translations/it_IT/process/changes.rst
>  create mode 100644 Documentation/translations/it_IT/process/software-requirements.rst
>  mode change 100644 => 120000 Documentation/translations/pt_BR/process/changes.rst
>  create mode 100644 Documentation/translations/pt_BR/process/software-requirements.rst

That is a *lot* of churn just because you don't like the name of the
file.  The naming is not perfect - it is the result of decades of
history - but I think we're better to live with it.

jon
