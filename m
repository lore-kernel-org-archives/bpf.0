Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792633358;
	b=V2JAmcbTLI5f6h2CB39EWkmOamDWgQ4Nra+7i93XRMBI6GfjvYKbPSlwHGBs0ZK3QGC1
	 sTdwtj2qz9x3c17AE9bduIEzZdMDg6xQ8peCTF7theATwUSyUDOLUJrJ1OoQt5pc+Zpg4
	 RLlAQabUwYzwkvimtqk2egagnY4GHdrPrTxaZn0hazwG+x/eh8OeDCZp76mr2D1lN9oBC
	 Vkkc5FebHredZiON+qLePz5ovJTha3I3UmBOHxGO6pYv9Lht3gw6farOHpxJ+XS/5V2rQ
	 x2nddF8Cc2rfPPOHwnksgfNSdiRJJ9dHNBVsDDZ0I5cSWsg2oy84k66aIQFxIjanAIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792633358;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zVnTxsSOYn7loPLQqsq9dMi7CaUQseU4qAQdCgNr3j0=;
	b=YlSgKmu6CCGSgWktrPGnwk2DFTl4NyvnX2glBeUlHsxBzs+E0sqDAU96iAdbsCrKWRir
	 bcNzTsxwmmaXQGmof26fUaCz+e1MkbzUlFojnxsQBphs9nYvt9EaeyVn5gnSbTQoz4O2i
	 suVwyAr6+2fFd36J5SSPG9XnNUh8sY0w4euBdB+1s9m2dLBodOkYM3GC+FdwKFTFqFqtD
	 TbOZwRCkXV5EVbxaM1rnB56uBqbpbZ4oG7YlK4HLQERJobDgmSbaMaYNTkx5mXOrpPIpL
	 YolYN1X3EnVmMtHXsMwjUD77NfmjiFOj4cc855jxXxMK2T7uHsmC7jqeBqiuqJV5F3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSUE2eXC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F51606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSUE2eXC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4BB1F000C1;
	Thu, 22 Oct 2026 01:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792633357;
	bh=zVnTxsSOYn7loPLQqsq9dMi7CaUQseU4qAQdCgNr3j0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RSUE2eXCuBy9li+1wXri1CU+7caVsjMyXlrvTzRFe3fQtgfeC7l4Zf8szM9+mFJ6e
	 wo2wMlsBtJf1E5/W+cjJxsBlOijU8fJ846hTB1fbw0FzVvmEfQtxu3mECgjRdnrGox
	 D86x2/4PMjRcwMjEhYCMRbcPVF9Qjzy9hc+32sGOouWvBab6nwuBcJbzu4raVufKkG
	 6kV3cPyNBnQgJrEPrQjHjnEsvkJS+u7WxDP01UvdfI1QFq2bTgyQw4sdAGXlKT8Sjv
	 i71xFFVnPJf2DwtmuGxTm7hhPTrwFVVnCGGqiTQWE29JZMa+RXSYRRL1mGtNuEIwAw
	 r943wx2NQktXg==
Message-ID: <sashiko-outbox-180846@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] docs: changes.rst: set the pahole minimum back to 1.22
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mark Severson" <gr3yf0x87@skyn3tlab.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261022013432.2638010-1-gr3yf0x87@skyn3tlab.com>
References: <20261022013432.2638010-1-gr3yf0x87@skyn3tlab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 01:42:36 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] docs: it_IT/process/changes.rst retains obsolete pahole 1.26 paragr=
aph
--

commit d0caeb7c4f6cd56144ad9f71152e69d2bd461aa0
Author: Mark Severson <gr3yf0x87@skyn3tlab.com>

docs: changes.rst: set the pahole minimum back to 1.22

This commit lowers the minimum required pahole version in the requirements
table of Documentation/process/changes.rst and its Italian translation from
1.26 back to 1.22, following commit fd5425b67355 ("docs, resolve_btfids:
Document kfunc BTF annotation emission").

[ ... ]

> diff --git a/Documentation/translations/it_IT/process/changes.rst b/Docum=
entation/translations/it_IT/process/changes.rst
> index 0be1292a87fc8..5adeee24cc713 100644
> --- a/Documentation/translations/it_IT/process/changes.rst
> +++ b/Documentation/translations/it_IT/process/changes.rst
> @@ -57,7 +57,7 @@ mcelog                 0.6              mcelog --version
>  mkimage (opzionale)    2017.01          mkimage --version
>  nfs-utils              1.0.5            showmount --version
>  openssl & libcrypto    1.0.0            openssl version
> -pahole                 1.26             pahole --version
> +pahole                 1.22             pahole --version
>  pcmciautils            004              pccardctl -V
>  PPP                    2.4.0            pppd --version
>  procps                 3.2.0            ps --version

[Severity: Low]
Commit fd5425b67355 ("docs, resolve_btfids: Document kfunc BTF annotation
emission") removed the KF_IMPLICIT_ARGS paragraph from the English
Documentation/process/changes.rst, but left the corresponding translated
paragraph in the pahole section below the Requisiti minimi correnti table in
Documentation/translations/it_IT/process/changes.rst:

pahole
------
...
Dalla versione 7.0, le kfunc annotate con KF_IMPLICIT_ARGS richiedono pahole
v1.26 o successivo. Senza questa versione, tali kfunc avranno prototipi BTF
errati in vmlinux, causando il fallimento del caricamento dei programmi BPF=
 con
l'errore "func_proto incompatible with vmlinux". Molte kfunc in sched_ext s=
ono
interessate da questo problema.

With the Requisiti minimi correnti table updated back to 1.22 here, should
that paragraph in the pahole section of
Documentation/translations/it_IT/process/changes.rst also be removed so the
table and the text below it do not contradict each other?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022013432.2638=
010-1-gr3yf0x87@skyn3tlab.com?part=3D1
