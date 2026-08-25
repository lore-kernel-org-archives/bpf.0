Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BFC485CD8;
	Tue, 25 Aug 2026 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672381; cv=none; b=cqH/HG5A2p5EUtgk5Jhqh4mTBTxObK3gHA2VP59NqjYeHTGvQqdqm/e5JcvehT0cMR1p5z4uCYvi2jpX+W+NdbqniDU/9lFvQxfvnbrLFyO60PY7/YZRyiuWM5bnNyNmE7afEGT1lBXHG7bs0p5O8Jk3lolwO06RQZ4UtO7U5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672381; c=relaxed/simple;
	bh=Vo7J22ztzwdMfPq0r809nLkdj6m9Y2a2aOLwDLtS/z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsTvJpr7O8pJUT0sEw2RZx8hrBKFtbmrolLj5hErHQBx4z0xLkAFjAkCp8pMbCywdEq/yHjY8L78uZydUux3+ktoBQfeuOXHhZl9oFSsN+H48ry6IkA7djKkcKU1KcO1lg5Y0llAukDMVjtDXcrN5XAo4aJaQ+20N0oAjdC18CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=liZvsEz0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="liZvsEz0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MWFZujQY9NLwVf8MsxDF/LwNaa+OH8XXZy8xUNWfxDY=; b=liZvsEz0m9hi16V+K4jEh2Iai6
	2RBXdlM61gXObmpq95Q2OWXJqX0m++AqC3C1avdhxYqzEcrcd9R7+HmoXDgiwVauH43+UWDSTjANJ
	lts+TIQJMqPsV3Tj7mY+gUqLxTYG5dV+vL5m72OwaWn8PR2jm+FLSjlztWglfLQH1TvziIRCbx3Cj
	1GRLOkQWux/oV++qTXb8BwJMxZcpIU4wWAKvguvjt+64sQNxcy8g3vjBzu8scaAz+YKOMi7H1lkHn
	V7Sze0rgGYO/RU0JKlm3nwG14194nzgX0B82GU9kbI80vqASgy8QMxbbxjB7dV/tV9MNWId6tJu6y
	KhS4Q6Ug==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wytFJ-000Dzy-27;
	Tue, 25 Aug 2026 17:39:29 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wytFI-000NIE-2t;
	Tue, 25 Aug 2026 17:39:28 +0200
Message-ID: <46035122-87f6-449f-aa71-a8e9e99dc006@iogearbox.net>
Date: Tue, 25 Aug 2026 17:39:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] xsk: Fix circular locking dependency in xsk_bind
To: Khawar Ahemad <ahemadkhawar123@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, ast@kernel.org,
 kuba@kernel.org, pabeni@redhat.com,
 syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
References: <20260825152152.86092-1-ahemadkhawar123@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260825152152.86092-1-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28103/Tue Aug 25 08:27:08 2026)

On 8/25/26 5:21 PM, Khawar Ahemad wrote:
> syzbot reported a circular locking dependency involving &net->xdp.lock,
> &xs->mutex, and netdev_lock_ops():
> 
> -> #3 (&net->xdp.lock):
>         xsk_notifier
>         unregister_netdevice_many_notify
>         rtnl_dellink
> 
> -> #2 (&port->pnodes_lock / netdev_lock):
>         ipvlan_device_event / bond / netdev_change_features
> 
> -> #1 (netdev_lock_ops):
>         xsk_bind (holds xs->mutex, takes netdev_lock_ops(dev))
> 
> -> #0 (&xs->mutex):
>         xsk_diag_dump (holds net->xdp.lock, takes xs->mutex)
> 
> In xsk_bind(), xs->mutex was acquired before dev_get_by_index() and
> netdev_lock_ops(dev). However, in netdev notifier callbacks like
> xsk_notifier(), netdev_lock_ops(dev) is held by the netdev core while
> taking net->xdp.lock and then xs->mutex, creating an ABBA lock
> inversion between xs->mutex and netdev_lock_ops(dev).
> 
> Fix this by looking up the target net_device and acquiring
> netdev_lock_ops(dev) before acquiring xs->mutex in xsk_bind(). This
> aligns xsk_bind() with the global lock hierarchy:
> rtnl_lock -> netdev_lock_ops(dev) -> net->xdp.lock -> xs->mutex.
> 
> Fixes: 978939c08db1 ("xsk: use netdev_lock_ops in xsk_bind")
> Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=aa48b5fe7bfda62d1682
> Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>

This creates a deadlock with the change in the following:

  - xsk_bind() takes dev->lock -> xs->mutex
  - xsk_notifier() -> xp_clear_dev() takes xs->mutex -> dev->lock

... also Fixes tag does not exist.
