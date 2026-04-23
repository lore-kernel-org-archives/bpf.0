Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C33AE703
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969473; cv=none; b=sBx4U799srFsEMCn6v1QYC/OqZxBiLZ6+15DhrsVMNiXfx8LIw1a1REjmLgLSZla5Smxb90txbMT30gZVpJcTiUeuez2MjSS7OXG9E8FPqDhUvxtGvazyNufDMwBGz98YRlemM3PCDcr7e7RkzmGBbH5/vcfM3WMOo/IahZN5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969473; c=relaxed/simple;
	bh=pLogyO6U0JGk6ooB0P4t5Xcvy9poB88Kwj5skPGIyDY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=O/65OsoYS+ctc+cbGZPI0r4F3OmgOV6+Y8KhiLgOX1JEwnHu78u6bTypzwqfLcF2eUshnANo0MR6NDlbh9loQdXuuDQ8Qd4St2+UavSJaSWwmGc/nzAxEUtXQpi1oHM71NxpGsgKQsKKgU92p4I/wGsJbCgQ+5O3OP2jdNJCPOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SYtzxNgy; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SYtzxNgy"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a0323830beso45577026d6.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776969467; x=1777574267; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WuJ9ZclNJckM0eVZPQcmoslgmsrrdaxBWMSl5N+wUo=;
        b=SYtzxNgyK/MxdkMZ22OgKhaWjtmTyZtOUJx+VQxElxF7Bl5ijvJoQ+2TCUPMO7NBYd
         xuZXeh48GikngxwIn9xWdxroCm/fWosOCCF8VDtYnsASvIgUzxP43a6KwYqOTPJQL1af
         N2eK3fr9AWE7WVjP1+c+b+pCCX5ySXQ3nYRV+6GullDe6D32z/fh0/wEmvjPj3YgsR84
         /v4D8u03VkmmFFGuUp4Xmk78E5rInidiz8uZxi6RXYFkudne/hQVxp6uveKgiQQ7ErdE
         fq8LF18vHseYhYZ5ilamchLPtMEyQE8DL2uG5ZBU+jJxm4202j4/xHzD3HowBiVXgSU+
         hQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776969467; x=1777574267;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WuJ9ZclNJckM0eVZPQcmoslgmsrrdaxBWMSl5N+wUo=;
        b=O1hVN/ZtGQcnqULV7/55gmcLQueCDWZL/9kJDg+mgb24zWWZbOPom6HhCca+TrwRK+
         eOfowggFVUV8geomqL/2CklCHQlmCjPGs3yy6F6YrpgsIDEk4abhyO0xT0OAPxBRS1+E
         NvtZaElOvG92A21X+4qES4cRs9Py93Yl6MkZuqZM4vv25dSz8I3vdRE62fOHwgFq/LLS
         pdx92DFgWFyIZUYgS1QHhZ/7E5LV8jK0/2vWEyJyAz9M/uaweSQYn7RuD9h8O53Yw57P
         00+XKaDOoa+8xGSHm8Y1xYXr2FwN99CeJqqEs+cVxPrUH/hBJbefYMreCKXJ5muyyulQ
         roFA==
X-Forwarded-Encrypted: i=1; AFNElJ/TwKfgyMut7ZfeFlYuY/VeQbu4c0sqgWFwlhIL4dUommGUS7F7AvuFUEH6xhGQbMoSdF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7CLRIzk4M2zC491o3UGCmrRXhXuBYC+IZZ4qmZ0xqogOuFR9H
	XDomcbzUnOD4v4zYPe35FYEpiuNp/gSNO+NqUVbDP/WiecL/pgNFJyaLOWXsaljY4Q==
X-Gm-Gg: AeBDievUFepDcyBJp53cEphr8ypPDxzZJK5MxxbIwMH9xR2VN4RQx/Y/f5n5QFvlg2V
	HkyjupaE/62DEjga8sfLH21NuIoTIUQ2RXzIi9TXubk+oHxYynNHD4ioUzuQr7Qsg1YyTu7hypm
	62/QD3EPFU+L4wFCGgVnw2fMcy+fWe25NuZ8zjtBSzPLpo1tmyITBCxVLcAlorsDa2S96qAjlxU
	3gZhROlwC+dv06Hjdg/5xdtK8oQgn3kQyB1zdKANT8S7VM17mwOOIAY0On7eWnqMdWg9KXGfcb4
	stYwrWETDXKoOFB0dC8eBieDd5fEFyI2UEquR+gQtQsx1S56gQNGRP8AZslh/Vx1nf/195Go5W4
	u0v/5BoL1MmtAaKwvhoeChi+0GW5utaEmslU65iB49Bz0OZI2uRgYUkFdssEmlzw9ioIQHvIpB+
	8J+Kkl4EZ8Nc2m9ncQ7+v/2NjZn5DIhyK4v1ffFHXg0hzIK9idBjNtQdBEv8IpUEN9lEh+lZBfg
	FNvnZQ=
X-Received: by 2002:a05:6214:3c8c:b0:8b1:f069:3fc6 with SMTP id 6a1803df08f44-8b1f06946f6mr255771196d6.40.1776969466835;
        Thu, 23 Apr 2026 11:37:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aea5ebcsm165040706d6.44.2026.04.23.11.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:37:45 -0700 (PDT)
Date: Thu, 23 Apr 2026 14:37:45 -0400
Message-ID: <7e924e82fbdfb5091f0436fe9ecac2b8@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260423_1403/pstg-lib:20260423_1403/pstg-pwork:20260423_1403
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "" , "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Andrew Morton" <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, "Fan Wu" <wufan@kernel.org>, "Ryan Foster" <foster.ryan.r@gmail.com>, "Randy Dunlap" <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v5 6/10] security: Hornet LSM
References: <20260420212653.438685-7-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260420212653.438685-7-bboscaccy@linux.microsoft.com>

On Apr 20, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> This adds the Hornet Linux Security Module which provides enhanced
> signature verification and data validation for eBPF programs. This
> allows users to continue to maintain an invariant that all code
> running inside of the kernel has actually been signed and verified, by
> the kernel.
> 
> This effort builds upon the currently excepted upstream solution. It
> further hardens it by providing deterministic, in-kernel checking of
> map hashes to solidify auditing along with preventing TOCTOU attacks
> against lskel map hashes.
> 
> Target map hashes are passed in via PKCS#7 signed attributes. Hornet
> determines the extent which the eBFP program is signed and defers to
> other LSMs for policy decisions.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> Nacked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> ---
>  Documentation/admin-guide/LSM/Hornet.rst | 321 +++++++++++++++++++++
>  Documentation/admin-guide/LSM/index.rst  |   1 +
>  MAINTAINERS                              |   9 +
>  include/linux/oid_registry.h             |   3 +
>  include/uapi/linux/lsm.h                 |   1 +
>  security/Kconfig                         |   3 +-
>  security/Makefile                        |   1 +
>  security/hornet/Kconfig                  |  11 +
>  security/hornet/Makefile                 |   7 +
>  security/hornet/hornet.asn1              |  13 +
>  security/hornet/hornet_lsm.c             | 346 +++++++++++++++++++++++
>  11 files changed, 715 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
>  create mode 100644 security/hornet/Kconfig
>  create mode 100644 security/hornet/Makefile
>  create mode 100644 security/hornet/hornet.asn1
>  create mode 100644 security/hornet/hornet_lsm.c

While I think this is looking pretty reasonable, I think Fan had some
feedback which merits a reply.  I also spotted some references to the
secondary keyring in the docs which need to be updated (below).

> diff --git a/Documentation/admin-guide/LSM/Hornet.rst b/Documentation/admin-guide/LSM/Hornet.rst
> new file mode 100644
> index 0000000000000..af5e9cd9d83a8
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/Hornet.rst
> @@ -0,0 +1,321 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======
> +Hornet
> +======
> +
> +Hornet is a Linux Security Module that provides extensible signature
> +verification for eBPF programs. This is selectable at build-time with
> +``CONFIG_SECURITY_HORNET``.
> +
> +Overview
> +========
> +
> +Hornet addresses concerns from users who require strict audit trails and
> +verification guarantees for eBPF programs, especially in
> +security-sensitive environments. Many production systems need assurance
> +that only authorized, unmodified eBPF programs are loaded into the
> +kernel. Hornet provides this assurance through cryptographic signature
> +verification.
> +
> +When an eBPF program is loaded via the ``bpf()`` syscall, Hornet
> +verifies a PKCS#7 signature attached to the program instructions. The
> +signature is checked against the kernel's secondary keyring using the

This version now supports using the keyring specified in the bpf_attr
union (presumably for maximum compatibility with KP's signature scheme),
which is good, but the docs need to be updated.

See below, but I would probably make a note that LSMs providing
enforcement of BPF signatures will likely want to check what keyring was
used to verify the signature, e.g. a trusted keyring vs a user supplied
keyring.

> +existing kernel cryptographic infrastructure. In addition to signing the
> +program bytecode, Hornet supports signing SHA-256 hashes of associated
> +BPF maps, enabling integrity verification of map contents at load time
> +and at runtime.
> +
> +After verification, Hornet classifies the program into one of the
> +following integrity states and passes the result to a downstream LSM hook
> +(``bpf_prog_load_post_integrity``), allowing other security modules to
> +make policy decisions based on the verification outcome:
> +
> +``LSM_INT_VERDICT_OK``
> +  The program signature and all map hashes verified successfully.
> +
> +``LSM_INT_VERDICT_UNSIGNED``
> +  No signature was provided with the program.
> +
> +``LSM_INT_VERDICT_PARTIALSIG``
> +  The program signature verified, but the signature did not contain
> +  hornet map hash data.
> +
> +``LSM_INT_VERDICT_UNKNOWNKEY``
> +  The signing certificate is not trusted in the secondary keyring,

Another secondary keyring mention.

> +``LSM_INT_VERDICT_FAULT``
> +  A system error occured during verification.
> +
> +``LSM_INT_VERDICT_UNEXPECTED``
> +  An unexpected map hash value was encountered.
> +
> +``LSM_INT_VERDICT_BADSIG``
> +  The signature or a map hash failed verification.
> +
> +Hornet itself does not enforce a policy on whether unsigned or partially
> +signed programs should be rejected. It delegates that decision to
> +downstream LSMs via the ``bpf_prog_load_post_integrity`` hook, making it
> +a composable building block in a larger security architecture.

This might be a good place to document that in addition to the verdicts
described above, LSMs providing enforcement should also consider the
keyring used for verification.

> +Known Limitations
> +=================
> +
> +- Hornet requires programs to use :doc:`light skeletons
> +  </bpf/libbpf/libbpf_naming_convention>` (lskels) for the signing
> +  workflow, as the tooling operates on lskel-generated headers.
> +
> +- A maximum of 64 maps per program can be tracked for hash
> +  verification.
> +
> +- Map hash verification requires the maps to be frozen before loading.
> +  Maps that are not frozen at load time will cause verification to fail
> +  when their hashes are included in the signature.
> +
> +- Hornet relies on the kernel's secondary keyring
> +  (``VERIFY_USE_SECONDARY_KEYRING``) for certificate trust. Keys must
> +  be provisioned into this keyring before programs can be verified.

... another spot.

> +- The only hashing algorithm available is SHA256 due to it be hardcoded
> +  in the bpf subsystem.

...

> +Signature Verification Flow
> +---------------------------
> +
> +The following describes what happens when a userspace program calls
> +``bpf(BPF_PROG_LOAD, ...)`` with a signature attached:
> +
> +1. The ``bpf_prog_load_integrity`` LSM hook is invoked.
> +
> +2. Hornet reads the signature from the userspace buffer specified by
> +   ``attr->signature`` (with length ``attr->signature_size``).
> +
> +3. The PKCS#7 signature is verified against the program instructions
> +   using ``verify_pkcs7_signature()`` with the kernel's secondary
> +   keyring.

I believe this is the last mention of the secondary keyring.

> +4. The PKCS#7 message is parsed and its trust chain is validated via
> +   ``validate_pkcs7_trust()``.
> +
> +5. Hornet extracts the authenticated attribute identified by
> +   ``OID_hornet_data`` (OID ``2.25.316487325684022475439036912669789383960``)
> +   from the PKCS#7 message. This attribute contains an ASN.1-encoded set
> +   of map index/hash pairs.
> +
> +6. For each map hash entry, Hornet retrieves the corresponding BPF map
> +   via its file descriptor, confirms it is frozen, computes its SHA-256
> +   hash, and compares it against the signed hash.
> +
> +7. The resulting integrity verdict is passed to the
> +   ``bpf_prog_load_post_integrity`` hook so that downstream LSMs can
> +   enforce policy.

--
paul-moore.com
