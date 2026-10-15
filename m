Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E737F51476C;
	Thu, 15 Oct 2026 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058760; cv=none; b=ECJadKFRYWllvAr8HXuymTe7pHIs5u3sD+OZSECZn0f80tE3JT5Dqk28/+vAb75Z3sUsTXCm7nCjEPVe+x9PIm7m+hpBGW7xaDlrBQ5fYqOR2k2DWTWPWZz9ag7WTKNxnLpuOoBjSa9SN5+SlCaPY7mznFxCoh0JzPSkzGrHGO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058760; c=relaxed/simple;
	bh=wZyFc6bHRExr5cX4q3SDxDc00taVDNpTWc3ZJmj6meM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TQHKJDbs+tRxRuPQ+lDn1ykb/AZI8cOGs+tXEhrYsEubMRKzlQ2aV5RI6LQ8T7UFw11d8PbWUictT63xBdBODcZyOxszMUdMSOvLebW9Fr9bmQmANMmZXst45mQHpvIwT81uaakyZs/3Dmj7XtJtouaC0r2xN+TmHc18Jize2Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6ucFqPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6ucFqPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82781F000C5;
	Thu, 15 Oct 2026 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792058759;
	bh=wZyFc6bHRExr5cX4q3SDxDc00taVDNpTWc3ZJmj6meM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=k6ucFqPwR3YM9WexutA5QPZBboTz6/6zl/HSWJLfYAwuasuP/g6fjOd6zznacy0Sv
	 igTPSmSUMq5RwMEa5HjeKL+iXbYz6PVCbHJ4JecvuduxyX71+mbcWm6fqyr/ZRSQ4W
	 awsH0sxYdjVwW6URB+5se+mNh5VHZIjivnC8n5a+kOhLZnlDDNcwJQ2M1VkfD91fdq
	 BjN5aRkKEFbDx/7RCylogXiU+lOxTXlqsmoe7r2Bpijdblk5lGMDGobWxb5QKZOWdH
	 GlysIiYJrMhgRBqDIHtTlx+xAYwGorb1L56iY1Fd0nav9bH8NWWBx127KLjYQgJHOS
	 t1SISLLn0rxLg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v3 net-next 12/15] selftests: xsk: pass non-test traffic
 to the stack in hardware mode
In-Reply-To: <20261014184539.774708-13-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-13-maciej.fijalkowski@intel.com>
Date: Thu, 15 Oct 2026 12:05:56 +0200
Message-ID: <87pkxb5ldn.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> The XDP programs of xskxceiver redirect every packet to the XSKMAP and
> drop what no socket takes. On a hardware link, this drops neighbour
> discovery, LLDP or SSH while a program is attached, and on the remote,
> whose socket shares queue 0 with RSS, such a packet reaches the socket
> and fails the case.
>
> In hardware mode, redirect only the UDP/IPv4 packets sent to the test

Again, IPv6 as well, please.
