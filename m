Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ED52BDC2F
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000972; cv=none; b=j0zWPT2xzTSwwQ/tV7QFT42hes10w1JW1B8rddAQkf7jHndvwVn4rv10Q+EdeFgHQjrIHo6dp749K/09GvpOMQ8lbf3q2MNiJSrn2jgtSN0bZIDcwcucc6ZeR/U9YOUIioTQa39HJKIj4Wk49cyb2SDjWLay5Vi70AZzVDCdgIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000972; c=relaxed/simple;
	bh=b6F5Wol1rmdIAxCBSR/1o0L6e0zkmGyQDRLJXJLm1hU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=kW2U9p1goa1x4+JftAL/g9pOvvyqCujRQsPCbUVTAkMlgwc93A3jD0vjP8ipvCyDUSAh4hLSTokXm+K7wSgV1MRdlcsmz9DN6OURq0VzkcZhIbpBJ++GhyRijiklwxIGMe+DaQLYoFEV8NCYSBiDydwtDDLj9yMNBSP8a4vMAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gHZGo6lb; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gHZGo6lb"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506a747448dso48655131cf.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 16:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775000969; x=1775605769; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYbvdnLCMnXdYzHfn2HH+3PkoNRX+uMbCDYvoiIgkxg=;
        b=gHZGo6lbZiKz7X5sTNABvDHfU6h7W3mQT8CQgjlXVIWsi3bGaD6daAjUE4VaSLj6Bb
         huHSGF5LhKgtDgIP4SiCbHP/4EolqyPQuJDzAUgKjNWpuWbs+hMC+cr88mqkNqtLQhf6
         Kho3KK1vSTuJzfOEqLobBtGRE7TMEsmxJTEcFFmFLR57iNFPv6Lk4UHcTdkVpeoP6EJ/
         GHGG3X/2uAEiCGSWYdG+avjDURQql4o/AXzLLAk/DxO676KAvDUaNT0u5ZjkrkMDqqE/
         m7fn3F6i5pYqOjtfuEXO7eVy3/xgDEjv5RL6XZmjIx3rfKFOrYspKoXzXh386q47C3GK
         MNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775000969; x=1775605769;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYbvdnLCMnXdYzHfn2HH+3PkoNRX+uMbCDYvoiIgkxg=;
        b=Mm6u7xSGXjurJ/+9ThbxYiu0IexGb9fSNpm/iaGnIRIC4CKbLRBf/shQxAudaoC7/g
         hCmZ/ascMjdIKLg6+YQ8ng1mlQj+hVpHurjbfEYGCqw1PKd2R3xyk/NnwxQh8uPbjtul
         s3m75cdKt8JK/1cGiNDq/8XFt30D0sfjgHXkzmVMomrCNBobxdRANL9xNALdxPjW0sAc
         fMxNXS3esZAWfvg/iwfBnuIAFHbIQ5PObGaJRJ79tqno9f1p91cqPkWsVceTO8AK0Ga+
         uDofjQ+jacLclkwValtdEDKtEh9eIJJTvZYH+mHpuVk+2A0aT1EzFudWX66v6eNhotyv
         3USA==
X-Forwarded-Encrypted: i=1; AJvYcCX7At1KH3+dA7fmk17Za9Ax00jxFoVrn4DXcjglYUvnZ6Tg/Q6LMPErWlGdR0FFDdh1k0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpz8gJkCHgB1l9ZKc2Pd2i0owGrV9DiVNcCgL+jwTUhn5rsSQv
	klh6Xk3CFf4JbaB0z/cokKYVNov7IZC3JBoUsq0gMkxZI5vRj2CsAv5XblS6CSbWtw==
X-Gm-Gg: ATEYQzxSo5ctlrCwNdv4e3gA1HvXo4TJ+HuoG26QrPOIIVGMQbAD+Gc4O6X3PVKhKH9
	xdcFudcUbiXYeqPFYXvW5FcBgcFy2+VbAfhLpnteDDxJrwDnUi/2ZRMJxiiVqjhNpcfVzBXsla6
	NchMekgPVUyylC6jhOBb0Ljpa6bZdmaL52k/fKKTSyNKMeAXRVGwshONlGe2BcH/QM6FH8nmpvX
	MJqLNV4gWxg/hR+zt427BhkQz2t/edj9pcyzZ6QOsF7kno4ds4hsE3nfvbmLNVDnFrRZ9dsJ0Xl
	1YENiwmOSAcU+BUzeS4FtHR5W5idzineme/gwVO8IjXAV6eiy+0pZnUrSta/L34CbnAvKrKa7X2
	GND2F+emg07051DfDXdVvP8eAslfCW/6ouCKJuSWP02OwuftsmepjdDPRyzAglbQo8eGAxPR7/J
	DYq0La8yT4feTs7Te6pGY5k2vmzZfPDTwFRe1ic8oChK7I2xgnYNL9TGZRx436mMRFiWcK
X-Received: by 2002:ac8:5e10:0:b0:501:3ccd:cb3e with SMTP id d75a77b69052e-50d3bd6369emr22793691cf.66.1775000969032;
        Tue, 31 Mar 2026 16:49:29 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2c96a5asm97285841cf.10.2026.03.31.16.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:49:27 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:49:26 -0400
Message-ID: <667eb53aa7425c115055e354a6df2bdb@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260331_1732/pstg-lib:20260331_1626/pstg-pwork:20260331_1732
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, Fan Wu <wufan@kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 6/9] security: Hornet LSM
References: <20260326060655.2550595-7-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260326060655.2550595-7-bboscaccy@linux.microsoft.com>

On Mar 26, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
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
>  Documentation/admin-guide/LSM/Hornet.rst | 321 ++++++++++++++++++++++
>  Documentation/admin-guide/LSM/index.rst  |   1 +
>  MAINTAINERS                              |   9 +
>  include/linux/oid_registry.h             |   3 +
>  include/uapi/linux/lsm.h                 |   1 +
>  security/Kconfig                         |   3 +-
>  security/Makefile                        |   1 +
>  security/hornet/Kconfig                  |  11 +
>  security/hornet/Makefile                 |   7 +
>  security/hornet/hornet.asn1              |  13 +
>  security/hornet/hornet_lsm.c             | 333 +++++++++++++++++++++++
>  11 files changed, 702 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
>  create mode 100644 security/hornet/Kconfig
>  create mode 100644 security/hornet/Makefile
>  create mode 100644 security/hornet/hornet.asn1
>  create mode 100644 security/hornet/hornet_lsm.c

...

> +static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *attr,
> +				struct bpf_token *token, bool is_kernel,
> +				enum lsm_integrity_verdict *verdict)
> +{
> +	struct hornet_maps maps = {0};
> +	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
> +	struct pkcs7_message *msg;
> +	struct hornet_parse_context *ctx;
> +	void *sig;
> +	int err;
> +	const void *authattrs;
> +	size_t authattrs_len;
> +
> +	if (!attr->signature) {
> +		*verdict = LSM_INT_VERDICT_UNSIGNED;
> +		return 0;
> +	}
> +
> +	ctx = kzalloc(sizeof(struct hornet_parse_context), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	maps.fd_array = make_bpfptr(attr->fd_array, is_kernel);
> +	sig = kzalloc(attr->signature_size, GFP_KERNEL);
> +	if (!sig) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	err = copy_from_bpfptr(sig, usig, attr->signature_size);
> +	if (err != 0)
> +		goto cleanup_sig;
> +
> +	msg = pkcs7_parse_message(sig, attr->signature_size);
> +	if (IS_ERR(msg)) {
> +		err = LSM_INT_VERDICT_BADSIG;
> +		goto cleanup_sig;
> +	}
> +
> +	if (verify_pkcs7_message_sig(prog->insnsi, prog->len * sizeof(struct bpf_insn), msg,
> +				     VERIFY_USE_SECONDARY_KEYRING,
> +				     VERIFYING_BPF_SIGNATURE,
> +				     NULL, NULL)) {
> +		err = LSM_INT_VERDICT_UNKNOWNKEY;
> +		goto cleanup_msg;
> +	}

Given that kernel module signatures are verified with
VERIFY_USE_SECONDARY_KEYRING it's reasonable to do the same here in
Hornet.  I suspect most users concerned about code integrity, especially
code running in the kernel's context, will likely want to verify BPF
programs with the secondary keyring.

However, as we've seen from prior discussions, there is a desire among
some users to support arbitrary keyrings, and we should find a way to
support that in some configuration.

If we take a similar approach to bpf_verify_pkcs7_signature() and take
the keyring from attr->keyring_id, LSMs that provide enforcement via the
bpf_prog_load_post_integrity callback should be able to check the
keyring_id as part of their decision making and respond accordingly.  Do
we need to worry about a malicious userspace modifying attr at this
point?  I think the answer is "no", but I didn't chase it through the
code to be sure.

I suppose there might be a need for a yama-esque LSM which only provides
a bpf_prog_load_post_integrity callback and ensures a valid signature
verified against the VERIFY_USE_SECONDARY_KEYRING without the need for
any other policy or tunables, but let's see what the v4 revision looks
like first.  We can always add this later if needed, and it could live
within the Hornet dir (similar to how the integrity directory hosts
both the IMA and EVM LSMs).

> +	if (pkcs7_get_authattr(msg, OID_hornet_data,
> +			       &authattrs, &authattrs_len) == -ENODATA) {
> +		err = LSM_INT_VERDICT_PARTIALSIG;
> +		goto cleanup_msg;
> +	}
> +
> +	err = asn1_ber_decoder(&hornet_decoder, ctx, authattrs, authattrs_len);
> +	if (err < 0 || authattrs == NULL) {
> +		err = LSM_INT_VERDICT_BADSIG;
> +		goto cleanup_msg;
> +	}
> +
> +	err = hornet_verify_hashes(&maps, ctx, prog);
> +
> +cleanup_msg:
> +	pkcs7_free_message(msg);
> +cleanup_sig:
> +	kfree(sig);
> +out:
> +	kfree(ctx);
> +	return err;
> +}

--
paul-moore.com
