Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682230;
	b=U3CHAVSSL4PTGdx+GmushFc3zmgqwqWzos6gb94hDLFqa/qonhDdOFoTCC+q1cp39Kav
	 V7nRb7YVeB11AJYaqdwzxw/dWzm9AQkm+gf+ykUjgXgs4DVa3CBq/bjDENbHnAgahlXP5
	 oy/3fQwSXN0J98qrq2cWp646yk9Jpak6q9tLyk6cvjV0a0MBil+aTJi3tD5zclL/YDxbo
	 AyCpMn0/qHQNjB3clehAYVgRA7zcmHWcmlQL2pemcuDS9SeSooorkaNnkq7T7Bc3ICGs3
	 TcrAuCS0Z4H4BiMwD2tXQmpwlp8rkzLMJS4ukc01QwSG3Kxqk+rDx94xEuw5LKLMuew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=J7v9/YPEzjxZ/LGBEzvQ09s+gFXT8pS/d7xVKdjrCoE=;
	b=csLPwFSBUX7COLcdPuNbmKQnqjsxLQ60rpKvV3+AGFqe4C/GHUEO9Hm89euztLoWYKtf
	 19hmdY8eeE+cUPEn4GGdkaMXSPEdka0Vx0xOcIL9yF1RUZGo9JmU6Ppw6rzLOFsh9KCnn
	 GNmezJZCtiF3niUqCDWMWtkVK7e2WCv4pJmoLuhaB/hOEF2rcOIbDXHq2ypcvwQ6TEwRH
	 qOTSp9s9DhUS4ZZsu3GXf++4lDwfwsaGBN9kcG++NZFgR2rszZlxxW4TlhmHdUy1HkgHW
	 zYbptO0n5RDrOSfrm02J5bhw+c+N4jLYdq9MxR2j4ZhJWAR5Y4byUplOP7shMVJo42w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GLhZMEfG;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E6606A330
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 18:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D72E6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GLhZMEfG
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e977109392so11968725ad.0
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 10:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794682229; x=1795287029; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J7v9/YPEzjxZ/LGBEzvQ09s+gFXT8pS/d7xVKdjrCoE=;
        b=GLhZMEfGifRuC596AndpNsLBIA9hBtwq3Fl2rl3RpCiUBa8JAgBi68PRu+6UvL0g+9
         Xzpu5p86rL78arrOM1QXBYNA9uv/mQu8WneFiAYdgeLD3BArt1DXcWip0vvdIfwC1ddG
         0N7V1Ecf+4SbVcB6y4tQNetroGzQmR9Z6fFcA0F6Ilqp1eKHvae2lq5iaUBEk0SCv3fZ
         JsSK0yuswuP9WHl5IzYpDImD+QbhCfQvlc2i+GAF3wnXupHdatzhSaYbY7MO1Gbgv/tJ
         /1lWvvJ7uBAc0QGCLV5ij/aoOAMBqbIa9aK22/g81KNbLj5WqLzMp41HokYHr0zzbrFb
         IZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794682229; x=1795287029;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J7v9/YPEzjxZ/LGBEzvQ09s+gFXT8pS/d7xVKdjrCoE=;
        b=f9vYA8x4lVittCNk8/gtR0NzthlcVhL7O9LsdVCW4xbed7I/QsH/R4G1Umu9hMwC9v
         mfcGLQj5De1TuHE/X0q/h4Q1VLOVb7a9haSBJ84PoPqEz7OsCoqBmrxCDpXWMGtL1QPX
         DmqA7BkBbBqBXvws4VVrrUjmxU/nfGw8YaVEn/BZdbwsV5qXgH2w+yCmeWlk65u3n7tA
         u+MZ/CNznIX1vFZM68cc0pJNrJ+9AYH+AwSBZ1pn8YEo/3YOSWOvR34z2GF+5UD1w2Pu
         0gQfjS8Hu43o+fmn61UM3Ancszvj0FtDpyy9AI19JUwvixhUYVihpWydvsPFwMwBAuiq
         Ogrw==
X-Forwarded-Encrypted: i=1; AL+hErFhwfgmJF4gi/mlyiLuBoYWdIw9rWGtEn8NPEJ9AfR9txBbDAhrTH5vuxH9y3eWDItYtWM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LAkWvBu01BCdXK77J0zLGEIvpQIXbUjQ/ngP53ExrI3BW8nCb
	CKbLoLnwu0FDhXwKBIE1x7ilbIBM2+u8cprZF0xAWURSK5sJKOgBpMtF
X-Gm-Gg: AYBFou3nEPrKawrghpZrjJGCDbd5b3zBtBP/vs5ATcF/miwnCNsD0p2/YlnvJE8Nsfv
	WdAE5CXcOR/R18KJsIn/3IWlpWAYrhSXiYowCoX9h+GhzYt0Pv9SleckWq7MzFqhd+RN2i18pCl
	kA06LRWaQCBEesNBbJWcNM0YuFlFj8jtNFuUBBFGowl+VlG0DtFjlRg1BL8r8FcWsMteLOz+KbH
	u//bAiqVtNyEmniRKq8BcENcUYvldWv0f9kZ7Q9zpn46oq0vDayws6oWLhaQu7voyCFCrB2Eupy
	DU1IRXPGSk3CDvdMKTcAfv4VmhY8eco/H2ZmI/tb7dB8ytx5MelrmAOrNNcOG3oWRAVAmY5kWZH
	sPkagaDXI05zYphz84O8LM3F/OwE3a4aBCszv5ki1MY8fydvDi6W0EuwNzd7Ffjo5IxJFfQ5MF/
	haz53XD2PWrNMf4IxpUdUovqFvbnQ+F5Pf7VGwrhsFzeZe3pUj4cIiKFxnZV9FgFXploMEE1ev+
	mUZxm2B3FDq+yl6gQc6cM0zw4Wz6f4XLS3M8mDetZ0xIWsUQiQY3K7cjp78x714MWiwZenyFseL
	YpQDPfDn0Q96zTr2ktzvk+OZW2xjDmExU15Bu56Lavbxqa5961JP21V03iU7TQG/AN9/cS/3Ucf
	Oyo00slq0jW205fGksI5A+vKF0XdxWngcfw==
X-Received: by 2002:a17:902:db04:b0:2ed:2b43:483c with SMTP id d9443c01a7336-2ee0dc2a5bfmr60623615ad.38.1794682228921;
        Sat, 14 Nov 2026 10:50:28 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75c980sm22473765ad.25.2026.11.14.10.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 10:50:26 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 18:50:24 +0000
Message-Id: <DMV5R4A5D4UE.CX5X9T3GM3GL@gmail.com>
Cc: "Michal Luczaj" <mhal@rbox.co>, <virtualization@lists.linux.dev>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v6 0/2] vsock/bpf: fix recvmsg deadlock and
 zero-length, OOB, errqueue reads
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <jrmmhm.kernel@eldare.de>, "Stefano Garzarella" <sgarzare@redhat.com>,
 "Bobby Eshleman" <bobbyeshleman@meta.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>
In-Reply-To: <20261114-kbh3-1-022-fix-v2-v6-0-96b6029bbffa@eldare.de>

On Sat Nov 14, 2026 at 11:59 AM UTC, Jerome Mohm via B4 Relay wrote:
> On a vsock socket in a sockmap, a blocking recv() deadlocks with the
> virtio delivery worker and stops all vsock rx on that worker, and
> zero-length, MSG_OOB and MSG_ERRQUEUE reads spin with the lock held,
> wait, or consume stream bytes. Both come from the commit that added
> sockmap support. Patch 1 hands those reads to __vsock_recvmsg(), and
> patch 2 releases the lock around the wait and makes the wait loop.
>
> The deadlock and the MSG_ERRQUEUE case were found with the help of
> Anthropic's Claude, with Stefano adding the stream-byte part; the other
> cases come from the netdev Sashiko reviews and Alexei. The reproducers
> are available on request.
>
> Changes in v6:
> - Split into two patches, the zero-length, MSG_OOB and MSG_ERRQUEUE
>   early return first, as Stefano preferred; the deadlock fix does not
>   need it. This is the reverse of the v3 and v4 order, and 2/2 no
>   longer argues for one patch.
> - 2/2: check the transport in the wait loop before the data, so a
>   reader that wakes after a failed connect() has dropped the transport
>   no longer calls the data check, which warns (netdev Sashiko review).
>   I check the transport instead of swapping the two tests because
>   hv_sock reports the peer's FIN from its has_data() callback. The
>   WARN_ON_ONCE() at the top of vsock_bpf_recvmsg() is unchanged.
> - 2/2: reword the comment above vsock_rx_done() (Sashiko).
> - 2/2: leave Sashiko's signal-and-timeout point as is: such a reader
>   gets -EAGAIN where a native one gets -EINTR (see my v5 reply).
> - Rebase onto current net.
> - Link to v5: https://patch.msgid.link/20261109-kbh3-1-022-fix-v2-v5-1-4d=
9af04f0fad@eldare.de

thanks. lgtm.
