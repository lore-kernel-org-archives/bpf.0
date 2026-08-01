Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767347260D;
	Sat,  1 Aug 2026 01:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785547923; cv=none; b=I9PKvFp+X4NbEH5M2a+5wmFrTfOJYw9cpQVUh1UtzJhTT9yQk2LzelLfhQSxFVYcIF7ObsflLhT2f/ZKqXFM+5YpqgDe92EZRFojGH5UmfAJX1txXzQrqkMdTwnxPTHUir4Aji2fRRfShJ4tus4HEW1xx2IqGUFnSPHEYCyxdPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785547923; c=relaxed/simple;
	bh=f8rY+JwJnopqDv8WVaYlI8s7YX4pYGbTOexdqm1Itek=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kmN/jbUshY5x0YTkt+civ9E78ZXVfS//+8ZnLVpevAkEv8KlEDI8IhAVfnaleJ6pCyGJsK1x3u4LbtTeRHsOQA4FpxWdVK5wGf+cTMgL1/DuDt0LEuD6lVNL2LKIrVg5G/JkPYumXWdiqWBAXf53GuoYpsv2lhtX4cUMFQsK4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS+Ls4Yd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS+Ls4Yd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2962C1F00AC4;
	Sat,  1 Aug 2026 01:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785547922;
	bh=FygqdHscPa55VsrCF2NTgQpIKjXqAw47+DFt/URfP8U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fS+Ls4Ydtdbjl89EYdZfZAV+PWtXkSgr/NDCIT7e5makeNJZLj4Q25AzWjWb+5oq6
	 GlIAUdZVPB40D3QcuZ5TccEOL4i4qO8sYM4EtITIxWh0gwywoakjYw2H0smvp5MsN8
	 P+X1kzVp3kAofNhjryO6tvsd60rX47HMxNXhzwrzzvBFPbfx2RWdocD+mcH1FUFM6F
	 8jp8KW7XEV5caTcXDXOPvr9Vd4sEynmISASvntBOkSFctuWrwzcyGpEMjCDh5pjkZu
	 n3Ac+rwVrOgq2u6vFsLRrnn/jJNAaViEdWpMItNqf6Nn/rO1lxdu3Izge/qeMeonZp
	 FFLdPjM8MlmXQ==
Content-Type: multipart/mixed; boundary="===============3185519639301511561=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5846008399c0c914c487eb22a9548201420ea5a14b3a4293735411e3a9726961@mail.kernel.org>
In-Reply-To: <20260728115036.2049536-1-tushar.vyavahare@intel.com>
References: <20260728115036.2049536-1-tushar.vyavahare@intel.com>
Subject: Re: [PATCH net-next v3] selftests/xsk: decouple xskxceiver and xdp apps from test_progs objects
From: bot+bpf-ci@kernel.org
To: tushar.vyavahare@intel.com,netdev@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,stfomichev@gmail.com,kernelxing@tencent.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,tirthendu.sarkar@intel.com,tushar.vyavahare@intel.com,andrii.nakryiko@gmail.com
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  1 Aug 2026 01:32:01 +0000 (UTC)

--===============3185519639301511561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 55d394438705..2749b26fd4cd 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -932,17 +932,26 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> -# Include find_bit.c to compile xskxceiver.
> -EXTRA_SRC := $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c prog_tests/test_xsk.h
> -$(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
> +# Keep xskxceiver independent from test_progs object dependencies.
> +$(OUTPUT)/xskxceiver: xskxceiver.c xsk.c network_helpers.c \
> +			   $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c \
> +			   xskxceiver.h xsk.h network_helpers.h \
> +			   prog_tests/test_xsk.h test_progs.h bpf_util.h \
> +			   $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> -$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xdp_hw_metadata.skel.h | $(OUTPUT)
> +$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c xsk.c network_helpers.c \
> +			   $(TOOLSDIR)/lib/find_bit.c xdp_metadata.h \
> +			   xsk.h network_helpers.h test_progs.h bpf_util.h \
> +			   $(OUTPUT)/xdp_hw_metadata.skel.h $(BPFOBJ) | $(OUTPUT)
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@

This isn't a bug, but does xdp_hw_metadata actually need
$(TOOLSDIR)/lib/find_bit.c? Nothing in xdp_hw_metadata.c, xsk.c or
network_helpers.c seems to pull in <linux/bitmap.h> or the find_*_bit
helpers, unlike prog_tests/test_xsk.c in the xskxceiver rule.

The xskxceiver rule genuinely needs find_bit.c because
prog_tests/test_xsk.c includes <linux/bitmap.h> and calls bitmap_full(),
bitmap_zero(), and __set_bit(). The pre-patch xdp_hw_metadata rule did not
list find_bit.c either. The only bit-field work in xdp_hw_metadata.c is
FIELD_GET on GENMASK constants, which doesn't require find_bit helpers.

>
> -$(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xdp_features.skel.h | $(OUTPUT)
> +$(OUTPUT)/xdp_features: xdp_features.c network_helpers.c xdp_features.h \
> +			   network_helpers.h \
> +			   test_progs.h bpf_util.h $(OUTPUT)/xdp_features.skel.h \
> +			   $(BPFOBJ) | $(OUTPUT)
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@

This isn't a bug, but could the xdp_features prerequisite list be packed
into two continuation lines to match the density of the xskxceiver and
xdp_hw_metadata rules just above? The current wrapping spreads the
prerequisites over four lines with one line carrying only network_helpers.h
and the final line carrying just $(BPFOBJ) | $(OUTPUT), while both rules
above group their prerequisites more densely at the same indentation.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30676354696
--===============3185519639301511561==--
