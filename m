Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2B48DB46;
	Fri, 16 Oct 2026 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175010; cv=none; b=IaMDbl8ybZHi3Lq6CK5iL1BGSNqSFgwyLqUS46fcqQmeDSiN9PkD67FGw8FZcrIcZ0lmTLC8ckaHEBhAIKHG5uA7thcpy+rNq0N4CvgIyWl5hhB8m3tI92VkiL24H7dOAiiYOKuQ6aLb6pWt4sp3ysPVDBFAlnQPkbUlZai+7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175010; c=relaxed/simple;
	bh=cpADTyUxjfLwYZlDGpGUclPXOv2vNyaG5z0/hVoEv7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REPSZuLalT9Fxk3D9UIXAeUOgBvjAwmgaNdqejVbtRrp5gHEbebwnV8sh7FggNoHe4k24yBaF1HbGoyZmC5mllwHLP0sBN4Ds1JxEEAaTDxZicnOFa1fX4wn0uyfhU280GRYs0SpHr9eovffcvk6Xwj/L3pRJNaD7tKEQetIQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM/dxiqB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM/dxiqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDC51F000C4;
	Fri, 16 Oct 2026 18:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792175009;
	bh=Z5Fk0ND+iz/SVsU0Ty+69NRmLr4whiLdG71zFqf42dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bM/dxiqBbdNMm1c0E+zRdEk0mgsLF3KUlqziY5MXDNBbfsgAzoXOPFy4Nh20GDnaR
	 FWU8fjoGK33bVP3E+FmPYg+kd/U0d6CRltG/6Rz0UWc7MpfJEb0o1RFqY5ao2CyQr7
	 GCQ0gIZ9Y+DHbQbTlXZASi+txRcFrJFZRWxcquvAmLnlaPKVbt0VJY3Nzp/htyY4ht
	 Eq/u87ni7/YIIWeda7+pCzsbpJ7yoemWkQZElCqp7aSdfW2KdU6hafR7eiknhMBv/b
	 fMXTBuHUsoJhQDKzsFAWzOK2g13KrpTETQFPJHcSt9Ves9GxTYjvoxAlruP3k5BOtE
	 Shz19RXBSIuXQ==
Date: Fri, 16 Oct 2026 19:23:25 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	jiri@resnulli.us, bpf@vger.kernel.org, victor@mojatatu.com
Subject: Re: [PATCH net v2 3/3] selftests: net: exercise dev-bound cls_bpf on
 shared blocks
Message-ID: <20261016182325.GM363352@horms.kernel.org>
References: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
 <QDISC-PYC7.v2.20261010165947-4@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QDISC-PYC7.v2.20261010165947-4@mojatatu.com>

On Sat, Oct 10, 2026 at 05:02:50PM -0400, Jamal Hadi Salim wrote:
> The issue:
> bpf_offload.py only exercises per-device ingress qdiscs today, so neither
> the shared-block accept path nor the late-join replay is tested.
> 
> The Fix:
> Add a test for a device-bound SCHED_CLS program attached through a shared
> block.  It loads a dev-bound SCHED_CLS program for a netdevsim device and
> checks:
>   - the program attaches to a shared block owned by its device, and the
>     filter teardown leaves the device unloaded;
>   - a block that also holds an independently backed device rejects the
>     attach, because the offload path broadcasts the program to all
>     members;
>   - an independently backed device that joins a populated block is not
>     loaded by the bind/replay path, and the driver's extack is asserted;
>   - a second port of the same netdevsim device (same offload device) is
>     accepted together with the bound port.
> 
> The program is loaded from the existing sample_ret0.bpf.o with an explicit
> `type classifier` override, so no new sample object is needed.
> 
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Simon Horman <horms@kernel.org>

