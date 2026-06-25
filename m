Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013B315D49
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419932; cv=none; b=GHW7HEqiePA4vx1W7A6deRT/7/Pfk5NqV0kVG74D3z4zijS4z5hKXlnyUwMvw73tQ2Y5UfCEKpzVSP1UwTbVZxJy2rnMx3fJxr5ofsjoEvFsiebVe63WsGU2prkgpxAHeHn77KdZyq2IDiQMP7UV+PCoglvLgFNkT0vetIwe6Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419932; c=relaxed/simple;
	bh=tD9u8pCFO1K+2MZyPOOgniei5TBaj+db9ZtABm0DM20=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ai4CzxmXe+pfRkU/fEmX8gLAwpvCj9EUFhYzqV8HEmZeWYLDCFxMGQXXXdVYU2iK61iEjKyc6D2bnBMW6it8O/lt/y1ucKRcX9dTa6hbwSYNSakiO185g3giek1a356RT8JZNNdbCU2k+j7qIH5fNP8zwlWQRs4/AkacaSooo9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apiYtfD0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apiYtfD0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c6c57c5bcfso3720235ad.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782419931; x=1783024731; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tD9u8pCFO1K+2MZyPOOgniei5TBaj+db9ZtABm0DM20=;
        b=apiYtfD0TakKP235+0E0wwC9RlHvs6SPl8IlalPfUWp/A9KwzbVd5JaaesQCmrrCg3
         uPLKJUeIVibS5jCk9garHWowogRa3YXujN2sDLTzLTnxbK7VcWw1x/E34ZAcZcc6OWI8
         wVjFGFBh3oDW/mVBB3v6SpXRGsPzYCqUR0wbMzbHWYpAaYIOW7fDzybillrAPff9BPsf
         B+nFL/dE21pZvHIv2Bnx7fUJNqDWT72cZY9t2R5VSWC/QDwnOjH7ccXITE3+LLiKQiBp
         VsJbA7d42F5NtF8J4XJzxYpcJs3/OfyTBbjUGB036Ed66j/2AB+DL/dHo72Ft6mbV8c7
         syjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782419931; x=1783024731;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tD9u8pCFO1K+2MZyPOOgniei5TBaj+db9ZtABm0DM20=;
        b=e0f0FamwjbXsiht/fewX7meHrFQQR5+s/CRFU5dmUfbUcmbgiVahql9JLMiKXg3o+9
         rng+SA8x1/Pu15pmG7KQ37J6/BfaplKZOs+HxSJZ2bhHFNSCQVhYhCFL1ELlb+7mIu9S
         oZyaS8Q2WBCGECPDRoSjoh0HZwDIbmROBKtdr1HSUoMoyZbNKVMsNII9DVVFBpDzLoM+
         cCR2a7H3/9S407oEuIYM5ca074QyFZ2Xu40ARVJErDdRuNNp9zTBTr+yX0QvlK//EYjo
         /kFx9dC0Ul3X6dNw+hgnivUzK5GqJg4RFEn6JyQfmCzU+w2Rg9dA0APJ4AfXu0m5Rs/t
         zgVw==
X-Forwarded-Encrypted: i=1; AHgh+RqS3Ogwv68bfMSGsnVlYfwwsXabuOCKcPVEk0xjpNy5300MsevlAmuyLvh2eiampVQQEm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV8kFzLqeQbYgTrtoxj6Lj/4r04pBsMU87EaTE54/uuWAiMeZr
	Pcdf2suvmeF8oS4QNmU4UTi3A+jNz7EsKTFISz29b/J+tDFBlc2OLGxd
X-Gm-Gg: AfdE7cn+zaPRrkRL8G+2ealGTXYLITbs79iIAcJzGMFeRwusqkqm8Cnz6hx8pGgGkh1
	8xF2MtWp5j9+AovIdckCaGVas3lNrTFrJMcTkBa/SlfUqixjs/3S464h5qtpqN29gM8sWXl6zgM
	6S8uKBpiCq4jVadAhYXbHFJYWKRvgKIsjSUDDgU/IW+sdJFWmakaunlV3iKF+9IRadWzJCwNCmt
	F21aYHnkA3Zy6vdk2aahYHyKxfweKlZwDMnxe8vWX/h1wKFUASF7ljeEj6c0EMd0kh83xkEYK6p
	DF15UT25UhsK19j9LD0LTIOpzn4DShJSGvzZBGjYIJZBSXJphyCb5+nq+9b2JM3i6cWMacMJH2w
	RSif3MkQUd8wGEd46475t65omg+kBbA+t+8AwogyjfkmdB037giDc7VSuQ0C/nVVIRVm8HcLJin
	a7NC23PDKxwU3UB6plhipt5frA6CjxhOnevbOoP++8QlGk3xjBYUIV
X-Received: by 2002:a17:903:b48:b0:2c6:5bae:f9ab with SMTP id d9443c01a7336-2c7fc9c0cf2mr42317055ad.22.1782419930970;
        Thu, 25 Jun 2026 13:38:50 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ae7a7csm26355775ad.22.2026.06.25.13.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 13:38:50 -0700 (PDT)
Message-ID: <4eecc37b00c9a3dcf076bfe2824d9c245f41e2c6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Mask pseudo pointer values in
 verifier logs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Quentin Monnet
 <qmo@kernel.org>,  Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko	 <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Hao Luo <haoluo@google.com>,  Shuah Khan
 <shuah@kernel.org>
Cc: Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Thu, 25 Jun 2026 13:38:39 -0700
In-Reply-To: <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-0-a190ebb8f3e2@mails.tsinghua.edu.cn>
References: 
	<20260623-f01-13-pseudo-btf-id-cap-bpf-v2-0-a190ebb8f3e2@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-23 at 18:43 +0800, Nuoqi Gui wrote:
> Verifier log printing already hides ldimm64 immediates for map FD and
> map value pseudo sources when pointer leaks are not allowed. The same
> print path also sees rewritten immediates for BPF_PSEUDO_MAP_IDX,
> BPF_PSEUDO_MAP_IDX_VALUE, and BPF_PSEUDO_BTF_ID, but those sources were
> not included in the pointer classification.
>=20
> Extend the existing masking so all pointer-producing ldimm64 pseudo
> sources print as 0x0 when allow_ptr_leaks is false.
>=20
> Patch 1 extends the disassembler-side masking.
> Patch 2 adds verifier selftest coverage for pseudo-BTF ksym logs.
>=20
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
