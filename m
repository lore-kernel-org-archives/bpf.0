Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2240DFD9
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 00:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773878468; cv=none; b=kRTZ7fx32unimGLqd2Q85N9jjyBcUyDAvoLRld7lUjbrLAYS/DSxmRosv1TntPYdChZANzl2BiawMsaVEv6bW9GI57JtZMiGLXuTKz7hi2nNk/nmONm9uXyRgovhr+fJuVCioKrR5HD5NKhVOILZzEhoOaOUBFOthNVqD554pEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773878468; c=relaxed/simple;
	bh=I+jFUSuAOEMjj3fbB1HA6PoT09aFr0BDiTdeapWAWjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntrHxUwb1+1zPC09wHctJy0DWSB4sOS6zb/1NBicFZlPBri81hPFnTOC/ifUPhRYMK4uDvDJND78nakfugWfSMVdikTHfdVhzfRhzxwfKwcKt6fPMBNOxFaP3bUnZ83ueGnEcSTJtfUHdlxZPigUlffvRqn9w7i99CmbAdv14fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHg2bRed; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHg2bRed"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64d5a7926cfso573047d50.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 17:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773878466; x=1774483266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ILbygoPcRuCSs+r8YFh5aPC+4K7iokiRrlp8YwLSZI=;
        b=iHg2bRed8IOLUzRSEfxP8wWEwl5EK012794uh2tD7rXbk+nFRdNpdoTkyZNeOd/y0v
         ppjF4p9DauAEMn0ap4K+X3hHcHK0IHZGXI3Qz24aleAWSzjroqyJHOOFryZIv6v1McVT
         BNbdSmwX0DKZISvDKXiYyaPdFVcajgVxRdLQ/v3Bg3c0n/pRp9C2v++WmTURksSj/81H
         Ns8NtMB/4OEktleS8I5mBeWOYMgLFGpIigbUM7MfNGGKKfheOl9tN02/hJpwINhTaVaG
         0LOhEZGx0hropxZ4hzFZw0HWF4D7mmM4kX0KcaTJt2lxEkAD1VDwmaL1nVUHWSRi3vbP
         TLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773878466; x=1774483266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ILbygoPcRuCSs+r8YFh5aPC+4K7iokiRrlp8YwLSZI=;
        b=n6TFSHe1FxED3Z5Rxe9YfzzpwImJ971wzmtwnVEjyg3R0yUjnBixyMj5V4nPxJpBP5
         kmzhPUbZSEhlvik9xembbRKj5qIY2CeXSttpwEPtY6SFd0KUsBSa2Gl6itmG8WTv49jq
         IfmQzCAs7ctXzTrKRe8A5Xx+bFt7bf0AXPGf+Cn0U92yTACdaqFi9aMUo0V2l5Xeg+Xv
         ykcRTF3z8gCByqDIYWdRftX7PSqgpyZsusPmdm/mA37ppTaSQVMZjsDM0TEJ18crFu4g
         SR79fY2w+dwx26H+tMPc1IXd8fQ0txcQb0+xj2T+wBnHcFDLskIQBBeqAJDjCL9HY0Wb
         uzRA==
X-Forwarded-Encrypted: i=1; AJvYcCXtmklEt8nc01+VXQe3Yii/ksD06zgw6dCL7eOwPxFo7dzxljJTxMkYkt1zq22SskJDAE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP0BnQ5p/jQNcKtOtpBqo9itb1/20yQCKbR7cOO8CdE2HZtUjJ
	13sxJrcwS66Dmh2oYh3/8V1sfAhWOuwhJ1EjeAHjnFVEoOv/MlIDrmA3
X-Gm-Gg: ATEYQzzAPDGtsuDuzQXwdX+jfsiSmL/qoJfMw3C+GvXQvQOUab75UOR6cNetjy/UNbV
	JUWRs7fTUpr+hgNTtOaNU74RH/Suss+GxB/ESkfaExpGHDSUTM2T536bDCHzeAvvznHc1vtKP7L
	p2lSiO/cVfDTnbgT9SyEN0g2iEl8Jx0Do+LqMLBnKGdUCldNSEG/gv1LzgELSbZ5rqRZzxNqybQ
	8siYWBOwSdEjZ0mmQIXh3SjvJtlHpRHrBKpMRBKqz4LYD/Zy/RKN02SPmwypNSKbc44Y5wEqeB4
	XnSv+WmrDCprWSJSD+8l7tUxS+KYFMzGwI3doVc1L7fqUhLlBHg9xvFSwq2O/+5WZYFWpDnBhIl
	DNgz8VIX+1a0Aoko5QHrp7iGO/Mmset6lizrJqYGAsJHVKFXKgRq5Ug6H18vePs+/7lOGetYXEB
	ngt9x/X8MXhu40n/S4gsuLzZyAq75byb6Enl9lXeXxxrEyQA==
X-Received: by 2002:a05:690e:1b66:b0:64a:ec39:dd64 with SMTP id 956f58d0204a3-64e915cbab7mr4173241d50.43.1773878466260;
        Wed, 18 Mar 2026 17:01:06 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91bbecf8sm2512651d50.11.2026.03.18.17.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 17:01:05 -0700 (PDT)
Date: Wed, 18 Mar 2026 17:01:04 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 5/6] selftests: drv-net: add netkit devmem RX
 test
Message-ID: <abs8wCq9PBpuDc5w@devvm11784.nha0.facebook.com>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
 <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-5-b53c8cd72b23@meta.com>
 <abns9COj7WagFtZ8@mini-arch>
 <abn3rJGXXyDYSNzA@devvm11784.nha0.facebook.com>
 <abq97UD7CHR7bdod@mini-arch>
 <abrRDNi79H9ircl1@devvm11784.nha0.facebook.com>
 <20260318161010.2d7338b5@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318161010.2d7338b5@kernel.org>

On Wed, Mar 18, 2026 at 04:10:10PM -0700, Jakub Kicinski wrote:
> On Wed, 18 Mar 2026 09:21:32 -0700 Bobby Eshleman wrote:
> > > > IIUC, we could have main() do something like:
> > > > 
> > > > for env [NetDrvContEnv, NetDrvEpEnv]:
> > > >     with env as cfg:
> > > >         [...]
> > > >         ksft_run(tests, args=(cfg,))
> > > > 
> > > > 
> > > > And then the tests could call helpers that check cfg.netns to use the
> > > > nk_{guest,host}_ip6 addresses when true, otherwise use the regular
> > > > addresses?
> > > > 
> > > > It should be doable if I'm following your drift.  
> > > 
> > > Yeah, yeah, this plus some small changes here and there (to pass your
> > > new -n in the netns mode for example).  
> > 
> > Sounds good, I'll give it a look.
> 
> I haven't actually looked but double check ksft_run can actually 
> be called multiple times. We may have some global state :S

The result is global, but accumulates correctly.

But the tap output doubles:

TAP version 13
1..2
ok 1 devmem.check_nk_rx
ok 2 devmem.check_nk_tx
# Totals: pass:2 ...
TAP version 13
1..4
ok 1 devmem.check_rx
ok 2 devmem.check_tx
ok 3 devmem.check_tx_chunks
ok 4 devmem.check_rx_hds
# Totals: pass:4 ...

Not sure what outside parsing expects yet...
