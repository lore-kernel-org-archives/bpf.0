Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E4538947F
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935892; cv=pass; b=nNPBs4U5LOFehDt//T0Pn8QnFh/bjGuSJAhREx9c4fXHBiTi4jmljaoyDGlzfPBLVuMjHbMjRwjZJ85rwwlJEp6Ozw16p6fuCJ8hAUW1YVYJXmEOFBGsOEWwthu2uxnrLcYaxOmTIEwCAFCc8ePpN12wQ0ef0rQy3yIffQ0dszQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935892; c=relaxed/simple;
	bh=9bt4yB4wrN8kHYOfxeXhMbkcmKTisipIJsXnXK0ZxD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ex2x6zsH7RehJizexzZ17+rNI8GfJrDaRRNRCNDjiniJvGzn9omPaaNHaQ2hLRU75w7iqBjL2dB8eSwYz0vVS1gAce4sCoryqndAZivoE/sZ6cyIPVssArq0hnwbs5ak7JTqYQQdy49fo7u6CyfI3gE5BbOvAy/cdnTIV9iKvys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S03MfrYd; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S03MfrYd"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5218927884fso13979371cf.3
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 09:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787935887; cv=none;
        d=google.com; s=arc-20260327;
        b=Z1rpfgXRRgkoDtdA4Y08kcb0sxyPdcBmxb5vCW236b4WITSC+pkx8Bg8ch7uT+cIml
         lgVjtnGCIrSUqRNHXVH31OaYBQewfYCuD3hoNYc/MjLQbCmQwoPbBfAMd9Rr1X0Qe7GU
         rcGPD1dq8RIxPntXTutvxrJJMOmYtDUMtxgQWf1je58q0cWOxAXa3D1DcopjAme8Vwwk
         ird+XqVjW2aZkBCRMhgCLcd/cy9WsZ9J/5lCWHa5/d3B71Se0fzt6aFz3tp9c9tZv7N8
         vZPqzV8IRgfLKVcJM58ZVypDBtLS6vGp+PwYQyv+QhiWYheikiqfVR+bZ46KKTO1elxl
         vPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mMlaPah34klg2SfIGU5Q2NKW+XSAghjYJ83EboJBxEQ=;
        fh=rrOFYEIb72Ca/t6eVl3OwpyU5WtBp4rR1T8pwdPCzeI=;
        b=BBR4RvOiCjEIXPhzLN99xLI4k0S2slMVhj2+ggZb+kVd4dmi+QXLicKBqPvOiCnrdm
         Z1aG9e+yfO2DVmLHrhFO/efbvgQtulJhY3tjJPWyTDFc/bf29uTgqTd1Vhp3McH/9ZD4
         827K4igBOHGeBDrp7IcmiMgsU/k1jk+yIvqCshtL4FI/kptqVgK6YVamWXJU39mg4Fyj
         dEqZVTNlbIebjQvTBFKqtTVWA9YTYFv5g2QkfpyNWCbRfXIq4X6j/9dn0pBQHUfPMwUp
         1N/5z+XiaYkn+2kJe/TT3iCWvC0bAMFDSq/JvQ8h1KZtEyTrgNHQLGZIPbrO3d8hAWPi
         XWAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787935887; x=1788540687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mMlaPah34klg2SfIGU5Q2NKW+XSAghjYJ83EboJBxEQ=;
        b=S03MfrYdTW5Rx3/WhElnx7QQSdMr+5rJQDaq3lBdKyDnImCmv3yJf7n9u5zXH0QkBz
         ZBR+yhImIBK/ChSOg5AirlOjVmhzVHKDV5eJtRRUUd8bbLUMz9MrNgYHglvSICjoI+lb
         QdgEtIeN4Bp7xv5FZkys+nF+Ahz1bcxvG0yZGtwh+pApyECjKa/HoxE8fksGmw56oCeG
         Yy09Uo20M4OeTlcqkJrZZygsgFY5hk63rIeIW7daMlRZWGN8hc+x5hA3WI0DqFtF7793
         x9AYNvCqLDa37MfAs3i5LqP2TH5vGbyjhjdgI/gA5r+B89WmZhfid+VcDOTC6YfGAwLS
         efIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787935887; x=1788540687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mMlaPah34klg2SfIGU5Q2NKW+XSAghjYJ83EboJBxEQ=;
        b=Q8skS4e0dZ84Qx8RENNnkfOgp104g/jyRIHjaD2BWeBibOpJamoSWMMHNACSfdvTzk
         QxQ4lG8s0RxYeTlvRVFESh+LGTXv6gXIJGcXw2f3X/oxpBXeARoekihl8CmhaVlyAcw7
         XGuWctQyIB0AnQg+RpwYF1Si9XhRRzUqj7gW2JxdMj5fAQmYRnEoVRa8dvM/ywnexL8M
         g1wUEMq4dJGDhqJsaM++M24JV15NP/uUegy/V5XiwmLFijhZmmWDjvbAxi7KxFPw/ktv
         4SyKwMATc/Dk6M9ADY5sRpfbwMhoviCXw/JgcatY2nE4zpFVL4p8msqWkfdLalbyt7+n
         gt5Q==
X-Forwarded-Encrypted: i=1; AHgh+RrMiPWgaEe3nC42fyLbd6qET1H0ElsgEwKwPqO+MSNFqhD5IiZ6eG15SM0sDZQUvIv8i24=@vger.kernel.org
X-Gm-Message-State: AFuF++kRNJssvXqqLDNiwNF+vfsz+i28tcKdB/3BGgLuMqtR3iwIsCzy
	So+xo40xjuCgY7EjZi8qvY4qtq9HbMwufBykk6m5Hwyaw0yeGXRBV0ehnn0ycT9wyTnZnRWR2QO
	NhW91pJQpS1at+IzhnbQlfj7s04KHWEizv+r+hLMF
X-Gm-Gg: AR+sD11cEhDOmPrTHul8Ev7Lyh4KHpVX7/P2Q/36y0HPMPS4N9U4QeiaRrvu5rGf63s
	MAZpPANY5KEBnv8djik61j0ZPcVW0kEPnsWTF/RqG3hokKmkT/I5wBpJTOdW+5QVC3+VNyB+jYt
	nl3Uoz8ugpDWBASPt0KNKcI2yOxHUDnZRJi4yPbrfxOOz/3SGG0qwllI80dhHO5xyJwo9bow2Id
	3zLVO2Ogi3RF6O5z8W8SD3RSDMU5Mw1rK+xA7wqQhmi5Xlc9GbAqLS16H6ejaRaiRc/HNpHCXji
	yo//niGNLGxme6QNXD5MqDe8BQIHO+VTvYwHQ9MeOZd3TCDx3CKp6BGhiRq3V2HnkeA72llo6A7
	ECAcgwUa7F/gZeO5UrbKFKOr9Sj4mW4JoTMm8z4ZSuK4o1UmnDseec7jYrRI=
X-Received: by 2002:a05:622a:c0e:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-52fb93cf74dmr100711571cf.1.1787935886865; Fri, 28 Aug 2026
 09:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828164918.451364-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260828164918.451364-1-maciej.fijalkowski@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 18:51:15 +0200
X-Gm-Features: AcwNN1U6wjvnrTjChRJ42-n0h-q835Ksy05AvEQrrkJT1qt_7aTQ3cY8JbZm830
Message-ID: <CANn89iKJRSsYNzirnzUwLSwGOoyn8ujKyBWRh4BBeZHHPFaM3w@mail.gmail.com>
Subject: Re: [PATCH v2 net] ipvlan: unregister upper devices outside pnodes_lock
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, 
	magnus.karlsson@intel.com, sdf@fomichev.me, bpf@vger.kernel.org, 
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 6:49=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> syzbot reported the following circular locking dependency:
>
>   xs->mutex -> netdev lock -> pnodes_lock -> net->xdp.lock -> xs->mutex
>
> The pnodes_lock -> net->xdp.lock edge is recorded when
> ipvlan_device_event(NETDEV_UNREGISTER) calls unregister_netdevice_many()
> while holding pnodes_lock.  A nested NETDEV_UNREGISTER notification for
> an IPvlan device enters xsk_notifier(), which acquires net->xdp.lock.
>
> Keep pnodes_lock only while marking the upper devices as dying, removing
> them from port->ipvlans, and queueing them for unregistration.  Once the
> devices have been detached from the protected list, release pnodes_lock
> before unregister_netdevice_many() invokes notifier callbacks.
>
> The port remains alive across unregistration because
> ipvlan_device_event() holds the reference acquired by ipvlan_port_get().
> The dying flag prevents a concurrent ->dellink() callback from deleting a
> queued device again.
>
> Fixes: 35add1093e2f ("ipvlan: Protect ipvl_port.ipvlans with mutex.")
> Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Daa48b5fe7bfda62d1682
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
