Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AF334DB54
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367589; cv=none; b=UnoUi4S835fRpMb5lPELi+laRTfCnezQI87kNlsBUaRPsMT/hyqYwQDrS7z0zMco5Ji7dqdipsQ3Ee5TnkNSmH7NzLlLdG9lehGDY9CnRgmLOh3R7IVmrAMyEdbyntFldSJzqA6M+l6CnB8JAw+gPP1czcLrmJlWzjczX+sFhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367589; c=relaxed/simple;
	bh=EtacrmaPBkZpVVdwiz2utfHJg2pYuqpvObhVeG+QoOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I21eCmY8cdUYOG4HOFk013lHkgNQ0uCB1L7tnYzVhEL4iWvyAcs67RAJXsHGxvpkFOuAyJ6cnfwbb2crhF565HWBNUchUVe48bOvlScGFAfSsuJ+HlEKMqhTZrxyA9LM0SQZiMELqvmMZRGAS4w0Dg/gKs23z2n0ganZ6ghB+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAZJTQWE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAZJTQWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC0FC2BCAF;
	Thu, 16 Apr 2026 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776367589;
	bh=EtacrmaPBkZpVVdwiz2utfHJg2pYuqpvObhVeG+QoOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kAZJTQWEmWVjTRtWLIt1elnkO4kStXQh4UFjOyTKttqieyEqaHcC/ASfoWHASiD17
	 BscEg82b+Z3l0R/6iDOXPtnQ28ilV7lSacuKgfPO4NPe2Ec12cxQg+HXlXzRGYNfCi
	 Fk1UleCF9MP38sNaeu0bHTOkkzfJzMTTUv5rMyaxZ67iLsA2XAz08T957WvbHGokLp
	 lwdC65888G+//q27tYadryLcsBx3CzDshqLStkOZKqQYeyl0npSiG7zO8KCGEqnoy/
	 aJzB481Wa/ap1r4z6ZROHgYJnWgeBETCBlhBeAnYgQbgWljQ3/sMSnjCk3n92XmiKb
	 cC85VYTm7GgkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/10] crypto: pkcs7: add flag for validated trust on
 a signed info block
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416173500.176716-2-bboscaccy@linux.microsoft.com>
References: <20260416173500.176716-2-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 19:26:28 +0000
Message-Id: <20260416192628.DAC0FC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Stateful Trust Validation / Blacklist Trust Confusion (Authent=
ication Bypass)
- [Low] API Export Constraint Mismatch
--

commit 4ed8f1fbacef58172cae707b05aaa2b29ba6f7c1
Author: James Bottomley <James.Bottomley@HansenPartnership.com>

crypto: pkcs7: add flag for validated trust on a signed info block

This patch adds a flag to struct pkcs7_signed_info to indicate if a
signer has passed trust validation. It also exports
verify_pkcs7_message_sig() so modules can access the trusted object.

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

This isn't a bug, but should this be exported using EXPORT_SYMBOL_GPL to
match the rest of the PKCS#7 subsystem?

Other cryptographic verification and parsing functions like
verify_pkcs7_signature(), pkcs7_parse_message(), and pkcs7_verify()
are strictly exported as EXPORT_SYMBOL_GPL.

[ ... ]

> diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_key=
s/pkcs7_trust.c
> index 9a87c34ed1733..78ebfb6373b61 100644
> --- a/crypto/asymmetric_keys/pkcs7_trust.c
> +++ b/crypto/asymmetric_keys/pkcs7_trust.c
> @@ -127,6 +127,7 @@ static int pkcs7_validate_trust_one(struct pkcs7_mess=
age *pkcs7,
>  		for (p =3D sinfo->signer; p !=3D x509; p =3D p->signer)
>  			p->verified =3D true;
>  	}
> +	sinfo->verified =3D true;
>  	kleave(" =3D 0");
>  	return 0;
>  }

Is this verified flag persistent across multiple trust validation passes?

When verify_pkcs7_message_sig() checks a message against the blacklist keyr=
ing
first:

verify_pkcs7_message_sig()
  is_key_on_revocation_list()
    pkcs7_validate_trust(pkcs7, blacklist_keyring)
      pkcs7_validate_trust_one()
        sinfo->verified =3D true;

If a signature matches a blacklisted key, sinfo->verified is set to true.

If the validation later aborts because a different signature fails to verify
and returns -EKEYREJECTED, the blacklist check will abort and the caller
might interpret the result as not blacklisted.

When the same message is subsequently validated against the trusted keyring,
another valid signature could cause the overall trust check to succeed.

Could this allow a caller to mistakenly extract attributes from the first
signer block where verified is true, which in this scenario would be the
blacklisted signature?

Would it be better to clear the verified flags before validation, or keep
them scoped to the specific keyring being checked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416173500.1767=
16-1-bboscaccy@linux.microsoft.com?part=3D1
