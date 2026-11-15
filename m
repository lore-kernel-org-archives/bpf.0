Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794717732;
	b=QZAfiPB/rXUuj3ITeFXYOLplO2+G87kNA6QMfRDHCX72aR1Lrka1mS0cQKKvz2N5T2yS
	 QjrsCSwCEH7+WhgiEcx3LICaCdmRjJwHpVZEPQpV54v/7egQGdCS3/MYbFvaxp7awYsmp
	 au6gF4CL7+QlmNadc6uBOoWLnyR7gJQ/Xnb08RVWibOmkafl0SkNPgidTSYfd65WcuXPT
	 /hEHHaRxgeNVsHuA1rgzJEnrfFe6ZpTjwvuIuSWv5cHqke3kVcrcrX+AVmJ/BkjRU58FR
	 3eJuJSfdfxaz0vKdK1m22rfvuPMcjFSDr5MfMavJsQUPs1XxpEk1yE/S7rCFjNo3tUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794717732;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=CH1P70Wvz2jfUjwiFE/3453DLMf/gLYICYYrZj8tuqo=;
	b=Pzj5M24vv0b0EmSy22fiiw18OhCkP5D+MgsTeDoyHdXvOrqSkfS0BadoSMZ+Yuu2UFCT
	 B7s1t26XTxOoSquQw8ekpk0kaG8z53wVQ2wDNp7khHHWf3bgWtJSLy2Skd2Ilf1+eyywc
	 7sKLBdPSqqxEVJCslsspu+Rc1adkx5caaOH2oChbKxf5obgSuGBgmjxIbLGliiu7OlTPA
	 YCPzBVnrH1p4vHquVY4vnqF8lBrb5N5L5FJ8HP9VUaOJMYFtP4/A7yQKprsUqNErk4fli
	 3S7JsxaLVECC4RmkkeI5RXDy6HEsu2yK4Ikovx7d4mxPQQbmSsZBVObuZBA6/yaZncQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RV7XcsYU;
	arc=none smtp.remote-ip=115.124.30.132
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8AA606A327;
	Sun, 15 Nov 2026 04:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B8AA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RV7XcsYU
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794717722; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=CH1P70Wvz2jfUjwiFE/3453DLMf/gLYICYYrZj8tuqo=;
	b=RV7XcsYU62820qkCOMFHe5qJKKO14sIzlh/mXA9dplIMls1dNvsYfa+0uETEJRQ7V+ill4xKIibn8xa4ej+stsOlQ8sVS/Ef/pVmRIxmVLgQtCpKoiS4mrZgEtRmM3ViEAFSayZ3DkOAUjaWciURUtw4IzGb3z8cXLqKwcUNuUA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=shijing.wuqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0XEj8Jfh_1794717709;
Received: from localhost.localdomain(mailfrom:shijing.wuqi@linux.alibaba.com fp:SMTPD_---0XEj8Jfh_1794717709 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 15 Nov 2026 12:42:01 +0800
From: Qi Wu <shijing.wuqi@linux.alibaba.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next] bpf, tcx: Skip RCU synchronization when the entry was newly created
Date: Sun, 15 Nov 2026 12:41:46 +0800
Message-ID: <20261115044146.163548-1-shijing.wuqi@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <DMV63QDBPR8M.OQPRTU7QTUUC@gmail.com>
References: <20261114124039.111360-1-shijing.wuqi@linux.alibaba.com> <DMV63QDBPR8M.OQPRTU7QTUUC@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 14 Nov 2026 19:06:55 +0000, Alexei Starovoitov wrote:
> Lets do the same in bpf_mprog. A new bundle starts with
> get_completed_synchronize_rcu(). Then there is no need for the
> 'created' check. netkit needs no special case either.

Thanks. Recording the poll state in bpf_mprog_commit() and waiting in
bpf_mprog_peer() before the peer is overwritten makes sense, and it
covers the clsact-first and netkit cases the created check misses.
I'll implement it this way, test it and send v2.

> synchronize_net() is expedited under RTNL.
> Should tcx_entry_sync() and netkit_entry_sync() use it?

For individual detach, using synchronize_net() looks reasonable.

For bulk uninstall, I will also investigate batching the updates and
waiting once, as the synchronize_rcu_expedited() documentation recommends.
There are already synchronize_net() calls around the teardown loop, but
reusing one requires checking the notifier and ndo_uninit() ordering
before concluding that the per-device waits can be removed.

I will keep v2 focused on the bpf_mprog polling change and evaluate the
teardown changes separately.

> Way too long. That's 100+ lines of commit log for a two line change.
> Keep the problem, the idea and one table of numbers.

Will do.
