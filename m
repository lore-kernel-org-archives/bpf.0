Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C97388873;
	Thu, 16 Jul 2026 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185424; cv=none; b=VPHaK1WW93SF5j98dsJyyt2Hu+SGa8k52JxxqthakcZjkA/EUKU8acYLigEhXcboATUBERkqMKOUZ5Xz61l0isy3HHpTtbCfgGQQXv1JilW2tjhLOsEoibO6FAtASMVB8Vrc0At5ejCuY1Iaa5pBxsnL7RcYJjsF2fFBdmKYeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185424; c=relaxed/simple;
	bh=mpK7RTt9BmL/o0/UfkQazuavIvPWtv+hyuf5KKtGb/Y=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=da3LP62Yg9dyZLdMviDgBl3+HxXhQDBjLpfCHlgrpHZtnJTqqBTvXGOf11F0mCxV7HYZI8DfraE5dQej00UnkQZ1p8gyXCezTXhECDU4aIpUfZb0wcVchfF+OuWTpcGSTj8pfzMdhKiuAvhIjof1+jK4UHen0wcj1clGkU/6sAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4h13sv35wGz4xNtD;
	Thu, 16 Jul 2026 15:03:31 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 66G73Sq2031759;
	Thu, 16 Jul 2026 15:03:28 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 16 Jul 2026 15:03:30 +0800 (CST)
X-Zmail-TransId: 2afa6a58824217f-02beb
X-Mailer: Zmail v1.0
Message-ID: <20260716150330696WUY2gk5CaNNaxqm2ggKWL@zte.com.cn>
In-Reply-To: <2528a896-a0f4-46ef-a7c5-83c7c8a2980a@linux.dev>
References: 20260716142613346GZ_NR5Zi4awr3wEReuIMG@zte.com.cn,2528a896-a0f4-46ef-a7c5-83c7c8a2980a@linux.dev
Date: Thu, 16 Jul 2026 15:03:30 +0800 (CST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <leon.hwang@linux.dev>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
        <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.xin@linux.dev>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBicGYtbmV4dF0gYnBmOnN5c2NhbGw6IExvZyBlcnJvciBjb2RlIG9uIHRyYW1wb2xpbmUgdW5saW5rIGZhaWx1cmU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 66G73Sq2031759
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 16 Jul 2026 15:03:31 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A588243.000/4h13sv35wGz4xNtD

> >>> Well, the crash may happen when the kernel is booting, or too hard to reproduce,
> >>> in which case, bpftrace does not work.
> >>
> >>
> >> Do you enable kernel.panic_on_warn sysctl?
> >>
> >> If it's not enabled, the kernel won't crash, I think.
> > 
> > I'd like to clarify that the panic in our case is not triggered by the WARN itself.
> > Instead, the real crash is a use‑after‑free (UAF) that happens when one CPU is
> > executing a trampoline while another CPU is concurrently freeing it. This results
> > in an illegal instruction (or page fault) at the PC, which is fatal and will panic
> > the kernel regardless of panic_on_warn – because it's an Oops with Fatal exception
> > in interrupt.
> 
> 
> Why not fix the root cause instead?
> 
> If you want some help from upstream to fix the root cause, pls provide
> the crash dmesg and the reproducing demo.

It's already fixed due to some OOT drivers.

I think if we have this patch, it can speed up trouble-shooting.
