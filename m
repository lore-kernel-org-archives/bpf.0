Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F65B222597
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 04:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788582791; cv=none; b=EOySHcUmRzLfk2oVJ/JE8gqtpQO5NSo+exH7/Uxa1X84douYhUb7rBNCtojQVZzBqpwTy+wqO47vKxrDn1HaFeUSVTAh2aVHgeYZiCfe+lYQH6sCt/SfkMe5ntcTiHq3VGEahEfLi2/ZHDzY9TpLSoIPd98DhkPXwGzfPcAHh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788582791; c=relaxed/simple;
	bh=S+yqJe04UoMbdyjmjqUyNEIPNJtbZOnTEiibvRHqZjs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=E+j02Ae70krP8yJBGumUSVocVm5wjx+BdNx+w6+SlhWfxVf1ASix4thPsAOUj1m6/sqWe77ZDuh1XzErxoYwndgrqBGH6e3QVQZoWGvcDHSeFZIl7jzQrVclNzN/82NJ3qYkefE041FfzjPC/+bQS+rFnpHwrOdHnm55ISpS4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvOfwWL1; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvOfwWL1"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-483960225ccso494646f8f.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 21:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788582788; x=1789187588; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mGZsDm4uizvC7uugERQ41jrzAxKK+9ADw0Wmwd9so7A=;
        b=TvOfwWL1LZuPNVrU5lIHK+P+QodrSruJEYecKQAVsobRlgfXMX3ZjphgB1a+tnr55w
         r0LY7+bM9R93rZeYaOcWK0mS4H6Sb1kxPssF+P4iP26l2waHyhXcYysc2cC/3kLmd5MF
         taU7013cmUhJUgqyzMsUx8dpfGF5qzIK2y3MJUM9IJQ1nJu2J2D7yzSr/JlRZ/kH0yml
         SX3jeuhlOz7UpyWvVOwWZVRyKMriqv3WTKtqwv6k0EaZuAg0MTrbjh6hOX86fxCbJF+M
         7+F+0X86j4sFNR43Ok4XGrIGr3skCdf2CH+/OXqT4ojv0RmpGVLquU395vp3+q6AhmGR
         Wmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788582788; x=1789187588;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGZsDm4uizvC7uugERQ41jrzAxKK+9ADw0Wmwd9so7A=;
        b=LsRYugfdtnkr1wozai02L1lPo5jHi/mZ6YiIFjKY+mQtSxnm4fDjcgelyZViU88rbj
         tHsEKWCuS08f/YjaScyzMmavi+xwdRXiwg/HfLIJgn9iEO1Azwm40HYiqDiLri1jTEzg
         4+4uClcMJdsF1JNGSKfupHLklwF21CHDo4bpKpsdpr5bwTXNNm+yNKdh3YBdFBH9oNFJ
         Rinxz5Wq+3Xme02cQyKlpJNpnzAK1EgZPQiN1+GBpYLEimpRP1g7D3l2KP7VZ4iRXcBV
         GyI2gr39N8jf4EbRvQQU5WMNv8oXF55oNMrt3nRlum+eFVO1lThzZ0L5LUe7Zoy6370g
         fyTg==
X-Gm-Message-State: AFuF++nKQLrFuR6fKkrCZ6BYWvcuCM89+R+nCwzth/LUSNfE6VOuD94y
	gdsibu6wzWhXd5M3u8eLJ5JL0rUEn1tQ6SlBL60QwLcmyP20vf8xHsaMpL3TD9KL
X-Gm-Gg: AYBFou3Uv1xB9kkUvfRuQ9GbPHbbA3KZvVeSf2qKr0k15ZwW6kEBjNB0sm3UYY0dVKL
	GmOIJPez4yhdFGPbiABY9jOhqllbiN8EB2klcN2AVpuSZwbh6BjfggJdj+68X28pR5BxnSN9nTG
	Eke8ho14jWsfrDiIw0n3PXR10NZyIs7i/KEcF5y14zYUqoVI+VNDqkRTtN3PkRDz4XfjVHB9E0L
	VUqPegF52l35F4mh5QVo8hjWW6+tLYzvhsA+kYMcIs+HdDgNjVdBkM7+rs5ObJAg08FGQjBhYus
	XTwxHSX1Ok+OWPIeYS01lqPnT2ApAhYeUe/gnxhBOdG3N/+5yFxf+mbJ6F7oswz6fqJh3FXdNjV
	PH3nflSb/pePep71k2tHYewlc/fcPWyQD/se2lI/+y4gPn7wU0nmANrG+Bzx6YpidKgLVUTE2aK
	9G+Rv4aYvEQcsk9mXk/Np2WGPPIgxoSKVJWafqq3UXQHYgUZWh/aBpUDsG9/ZOt1Ykc1TD8pGSB
	JgEnEVhHi/+fW9h2tWyAwUf8Qmn3AStQnDyH8wVQVmSAnpwJ63THQjzRScFwI23Xe+QFvUvP2uJ
	qYcsuV6ighXtmkcZHXVhhU5HoAwH+JBPpH472w==
X-Received: by 2002:a5d:5e87:0:b0:485:8a47:5b85 with SMTP id ffacd0b85a97d-4858a475c6bmr8204782f8f.34.1788582788421;
        Fri, 04 Sep 2026 21:33:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883927a3sm8269975f8f.11.2026.09.04.21.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 21:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 06:33:07 +0200
Message-Id: <DL73OLDDW2OX.3JGCQEAM6JO1Y@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Nicholas Carlini" <npc@anthropic.com>, <kkd@meta.com>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 0/2] Fix global subprog verification context
X-Mailer: aerc 0.21.0
References: <20260905034018.2095649-1-memxor@gmail.com>
In-Reply-To: <20260905034018.2095649-1-memxor@gmail.com>

On Sat Sep 5, 2026 at 5:40 AM CEST, Kumar Kartikeya Dwivedi wrote:
> Global subprogs can be invoked in both sleepable and non-sleepable
> contexts, but are verified based on context assumptions for the program
> type as a whole and not the precise context in which they are invoked.
> Nicholas identified that this can cause verifier's safety assumptions to
> be violated. Implement a fix by performing verification twice but only
> if different contexts are exercised, and add selftests to ensure coverage=
.
>
> Kumar Kartikeya Dwivedi (2):
>   bpf: Verify global subprogs in each sleepability context
>   selftests/bpf: Test global subprog callback contexts
>

CI failure in GCC-BPF run looks unrelated.
