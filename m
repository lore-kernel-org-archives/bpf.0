Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865112E1F11;
	Fri, 20 Mar 2026 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773992015; cv=none; b=f89zpMIl6Bks1UadhQKedrfmCgka89gQNTZ1TLBzsdb1Y/NGvHnkCj2dSWc57D/kaDAZIddmls+H1/MYMlmuo5L8JonZty88Y9ActgYmgklSonuwqO/XqH6KIhfXgnlWQavnErlQo+esE6iiM+4lpL/DkraBcQ7UnJ62aX4nzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773992015; c=relaxed/simple;
	bh=mDxASL2NYfrGfQNB0AwjVZ78bVAlLUC3X5AxC4QKgxY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sqyhL66/h98PMN8Vf8MnK2Kp4rYm8ouJtJtkueG/XmEx+3mgqrBg97lWz/skT0aNM/dALQ5BCKmqSIR4SX84xUKPMD6lbDefKtbWPEVbmFRsoK0pe7H53MY200//yd7Xd6Om/YTgHudVawg25oVl6lt1FyhWlCcITE0RjdT3Wx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i20Ts1sl; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i20Ts1sl"
Message-ID: <d1ea4d44-f380-4017-b90c-ecaec6e5a30f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773992011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewotJeu+IfO3qRPmLBMELeKgiPEzDCIRjYWohnQPmXs=;
	b=i20Ts1slsIChM5gklO7p6itL8svLCLzmi4nQyBODoE/0qpdfC30pWm8mAKA3mQ+9ejAwBV
	c36ydo+vuNorO7uJqL6OwG3helgZ1QrTQ/LY/m/TGkZL+KS8Wn9E/6kCvCtgEEt7KB+cUj
	BycYm4cKumdY+fJlRcKclG+/pVMawv0=
Date: Fri, 20 Mar 2026 15:33:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Paolo Abeni <pabeni@redhat.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com,
 syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
 Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev> <abAFRbJNinhN3O5v@penguin>
 <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
 <CANn89iLOyWzWW7w262Vsy2MOMVDXA0+UZGpEbsdLwe6e75mhKQ@mail.gmail.com>
 <abARG4sHFdUNqcRV@penguin> <8d746046-eed9-4d82-a064-c20b6a131bdc@redhat.com>
 <c72ba406-fc16-4ce0-b75f-3105b64caef6@linux.dev>
In-Reply-To: <c72ba406-fc16-4ce0-b75f-3105b64caef6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/12/26 7:02 PM, Jiayuan Chen wrote:
> f who calls it, preventing similar crashes from other potential code 
> paths.




Sorry for the noise.

Could we include both:
1. Add link status check in xdp
2. Adding a defensive null check in bond_rr_gen_slave_id()


This way, the bond layer is robust regardless of who calls it,
preventing similar crashes from other potential code paths.

