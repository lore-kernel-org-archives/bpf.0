Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65EC395DB4;
	Fri, 27 Feb 2026 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772187714; cv=none; b=IRVclwGRyphaQCy2cFJfrd8gU7K07otE9AEpNaSZlYxrlnlxnGG0VMJr6Spd42ooj5LPUu6eX5J7lXcm97isBm9DZjnHsmNwqgMR/ndrF9Om8tjGorv85kA1caBhsWTlGVsCjTjTZJXW965VoX3pQEGdhnKkVForM56J4YG//lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772187714; c=relaxed/simple;
	bh=UsgWvp1GgBfZzBi1bQ6C6S5njIGPpnPU/XFTEKEJPaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7a11BGBTcEBVNHIrOD4rDxHBpZda24iZovtJD9JMgOlCrokvgNIGR8S3wG8wpU0E+aYqUUgGVBzDeiPa7fSl2X4qVoBKsrUeQHLfg8B5jJcqRLx0ZAhzGRosdrWASgTeLTGc1cuUFx0s3P9kzKTIAUHsGHYA/LGyTon6r2k1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YyE8+P6T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WtXquy3y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YyE8+P6T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WtXquy3y"
Date: Fri, 27 Feb 2026 11:21:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772187711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsgWvp1GgBfZzBi1bQ6C6S5njIGPpnPU/XFTEKEJPaY=;
	b=YyE8+P6Tjo+S+BcZoSBuMWXn2hz+l+vNFOLWtJMvSjiNergSVEkkxT6tsvTRF1jxmsuaxa
	MdCs/2CkJLEtHHTeNKA+MsvS4v/OriaN1U7gH3UK4xijBauQLq5l9JAyD74VU7J/cdgsCJ
	6/JXhWBrb4CxHTVhyOUEjPs5ERHb+QOHaWDQI2g8Eq/59fuISBz8VMU5ohS6TliUs+ka3H
	V1OAslSzz4IydKu6CCHi5EMS+O6OauuOIc5pqPqEHPWXdb+KxgeCEeawrWxJ0M7mFs5i9e
	4/W6pin84La3pzPtBnpyV23qlLCBLHLjVaivMHbrA2aFo5dJWtsQsb7wCpdC7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772187711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsgWvp1GgBfZzBi1bQ6C6S5njIGPpnPU/XFTEKEJPaY=;
	b=WtXquy3yQNm+aAp6lM6ngwO+HwtWiMVlBJp+FBIgmEV74EhwIXAvXszUa8eVsFR+/5UOiF
	hCTY13bsVdtV8KAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuna.chen@linux.dev, jiayuna.chen@shopee.com,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v2 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
Message-ID: <20260227102149.10ZgLF-t@linutronix.de>
References: <20260227092254.272603-1-jiayuan.chen@linux.dev>
 <20260227092254.272603-2-jiayuan.chen@linux.dev>
 <20260227094558._Fna2iSe@linutronix.de>
 <4cc373b555ec3d6ff57037c569d12966a8b701db@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4cc373b555ec3d6ff57037c569d12966a8b701db@linux.dev>

On 2026-02-27 10:17:29 [+0000], Jiayuan Chen wrote:
> bond_mode can be changed after device creation via sysfs or netlink, a bond created
> in active-backup mode can later be switched to round-robin, which means the allocation
> must not be conditional on the mode at creation time.

Must the device be in down state or can this be also changed while the
device is up?

Sebastian
