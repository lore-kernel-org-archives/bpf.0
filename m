Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F13806C4;
	Wed, 25 Feb 2026 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025289; cv=none; b=dozOwKIfe50cxkG8iMKvMsfGyMelJAwajYIEuRPQChoiFeYD0ISHi/PkOtPMouUqvHu4bYavRad00K0LtjvPZbNfW/rUuACL7wbb9LtDazaGQd7ySIQQ53dSB7za8Xl/5XRxf7qDPU9Qkz7tkltPrcSh5azd4jyt7vT8Do/sXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025289; c=relaxed/simple;
	bh=hP9OcveJ9COQQ+F3kAbwEAjlQzWy+VaJvjNWKsLLRU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YaFe1i7gxfbucmLHcLQDpHMwBAiBCgRPFTA5lV3m6eKFfw/pBtxQOgob6/nlqHcYKMytptfaducBinhGuQTUT7yMyFJJgdyoxRDRGw3yPhQMqrlcbc8NQnpv4dv8fhC09sOriEPjrSQrBdRBOPPQ2owzX1cYQmAP03a6wlqaaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pZU0oVDU; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pZU0oVDU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=s4fQYoVUZk3ueED
	niUcRygosHLpG2DqgLP/aqEwSeB8=; b=pZU0oVDUCCHXzRxdnNS+/kjyS48j/qB
	4PZImVuHccdSFJ9KNBkpYDz2AdujdalTXsk/Hl+9+ZGJP9TeFKDyUccWXhHCOQgS
	97mj1dwEYjYVfwFLXtSpFAbpVfS0+vhwS0zQDdQlWWopVmJnk+DsjRGohjkwjzs3
	E6N7PcVYgAuI=
Received: from yang-Virtual-Machine.mshome.net (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB3fcqC9Z5ptWhGTA--.29057S2;
	Wed, 25 Feb 2026 21:13:39 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: martin.lau@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	posk@google.com,
	yangfeng59949@163.com
Subject: Re: [PATCH v6 bpf-next 1/2] bpf: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
Date: Wed, 25 Feb 2026 20:12:16 +0800
Message-Id: <20260225121216.10112-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <49568dac-6c95-45e4-b869-d0f07563205a@linux.dev>
References: <49568dac-6c95-45e4-b869-d0f07563205a@linux.dev>
X-CM-TRANSID:PSgvCgB3fcqC9Z5ptWhGTA--.29057S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUe9NsDUUUU
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8QOfGGme9YMungAA3E
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 23 Feb 2026 13:39:51 -0800, Martin KaFai Lau wrote:

...
> Please check if the v5 discussion make sense (fix in test_run.c). It 
> should be something simpler than v5, e.g. always assign a dst to skb for 
> is_lwt case. I think always using net->ipv6.ip6_null_entry should work 
> but it needs to check ipv6 mod is loaded/enabled before using. Checking 
> 'ipv6_bpf_stub' should do. I don't think we need to complicate things 
> for v4 only kernel in test_run. I don't think testing skb->protocol 
> matters also from looking at bpf_lwt_push_ip_encap but please check.


Sure, I'll check, modify, and test it. Thanks.

