Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D52FFDE3
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761885; cv=none; b=dPcpxDAtlp+K7rXi9btL0NcpZVmCtAh1s53EeohGxUBT1VwsofSz4Hg0YxaLBud9Hy2NMbsDDr23Q7k0PODJtqoQkY6jdc7ou+b99GxDFBGOs5EhSy6Ax0Hy8pLg33111Ht8XqI2mlPBzyZlHoUuko6AyyaqQAP6jHGsF/hMRzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761885; c=relaxed/simple;
	bh=jGmyYO8lDM3g6XqoDmZ7Yg24Ep0RFdknOjdFXwLoGVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLsLDOscIiQiPTlM/8F4jhEVnjH3WB3nmNHHnVLMXI/Qmt7YRe4B1PJxFZF2ox/HHAF8nA/ARHcrfDjZ79YOeibIpy7v7G6GQ+Z4hCtW8LYALX26pjPQ5uE5x9CYHwdvu9l+TFJKaqjGFqoeyzXVlZvUou2zTgVIqMZQdrO5Y0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyZf3mdJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyZf3mdJ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b4915161fso1454594f8f.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773761883; x=1774366683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rkVMCqbxXXFOsW4pPazg+jqY5Bky8lF5MH2mHNgzXCQ=;
        b=CyZf3mdJpROe24wtqtERiLFZszXTRyh+RYjyI9AZiVi6XSRbaNGS1HTKJ+r11sipeu
         O8vgaM3DfkvxL5mJNBv+MTv4khA3afHhk/kmlAmCAhCzndPQrfS/zG4EQ0cBkPSI7QZB
         FYc3nGmri/X7FccKwBgxEDjvq373RPdZJ4Bgf+eyrfioe4wEneE9J/1gPDJIIWDJNNdz
         CxRGAl8kY7Dw9sP4iNuiVJuljGZopCZJKmkQtWVs2W0MhzVGhvubApOTssmbwdXFFqxM
         ckJKVz78NG9RERFICO0Y8nmQocuVWNb/UjAJhA+IwlGE9UI0UEzLeW0q3ZHcRi3+Qxt/
         52ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773761883; x=1774366683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkVMCqbxXXFOsW4pPazg+jqY5Bky8lF5MH2mHNgzXCQ=;
        b=StH8Ib2XvZnsOX3rsEUi/l0caD9AI7OcxEw1mdasbWcX5qnoId2rLNwIJeYGFesfZj
         IZprcC3hhY3SGTMT1wTbeGxNyU+fEKYiWQiVBbmJBPdFzRmGsCEUAawjhW22+wJLFTm/
         qjoD5/cpVAmQ2IpWAo/bvgA0EH3TWXTKvlZEUlvO70lvW3dsZa7EimpxZX8bngm+S5ds
         3lq0gMmAr7jmhPW7b4aeaxy+aOXeE4Bd8EE4pH7yEQ+p/wMreS2FmMB+uqfj4RGmT4hA
         lR4sW5MZz0Dz+9YfL9TN3ErpPds8Gby6EMeBiCMPxwG2/i2fXquGMGrTstvXQMV0B+6M
         SHGA==
X-Forwarded-Encrypted: i=1; AJvYcCUYtLPckwKxrcuklTrudVcddTRiY0SAuKeIvZfMVQqga/lCKV5IS21quwFx2qsduWZW2c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdfZA9L8wZxsrjCXI8Za25OVUXr+aESX3hYC2WAVOUpuyVMpsx
	GKtv6DuMB1TepUu93SwMGFcnTV+A6kRONEVleWDQdtOhUJitVI7MsLkW
X-Gm-Gg: ATEYQzzoMm9oRQ9ZjtHTv/0EoC0QBKs8o0fPbGQ7vdERMzglVCTS+3s3HOgJeWRh2jF
	CMgBuyHRMgTKxcaxhxo9OYUwApm3JleDJIP/ctuwrxdS8w9AtsBJ1E1m2fGPZMhYXB9aS8iMrw0
	c4DE2MNHuOlr31GKTwi0Dh58tsPcSqbGkEsTkNPWpHlpDvGOjpHpOiUKh6/U5WQPpTg6vVtQYum
	AMu+SSmw1aFiR8LbIYS5i2goxxL2tkKEOaIJ+IAX+f1rY7tW5tHJ17tN49ko71PZGTTmo+RNYSu
	4h9g/NkIdbs+JRhFPNHk7VM7JltxOh4jPOu7jVd0iufMIGVQlbp80tBwR/ZjLOOl+PEcdtt+o9r
	EsnC1XoI283SHMQCnx7EBUVXRL4UJp0ZOGSndFozWKl3Du7nsr1TwC9d4NuZa1gNKHsQhM6F1/8
	cm0V9GIlDxBhKUchfHyQSHvA+a3aqSRBvy8ojhuMEDciB9iF41W5UEUTq23iAeRPCRQxMnKUgOE
	6j6ZKB+aaq23zcDgaAcX8D8Wy5NgzPmw9HTleHeBI1bjK9cyCHEX2ncMDW0RDDc2JyMuCMbsdkC
	F5i/raT9hQ==
X-Received: by 2002:a05:6000:26c7:b0:43b:495a:a760 with SMTP id ffacd0b85a97d-43b495aa934mr7468451f8f.5.1773761882342;
        Tue, 17 Mar 2026 08:38:02 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001bd1b8260f3f46ac.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1bd1:b826:f3f:46ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892161sm276317f8f.21.2026.03.17.08.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:38:01 -0700 (PDT)
Date: Tue, 17 Mar 2026 16:37:59 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, kernel-team@fb.com, yonghong.song@linux.dev,
	emil@etsalapatis.com, arighi@nvidia.com
Subject: Re: [PATCH bpf v2 1/2] bpf: refine u32/s32 bounds when ranges cross
 min/max boundary
Message-ID: <abl1V9B56HSCKh3H@mail.gmail.com>
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
 <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>
 <aaocJ3gJr7019urU@Tunnel>
 <fd6a7d7fc0eee70b0b3053b1db34e9e986b2a067.camel@gmail.com>
 <aaoevIcblUpMyN3U@Tunnel>
 <bnw5mn5vwgezvhvzotrqcxfq5xixczjgzc2gj42565vnod5aai@rbwkdbuz5t3d>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bnw5mn5vwgezvhvzotrqcxfq5xixczjgzc2gj42565vnod5aai@rbwkdbuz5t3d>

On Thu, Mar 12, 2026 at 02:45:47PM +0800, Shung-Hsi Yu wrote:
> On Fri, Mar 06, 2026 at 01:24:28AM +0100, Paul Chaignon wrote:
> > On Thu, Mar 05, 2026 at 04:18:42PM -0800, Eduard Zingerman wrote:
> > > On Fri, 2026-03-06 at 01:13 +0100, Paul Chaignon wrote:
> > > > On Thu, Mar 05, 2026 at 11:48:22AM -0800, Eduard Zingerman wrote:
> > 
> > [...]
> > 
> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > > > index 0322f817d07be5d003c17dd7cedfa3aa4197678e..04938d0d431b38e086b50fe28b99e4ad2682742e 100644
> > > > > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > > > @@ -422,15 +422,69 @@ static bool is_valid_range(enum num_t t, struct range x)
> > 
> > [...]
> > 
> > > > Don't we usually put changes to this file in a separate commit, as for
> > > > test changes in general?
> > > 
> > > W/o this change the reg_bounds.c tests would fail.
> > > So far we tried to keep selftests passing for every commit,
> > > to help with any potential bisecting.
> 
> Similarly we have stable AUTOSEL tends to just pick up kernel/bpf/
> changes and not the selftests ones. e.g. both 76e954155b45 ("bpf:
> Introduce tnum_step to step through tnum's members") and efc11a667878
> ("bpf: Improve bounds when tnum has a single possible value") got picked
> for 6.18.17-rc1, but not 024cea2d647e "selftests/bpf: Avoid
> simplification of crafted bounds test".

I can send the selftest backports to the stable ml (unless you already
are on it?)

Do you know if there's anything I could have done differently to have
the selftests picked up? Or maybe something we could change in AUTOSEL?

> 
> > Ah, I didn't know that. Definitely makes sense for bisecting.
> > I probably broke it at least once :(
> > 
> > [...]
> > 
