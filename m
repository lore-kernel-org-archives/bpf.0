Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F040C36C0DC;
	Thu, 13 Aug 2026 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649317; cv=none; b=XrwxWWTxMEzh47/r6XqfqXHksDgahkFT3EXrIxtgS8P3bY7yKgsbonP4JKLly8/XbMR/7YgBPSRMWBL39jP9PcoqFp1cinJei5ZEO8zPlJzD5txcb9MSHxyQ8Ltcoq5FjckCxQn9C/WTEm6j/NeSVW82jMhJsDfsvkSm8ES4dRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649317; c=relaxed/simple;
	bh=+j5Q/Dn1mqRpzpfAYT8mZq0/qFlD2eTOaYLXnfEKu9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kJ9vOmuhduzUcDVTKyyw8xlC148acu2Ct3U6rKtFUDFTCaVRDlcqnk5/MOBmYWcA4wHPYQ5IMG0WsUJ5gfSRkmGlb5LTq7wwMdsU0CcaH9HOH8xTxiqZSOcheQUv5B79hDLVATbdMPTMV2xXHPiw4iq+qrPia+xhJX2rS8o6f1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY84mnxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY84mnxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084D71F000E9;
	Thu, 13 Aug 2026 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786649315;
	bh=I6ENnc6W9hgAQ/SR+yRswsxr0eqH+PVqviaYmokLnAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CY84mnxiIOZKScT7yCGAYdvqH7NVBfN/BalZsoBlOdWLU8DU+L9Mbaw7VpvGFoVoS
	 mDEfYxTIMGPA3q0fqdzcGrvvzmn3q8QHZQYPDzVO8CvErqGzB033KeE3j2yFAIETE0
	 oUK7T36KGnniNtKVW04lF+DiF8oQjAWkqCwVCb4CoT1BlvkW0dztny8NL7oF2fX173
	 Ag3GBn35fVFBuO7L4GyFCTxQhi5VNYhScGYEfAd+Iq7b4ClQf3MfjaqHF/CyTdUhCE
	 1ax3OaNxocji+2LkCzmhq9vNt5+ZfIvWerbiytyg0Z4n39uz0Z0Rue8UmVyxYpeQSD
	 vo/qnF3uAOcFQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next 2/7] arm64: insn: Add encoder for ADD/SUB
 (extended register)
In-Reply-To: <20260810191901.5729E1F000E9@smtp.kernel.org>
References: <20260810190922.3408757-1-puranjay@kernel.org>
 <20260810190922.3408757-3-puranjay@kernel.org>
 <20260810191901.5729E1F000E9@smtp.kernel.org>
Date: Thu, 13 Aug 2026 20:28:29 +0100
Message-ID: <m2h5kxzuoy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The encoder for ADD/SUB (extended register) fails to reject `UXTX` and `SXTX` extensions when generating a 32-bit variant, which results in an UNALLOCATED instruction.
> --
>
> --- Patch [2]: [PATCH bpf-next 2/7] arm64: insn: Add encoder for ADD/SUB (extended register) ---
> commit 286e3f9944297bcaa48fe3c90eb0bde9f1e85a33
> Author: Tejun Heo <tj@kernel.org>
>
> arm64: insn: Add encoder for ADD/SUB (extended register)
>
> This commit adds the aarch64_insn_gen_add_sub_extended_reg() function to the
> insn library to support encoding the extended-register form of ADD and SUB
> instructions. It is modeled on the shifted-register generator and uses the
> existing IMM_6 field for the option and imm3 fields.
>
>> diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
>> index 37ce75f7f1f08..e70ac02385153 100644
>> --- a/arch/arm64/lib/insn.c
>> +++ b/arch/arm64/lib/insn.c
>
> [ ... ]
>
>> +u32 aarch64_insn_gen_add_sub_extended_reg(enum aarch64_insn_register dst,
>> +					  enum aarch64_insn_register src,
>> +					  enum aarch64_insn_register reg,
>> +					  enum aarch64_insn_extend_type extend,
>> +					  int shift,
>> +					  enum aarch64_insn_variant variant,
>> +					  enum aarch64_insn_adsb_type type)
>> +{
>
> [ ... ]
>
>> +	switch (variant) {
>> +	case AARCH64_INSN_VARIANT_32BIT:
>> +		break;
>
> [Severity: Medium]
> Should this case validate that the extend parameter is not UXTX or SXTX?
>
> The ARM Architecture Reference Manual indicates that for 32-bit extended
> register operations (sf == 0), the option field values 011 (UXTX) and
> 111 (SXTX) are UNALLOCATED and lead to an UNDEFINED exception at execution
> time.
>

The manual does not indicate that, 011 UXTX and 111 SXTX are valid
values.
