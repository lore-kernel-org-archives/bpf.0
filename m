Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793467157;
	b=Q2BmlreJu12jrpo6BRG7A3+06shZtTF4TIElfyyInMaPGGHOr2yIlsxyrhUbcEjQFkv7
	 BcDDFpsO5+6zwkAKx7wf9fqQqcuQKYOKPq2H5XmTIrx8PjuJ6NV6mWjhNxYsSWmJc/LXo
	 0Ju89N2HSIZyga6bki+VgvmPvmdHgykOPmiGytJox7W3X7kg3X7zHYj1HUl2FtVh6yqsQ
	 afN1EA8ffM6b009urQH5KvC/aulCC9qLdABeu874fQBj29QEogKz8ncpzXPhUq6hI28mk
	 jQ0vrwjT22ULwa8sJ57fbS5NflS7Xmo9hT+58z0tztwJVi9U+ujAauO8Xm4HCprisYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793467157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+iJ0a4xwnvduAC40tjoKCL5h2tUu76zSQglrgv1MqoQ=;
	b=SIEJkNSw+SbufBNO2sG0RMORQPcJmIWuzb6j7wAOsYY92seewWmplVeMDXiuaPl5kz+5
	 V6W9sIWP8DCuNR1KYZGT+Alwuo4O3vwavnu46OBtmrf225Fmit7KJ+ZICz/2YEOhQgEt/
	 msBCTi08H8C67YlMBT+PVyDot8y2x2y4NnhDPx7R3GX9RM8Zdx/3oDyOoLgQygO3DfhYj
	 NQdIoThNJNb9QbFVegYtSmM/EOdkWd8B+twy2Ibx0klkeROrxJuuB1lt5tMTr7YxX+wic
	 6EosB6e+IucFZ32VV0lJQU+UPTI40qRWk5egtIDfZUANnyUpOLglAGrZPxygBN0DWmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=smJd2GsO;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30983606A31C
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 17:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30983606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=smJd2GsO
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-886e61fa30fso660029b3a.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793467156; x=1794071956; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+iJ0a4xwnvduAC40tjoKCL5h2tUu76zSQglrgv1MqoQ=;
        b=smJd2GsOgk33z1a9NsA2IRRaXVbgQcOy06lL1zBbEXzvJR5Hjap9SkumOqUrXctSm+
         wWN6iatbtwfB90U5grPlMaRULuwtamGl7HJJAbzuzVQ0f26NAMexNwIeR5/2Hda00xOd
         PQLxiczXi7hAvQzQ77vRcNiWAIQ9xGSV4kIhqSEscA08Lx+JcTld6Tb61p0sK6nG8KF1
         cE8QmphByy5ZcdmB7o5wHNYUQvIJ6NIHSK39urE/syIITO++CHC8ATj8lvl0x5oIu4EZ
         j+XDy5d0+eA+js/fQj0XqGCkXEszywpgSDnCzXz5vJpI3QWQ41uztALOqu1fSyRBze17
         5Nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793467156; x=1794071956;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+iJ0a4xwnvduAC40tjoKCL5h2tUu76zSQglrgv1MqoQ=;
        b=0vEOy4heTJ1xPtgztCIAJdJxp37Ieb5NFEGnoOyh0rLJxe6uYTJddd5lUXnB0lo4Ru
         owRhTCfjqkpVazBx3RAvyiGNkXugbTNWCIL3EHAgJILhfdQHob9/GqFr04DGVtjCqkBb
         LIZ6RSXpDwf2Hl+J4+WRsfNkfGW0cFt+NHTt1Joy/+KK4hIv0iDt86bPeWwfMDXjJsB3
         a6QEYnCTmZo/CZFEHhIdAD0JnfnfvaTcUQy+FxaSEjnnR7bXk4J22H7b0iMM2H8hoPMU
         1WDbykRNFuusiFqHAQGTP6DpeE2cpxjZFyosPF6mRwjNFizWxTxfe4X2nA9Z68zvtQAp
         sUow==
X-Gm-Message-State: AFq9FYJbi461Dwt3oMlMaTEtv46atuCxRpJ9yEoZ3RMv5716MuP/BF7g
	YZsBNiKd8gHEGrYABMujWUoBhk7OztKeO92auYR0YEDYva27kcKrIy1J
X-Gm-Gg: AYBFou1oPKnIcDL3kr3oFFCdSXwd5KsYV3wiGKPnfC7F6XYL2srhPwA+5ErlQaPOyex
	FbruOCbv+GgKN+ujy2GkbUbu7rVsdncojoM+WlRvfXtX3eYH4oJrTAjBgpKlUpHdlAyOoX6/wzT
	2wOBBlGvhC0Ah8pw5f3wIeRtOHN0hh8smF233Xra8M39YlfVn4yyRXnK/LlVRtNQwO2kw8X/6CQ
	0PlI4A0ng/+7RuA8QxysfvMluZ6SoPXwn23nezzOX2/BwU+38uNzQcOFgax3TgtE72pG4OaClIR
	7wk3nvZV6vhK3YW+4UOep5C0i2AFeo4XDSt6PmiljrxxPAglQX7yGZLi3BxguW938BiRg1W1Xa7
	vVAPFtrkjWZQPHnwC74TvsbKUzAXjoNLf84H+saHJ3C/7g5Ktf6x1U44A10jDQLgKJN18/Vz7b9
	xFJTY1/dFFlsIFZ4pwPX8Z3oozvW7/LD4JLwH285fBfQM1hzI07D6suK4wiqOILinHRso3OWEZf
	Ln1UnE7wwbBKJzsuuO7qvcG/1cCSdm4/eXVYru7oPM0Hu9xgYidXBua+QBVnepB0OK06KTAAe0D
	mCVLqwQtsSztco4t7IpMnoWGJ1Pri7J8Yxal+upbBT23X772ZXxzGZQr6u7V+UdRXUFuqXpN5lR
	8EsV+MHR5KUFIYpsR0m6IGmkit8vxSyav4eo=
X-Received: by 2002:a05:6a21:3b49:b0:3e2:70b3:957 with SMTP id adf61e73a8af0-3e928959011mr3838382637.30.1793467156400;
        Sat, 31 Oct 2026 10:19:16 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09706f01sm1745003a12.20.2026.10.31.10.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 10:19:15 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 17:19:15 +0000
Message-Id: <DMJ71P0VWZY8.3P0POXHH1CZXL@gmail.com>
Cc: <bpf@vger.kernel.org>, <alan.maguire@oracle.com>,
 <cupertino.miranda@oracle.com>, <david.faust@oss.qualcomm.com>,
 <irogers@google.com>, <jose.marchesi@oracle.com>, <vineet.gupta@linux.dev>,
 <yonghong.song@linux.dev>, <martin.lau@kernel.org>, <mason@kernel.org>
Subject: Re: [PATCH bpf-next v3 02/13] libbpf: Dump kflagged BTF tags as is
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, <bot+bpf-ci@kernel.org>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <qmo@kernel.org>
In-Reply-To: <eab20bce-ea0a-4936-9fb1-dc5ef5a7822b@linux.dev>
References: <20261030233355.1836749-3-ihor.solodrai@linux.dev> <b8912e062900f51fd8c8f44c44ef43d0788ce6af12582abc0060dd6cd4c05065@mail.kernel.org> <eab20bce-ea0a-4936-9fb1-dc5ef5a7822b@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Oct 30, 2026 at 05:36 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
> The incompatibility affects:
>   - old kernel BTF + bpftool before patch "bpftool: Normalize legacy
>     arena type tags before C dumps"
>   - new kernel + old bpftool, in which case the users will have to
>     update their bpftool

I don't think we can accept the second one.
Every bpftool since v6.15 wraps the new string and prints

  void __attribute__((__attribute__((address_space(1))))) *

for the arena kfuncs.
After a kernel upgrade no prog that includes it compiles, unless it
defines BPF_NO_KFUNC_PROTOTYPES. It's not only arena progs.

The list misses module BTF. Patch 4 skips split BTF, so on old kernels
the new bpftool prints "void address_space(1) *" there.
People do such dumps. See commit d8d5c0151148
("bpftool: Support merging multiple module BTFs in btf dump").

can we leave type tags alone and print only decl tags as is ?
bpftool adds decl tags only. It adds them to a split BTF in memory and
dumps them with its own libbpf. Nobody else sees them.
Kernel BTF has no kflagged decl tags on records, I think.
Then no need for the resolve_btfids change, patches 4 and 6, etc.

pw-bot: cr
