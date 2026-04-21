Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC45E347C6
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776734249; cv=none; b=NzUN3Mf2OcHZjeUUHcN05uo0vNHxpu5H10kUeC7yQU9cX2BiZPiDwLOngOF8gDz50ks+UoXtqLUp18vLsNWRNuortWLFwR+7IwueVTe5ouxidqMYpHRjZktSbihuGo/BgVTiKkmWu5Purt2R2TQi8+tPRlSrupYwGTO9D7qRTLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776734249; c=relaxed/simple;
	bh=O1F7dJaFSzJR6VKySvNzV3K8karEFrgn5nwyd1CBkXI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JhkzPdWEtSUyTxXxzX1QOtyrU+v4KzM0XZSoZHNJc67WBqGd//rJk9775oXkzxE1qNfn59/K7d/I94JBNnwmvg+McaNmoBeGA+0VId2TakC8DpmX00tMKUhLZaiVAbQbqV8Pmr5sGqlVldI0bPuEeb47S/wBPFXOkPZI6HGv1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYTlR0P1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYTlR0P1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD73C19425;
	Tue, 21 Apr 2026 01:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776734249;
	bh=O1F7dJaFSzJR6VKySvNzV3K8karEFrgn5nwyd1CBkXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iYTlR0P19wqAmqym9pZGbnP/5JfaEz36Hf8h5bjK4eyafmvR6R7j/XcJVWwdXTqiV
	 00dyL1lo/Gqs0SOpvfUu/L41dpC5Jw9viMwENw5Rb5fzQzyjXMYheNQaBukRr4bEF4
	 PECUh6P4aZIdZXHbLdD9T21Bk+/7jsPCSfzIANJ+UPeWdMKMxZdIple5hhHo9VpL1H
	 3Jf4zagbgNO4pG0H9TnoZuSFTh5cPgNGJhAopoHBJI6cv6ByRSG2QdI/zia9xv8fKl
	 rInSxXizE5ADBDzn6BKl/N+lks7GELU3YIwgk9Bd4fLKN1gl16jKAdFMj8gi/+QRE5
	 RmSnBCJgdDznA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/10] crypto: pkcs7: add flag for validated trust on
 a signed info block
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420212653.438685-2-bboscaccy@linux.microsoft.com>
References: <20260420212653.438685-2-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 01:17:28 +0000
Message-Id: <20260421011729.4BD73C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] `verify_pkcs7_message_sig` is exported using `EXPORT_SYMBOL` but re=
quires a GPL-only structure, creating an inconsistent API boundary.
--

commit 6419b567f8141f60cbee1c62c6b8f2a8760edbda
Author: James Bottomley <James.Bottomley@HansenPartnership.com>

crypto: pkcs7: add flag for validated trust on a signed info block

This commit allows consumers to check if a PKCS#7 signed info block has
passed trust validation by adding a verified flag. It also exports
verify_pkcs7_message_sig so other modules can obtain a trusted PKCS#7
object.

> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index e0761436ec7f4..9bda49295bd02 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -380,6 +380,7 @@ int verify_pkcs7_message_sig(const void *data, size_t=
 len,
>  	pr_devel("<=3D=3D%s() =3D %d\n", __func__, ret);
>  	return ret;
>  }
> +EXPORT_SYMBOL(verify_pkcs7_message_sig);

Is this intended to be EXPORT_SYMBOL instead of EXPORT_SYMBOL_GPL?=20

The function requires a parsed struct pkcs7_message as an argument, but the
only function that parses and allocates this structure, pkcs7_parse_message=
(),
is exported as EXPORT_SYMBOL_GPL.=20

This seems to create an inconsistent API boundary where non-GPL modules are
permitted to use this function but cannot legitimately obtain the necessary
input object to do so. Other related APIs in the PKCS#7 and keyring
verification subsystems also use EXPORT_SYMBOL_GPL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420212653.4386=
85-1-bboscaccy@linux.microsoft.com?part=3D1
