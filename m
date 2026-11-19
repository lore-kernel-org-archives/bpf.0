Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052707;
	b=I1P1cRmSo0DRpXbQ5TbpTcEChP0PI13tj5GD2Qj1fSTYU8Hvvfm7pIIm65BKJ0EBYrPF
	 6eITkrf8yzlzfInAqUUZo+4p1MXL26fkTInzmNFgnPNCSphbilzVVjeV56m8aX+Vg6weJ
	 DUhsnOKe4AwJmLPYKDixnmnk6hBixnmvA1lGeEEZI82jqtv3BTxEIxTajAcEMaaBAr9T8
	 Y0nEIwr2s566fFBmaqPsZLmT5+n83fSC0Wk6aTfk5trclDvW4yYwL2tAhMjdGS0pk59qv
	 Ain7tgRy9pW9n/1oNO1WlQ6UOtfQvxEoYXLOXLDafRyFP1qHdzhSMBX+O5F0ngPmloA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tsSPte2OHRCCjjgAaKFsJbmdFYgco+qIPW3i7HnbLCI=;
	b=nBnJcViaI4I1QBbUY3kdswHX0PEhCSsADtMp/BCkzNsQ3lJGT4gGpQ2PMdApXXqC98o+
	 vXJguic2dY2XARb5q/e61eukTkhqnkc9LB6iKRZWXz9t8KsZqWUAZJhY9efzHVZfI9QHd
	 ftoz/Pd2krhW0q3qcW6S0o90DbIYL88PHU71Bbl1/m8mbNSNW/c4/JMnOAB2xT5T2v3LL
	 xJvbmsShvbkVKMmtaJKdJ62+cMyT9yEZlCPkrh18g+WzFrij4QRO+G+Kw5xh6jd5cTlG5
	 svpkT+dN9N4zGIgw7lgHUJsvyz4fJ5gzu+FIZWB37e7tZaX0efLS9kPl76ZY2F/dEDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qdZ1g3gO;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0142606A31C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0142606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qdZ1g3gO
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8c5ebbc5150so1175857b3a.3
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795052706; x=1795657506; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tsSPte2OHRCCjjgAaKFsJbmdFYgco+qIPW3i7HnbLCI=;
        b=qdZ1g3gOfaDUZDiuRS7xw4tFFKrnA3YBKQQCN2kvMWCCNidSbyvuX3dga/Na+RiEi1
         G3aI17wq6bd28pFgIwqb3hrUJbNAQ6uErDiSHdjGiMi6REMAhEwgrj/Tk0hSykyM6Y+6
         qS8mWzci2IuobgL6A0cgzPr4JUf/2iTxccNeiSIOpydAZF9s4Ilp+bqYxWj254OIxchs
         UY2Y4K4OcA8oS8p7x5I8s0isXgnOx2GnmbsvZzH7kxQ1T0ymeFCsTM3pAC4a1jhibqyt
         +RLpqoZ5bSFCwFnbN0UyVcEkX7G35qTB4bJ29bxyqDJ5CLTfLqy5R4T70QmIr7s0BGb7
         DlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795052706; x=1795657506;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsSPte2OHRCCjjgAaKFsJbmdFYgco+qIPW3i7HnbLCI=;
        b=mYWquGrOPtyWbmAJq77Nj2BHpIrUa5CeLVEhhkAXpZmBfM+zdbTJ2GkbpWW5rv6R+8
         jLHvAxC4Wf5KnT6Z6LI6G9cFi64SpfU2qrUS4biLfI1tPF/bf9OVsxiLtAnqfi58A/Mh
         TV7uArigUMtfrVo0gs8p6Ebi49ZmAjc4A5XqG/05nFydaorIQJJ2g3/nYHdpQ0zr+8eF
         pzpEt4zv3/ybEjKEvKbwu3SkGC0eSOmgk767TPHxfLlUFS2Xa5wB91011sGF/4G1HZ6S
         2VCBtasib4L6PaudTjQX8iDThptUVG4peR1K2+SpCDN10pAhSGeLnmXbDLrUkb2GHCwr
         fMYA==
X-Forwarded-Encrypted: i=1; AL+hErG4yPaSxFTPZ4IXVGjVWmWKPUPVyeohw38HBhlQv8Xj/iD0MfTJK4EXMik/pPZNiY0k/Eg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9u57XA4eUH9mIjtDqxHC2/gGEhnrJGNU+Vc/26JYwt/Oqipt9r
	7ru4Sz0hPoE4QBZiiZDHvM2BvHoOonx+v05lACfbx+mUO74GfSPu2iN3Dnpi3g==
X-Gm-Gg: AYBFou3UJ2ytbRzvly6kUQpO3biLo1iDEXoGOPZUGR+XCwP0ry5JrEUtYpkTAtlcwzl
	0WOm6GT4FCLYk8udt0wwMLcRBIP4ebTZs0MDKgOBkEcUqle7OCAseDCoA0MXY02eJbCybADi5Nj
	GBzgFquSViKLIPWUiKM127ebG0Rf66ridUMT1yyjhMx6NcuKdxD5cK2KE4DSiYhpOPC9xiQTGEl
	4dw+VGsm7wZOEOephOMfuotuE/kXD/CmAfcIECtiL52XOEp4pmYrJwUtS0FLfUREk6ceIoqyHw8
	e0PwqlkDlHwuyV8p2loFAahsakJjWwTOVVtLlkKYnnznS9zUnwv+7BhSZrMNFuJ1AAKqQ0NUwtm
	7El+2sJ26q/Qz5S6b1ZRywdpHXzo9x73G2L2i8qVHWNSDuPZGu8ko8e9NYLwFCsT0wvxQDmJP+L
	rpyROcYHxk7rV5b/ZJlFSJv9dM7hx9Yx+SIfL+/MrHmJ9fjp8eaW89F2XaSRJTQc9ddZF9j/eQS
	iRI4C44N5+L/+Hgpji7eBaKJw6KuQuqLr58QFzWJUN8j88dhTR6uCCbMRYvVnu5Ppa2pMRo1DB7
	OR5uLymTCTx882ISZIIhe5zUWRXvA2L418uJl8/gjDARbNfDuti3X46I4P6YSfE9fBKAKb6ebSA
	z15bbW4qSfACHpoWr18QtDAoM42OBnF9oyQ==
X-Received: by 2002:a05:6a21:8203:b0:3de:456a:6e07 with SMTP id adf61e73a8af0-3fe8a519514mr5262258637.46.1795052706175;
        Wed, 18 Nov 2026 17:45:06 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cad86d9fsm1940114b3a.27.2026.11.18.17.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 17:45:05 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 01:45:05 +0000
Message-Id: <DMYT2SQGVA4C.2B8FUKCDOZZV3@gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: Remove BPF_MAX_TRAMP_LINKS
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-222288@kernel.org>
References: <20261119012909.3657417-1-alexei.starovoitov@gmail.com> <20261119012909.3657417-4-alexei.starovoitov@gmail.com> <sashiko-outbox-222288@kernel.org>
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

On Wed, Nov 18, 2026 at 05:39 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> This problem wasn't introduced by this patch, but can
> bpf_trampoline_add_prog() leave a dangling node on prog_list when
> fsession_exit() fails [1]?

> If a BPF_TRAMP_FSESSION program is attached with a link type other than
> BPF_LINK_TYPE_TRACING or BPF_LINK_TYPE_TRACING_MULTI, fsession_exit()
> returns NULL and bpf_trampoline_add_prog() returns -EINVAL without

Not a bug. There is no such link.
bpf_tracing_prog_attach() always inits BPF_LINK_TYPE_TRACING.
bpf_tracing_multi_attach() always inits BPF_LINK_TYPE_TRACING_MULTI.
The only other caller is the cgroup shim and its prog is BPF_LSM_MAC.
