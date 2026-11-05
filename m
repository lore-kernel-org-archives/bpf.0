Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896776;
	b=ef/DMjzizTH/FKNjl3VtQNdn0BQuoHzrob9kNbQ/yu2ySzqhqK8eo0HFfAFS0GNCxdAp
	 bymmOJtVmlGxI9XZOBIf56WpM/OJKHV3GrGNfwM3/I76BIcypNz3BssRNdgXdg4Pk+jYf
	 NujL9D+2tbnSbVzK6UPS6z8Sv5CEl2PHg0ka3MrelWLwTzEzKlxKNUioZbj2Iz4TmBBSb
	 JxsyM9EbYzVF50JQh96ljYn6RAbT9/8cFWeJKfGFF3iLfIwITwrtEo5WfkfG9EmVWLsdV
	 U47HWIdx9FlOXqIIN1OFmDwh0PGT3qvbe/ASBW2j1/r3rYmL1tTIveW5rFCNw0NZw5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=g7fNqjHpYaxkYpPES1WMA+c07Ra73ql25qOjXSvqWMg=;
	b=bfYklu9iDxMCdWAI/zOj2qahku6UlePQon1fqlMKlR+nLSHR4V9iouwrJ//mh+C8AMBY
	 PV6QPxTCpM6DAaPKEAmtWMFJwvDgjR7he8JALQvvNNngJ+xNuVidBtTqWDTC97IyzaMaf
	 WPWaeggZpVBJK4P40QxQ821IODn3qGwgfBD6qDRiHKa9NZZ+KDayA5g06ZIwd+sX/T4aj
	 nOtnIOwu5M3B99mIUnLDGfAgKz2tbaa8S5Z4gjhHV4At4wDCGgg4vr6rgFDHPncQsXI03
	 J+VWq3HKKPWPQQgTuPv6VSO6dNdKGbpoElgaXCLG1polOAJrnd+oGzDf9W8aExGsdbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Do+25Wfz;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE9E606D80B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 16:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BE9E606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Do+25Wfz
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so1255476a91.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 08:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793896771; x=1794501571; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g7fNqjHpYaxkYpPES1WMA+c07Ra73ql25qOjXSvqWMg=;
        b=Do+25WfzhzV45gI604/1EZvOaKh/pike1eqCQMpc8ex4jx1pAN42T46xblK9HDKHB7
         KBTnLQs3xSuJSR0+hEgKmeAUNfW7AALEE1T+rKSR8y/Wr6GUmZX+ZXbk0/jIIrWIb34e
         Yw9LpdxIJ6RYaq5C4Wj70gFPr5PfoFNw9Wj1rtSjpwyfXfGgNxmzpEWd+pGHumtKX+QO
         k215Bah+78+AZwfWVSUOu39cXJM1slYWKsGxQY1UQiXMh04MxQ3RMSH5gZw9oEmKn7eL
         2b+IzsuxrHs07AWt0ROurkw62JUn2qAQga5a3MNxjUfuy3Fj7jBTvPwu5jCADAyjs7gl
         zT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896771; x=1794501571;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g7fNqjHpYaxkYpPES1WMA+c07Ra73ql25qOjXSvqWMg=;
        b=i/lYdQvdW5qCsst1TYzRRXCKhu7dpb/DUhMZmdekcbS04Z+k6dQn4bDL6waAk53HVg
         VoqZ9tr6Ia/mBBMPQPeUOUgLwZ4aMr5tooidAUY4LyOLgrC4Ly+FEP9wX1YQPmZ6JW/g
         DIrNupGX89cmCJ9Ma2g2d6pderYJCIuhQ6cs82OydZzd4+Uf2i2+xOTah3DDUOD3GMvv
         wBSmMc91iyW3ebUx/LAfYyehsHfR8i6+wZq2w/D2z5cbvk0683V98TXzgRc5jfgwmuSy
         Rp/MDb1u8AlEa7QJ0PTdI3MMMa/NsYEWGq5NjIgQUfU7q2Nkdv98C5rZszCNGrXJdJAI
         KFrA==
X-Forwarded-Encrypted: i=1; AKwUvBxABjTM+WezEvlhZPNKr/5jnjK8p3kVwlkOtThSuEaXcuTvIeeJNtfyDZmlscMnwn8x5nQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hb0LvPpX9oVEpK8mZxiCVSo6N2oVq827s7ImDob17Et7SnDwY
	yIry0v38fqyFrojdWlJnWkYdAg+BIIv528d7Wid/EaeR63fmqdvUGCQU
X-Gm-Gg: AYBFou3qK1ArDWm2lgMOC8ijcukCMEzeHNhHRZCIOrLIOMMKFDPFLBdXdpzVnRJm+kz
	7Kbg/f0PzUjCLjGyHMQ+kogWPuSGRrsvSpOx323U1yHGJzR9vojJy44zOSnwCso81PTevFoSUiB
	bmqMzS1UHtrDZ2FUZp+RahKZZ88Jxt8vTrrSF3gL5Sm8Ps9Mxu/39bwMX/6RIeJu01PGK2vadGO
	5NclK2OWrjYWF4fe6lcuFdZE+pivHZ2jArZthNdm6cpdj7btw2o0PoXA7ym4u2pKJY+EVeS1cee
	1fuH+SIbn/FRZPagaNIVtaqOC2+/BmHbzWdja3f5LQ3ey9MMZWJDN5WHUjKzej/W7bvoKxWUELv
	ghOOHqZ5Q45N4uMVz+buaITwfdRjP0t+nD8oaql6zZNJgxXaO/m8im0Gsdp9+ixmhV6jpo4WGAj
	v8aL9mKdCT2mdGH2i2YCCHO9lqaQ0I0k+gF2saeajWwQPSdtlpt2wN5R4hbDx67JUGfKI98OVcA
	8KdG8FcIQKdh5mHoalvob0yiQSoEq4fx3u417hzjhG2wGkAP21cz3XqmZpHa/4BSAJXgS+bOUvJ
	9BjxlVut5CXLyKJp8W6zUeiiRX7s+2idOLZnhdDUUrxDiDZXd/ja0pPlz+TJ2/ZPYAQ4BUBDfs4
	I/JaPMhG6LXIf+gCKaX9c4aUyHomffBGeptY=
X-Received: by 2002:a17:90b:4b8a:b0:3a7:8350:3f7e with SMTP id 98e67ed59e1d1-3ae89771679mr16239176a91.44.1793896770403;
        Thu, 05 Nov 2026 08:39:30 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323cd47sm4574863a91.6.2026.11.05.08.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 08:39:29 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 16:39:29 +0000
Message-Id: <DMNFBZ04A7IE.1AX8WZ52K8DT8@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] bpf: Add network namespace boundary inspection kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Abhishek Khade" <abhishekkhade69@gmail.com>, <bpf@vger.kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>
In-Reply-To: <20261105121642.38019-1-abhishekkhade69@gmail.com>
References: <20261105121642.38019-1-abhishekkhade69@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 04:16 AM Abhishek Khade <abhishekkhade69@gmail.com> wrote:
> Currently, dereferencing task->nsproxy->net_ns directly via BPF CO-RE
> presents safety and architectural challenges:

No. The prog does all of it today without new kfuncs:

  inum = task->nsproxy->net_ns->ns.inum;
  is_init_net = inum == NET_NS_INIT_INO;

The verifier accepts these loads in tp_btf, fentry and lsm progs.
A load that faults reads zero. It doesn't crash.
NET_NS_INIT_INO is uapi. No need for the address of init_net.
For a socket it's sk->__sk_common.skc_net.net->ns.inum.
Networking progs also have bpf_get_netns_cookie().

> +	rcu_read_lock();
> +	nsproxy = rcu_dereference(task->nsproxy);
> +	if (nsproxy) {
> +		net = READ_ONCE(nsproxy->net_ns);
> +		if (net)
> +			inum = net->ns.inum;

This is a use-after-free when task != current.
So much for 'this is safer than CO-RE' :(

pw-bot: cr
