Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.79.88.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636470;
	b=zePnik80oXEs9H1MuJXg03ZJRCwZRHcn19S14M4dJT/M9bp0hzpnlLndnePPzuyPR9BC
	 NxhdcpbbwE878NpD08NkuQlhG35vNrXhPSM5k3HH7ay679JTW6WnVaGCg7Vwb4E2ZSfO9
	 qXmuIr8tZswSvKddvy7paQ99lM1UJB9ZiONmgyvWlIW8WlmLPaXVXU8Xp8+Cz017ykvzo
	 OIuBo27zAW9rIVdurJ/p6KCGxrgWccxVEfJvaIsoAZd3mlI1+fWV0ZkI1aw3IqduNml0z
	 gMvtFWh4xFovsIBTR/5BAh8f+VkEQfdoZjYTeuUnDyFwpfmzTSWSJ91wB9FIY+GshCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636470;
	h=DMARC-Filter:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=pieKe5GiYH0kpv6II+hMND4COk8Q1hrQzu0fIwGjl0w=;
	b=dwYTY2ja9NCRZ6NowWBspy513o1weD9+LR0vTYu20FE10YfHh85HXbbuWHKc3+qEJxjq
	 kUIQ86W6Z1pNnkse+8QLgOtm0ZVf4g19HGquHOxiUaaST362lcyn8doa81a6KTMXuJZ0K
	 9VA1mtzPoBdn5hpwtj9cc1APEd/KDBRC4djXIdsqgxveCtoWPDTgJgfbzFSa4GqNPYAl/
	 EYZeD1CuA2m2l3Kpwaa1hGOrUyDiC9VbTQI5tDWFF1yQoxctNfbb+9jfWiYESz/4K6a7R
	 9N+fNknKs6pN9pFzgVmxrx8KLFm65uoKPc7g62smRDku88zjN60gkFW+ijw2k9OwyoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lwn.net;
	spf=pass smtp.mailfrom=lwn.net;
	dkim=pass header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=kczmzPau;
	arc=none smtp.remote-ip=45.79.88.28
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357A608440D;
	Mon,  2 Nov 2026 16:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8357A608440D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=kczmzPau
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A572240430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1793636469; bh=pieKe5GiYH0kpv6II+hMND4COk8Q1hrQzu0fIwGjl0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kczmzPauziu1bkmTcGHrvTNYebY2GJg/E/hfOUZGjBMhcHjCAIn/SZ9y8V4tiJawY
	 5ybJf68LIw7PPf1oP6xZNB1JVjIw/WpZExYWQJfzprvJsRJ54V1++jVFEoiJ5vUnMX
	 1AmvXNXekCbTNrrNr/myXOnc+BAFwy2pQitwJVfKS5SwKngqTBG+e9+VznbfoPGPAD
	 3hV8v7ZIZh5/oYRKrHklrgLuocl1VqoXhZb5s342SFkRnswNEQmobMqMn+4wm2EZGF
	 ncCHvWJCKAg9FOy0uZB8FYSemm6PtLwiO+6zeNeQphMTWuH3P2gmjEGDCoCpXa5anI
	 gVG0cihvsCZzQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A572240430;
	Mon,  2 Nov 2026 16:21:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mark Severson <gr3yf0x87@skyn3tlab.com>, Federico Vaga
 <federico.vaga@vaga.pv.it>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: changes.rst: set the pahole minimum back to 1.22
In-Reply-To: <20261022014811.2803450-1-gr3yf0x87@skyn3tlab.com>
References: <20261022013432.2638010-1-gr3yf0x87@skyn3tlab.com>
 <20261022014811.2803450-1-gr3yf0x87@skyn3tlab.com>
Date: Mon, 02 Nov 2026 09:21:08 -0700
Message-ID: <87pkwncih7.fsf@trenco.lwn.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Mark Severson <gr3yf0x87@skyn3tlab.com> writes:

> Commit fd5425b67355 ("docs, resolve_btfids: Document kfunc BTF
> annotation emission") removed the paragraph saying that kfuncs annotated
> with KF_IMPLICIT_ARGS need pahole v1.26, because resolve_btfids now
> emits the kfunc BTF annotations that pahole used to produce. That
> paragraph was the reason the requirements table lists pahole 1.26, and
> the table was left unchanged. The text below the table and
> lib/Kconfig.debug (DEBUG_INFO_BTF depends on PAHOLE_VERSION >= 122)
> both still say 1.22.
>
> Set the table back to 1.22, in the English document and in the Italian
> translation, which carries the same table, and remove the Italian
> translation's copy of the paragraph that the English document no longer
> has.
>
> Checked by building linux-next 20261021 with pahole v1.25 and
> CONFIG_DEBUG_INFO_BTF=y: in the vmlinux BTF,
> bpf_task_work_schedule_signal has four arguments and the bpf_kfunc decl
> tag, and bpf_task_work_schedule_signal_impl keeps the
> struct bpf_prog_aux * argument, as Documentation/bpf/kfuncs.rst
> describes for KF_IMPLICIT_ARGS.

I've applied this patch, but removed that last paragraph, which doesn't
really belong in the permanent changelog.

> Fixes: fd5425b67355 ("docs, resolve_btfids: Document kfunc BTF annotation emission")
> Assisted-by: Claude

This line is no longer required, so I took it out as well.

> Signed-off-by: Mark Severson <gr3yf0x87@skyn3tlab.com>

Thanks,

jon
