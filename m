Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C674E77E4
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415084; cv=none; b=XpMqNPde3OZC1Ul5CRsLVvwAe2NFtsMXjcjYFB0v3jqnxqwB9bsjnZTotb+XXs0xy336OMUiC4w5AxMeUHLG/X2VixDXdi3GvF9ejn4Of2BjCAhOM+I6z85Yxxaywkap7taR05r9dCOyuqG14wqzR4ye4gtlPUhoeVW3o5HfeZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415084; c=relaxed/simple;
	bh=ypi3osWI8gP8xyKWXAity7kWnhHwA/VpXlB9i/wvPi4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=aIJOaKigecOP6LG5RGTS3znp6Ei79sHuKb4f0R8mHL+6Rnso2251g9hNXLW7rc+rCYKyh01HpnHCyOLd61sQcJU9aVOzOHI/jq1H7j9+aljB2We4YDvf9QuQd+F0f9tlf1oxdd1gpcjPSRy13W1nUzuj3ZUG12WTYKPlMRERfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw2Ro5NT; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw2Ro5NT"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91b834592afso23418186d6.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792415080; x=1793019880; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ypi3osWI8gP8xyKWXAity7kWnhHwA/VpXlB9i/wvPi4=;
        b=Zw2Ro5NTFeqeRpPaUDiAoqDBBEVA4vrR/egIYDXbODNDfzxRKXaLD1RJK11z0W2Nfo
         v4ChuE6+1Sfi4K+VMqUl/ZYJB0btqAXli5pJHKqFcJ5+/uVwztEMPyj+J7yGeSc02FBk
         C6CLlRLhQJl0jM8HTwn917o5vL1wfF9ZSDi+dhXi+InmnwfjUMcBIiA70sapE8VxKTcE
         fF9GSx6VUK6IsUY0dHiKY4mYq2w+na9GwH3Hpjy1mWZGcO69wec5JKb27RNOnTs3sqsM
         01rhQF+lRKg5rrHh7r063fn0ukbU+Iv3/sufzKGp/PEF1gaM6y90GfQ/oOuPO+W+XT/y
         jCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792415080; x=1793019880;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ypi3osWI8gP8xyKWXAity7kWnhHwA/VpXlB9i/wvPi4=;
        b=Ucpsa/CyT93SZgHA41i61GAsETjkLjQJaR8aCzbZriP86UuxocCbwBHyHsw8SzbW9r
         iP1TWh4Txlvb6fMb5LuBPwiGghDY7yOAHBnTDSnbCqeW+O1SoNvC1ogI2PpldNpd24WE
         uqhoJW6iE2HHqXjQRGhSxqCcogC1FsIRGkVYHWGiICGv6JpP/szr3Qu+oEhZ97axQzz6
         HidwjHQWjCO7rkZtsdwxPY9vp6DCtAEekJA91K5lhH3hsPMAxaBd9pwHf28yErxgeiO4
         4N5o+GH8xRoVTmjkQ9H8Y0SGwD+Ec80E3NRbAszc3sCV/s96JSL6LPtHht16kmXc2GI+
         BO8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxCSTvR4Em5LRdmrNHV1k3xvC6hPZQGKPcrRPkOQOIpd3wExw/SlphKhIwr7bUQ2NeujA4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKINf0gsplHUrQFkDLz+FJTCoOgbE8bCn50Y1m0dWVUjksgYlNA
	sITivH/7MFRS5wUdbKpaP5MKConfymxJa0EaCJ8RE7m3cTIw8bO33jlV
X-Gm-Gg: AYBFou37/gXJE8ZSqZJ+6ub8zn6TQxIVuGlP6gl0CbaXKjEtrMU6gPXRwY+foM9b2Gk
	PzDxxC/HyAWMYb6B9X+o/U8qVPlpIBS7mLl8IpHJsYZ4lQPE3twtRlnnGlh35BYiU24/5xGtwIc
	LCvL9SoiTTV6AAVUakXxUCpvTonwH1+pa29s0gIrMdMxwUqQDVqvtweHcq5JoxwQ/fCMuZDO7RB
	gALLTo5i3d48yyIdS3RTsGAR5+4Ittr3X/wW8ADKR6JmDj5QiOib12axMRAGODxqYCSw48SlQ8f
	7RvCQ7GubQj0nA9aKjI6zdg/b0ZhOAOFtM3w3U7pILKHeKSA1IsXg8nMuNbMkjgfbswtAkOb7hr
	zKzvSSJr/RgnZuz3kShF5NwRYUc4AOLy5M4lifjleA6sNvlGETvptdH2pysvGq+TqwUTOlRAs2p
	zSXUa98BtZVAuRot7ijnXaW1vmaMhrkG56UiggQfIfsf7kKKiPyezoOUXgd+zspJSqn9ItIgw8O
	co=
X-Received: by 2002:a05:620a:7119:b0:93e:fc4e:c490 with SMTP id af79cd13be357-93f29cf1c9bmr1378673385a.15.1792415079619;
        Mon, 19 Oct 2026 06:04:39 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f3cb855a0sm328418385a.4.2026.10.19.06.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 06:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 09:04:38 -0400
Message-Id: <DM8U47F4MNK3.2V54CCQ9YTNBY@gmail.com>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Daniel Zahka"
 <daniel.zahka@gmail.com>
Cc: "Alexander Duyck" <alexanderduyck@fb.com>, "Jakub Kicinski"
 <kuba@kernel.org>, <kernel-team@meta.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Paolo
 Abeni" <pabeni@redhat.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Eric Dumazet" <edumazet@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
From: "Daniel Zahka" <daniel.zahka@gmail.com>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
 <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
 <20261016220930.i32JEcqe@linutronix.de>
In-Reply-To: <20261016220930.i32JEcqe@linutronix.de>

On Fri Oct 16, 2026 at 6:09 PM EDT, Sebastian Andrzej Siewior wrote:
> On 2026-10-12 05:04:34 [-0700], Daniel Zahka wrote:
>> Keep packet, byte and drop counters on each Tx work, Tx completion, and
>> Rx completion queue. Report them to the core via the rtnl_link_stats64
>> interface.
>>=20
>> Rx completion queues also count errors. Frames the device marked with an
>> uncorrectable error are counted as errors, and frames that fail for any
>> other reason are counted as drops.
>>=20
>> All packets cleaned from the TWQ during mpnic_flush() are counted as
>> drops, though completions for some of them may have been DMA'd into
>> the completion ring between the time mpnic_poll() last ran and before
>> mpnic_wait_all_queues_idle() returns. This is done for code simplicity.
>>=20
>> An RCU approach is used because ndo_get_stats64 is not called with the
>> instance lock.
>
> Why do you have the two mpnic_base_stats and fold the stats into into
> it? My guess would be that on stop the counters are reset and you want
> to preserve the stats.
>

Not sure I understand. I think you are asking about two things:

1. Why have two mpnic_base_stats?

To avoid a separate heap allocation that can fail. Handling an
allocation failure in the ndo_stop path when doing the aggregation into
the base stats is tricky.

2. Why split stats into base stats and per queue stats, and why reset
the per queue counts when the device transitions down?

This is the way the stats in netdev.yaml are exposed depending on the
'scope' request attribute. My reading of the relevant kernel docs is
that the per queue counters are counting events for the current live
queue, so it makes sense to reset them and fold those counts into the
base stats when the interface is transitioned down.

>> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
>
> Sebastian

