Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443001;
	b=F2GbKx9gJhyJCgwzT2ZDgD+fR/IAUX4/rM9OxkOOeHdhUbFLZy21qNirqbj4aURV2gSy
	 q1XCnqwup8ckc+Oo20u4Tcli6L0YfQxpEjEpK9UHV4d0hifDiZJfcAyXezG3HiGTBAQ5I
	 +vj4wKqSdzLZc7E1MoxvJ8pbJZr09Cv4ab2pORZOAKxcNqOZ0IGSmUCfveOPw8laDbn5y
	 3J5Gzuz0Eh2TplvIHF+SU+UPr31R3++BDAkqPfSKd8kovkwL9tBjjepJYPU/vH9eb8ebd
	 xN0u1CDwphI6GzPzEI6oAsnT8xblQw5kcfD41RjOMlxLifC85bB+Cc5RbXFD0PFS/1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QgZcTbM3Kqv6H+uxjoWsyk/LUvsEFgztRPahYNF7SRI=;
	b=d573GA8dHu21QzJmqmYjr1UEpR4GlyLiEEzqpV8GY5h71k+p6JlbwqAhr19UucDAlKzl
	 KQKEM2hm38QBhK7RbyAsfzK/pHhsC81dblcko+q7hEVcx78PaL+sA7lr+a9YooamiRs3j
	 I5UgyBnQXvxIf/3o4e4svnFHsNaIE+8W/6AwOlxaC4FPjgXLt75RiF77ImddUgrE/5AvF
	 II4bnE1sSSa3LgmJWjws1aQc4NVtoSt1VUFhh4NmOlqsHDdkoSN0mHfMUSN7VpQa9MN5L
	 eOipDzjnu+rN9sfjVWBwThW6nRQiUr1hfthxgL1sQ6Dklj0pFXYdiXqj2dzzI9bDksQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Paa77cZC;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49113606A692
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 14:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49113606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Paa77cZC
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b86bbce3d1so4354721a12.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 06:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795443000; x=1796047800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QgZcTbM3Kqv6H+uxjoWsyk/LUvsEFgztRPahYNF7SRI=;
        b=Paa77cZChyyChxxqH0++ZoHrNdr+ZwfEV5r3GB0JbKAt390gQbZVBTLUQK/SdI9upz
         xGXlAKnQc/LOSJ125nn0daxggCAOvLBF68qypSE/tHYltYiQq8Ftq7d7gBBmmiTAM3A9
         iSdT2mbU+8CzXHhDDd6dqQc3SRWZNKOyny4bRIuFL7Gbac1DRYadRvefq4UjuhQ6IJOc
         NYBjw8WW4q549KfSprr7Q2nsQsODiY+WQPIb9Zc7n5aYf5+nZPXZifAFkI7OPkOSaeot
         m9b6+PCrJwa55p6340Xphnr9GVkalxKvS5OaP2qnFVst3wc999+6WwFX15JlNcWfWtKh
         5Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443000; x=1796047800;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QgZcTbM3Kqv6H+uxjoWsyk/LUvsEFgztRPahYNF7SRI=;
        b=OF95s2uT0DZuQuxiEnZ0j/Lb19NwtLca4ksuMziEv+IqZAf7gMEQHUB1fvyhtMXWHQ
         T8GQDFq6kfQVkOweBeNIgyV456t7cTtsxMZxxOolFHfKS3RPQvS2wVUXbUNszu106flw
         7Z5yO4vJG+FWB+9BFNQzWt6TpPRQcg26fyOokP5kMzsYbZsLV3WYAvIVDsfHfAHiOZiq
         bHtGHg9y23+iX/jyZ6HfEvEbz+BhsZiS5iLvz/yTmc/oOI9WUa/qLDrF3/Tb2LchUKRx
         adCtqG7ECq5jacn5DbLjkTnIWfHFwgqEYX3QCddJo6JcJjhBkdowbPjlf2g7vVON+iYV
         n0Pg==
X-Forwarded-Encrypted: i=1; AL+hErEhX4mAma2STfVlYZurkcAG/h61RzLFtp1AfJXBPC24zvobbGAynM+HsqW9nh9qJ8saF0Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KAmqpeVFAsGLg2mpUSJu2nLPZ8i3/Tn89Xjc11QFBI7GiIi7+
	po9l7QcAM7jFal7e7b4goakubw/RoakZAQ/sD16IbT9v35hU8+YU7Hq2IU7DxOjNwU0=
X-Gm-Gg: AZFdTZerkDVzQ2GJ7z7B5NNSTr9kt8e3iD92xOuN2sNojaiaLKde82ioUCFLJ6TyQsq
	QCU2tYUFPQI+0a1ESAph+tei26Q1S7ou/T/AjvUmiucndjE4SffEORa8FrxzuX/tUrHVFyeToDW
	7D9jQc1nwCwqIFz3UbHVBIMCL+Yx2oi42I8F7fAwXgeiN+PJdN8UdV44SimejE8XIJiM1YbQrdb
	rUd23pTUDWRM7spXpYBx0IFBtnHge8lzixXQDGwJ3808BaY+MkWWpTLb8R7ec9iqyJ0LQymyj11
	DVq2vvFA1KvOk6RgAuVzZJbfqOgyjZhwKhX035Eezu1/KCO9AeWZk8+eeOwA87ckn4+ypDYypM/
	4ZUZIcUzCvOlOxuicAc98HdAkC8FIOAxdBwKHuAALATSRFFdBoSv9kcvo+0Ew472S5MROu+odws
	aYOo0MuAHxrt2iTLEkz+rq9Fv3jy7SlZYVShTsflEAqWNcrekklZLYhcMaCVWAnoH0OMTw/BXwI
	sZomr49hJjev71JAYrBG0P1lpw/tYTPNrlAOp/bTrPnQT5SDCeRR7psTMTQEN1qi1lyzUYSOcsB
	jKJub15Wq7Y+fwUsKPz5asugaIUC+ZQL+KaxzVptOmZXOc4=
X-Received: by 2002:a05:6402:1953:b0:6ba:ad05:3fec with SMTP id 4fb4d7f45d1cf-6baad054b87mr2592953a12.29.1795442999662;
        Mon, 23 Nov 2026 06:09:59 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fbf0esm5388027a12.23.2026.11.23.06.09.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:09:59 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: hangbin.liu@linux.dev,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev
Subject: Re: [PATCH net-next v5 3/3] selftests: net: veth: propagate bad-settings check failures to exit status
Date: Mon, 23 Nov 2026 14:09:47 +0000
Message-ID: <20261123140946.13992-2-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121182217.4609-4-emmaonana18@gmail.com>
References: <20261121182217.4609-1-emmaonana18@gmail.com> <20261121182217.4609-4-emmaonana18@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi Omokefe,

On Sat, 21 Nov 2026 19:22:17 +0100 Omokefe Emmanuel Onanaroghene wrote:
> Three more checks in veth.sh print "fail - set operation successful
> ?!?" without setting ret: "bad setting: XDP with RX nr less than TX",
> "bad setting: reducing RX nr below peer TX with XDP set", and "bad
> setting: increasing peer TX nr above RX with XDP set". A kernel that
> wrongly accepts any of these invalid operations would be reported yet
> the script would still exit 0. Wrap each fail branch so it sets ret=1.

If you squash this patch with patch 2, feel free to keep my tag on
the result.

Reviewed-by: Tianyi Gao <tianyi@cloudflare.com>

Cheers,
Tianyi
