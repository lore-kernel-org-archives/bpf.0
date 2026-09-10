Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E347143C
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039928; cv=none; b=cBNYVaFBQgboSU1B9NbMiZE5lGi8xSBDXjrNys4NeHkccoQK8EZIMcNJPdD23NTlZWFMspBj7XzlJ/uxi/mc3h9M/cZYAf+qcso4E9jV/ej5HK2XRgbiHq0YMFu5Sl6PBZGPV6O2C+XnZns8Dbm0jRuGXHCWdznB7KUJP4tReno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039928; c=relaxed/simple;
	bh=lJZi95WZB7yzdlKPvBofx8mF9bEAbVe5sXoFviCtnMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=QAheGUhPYqi2VUDA5LsMa3U4i8xKmlN1ehvVJ3lW/o7g5ATu93uFL6AcgdC6Fz+kDmWiEgs29AiqOzryeA9j6hrvTTEieLGLir54bBhB9f53ru5NzYvL7nWmbK03nMETWFRs0h7f78sro0LtxmkrhxQIVhJVTgVXOSm5hF/nFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSCSCPQ9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSCSCPQ9"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-86a46577018so518933b3a.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 04:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789039923; x=1789644723; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IPKZJQlP21ww4LrqqKoCC3eq7Co68DwS+hHs4a+8eYc=;
        b=WSCSCPQ99WEhgSMG29hwUfvzAE3NRCZmk95Rkda+PLeIQkZanHPraZ0QjEZkVPgXPS
         vOnKwJ4Q/B8B9BSmuLSqIS+ASAkKLS4gTOH8hPU9RJkJEZ0SDhIU5fJnADChtiECHTSK
         +liJjWjepGcOfeYCe/BRUGnpGKCrPSuX2RYafwjSd3ZM7cAoS0psbumsut1OMxAveEvQ
         wzt0lUAfB51nUDw2UblJGPTHScLleSZIkQOux2U+XpR73R2FrFrZZuS2Z3tyE7YJ8QtY
         bPxNoWRGuKmYyxhzD44rBb39oWacp2TKBpbQow2nDSiIxfggRcsZh0MJFutUCXsSlL+4
         h0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789039923; x=1789644723;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IPKZJQlP21ww4LrqqKoCC3eq7Co68DwS+hHs4a+8eYc=;
        b=iqynl5D366YJJmubOsotfdJenvkwCa00W8Y1c576eaZz8Vm6fgpnhx3kHv/VNC3mxU
         1p89J3o4NeRtt5+Bz00CFLAbF7yu/FzM0C9YDxWgN7AMkl+SLUgaQWSh1YcYtzfahQEn
         riVrXP8pGlSoc1M4vIC4m67Q+Mg58JKZBeSzJq5a1PkVyfbPAdz2HbMKhjuqKaICPQnc
         lLylTaA0srp3+LxefZCSq8snoDvHnLGp/dC5b3SSmo1CLQL7I/C1EiuUg4WmpqMPLjGW
         Wb+o3ZYaOpEGF+ythFeK4z8fVXuy+8uFnPxG3e9cu6wOd0kj+Un3BPwdEVTCQEIu6IWS
         /18Q==
X-Forwarded-Encrypted: i=1; AKwUvBzqzHzpvteLNG+RQ66dMXQF2eOkLsQ3LahVthnHwA6H9tOq7wnfGhgnghr+QGLluLNn2iI=@vger.kernel.org
X-Gm-Message-State: AFuF++nlF8l9kj2aa+feDt7vG7gZhNM5HJn/UAZtpKxPaA9pb9HtAUfR
	N4VC1EKvodj+oLPTKz7/aUOaF3qgdH0DY5H+dBhvk8JueivGPSL7Zrbb
X-Gm-Gg: AYBFou1XHv5NBNBrv69xAA1kFOGJx9DJn5zIMo7+CBruUwt8j1V5CcVQeKQ2Run8CB+
	XEYxPN/Tr426b5azRYtJBP5nx5+XBZHu5jH027cbwUB2C0usVy7w4ZzPSjqhMcLbSghXc6gukGp
	GYPu7VhyLJ4LyDVV+cxROCnZbgowBjmYIEYKu89zIbbwWM16ZWh72YVUc2XYGZjWxiiU2T0K/14
	xHlZdd9qSjUlt1EN/L7stkouiHTrLhb9jPGCEKs2YnfrsWRdPCoWjl75nZ/vLGo+Hx9ZnlO/2/p
	MqhkjFGZKvZuKzIJlMf0WdjwJLB1QKEMjeyZJB64RrPQ0sOSloxQ2la+jzU5bDNBOyTeVCsIpw8
	Y7Ul7Th9k8NWukmHWzaUh/adV/7lWUp8hc1mgJsvBR8NOHmiQHOJ9s/q02alxiXaO9+NNO6Wk+T
	F+7BGCux/IvR/IjFgyqDd3x1gnrMSgs8noNXJ09bEZiML6uy769Atfw0aZOF9JkH9621QlenQsg
	QLTPNXLPx0sQkFCDTAOLf3F92kiVbNlLxfEiuNMvPZfjZI3q0PahhoAUqVPBY4hZefRz7/tNH8c
	+WP9/N/S40qmsHZlQbQ2LhI9Jy4JcBK/EM+xBxIpFm3KcakGp/rZT27Gh8vykxLSPvTlTcygUHr
	5L7q54QRNsSf4j3/A+uxD
X-Received: by 2002:a05:6a00:13a0:b0:86a:59ca:6cb6 with SMTP id d2e1a72fcca58-86a59ca7130mr2870537b3a.20.1789039922659;
        Thu, 10 Sep 2026 04:32:02 -0700 (PDT)
Received: from [127.0.1.1] ([43.227.225.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-869a5b727f6sm818032b3a.28.2026.09.10.04.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:32:02 -0700 (PDT)
From: Nikhil Ludder <nikhilljatt@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Emil Tsalapatis <linux-lists@etsalapatis.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, horms@kernel.org, dsahern@gmail.com, hawk@kernel.org,
 razor@blackwall.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: fix reading neigh ha in bpf_fib_lookup()
In-Reply-To: <7f3e237e-ac5c-46af-ae21-8b437a099fe3@linux.dev>
References: <20260909024011.1252694-1-nikhilljatt@gmail.com>
 <CABFh=a7Z=heZODVsXwisY3VwULDy-Rq1hwO09exgX2d0-KzgUQ@mail.gmail.com>
 <178898653497.1776876.10402414041023036972@gmail.com>
 <7f3e237e-ac5c-46af-ae21-8b437a099fe3@linux.dev>
Date: Thu, 10 Sep 2026 17:01:52 +0530
Message-ID: <178903991209.1916825.3991149870565892141@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 9/10/26 12:59 PM, Jiayuan Chen wrote:
> Yes, no deadlock.

Thanks for confirming.

> BTW, if an IPoIB device can show up here, dmac is already truncated
> today and the packet can't be forwarded anyway.
> Shouldn't we just reject addr_len != ETH_ALEN instead of open-coding
> the copy? Then you can use the native function instead.

You are right, and it is worse than just dmac: the line immediately
below copies dev->dev_addr into params->smac with a fixed ETH_ALEN and
no addr_len check either, so both addresses are already truncated for
such a device.  struct bpf_fib_lookup declares smac[6] and dmac[6], so
the helper is ethernet-only by contract and a non-ethernet nexthop is
already outside it.

I would rather not fold that into this patch though.  This one is a
race fix with Cc: stable and no behaviour change, whereas rejecting a
device that today returns a (garbage) success is uapi visible and does
not belong in a stable backport.  Would you be happy with the seqlock
fix as it stands, and a follow-up for bpf-next that rejects
addr_len != ETH_ALEN and covers smac as well?  I am happy to write it.

If so, which return code would you want for that?  None of the existing
BPF_FIB_LKUP_RET_* really fits: NO_NEIGH is untrue since the neighbour
is there, NOT_FWDED is vague, and adding a new BPF_FIB_LKUP_RET_* is
uapi, which is another reason to keep it out of this patch.

Thanks,
Nikhil
