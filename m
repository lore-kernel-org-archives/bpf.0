Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09239299A90
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771903341; cv=none; b=bAp3wnU4y0PeZL7cfvfVO1+asVaXHh2+7DeN2tqZRWctBwFTHYNIc152WQOhqf0oHNr4MjXKwJC6fkpUhxFGmoZtLsHmQ1tq8vzhwPaG6t0+ye+wn79fONaD74CYRwz9GOOWFlQzKhFBqcRv7e12TocKJvEYPs981G89Rx/3C70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771903341; c=relaxed/simple;
	bh=keOp2UBldaBSW3ji02nyMWxZVH/B/Rce8DhgJIAy7ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIZ4uGd1M6hBrfJFvlVqWbPSWGh1fJBJm7SdXc8LMCSqdLxT0HzzgmD+cfPVPmJQ25+V9wU6mbgivVdcK6m6tEWxvMIVwXa1LyiG7umeN3F6dxip+4UR1eSg65wKaS3wo3MqBOOpOPYzpLiOjYMDga+djpNn/qTEnWPxWNWtgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=AT3ln8Bd; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="AT3ln8Bd"
Received: from ms-a2 (99.223.13.160.dy.iij4u.or.jp [160.13.223.99])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61O3Lc6f091715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 24 Feb 2026 12:21:39 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=OORvIcpt40NrPzm7C1YMEidPOm71ORHbhwbkLwDDqi8=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771903299; v=1;
        b=AT3ln8Bd03cWXIjcsuqiqWmScp9ar1ujPefGkK2FlGtMhfcuKAca4UkJ3ZE2b3/x
         eSBQlfkCE67+SRlC0V5+4PJXxuAz6JcvvRjRGhiqqDihwm/JSnVblOBkMblDLbKg
         Oh9kqLJlMWi3NArFHUx34J9So6Lu9RXd0z0Ex7DYZkcCr6GKwtZk+SfKRuN0PgtH
         mfon5YzeLl123MGYf8x/xU8xTxhjIGSemyJCEtDOmt7UEyjLX34cfrY9vTd0WxzK
         1pGuw7J4JHSwfj8DLQ5UF7rtvKPSGoUSU1MsfIsUVQwis8dRo+CJVX+aC8apuVuv
         AAQ4VRlxTzLjatfyTt0UHg==
From: Kohei Enju <kohei@enjuk.jp>
To: kohei@enjuk.jp
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
        haoluo@google.com, hawk@kernel.org, joamaki@gmail.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kohei.enju@gmail.com,
        kpsingh@kernel.org, kuba@kernel.org, martin.lau@linux.dev,
        netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
        syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com, toke@redhat.com,
        yonghong.song@linux.dev
Subject: Re: [PATCH v3 bpf] bpf: devmap: fix stack-out-of-bounds write in get_upper_ifindexes()
Date: Tue, 24 Feb 2026 03:21:38 +0000
Message-ID: <20260224032138.39888-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224031556.38398-1-kohei@enjuk.jp>
References: <20260224031556.38398-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 24 Feb 2026 03:15:37 +0000, Kohei Enju wrote:

[...]
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 2625601de76e..d8e926a2d0da 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -588,18 +588,22 @@ static inline bool is_ifindex_excluded(int *excluded, int num_excluded, int ifin
>  }
>  
>  /* Get ifindex of each upper device. 'indexes' must be able to hold at
> - * least MAX_NEST_DEV elements.
> - * Returns the number of ifindexes added.
> + * least 'max' elements.
> + * Returns the number of ifindexes added, or -EOVERFLOW if there are too 

Ugh, I missed trailing space. Will send v4 after 24 hours.

[...]
