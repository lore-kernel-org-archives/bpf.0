Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959640;
	b=ynX8M1xlOZPHkqn6b1tR+YvvcZLZHAQZjUO4Hwt4L9BDHk/A5a/+xaI5PXwNHvAIwC2/
	 sNfrpDNaGPYyDhg6ZAgZB6CXDrdXFsXbvtjK3maV/xVNNZqaCxtgVuN1DpJWNZnk58YXx
	 oeoMmkwO70ZRdDi06m7Ge7J38S7V9mTYzruGNDwWIMn/JnDlgBYQR1NLxRcOE3wURrjDm
	 HDw1WuruP37ZsEOXf8byj1pRNew3TC1984DrtjbUoVSf9mPzIetURDLJ1ZCdchQUNnQlC
	 Gl93Dp+PNp+alVqQC2vt9DBT4vPcYHIXeV1lGJ3CZ75bHDDHOwppKFpq5PVW5u/L2Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959640;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=pTFtW/TKWLkTwiR6xWWBlEqf5jzq3pCBP93iDmWfJFc=;
	b=avw1TJMzlTYTmkX65kEfSffbpeWGbCrT2l1jiRd8dVo2AVLlW0xSBtagyzn5NHE/5THP
	 vSUwRvv3tkAqVtuP66U17D//XOldLPQr4jOSayCsA/wDbSqltZ+WTZSeVfGjfQj29M4mr
	 GVCsAjNfLN3AA24YKykTWqbd4MS9VkjJl5R95FFaIcOkKBlONNXuM74nTByUT3AokJgUp
	 mPXB8/OY+cxf5qlYKXRrQmD/A/3/8X06/igYGHqTWHJQzb8O9BL/EdXM7Aj4CdR5oQhaZ
	 84mGGbopBhFoFyucMgcje56qZ7Luon10qIr4ZjvR6BdMKPIpZfF/MyeSgXKHqB30+sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j1gVT/nK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DDC606A31A;
	Sun, 25 Oct 2026 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1gVT/nK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBC01F031E4;
	Sun, 25 Oct 2026 20:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792959639;
	bh=pTFtW/TKWLkTwiR6xWWBlEqf5jzq3pCBP93iDmWfJFc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=j1gVT/nKNhO2IyuskMUAiJ1oAHVhAD17eOH7/kKsSQjiSelbjMLsDMYLsnoZZ+ocl
	 Jx8EXT/xZZ22uXPzCnjKtmy5T1SjeptGr/Rms8mCcvsM7FEJe0qMZ9FvbLsOuZQsk/
	 aFMTscNp7TFm0RGG4Lh16YlyWwn8NxvTPxBmzqp9R6dfzYUEfEpxLsq1+ihoIL+vTM
	 I1L/COd+h6vL+BnYvlwLO3jbDoHxQtdWYOe6ifRe8wCuXTJ3AfmGTUSkcapOqsH7dM
	 RGZtUADdl5YVvCvT0ViqjkjmCnsSF2hobr+7pGA75RpRCYEmUNpVe1UCHrH2HaGnpI
	 Lcz098gERiP7Q==
Message-ID: <2c3750cf-58e2-4b18-8f5d-8ccb010d2c2d@kernel.org>
Date: Sun, 25 Oct 2026 21:20:32 +0100
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
Subject: Re: [PATCH v2] docs: changes.rst: set the pahole minimum back to 1.22
To: Mark Severson <gr3yf0x87@skyn3tlab.com>, Jonathan Corbet
 <corbet@lwn.net>, Federico Vaga <federico.vaga@vaga.pv.it>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261022013432.2638010-1-gr3yf0x87@skyn3tlab.com>
 <20261022014811.2803450-1-gr3yf0x87@skyn3tlab.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261022014811.2803450-1-gr3yf0x87@skyn3tlab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2026 03:48, Mark Severson wrote:
> Fixes: fd5425b67355 ("docs, resolve_btfids: Document kfunc BTF annotation emission")
> Assisted-by: Claude
> Signed-off-by: Mark Severson <gr3yf0x87@skyn3tlab.com>
> ---
> v2:
> - Also remove the Italian translation's copy of the KF_IMPLICIT_ARGS /
>   pahole 1.26 paragraph, which fd5425b67355 removed from the English
>   document only; v1 left the Italian text contradicting its own table.
>   Found by the Sashiko review of v1.
> v1: https://lore.kernel.org/all/20261022013432.2638010-1-gr3yf0x87@skyn3tlab.com/
> 
> checkpatch reports the Assisted-by tag as non-standard; it follows the
> Attribution section of Documentation/process/coding-assistants.rst as
> published on docs.kernel.org. Not run: make htmldocs; the change keeps
> the table's column widths and removes a whole paragraph.

As checkpatch asked you, drop the tag. Claude is anyway wrong value for
it (older value was LLM).

Best regards,
Krzysztof
