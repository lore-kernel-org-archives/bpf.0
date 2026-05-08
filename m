Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05B3C276E
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252502; cv=none; b=bAXfAtN0HyCLjHkd7mnLHyJmd6wTwPgreWNmhPF/+zxxqoMVPFVdZDtoZ/CLAOx4H7zA/owBhu6+GgIjF27AY1fIb3dEUvr9P1ZviV/UKvfUWsAEPaPp4dRzM8vsJmO+PaxWpC/pj3L8SI0qsUhOrsHUffoMn9i+yex+IQiyDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252502; c=relaxed/simple;
	bh=9/t/hUMZJzNMH4RVbdJbbZH15OTzwSdGifx4D0PefWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tt6ubiirHHVkefxoaPZ5Gxrjon1H4+xgknP4eofLr0paHBguGfox1//tj92uDrtK0ZFH4hHXDVz8b3qjS4FFmWWMoKiEFOP1ZYOwNOzcRtTbSYbUHavGKzoNqhPPlJW1aQSLHbZ6E1X5ch+JAGUamrP3EMAFZY+cyrn8ZJOafxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwrtcv0L; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwrtcv0L"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8367df48711so971805b3a.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 08:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252499; x=1778857299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6j5p5DIVFbvgg+WGkwfocupb7aWHhDsZHNXCf6IHkDw=;
        b=qwrtcv0LXEIx8rCCicFAexqLv2BoxrUwNPWaK/3Ygzu4ERWPqmO80wV/OX+t24E3mI
         qtMK1pto0nicCgilFhKxLuLw1lBHY5yOjAFnWENpVmcgiQSbLXMS4LS/vcy7+AIfPXxb
         l+J4sTLrnmODq2yqFRlbvWcw2EoEBUnsw2WcHR1fsHEC3juIHGTgy/6UTwqPGGFE48nE
         cX/87Ob+bCJM3QFUL3BqkDEtE2wteyCnAxIkUGkbf8CrEA9om5Pdd/wH3a7o0kTrjBJg
         R+rFDUzD+kQ0D4DdlQDF9f9YBPo2Q4OWk0Lm5qUHRorREp2tlgqNMqen8FcW4lAUF2bT
         kqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252499; x=1778857299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j5p5DIVFbvgg+WGkwfocupb7aWHhDsZHNXCf6IHkDw=;
        b=TlrkldehZ1J8QsUiCuiS/fTWPiFB9D3ZeIqvTWTC5MDsT6EFd4w3RjZ1tKlD4IHCfJ
         HPfLSZ1gA5/zjIs1srymtiY4F+w5iuG6dm3/XtXSOq1W4KchGVwj3siZ3z7+eJMGLLuL
         FRyJPkYHBwuLkqUcWpPZQlmA70m/sWmyGiotbaMo0UbFn0szKRx4oDgjZZktFyzqbRa7
         rggJcpC9r/UyT7m7hdNKzpIeVxR6YViIfTzSG/37hEYBu0Yp7kII3YFCLgYJgch8ggIR
         UnAcQrs5ZeVVVFodf1lgGTSo9c0e8cgQQaQn72E4LnCseVh3GGjWtzFlHRF+W1KyFLmd
         XytQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wsGFrTmWz14k8Z/DPphuSpOnuUjHVSQOw4sF7vZ69/VFGonmNi6g9Hg5Jw4sqOzg5jbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKTA5i4nQ+rS5HdkO7Uhc4algwRTvULdbO5XXhGoOIA/i/6rZU
	bUQT+kSTr3EKP7Y0b3A0dLgIHR2o/d7JcZ4dGX8tocpo75MAlGVUDNIj
X-Gm-Gg: Acq92OErCWde410ngI7PnjPQUQkXVIJ8C639OaL5c5qPhKrRzIoOg9pkWH3ccoX8/69
	Ch7kHW7brdkgEzE5caIVhtBdY/AOQOjHytt4/24NRme+cXWsAxsdPPLMtMmx8Z9aggu+YWEpn75
	0bSqAHbtkphCxtVC0mIbg8QAZS38kI1/1lgfpuH5v+A1pYSGiC2Lc4OiCIfByXc3K4PeJZV6mwC
	sEOuMj9NSOuOXrVWnj8EwTxUwdob9Z/NrTb7+E7yulaveMNM2IWOXHMI+Dhv2E9EDpppD1bXps7
	nLu8vCZgHJu6iwMpGSE5v/OBfM8QdWXzqhzrcCQhYET7qoksaZAnS4DQLzvR3nxll0suBRsxRQR
	tSENJVoSLELe4ZMbjTZX3ITO83jufbVd36BXiGxwv7o4fYF315hijPULls27+3HSW9tE8yJK+z+
	betxhK4dBsCjVSjIZ9
X-Received: by 2002:a05:6a00:39a5:b0:82c:2205:507d with SMTP id d2e1a72fcca58-83a5dd5bc34mr12224762b3a.36.1778252496977;
        Fri, 08 May 2026 08:01:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d35b3bsm11676274b3a.24.2026.05.08.08.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:01:36 -0700 (PDT)
Date: Fri, 8 May 2026 08:01:35 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 4/8] selftests: drv-net: ncdevmem: add -n
 flag to skip NIC configuration
Message-ID: <af36xtqCzGOGF2m-@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-4-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-4-52821445867c@meta.com>

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add a -n (skip_config) flag that causes ncdevmem to skip NIC
> configuration when operating as an RX server. When -n is passed,
> ncdevmem skips configuring header split, RSS, and flow steering, as well
> as their teardown on exit.
> 
> This allows ksft tests to pre-configure the NIC in the host namespace
> before launching ncdevmem in the guest namespace. This is needed for
> netkit devmem tests where the test harness namespace has direct access
> to the NIC and the ncdevmem namespace does not.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
