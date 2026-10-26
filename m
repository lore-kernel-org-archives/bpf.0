Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009867;
	b=11dORDg2EF0iKGr8X1ytZDL3iPzjupLsAmD/wGkDSvQiyOPSYAs974bMQ1ZAOze0+tGR
	 ybRAygpbmnbYSvcuf0/fEYEWS3hBKA9SN+zEoEQwa6CG2HUmxEhs/V7VrtICksSTubBZJ
	 J6Ikyu4X/t7yA1/pD6DL5hcmFvplAbECZ6DTtKNtdEEOs9mRYfCwUluCohVYJyqQlK/1y
	 BUfZuh+WHMk3uWi0zCaPH0pAxOV7DmA1HYElIuXf+ksWuEsVR4yL+/k6vg1TKUWUTuX11
	 evPzodBu4TUj2VdvVmisdkgWTP3zyd57oDZcF22TkURYhTILND+CBzxKhpwQ/12dPqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009867;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QdTmk1Vq8xr84K8e9cM58PhZ34X5e3vHVUHu7vqDrHk=;
	b=wWZzxWXqzK3WqSmFCF4e/fN8SDNBsUou1mUuSblnsmRkblhhesBGH+QrFXOkDoI19L2u
	 zevcM4jTxu3nSUi74zy/Ss6STaFcionD6qhC57ASgQa5qtoAEgz0G4DeYQ+SVidPze5i2
	 kB5xcKsUColpSkN4DP4jItclleRKjfD1T9DqNvPdzoJeXjTUQfVywqVeOggf/LvlLB8Tq
	 gDW+HxVm8ehaKbZC8wNN13rEkh6TbgATpPs69Re91eJkB7uH9IBUs+FLUqJ4d2NmXXuJh
	 zfaSsX0gohN/Vluvm1/9+ql5KLmfuHPjty/WmAR1+u/nPg6IINyJJ3abPcAMMrO712Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DcNgpJuA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AC606A31B;
	Mon, 26 Oct 2026 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DcNgpJuA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96631F031E0;
	Mon, 26 Oct 2026 10:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793009866;
	bh=QdTmk1Vq8xr84K8e9cM58PhZ34X5e3vHVUHu7vqDrHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DcNgpJuAatbRuyVX8CSXplGTRyzTTqrGuSFRCXihxjC6taPRCzczpFUezWm6uasm7
	 nYhVqt6qgkupiAyB2aIj6mzC5cHKsSAEixMsXLPuR08871vcrmFCMg6QKS1MRdIeBG
	 7IWRRBku1stWhFHJICNuqrVpMv9rwtOKTqTZzpW+5Aqp4gskDsOrTvbdQeAHDp777e
	 B6e0ui64hqjdQhyem8La1oE8D9tdjM9/qb6Q9vO/fXGb81Qo0wb8yjnjB2rmL5purZ
	 7Qxq+jCWsoTx1xfmjdf3EwE269NlG86dtk0/rYPSKAkEpJ1MomeWjH+cBuQIB0t9Dd
	 /wCj5RDbg9FJw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, sdf@fomichev.me
Subject: Re: [ANN] AF_XDP office hours
In-Reply-To: <aqPxxX9MeGmAqGy6@boxer>
References: <aqPxxX9MeGmAqGy6@boxer>
Date: Mon, 26 Oct 2026 11:17:42 +0100
Message-ID: <8733ts7ol5.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Hi!
>
> We feel that there are efforts on various sides related to AF_XDP
> development so we thought it would be nice to have a mechanism to have
> cross-company syncs or discussions.
>
> Therefore, let us introduce AF_XDP office hours. Plan is to have a meeting
> every Wednesday 9am pacific time. Similar to what BPF did, we're gonna
> have a public spreadsheet where people can put topics for discussions:
>
> https://docs.google.com/spreadsheets/d/16GL6AbdjDyT81cJ3-qUnYvFxqO-RlhtYT=
S68bfQQDbw/
>
> At this point we are planning to meet even though agenda is empty for
> given week, this might change in a future.

Heads-up; We had to update the meeting link -- the new link is [1]. The
document above is updated as well.


Bj=C3=B6rn

[1] https://meet.google.com/ibt-mikr-ycu
