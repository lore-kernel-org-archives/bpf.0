Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77442E7BB6
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 02:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725713; cv=none; b=Uq09Uge7KPdjFJycbx8kKY8dHfdyyDf9/f6/6TkMeTYJYN3LTRr+iibFQu1ByNtvxD4fU9OS5E2ngz6hHq62jSpO5po11KNi19EIpUAt+vE5rk8yRCAl4f2SUYtHh6tgT8n2hc+1uq3XoIKJovH2JvG8Ac37iJkoY9QuukVPpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725713; c=relaxed/simple;
	bh=oaxgpoSbY65896j0Ju4jgMezNeznny82DVYv/Yi/2Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzBjNXkiXuF0f9nbjjitIwiXkkIlrK79tT81VYjGgxKlQziuNJ40qG74ELq2EE9wAV7H7ThrUpG4G3QCAL+2qsMOdES2uhk6eJYpoPEOZqoFludtAVLTO0Mr1sGimPvrn6GWVXqfuWmEzUJmWug+5wW5fFTwPRiIhkES2nmXqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjnl5cjV; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjnl5cjV"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651c366f7efso8365813d50.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 19:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778725710; x=1779330510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxfGgciuIl8ecIFy9+5zcD49dfpTzAB0PVcZJYXaajU=;
        b=fjnl5cjVVcoKnjVGGfmK/DNONvc0XgYuYhmB5ci7Ettt/CfRsbuO5BHrq6DMSp2Nsr
         DoLzh1Y4AmVVFPN2/r/nvLFmeRPbCGbUht6a/fRJLcZBVwrUdui9qrHQSK25QcrFlyzO
         qmFRzSKIf5H2QR2rW1he8KumP475SN3HL4ajJOmlivup1N4u4+RbQe30QQvgAz5Vfnod
         d+1SDq7ueGLmSkAwjHZGgEwk4ENZ5r0Sl4kp9HCh7MnmuOFilHnrUml+lsA6IE9bhJl0
         EhMxcJ3i9nCiDKnOTPNHqVIojk3we7X++fousEat7rt+2FaL9sPL5TRRMzM+y4IPcNe6
         aFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778725710; x=1779330510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxfGgciuIl8ecIFy9+5zcD49dfpTzAB0PVcZJYXaajU=;
        b=kcv5jGYcPD43CQxgu1Myg16G8Wr764Z31c9JUPzq1aGqG8FFCKZMpQUasFTHj8hzPk
         8WhReXwdhogDLg25CLcILoLu74OJAaCA52qaVKEEfRAdfM5Xo43AjVfyyx5/kXrPZvZm
         wGPinQ6lz8Ebn5YdnhS185f8R65E1ti1xcWHVxbuhnJVoFYOboNsL/zTFn+Y4g1w5WoW
         ka/cL9HigsmHAdzBh2UioZvdxTKfzVFNnJTPCij+qRGbTSxavluF8RKNXjoHxcuzzuuv
         Eospg92lncY+1/alCMmmsprcIEWfRQ1WgKrXUKpzdlLp7SfbdOjZe5oFauQa7tS76G69
         TVkw==
X-Forwarded-Encrypted: i=1; AFNElJ+dTSs0OCqj6rR48KpDbG704lz7MxCHUjwYYI3MphBegA0nb73NSTBwzv5dk3vvetnR5mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE98laQsUzxFBtoOAbXmrXbDvAX1VIV+WEuQC7r6Wi+RyfVrvR
	f9sTwmWwNCxwiag1umfYiC6Zh0XFScgAoIjRWkt9I4QKOaMMFshxxvTU
X-Gm-Gg: Acq92OE77yWJqvYO6/OomNqZtXbyd9SkWVcUiU8H0fQPcysFSle8pLeohwn7A7wwSBS
	6Lsyozn7uoTiSbDP8WhNtPwxkQ7Fe/Wd9ic6inahSJNgpq+HbMDtfkqYWg6cxPFo064jOFqqDBn
	Vxp4OB0Sbz3f9HpRmJP21MIyjd9P8pLQMcAUePWCWIO3dmOWs9C1Y97aaLSorn52M8h9VHIpB+O
	TYCJAaNgZao5TnNxyxqX21DIJ2o9bLwcCsCSB4xIVaF6oaMOnuvADwFMI7CUlNOwnR7wObzr8NR
	rzX7QbmPNiPsyLNwlBipjJDPSn9usoAGeyfqPs7rwtJTfxsRTR4gGcjvBvNbAFfyzqkmSAsJi+p
	3gfzDyt1Bl2lNROJ0AfkO0wmgx6tfoQmoRGMJLZw1nXXbrIhNOZSt2y3C5FcZnRilhA6hqG+PpU
	D6hUn/se1fLTSZc7nRA3Rq2m056MJ/vvdSrOcC+UqT4Z9rDG8=
X-Received: by 2002:a05:690e:118a:b0:658:a18:cdf0 with SMTP id 956f58d0204a3-65df625951amr6137491d50.29.1778725709828;
        Wed, 13 May 2026 19:28:29 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f806:29::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0aa51sm438759d50.12.2026.05.13.19.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 19:28:29 -0700 (PDT)
Date: Wed, 13 May 2026 19:28:23 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, sdf.kernel@gmail.com,
	mohsin.bashr@gmail.com, willemb@google.com, jiang.kun2@zte.com.cn,
	xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 6/8] selftests: drv-net: refactor devmem
 command builders into lib module
Message-ID: <agUzR3O35Rx4RHnu@devvm29614.prn0.facebook.com>
References: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
 <20260511-tcp-dm-netkit-v4-6-841b78b99d74@meta.com>
 <20260513192133.60a82598@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513192133.60a82598@kernel.org>

On Wed, May 13, 2026 at 07:21:33PM -0700, Jakub Kicinski wrote:
> On Mon, 11 May 2026 18:18:00 -0700 Bobby Eshleman wrote:
> >  tools/testing/selftests/drivers/net/hw/devmem.py   |  77 ++------
> >  .../selftests/drivers/net/hw/lib/py/devmem.py      | 218 +++++++++++++++++++++
> 
> If the reuse is in the same dir I think you can create
> 
> tools/testing/selftests/drivers/net/hw/devmem_lib.py
> 
> and import:
> 
> from devmem_lib import bla
> 
> I _think_ that should "just work" ?
> 
> The lib/ is meant for things shared between targets.

I will give that a try.

> 
> Also I think you missed adding the new file to Makefiles ?
> It needs to be under TEST_FILES for building tarballs

Ah okay, I wasn't sure if the already existing `TEST_INCLUDES :=
$(wildcard lib/py/*.py ../lib/py/*.py)` was sufficient or not. Will use
TEST_FILES with the devmem_lib approach above next rev.

Thanks,
Bobby
