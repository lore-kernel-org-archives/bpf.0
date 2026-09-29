Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947C3E4C7B
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697564; cv=none; b=O3IrPRuCAxbhV+jx19ZBZf8Vwu+snrnDhKOrCtF0d57dqfXh2nP3g397hEhsSdf41LsDqoHd9vnOlN+U6TLsxhAkKm4rdAFHa/KAkoCP9tJyS3nWVqG6ot9sk7BWwuZwOtbMEuApy6N+vj2vj4Pb4bU88ZtxM07N9Nb8LNXpbEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697564; c=relaxed/simple;
	bh=bwnWYK80nFfKr3iwUcfFe3FiEOIbobSQBQGXAMlfsws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqT9sRT1MpourSyu4ehf1U2xTca/ZuKg2jrGT06dSE3gJUUCJMAMT0WgOq+C7Nd3Io+opY5m0omX6ecGsynWBt8Zsvp81cNTm4kg18wBBqINJVxyyfjtjFu/RpJ/lslOM2aZMkUwRgg+aTzOy7VQULVlPYihLGOUjcpreloKip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nYBYdIxr; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nYBYdIxr"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so20297065e9.1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790697560; x=1791302360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3j1GsvDFG4oGBkWvUsNYUZ4jWPGCGdM9fhJMq32ExyQ=;
        b=nYBYdIxrDawbXfSaFe7w3OFYOIJlQrI7qz59yDzNoP/mpoddTQw11jDpz8fIdtFR8U
         Znr8Mf9igyXtWKyhX9oMfdAJDqgBGoGjvHJ6igkkprc58F97zd5CcoCsAlzLvRI3ylim
         m1hLqtLjxW1ZBq19GMmUHaYSFSOffW8bLP3K3qMkDov5FsMy3S3x/irgsjS1eOVIRxq+
         mTxoNRrvS3DP/l/GGQcl6eQRSamNLt1PpjT8Td4ULW0LxMOaLDCJ+NvWfW4h18DY5Ss0
         azhkGRaDxXPuY2FEehlaV3VB2aS/wbvlM5l1jOZ2enaChDZdM1x+J0h36wzrNkROlZrg
         6rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697560; x=1791302360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3j1GsvDFG4oGBkWvUsNYUZ4jWPGCGdM9fhJMq32ExyQ=;
        b=p461Cp8c88+fwEELwfCEg00eTQ6Ab+jBHSYs5lKNyPL1MFqfY4QbvHIk7qtQ8s1U/K
         G6WbiPLVyMA2lfdJFWyxqsHIBDJDgF1pjG6a5yi+6G8Fz3tvj31O8c96j2nViqo2b45J
         52f7YYpolBJk4RXpzkLbs1/M83ESgNnedWKR/RsOZ3kuzBpUqZ054C5aVfdn+cAgp2N9
         qB8NJcRqjLb/k2JUkPJSs/s/nQ3U1JsL7l0OPkBMYUvSHf5+QB4WnYb6pybQDimNMYS5
         WtGheTHRkFk2FkKl+bA73uR7aYLKZXk/qCcXWECOxMT7GPxI3iLqEHn2HtlhYdmwIDPH
         SYwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzC70Ez7pX2DODUzKUzALBzIX3jbk2NWJk+CHXigdzWsdv84BnpGnTlmnH6tF9sGFY1rWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++noma17bKeXczegIaSwMecltu1C6Bc38wJ4UmloEBt6mFjQibvd
	eQSvWff1EHxAWC1o43kjIaRhinpmLX5mT7CN6pQcNm/6kw5GuFDt6MhGwQD+9SV6ed0=
X-Gm-Gg: AYBFou0lTsTIqkeA+p8ZYmjKZltGjW+iEb8c6d9vM4U7weKqTKcptngTzkzwMiFK8ce
	mQP5EgJa5WPTIRKzviU50lxj1QEcRtDOaVTTr4z4ezyuCaffKWiB4PbB2e6bufpr8bUcOMOi35Z
	4SMrqziSiFd/AIv5atoJw9M//ALED8zGVrVNk0ID+4X9iGNpQGntrWBflnabzCJDeaFB0my//gD
	WjANQ/tP7timyPBoHR3jnJuuh269yx+Reg0xl9RK2J/lFGhnwbo9IZV/ZJLIkZfVplQNDx8k2V/
	rmDKRJWsYto0LloTwvoWYpcapNaiPn2xD7tW7wmyeLfrjydAAZ8Vlq8ztiaVFIM/G1yptElzAZY
	4iJHJXaS3jUOsjUvtqE57htahP7Jkx4D2dqvsTf6+jNMey8K+SRS19jjcXkS4uDNe2wzMBO/mHH
	D5VM7IUZBPOkOjPMcQ9mcLCwDA12UVQZTJZ9HAahAHi/MEoMCxR+jOa5lI4E+wFl2m4g==
X-Received: by 2002:a05:600c:46d4:b0:49f:ec98:f030 with SMTP id 5b1f17b1804b1-49ff06f839dmr227620145e9.33.1790697559827;
        Tue, 29 Sep 2026 08:59:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::5:5c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013c6f295sm7062155e9.0.2026.09.29.08.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:59:19 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:59:17 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 07/40] mm/vma: tidy up map kernel pages enum values
Message-ID: <arvgNTUgcO0nPh-V@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:16PM +0100, Lorenzo Stoakes (ARM) wrote:
> MMAP_MAP_KERNEL_PAGES is a mouthful, discard the MAP_ as that's implied by
> MMAP.
> 
> Also while we're here delete useless comments for mmap actions whose names
> clearly indicate what they are for.
> 
> Also update the userland VMA tests to reflect this change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
