Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2851EDE0;
	Mon, 21 Sep 2026 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029567; cv=none; b=SgXVN5gCIsHCqMqxVMXm/BVNV1tsxAEAzr3tpTZ9Iny2L6oSdHZk4qg9DEqwz17rNjBj5mvWXN5LOOAExmczepQ4s8rzdy37GxUwvjg7z49dDVHSRq9foetYziVCmoYhVvKam4TjtSsDoZJnRWWx0/bYzPXmMXDRig0r0lFYyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029567; c=relaxed/simple;
	bh=zdzaH1Wcw/dxTgxFvZLIcu8gve1bczPYShK+jv0Lxdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMPNOm//OFx9834nkjC7Mb419f9Hju3c7BaXhhnPCWqhLIYeZnteW+813y8S1mSNuTBApMhoHcIru0JtxP7GUKKmuqUJlfDD3GUgok58QrqdWw+N1/hMTfUHzqYe9cDlTT1Brt6TpgvQzJAnxt7DCXcHCrnfFWPaoRJBDCYYmHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2ZQupdx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2ZQupdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABBC1F000FF;
	Mon, 21 Sep 2026 22:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790029565;
	bh=yvL2cd8Bs/WbJX8qc98Y+wmI5B5WSR/JBxgiRWj5hSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q2ZQupdxS3qfV1UYag4k/CFYQ/KBfnmJH4WmJTrW5Kuh3eILp2SPm/L4XUR/Y2z+d
	 ML5wfcqRBnMQx/579vCkk3ePT1pUME82qApRPBF/D6ustq07ktAJIcyJk01IiXPQAw
	 k222YqYNX98IBrjN0t6HhfJXmk2GTCttC/GSS0o+9nhP2NK3SqDYWS1v6Ho9b/YU1+
	 88r5qlw0APBg8nCH+HM7lfBa8OigapIPxC7fLxvc69QwIT8UX/itk/TkBQ56Xa9BvJ
	 BRRZT0DvAk8vkRkAUfHQjwZa7UX2EWmFga4rugppCjIia7dXzf8heLw9O6ZlMK1ceM
	 MKLDuFjuVFkbw==
Date: Mon, 21 Sep 2026 15:26:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Irlanki Sandeep <irlanki.s@samsung.com>, edumazet@google.com,
 ncardwell@google.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 corbet@lwn.net, linux-kernel@vger.kernel.org, lorenzo@google.com,
 maze@google.com, sporeba@google.com, motomuman@google.com,
 srihari.k@samsung.com, g.pokhra@samsung.com, r.kumawat@samsung.com,
 raj.kumars@samsung.com, ts413.lee@samsung.com, ramyashree.s@samsung.com,
 daeil2.hwang@samsung.com
Subject: Re: [PATCH net-next v4] tcp: add TCP_ECN and TCP_ECN_OPTION socket
 options
Message-ID: <20260921152604.2df7daaf@kernel.org>
In-Reply-To: <20260916050255.1379192-1-irlanki.s@samsung.com>
References: <CGME20260916050144epcas5p3f7d6a44556baabd24027af8f4bce7893@epcas5p3.samsung.com>
	<20260916050255.1379192-1-irlanki.s@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 10:32:55 +0530 Irlanki Sandeep wrote:
> Currently, ECN and Accurate ECN (AccECN) configurations in the Linux
> kernel are controlled globally via the net.ipv4.tcp_ecn and
> net.ipv4.tcp_ecn_option sysctl variables. This global approach lacks the
> granularity required for modern multi-application runtimes.
> 
> In diverse network environments (such as mobile operating systems like
> Android), different applications route their traffic over distinct
> physical and virtual interfaces (cellular, Wi-Fi, VPNs, etc.). In the
> wild, certain legacy network paths or misconfigured middleboxes (such as
> routers, DPIs, or firewalls) are known to blackhole packets with ECN
> negotiation flags in the SYN, or silently drop packets containing AccECN
> option headers during active sessions.

My gut reaction is that we shouldn't be adding a setsockopt here.
This is a routing property, really, IIUC you're adding the setsockopt
because you want to use BPF, in which case isn't it better to add
a kfunc for this? Why go thru all the sockopt plumbing?

TCP maintainers, WDYT?
