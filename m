Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5655C613
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725770; cv=none; b=f5Ss4K4PjTwNlXSljUNmVIvtrHDmhOswcoGlfvo0lKFakIjdzK834/JtOR2x5ueDMwvP4HWQTN5FkrHs/Ec6IuzgKTshNcWzOoSUx/zlrx+HV8ck1HAb8EEqNvApMzZIICEvnQ96SQ7zBkL/a5yGH505nhLmeBLf24PprzAuFl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725770; c=relaxed/simple;
	bh=icCOzuK7ql5XqJQ4rmGl1XOjCiHd52LSHVgQWqAHy+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as463MD9VSCXhUZT2K0aAUtNDDh2940Wolt/f3jZ/c9ar7C+ktW/yrEJXoJZwYe1Agw4T2Hru8mLdVmOo7jUcMXs4aYWE502XER6hKTPS3YcVw2fglYDTpNKy4r261kw4vl1HOk4SRx9Hu/ANGN0r+cRaBkG32PCN/OpSHwgtUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmCbPcFO; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmCbPcFO"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c52bb5dd7so8048049d50.2
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 19:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778725768; x=1779330568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JwKoMRklFyzl2EMPCcvcyW8klUuKY19COHqcZRaHjYg=;
        b=WmCbPcFOFEFgorBAc3pvRkSZB7/8g4/lJ1poQyETsq62r1SRrC6OxwLaunYD6OhZSj
         AmNAHhOQWCzt4KQJHlyzGhLo6WfnnIXq530jXsH8+Szuv4ygwRMvZWRGXFa7U+ErQQYs
         yMB0BpnRx6GPWDq1RFFTkAY94mylQ8qFGRPChklNTOP5npQBYwaU/Trp7ujRSquHinm/
         wm9G+3Alc/o8ZtF+B23MHkVDlZ8ctVfIeku7MjDvPf1HGvPi74Fkd2fqf5zjyMCDV9MY
         TDkusrDVF6KVPy44VBBSlL8GwYzS5x3ZFmY82GDARm40FvLNBAJyCy/4Efmn+SHmaR9l
         7QKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778725768; x=1779330568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwKoMRklFyzl2EMPCcvcyW8klUuKY19COHqcZRaHjYg=;
        b=Ae8nCrCzbTmEjxkxIxF0eEHz1VUvoXrrKRMUDXEMxNRmKHsMPqUptXzCaSMSynXV3B
         +urLQssIa+gY+fcv4WwiP2DrY2XFNiuPBQTV57uiXtbyE+/isQfdAFf3EyXDuSk2mBBu
         IX4OEeJCc1so0VxZfIpp5pLT/VJMjIA8L70MbPp7bN6ucyPi4yRDClvQ9GkwpcsoDreR
         V+WbamlCSgpy1+lqyFNfeg2a29XQgUjllPxMjLGXFgJl/I+76dmn8a6CcPnTNI/nb0Vo
         vSXR8HNpb55Tx8fRtDvtcFfSdpTB+ijGqcqF6x1feVQqsgLMEmu6mrdxXpZH9oW1j3s+
         pLDQ==
X-Gm-Message-State: AOJu0Yz7g0VkNio2ua5ZyCW+k8eD66vsY4pJyx/aTMr/Ixr+ibRxrQCV
	tUABLEB10f+xJuUm8xbPiKqeCrFAtWMUqP2FHPLO+Y4DXyqXGuKGeIsF
X-Gm-Gg: Acq92OHHlPd2mSUUsFotr6cca8TXSmkYoVUwQe30YbxtpiUXWLET4wvCn+NR0NQHSjE
	lOPMQSnxbxJvi0RpbsWxhnWcmOTNllTVi3tW8tMkWa3Kg6Kv6QdPgmNVFVkUbok3boQiKO9b2rJ
	bEPuE44J7X/vwS3E4t8GIUyar0y5EGYK1KQB74hTmbw6Q7v8IDAYeU262D9WRZZwkUwMtY4Z8Qx
	F1PgDuRillh1kPoKRVP0PO7uMNlf0G1UGWnYmY1E/OHFRztVHKlgvdxrZ/wRsP/AStarqAnzRuA
	iu4Hhl0TEks14n0l3pClCRYATauyxIrdTjs5CUI5QXH/qsBYQ2eEEko/6cj88CfYLiw6xVlI1JW
	NqEPW+4X5Qkb8by6qawP7CxEaYEAxriF4UEUykiBqLQnILQnht6CNwihSVm7CuA+xemySra3fe0
	z+oprVuTmL2ZQsQEWU3NwPRHSIBal8JzsM3rTfg4W2PWK044aDHVsdtzRjhg==
X-Received: by 2002:a05:690e:158e:20b0:65c:6897:26e4 with SMTP id 956f58d0204a3-65df637f4b6mr4752806d50.56.1778725767695;
        Wed, 13 May 2026 19:29:27 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f806:20::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d89b130sm459097d50.5.2026.05.13.19.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 19:29:27 -0700 (PDT)
Date: Wed, 13 May 2026 19:29:25 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 8/8] selftests: drv-net: add netkit devmem
 tests
Message-ID: <agUzhWhoadL/TMiI@devvm29614.prn0.facebook.com>
References: <20260511-tcp-dm-netkit-v4-8-841b78b99d74@meta.com>
 <20260513190709.6693CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513190709.6693CC19425@smtp.kernel.org>

On Wed, May 13, 2026 at 07:07:07PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Uncaught `KsftSkipEx` exceptions in `main()` cause the test to fail instead of reporting as skipped.
> - [High] Global NIC configuration changes are leaked if the setup phase fails, breaking exception safety and corrupting the host NIC state.
> - [Medium] The commit message incorrectly claims that `nk_qlease.py` configures the NIC once in `main()` to avoid re-toggling settings.
> --
> 
> commit daf9f495f84bddbf201c5b6c6297e5e878d7ea77
> Author: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> selftests: drv-net: add netkit devmem tests
> 
> Add nk_devmem.py with four tests for TCP devmem through a netkit device.
> 
> > The NIC (HDS, RSS, queue lease) is configured once in main() before
> > ksft_run() and torn down in a finally block via cleanup_nic(), mirroring
> > the nk_qlease.py pattern.
> 
> Is this description accurate? Looking at nk_qlease.py, it does not configure
> NIC settings in main(). Instead, it configures and re-toggles settings like
> rings and RSS within individual test cases using defer() for cleanup.
> 
> Could the commit message be updated to reflect this accurately?
> 
> > diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
> > new file mode 100755
> > index 0000000000000..0e36a0fa96888
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
> > @@ -0,0 +1,55 @@
> [ ... ]
> > +def main() -> None:
> > +    """Configure the NIC once, then run the netkit devmem test cases."""
> > +    with NetDrvContEnv(__file__, rxqueues=2, primary_rx_redirect=True) as cfg:
> > +        setup_test(cfg,
> > +                   os.path.join(os.path.dirname(os.path.abspath(__file__)),
> > +                                "ncdevmem"))
> > +
> > +        require_devmem(cfg)
> > +        configure_nic(cfg)
> 
> If require_devmem() or configure_nic() raises KsftSkipEx because the
> environment lacks devmem support or sufficient NIC channels, will this cause
> the Python script to crash with an unhandled exception instead of cleanly
> skipping?
> 
> Because these functions are called outside the ksft_run() test runner loop,
> it appears KsftSkipEx won't be caught, resulting in a non-zero exit code
> instead of Kselftest's expected SKIP exit code (4).
> 
> Furthermore, if configure_nic() raises an exception halfway through its
> modifications (for example, if an ethtool command fails after initial ring
> modifications), will this leak global NIC configuration changes?
> 
> Since configure_nic() is called before the try...finally block, an exception
> here would cause the script to terminate immediately. This bypasses
> cleanup_nic() and leaves the host NIC permanently modified.
> 
> Should configure_nic() be moved inside the try block to ensure cleanup_nic()
> is always executed?
> 
> > +        try:
> > +            ksft_run([check_nk_rx, check_nk_tx, check_nk_tx_chunks,
> > +                      check_nk_rx_hds], args=(cfg,))
> > +        finally:
> > +            cleanup_nic(cfg)
> 

Will address all of this in next rev.

Best,
Bobby
