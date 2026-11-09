Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250002;
	b=k8Kfxw5tm6br7WWIVinP4nr27g2wtalKADed20RmaIcwESaYUbscOskOzO/KqEgnF/+i
	 Yhex/CCRPpt7w96uwuuie2bp96ZRSVHHz+Tt6/y4gxLSZuLOzWLbja1NLXsDL+UVCFSMC
	 KsWBI1blpOT7WtOt5KEhyhdxVcLZ/wNBQOThuMzwhOhW/ZNzlL/WMibdJ8hqjbrIzpHuU
	 n7mVf46UVgUsQpS3o7ZayCK2WyAwa/jRhrVVsn5N9DXQuFpB2vASTHlTC66xYHkOz5kix
	 3mEvBiRvrIZY5naIvZkrXTwcrDBYHtaKtjFNHX+o6quOWVaMnb7hYbsT29mgkDRPo7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250002;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5qOyi+WCk7vYnmBrilL3RcGTHF9Vog3qRXw0lpxhxtU=;
	b=N5F6Op9ou2vMaQlO8KZsC+5A1hqNWStVvugFrq/8PfMRDHeXIgM85tq7XvI4nrLovhHc
	 5MQqh/qcK1KkMd/AcNrYvKCJH4Mw9djo+AdZFwhih1x44QzkemfKSbcOMiSLO/oph6gCg
	 QLiXem+uk79KjSzqP2d+d6f3JI1EnoJh1XvEd26+3jDpnynkDPMLKTR6ueeawfmGsXQiR
	 wWMzclIaJUVS7GEUZs9rr5mcPcINAE0Z7VmxrsyJDRyZx5P0/2DJFwGBj3ZL6PI5mJtec
	 fbuOQTzpKbTYs3B51MWEkQxOJI2/S/3S27jyp8b4MWqogMZWTrtzCwCxqRR80tZS0RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIu7XUH5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380F606A33B
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIu7XUH5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A241F008A1;
	Mon,  9 Nov 2026 18:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794250001;
	bh=5qOyi+WCk7vYnmBrilL3RcGTHF9Vog3qRXw0lpxhxtU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aIu7XUH58RkKlm1os04C48Rivg2N6lEQ1bb+cH63Vhaf/tUOx4BBpMlnwWTZq3r6n
	 NF/G0jyf64UL6GXhZdhD7a7nfUY6kRCo1IqgALG37oaDHc0U0784ars6Rv6MYTzVtn
	 y6JFCRgtKIW0kDEIE8sVdxlbIdCFCiTTEo9qD2NhdgjQYTLb77W8Y+zhUb9EhTh2Pv
	 N88/qNbl1YNbDXOaekwBaWW9QE2qCIP52Wb0tiONzQ+AD3+bnRjmJN7M5rDoUyVshH
	 ZYhhZF3RaNDHv/XJsfNXDKaBBfZ6is9xMKfJirXNC5/rXsIFN4hh8363xihXSGolEw
	 xXH+Fq3ldjJNA==
Message-ID: <sashiko-outbox-205437@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] selftests/x86: add generic prctl shadow stack
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Roberts" <bill.roberts@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261109182758.252223-7-bill.roberts@arm.com>
References: <20261109182758.252223-1-bill.roberts@arm.com>
 <20261109182758.252223-7-bill.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 18:46:40 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/x86: duplicate test_shadow_stack entry in
  TARGETS_C_64BIT_ONLY
--

commit 52e57f66207c4b662bab2432ff697c9236a6020d
Author: Bill Roberts <bill.roberts@arm.com>

selftests/x86: add generic prctl shadow stack test

This commit refactors the x86 shadow stack selftest into a shared
implementation and adds a test_shadow_stack_prctl entry point to exercise
the generic prctl() shadow stack operations alongside arch_prctl().

> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftes=
ts/x86/Makefile
> index effbfe9b269f3..48c7459091614 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -20,7 +20,7 @@ TARGETS_C_32BIT_ONLY :=3D entry_from_vm86 test_syscall_=
vdso unwind_vdso \
>  			vdso_restorer
>  TARGETS_C_64BIT_ONLY :=3D fsgsbase sysret_rip syscall_numbering \
>  			corrupt_xstate_header amx lam test_shadow_stack avx apx \
> -			sigframe_fpu_portability
> +			sigframe_fpu_portability test_shadow_stack test_shadow_stack_prctl

[Severity: Low]
Does adding test_shadow_stack here duplicate the existing entry on the
previous line of TARGETS_C_64BIT_ONLY?  Because BINARIES_64 and TEST_PROGS
expand TARGETS_C_64BIT_ONLY without deduplication, make warns about duplica=
te
target recipes for test_shadow_stack_64 and kselftest runs the binary twice.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109182758.2522=
23-1-bill.roberts@arm.com?part=3D6
