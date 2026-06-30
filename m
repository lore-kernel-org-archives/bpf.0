Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14403DFC8F
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782842793; cv=none; b=MqVqD0CSf31fzFRpp0B9W/7PWYd2tL8J+eTt0USvMbokRt+bsQn843hTRwt+PVTPl0VWjCYgiLCy8b+jibtF9qwjnzqY6PhmduIFpDs1BOKEhv0uQylqrbRlJyqNeekJ/oE+ZWFO3/nHymc3pnxUrCyAc85Ap5xGOX1nYKNdbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782842793; c=relaxed/simple;
	bh=CCydaf8iCxcowGdrabRK9TAL0PXl8sDl0isd9KqbIFg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=HalQiVCtjdVh+IyH8pQ12CgnxtrKPtXloy+XHXvMxpAB+wGIIJE3tXBJwx4bZAxz9uG5SuHm9vDCZIuYgQPZ2xIzgew9eIcmtAl3J4hQ/8mIewm7ViwzAGuyfOJ4HZ9ZZ774G0yiMDXJj12FKEbhqYYycWlJUlUINsaCauJQlvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJhYR22m; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJhYR22m"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69d8f70cb0cso3628147eaf.0
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782842791; x=1783447591; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CCydaf8iCxcowGdrabRK9TAL0PXl8sDl0isd9KqbIFg=;
        b=MJhYR22mhr0PL4c+1IVSGhLN6njEgnua1G7NYYosJOMO0vALapwrhx91TRv4sYMpp4
         uynoAEfO43NqdmsNbPqcumUh9JbDYDBFJjrJq7XKHDx19iaqXL3GR00c1SX6IOvo1wat
         xT+Z8yc7FrjcQFlufTHVhCMflyZwGCjHB5iXREldY4oXRHmnYsumjb3g25wBWCJxsUV8
         gfsEeGkRz63WFkK1Y6RIEtzte8pf8ztd6AauQECZHYJabXeCKjWg7/cZRuqYxamUtN7U
         4Ib/vlbzkHp2e9qQZAjNpZHiB/lBjIwjXJ4HIsGADGAbhSQnogeZqCa8v1Dq6dE/Bujl
         NEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782842791; x=1783447591;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CCydaf8iCxcowGdrabRK9TAL0PXl8sDl0isd9KqbIFg=;
        b=M4bH//A6m7ZftzTyQvydvEXZ4355BDf9wJSHv5zGUM7nxODdTBm9Wu13xyUP05WXAY
         HJ2PNfqwVMNWk01TavLnq28FavzpKeQPY3MehPYEa4/TBbyF1DpwzLINjjIfEsyIxI2f
         k9J/mId7pauoXaPwzW94a/Kaps8nX7QED3R4HXmWSblFYi7ZV7TJxKXVI6tBumP2ex+E
         Xh/MXyB8WyUeZaDqaYTTcyTc0SdCyu/2v4AEhN8+BNf+8br4e05Brx3KF2miJuZU4b5w
         EyeYEC1GuMIaa2JBaL9vxXgKvLikmTbrB3jyJsJc0B46wjfsP/K7VH6cw/TMCmuO5Ajx
         /XGw==
X-Forwarded-Encrypted: i=1; AFNElJ9yiMtG4DcoE5N8QrqOhOpgYJgmmLZR5oJYpM3Czg2VylsIF2RyrKmXDyoqF5uCepXKfTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxvtdWgRzApUMmjGtzZn7tccywju+JPvzUCSlxbjc7Hlj1yOvl
	4vgL+qdNDvxYC0NNWTASl9bFLMn3anpR2zNLFdVfuVWsWdxuzBzLg92z
X-Gm-Gg: AfdE7clBQDMEkbXbyUR/C0N3QvwNPzl2YcFHKZP4TU4BheyxMqxdYKiSabdPApsGuUL
	cGb/EEs7aeFZK+mzWmtQNQg8lo1+7SHgjlplhheqTPtB1AgOtonAApigvs1SKWE29BDuo2xiVss
	T7ZO9v7QJnlSizJTi5jdxoJtdMVh+pnEJtMXLccXmnJ6/RE9mZ8OUNZbmAwbn8tVoyoPwvf6cpv
	wAWmpKSv2DqBVaDq0rAv1exmHpfevC8NO/Qdy+qcb+gQcyb4vTtlLQSqYE+r50CXw3939JxC2W8
	KqDv/4HDtrAY8aErUNCIpYlrEvJAJYnzv8oqz16NiNcGAo2Wb8UBbhebrom0nHBSChT7W1eB/vH
	NGYmJkzPPk+zIiUrr1ApLPtRoraL03CvH0seRdIf0s75UT/2PbXpr5gmoM+kdmgwSmvxA/e5r4W
	f4potj6MwvTWmi9C9G5U8k+xQagPxFE7sOaPk6/L1tyoIlnBPn2RXap9Re8uswCcoBjE8eirGqL
	5G51LsQhHGp03zq9w==
X-Received: by 2002:a05:6820:52d2:b0:6a1:50eb:d524 with SMTP id 006d021491bc7-6a1893fcc34mr2741079eaf.69.1782842791572;
        Tue, 30 Jun 2026 11:06:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5b::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-448dbf813d2sm2773410fac.14.2026.06.30.11.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 11:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 11:06:30 -0700
Message-Id: <DJML0UYPUL9U.P5NHVG4E32LW@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Skip libarena when the BPF backend
 lacks 32-bit arena cmpxchg
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "George Guo" <dongtai.guo@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>
Cc: "Eduard Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Mykola Lysenko" <mykolal@fb.com>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Huacai Chen" <chenhuacai@kernel.org>, "Tiezhu Yang"
 <yangtiezhu@loongson.cn>, "George Guo" <guodongtai@kylinos.cn>,
 <bpf@vger.kernel.org>, <loongarch@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc
References: <20260630025809.74043-1-dongtai.guo@linux.dev>
In-Reply-To: <20260630025809.74043-1-dongtai.guo@linux.dev>

On Mon Jun 29, 2026 at 7:58 PM PDT, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
>
> The arena qspinlock pulled in by libarena (bpf_arena_spin_lock.h) perform=
s
> a 32-bit atomic compare-and-exchange on an arena (address space 1) pointe=
r
> via atomic_try_cmpxchg_acquire() on the 32-bit atomic_t lock word. Not
> every LLVM BPF backend can select that operation; releases such as clang =
19
> abort instruction selection with:

Sorry, you have to upgrade your test environment.
We won't be disabling tests because people still have old clang or old gcc
or other older tools in their setups.

pw-bot: cr
